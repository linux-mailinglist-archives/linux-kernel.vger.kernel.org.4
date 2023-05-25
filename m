Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04D5711035
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241873AbjEYQAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241921AbjEYQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:00:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9C210B;
        Thu, 25 May 2023 09:00:09 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PF8wSH006381;
        Thu, 25 May 2023 15:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ifrrVubeMpLzEPIoHO7EEL0cWJH3ZyfUBextvsvrqiA=;
 b=AITs81PircVlme5/EjDLShQCRxY3njfHQsCYBNSKKCpLf24BvyT4KTOsGjmx6ezrH9fs
 5ohKxh06OOWaVM9u3hqZXdiivmyRsMID2MXiEYs8nSDEt/551PqTkq+rXs1gMI9hRm78
 +R/m4AGCO7S+zZgTjTo3xLiHN1gpXZddjniIGAytcFL50K6w1k1O8jQ5FO7DRuqQwg42
 xdWX+oV9vlqu90pufrLOYPPFiolNuoqvvp0el2DsNvvkgNoeWp0LUHMylkO8Q417dyIu
 JzO7etbucZdKmJc0cjkRV9w9YokKYOxQBLtjC69vE9L2Nm4w8PG/B3FK5pLGLTbQD6E3 7w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsuc220cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 15:59:42 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PFxSeT023394
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 15:59:28 GMT
Received: from [10.216.59.206] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 08:59:13 -0700
Message-ID: <18a4c59b-0dca-fceb-5a39-3abc3a5b611c@quicinc.com>
Date:   Thu, 25 May 2023 21:29:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 03/18] docs: qcom: Add qualcomm minidump guide
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <corbet@lwn.net>, <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-4-git-send-email-quic_mojha@quicinc.com>
 <2ce73561-ce8a-b288-a5ab-254e5d2070f1@infradead.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <2ce73561-ce8a-b288-a5ab-254e5d2070f1@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: s8VjoP2Ua09NGL60jicblbMN0MFRZsxi
X-Proofpoint-GUID: s8VjoP2Ua09NGL60jicblbMN0MFRZsxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250132
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/2023 12:16 AM, Randy Dunlap wrote:
> 
> 
> On 5/3/23 10:02, Mukesh Ojha wrote:
>> Add the qualcomm minidump guide for the users which
>> tries to cover the dependency and the way to test
>> and collect minidump on Qualcomm supported platforms.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   Documentation/admin-guide/qcom_minidump.rst | 246 ++++++++++++++++++++++++++++
>>   1 file changed, 246 insertions(+)
>>   create mode 100644 Documentation/admin-guide/qcom_minidump.rst
>>
>> diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/admin-guide/qcom_minidump.rst
>> new file mode 100644
>> index 0000000..062c797
>> --- /dev/null
>> +++ b/Documentation/admin-guide/qcom_minidump.rst
>> @@ -0,0 +1,246 @@
>> +Qualcomm Minidump Feature
>> +=========================
>> +
>> +Introduction
>> +------------
>> +
>> +Minidump is a best effort mechanism to collect useful and predefined
>> +data for first level of debugging on end user devices running on
>> +Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
>> +or subsystem part of SoC crashes, due to a range of hardware and
>> +software bugs. Hence, the ability to collect accurate data is only
>> +a best-effort. The data collected could be invalid or corrupted, data
>> +collection itself could fail, and so on.
>> +
>> +Qualcomm devices in engineering mode provides a mechanism for generating
>> +full system ramdumps for post mortem debugging. But in some cases it's
> 
>                 RAM dumps for {post-mortem or postmortem} debugging.
> 
> 
>> +however not feasible to capture the entire content of RAM. The minidump
>> +mechanism provides the means for selecting region should be included in
>> +the ramdump.
>> +
>> +::
>> +
>> +   +-----------------------------------------------+
>> +   |   DDR                       +-------------+   |
>> +   |                             |      SS0-ToC|   |
>> +   | +----------------+     +----------------+ |   |
>> +   | |Shared memory   |     |         SS1-ToC| |   |
>> +   | |(SMEM)          |     |                | |   |
>> +   | |                | +-->|--------+       | |   |
>> +   | |G-ToC           | |   | SS-ToC  \      | |   |
>> +   | |+-------------+ | |   | +-----------+  | |   |
>> +   | ||-------------| | |   | |-----------|  | |   |
>> +   | || SS0-ToC     | | | +-|<|SS1 region1|  | |   |
>> +   | ||-------------| | | | | |-----------|  | |   |
>> +   | || SS1-ToC     |-|>+ | | |SS1 region2|  | |   |
>> +   | ||-------------| |   | | |-----------|  | |   |
>> +   | || SS2-ToC     | |   | | |  ...      |  | |   |
>> +   | ||-------------| |   | | |-----------|  | |   |
>> +   | ||  ...        | |   |-|<|SS1 regionN|  | |   |
>> +   | ||-------------| |   | | |-----------|  | |   |
>> +   | || SSn-ToC     | |   | | +-----------+  | |   |
>> +   | |+-------------+ |   | |                | |   |
>> +   | |                |   | |----------------| |   |
>> +   | |                |   +>|  regionN       | |   |
>> +   | |                |   | |----------------| |   |
>> +   | +----------------+   | |                | |   |
>> +   |                      | |----------------| |   |
>> +   |                      +>|  region1       | |   |
>> +   |                        |----------------| |   |
>> +   |                        |                | |   |
>> +   |                        |----------------|-+   |
>> +   |                        |  region5       |     |
>> +   |                        |----------------|     |
>> +   |                        |                |     |
>> +   |  Region information    +----------------+     |
>> +   | +---------------+                             |
>> +   | |region name    |                             |
>> +   | |---------------|                             |
>> +   | |region address |                             |
>> +   | |---------------|                             |
>> +   | |region size    |                             |
>> +   | +---------------+                             |
>> +   +-----------------------------------------------+
>> +       G-ToC: Global table of content
> 
>                                   contents
> ?
> 
>> +       SS-ToC: Subsystem table of content
> 
>                                       contents
> ?
> 
>> +       SS0-SSn: Subsystem numbered from 0 to n
>> +
>> +The core of minidump feature is part of Qualcomm's boot firmware code.
>> +It initializes shared memory(SMEM), which is a part of DDR and
> 
>                           memory (SMEM),
> 
>> +allocates a small section of it to minidump table i.e also called
> 
>                                                 table, i.e.
> 
>> +global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
> 
>                     contents
> 
>> +their own table of segments to be included in the minidump, all
> 
>     its own table
> 
>> +references from a descriptor in SMEM (G-ToC). Each segment/region has
>> +some details like name, physical address and it's size etc. and it
> 
>                                                  its
> 
>> +could be anywhere scattered in the DDR.
>> +
>> +Minidump kernel driver concept
>> +------------------------------
>> +
>> +Qualcomm minidump kernel driver adds the capability to add linux region
> 
>                                                                Linux
> 
>> +to be dumped as part of ram dump collection. At the moment, shared memory
> 
>                             RAM
> 
>> +driver creates plaform device for minidump driver and give a means to
> 
>                    platform
> 
>> +APSS minidump to initialize itself on probe.
>> +
>> +This driver provides ``qcom_apss_minidump_region_register`` and
>> +``qcom_apss_minidump_region_unregister`` API's to register and unregister
>> +apss minidump region. It also gives a mechanism to update physical/virtual
> 
>     APSS
> 
>> +address for the client whose addresses keeps on changing e.g Current stack
> 
>                                                     changing, e.g., current stack
> 
>> +address of task keep on changing on context switch for each core. So these
> 
>                     keeps
> 
>> +clients can update their addresses with ``qcom_apss_minidump_update_region``
>> +API.
>> +
>> +The driver also supports registration for the clients who came before
>> +minidump driver was initialized. It maintains pending list of clients
>> +who came before minidump and once minidump is initialized it registers
>> +them in one go.
>> +
>> +To simplify post mortem debugging, driver creates and maintain an ELF
> 
> choose one:    postmortem or post-mortem
> 
>> +header as first region that gets updated each time a new region gets
>> +registered.
>> +
>> +The solution supports extracting the ramdump/minidump produced either
> 
>                                          RAM dump/minidump
> 
>> +over USB or stored to an attached storage device.
>> +
>> +Dependency of minidump kernel driver
>> +------------------------------------
>> +
>> +It is to note that whole of minidump thing depends on Qualcomm boot
> 
> s/thing //
> 
>> +firmware whether it supports minidump or not. So, if the minidump
>> +smem id is present in shared memory, it indicates that minidump
> 
>     SMEM ID
> 
>> +is supported from boot firmware and it is possible to dump linux
> 
>                                                                Linux
> 
>> +(APSS) region as part of minidump collection.
>> +
>> +How a kernel client driver can register region with minidump
>> +------------------------------------------------------------
>> +
>> +Client driver can use ``qcom_apss_minidump_region_register`` API's to
>> +register and ``qcom_apss_minidump_region_unregister`` to unregister
>> +their region from minidump driver.
>> +
>> +Client need to fill their region by filling qcom_apss_minidump_region
> 
>            needs
> 
>> +structure object which consist of the region name, region's
> 
>                            consists
> 
>> +virtual and physical address and its size.
>> +
>> +Below is one sample client driver snippet which try to allocate
> 
>                                                     tries
> 
>> +a region from kernel heap of certain size and it writes a certain
>> +known pattern (that can help in verification after collection
>> +that we got the exact pattern, what we wrote) and registers it with
>> +minidump.
>> +
>> + .. code-block:: c
>> +
>> +  #include <soc/qcom/qcom_minidump.h>
>> +  [...]
>> +
>> +
>> +  [... inside a function ...]
>> +  struct qcom_apss_minidump_region region;
>> +
>> +  [...]
>> +
>> +  client_mem_region = kzalloc(region_size, GFP_KERNEL);
>> +  if (!client_mem_region)
>> +	return -ENOMEM;
>> +
>> +  [... Just write a pattern ...]
>> +  memset(client_mem_region, 0xAB, region_size);
>> +
>> +  [... Fill up the region object ...]
>> +  strlcpy(region.name, "REGION_A", sizeof(region.name));
>> +  region.virt_addr = client_mem_region;
>> +  region.phys_addr = virt_to_phys(client_mem_region);
>> +  region.size = region_size;
>> +
>> +  ret = qcom_apss_minidump_region_register(&region);
>> +  if (ret < 0) {
>> +	pr_err("failed to add region in minidump: err: %d\n", ret);
>> +	return ret;
>> +  }
>> +
>> +  [...]
>> +
>> +
>> +Test
>> +----
>> +
>> +Existing Qualcomm devices already supports entire ddr dump (also called
> 
>                                                       DDR
> 
>> +full dump) by writing appropriate value to Qualcomm's top control and
>> +status register(tcsr) in driver/firmware/qcom_scm.c .
> 
>            register (tcsr)
> 
>> +
>> +SCM device Tree bindings required to support download mode
>> +For example (sm8450) ::
>> +
>> +	/ {
>> +
>> +	[...]
>> +
>> +		firmware {
>> +			scm: scm {
>> +				compatible = "qcom,scm-sm8450", "qcom,scm";
>> +				[... tcsr register ... ]
>> +				qcom,dload-mode = <&tcsr 0x13000>;
>> +
>> +				[...]
>> +			};
>> +		};
>> +
>> +	[...]
>> +
>> +		soc: soc@0 {
>> +
>> +			[...]
>> +
>> +			tcsr: syscon@1fc0000 {
>> +				compatible = "qcom,sm8450-tcsr", "syscon";
>> +				reg = <0x0 0x1fc0000 0x0 0x30000>;
>> +			};
>> +
>> +			[...]
>> +		};
>> +	[...]
>> +
>> +	};
>> +
>> +User of minidump can pass qcom_scm.download_mode="mini" to kernel
>> +commandline to set the current download mode to minidump.
>> +Similarly, "full" is passed to set the download mode to full dump
>> +where entire ddr dump will be collected while setting it "full,mini"
> 
>                  DDR
> 
>> +will collect minidump along with fulldump.
>> +
>> +Writing to sysfs node can also be used to set the mode to minidump.
>> +
>> +::
>> +	echo "mini" > /sys/module/qcom_scm/parameter/download_mode
>> +
>> +Once the download mode is set, any kind of crash will make the device collect
>> +respective dump as per set download mode.
>> +
>> +Dump collection
>> +---------------
>> +
>> +The solution supports extracting the minidump produced either over USB or
>> +stored to an attached storage device.
>> +
>> +By default, dumps are downloaded via USB to the attached x86_64 machine
>> +running PCAT (Qualcomm tool) software. Upon download, we will see
>> +a set of binary blobs starts with name md_* in PCAT configured directory
> 
>                           starting
> 
>> +in x86_64 machine, so for above example from the client it will be
>> +md_REGION_A.BIN. This binary blob depends on region content to determine
>> +whether it needs external parser support to get the content of the region,
>> +so for simple plain ASCII text we don't need any parsing and the content
>> +can be seen just opening the binary file.
>> +
>> +To collect the dump to attached storage type, one need to write appropriate
> 
>                                                       needs
> 
>> +value to IMEM register, in that case dumps are collected in rawdump
>> +partition on the target device itself.
>> +
>> +One need to read the entire rawdump partition and pull out content to
> 
>         needs
> 
>> +save it onto the attached x86_64 machine over USB. Later, this rawdump
>> +can be pass it to another tool dexter.exe(Qualcomm tool) which converts
> 
>            passed                  dexter.exe (Qualcomm tool)
> 
>> +this into the similar binary blobs which we have got it when download type
>> +was set to USB i.e a set of registered region as blobs and their name
> 
>                USB, i.e.                   regions
> 
> 
>> +starts with md_*.
>> +
>> +Replacing the dexter.exe with some open source tool can be added as future
>> +scope of this document.
> 


Thanks for the review, applied the change for the next version.

-- Mukesh
