Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DC6687D5B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBBMbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjBBMbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:31:44 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77241B743;
        Thu,  2 Feb 2023 04:31:43 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312BXrk1026924;
        Thu, 2 Feb 2023 13:31:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=6YJzdUoEmaJpiD3sI8ykN6dxx5s4ntZ/SMPNVvvRge8=;
 b=xO6/TybQwruQNbEigHNj4nLKobrBsJ2BeaB9mFORU+WY9rEmu1/zvViNQiMCyuoDSzlb
 g9ODrTk+6tUYVhS3arktq5gI60deblgK/XkkwpMsp0TYssi9OIdKux3s5Q3hyCXa8xg2
 tv5+WLNIBCRVcB/t56m5GcnrIpau15kUDeiuV6qWaOMKKkFjn2hKHyFqTYWeuvPKPsKT
 zWx0yhc+eihsDZRyTkHblRiD4Bn0qt6zTciXYkA/NJ4WfKqHK+kp+CCDGMLYpUsyxe8Z
 YGRUtXesgEn8x5tuPBcDPP9r1xPX0yIcL22sYN34jkZzBfF4YsErPGy3SEvSfDIbbSYP Xw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3nfn3dgsp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 13:31:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C36E210002A;
        Thu,  2 Feb 2023 13:31:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC3E1216EF3;
        Thu,  2 Feb 2023 13:31:30 +0100 (CET)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 2 Feb
 2023 13:31:29 +0100
Message-ID: <3cb1c9e3-4b28-d8d2-80ac-0b6448f4baf2@foss.st.com>
Date:   Thu, 2 Feb 2023 13:31:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 1/3] ARM: dts: stm32mp13: fix compatible for BSEC
Content-Language: en-US
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Etienne CARRIERE <etienne.carriere@linaro.org>,
        Fabrice GASNIER <fabrice.gasnier@foss.st.com>,
        Amelie DELAUNAY <amelie.delaunay@foss.st.com>,
        Lionel DEBIEVE <lionel.debieve@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230118172940.841094-1-patrick.delaunay@foss.st.com>
 <20230118182856.v6.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230118182856.v6.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_04,2023-02-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 18:29, Patrick Delaunay wrote:
> Use the correct compatible for stm32mp13 support.
> 
> The BSEC driver for STM32MP15x is not compatible with STM32MP13x. For
> example the proprietary's smc STM32_SMC_BSEC is not supported in
> STM32MP13x OP-TEE, it is replaced by SM32MP BSEC Pseudo Trusted
> Application in OP-TEE to access to the secured IP BSEC on STM32MP13X SoC.
> 
> The correct compatible is already used in U-Boot and in upstream is in
> progress for OP-TEE device tree.
> 
> As the SoC STM32MP13X is not yet official and it is not available
> outside STMicroelectronics, it is the good time to break the DTS
> compatibility and to correct the error done in the introduction of
> STM32MP131.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> This patch is already sent separately in:
> https://lore.kernel.org/all/20221017134437.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid/
> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=685815
> 
> I create a serie for more efficient review.
> 
> Patrick.
> 
> (no changes since v1)
> 
> Changes in v1:
> - update commit message to indicate DTS break reason.
> 
>   arch/arm/boot/dts/stm32mp131.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
> index accc3824f7e9..0b79380cc627 100644
> --- a/arch/arm/boot/dts/stm32mp131.dtsi
> +++ b/arch/arm/boot/dts/stm32mp131.dtsi
> @@ -520,7 +520,7 @@ rtc: rtc@5c004000 {
>   		};
>   
>   		bsec: efuse@5c005000 {
> -			compatible = "st,stm32mp15-bsec";
> +			compatible = "st,stm32mp13-bsec";
>   			reg = <0x5c005000 0x400>;
>   			#address-cells = <1>;
>   			#size-cells = <1>;

Applied on stm32-next.

Thanks.
Alex
