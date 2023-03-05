Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B836AB147
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 16:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCEPzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 10:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCEPzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 10:55:08 -0500
Received: from sonic302-34.consmr.mail.ir2.yahoo.com (sonic302-34.consmr.mail.ir2.yahoo.com [87.248.110.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0239EEC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 07:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1678031703; bh=XBA3Tjdg1aOK1Mf2ovbvgPxmXJjSnTvyJIg5UooDk1o=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=C+qNunrJFW8iFfJRNNke/u5js7SH6mADRT0CA46RwQGwS/VjEjQIXSnha4cfOSRuRqbIwkdOH4thUcqZM9m7JZKYf/HLV/wEacRIDwKugS7yB88/iw3DKP058234XUfoukGc00nPg/84cTtM9hSqDfVDJa3eR0pq7Gk6gXEMnKmon9RpBcho4y6tqnAKEQObnb7XWtM2wu6AV5PoK1zl6QNcRjwSD7sbPjo/TOZu71wlsXHakG+Ca2q3Fgu1KF4YHmB/DSVA3qRZ0n6WPMw9xr2lIhQjpTJwaka+EMlJSJEDGSGA25IUTdQJ9WyWcCYB/ChrZaKeuQ0QHW+1M7dA2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678031703; bh=1Kp9L94l0lRf75Ex3B6yAcE7jI2pZ8T0cdRd94RGjln=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OSJPsSOhi+Zk6XZuCoeVYuWlu29jJXZ+rmPdt2v2GPCLeLK4Ugeg9AVLqG7HMF3B022uiJDZky0NwhgwRmgLb3yWwYDIRVIsDuwwIPwSPO+wm8+L2w/kcA7QyrpkrPd8PP6iHV0CoeGoAZ3fB1uZzzmefeVwXOkSTqqTwCH6V2akpBI8Y/7IVQvTzBbYn2u4rteommPXu/RPdQeucaOo9feWoaF+JtSPzT2st2GJuSIDuikkNjzPddHtBe4q2QYz749UUvL14WC03sh4ASoUXPj4OJbUCMZYk4U9JgHjzpNQRWzjlry2Az6gYpMAxqcE8yONZ8L/9wuDqyAywoFl2A==
X-YMail-OSG: h6IVnLUVM1kt.Ka8QyKxXtCWzVv3luEF3FhKuVAelOWUGZumL77C2ha8w_tfEln
 66Wsbs51SyWZrej.UEPVhY2DtYFKLWxcLA37enLqMegpPrhynuyJHlVBPdQJY03Y8aHI3fM6uZCA
 .jJHJ75RX5HAc9zU0qjGqBIOzhr4aSojTGuS7ldo3YFgTJ9D6furaTfEy5T3oH6hnarVxUNpM.Nk
 B.jagBbDjG0xsXy1wvBSQvRxvxALLNVW2M2O.UgkxdkHcC9cgP8UbhRNnWse8xEa4waTWigFrvzU
 Ca4vGeuTLbXE7vrCT.gZyqPhjhUp.0Lf5f4oqHVJxhPNPLpIJ4yUtVyq.GFwmXLE4DF3kCCW0Biy
 PtzR2JMYKlVAUIXwby4rBVmUF7_6sovIeuIPRP.vyaHQKR3hXk1.Nf_S2Rv42k7YuvEeahHi6OlT
 ZdKa132aqmmHLCix243BLx7NnNgODWfDpGHiCHFPMasCakcpNBLYtW8mfdUu9KhxBV9snhOGbKj3
 CqmukhHP7CpHDINFlVnmKCuW34X3VoXC_jR_BB8ldZj4IT7fSWWkY6vG0F4W81ogr34NKIj3yMb5
 9WSlfK7cnYSWKLqnJOfKE3yPOIbAIopmOpPaj2vumZWo3Ch_83BMDq.Evlt1VNMaujOdShKvZUO3
 1gLWwBHo19rx5lKQ58Jqgo7xiCx8rAnnYGcLPqqigbuQjV_gVphMxkEZJcvU4JUCBz2lBRbo7hCc
 z_s7zEk4zPxlpxPjo9xk.AhBXTxUCy1b.piATrW1.dzjZz5pivufq9tHOfy58fy_FS7QtztVTSy_
 jeijjwzDcecxSgomzt5W9FS1YgGD9D0UukO8X.MkF8J6wC.tBWdVQahbZoDy_j7TrAEsuibFGDkQ
 jdZNh7DRuV.m28UsK9L8_pAapzIV5_qQ87gflb2hqf5V2eD1ieNeZpGRFpElDAK_60gezp5OG17f
 79rRVCNt_A2DdHCPcOJOmFub.oIccTDhG2tjjpq2ScxykeniC5fXlVYNveu5jCP6qmNgrRue8bgy
 KKMAJ9oGGkJcOlVgdfxhCgI842Z9kv_NpvoBWtzpB0ab.NYn3.oQj2EzBxmidr6zuM3WO8VUgWhp
 1Xl1z.evHPe.ae.fBl_EXKaggK4X2U2SVI99ldQAePQNyzo5rzphe2F_kto2_LXTDGbGYWrMBoHY
 SZ3B2gTJaBbxVM9BQnZhKpexIgUHWuqtfWYb.qXewcOREJ_DPW752ePN6o4_92kHJprG_zGI38yT
 B1apAKG1FLRUhalprCvA6ljpE4KlfGiHgMpLJ.wOH6tY1mAY8lgQt7NypPCVvn8u.lp7GiLk8Z__
 xLFTl9L24CUT3ghSVpYVij61Pe4POSZB3R4xsyIIZm2IlKkNQDRm.GPI9TRKBz4bUNCvL.u5rEpF
 bn4VG7NafvO2hIOcELZ1p5zDG1s24JdT_ymgNFx6bYUMEqjfhgccBR9B6a.w9RbvmK8pVaSXNCxG
 do5_6pi7VucJEDi5Y7a0VvpsOLgU2yq4p6uOZXTDdLVo.1vbZQdkQScGL.XPgunsGtOVEHGtlDkn
 WHSOVRPEViMgeNgWg0QEGDSA57u..xy_kg2sWCGrpdrOfMYL.mDaZRSRatLuWgBKwtKhhXvu4lb.
 jfeYcTe7GY401wdolFJ7E7pyHzxxlHVdlI2UzEUox0jBCnEoqFWPIzR4itH.wBFtQ0ufoxXlfkj3
 r2E2AX_l7aAPGmG9AWCX.VBBBZphN54kwamb9fQvq2my7bE06GJV8oLCAKUKyde5G2yXN28eH8OI
 dIH.5Mc4DhC9DyWSfU2v0QvP3BcQyKPIZ28dALRKyAaskBD0tT1JP9gTSHVJSWLYNBylCPDsE_Mt
 QC0P9PX3DgyPCTOepyYWX6aK_AJCtNv.zUOVklAX1vsAmiqmPI.rGGPmkrkxOaCU2_WtJLIjw36c
 MnjkQx55wfiSxDwxonhlnKPtyzvxpPK2UYiiSCQZgIob213VzvQxmOCJ1_clp1T6j1bbknJPdH5c
 dcEzpRtJruPF52xxbdEET5m.WGzOvnOMffXYkU2h.IBGclau4EC_oPPtyv1BQUla5dPbQQxiSNRm
 e_7lUxYyfK4gzI9Ek.JFD1dsXtERPoBe.UTmA4eELq6m_7a7MN0MQMB9AMqYgrKfGvO0J3RhgX.B
 HcvAXhVmplgUDiJ7daCzzO.4G8zmmAh.wYmEa1coC9b8hW7HIk_XBIbTgvgP5fRki_x5Ni7afuvw
 Vm.MbmHPrbv4N9u3jAwyEh6lo6NaCrNxD7D7307W9PJ55FutBY8YkKhFvZWEWDsf0kIRfq9JQFTM
 P_2JMwOWBFeOO8SbcsDIId4foq7pZwak0PifT5N4WUb46Bxhx7nF6NXpO8dT.VVM.lz1QRzg.vYu
 v0s8xORwsdNjwA17tyeX_L24-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Sun, 5 Mar 2023 15:55:03 +0000
Received: by hermes--production-ir2-5b7d458747-xwgkr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 95627d1ce00d1150f3825147f548fe9b;
          Sun, 05 Mar 2023 15:54:58 +0000 (UTC)
Message-ID: <0e008725-66bd-5c3b-e641-1bcf9dcc24e4@rocketmail.com>
Date:   Sun, 5 Mar 2023 16:54:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 10/10] dt-bindings: Add documentation for rt5033 mfd,
 regulator and charger
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1677620677.git.jahau@rocketmail.com>
 <a698f524106e0eb7db5cbd7e73e77ecd5ac8ad7f.1677620677.git.jahau@rocketmail.com>
 <20230301023545.GA235322-robh@kernel.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230301023545.GA235322-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21221 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

thanks for the remarks and sorry for not running 'make 
dt_binding_check'. I'm not familiar with devicetree bindings and 
obviously missed to read the file 
Documentation/devicetree/bindings/submitting-patches.rst.

On 01.03.23 03:35, Rob Herring wrote:
> On Tue, Feb 28, 2023 at 11:32:27PM +0100, Jakob Hauser wrote:
>> Add device tree binding documentation for rt5033 multifunction device, voltage
>> regulator and battery charger.
>>
>> Cc: Beomho Seo <beomho.seo@samsung.com>
>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
>> ---
>>   .../bindings/mfd/richtek,rt5033.yaml          | 102 ++++++++++++++++++
>>   .../power/supply/richtek,rt5033-charger.yaml  |  76 +++++++++++++
>>   .../regulator/richtek,rt5033-regulator.yaml   |  45 ++++++++
>>   3 files changed, 223 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
>>   create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
>> new file mode 100644
>> index 000000000000..f1a58694c81e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
>> @@ -0,0 +1,102 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/richtek,rt5033.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Richtek RT5033 Power Management Integrated Circuit
>> +
>> +maintainers:
>> +  - Jakob Hauser <jahau@rocketmail.com>
>> +
>> +description: |
> 
> Don't need '|' unless you care about line endings.

OK

>> +  RT5033 is a multifunction device which includes battery charger, fuel gauge,
>> +  flash LED current source, LDO and synchronous Buck converter for portable
>> +  applications. It is interfaced to host controller using I2C interface. The
>> +  battery fuel gauge uses a separate I2C bus.
>> +
>> +properties:
>> +  compatible:
>> +    const: richtek,rt5033
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  regulators:
>> +    type: object
>> +    $ref: /schemas/regulator/richtek,rt5033-regulator.yaml#
>> +
>> +  charger:
>> +    type: object
>> +    $ref: /schemas/power/supply/richtek,rt5033-charger.yaml#
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    i2c@0 {
> 
> i2c {

OK

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
>> +                safe_ldo_reg: SAFE_LDO {
>> +                    regulator-name = "SAFE_LDO";
>> +                    regulator-min-microvolt = <4900000>;
>> +                    regulator-max-microvolt = <4900000>;
>> +                    regulator-always-on;
>> +                };
>> +                ldo_reg: LDO {
>> +                    regulator-name = "LDO";
>> +                    regulator-min-microvolt = <2800000>;
>> +                    regulator-max-microvolt = <2800000>;
>> +                };
>> +                buck_reg: BUCK {
>> +                    regulator-name = "BUCK";
>> +                    regulator-min-microvolt = <1200000>;
>> +                    regulator-max-microvolt = <1200000>;
>> +                };
>> +            };
>> +
>> +            charger {
>> +                compatible = "richtek,rt5033-charger";
>> +                richtek,pre-uamp = <450000>;
>> +                richtek,fast-uamp = <1000000>;
>> +                richtek,eoc-uamp = <150000>;
>> +                richtek,pre-threshold-uvolt = <3500000>;
>> +                richtek,const-uvolt = <4350000>;
>> +                extcon = <&muic>;
>> +            };
>> +        };
>> +    };
>> +
>> +    i2c@1 {
> 
> This should be a separate example entry.

I'll skip it then.

The battery fuel gauge is not handled as a part of the MFD, it has a 
separate I2C line. Accordingly, it has a separate documentation 
including examples [1].

I had implemented into the MFD example to make clear this is separated. 
But as it is not part of the MFD, I guess it shouldn't show up in the 
MFD documentation.

In the description of the MFD there is the statement "The battery fuel 
gauge uses a separate I2C bus." I hope this is clear enough, I'm not 
sure if I should modify/extent that statement or add some kind of 
reference to the battery fuel gauge after removing it from the example.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml?h=v6.2

>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        battery@35 {
>> +            compatible = "richtek,rt5033-battery";
>> +            reg = <0x35>;
>> +            interrupt-parent = <&msmgpio>;
>> +            interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
>> new file mode 100644
>> index 000000000000..996c2932927d
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
>> +description: |
>> +  The battery charger of the multifunction device RT5033 has to be instantiated
>> +  under sub-node named "charger" using the following format.
>> +
>> +properties:
>> +  compatible:
>> +    const: richtek,rt5033-charger
>> +
>> +  richtek,pre-uamp:
> 
> Use defined standard unit type suffixes.

That makes sense. I took the current names from the 2015 patchset and 
wasn't aware of the standard suffixes.

Just for the record: Chaning the names will also impact patch 06 "power: 
supply: rt5033_charger: Add RT5033 charger device driver", as the names 
are parsed there.

>> +    description: |
>> +      Current of pre-charge mode. The pre-charge current levels are 350 mA to
>> +      650 mA programmed by I2C per 100 mA.
>> +    maxItems: 1
>> +
>> +  richtek,fast-uamp:
>> +    description: |
>> +      Current of fast-charge mode. The fast-charge current levels are 700 mA
>> +      to 2000 mA programmed by I2C per 100 mA.
>> +    maxItems: 1
>> +
>> +  richtek,eoc-uamp:
>> +    description: |
>> +      This property is end of charge current. Its level ranges from 150 mA to
>> +      600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA and 600 mA
>> +      in 100 mA steps.
>> +    maxItems: 1
>> +
>> +  richtek,pre-threshold-uvolt:
>> +    description: |
>> +      Voltage of pre-charge mode. If the battery voltage is below the pre-charge
>> +      threshold voltage, the charger is in pre-charge mode with pre-charge current.
>> +      Its levels are 2.3 V to 3.8 V programmed by I2C per 0.1 V.
>> +    maxItems: 1
>> +
>> +  richtek,const-uvolt:
>> +    description: |
>> +      Battery regulation voltage of constant voltage mode. This voltage levels from
>> +      3.65 V to 4.4 V by I2C per 0.025 V.
>> +    maxItems: 1
>> +
>> +  extcon:
> 
> This is deprecated. There's standard connector bindings now.

How does this work? I couldn't find an example.

I found Documentation/devicetree/bindings/connector/usb-connector.yaml 
[2] but I don't see how this would be applied here.

The extcon device entry in the samsung-serranove devicetree [3] looks like:

i2c-muic {
         compatible = "i2c-gpio";
         sda-gpios = <&msmgpio 105 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
         scl-gpios = <&msmgpio 106 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;

         pinctrl-names = "default";
         pinctrl-0 = <&muic_i2c_default>;

         #address-cells = <1>;
         #size-cells = <0>;

         muic: extcon@14 {
                 compatible = "siliconmitus,sm5504-muic";
                 reg = <0x14>;

                 interrupt-parent = <&msmgpio>;
                 interrupts = <12 IRQ_TYPE_EDGE_FALLING>;

                 pinctrl-names = "default";
                 pinctrl-0 = <&muic_irq_default>;
         };
};

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/connector/usb-connector.yaml?h=v6.2
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts?h=v6.2#n123

>> +    description: |
>> +      Phandle to the extcon device.
>> +    maxItems: 1
>> +
>> +required:
>> +  - richtek,pre-uamp
>> +  - richtek,fast-uamp
>> +  - richtek,eoc-uamp
>> +  - richtek,pre-threshold-uvolt
>> +  - richtek,const-uvolt
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    charger {
>> +        compatible = "richtek,rt5033-charger";
>> +        richtek,pre-uamp = <450000>;
>> +        richtek,fast-uamp = <1000000>;
>> +        richtek,eoc-uamp = <150000>;
>> +        richtek,pre-threshold-uvolt = <3500000>;
>> +        richtek,const-uvolt = <4350000>;
>> +        extcon = <&muic>;
>> +    };
>> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
>> new file mode 100644
>> index 000000000000..61b074488db4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5033-regulator.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/richtek,rt5033-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Richtek RT5033 PIMC Voltage Regulator
>> +
>> +maintainers:
>> +  - Jakob Hauser <jahau@rocketmail.com>
>> +
>> +description: |
>> +  The regulators of RT5033 have to be instantiated under a sub-node named
>> +  "regulators". For SAFE_LDO voltage there is only one value of 4.9 V. LDO
>> +  voltage ranges from 1.2 V to 3.0 V in 0.1 V steps. BUCK voltage ranges from
>> +  1.0 V to 3.0 V in 0.1 V steps.
>> +
>> +patternProperties:
>> +  "^(SAFE_LDO|LDO|BUCK)$":
> 
> Lowercase preferred for node names.

OK, I can change to lowercase.

Though I have to change the already existing driver rt5033-regulator as 
well then [4]. I'm not sure if this has an impact on already existing 
implementations. Although within the upstream kernel I think there is no 
usage of the rt5033-regulator driver yet.

[4] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/regulator/rt5033-regulator.c?h=v6.2#n42

>> +    type: object
>> +    $ref: /schemas/regulator/regulator.yaml#
>> +    unevaluatedProperties: false
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    regulators {
> 
> Just 1 complete example in the MFD binding please.

OK, I'll skip the examples part here then.

>> +        safe_ldo_reg: SAFE_LDO {
>> +            regulator-name = "SAFE_LDO";
>> +            regulator-min-microvolt = <4900000>;
>> +            regulator-max-microvolt = <4900000>;
>> +            regulator-always-on;
>> +        };
>> +        ldo_reg: LDO {
>> +            regulator-name = "LDO";
>> +            regulator-min-microvolt = <2800000>;
>> +            regulator-max-microvolt = <2800000>;
>> +        };
>> +        buck_reg: BUCK {
>> +            regulator-name = "BUCK";
>> +            regulator-min-microvolt = <1200000>;
>> +            regulator-max-microvolt = <1200000>;
>> +        };
>> +     };
>> -- 
>> 2.39.1
>>

I'll wait with implementing the changes as there will be likely further 
comments on the other patches.

Kind regards,
Jakob
