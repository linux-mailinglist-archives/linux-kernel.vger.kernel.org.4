Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FAF6E6E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjDRVhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjDRVhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:37:41 -0400
Received: from sonic303-21.consmr.mail.ir2.yahoo.com (sonic303-21.consmr.mail.ir2.yahoo.com [77.238.178.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68A9130
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681853858; bh=XzIfjNAQ6FWOx9wfnDuWL7QaL/nlgGrtEUaAu68jgNk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=K10sEsAxNOLuEzfPIXLMaXrEAff0CNh/gdrjTIzXuf1lhHnpqa/e3nEmvkjPCtguF8XVvlD0X2/O3jfdz/kl1lA2/H85zMTw7sUtRG22LJKh9jLA0vgWgKjvVW7lIJaTxCjNXiPcXuNc0cVBiXJMc+Cg8Rn/UFVlzv6Ys1Ln5jCrnOGRcVE2PS8z+HTNSKBv21SKNNq/RI8CULyDq5A9Jc/k/P7Gf3KfExpfzybUdWx4MAKW8VFeDl3ZXNLRFRuRZg/Rj/RQSGwPC7zIWC9Eq6sX91SFnGP7tFvqtMMFIYVxtVgRHBAT36RLYGLk2XCZF1je3HVXUCXHfDe4MDXq5w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681853858; bh=WV2DLFekiIbEc+LCArbaTU5I1VXksIPwPpKJhX5vxqk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uO3yPI2DWI0XuO638EV66MLlA224h/kPQAS1h6sEegzbKtNJnxLZ6JXhiYFOaLcUMohR/H7HiJoMwjuXWCX+VO2wavESHoa3zpUCZpzSbATTJ/EsTiNuU3wUotqtMuwtRmVeHImYz0XBlC9Sdnx++8FhVRKIykjvPMM+WBtQKJbwyhlyx1i+VMb4c3zgAr5XSjdEE9EzkIZOHU0j2lW1ETnof/rnpgL9Zw4cghqDVZPtYYrhgZg8+hix+lusatoZd0G4zLVP5nRrxJ1NQaj8JssYbhqopgm0g2m9Yzx6ekLKo1tDDzKiHWDR5OXLqqIOg3khlIKm8uvzO7lzfH+hNw==
X-YMail-OSG: 48mMsVEVM1nWwYYoYYKD.71nu_WYVXCi2lhCa4lRmXgS9KqlTOKWEwy3epxrqPP
 bO_AKICWkP7CUix0ufh0tKqTsc7bCjoO3j69pO1z7hDIl5eusA6l7uYj.aTjfIlS3FCgzCDHeDDm
 mCOqzwO7I5lW1aYC1ShFf8PW9FCMmV8bV8PWOiyKP2OCRBBwxZwWzdy8YmlwAx7EJbqEHCMwJsBu
 SLhmEaqHgylTRxytXTxbAaHZDFdreJbfkIhJpz0irhRLzIaPFjoUwzE3FfQejz6RyRHJcn1rqAdX
 GEaqHrY7sYjnQBv.bMmRRbsTtRWEoFrKnaNkOsCd.q6mZQGJNngxBE9bToM4hdk5vy4bD4kTuHbv
 7eXbr4SC.g0YAmlps57XfTISA.Xw0gryOnc7c9s0ZrLtIBU7k9kddn4qGxdZYxn_vT_VM2yPMYHX
 f7Ai6Ev_9.ARejf6_j.4sj70OHTMfwvrPBPjDw_BoS3BlMAz853DcfVgLYzmp_D9uyWWFou8rtks
 mnLKfR4_2aPYxo5X7pW6eknwl7rK0i2aMcGq5AxZJR3tW8esOWacrILzqTdxWrgvsiSSkIAHQ7UC
 87HtznnhsO6HC1_XbLMTOqFFEoLZnijDsOTALF6ybKlfN3Dru2eXEQa0KxWI7yK.nk.ST9cMTIvK
 LTHmVCRx0UmRPitiJlr5LZgQOykIEMGZaC.ansHnT40jAu69n1p0H0qOqPsIoJOP82VggoiVLJmc
 8MozYOWcO_PQkl8Xk0f1rd8EXxW94BlKowbkGKERKpxcw128QRZHk50KP65TA_QQdLvh_Svgq2vP
 CIYPrTUmc2kWlW6uVG1xULLenKfiDWlaywXx8a7otMLfa8LYX2Nbv_Pd_8PNE8m8zx5M4R_FmlrE
 yCSWTTXKj6T5lwt1yprmCcml7f0cAtZzwwE279OAZddpcsziH8pVJFBdrGN4oLjXMdH.U4ckhULq
 sOej0QikzVfdbBVxg.jsm0VqP4i2LWjebae11BUEAS_O9h2543mOtkaTEc3SvvmS0qzdmA5dff19
 eK5FraFEBJitPrV0Ua_xusZ_vmqQF78lRDwgJVZMfhqU48T0NQbw1N9RGYlLBcnY5LorSNyaKEmI
 nstAP3d6mTtnEH8z2FS7GVc2oRfhM6xSuAOta83c3gfg3BeL.V1IBDA2qwMCHm1j5RjHV7ektgRR
 ..KZzvZA_yS6sgnNSjq6ZltUjikdMvG4nrTLV4IJX8aeGTWMd..e6wd36XxNjXIgvmECHyCoTMFR
 LG6waeNSSeodc7M0galpghQ0XJKhMk8VnQNV3IFQYZvrbLQjt2EVv_e4R_MlHPtELVbovYrzmziT
 NIunW51muaYTefxy6hyz7rhTlxjCltb.BFsExmt3662abl52pD_3Q9UEw0Zopn.zzCpVsdNEyJl5
 VZfled3pab7fbeNxBOj2mXoLxPBZnU4Wd6PV9pWLlTF04b4tuNpc5TIJLrAzDADp3ixzW5lfVe6p
 MRnvkysObMOH1vM4JCkPSQG6_lcRQjNHbSkvJjKTAaZox9oz4f8P0fsfhAyalAncY3nA0324PAD3
 36PaCDEnuY0Z08t4oodFYgvL4HMpFswxUNSS6nVUSwSxar_QJmT.mdOcw0FiJuNlHGy2wX5mOXpD
 hF6o7nn0BqDN9p8GShnT_4hM8uuBxdHUBKM3d91k74UMMxndFPzO7STxP.IhUHcsTvCOG..ghspz
 dENHU4McE954dY92zi43WQQfnDA4KCJSO8VwVMwV7.UNSxuAQK_XHbsSSUb9S4vMbE9LFuTbaf8W
 vgZn6PDuHmtN1EEieiqzCIjF5pBZT_6fetOW7szArKToJ5w2n9hjJ0w3GrVYiIn7RP.nB7bi4Sqk
 w1rDfUe76lETFLdUkL3i3srJCw8ejWNiX2vcPR_CCQv4fXjKcNHeHA9xp4UqxZefwEbfF5TuhgGb
 vyQ.GxQmZFKvkfAvtKNm7veNFugKOrMKwJXZtlKjbuNGCeP2hBIs3C_H6PgIq8ilXg_XDQ9QSlrZ
 USJHYpDVblGe38DoJ17a_9qIv77RfKpzRIuqKjXwtnucQ0s4_B9N.K8ecRxCEEKIFIXLe6Nr4z0l
 u49NY_50uxZFpo16fgbIX0dX3qnYdwUSpHERZ5G7cbc3bYSpUdqqCYJoFJymUnNjS3BOkwsd1imR
 QT45N.iR_StAD.VEIk1FqK7fh2M5BHicwX0CVZA4L7cRbVD6R8VvftrB0zMYXYb70sGt.l7GTSd8
 pCU6nTjydIL8A0NXoyQbLMwJT2sT7UPJhEYRuThDy3XHapEdBpg7GkU6naKo7uc6MrIZN0NOK6TQ
 .a5Oo47cJRuItgHH6Iz2.mfilKUEnETY-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: a23b155f-b731-427b-96a7-ab05bfc3913d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Tue, 18 Apr 2023 21:37:38 +0000
Received: by hermes--production-ir2-74cd8fc864-29g5c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 796ce50f401174f98ec284de7688bf1b;
          Tue, 18 Apr 2023 21:37:35 +0000 (UTC)
Message-ID: <acb209ce-7cb6-9a07-c913-9931b980c8c7@rocketmail.com>
Date:   Tue, 18 Apr 2023 23:37:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 9/9] dt-bindings: Add documentation for rt5033 mfd,
 regulator and charger
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1681646904.git.jahau@rocketmail.com>
 <9275af790e6e21b5cf661a2444effe4caf2be02e.1681646904.git.jahau@rocketmail.com>
 <5b41b54c-88d0-3666-9db2-9cbb90ba8183@linaro.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <5b41b54c-88d0-3666-9db2-9cbb90ba8183@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 16.04.23 20:39, Krzysztof Kozlowski wrote:
> On 16/04/2023 14:44, Jakob Hauser wrote:
>> Add device tree binding documentation for rt5033 multifunction device, voltage
>> regulator and battery charger.
> 
> Subject: drop second/last, redundant "documentation". The "dt-bindings"
> prefix is already stating that these are documentation.

If I understand correctly, the new subject would be:
"dt-bindings: Add rt5033 mfd, regulator and charger"

...

>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        pmic@34 {
>> +            compatible = "richtek,rt5033";
>> +            reg = <0x34>;
>> +
>> +            interrupt-parent = <&msmgpio>;
>> +            interrupts = <62 IRQ_TYPE_EDGE_FALLING>;
>> +
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&pmic_int_default>;
>> +
>> +            regulators {
>> +                safe_ldo_reg: safe_ldo {
> 
> If you could change it: No underscores in node names... but you cannot.
> This is old driver so you will break the users.

As discussed on patch 5, I'll leave the regulator names unchanged. Thus, 
I'll reset them to the original uppercase spelling.

>> +                    regulator-name = "safe_ldo";
>> +                    regulator-min-microvolt = <4900000>;
>> +                    regulator-max-microvolt = <4900000>;
>> +                    regulator-always-on;
>> +                };
>> +                ldo_reg: ldo {
>> +                    regulator-name = "ldo";
>> +                    regulator-min-microvolt = <2800000>;
>> +                    regulator-max-microvolt = <2800000>;
>> +                };
>> +                buck_reg: buck {
>> +                    regulator-name = "buck";
>> +                    regulator-min-microvolt = <1200000>;
>> +                    regulator-max-microvolt = <1200000>;
>> +                };
>> +            };

...

>> diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
>> new file mode 100644
>> index 000000000000..439e0b7962f3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
>> @@ -0,0 +1,76 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/richtek,rt5033-charger.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Richtek RT5033 PIMC Battery Charger
>> +
>> +maintainers:
>> +  - Jakob Hauser <jahau@rocketmail.com>
>> +
>> +description:
>> +  The battery charger of the multifunction device RT5033 has to be instantiated
>> +  under sub-node named "charger" using the following format.
>> +
>> +properties:
>> +  compatible:
>> +    const: richtek,rt5033-charger
>> +
>> +  richtek,pre-microamp:
>> +    description:
>> +      Current of pre-charge mode. The pre-charge current levels are 350 mA to
>> +      650 mA programmed by I2C per 100 mA.
> 
> minimum:
> maximum:
> multipleOf: 100
> 
> Same for other cases.

The "multipleOf: 100" doesn't seen appropriate to me when the choice is 
350, 450, 550, 650. Those are not multiples of 100. It's more of a step 
size. I didn't find a general property for step size. Listing them as 
"enum" would be another possibility, I guess, but not an elegant one. 
Especially for property "richtek,const-microvolt" there are 30 
possibilities.

Using "multipleOf" and unit microamp, the block would then look like this:

   richtek,pre-microamp:
     description:
       Current of pre-charge mode. The pre-charge current levels are
       350 mA to 650 mA programmed by I2C per 100 mA.
     minimum: 350000
     maximum: 650000
     multipleOf: 100000
     maxItems: 1

Or possibly better readable the following way:

   richtek,pre-microamp:
     description:
       Current of pre-charge mode. The pre-charge current levels are
       350 mA to 650 mA programmed by I2C per 100 mA.
     maxItems: 1
     items:
       minimum: 350000
       maximum: 650000
       multipleOf: 100000

>> +    maxItems: 1
>> +
>> +  richtek,fast-microamp:
>> +    description:
>> +      Current of fast-charge mode. The fast-charge current levels are 700 mA
>> +      to 2000 mA programmed by I2C per 100 mA.
>> +    maxItems: 1
>> +
>> +  richtek,eoc-microamp:
>> +    description:
>> +      This property is end of charge current. Its level ranges from 150 mA to
>> +      600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA and 600 mA
>> +      in 100 mA steps.
>> +    maxItems: 1

Here are two different step sizes. The first few are 50 mA steps (150, 
200, 250, 300 mA) and then it changes to 100 mA steps (300, 400, 500, 
600 mA). How to deal with that? Again I guess "enum" would be a 
possibility, but again not a nice one.

>> +
>> +  richtek,pre-threshold-microvolt:
>> +    description:
>> +      Voltage of pre-charge mode. If the battery voltage is below the pre-charge
>> +      threshold voltage, the charger is in pre-charge mode with pre-charge current.
>> +      Its levels are 2.3 V to 3.8 V programmed by I2C per 0.1 V.
>> +    maxItems: 1
>> +
>> +  richtek,const-microvolt:
>> +    description:
>> +      Battery regulation voltage of constant voltage mode. This voltage levels from
>> +      3.65 V to 4.4 V by I2C per 0.025 V.
>> +    maxItems: 1
>> +
>> +  extcon:
>> +    description:
>> +      Phandle to the extcon device.
>> +    maxItems: 1

...

>> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
>> new file mode 100644
>> index 000000000000..66c8a0692e10
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
>> @@ -0,0 +1,24 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/richtek,rt5033-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Richtek RT5033 PIMC Voltage Regulator
> 
> You should explain in commit msg that you document existing driver in
> the Linux kernel. We would not cut some slack, e.g. stricter rules
> applied to new bindings.
> 
>> +
>> +maintainers:
>> +  - Jakob Hauser <jahau@rocketmail.com>
>> +
>> +description:
>> +  The regulators of RT5033 have to be instantiated under a sub-node named
>> +  "regulators". For "safe_ldo" voltage there is only one value of 4.9 V. "ldo"
>> +  voltage ranges from 1.2 V to 3.0 V in 0.1 V steps. "buck" voltage ranges from
>> +  1.0 V to 3.0 V in 0.1 V steps.
>> +
>> +patternProperties:
>> +  "^(safe_ldo|ldo|buck)$":
>> +    type: object
>> +    $ref: /schemas/regulator/regulator.yaml#
> 
> Just squash it with parent schema. No real benefits of having regulators
> separate - it's very small one.

OK, I'll squash the regulator schema into the mfd schema.

Kind regards,
Jakob
