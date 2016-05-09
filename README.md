# TrueSight Pulse Memcached Plugin

Collects metrics from a memcached instance. See video [walkthrough](https://help.boundary.com/hc/articles/201816101).

### Prerequisites

#### Supported OS

|     OS    | Linux | Windows | SmartOS | OS X |
|:----------|:-----:|:-------:|:-------:|:----:|
| Supported |   v   |    v    |    -    |  v   |

#### Boundary Meter versions v4.2 or later

- To install new meter go to Settings->Installation or [see instructions](https://help.boundary.com/hc/en-us/sections/200634331-Installation).
- To upgrade the meter to the latest version - [see instructions](https://help.boundary.com/hc/en-us/articles/201573102-Upgrading-the-Boundary-Meter).

#### Boundary Meter versions earlier than v4.2

|  Runtime | node.js | Python | Java |
|:---------|:-------:|:------:|:----:|
| Required |    +    |        |      |

- [How to install node.js?](https://help.boundary.com/hc/articles/202360701)

### Plugin Setup

None

### Plugin Configuration Fields

|Field Name|Description                                                |
|:---------|:----------------------------------------------------------|
|Host      |The Memcached hostname.                                    |
|Port      |The Memcached port.                                        |
|Poll Interval | How often (in milliseconds) to poll for metrics |
|Source    |The source to display in the legend for the Memcached data.|

### Metrics Collected

|Metric Name          |Description                       |
|:--------------------|:---------------------------------|
|Memcached Allocated  |Percent of available memory used  |
|Memcached Connections|Number of current connections     |
|Memcached Hits       |Number of cache hits              |
|Memcached Misses     |Number of cache misses            |
|Memcached Items      |Total number of items in cache    |
|Memcached Requests   |Number of requests                |
|Memcached Network In |Number of bytes read from network |
|Memcached Network Out|Number of bytes written to network|

### Dashboards

- Memcached

### References

None
