Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBA16064AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJTPeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJTPei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:34:38 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBECF2A423;
        Thu, 20 Oct 2022 08:34:30 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KERMVB021524;
        Thu, 20 Oct 2022 17:34:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=IqHKS/vCDR7EQlr9WEEoFigCoOnxdq42cEM/JJjFv8E=;
 b=XgdhoTwM8cSZiLtXHGRVFaiqo8PgGfMqCNqy8CmE9MyBoGla2uvR3tLSNksAJRBeRHCh
 F2PchDrgZb2ljEVsGAwjvIuVtMPEpASsqgUAyT1fnXW74jkPymsQD5CRbonbGq+KBKpC
 NCMNa/82N4BLH56okQUANbjKSKx1GfLDvdTRJ40QH6hAUmYHCtym/ZWeW+oA2CRQS0F4
 //WoFvpR3lCzKadk7YbhpAD84ob+zP5mLd2WsDwM974DUBigr1bT0kLzfbi5XtaXqrLF
 bABnfhMof2Ql2BEgKChJhgJrGmkB3VYDL4dM4EBp2idqfqhzL5mHxZ7pgk88rIIC/5ou Wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k7j9nc1b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 17:34:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6EF1F10002A;
        Thu, 20 Oct 2022 17:34:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6A727237D8A;
        Thu, 20 Oct 2022 17:34:08 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 17:34:08 +0200
Message-ID: <54d0a3cb-3a48-1336-ddda-4fb0e1a20df6@foss.st.com>
Date:   Thu, 20 Oct 2022 17:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: dts: stm32: add sdmmc cd-gpios for STM32MP135F-DK
Content-Language: en-US
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220921160334.3227138-1-yann.gautier@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220921160334.3227138-1-yann.gautier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_07,2022-10-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yann

On 9/21/22 18:03, Yann Gautier wrote:
> On STM32MP135F-DK, the SD card detect GPIO is GPIOH4.
> 
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp135f-dk.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
> index e6b8ffd332c7..52f86596ce12 100644
> --- a/arch/arm/boot/dts/stm32mp135f-dk.dts
> +++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
> @@ -82,7 +82,7 @@ &sdmmc1 {
>   	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_clk_pins_a>;
>   	pinctrl-1 = <&sdmmc1_b4_od_pins_a &sdmmc1_clk_pins_a>;
>   	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
> -	broken-cd;
> +	cd-gpios = <&gpioh 4 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>   	disable-wp;
>   	st,neg-edge;
>   	bus-width = <4>;

Applied on stm32-next.

Thanks.
Alex
