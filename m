Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216586E8505
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjDSWeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjDSWeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:34:03 -0400
Received: from sonic307-7.consmr.mail.ir2.yahoo.com (sonic307-7.consmr.mail.ir2.yahoo.com [87.248.110.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A6E30E9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681943520; bh=QgwEvaxznVhbwwwaHbod/jvh/kKZgXY3lH4q0rCY3ds=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VwI0AQbt4Q21SVAwfqoq19LalICgTCbX2sgLECExRwMLEHwxowDFT6xzfQvYzdkRXbk1pGHIO007UVxsqKF8HyIPf1LGjg0NFMfaBmhNIQlifY4t0WsdF1tYMpJmWrLiqGd9rK2eQYl4KTrn0gvMEIyyzqKbR5vT4nKutyCbq0XZpp/ybaaucqqQsZZkDZjcZBfmrfkYr/MNTVefezzPSq+LxLYlVuf4dNkoEDtoq1OYwPWj9CGJas+tDJJiLw5hZIow4Y6qO1MOfCx2QqV5CuprBz7G+4FTlTUDK9YuZu9CJt+ttSFfjiKeMbvArEDpEPBy4mYPNM5bdKYPgu8Viw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681943520; bh=fEJRsbrGtVafMywGT85HUetpJNrzOlG6WcV6QruQtH2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=of0Ao8iE4VdHcab7LaWXt2AUaHhDsSJ0SGD0i+Qp9VBhnKluva/2YM9gFEyCJIDZvJQ3ZoASQDlvfkNP5cvHQIxios9r38UmOrK88E6KmR+1lwnFG9SWdaw5wBzhe68cspHBgpAq0Jf16bGvkJ7V0CgydteZ5TYo2jutqeWP+tzcPpbuxkGYJSk0WBovjMoiEjCE7krIn81hyC66XXOnvsFws0MfwGRZMQA5eBwYfWTFuC/R+2x5+7/Q8Ky5qOs86RZPWINoo7onGyjhyNriIQcJTdKg2LuMT/oLAg0HR7RqnUnIrSrL742B44tIWeRWvDlUyDtNLvDV+LlTwFy5Zw==
X-YMail-OSG: VxESa2YVM1l1UBi7CnVMMdeUyMabjI2yhujSfxTI15FY8xVT9nXwAEQ2N41OhRg
 EL.LdobvcowL3ITCt2mH_WldyMsB9B9ctIbnYUEauVKmyCb9c3HOEXOJjnqJMKE1V3H2Ulqg5bVy
 .XMcr6d3kKLi5Fn142rDiJHSLI0qzwMuT8Y6T.m7GRn4kGQwQ_l3B7TH47MAA8hH26TVRYrYbxa4
 HFcef6KaKUwoaVvn_9zv3d0pb7yZ0N_4qoL9bPY0RrFet4mt8Uquv3xP6JdCmbImHrec0_08_XVW
 80jXdeLetLq0nO4EuVvw1TZQIQ8MoZWL8YEMPuOhbkqbMPBKvB5lvfZxbTKn9TtyTajRiL4JXyL.
 nVmG1d6uHdCCv06xEOQ5AWL5H9UrV_XZ.Qm10ixKTnbtl9b1z1HaAWPlm9tUJocjwyTmbXiZqf.0
 lZf1vfySnAYtXFvUi.FyzGPSlfsO770.7mK4bH1fb18CbXBkidflUFKsykRgliwr12lCIia9ZlB6
 AGYF1iqWgy_k7neFDhr6FocV2fB5M_2u7r3NqVTW7q8.wI3o7WrPjm4c3_ZDLvXmLDOrVNgnnLKf
 FyXVsHr.OJyASBSGGRA1gatXmS7zSwLDh4egK3ZRRIX1ucS_6ZIJDlQ1fdj1AaQsnNnx..t7XXhf
 1KZ7o7bz9Q6m6lMJfPkS5AN1CZ9gDd0AXZZ8F3lmVQjjRjzUwnkpOtU1I70tCMPl8EITXNdUtZCf
 TdBAqf5eQTHgWHcKnqzbP_Z18PBISYMyQWU4oOZ2ADWAmCtHRFHFADy3jm0F2cyjpxO9gQ1lAi1b
 umhGfuoJHHNoY9BdMRzT2dI_3D4fW3QMbQuy5clMDwvuq1ZThxKR.5eu0fOVimKfTRhRbCFqAlva
 YLwIVSVnNVSUTbtS2VepiX_Fu8FF77LCUn508HgtpDm1Fy7Yc4yvatkYV6Zalyq3ZRxRcXvJcO0X
 X0RaKDOAVTM4LHsuWpA_KpopSVxxCVWLOaKK419w7LeILxdMtS62zK6VKdmsVf516gnnhOSIZZy1
 lslymiUCony4TKa47sragF8rMP1mVvfw6zoe9e._E.Bgnc7CYloW8aHABWbJKJiTwz5y2M4ll11E
 aDehcX6D7jG.QUw2RUbO_9_.SdaddRhcbovYrXr4KakXZSGjhbGSnLybZPwSs3xEQq_VKBbQzv0j
 NK1_ECBxWqytqk3cEcCVcmJkOwAsDCn1R645K.9xGaqpjbm6y4n7Znq6jhKLWOptxRg40gsgQsMP
 ZqPT51QRCLzU1rJOywZIQ7RZruXVv.BXAqeym4rtINfIG6pLQb3OB1lD4mjaOypLouITexynJTzc
 4H26ZJnQT7_Ch2ZB5UwyxMag3mOy.KOJhybeqRWa0.GEu5uKjR45Pcg1gVAYoRA8gBei6iTg8b9b
 fwGOS2sOFo2opWnx2NaN7SCZczx5xv7Dfct3Sr1k52rrIrCSbT2WKTxXXsNF6G1wocx47EMMvCL5
 PUmoa8_1tmQ4H3VyPdhMbg2MedMNQrqww1.vl6tPKLBpbIvMsgCcEW3R.AhM03Z6koVDXv2FXc7U
 GlopzlDyUb_bNhybuavz1bCF7kXqgrKkIEthT1x38P5Z9hg.FaV6hjhfWsNMBpet9vSAdEKqWvL5
 QeOmMJPiXz1OUYVo0aa3DUj3.3rXk1t8mh4t8EH69QavAbgswPIfCSjldRESfxjAHDVmAIYqcBE7
 f6cfKBazKUZt_RJuHDa82FMsxcpT5XLWaf49XqQxnylVWb6eXkZX98Kmurh0fwbTRzUyEEy_4eHj
 cnLQ_gtHm82izJqlffIGWhxE5p7XYnaD9gI.hV2h3J6lOs5aKXBRc.EWJfQsxbF6rt1..GfjqFYY
 DOjF1DUJPjQKVz7uWKtxwgIJhk8SVwGOr0Gfcf4jJqfJucOcUEbUh0_6CPWPQrkrIJMt2vbmFbjk
 gF9Wbskeyk_3qDO_VPGyTXkk8RJ10eC3GInssPsXFbXzJyAfrWucI6orJa2qC1OJpqPlXGKjdV9J
 wpX9qt0lVyzty0jT4HcVKnpIGBCD.bUI7uSNPjVvOl1SZbF_u6eL.8Q23HDy_neMrI7xM1KiaaMY
 A7DEPos7sr2XvgALthc2N9f24YYN96m_ticET7IduPGToB01Z5p5e.8YWz9M1RNXNpHjSqopU9YR
 4RRw2PPzJUo21iRzIbmVgsazpNfOCWCbdr44W3DClOfdG.wm3KIyzb6MIQmKxgE8GtRaBMqjj04h
 zm4BwTbpuCtG9BHsESXkht6rJlEtpC77dRD2xLKl3ERbqbcAWlllfNoguaVI8plqEi2uwOsdYChC
 _0sWpVxBE_lESUb5R68_MZ7Gilf0DsUsw
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: dc59d37e-63ac-409d-9792-67e4d82a1f8b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Wed, 19 Apr 2023 22:32:00 +0000
Received: by hermes--production-ir2-74cd8fc864-jl5bm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 318f31df962c705776d30bee69907fb4;
          Wed, 19 Apr 2023 22:21:27 +0000 (UTC)
Message-ID: <b044de68-e9d7-ae23-a2da-96df78f95821@rocketmail.com>
Date:   Thu, 20 Apr 2023 00:21:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/9] regulator: rt5033: Change regulator names to
 lowercase
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
 <d4218947e354aee45589acb1060ce41727a26750.1681646904.git.jahau@rocketmail.com>
 <19ceb0f6-1225-c8cb-1469-3d657e66d171@linaro.org>
 <e6cc8658-fe93-c2c0-603e-093cdafb3cca@rocketmail.com>
 <f80fcbeb-f916-63da-a5c3-f80f6315f3e0@linaro.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <f80fcbeb-f916-63da-a5c3-f80f6315f3e0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 19.04.23 10:40, Krzysztof Kozlowski wrote:
> On 18/04/2023 23:24, Jakob Hauser wrote:
>> On 16.04.23 20:32, Krzysztof Kozlowski wrote:
>>> On 16/04/2023 14:44, Jakob Hauser wrote:
>>>> Lowercase is preferred for node names.
>>>
>>> This will break all existing users. In-tree and out-of-tree. Where is
>>> the binding update?
>>
>> In my reply to Rob's comments in v1 I was pointing out that this will
>> affect an existing driver. There was no reaction.
>>
>> As far as I can see, there is no in-tree usage yet. Though I can't tell
>> about out-of-tree usage. Although if there is, adding the rt5033-charger
>> driver might already causes the need for changes.
>>
>> Well, to stay on the safe side, I'll drop this patch in v3 and will
>> change the bindings (patch 9) back to uppercase.
> 
> Your v1 binding patch did not explain that you document existing ABI, so
> you got comments like for a new binding. This is not really new binding,
> is it?

The bindings for the mfd and regulator are new, even though the drivers 
are already existing. Sorry for not being clear on this in v1. This is 
due to historic reasons of the old patchset, more information on that 
further down.

The current situation in the mainline kernel is as follows.

drivers
-------
rt5033:            drivers/mfd/rt5033.c
rt5033-regulator:  drivers/regulator/rt5033-regulator.c
rt5033-charger:    not existent
rt5033-battery:    drivers/power/supply/rt5033_battery.c
rt5033-leds:       not existent

bindings
--------
rt5033:            not existent
rt5033-regulator:  not existent
rt5033-charger:    not existent
rt5033-battery:    .../bindings/power/supply/richtek,rt5033-battery.yaml
rt5033-leds:       not existent

The reason for that discrepancy:
RT5033 mfd, regulator and fuelgauge drivers were applied but charger & 
documentation didn't make [1]. They were submitted again but it phased 
out at that point, last known state is [2]. The LEDs are also a phased 
out patchset [3]. The fuelgauge binding was added not so long ago by 
Stephan [4].

[1] 
https://lore.kernel.org/all/1421899601-19327-1-git-send-email-beomho.seo@samsung.com/T/#t
[2] 
https://lore.kernel.org/lkml/1425864191-4121-1-git-send-email-beomho.seo@samsung.com/T/#t
[3] 
https://lore.kernel.org/linux-leds/1448446948-13729-1-git-send-email-ingi2.kim@samsung.com/T/#u
[4] 
https://lore.kernel.org/linux-devicetree/20210517105113.240379-1-stephan@gerhold.net/T/#m197b5719a5d37b17ba4ff9f3b3ff4bd4efcda71e

Kind regards,
Jakob
