Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CF5687D4B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjBBM1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjBBM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:27:12 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5E51555C;
        Thu,  2 Feb 2023 04:27:07 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312BUPKm026936;
        Thu, 2 Feb 2023 13:26:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Mw+N7TEGy05SvmwycC0dGQdQOuDcVYkf3U7In0Q6HSY=;
 b=dUJllfI2kLaMSbNxYx4Gh+cwh71Hp+zjd0UY5aGq/Gyb+bc8UjZy96fbqm0aLXeGSp8T
 UWaFom8rtKttrd3t4ApvmVK90TxMjyL7U8fCvl3VesRva8sGHh08QdzNmWZTglcrJ+I4
 IISwNw1LcxuvWyNtq+7kvRfFOTrFh90mGzxqTU5Bxns9SuaKNG9byO8JWIthiZ5hNb3b
 A8RA/9kzHF9C2DXxKP9zrtuqZ/atDbZYvlKMzSS8yG8ick1DEs1PoFt6IME9wI+s9Lil
 9CpLXv3LTlbSM3GrkFg6QRtJlZObn/FHSQhLDIMwchQLUxhFgC3luveOGXnYSHeoeKwK bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3nfn3dgrth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 13:26:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E5A88100034;
        Thu,  2 Feb 2023 13:26:42 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A7293216EE6;
        Thu,  2 Feb 2023 13:26:42 +0100 (CET)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 2 Feb
 2023 13:26:42 +0100
Message-ID: <4b616f6c-2df3-e2c5-162e-356111d18bb9@foss.st.com>
Date:   Thu, 2 Feb 2023 13:26:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ARM: dts: stm32: Update part number NVMEM description on
 stm32mp131
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230118134948.1.Ica923e4a2407c976dcf3d65c266c27c883734dd8@changeid>
Content-Language: en-US
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230118134948.1.Ica923e4a2407c976dcf3d65c266c27c883734dd8@changeid>
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

On 1/18/23 13:49, Patrick Delaunay wrote:
> The STM32MP13x Device Part Number (also named RPN in reference manual)
> only uses the first 12 bits in OTP4, all the other bit are reserved and
> they can be different of zero; they must be masked in NVMEM result, so
> the number of bits must be defined in the nvmem cell description.
> 
> Fixes: 1da8779c0029 ("ARM: dts: stm32: add STM32MP13 SoCs support")
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>   arch/arm/boot/dts/stm32mp131.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
> index f50051e81ee3..2f186a0ae92e 100644
> --- a/arch/arm/boot/dts/stm32mp131.dtsi
> +++ b/arch/arm/boot/dts/stm32mp131.dtsi
> @@ -1233,6 +1233,7 @@ bsec: efuse@5c005000 {
>   
>   			part_number_otp: part_number_otp@4 {
>   				reg = <0x4 0x2>;
> +				bits = <0 12>;
>   			};
>   			ts_cal1: calib@5c {
>   				reg = <0x5c 0x2>;
Applied on stm32-next.

Thanks.
Alex
