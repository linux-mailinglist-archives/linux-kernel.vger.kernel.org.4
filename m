Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D19701964
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjEMSrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjEMSrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:47:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E288F35A6;
        Sat, 13 May 2023 11:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=z5rT/sFnKVCPmGd3kdSEL73TC89E0iRmOXASAh7GYz8=; b=g3sAtfFAg2+nCMQ0q/nSLIcQVM
        gx2d6Aqu4nuwwDlHBypylm8SUhnOORCN8M4LfQcksoQrFi0r4vh0fllFljrfTPWMwkFwAu1NA1jy2
        Od63Enkq9c/maLX5A/TERlzyn7phhPEDIJ///EH3ozmkcHNZ8dS8UHy5oICKCzyOuqOMfpMFbXyy/
        qiSt+wFmqVGa9O13vJOjOmDIPSKY3bQpn4aHZth8qcrWQFUYI7kP+LG4tyd3sumA2hW5eqlw+esJo
        e4g+vuTFr+uucCErSsMfNe9SvmKI3QgHQ8YwZLBUwTSrGgWe6UnQolx/cH6r0uaCjX6bfo/JDa0c6
        o1d3WieA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxuGR-00Fbpw-0J;
        Sat, 13 May 2023 18:46:43 +0000
Message-ID: <2ce73561-ce8a-b288-a5ab-254e5d2070f1@infradead.org>
Date:   Sat, 13 May 2023 11:46:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 03/18] docs: qcom: Add qualcomm minidump guide
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-4-git-send-email-quic_mojha@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1683133352-10046-4-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/23 10:02, Mukesh Ojha wrote:
> Add the qualcomm minidump guide for the users which
> tries to cover the dependency and the way to test
> and collect minidump on Qualcomm supported platforms.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  Documentation/admin-guide/qcom_minidump.rst | 246 ++++++++++++++++++++++++++++
>  1 file changed, 246 insertions(+)
>  create mode 100644 Documentation/admin-guide/qcom_minidump.rst
> 
> diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/admin-guide/qcom_minidump.rst
> new file mode 100644
> index 0000000..062c797
> --- /dev/null
> +++ b/Documentation/admin-guide/qcom_minidump.rst
> @@ -0,0 +1,246 @@
> +Qualcomm Minidump Feature
> +=========================
> +
> +Introduction
> +------------
> +
> +Minidump is a best effort mechanism to collect useful and predefined
> +data for first level of debugging on end user devices running on
> +Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
> +or subsystem part of SoC crashes, due to a range of hardware and
> +software bugs. Hence, the ability to collect accurate data is only
> +a best-effort. The data collected could be invalid or corrupted, data
> +collection itself could fail, and so on.
> +
> +Qualcomm devices in engineering mode provides a mechanism for generating
> +full system ramdumps for post mortem debugging. But in some cases it's

               RAM dumps for {post-mortem or postmortem} debugging.


> +however not feasible to capture the entire content of RAM. The minidump
> +mechanism provides the means for selecting region should be included in
> +the ramdump.
> +
> +::
> +
> +   +-----------------------------------------------+
> +   |   DDR                       +-------------+   |
> +   |                             |      SS0-ToC|   |
> +   | +----------------+     +----------------+ |   |
> +   | |Shared memory   |     |         SS1-ToC| |   |
> +   | |(SMEM)          |     |                | |   |
> +   | |                | +-->|--------+       | |   |
> +   | |G-ToC           | |   | SS-ToC  \      | |   |
> +   | |+-------------+ | |   | +-----------+  | |   |
> +   | ||-------------| | |   | |-----------|  | |   |
> +   | || SS0-ToC     | | | +-|<|SS1 region1|  | |   |
> +   | ||-------------| | | | | |-----------|  | |   |
> +   | || SS1-ToC     |-|>+ | | |SS1 region2|  | |   |
> +   | ||-------------| |   | | |-----------|  | |   |
> +   | || SS2-ToC     | |   | | |  ...      |  | |   |
> +   | ||-------------| |   | | |-----------|  | |   |
> +   | ||  ...        | |   |-|<|SS1 regionN|  | |   |
> +   | ||-------------| |   | | |-----------|  | |   |
> +   | || SSn-ToC     | |   | | +-----------+  | |   |
> +   | |+-------------+ |   | |                | |   |
> +   | |                |   | |----------------| |   |
> +   | |                |   +>|  regionN       | |   |
> +   | |                |   | |----------------| |   |
> +   | +----------------+   | |                | |   |
> +   |                      | |----------------| |   |
> +   |                      +>|  region1       | |   |
> +   |                        |----------------| |   |
> +   |                        |                | |   |
> +   |                        |----------------|-+   |
> +   |                        |  region5       |     |
> +   |                        |----------------|     |
> +   |                        |                |     |
> +   |  Region information    +----------------+     |
> +   | +---------------+                             |
> +   | |region name    |                             |
> +   | |---------------|                             |
> +   | |region address |                             |
> +   | |---------------|                             |
> +   | |region size    |                             |
> +   | +---------------+                             |
> +   +-----------------------------------------------+
> +       G-ToC: Global table of content

                                 contents
?

> +       SS-ToC: Subsystem table of content

                                     contents
?

> +       SS0-SSn: Subsystem numbered from 0 to n
> +
> +The core of minidump feature is part of Qualcomm's boot firmware code.
> +It initializes shared memory(SMEM), which is a part of DDR and

                         memory (SMEM),

> +allocates a small section of it to minidump table i.e also called

                                               table, i.e.

> +global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has

                   contents

> +their own table of segments to be included in the minidump, all

   its own table

> +references from a descriptor in SMEM (G-ToC). Each segment/region has
> +some details like name, physical address and it's size etc. and it

                                                its

> +could be anywhere scattered in the DDR.
> +
> +Minidump kernel driver concept
> +------------------------------
> +
> +Qualcomm minidump kernel driver adds the capability to add linux region

                                                              Linux

> +to be dumped as part of ram dump collection. At the moment, shared memory

                           RAM

> +driver creates plaform device for minidump driver and give a means to

                  platform

> +APSS minidump to initialize itself on probe.
> +
> +This driver provides ``qcom_apss_minidump_region_register`` and
> +``qcom_apss_minidump_region_unregister`` API's to register and unregister
> +apss minidump region. It also gives a mechanism to update physical/virtual

   APSS

> +address for the client whose addresses keeps on changing e.g Current stack

                                                   changing, e.g., current stack

> +address of task keep on changing on context switch for each core. So these

                   keeps

> +clients can update their addresses with ``qcom_apss_minidump_update_region``
> +API.
> +
> +The driver also supports registration for the clients who came before
> +minidump driver was initialized. It maintains pending list of clients
> +who came before minidump and once minidump is initialized it registers
> +them in one go.
> +
> +To simplify post mortem debugging, driver creates and maintain an ELF

choose one:    postmortem or post-mortem

> +header as first region that gets updated each time a new region gets
> +registered.
> +
> +The solution supports extracting the ramdump/minidump produced either

                                        RAM dump/minidump

> +over USB or stored to an attached storage device.
> +
> +Dependency of minidump kernel driver
> +------------------------------------
> +
> +It is to note that whole of minidump thing depends on Qualcomm boot

s/thing //

> +firmware whether it supports minidump or not. So, if the minidump
> +smem id is present in shared memory, it indicates that minidump

   SMEM ID

> +is supported from boot firmware and it is possible to dump linux

                                                              Linux

> +(APSS) region as part of minidump collection.
> +
> +How a kernel client driver can register region with minidump
> +------------------------------------------------------------
> +
> +Client driver can use ``qcom_apss_minidump_region_register`` API's to
> +register and ``qcom_apss_minidump_region_unregister`` to unregister
> +their region from minidump driver.
> +
> +Client need to fill their region by filling qcom_apss_minidump_region

          needs

> +structure object which consist of the region name, region's

                          consists

> +virtual and physical address and its size.
> +
> +Below is one sample client driver snippet which try to allocate

                                                   tries

> +a region from kernel heap of certain size and it writes a certain
> +known pattern (that can help in verification after collection
> +that we got the exact pattern, what we wrote) and registers it with
> +minidump.
> +
> + .. code-block:: c
> +
> +  #include <soc/qcom/qcom_minidump.h>
> +  [...]
> +
> +
> +  [... inside a function ...]
> +  struct qcom_apss_minidump_region region;
> +
> +  [...]
> +
> +  client_mem_region = kzalloc(region_size, GFP_KERNEL);
> +  if (!client_mem_region)
> +	return -ENOMEM;
> +
> +  [... Just write a pattern ...]
> +  memset(client_mem_region, 0xAB, region_size);
> +
> +  [... Fill up the region object ...]
> +  strlcpy(region.name, "REGION_A", sizeof(region.name));
> +  region.virt_addr = client_mem_region;
> +  region.phys_addr = virt_to_phys(client_mem_region);
> +  region.size = region_size;
> +
> +  ret = qcom_apss_minidump_region_register(&region);
> +  if (ret < 0) {
> +	pr_err("failed to add region in minidump: err: %d\n", ret);
> +	return ret;
> +  }
> +
> +  [...]
> +
> +
> +Test
> +----
> +
> +Existing Qualcomm devices already supports entire ddr dump (also called

                                                     DDR

> +full dump) by writing appropriate value to Qualcomm's top control and
> +status register(tcsr) in driver/firmware/qcom_scm.c .

          register (tcsr)

> +
> +SCM device Tree bindings required to support download mode
> +For example (sm8450) ::
> +
> +	/ {
> +
> +	[...]
> +
> +		firmware {
> +			scm: scm {
> +				compatible = "qcom,scm-sm8450", "qcom,scm";
> +				[... tcsr register ... ]
> +				qcom,dload-mode = <&tcsr 0x13000>;
> +
> +				[...]
> +			};
> +		};
> +
> +	[...]
> +
> +		soc: soc@0 {
> +
> +			[...]
> +
> +			tcsr: syscon@1fc0000 {
> +				compatible = "qcom,sm8450-tcsr", "syscon";
> +				reg = <0x0 0x1fc0000 0x0 0x30000>;
> +			};
> +
> +			[...]
> +		};
> +	[...]
> +
> +	};
> +
> +User of minidump can pass qcom_scm.download_mode="mini" to kernel
> +commandline to set the current download mode to minidump.
> +Similarly, "full" is passed to set the download mode to full dump
> +where entire ddr dump will be collected while setting it "full,mini"

                DDR

> +will collect minidump along with fulldump.
> +
> +Writing to sysfs node can also be used to set the mode to minidump.
> +
> +::
> +	echo "mini" > /sys/module/qcom_scm/parameter/download_mode
> +
> +Once the download mode is set, any kind of crash will make the device collect
> +respective dump as per set download mode.
> +
> +Dump collection
> +---------------
> +
> +The solution supports extracting the minidump produced either over USB or
> +stored to an attached storage device.
> +
> +By default, dumps are downloaded via USB to the attached x86_64 machine
> +running PCAT (Qualcomm tool) software. Upon download, we will see
> +a set of binary blobs starts with name md_* in PCAT configured directory

                         starting

> +in x86_64 machine, so for above example from the client it will be
> +md_REGION_A.BIN. This binary blob depends on region content to determine
> +whether it needs external parser support to get the content of the region,
> +so for simple plain ASCII text we don't need any parsing and the content
> +can be seen just opening the binary file.
> +
> +To collect the dump to attached storage type, one need to write appropriate

                                                     needs

> +value to IMEM register, in that case dumps are collected in rawdump
> +partition on the target device itself.
> +
> +One need to read the entire rawdump partition and pull out content to

       needs

> +save it onto the attached x86_64 machine over USB. Later, this rawdump
> +can be pass it to another tool dexter.exe(Qualcomm tool) which converts

          passed                  dexter.exe (Qualcomm tool)

> +this into the similar binary blobs which we have got it when download type
> +was set to USB i.e a set of registered region as blobs and their name

              USB, i.e.                   regions


> +starts with md_*.
> +
> +Replacing the dexter.exe with some open source tool can be added as future
> +scope of this document.

-- 
~Randy
