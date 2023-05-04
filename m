Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEDE6F7093
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjEDRMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjEDRMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:12:40 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3841E40F6;
        Thu,  4 May 2023 10:12:09 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344GUggf015720;
        Thu, 4 May 2023 19:11:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=J4jKmf2YnViRrs4Q3HMD+7FMqDya2UEVvV21o1+C32k=;
 b=eu8mvob0gGVyS/rdi5919QIcAAabuqwY4gzwlaFUKcRxajzysruH37yoNgnJtoTs4GeL
 WZbBvvYMswWB1Ry2ZLup44dI3wH7Vp8H321PC6ps5TdrQLykJ2d39SCfHxM38afR4jQA
 SvXy2rJ+Ub4D8ThiOWH859pMd561+KpWHar/uvCIvpqlnHJfVS6l+jeIxoBf2kJwtSTz
 8RhR39RsofbTkG6brHpedpthtVeeGNKBFeIQ2zDTOt3nHJm/1pcbcZIQV5wjVY7cMHjT
 gqjCgpYKzb/RUEAlSCGL2/h72JwAbvpww3D4Zg81wbJJoF63q1lhW+BEfWX3/p6owxoa Jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qc6uwcjrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 19:11:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 90E2410002A;
        Thu,  4 May 2023 19:11:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 89497227EF3;
        Thu,  4 May 2023 19:11:42 +0200 (CEST)
Received: from [10.201.20.168] (10.201.20.168) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 4 May
 2023 19:11:41 +0200
Message-ID: <429ee190-9397-0a31-9c05-f2b8ac92a59e@foss.st.com>
Date:   Thu, 4 May 2023 19:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/7] dt-bindings: spi: stm32: add bindings regarding
 stm32h7 spi slave
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230428121524.2125832-1-valentin.caron@foss.st.com>
 <20230428121524.2125832-5-valentin.caron@foss.st.com>
 <20230428214607.GA326858-robh@kernel.org>
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <20230428214607.GA326858-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/28/23 23:46, Rob Herring wrote:
> On Fri, Apr 28, 2023 at 02:15:21PM +0200, Valentin Caron wrote:
>> From: Alain Volmat <alain.volmat@foss.st.com>
>>
>> Update the spi-stm32 binding yaml regarding to the SPI slave support.
> Why? What problem are you trying to solve.
To add some documentation about cs-gpios and don't allow to use
spi-slave property with st,stm32f4-spi compatible.

I will specify this in next patchset.

>
>> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
>> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
>> ---
>>   Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> index c599eb359d56..1d26fa2658c5 100644
>> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> @@ -27,6 +27,7 @@ allOf:
>>       then:
>>         properties:
>>           st,spi-midi-ns: false
>> +        spi-slave: false
>>   
>>   properties:
>>     "#address-cells": true
>> @@ -62,6 +63,13 @@ properties:
>>         - const: rx
>>         - const: tx
>>   
>> +  cs-gpios:
>> +    description:
>> +      In case of spi-slave not defined, cs-gpios behave as defined in
>> +      spi-controller.yaml.
>> +      In case of spi-slave defined, if <0>, indicate that SS should be
>> +      detected via the dedicated HW pin
> I don't understand. I though cs-gpios was for master mode. You want to
> define 'cs-gpios = <0>;'? How would that be different than just omitting
> cs-gpios?
>
> Rob
We try to keep consistency with spi master, but, as you said, it is useless.
I will remove it in next patchset.

Thanks,
Valentin
