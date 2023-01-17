Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6666DC32
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbjAQLU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbjAQLUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:20:47 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A42BEE8;
        Tue, 17 Jan 2023 03:20:45 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H9e8It032650;
        Tue, 17 Jan 2023 12:20:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Uhl/6ZnzLSC5uEBKCTotjT83reAKyaaW0IgeDaV1PQA=;
 b=bDmYpYBBtMhMF1oA0Pakp6oHR/Dj5n7knQTUJI0gTVvLRBQJP8ZFygyNsCeakq2482rE
 hziTdVg0BC1UvZVlTGe+8Rtw1GijcTwLfv/l2x3I8OCmJLAE7KtvFUWXdiCjxspxsfFx
 7HZlCoi0Nx7a7buLNS3RVrNn/2bH0P0leVcm1tHmVP8FT4NE5KrFLcHUemaJexwAmrgW
 hPgwoT5WK31P38uO1u8gbnv8Sr7rSEwzMv4HjbzPnzCzHOh4CNn7PF0zoU6GYobS86gU
 FfFQUwyh+2TVuFPBKSYmYXXvluSWuLqAxh/GHzYYn4MZsLk+HhnUgViGRr8CcQP1h77r mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3n3m5q0dmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 12:20:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5DD0A10002A;
        Tue, 17 Jan 2023 12:20:24 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5A6DE20B222;
        Tue, 17 Jan 2023 12:20:24 +0100 (CET)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 17 Jan
 2023 12:20:23 +0100
Message-ID: <e27f3293-2d3e-af7d-187e-ec73fa15de02@foss.st.com>
Date:   Tue, 17 Jan 2023 12:20:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] ARM: dts: stm32: Fix User button on stm32mp135f-dk
Content-Language: en-US
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230116115727.1121169-1-amelie.delaunay@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230116115727.1121169-1-amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_05,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie

On 1/16/23 12:57, Amelie Delaunay wrote:
> This patch fixes the following dtbs_check warning on stm32mp135f-dk:
> arch/arm/boot/dts/stm32mp135f-dk.dtb: gpio-keys: 'user-pa13' does not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$', 'pinctrl-[0-9]+'
>  From schema: Documentation/devicetree/bindings/input/gpio-keys.yaml
> 
> It renames user-pa13 node into button-user so that it matches gpio-keys
> bindings.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp135f-dk.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
> index 9ff5a3eaf55b..931877d6ddb9 100644
> --- a/arch/arm/boot/dts/stm32mp135f-dk.dts
> +++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
> @@ -40,7 +40,7 @@ optee@dd000000 {
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   
> -		user-pa13 {
> +		button-user {
>   			label = "User-PA13";
>   			linux,code = <BTN_1>;
>   			gpios = <&gpioa 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;


Thanks for the cleaning. Applied on stm32-next.

Thanks.
Alex
