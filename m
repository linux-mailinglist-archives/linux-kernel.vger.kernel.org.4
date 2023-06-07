Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C02725853
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjFGIqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239332AbjFGIqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:46:07 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9A419BD;
        Wed,  7 Jun 2023 01:45:58 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 531D95FD5C;
        Wed,  7 Jun 2023 11:45:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686127556;
        bh=uBSKsrbRuolQZg/+wG53i1qmpUFa/MrANVgb91lYcfk=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=MxOw7qzEgxWEAD9hil/w/JFHtOGjEZq5QYLAyDNyLlk4PqAwHKPEsgxnulQC02XWM
         lwMI3vIh9DLyjXyIbeWT8xe5TzYS1QEtXolV0jCZqMx7a4pHasNKyP2rGopWt6pawi
         vFmT/RWjjae/ieN1LLunhHErDMhKfluxORC+M1s2sAXStqpj3a9cqUY3MawSqc1b7x
         M31vPKCMHjD0SyivSVNNf14ljs6st90g1H7Nry+Adel5Ii+nJnOLOlQWcmtrP3Cl7C
         FAURsCHPQNWfjop1wqJ8SWRW6Ws9ioeDdmcqlnyPoAdQ5sM2edIg+jswOAXZ6EGJsN
         IEYpbkbkq9img==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  7 Jun 2023 11:45:53 +0300 (MSK)
Message-ID: <166bdc27-f77c-9076-f866-180cfa5bff76@sberdevices.ru>
Date:   Wed, 7 Jun 2023 11:40:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] dt-bindings: nand: meson: Fix 'nand-rb' property
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230606193507.35024-1-AVKrasnov@sberdevices.ru>
 <20230607095802.3adcd4f9@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230607095802.3adcd4f9@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/07 04:52:00 #21449589
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

Hello Miquel, 

On 07.06.2023 10:58, Miquel Raynal wrote:

> Hi Arseniy,
> 
> AVKrasnov@sberdevices.ru wrote on Tue, 6 Jun 2023 22:35:07 +0300:
> 
>> Add description of 'nand-rb' property. Use "Fixes" because this property
>> must be supported since the beginning. For this controller 'nand-rb' is
>> stored in the controller node (not in chip), because it has only single
>> r/b wire for all chips.
> 
> Sorry if I mislead you in the first place, but you could definitely
> have two chips and only one with RB wired. It needs to be defined in
> the chips.

Ok, so to clarify: is it ok, that in bindings this property will be placed in the
chip, but in driver, i'm trying to read it from the controller node (thus  in
dts file it will be also in controller node)? Because in driver there is no sense
to store this value in chip structure. In fact, in driver, I can read it from the
chip node, but set 'no_rb_pin' flag in the controller structure.

Thanks, Arseniy

> 
> Please keep the bindings and driver changes related to this in the same
> series.

Ack

> 
>>
>> Fixes: fbc00b5e746f ("dt-bindings: nand: meson: convert txt to yaml")
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> index 28fb9a7dd70f..866edf800b81 100644
>> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> @@ -37,6 +37,8 @@ properties:
>>        - const: core
>>        - const: device
>>  
>> +  nand-rb: true
>> +
>>  patternProperties:
>>    "^nand@[0-7]$":
>>      type: object
>> @@ -81,6 +83,7 @@ examples:
>>  
>>        pinctrl-0 = <&nand_pins>;
>>        pinctrl-names = "default";
>> +      nand-rb = "true";
>>  
>>        #address-cells = <1>;
>>        #size-cells = <0>;
> 
> 
> Thanks,
> Miquèl
