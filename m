Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65370747F14
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjGEIIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjGEIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:08:48 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4F21717;
        Wed,  5 Jul 2023 01:08:44 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 161BC120059;
        Wed,  5 Jul 2023 11:08:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 161BC120059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688544521;
        bh=fNQYFEDCRmuCNe/I+fdjC1cG7kMAFnCpHOxYewfTXFU=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=PH10+e835IqEviJs4EmxvzRWEYguzFbbnTadajLauYd9vEU+wLzMSvIGlu0bYldtp
         dMlU6CpJFKfrrrDOXBt7r+jVlXN/MhGTglVChTXZwFuqAxjrhyI3Fv3EkgBJw5PhZk
         rlLS5TStgyPF8aiyjuLwFq/idAQcCuSn6+314YVDpb1F/V7HisK24wrTQ8kxPlUIiF
         OKGZjugRtcv8CXcC0ymtYZRvudU9KSal82tNuebfWpa1I8Lu7eD3tgLDwueZdWdkde
         pJ5jQ/d7klH2pZJedXSYwaRztMRH0aLYgzAk4ysUEtjmFDK1TqIlfTyTn6cQ+W+Cbi
         AYdH/lFCMCk4g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 11:08:40 +0300 (MSK)
Received: from [192.168.0.12] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 5 Jul 2023 11:08:39 +0300
Message-ID: <365898fb-3719-38e0-4383-e04ccc0b475b@sberdevices.ru>
Date:   Wed, 5 Jul 2023 11:03:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: nand: meson: support for 512B ECC
 step size
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230705065434.297040-1-AVKrasnov@sberdevices.ru>
 <20230705065434.297040-2-AVKrasnov@sberdevices.ru>
 <20230705093702.6c0421d7@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230705093702.6c0421d7@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178438 [Jul 05 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/05 05:28:00 #21565829
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.07.2023 10:37, Miquel Raynal wrote:
> Hi Arseniy,
> 
> AVKrasnov@sberdevices.ru wrote on Wed, 5 Jul 2023 09:54:33 +0300:
> 
>> Meson NAND supports both 512B and 1024B ECC step size, so replace
>> 'const' for only 1024B step size with enum for both sizes.
>>
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> index 3bec8af91bbb..81ca8828731a 100644
>> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> @@ -49,7 +49,8 @@ patternProperties:
>>          const: hw
>>  
>>        nand-ecc-step-size:
>> -        const: 1024
>> +        enum: [512, 1024]
>> +        default: 1024
> 
> I was actually wrong in my previous review, there is no strong default
> here as the existing binding (and code) try to use the closest
> parameters required by the NAND chip: we pick the "optimal"
> configuration. So if you don't provide any value here, we expect
> the strength and step size advertized by the chip to be used. This is a
> common default in the raw NAND subsystem.
> 
> Please drop the default line, re-integrate the missing R-by tag from
> Rob and in a separate patch please mark nand-ecc-step-size and
> nand-ecc-strength mandatory if the other is provide. IOW, we expect
> either both, or none of them, but not a single one.

I see, no problem! "mandatory" means update description of both fields like:

    description:                                                        
      Mandatory if nand-ecc-step-size is set.

etc.

?

> 
>>  
>>        nand-ecc-strength:
>>          enum: [8, 16, 24, 30, 40, 50, 60]
>> @@ -93,6 +94,7 @@ examples:
>>        nand@0 {
>>          reg = <0>;
>>          nand-rb = <0>;
>> +        nand-ecc-step-size = <1024>;
> 
> So in the end this line is wrong and once you get the description right
> as I mentioned it above, this will fail to pass
> `make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mtd/ dt_binidng_check`
> Please drop it from the example, don't add the second property here,
> it's best to show a clean example where people stop tampering for no
> reason with the optimal values.

Ok!

Thanks, Arseniy

> 
>>        };
>>      };
>>  
> 
> 
> Thanks,
> Miquèl
