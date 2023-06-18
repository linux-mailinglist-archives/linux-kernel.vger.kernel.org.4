Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC488734712
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjFRQt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 12:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFRQtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 12:49:25 -0400
Received: from sonic309-25.consmr.mail.ir2.yahoo.com (sonic309-25.consmr.mail.ir2.yahoo.com [77.238.179.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92909E4D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1687106962; bh=1byxmKsuwVtHNKVjs0CfYPPIiLgXwsmmbrJRN3DT5sY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=uha/SwH7I7rs/r5ZpEHymasRxI2NNC+1btE5cJbHnBVi/+2EP7LDhN4wP0wDJUYFZOHGiyqYc6KUZdGxbK/K5mHGpV0F5Op8ZtJI8ZAGhObL62malGYW6geWo/PDkaNG+bbZx5AixdS/ovGfmzqmzPLyac5wc/8HU47ZdWI6bRFyGu2FAmtdOxy+Zs18pBuCIB3ns2p/sxLaJI9ag/V6BGpq651v+Mdo5Mt8drysFdU2I6OIGYU0/6jEiLIUIkufSuDABDMOHHFDT5favNAZie9mABoyfHlT/MRyDTqRa4+qr2JkIAxUZsyjmSV3WR7UptRCAYk0k1y5Sie2SoaKkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1687106962; bh=aJFsOPX7ARn/sObHD13lQRHiRpseUebdhxOsSCSQNu9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=pnZ2jomD+qitYFiL0hkl3X6RthizvbE/SLUTXcJrhYl98NczZJKkXP2bQI9AHkdXsajDhiSPhjsTpHboF6vn+fdmACCYu9w2UGz/LDqZ6nb9z5FCLXaI13nX5BDu7uEIB6oRBBakArIL09jTJT16NJJNz4/T2nCeQkR2MhZqmM0DhM1B62TOzJd1CmhhRYskRyVTkPccRGNQPRNzJ1Rz58GN33Z8ZQOLJ79mEKObXjTyRCepkukeVHCK2OG/v3m7JuX1Uugj2ozeDjpTB5fzhhtQI/9RqdLe6mtSaW/y0vyIBmpsWssIa6/BD1irrJACUsSHr20N1X2YKExjn6fxcg==
X-YMail-OSG: y1.8yFUVM1nNIPH0bembKj4.xSeiOLT4LwMSpl8Fo4EH0ZaQSwdfamb.Rx4slUh
 7baTXb1K7zM.3kQpzH8Ut2G1xug_uq4zseHmxx_kanDYG3syXd1cOAe1zyH779ysxCKV9YEnSW1l
 FCGTHDUJPGzqh3qneYpBMye0SWkONmrU6C3NM3p.7PWscqnII.v7kzwtzsoSbVl6rKH3opYc4.Ol
 Ohz_Xgaltk8D4Lo6ca8Ms4QLPF9scTKV.X03OZUFxAIsFopmBjXG6d1De88FtZ68aLOuhYsRcMMP
 W6o01rAep6TzOWOYngW.u6xI_VES6dvwhkkFkWq8zduOGQkbcOoqB58Pyih9bmPYkA1igg1dneck
 Eabn95qIKME_eoi1yTKOREO5HigP7Mt84bwGUNlJmoi1AYjWWqxIU9DC321_K8o4P.6IzBj1mJux
 HG2aWh7eWwnl0gQY2yFmgZ36Bljt1CCsu_gMeES_cSmbukeRWhD.eApRt14XcXvxiX782ubfprf_
 o9MTiiHmF6gMf5Ji23L7DuSuSOjDQW87703aR1sTlbkComoBFSkeGy3jNP7tx9Pazqg72MUv9T_A
 0O61VhZpoGjllLpcXmAyETtli1E415ZnH.bY_.RrS2B2v3GRU5vkMoSvk60pZ.abI6X1VGyL3oHg
 TlOOnSG.fl1jdJWS7MsOfDHdDqOmtFvuxKV35CRMVC5pLscK6eiWVEw3fqxqlhlbLja8yAC_B1cx
 _7i85Auca2KrGtsByuXX.0VUKb2a4EtJHvb5Fl49jfleS6skZLLRrpO77yNK35xSBjdfAebBmkcs
 Z3oAvk6suwoUeTMxfKUCctfZlhcmsaV3KQCwuosh73jegIX4P6GqP0AKbreH.eYFrE154.FNQwxE
 hBIgLNxlJSZmxfrCVoz1JZIPxrQJrkLb39vtXnCZNWQoPwV3WaEEcnsdFS_wJ_IGwoAONTT8fYnR
 abm5fbjD.HHpj0mDbSmbFEtHu5VPSC51I8C_uwU7d.bYhTtcEOkW7w3luHruedxZUafW7LC.XvRD
 CzDl34SGHnHONDEPffx7eUsK1hMZb1B.bWJC_OXwBj_r66M5ScCWHZ8ebwUfHR5AY26H_nx2.Mys
 dirxSG69kKE8aBl0mybEDi.9g1yF9V2y9cXK1HrNWg5VYTZwAbW_XcYmpwZJem4sQgxti3jYFyxv
 XS4JUypxm88YYDKOXGtBlvePamRdNN4hNpBJJzd3TJaml2gChrBHE0LFBDBY4yfj9nzKTBNzGxks
 tRA8nkI.BL5InLQY_gceaK0BHF.QqxhWFNVod8EpDBYO5L5cbUqcoeY__sbHxu.meiZKhHUNVeE9
 v1Btbe3aHDeY2Wu_aLTleBkcoJgyywzLazzK4QoptBHXrZbWGRFvckfa_F8Z4HlOYCJyCnKN7391
 AgHfUWrH3cP6KyH51olSlCAchgSjqCl8a58pZ0cudm0EI4qTTdnRfFWL6FlIU1LqRcecGKr3ZitK
 0FrSEVnDqHAUz01DWkb0y8Xj6znxBorKK4K.LN7lZAk53NxixcfLm1yzwJw2oYi4HQfj.asZl16Y
 FKFYkbv7ROyoeRRIDdzye7qX89TkptfquKr9aZDl6YHjxKNmhQqDixsD4iK30BO.4m574LOB.xmN
 QkOq6RQGdy2mVEXQ1DXabbJuf7m4EYzs.IJ9hpdR6uOCmhquk.CPfXlKRmyIMCa2MT8fGs6.Cu1M
 nIbdc2KXQLcuon2JxEacK7yi5Oi2vMP6fyNKimQIXeOu0U6IZkaB8wvDPZFlOZDg8VYS8QoFJlLP
 uZSr9nszMXwNPb.rMU1DeJdCg0aJKeIo..GDT6rFsNbpy9p9h.GsEMENJ5oCHEe9JGL69xCPuTar
 Ba0zlgJdJI7i5IxK1XIDz_ZGr.fQLHwhYg8HSaUuxN89hG1RVZPFuozz2BTOws9KmNhKsxngAc1F
 HnF0UuNQ.sJwO_VOj4wEfSbL6mdCBXYXA1y38RryQhBdvQoKPS27J1rvW02EhffbqNK9ufmwEd.X
 VvZ63ckWZLIVlShmNdOe6R2IcQrpsDJ4f2PrweVTLRcNHbWvtpzZrupUL2qlF0D1WR6zOUOJ8ALu
 XUFhSZqpETKd_Fjt3YO5Z7TL6y1CjbofIEDyv.VkTyzckCVbipbv_f8NV6.o4ivr829cFn4G1jwC
 bp3ZhyXiSlUV3Djteo2.RxciRbsFTTi4itNpdiBCPfFJ7Wi4JzSQQLctQ8Wir7_ooQwmqbYDJ6MW
 3KvS2_l8AhA5PjNJCM6JsP2PQrKddsvL1idKtjCKyyIFEu2KCBjTFknxeqrBOrxFnk2J7RMwubGz
 0KxZ7L7G_HTpsmQcak1kuLNTdp65MF03k
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 0a8d3c80-63d9-43ac-ad23-34ea945a5cd7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Sun, 18 Jun 2023 16:49:22 +0000
Received: by hermes--production-ir2-7867f454fc-z6m77 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4eb4576de48997a989d0f23ab4fb0b6c;
          Sun, 18 Jun 2023 16:49:18 +0000 (UTC)
Message-ID: <ab3e475f-27ae-e718-60bd-cb22f5070942@rocketmail.com>
Date:   Sun, 18 Jun 2023 18:49:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RESEND] arm64: dts: qcom: msm8916-samsung-serranove: Add
 RT5033 PMIC with charger
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230617002934.39408-1-jahau.ref@rocketmail.com>
 <20230617002934.39408-1-jahau@rocketmail.com> <ZI2_565RFDtR3Sa-@gerhold.net>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <ZI2_565RFDtR3Sa-@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21557 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On 17.06.23 16:15, Stephan Gerhold wrote:
> On Sat, Jun 17, 2023 at 02:29:34AM +0200, Jakob Hauser wrote:

...

>> +		regulators {
>> +			safe_ldo_reg: SAFE_LDO {
>> +				regulator-name = "SAFE_LDO";
>> +				regulator-min-microvolt = <4900000>;
>> +				regulator-max-microvolt = <4900000>;
>> +				regulator-always-on;
>> +			};
>> +			ldo_reg: LDO {
>> +				regulator-name = "LDO";
>> +				regulator-min-microvolt = <2800000>;
>> +				regulator-max-microvolt = <2800000>;
>> +			};
>> +			buck_reg: BUCK {
>> +				regulator-name = "BUCK";
>> +				regulator-min-microvolt = <1200000>;
>> +				regulator-max-microvolt = <1200000>;
>> +			};
> 
> The "regulator-name"s here don't really seem useful, since they're just
> the same as the ones already declared in the driver. Can you drop them?
> Alternatively you could assign more useful board-specific names, such as
> the CAM_SENSOR_A2.8V that was used downstream.
> 
> Also, I think it would be slightly clearer to prefix the regulator
> labels (safe_ldo_reg, ldo_reg etc) with rt5033_. Perhaps
> "rt5033_ldo_reg" or "rt5033_reg_ldo"?

...
About the "regulator-name"s I wasn't really aware. I don't have a strong 
opinion on this.

With the downstream names, it would look like this:

regulators {
	rt5033_reg_safe_ldo: SAFE_LDO {
		regulator-name = "RT5033SafeLDO";
		regulator-min-microvolt = <4900000>;
		regulator-max-microvolt = <4900000>;
		regulator-always-on;
	};
	rt5033_reg_ldo: LDO {
		regulator-name = "CAM_SENSOR_A2.8V";
		regulator-min-microvolt = <2800000>;
		regulator-max-microvolt = <2800000>;
	};
	rt5033_reg_buck: BUCK {
		regulator-name = "CAM_SENSOR_CORE_1.25V";
		regulator-min-microvolt = <1200000>;
		regulator-max-microvolt = <1200000>;
	};

Dropping them would look like this:

regulators {
	rt5033_reg_safe_ldo: SAFE_LDO {
		regulator-min-microvolt = <4900000>;
		regulator-max-microvolt = <4900000>;
		regulator-always-on;
	};
	rt5033_reg_ldo: LDO {
		regulator-min-microvolt = <2800000>;
		regulator-max-microvolt = <2800000>;
	};
	rt5033_reg_buck: BUCK {
		regulator-min-microvolt = <1200000>;
		regulator-max-microvolt = <1200000>;
	};

I would rather drop them. The first name "RT5033SafeLDO" doesn't add 
much information. The other two I'm not fully sure if they provide the 
cam sensor only or if there might be other users as well. Also it add an 
additional set of names. When dropping them, the generic names SAFE_LDO, 
LDO and BUCK are taken from the rt5033-regulator driver.

Unfortunately, I added the example in the dt-bindings with the generic 
names. So this question might come up again when someone else adds 
rt5033-regulators to another device.

For the phandle labels I'd go for rt5033_reg_..., I already changed them 
in the examples above.

Kind regards,
Jakob
