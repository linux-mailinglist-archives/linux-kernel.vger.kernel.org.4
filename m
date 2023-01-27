Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9B67DE05
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjA0G4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjA0G4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:56:00 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51E718B;
        Thu, 26 Jan 2023 22:55:58 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R6pu80019129;
        Fri, 27 Jan 2023 06:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HGwzQi8eBbFgB7XgKrIxnk5MJfxXDdJjWi+i8hCwJS4=;
 b=TtIRBsmLph0bkbnDDaXOUZTVI4huQN50oB4uyyCVoaAtrw+2IejvXZAuzPjKgIdcoAax
 nvTfvG2ogIRoqbO5O33jEZ9ekweqECq6GYQz9+xv012kztoHQiBF/WQesRq7v3Igu6pO
 bZtjhADPx/ietH76c6Qj0nCVcglrjU+sJ7HyVBtxuvGqYn+vHemqSyoxeGh6mOGoNM4q
 Jmcc46ekI2tT3iklfNMtqtuJ7mZpOF57pt2tDt6NXNpiUu2sP1ms3WP+jY3nJLjxNMyf
 fn7MVnBuvyeXdlxI6GbGmLn05SfjpDwga8yOsw7zwyJ6Prr6kHxOQNUWYNMJIs87MZ6I 2g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nb5ynbuqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 06:55:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30R6tihC018284
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 06:55:44 GMT
Received: from [10.216.47.84] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 26 Jan
 2023 22:55:42 -0800
Message-ID: <3d99cf40-b5e2-21da-cc37-cd2e17ce10ad@quicinc.com>
Date:   Fri, 27 Jan 2023 12:25:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 02/35] Documentation: arm: correct spelling
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-2-rdunlap@infradead.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230127064005.1558-2-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fUz_eJxNtqxoY0BFYwge7aDbau9S8lhX
X-Proofpoint-GUID: fUz_eJxNtqxoY0BFYwge7aDbau9S8lhX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_02,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=890 phishscore=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1011 mlxscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270065
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the patch.

On 1/27/2023 12:09 PM, Randy Dunlap wrote:
> Correct spelling problems for Documentation/arm/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>   Documentation/arm/arm.rst                           |    2 +-
>   Documentation/arm/ixp4xx.rst                        |    4 ++--
>   Documentation/arm/keystone/knav-qmss.rst            |    2 +-
>   Documentation/arm/stm32/stm32-dma-mdma-chaining.rst |    6 +++---
>   Documentation/arm/sunxi/clocks.rst                  |    2 +-
>   Documentation/arm/swp_emulation.rst                 |    2 +-
>   Documentation/arm/tcm.rst                           |    2 +-
>   Documentation/arm/vlocks.rst                        |    2 +-
>   8 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff -- a/Documentation/arm/ixp4xx.rst b/Documentation/arm/ixp4xx.rst
> --- a/Documentation/arm/ixp4xx.rst
> +++ b/Documentation/arm/ixp4xx.rst
> @@ -78,9 +78,9 @@ IXP4xx provides two methods of accessing
>   1) A direct mapped window from 0x48000000 to 0x4bffffff (64MB).
>      To access PCI via this space, we simply ioremap() the BAR
>      into the kernel and we can use the standard read[bwl]/write[bwl]
> -   macros. This is the preffered method due to speed but it
> +   macros. This is the preferred method due to speed but it
>      limits the system to just 64MB of PCI memory. This can be
> -   problamatic if using video cards and other memory-heavy devices.
> +   problematic if using video cards and other memory-heavy devices.
>   
>   2) If > 64MB of memory space is required, the IXP4xx can be
>      configured to use indirect registers to access PCI This allows
> diff -- a/Documentation/arm/swp_emulation.rst b/Documentation/arm/swp_emulation.rst
> --- a/Documentation/arm/swp_emulation.rst
> +++ b/Documentation/arm/swp_emulation.rst
> @@ -1,7 +1,7 @@
>   Software emulation of deprecated SWP instruction (CONFIG_SWP_EMULATE)
>   ---------------------------------------------------------------------
>   
> -ARMv6 architecture deprecates use of the SWP/SWPB instructions, and recommeds
> +ARMv6 architecture deprecates use of the SWP/SWPB instructions, and recommends
>   moving to the load-locked/store-conditional instructions LDREX and STREX.
>   
>   ARMv7 multiprocessing extensions introduce the ability to disable these
> diff -- a/Documentation/arm/tcm.rst b/Documentation/arm/tcm.rst
> --- a/Documentation/arm/tcm.rst
> +++ b/Documentation/arm/tcm.rst
> @@ -71,7 +71,7 @@ in <asm/tcm.h>. Using this interface it
>   
>   - Have the remaining TCM RAM added to a special
>     allocation pool with gen_pool_create() and gen_pool_add()
> -  and provice tcm_alloc() and tcm_free() for this
> +  and provide tcm_alloc() and tcm_free() for this
>     memory. Such a heap is great for things like saving
>     device state when shutting off device power domains.
>   
> diff -- a/Documentation/arm/stm32/stm32-dma-mdma-chaining.rst b/Documentation/arm/stm32/stm32-dma-mdma-chaining.rst
> --- a/Documentation/arm/stm32/stm32-dma-mdma-chaining.rst
> +++ b/Documentation/arm/stm32/stm32-dma-mdma-chaining.rst
> @@ -359,7 +359,7 @@ Driver updates for STM32 DMA-MDMA chaini
>       descriptor you want a callback to be called at the end of the transfer
>       (dmaengine_prep_slave_sg()) or the period (dmaengine_prep_dma_cyclic()).
>       Depending on the direction, set the callback on the descriptor that finishes
> -    the overal transfer:
> +    the overall transfer:
>   
>       * DMA_DEV_TO_MEM: set the callback on the "MDMA" descriptor
>       * DMA_MEM_TO_DEV: set the callback on the "DMA" descriptor
> @@ -371,7 +371,7 @@ Driver updates for STM32 DMA-MDMA chaini
>     As STM32 MDMA channel transfer is triggered by STM32 DMA, you must issue
>     STM32 MDMA channel before STM32 DMA channel.
>   
> -  If any, your callback will be called to warn you about the end of the overal
> +  If any, your callback will be called to warn you about the end of the overall
>     transfer or the period completion.
>   
>     Don't forget to terminate both channels. STM32 DMA channel is configured in
> @@ -412,4 +412,4 @@ Resources
>   
>   :Authors:
>   
> -- Amelie Delaunay <amelie.delaunay@foss.st.com>
> \ No newline at end of file
> +- Amelie Delaunay <amelie.delaunay@foss.st.com>
> diff -- a/Documentation/arm/arm.rst b/Documentation/arm/arm.rst
> --- a/Documentation/arm/arm.rst
> +++ b/Documentation/arm/arm.rst
> @@ -141,7 +141,7 @@ ST506 hard drives
>     `*configure` harddrive set to 2). I've got an internal 20MB and a great
>     big external 5.25" FH 64MB drive (who could ever want more :-) ).
>   
> -  I've just got 240K/s off it (a dd with bs=128k); thats about half of what
> +  I've just got 240K/s off it (a dd with bs=128k); that's about half of what
>     RiscOS gets; but it's a heck of a lot better than the 50K/s I was getting
>     last week :-)
>   
> diff -- a/Documentation/arm/keystone/knav-qmss.rst b/Documentation/arm/keystone/knav-qmss.rst
> --- a/Documentation/arm/keystone/knav-qmss.rst
> +++ b/Documentation/arm/keystone/knav-qmss.rst
> @@ -39,7 +39,7 @@ CPPI/QMSS Low Level Driver document (doc
>   
>   	git://git.ti.com/keystone-rtos/qmss-lld.git
>   
> -k2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin firmware supports upto 48 accumulator
> +k2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin firmware supports up to 48 accumulator
>   channels. This firmware is available under ti-keystone folder of
>   firmware.git at
>   
> diff -- a/Documentation/arm/sunxi/clocks.rst b/Documentation/arm/sunxi/clocks.rst
> --- a/Documentation/arm/sunxi/clocks.rst
> +++ b/Documentation/arm/sunxi/clocks.rst
> @@ -5,7 +5,7 @@ Frequently asked questions about the sun
>   This document contains useful bits of information that people tend to ask
>   about the sunxi clock system, as well as accompanying ASCII art when adequate.
>   
> -Q: Why is the main 24MHz oscillator gatable? Wouldn't that break the
> +Q: Why is the main 24MHz oscillator gateable? Wouldn't that break the
>      system?
>   
>   A: The 24MHz oscillator allows gating to save power. Indeed, if gated
> diff -- a/Documentation/arm/vlocks.rst b/Documentation/arm/vlocks.rst
> --- a/Documentation/arm/vlocks.rst
> +++ b/Documentation/arm/vlocks.rst
> @@ -155,7 +155,7 @@ the basic algorithm:
>      optimisation.
>   
>      If there are too many CPUs to read the currently_voting array in
> -   one transaction then multiple transations are still required.  The
> +   one transaction then multiple transactions are still required.  The
>      implementation uses a simple loop of word-sized loads for this
>      case.  The number of transactions is still fewer than would be
>      required if bytes were loaded individually.
> 

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
