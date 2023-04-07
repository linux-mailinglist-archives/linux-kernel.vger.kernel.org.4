Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0216DA991
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 09:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjDGHvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjDGHvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:51:44 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FE95B83;
        Fri,  7 Apr 2023 00:51:42 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3377codq012393;
        Fri, 7 Apr 2023 09:51:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=JZQ9ebk0VsNr3bmE9JHa8crYpwLrWBU1DloiIHkXoPc=;
 b=LATOAoa6VAv2sIlM+tG5p8SCCPc4K8iKdJp918Z0eSEhRFkDt1YH18iBa5sck1l+33rf
 cDQcHCFQF43sray9y1qxFdISoxpjSP/5yOhVMmBOFiBdytWdqCBl27HKdjs35gtPfW8n
 A5ONJu1TGJl02KSkQWCt0jUNmNEQpWKdSVhEYYnvh+JhTckINgJn08EDdd/PkrRQEjxH
 SDqA00tBDGHPh0bDgNyKq4yqmPtVw9ECW4fNq1JrlWisyeioRctkcXqf0fHxvURU+CTG
 qohwj3RtootheEg6yzbL2IVgS9yqjAsGFlN2lNGccEzIF4bl/4AdAe10DLTr12ZBcnKc xQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pteygr23x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:51:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 61B49100113;
        Fri,  7 Apr 2023 09:42:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5AB5E216EFD;
        Fri,  7 Apr 2023 09:42:23 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 7 Apr
 2023 09:42:23 +0200
Message-ID: <ae67208f-7e04-5d53-9b7d-77bf4547a790@foss.st.com>
Date:   Fri, 7 Apr 2023 09:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] ARM: stm32: add initial documentation for STM32MP151
Content-Language: en-US
To:     Roan van Dijk <roan@protonic.nl>, <corbet@lwn.net>
CC:     <mcoquelin.stm32@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230330091613.1445734-1-roan@protonic.nl>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230330091613.1445734-1-roan@protonic.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_04,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roan

On 3/30/23 11:16, Roan van Dijk wrote:
> This patch adds initial documentation of STM32MP151 microprocessor (MPU)
> based on Arm Cortex-A7.
> 
> Signed-off-by: Roan van Dijk <roan@protonic.nl>
> ---
> 



Applied on stm32-next.

Thanks.
Alex

> v2:
>   - Adds stm32mp151 to index.rst
> 
>   Documentation/arm/index.rst                   |  1 +
>   .../arm/stm32/stm32mp151-overview.rst         | 36 +++++++++++++++++++
>   2 files changed, 37 insertions(+)
>   create mode 100644 Documentation/arm/stm32/stm32mp151-overview.rst
> 
> diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
> index ae42fe886f0d..056ac11372af 100644
> --- a/Documentation/arm/index.rst
> +++ b/Documentation/arm/index.rst
> @@ -58,6 +58,7 @@ SoC-specific documents
>      stm32/stm32f769-overview
>      stm32/stm32f429-overview
>      stm32/stm32mp13-overview
> +   stm32/stm32mp151-overview
>      stm32/stm32mp157-overview
>      stm32/stm32-dma-mdma-chaining
>   
> diff --git a/Documentation/arm/stm32/stm32mp151-overview.rst b/Documentation/arm/stm32/stm32mp151-overview.rst
> new file mode 100644
> index 000000000000..f42a2ac309c0
> --- /dev/null
> +++ b/Documentation/arm/stm32/stm32mp151-overview.rst
> @@ -0,0 +1,36 @@
> +===================
> +STM32MP151 Overview
> +===================
> +
> +Introduction
> +------------
> +
> +The STM32MP151 is a Cortex-A MPU aimed at various applications.
> +It features:
> +
> +- Single Cortex-A7 application core
> +- Standard memories interface support
> +- Standard connectivity, widely inherited from the STM32 MCU family
> +- Comprehensive security support
> +
> +More details:
> +
> +- Cortex-A7 core running up to @800MHz
> +- FMC controller to connect SDRAM, NOR and NAND memories
> +- QSPI
> +- SD/MMC/SDIO support
> +- Ethernet controller
> +- ADC/DAC
> +- USB EHCI/OHCI controllers
> +- USB OTG
> +- I2C, SPI busses support
> +- Several general purpose timers
> +- Serial Audio interface
> +- LCD-TFT controller
> +- DCMIPP
> +- SPDIFRX
> +- DFSDM
> +
> +:Authors:
> +
> +- Roan van Dijk <roan@protonic.nl>

