Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81711689A28
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjBCNuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjBCNuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:50:51 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C15E9A82C;
        Fri,  3 Feb 2023 05:50:37 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3139pYul027545;
        Fri, 3 Feb 2023 14:50:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=quyuHnd52UYk2m8I58kZLilahHwXYAvRNaQN+/UHriA=;
 b=2MNrCRIIgLAG9Tu1cxSDCxD8Jprxjh+PrgHaGeYOGVtvxunRgBx3wtuUDn9aiblplZIN
 TRUlyO8StlXCSmPixiJ2doLww2jZMrmeP7H+kl0H0phlAKQDYnueKNac5LD7hyh0sBFj
 WzfSKksF7/s2JN329RT97asyy/ZS/xDRKPciUrc/IjOm0TFmMQ13wbbzZjNwi6SfZ6WN
 bGg+DH10DFkdhYbfL0X783WXsKlIYa6Ldm4Ky9nNcncwQpln0ZhMa4dm1+jnujZX5HW0
 ZvK/omGsLXW57AMlgGkw8Hyr11SsbDeAT4aHsHO4w5NPHKcd309fZpFEHY6dlZV7+r6Q qA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3nfny5f85v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 14:50:05 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0504610002A;
        Fri,  3 Feb 2023 14:50:03 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F2F36218615;
        Fri,  3 Feb 2023 14:50:02 +0100 (CET)
Received: from [10.252.18.17] (10.252.18.17) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 3 Feb
 2023 14:50:02 +0100
Message-ID: <527eaa1f-f663-8a92-00b5-b0329240b922@foss.st.com>
Date:   Fri, 3 Feb 2023 14:50:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] ARM: dts: stihxxx-b2120: fix polarity of reset line of
 tsin0 port
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alain Volmat <avolmat@me.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <YzcSqZdpNbdINp4Q@google.com> <Y9wGO0Q//TIKwTTE@google.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <Y9wGO0Q//TIKwTTE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.18.17]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_13,2023-02-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/23 19:51, Dmitry Torokhov wrote:
> On Fri, Sep 30, 2022 at 09:00:41AM -0700, Dmitry Torokhov wrote:
>> According to c8sectpfe driver code we first drive reset line low and
>> then high to reset the port, therefore the reset line is supposed to
>> be annotated as "active low". This will be important when we convert
>> the driver to gpiod API.
>>
>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
> 
> Gentle ping on this one...

Hi Dmitry

Sorry for the delay, i will push a STi pull request including your patch.

Patrice

> 
>>
>> v2: fixed typo in the subject, added Patrice's reviewed-by
>>
>>  arch/arm/boot/dts/stihxxx-b2120.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
>> index 2aa94605d3d4..d52a7aaa1074 100644
>> --- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
>> +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
>> @@ -178,7 +178,7 @@ tsin0: port {
>>  				tsin-num = <0>;
>>  				serial-not-parallel;
>>  				i2c-bus = <&ssc2>;
>> -				reset-gpios = <&pio15 4 GPIO_ACTIVE_HIGH>;
>> +				reset-gpios = <&pio15 4 GPIO_ACTIVE_LOW>;
>>  				dvb-card = <STV0367_TDA18212_NIMA_1>;
>>  			};
>>  		};
>> -- 
>> 2.38.0.rc1.362.ged0d419d3c-goog
>>
>>
>> -- 
>> Dmitry
> 
