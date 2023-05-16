Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2130705247
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjEPPfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjEPPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:35:17 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2025FEB;
        Tue, 16 May 2023 08:35:14 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GCFQCb014872;
        Tue, 16 May 2023 17:35:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=V8TfW2yFnFlBR+PvqUa/5jzNo/cIcHh5MaXp9eIlTJ0=;
 b=CiEp9jCFXi2uLnNtBtVkNxzsc9LPbjKVTr0lFBQTtUvt5lMIKrFSPAL/HDZTVqdq8MfD
 YD8JtbfU4ZXTmMO9Up+NXwCaWpcSBEPS+aD+7syTXvQf/MQpnCaNo5LvpHXb0bQ6CRtX
 46LYdk96aUZDAPWVuMu2gmHUTN7DZhndcg4qV2HXpbM7dG4u5FXjpcYE8JvEu0BcPHMC
 vpmSH8wLyvaZnBmwC/CIF5HsGfMOABj/kxUrbqA2/QKDECTsqGXCa0ahfxBSMD4490Py
 InCTP4UHaWFaKNfBUVn5nxOclcmlAuRrCKJ/7lR/UE31vjrry/JPQDRbKwPJCfsOK18c pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qkhp0hu5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 17:35:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C13E10002A;
        Tue, 16 May 2023 17:35:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 27D1423300B;
        Tue, 16 May 2023 17:35:02 +0200 (CEST)
Received: from [10.252.0.230] (10.252.0.230) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 16 May
 2023 17:35:01 +0200
Message-ID: <20c010da-7245-7acf-db2f-991ee2975ea2@foss.st.com>
Date:   Tue, 16 May 2023 17:35:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/4] ARM: dts: stm32: fix m4_rproc references to use
 SCMI
Content-Language: en-US
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230512093926.661509-1-arnaud.pouliquen@foss.st.com>
 <20230512093926.661509-5-arnaud.pouliquen@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230512093926.661509-5-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.0.230]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_08,2023-05-16_01,2023-02-09_01
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud

On 5/12/23 11:39, Arnaud Pouliquen wrote:
> Fixes stm32mp15*-scmi DTS files introduced in [1]:
> This patch fixes the node which uses the MCU reset and adds the
> missing HOLD_BOOT which is also handled by the SCMI reset service.
> 
> This change cannot be applied as a fix on commit [1], the management
> of the hold boot impacts also the stm32_rproc driver.
> 
> [1] 'commit 5b7e58313a77 ("ARM: dts: stm32: Add SCMI version of STM32 boards (DK1/DK2/ED1/EV1)")'
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---

I just ran YAML validation on your DT patches and it fails. I added your 
DT patches + dt-binding one (just for the test). I got the following issue:

/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dtb: m4@10000000: 
st,syscfg-holdboot: False schema does not allow [[7, 268, 1]]
	From schema: 
/local/home/frq08678/STLINUX/kernel/my-kernel/stm32/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml

Do I miss another dt-binding update not present in this series ?

alex

>   arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts | 6 ++++--
>   arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts | 6 ++++--
>   arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts | 6 ++++--
>   arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts | 6 ++++--
>   4 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts b/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
> index e539cc80bef8..134788e64265 100644
> --- a/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
> +++ b/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
> @@ -55,8 +55,10 @@ &mdma1 {
>   	resets = <&scmi_reset RST_SCMI_MDMA>;
>   };
>   
> -&mlahb {
> -	resets = <&scmi_reset RST_SCMI_MCU>;
> +&m4_rproc {
> +	resets = <&scmi_reset RST_SCMI_MCU>,
> +		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
> +	reset-names =  "mcu_rst", "hold_boot";
>   };
>   
>   &rcc {
> diff --git a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
> index 97e4f94b0a24..c42e658debfb 100644
> --- a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
> @@ -61,8 +61,10 @@ &mdma1 {
>   	resets = <&scmi_reset RST_SCMI_MDMA>;
>   };
>   
> -&mlahb {
> -	resets = <&scmi_reset RST_SCMI_MCU>;
> +&m4_rproc {
> +	resets = <&scmi_reset RST_SCMI_MCU>,
> +		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
> +	reset-names =  "mcu_rst", "hold_boot";
>   };
>   
>   &rcc {
> diff --git a/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts b/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
> index 9cf0a44d2f47..7a56ff2d4185 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
> @@ -60,8 +60,10 @@ &mdma1 {
>   	resets = <&scmi_reset RST_SCMI_MDMA>;
>   };
>   
> -&mlahb {
> -	resets = <&scmi_reset RST_SCMI_MCU>;
> +&m4_rproc {
> +	resets = <&scmi_reset RST_SCMI_MCU>,
> +		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
> +	reset-names =  "mcu_rst", "hold_boot";
>   };
>   
>   &rcc {
> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
> index 3b9dd6f4ccc9..119874dd91e4 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
> @@ -66,8 +66,10 @@ &mdma1 {
>   	resets = <&scmi_reset RST_SCMI_MDMA>;
>   };
>   
> -&mlahb {
> -	resets = <&scmi_reset RST_SCMI_MCU>;
> +&m4_rproc {
> +	resets = <&scmi_reset RST_SCMI_MCU>,
> +		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
> +	reset-names =  "mcu_rst", "hold_boot";
>   };
>   
>   &rcc {

