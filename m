Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5190A66BD6A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjAPMA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjAPMAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:00:17 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F681E297;
        Mon, 16 Jan 2023 03:59:38 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30G9PXRn032650;
        Mon, 16 Jan 2023 12:59:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=0sm6mrkASO1CPfvcqdgRSa/arEB/KnUJCVFWyeJSWCw=;
 b=TB/3jVrN++gT7SOv9u9xx2b4uT10ZVRRQ+d9s72o5vc/fKOWcjFz+pAHz8UyV7UZd/gT
 JOTlubRe6YDZcA6cKWZRu0CLP8VX71t2y6CqGjiMpKB61Ov/93Q++n64pGfCciubGB61
 d2HufCyHD1sFpDBnLIFc8oCbSrNFpMTpn0IMRTYbSlyvPWY377lDOKu3VVlAl41U9JOh
 kagDBYH2yE0wbXngNyUk5cYd6trc5hUVfnd2vzRKTYHVOMolm/WVVC08vgO372nnxf8m
 2yAL3qBA/ECE5j7Yyswt682zNwVGOFqs/m89BGEU700b14mO9J0/E5ptGgA6H0eGlCHs kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3n3m5pssy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 12:59:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6FB5E10002A;
        Mon, 16 Jan 2023 12:59:27 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 67626215BF8;
        Mon, 16 Jan 2023 12:59:27 +0100 (CET)
Received: from [10.201.20.208] (10.201.20.208) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 16 Jan
 2023 12:59:26 +0100
Message-ID: <20e51ef8-15ae-e0cc-9a90-2694cbbcee7c@foss.st.com>
Date:   Mon, 16 Jan 2023 12:59:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ARM: dts: Fix User button on stm32mp135f-dk
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230111100725.463136-1-amelie.delaunay@foss.st.com>
 <98d2af06-8ef3-bb6b-1f29-4e33c1c748d6@linaro.org>
Content-Language: en-US
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <98d2af06-8ef3-bb6b-1f29-4e33c1c748d6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.208]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_09,2023-01-13_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/23 11:38, Krzysztof Kozlowski wrote:
> On 11/01/2023 11:07, Amelie Delaunay wrote:
>> This patch fixes the following dtbs_check warning on stm32mp135f-dk:
>> arch/arm/boot/dts/stm32mp135f-dk.dtb: gpio-keys: 'user-pa13' does not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$', 'pinctrl-[0-9]+'
>>  From schema: Documentation/devicetree/bindings/input/gpio-keys.yaml
>>
>> It renames user-pa13 node into button-user so that it matches gpio-keys
>> bindings.
>>
>> Fixes: 57012d79fefd ("ARM: dts: stm32: add UserPA13 button on stm32mp135f-dk")
>>
> 
> No blank lines between the tags, but I would drop the Fixes anyway. This
> is not a bug, but convention and coding style.
> 

Blank line + Fixes tag dropped in v2. Thanks

>> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
>> ---
>>   arch/arm/boot/dts/stm32mp135f-dk.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
>> index 9ff5a3eaf55b..931877d6ddb9 100644
>> --- a/arch/arm/boot/dts/stm32mp135f-dk.dts
>> +++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
>> @@ -40,7 +40,7 @@ optee@dd000000 {
>>   	gpio-keys {
>>   		compatible = "gpio-keys";
>>   
>> -		user-pa13 {
>> +		button-user {
> 
> Best regards,
> Krzysztof
> 

Regards,
Amelie
