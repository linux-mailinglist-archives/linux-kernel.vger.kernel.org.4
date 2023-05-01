Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1E16F3517
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjEARfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjEARf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:35:27 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC3E10F6
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682962521; bh=04OPKsj/QXXjTdmsQM9AQpCh3NGap/ezTNnwVf4o7A0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BOTy4ygXDLp0GINCVl1Tv3QImHmX/M3+9YqcoVEoZwL0z9/s20ETHAdEfw9flJXQJdJ2ebTV87qxvy8cacOVdDoTYQhc5SEUyHteuJ0QaSf+oI5V4MW0ktg9k2Vl7L8Wx4JL4yGiqfvN8Hf+cz7DUsCJZB3ib+njTysLc4WEGuI9S2guryuBieVz4VpX8XXUx+ppXITKTeIDXbWwEn/fSE9NDGNa1LSC/u98sQ5/MI/tnTaxHk6cv2fRT0pR3TYIxtmOPOpaEMaypwFWWVhLjlQfEc6r5Nt+9TextlJ3QGDSAh3946HUpW24dIHNowQ9yBeacuLjehrWlU+/BmJ6Mg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682962521; bh=yqxcxKhFdH+GYt/iBDDt7ZHDKTJivpCj4DGIO7xiYez=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=abqH5tWIhKr3fHy6EaLh371VNF3xOpTW/i10a6A3IR7Ap1T5B5VI2N662cNyazwjSAJbMeB+jkQVRwyUlbxiE/S66eGIk2hPc5mJlK+aNJwbNmY1J1rb1Gh0jHxR36CmWaKgeaX55ApVcZlk5GmWkqLb2rffGSLetxTC73yn0nML6lNTzk5LdSApy1fu6M7ii9lF1UjqKdVfVOsKyAqwJEDZMwR0G+AxILGx2MdNu3y71C01R5WAUAiqnGzAv4CKKxN2e2MpjQLVCt0a8Xgk572e5QryCkbMGT+7zbl27v7IbBz0usmQ5ysn7GrBOYNpSB0aLtcp4qeUP7MKnzq27g==
X-YMail-OSG: PBmjzDIVM1mkBY8P665SrsROmABT91m8vWhuKRVhFQiwzNNw85_qX5Fxp2IZ2us
 pRwvAazripnyowzY9UpTfgWK1eFqrGb7yUW.YDU6.3i5OFo2KC04Oqj0to2MELkf2QcBmL4bhl57
 qJ7Ik7wdb0mcmvs5zY_X3pYpr7mT7Tvkk4aT2XyGHycJgHQ2qPxaqL8dhrCTkfJzazZDvx3_lFS2
 bV74h2F75a6HmQI5PRJdxKb.C46jePfyswNvfDiv0TJ6a8OOJqPk8oZTE_bUhimyUaGkWRNPYSJ2
 5o2kCQfh1tlWy4kuw99Lbrp7dd08xN8Twf8wsmTOpPK9k0cuFCO2D61ukprCybLFBnNiTyxnRisF
 TrQOZ8Eou2aEWSxnkVGrTT0Rw9N.f13KQQKMidMnMqKhg.DRlCp7Wzl_LRwnPkXuM.s6gGedR5Nd
 Z8O7ncxFpBLxWfy7rUYHSabzqIr2UXxGttkW6hQM6XIWF2ZkV_sp2cSY_3BVph.hGXReFSyS_cXD
 wd6XVj5MYv0En2NaAHonX5hP2nazAPA5WXqnirkZdrgl7i2g_fLdYWLD6MbN6iKwJycLVzAwKwj9
 WSO6GU9B7A33WiqHKB1sntHYAWAprKlv1WyLrZ2Ap9HtFAMqLX9uE0FOX0zDO8mJxchPvOXJ.gyE
 h8SJOPMkOweFqmiJ9jBRnyrAKNH_axbaP8CCk4GXGg9enn.hpMkiY0EodnHScepyitj8WIZLwLQx
 REbTevq_yVfp6fRaSqma6s702Ap1BrsbJuJCPJ94Pq3vi57XrYetQUr0lPxSyAUTsOkWocrVlHI_
 LpoXvkNfT_WZdmPhw3xsLxefITvcQiecX23KxN9E985gPEy4.AYkv37QHe805W.fTAy3.1DBA6Jj
 5KJ04mypFIesnpuJELkMJikVp5IKkfwvGmE.uOetgjvGnhMGojAW2tjAkPOgWw.2hancxXAqd4cQ
 t6.MaCFuDg9_fzrM7xlSpb4.YMY38x.dFFLznK92kmns4xyO7Sq5qLem3lUyzW1naIL0_oE_2Lyd
 YZpzDWN2Hr3bxOeGZmAuwsnpuOSCgs9K15WjlTugFWnKmOBw0IPhSLpetuqurFQ8uNfG0RikPRTF
 rhBQjpc.bZdb5bKd7QkLw3D7oeX0nPU6psvNmOAOh4DHM.YpjoQdqAHdp19mapG.8Fy3kigaDhR2
 j.Hb_l0NFad22Oj36GCbH78yak84bLYCs.ZXoZIo0dYxchkXkY8Z0vcGmdbj5ivgcYLnKOr3Ft_s
 yY4YuA1WRQo10LeJ0ds5x8Xx5WLdeySnKijEnaGow7KIld7LCVwE5OKQrxPRT5Jd9zUFp7mbRrCx
 8XysNajw7A2An9qJLososL8VXA9N1eh0LccH6q_XknKfv.C0D0kT8sl0MUwXfpEdiSH8tKMyCQ1x
 D5l9zRGmpA4VvWHCzDNLnADt.fe.GYkG9_VjFx20ifYXu5DKDrAmJuRZwhSXwqY3A46fiCxtsbLr
 we8dK30lcsXpAw4qq6oEkAiX5HW1s.n7JtK5AmZx0Dy6oOuW8EEVUBBoQ3bZC1Z1ZMeBP3tg4SmB
 OZDCbGXRL4sMLdEUYeNJeXtspF.QwdqsKgHlWncbGan2yHYj95ngy6pudnEq7kCE49PumLXGvnwx
 98nKzSMp5l17wIIxuJ1K3mm5jCFFAt1NtV5QBzMeuH42AR23zUgor2s15wZzk62YEWDSIkffNEa3
 RuNYFO97cawtscRR7NWGtU0ErWEWfxOg.yw23Zyo91X_qc7rO5u8nhgt7mxXMu786sgRi1gsFRAQ
 UgqQTya1fY3SubUXJGITSSzuYN_7apYeTYye.2osppSnEZuFU9sVINx4Ws0Q4V.410XrzyNwAv4x
 Ig1tscc4N191l01TRSnhUf5jxllYWxC2fXWSBzkVrkHESbmxjBwFu.4sPGVgKcNdZxmXJW7zJWmo
 8fCBMwYJwHonvsT9dC49t1zabFVIU89uypGV0uDHU1CjuD_DdE8wQHh0UjZvX93GYy8OH5x67aoj
 zc3A7Tt.oIUCY_ys8YTlQYIthDV8701Bia_gJjgfSO5Zu1IRrCTX5UvHdQsoZ1g5EImYSqfqDbec
 Etj9GjA5e3FhZJDNbAHZxEauFrIIidJyTxu1sSqGV_lnlSDWbcAKBnypbNdkTREzujYrHLAm52ox
 S9A9xifCpbwhOJGOxeeL5IK_X.E8DxkmKRGGSmkHEnZVJ9ABwJEY2yNjLC8a7fgkAxkJwzU7X461
 Mou00q7JGcvGHgeVK_KXWZkYKlfMuu5Wu3ey9tDfqPIXT_wI5BqpVlX0LoEvmW6KmUo7x2cBina4
 5_DnYowHqf1R2Gptax_Us0giKqyLxQmhZMjcc
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: d71d16b2-9418-40a1-bd45-1abcb6944291
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Mon, 1 May 2023 17:35:21 +0000
Received: by hermes--production-ir2-74cd8fc864-9w846 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8f3be1312e7b717e7c5ba74fc348ffb4;
          Mon, 01 May 2023 17:35:16 +0000 (UTC)
Message-ID: <e9d75e57-bdea-593d-7b05-136c9ad2e2fe@rocketmail.com>
Date:   Mon, 1 May 2023 19:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1682636929.git.jahau@rocketmail.com>
 <5bd8b90713a61129acf292a941eb7fb5ccaa3db4.1682636929.git.jahau@rocketmail.com>
 <1d187f41-ad9a-4e82-8557-20694a8294d0@linaro.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <1d187f41-ad9a-4e82-8557-20694a8294d0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 01.05.23 09:21, Krzysztof Kozlowski wrote:
> On 28/04/2023 01:30, Jakob Hauser wrote:
>> Add device tree binding documentation for rt5033 multifunction device, voltage
>> regulator and battery charger.
>>
>> Cc: Beomho Seo <beomho.seo@samsung.com>
>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> 
> 
> (...)
> 
>> +
>> +required:
>> +  - monitored-battery
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    charger {
>> +        compatible = "richtek,rt5033-charger";
>> +        monitored-battery = <&battery>;
>> +        extcon = <&muic>;
> 
> 
> Everything up to here looked ok, but extcon is not a hardware property.
> Please do not mix adding missing bindings for existing device with
> adding new properties. You should use connector for the USB port.
> 

Rob already raised this in v1. In patch 8 v3 comments below '---' I 
mentioned that the extcon phandle is still there because I don't 
understand what to do.

The devices using rt5033 I'm aware of:

- arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
     used by:
     - msm8916-samsung-a3u-eur.dts
     - msm8916-samsung-a5u-eur.dts
- arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
     used by:
     - msm8916-samsung-e5.dts
     - msm8916-samsung-e7.dts
     - msm8916-samsung-grandmax.dts
- arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts

not yet mainlined:
- arch/arm64/boot/dts/qcom/msm8916-samsung-gprime-common.dtsi
     used by:
     - msm8916-samsung-fortuna3g.dts
     - msm8916-samsung-fortunaltezt.dts
     - msm8916-samsung-gprimeltecan.dts

They all have either an SM5502 or SM5504 MUIC (Micro-USB Interface 
Controller) chip installed. It reports the information what type of 
connector got plugged into the USB plug. An example for the devicetree 
entry can be found at the bottom of 
Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml [1].

Documentation on the connector binding you are referring to would be the 
following, I guess: 
Documentation/devicetree/bindings/connector/usb-connector.yaml [2].

It's not clear to me what to do. To my understanding, in the devicetree 
of the device a "connector" node should be placed within the extcon/muic 
node. Like this? (Connector node at the very bottom.)

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

		usb_con: connector {
			compatible = "usb-b-connector";
			label = "micro-USB";
			type = "micro";
		};
	};
};

And how to set up the rt5033-charger to retrieve the information of the 
extcon/muic driver in that case?

I was looking for examples but didn't find anything that helped me to 
answer that question.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml?h=v6.3
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/connector/usb-connector.yaml?h=v6.3

Kind regards,
Jakob
