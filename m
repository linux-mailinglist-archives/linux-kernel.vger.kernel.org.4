Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294D56FD2F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 01:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjEIXIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 19:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEIXIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 19:08:35 -0400
Received: from sonic314-20.consmr.mail.ir2.yahoo.com (sonic314-20.consmr.mail.ir2.yahoo.com [77.238.177.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58DC3AA5
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683673712; bh=zp2c2cd4lwZqhHjdjVdFDoJiq8XP9spy5T+/kzV/2H8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=YRKXllKXPkJjYzNv9qUn3bC9XiUM23lukQasnHqq2W1UqGsSKqPdxt3V2MnGpmFkQn5zCMYikVz0UGL2SfftP+icM6rtlWT2DLV15u3J/BMv5AW52SGSWmI75e9O7wvdZyQZkDK7QAgrRD/n1A3wrNUPZKYvjzGH236s3NC2S8Uv6xpM/xxmyE0o1yurPIPJhn2Up0a4Y2lviXPa/DDVZZkg17VMxtcE2g4h+TH0fRvD8ChugXD2PAR5ldWCFQ93FBWSBLFYezbtSgn00O7o08IWVmD6fftYErUmupms+baHoPhTTg3fd/wy55YroBPGzJSuiBosPOP1Ew5g2M8WeQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683673712; bh=3bt0fE80k7Rxcpi/4RtFXVoaDMa2eRmUO6BCOqhmq0y=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=nrTo17tYlokj40BgbBijWTlsKKhPeajoeEOjjuEv/3S5IvB/xFzOcKaf7MwNb7hpXqTR2Z1zzvnCRVojZcgpsmN1nOUc7v4gXYsU95vJmV9ZeQLJ+COCzo7H0JDeESFKqvJF3Wpp74cLiA3u9OMQ3dUjEoV8f/TMBW1dloRPRBsGxwnX6YnIWvQ2xBk5GI05FthgKOSaWJjKpj+Y5oEp/i82NTh5WzmB6gttbI6sQMKdQUMb3J1dTkGOHLB0q1Jy0jzxRgNl/76ITfO2TyYWj6Mrpwr2mewnmiGoJ2iiyHIt4TXkgSeBzXwv7u95Y7VFXJEnVCexo+irQFzKdmih5A==
X-YMail-OSG: dNLcEmYVM1mtV84oVum2i3KZLiY3yU5rrycjCHcF4QT5y8aEcJO1WCu.JAhZAJk
 40_kCiH9IfTaVjYm0NqQjCcA2qpfNUqXzNWyIyOFsTmSZLvjJwsohVYDTF6vNpTq29o7.sdEu7AB
 53O4ylzhAbqqpf0L6eswdgvdYHIJ3Hk1r58D4YysDeHRsSN5R2MVhpkqq0DOqHyMjCG.EcrzVov.
 W4.s8kHfFK.nHoa22P4hIz3euAf1Ltpr_BaTG7of6sbMVULOe39l3kQYa7i377._HKFJ.zglwi6U
 OX_fAvFFE7_nJ4sTOorDiAaiM0cSNfhQ4u5WzGpZW3dTqGM3FXHB3CAtrRJkntKvpYy.KI6xEbLT
 JMfo93q9bjfTOjwcVbDuwUeTJPlegnRQ_nbG6Nuvz9fe0s8j5XtLP5DGdtjP20RsP2IptNIxqzUg
 vW8RsF7WxaMCAtPGAkvVUO2ELosASXZOiRmlBdZ.5E5xlGu.sTcqeQwnDOd5VpmxaHM7ls6P8MHW
 UTUKYQdG3xulyFF.x21Z51r8SQ_uk1kgGsWGYzEPHA0WQTeGGadL04gA7zVMjoxU0EzA2sz8IZkD
 DxgWpPXfjXN1fe.wfogCSuPZTrmSVZMjBJ58OMsr2RMmLo0UTmEBKlozjrCyycL_79U7F2IBzVsV
 VI9UMKfIp4oEn.jXqqGxC.T0URthaOeFxXzA5wTe9j4SDgTklBxHWgyMWTfusWW5S2GQCRiIB9BJ
 9PKk.jOa3bdDtPayGqtbpBp29BckvK0lAuJwc7kKOTulEk4X8QzLDFZH92hNwFhIXjUJwDHpp3Ij
 y15e_oSLqYos6k7ZoBva8KJ7pFGTHrnI4J.ySZsKC.S8y0.9uUC1o7PIAT6UhfpmK3w9QebxUuJC
 iD0nI5bu_fzbS78EcLAYs3.tejdw_R2.ENcO44_af2Dkx2lCAHfWmsURPMy3TdRIFK9wQcXUYux0
 fpM5rEW45S_0taEVQtMPe2giwv.7Y8w.4VHbhYJewXk45ak2O_H8SqJDutZA3NH0jwWuFgnKxAaD
 _1QP8xz65CB2UtKE09WnaLEdMMmxqsMB.DLLHFGXW7vN9STqAVb9cK_vyhtJGyvwDb1QjLA2VTiV
 g02cOsRJMyd0sBFitUkPDIC784qSzdsHODqMj6b3lL7duQLUi_K_LLRhEhNT.O2tSAxOUAgzrJCj
 sjMStT65WIhxYH2XrE1PxD5GjZMhobxnxCLgW8QlUs0.4l1qEcnElGpBT31shBxTNVBletNosGEK
 7Okt_r.EGK8bNejBShVxsEat_mK58JENr4T6s4MyMPInC1wpoTJ3CqYxHEuRSq_aJR7V8KUHhV5x
 J2IO56F_hRfhbEqvR_rLdVwvRjoXlwdvvA0DrjHTP4eNOvpasxbi_Ta7Mc80FHksioQ60C6PWQig
 QUYR0MCZiEDSJFDlghIPcXVcJihxW27r5V7UAgxpGReJt42m0CQaTUGFFnBtiLRNh6zFBz4Z7DCK
 RPIHTqmeIBJfLgg.8RC18tgEF.PdFRTX9erZ6pYCX2gZn0asuLQzjwkX0XCfa.ULNOl9v9iyRtxK
 ww77YRxvdTl3Z3h1BnzQCIPBEfKOmuD5bZdaDCwK6lMoPvmPlUGOjaKarla7JBgsdJe00g6UtFj3
 QORtP5uUg1O7wGwLgBY0KnzwHqM61zp01xzL3yb9PmCtDhW6zn03SPifG5fSoeYw.PnP7FxZPah8
 CRbvJwymUF2zicLbKhCrDLh1jOHRnEVhMM7Vm3K2qbUIzVZ1_PWghw3mxy6hgaK4nkYWqHflv2Qs
 Nu50Sz1vCAzKh4f0QXDVnJL0Ystr6xsNBzSPV6eGMQsiF0Nou1ASRE5ITbuHRr5vAkIj3VhKdzv2
 GwtMu8dsYltGMhnutjY5YUXeDOazFHbqIgX7mX463.bAXeiyluNUTzphyQfyA19zMuw6X382rNnZ
 dBrDaSv4B_A_f9ypv4_4l.xftl5VBFxUCehWMjymvKirANPwxnwdCSGtLYBctkCt7yOKHxJR3_Ur
 9qt77GMm7pnuh7csqxXH5C9RuqtWdOeZzRHhJY31PG9bWCaYmI5ZnIweM7U9n0_plz80g1KnT2PJ
 EfBpADrqwPFEoEyZmF0AYFBMvBigM6Hockr58zh.BDyanyUpbgaYNFZ10dvQSftoXv.sCKy1C0Z0
 oA0BssVDZp9x8thtnfLpeXtnlFRuCZet6ailZxPTir0eaDzqgGNin1aRHCiTOa5aVvMyHK8xyG4s
 4ytzISpX9PsUN1f2E2H0UEivKDl9zL5OsPzPEUcpu6K06Pytv5pFMztSwFSapbDQAHcjDTLqI69a
 gJKLgLQ--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 1c7df8da-ea60-4aad-8ef7-a78a43a32e11
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Tue, 9 May 2023 23:08:32 +0000
Received: by hermes--production-ir2-74cd8fc864-db5p9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 837ff3d45b33d672f05185fc55fb6f66;
          Tue, 09 May 2023 23:08:31 +0000 (UTC)
Message-ID: <74ab2851-1ca4-dec1-850a-1811e5a7e22f@rocketmail.com>
Date:   Wed, 10 May 2023 01:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
Content-Language: de-DE
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
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230506155435.3005-1-jahau@rocketmail.com>
 <20230506155435.3005-9-jahau@rocketmail.com>
 <fbfd02d5-183a-118c-5743-dee6c9367bf6@linaro.org>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <fbfd02d5-183a-118c-5743-dee6c9367bf6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21471 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

On 09.05.23 11:18, Krzysztof Kozlowski wrote:
> On 06/05/2023 17:54, Jakob Hauser wrote:

...

>> diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
>> new file mode 100644
>> index 000000000000..b8607cc6ec63
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
>> @@ -0,0 +1,64 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/richtek,rt5033-charger.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Richtek RT5033 PIMC Battery Charger
> 
> PMIC

Good catch.

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
>> +  monitored-battery:
>> +    description: |
>> +      Phandle to the monitored battery according to battery.yaml. The battery
>> +      node needs to contain five parameters.
>> +
>> +      precharge-current-microamp:
>> +      Current of pre-charge mode. The pre-charge current levels are 350 mA
>> +      to 650 mA programmed by I2C per 100 mA.
>> +
>> +      constant-charge-current-max-microamp:
>> +      Current of fast-charge mode. The fast-charge current levels are 700 mA
>> +      to 2000 mA programmed by I2C per 100 mA.
>> +
>> +      charge-term-current-microamp:
>> +      This property is end of charge current. Its level ranges from 150 mA
>> +      to 600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA and
>> +      600 mA in 100 mA steps.
>> +
>> +      precharge-upper-limit-microvolt:
>> +      Voltage of pre-charge mode. If the battery voltage is below the pre-charge
>> +      threshold voltage, the charger is in pre-charge mode with pre-charge
>> +      current. Its levels are 2.3 V to 3.8 V programmed by I2C per 0.1 V.
>> +
>> +      constant-charge-voltage-max-microvolt:
>> +      Battery regulation voltage of constant voltage mode. This voltage levels
>> +      from 3.65 V to 4.4 V by I2C per 0.025 V.
>> +
>> +  connector:
>> +    description:
>> +      Phandle to a USB connector according to usb-connector.yaml. The connector
>> +      should be a child of the extcon device.
>> +    maxItems: 1
> 
> Missing type/ref... but then you will notice you have conflicting ref
> with existing connector. connector is usb-connector.yaml, not phandle. I
> am not sure if we need generic property, so let's go with device
> specific - richtek,usb-connector

Actually, as we already switched to the connector thing, I would have 
liked to do it properly, if at all. Again looking for examples how it 
should be done, the usb-connector.yaml schema gets mostly used in the 
USB and PHY domain. Those examples don't fit the specific case well. I 
didn't find examples in the power supply domain.

Therefore, giving in, I'll chage it to richtek,usb-connector.

It's still hard for me to understand why phandle excton shouldn't fit 
the specific simple case. Now we have neither a proper "connector" thing 
nor a simple extcon phandle.

...

Kind regards,
Jakob
