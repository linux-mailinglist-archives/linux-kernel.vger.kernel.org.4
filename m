Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F95D6F1BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbjD1PnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345910AbjD1PnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:43:02 -0400
Received: from sonic310-11.consmr.mail.ir2.yahoo.com (sonic310-11.consmr.mail.ir2.yahoo.com [77.238.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48EC26BA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682696575; bh=EoLfXSDv/zyZS47vEzGnZaK948dl5CyaJIq5euI8was=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Lrt5RKDcj5eAPMNeQPSHusCxFQH+GKJJOI65obZ16kLjgkwrX5ostZundiHB6ShaJTH9CHhyTdJLCEYWAUtpwKWkQqlvBP0V+x6UV3GaICfUtUZ+mRop57heBr65XSBY5b4onlEemGQnDhTwLjwcdKWj6J9zhFzFzO8LqNcPik+R1hVwBjxxPa7KOGfqMs9BWYP+PRgyEaDcFy2YNS8wfJm/6xuVf9yVm6Q3APf0FWNZRunzv0tgga8iuaqHdobMFmOC8zvlFKq7SLOTYdnY31UD2U8QNELMeaBqActqju846Ggf+Gg3o/b/7//+Y24eH+3X8NjHy1eMxBsap40VcQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682696575; bh=U8xh1lxtP9cyvCWWcA2tOijUUssLs69gLbCAewuqCi2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qQZqX6Y4NQMxFbi0qtFYIexg7PBbXbr6WgdJJiggvJ+kzWHamW9UH2ZTxbj2egTKXvl4nmJiwfWpcKFDCIm5Hq2e+hKcd/nBpQ9W+qWxtlRei3IvX+SORn9yYmlpnt41oJVHp01Npqkz+mz5Wv6w6CUmbxkUn91cWrIFvxjGU91EY7mnam92Bir/y+4XcjvY5VUswKMoAkH1/J93lGLU51sT7fMJzk+VPuyIZN44OBaifwnjI+3JF3fWbC5/thz+P9xWwHqpzOJLfJC8Cqp04v8ryl6+dI2/fZsHMUR/BonDTEWSHA51kbFY59y8opH4xPlKe3sy8pgxg0I4JvY4sA==
X-YMail-OSG: SmtURBAVM1kD89kqoYNyFN3qux7qyu9Q004abrxiXxC5.1q_hHeNu9_PK.KbYnU
 HpT4aBsF1rx7I3lWgMzCltSqJaxQeAgSZ8JGR55tPco6Wz.NHpkT97NKTP4e8ENON9jf8Py5tX.k
 Y9UJiG5UCRZi79KnCZKYh9QCEa2yp1tZ8723T_6yQvFWYGPi6G3vPqv86Fz4Ko3Wx7XKwgr_Vy4B
 hwjbvaIrSWgYT5fn3pMryZlHzbgYtJ6NVJ8ArhZxqifsN_wQRLDtXMss4MwnDCffuXZhgpKSchte
 lGJU2sJmIsH_0rW1D2VIl09aoxlGWng5VUDePC5DLnYtdTKlKjM5xBWGjS.M7BZhLIopsqnFqUsG
 JlF81hMkL1PmiMhhCWTj.iZnp9HMXoK.7NdY8tdm6QmfHPwjYAxcTTk_Sr7kOMAYCakXvvuuEZZR
 Ykix8OcAlfNa6UqJ3Fto4SnopZY1bFldZNV6v56V9P41rwtfVPqOGi44UpssSonzyr4XCzczQgpX
 0bJLNJqFCZGwq1uosxYX0WYXLFqh1DqNrbODycZLpDMrlq.syq7QH4Zow5P73CydtWEQMNo7bRvQ
 tggBtmlUP_a5uILCPSInkeOsujqFCsn8ohoxna98FHYnF_ApMdUeFw1hMD_dyG98diTU2Tq1hUWh
 6Cig9cy5ArbLb50uQAIKqkQ2AlFz4jMl1Ge_v4f4RwRXhZ.jdO90vQxXpp4F.EuxTl9RO.x.IBqk
 JUjkzWkm_47zInpfEbljhLerBIxiInEhIxvFZYZGZlNaIPwPUYGwNStZ.ISGu33KtnQoCwE9NJY0
 5th7IMh8Qx9c5rKderde1gtFF0d0M6G8kPP.3GYGV8jxfvJyx._93rdRzgUa73nyeq1rhe40KhiM
 rNkezIjK60kUVZpo2KYeZsXBaSdQmv2ryGmWT2gXQ5PyjFrlIexKQcQjLY6lMapyMLkw8VLGcHRV
 E94GkQSUrTgoGUgpA9TgVPfuvb6nC4QpY8JJxjETCmRMUmYQ9cjE_FJ2G5ANx0LgRJ2UyGibUHks
 16PwCkwus1kNvt81GB7J8BQvbSXJJHizUUSQD9bJJT2NdefwW8E8mBcd1oKdToxCkGcZh0jPAwHl
 VZJjQqYaCntZzmz2LlW3Y_lr3hq_6jEoDY3nN.LEs.b4sot9MKIzfn4ZXW47iLIWkrUBoREj3Ziz
 Dud.wmva2oYA0uM_LCGyaxqW0PPHNfYARTyn.omqQkwiNRyW7IUjOUfLKKgWKZm1wCa6nPzokfWY
 JnmqZRYCG1ke7v92KoIEgAuTJChrgKXsCE1inwJFCGk3x7ndi9HUDvg4oBt62nT1oDUbiCXPpgEM
 tCJxGsm8Q7NuDvuZOUb4CyJe265CEAWUzWhDSg4vq9rqn2fnKkZX_aT0_ErlVYG9Kzqr8x9odggi
 UWljWQ.v5L9uNwhrNjwgBnadAwQyfhHCFk87Q105F7r_hEsN25eouiGbdtTxy7JEOJvK0QEHE_jf
 Ip_vAHJo6YjqG7HZK6IJoLrTU1l4RgyWW9BwnOuOPfqmsH_S.enRUQbKOZ7fE0eJVUBeHqJL4nwK
 G.iUC2si1JG.X1fb.QrmmK7XWkenV1zAL6SBhv6cRe2hdob9HVugm.yIHJ.B0o_tPlwnmo7kPdW4
 pb5j9.0HBiNO1ids2vgJuINe.qPz4wiAiT1fJqX77lGMxTuAhQzfRx0FSdVFjudSbofZl6tlVgWb
 jPyAl52TdHdFgx._DpzE0BhhQOZi9YJM5SYksjmcr.mjq0FIx.kkOsw7lgRQXYGw6TO41DtDIyRq
 5cHeoAz3.yxnNSjfT559aT6jmWvjxyOfFWXoWrInJGUWZ1welUZiXYNMe8bzd2Rv2hhKeIOrhOyg
 gDowPJ6CRz_7LhNK0vK0.fEo.Su.s4NEfA27ZXDTckTFSdpxqZXlzz50_YFOJpihH5b8OPCy9Npw
 HBnikNB5lLOINpinb5.hSIaDic4R48SRPN0k6jb4V.fn_uU6mZfP0CNi1gUY8al1fx4ARwDv3Adf
 wMIzX5jSxTn0ZozfSFEXg7zXLsmxGSbqm8p6P8ydtaV.HBlbXBZBxLJexSg97eXKIc0akjX8V7_m
 s6frptHMBfxDDjlRkAOvZCvZhh8z2ZB8bhupeF40XABteeVzVwsB4INQ5BDHwdzkXs_Ttlu9S_Iw
 PJM1I6FCGOhRH0aEXC1lEi49gWgsKfbsjYCnajiM_7VWxOovRbGZ_QpfkgVJ.NqtBTB6Rafo79oF
 9HOpr4EWqVLpgU4volbS9EoUoCXX2.TIZCgPpVm30gXjzT7VYPRXSRsK4AYzOeIMnxIpKfWiCzOj
 UxEQ2lLk8SA--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 537d4aa0-383d-4b90-8a4c-45fc6f728880
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Fri, 28 Apr 2023 15:42:55 +0000
Received: by hermes--production-ir2-74cd8fc864-29g5c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c7f38f8d48bc9388ec23d0c252031f80;
          Fri, 28 Apr 2023 15:42:52 +0000 (UTC)
Message-ID: <0d20da8a-3d25-7164-65c0-a6f5763473e8@rocketmail.com>
Date:   Fri, 28 Apr 2023 17:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
To:     Henrik Grimler <henrik@grimler.se>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
 <ZEvaixFJGk/Nr1m2@L14.lan>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <ZEvaixFJGk/Nr1m2@L14.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henrik,

On 28.04.23 16:39, Henrik Grimler wrote:
> On Fri, Apr 28, 2023 at 01:30:11AM +0200, Jakob Hauser wrote:
...
>> +  regulators:
>> +    description:
>> +      The regulators of RT5033 have to be instantiated under a sub-node named
>> +      "regulators". For SAFE_LDO voltage there is only one value of 4.9 V. LDO
> 
> Is only 4.9 V valid for SAFE_LDO? If I am reading driver found in
> vendor kernel for SM-A500F it seems to to allow values between 3.3 and
> 4.95 V [1]. Same range is also written in the devicetree for the
> device [2].
> 
> [1] https://github.com/msm8916-mainline/linux-downstream/blob/SM-A500F/drivers/regulator/rt5033_regulator.c#L109-L114
> [2] https://github.com/msm8916-mainline/linux-downstream/blob/SM-A500F/arch/arm/boot/dts/samsung/msm8916/msm8916-sec-a5u-eur-r01.dtsi#L148-L149
> 

You're right, the RT5033 regulator SAFE_LDO is capable of more than one 
voltage.

In the mainline rt5033-regulator driver, however, for SAFE_LDO only the 
one voltage at 4.9 V is implemented so far.
https://github.com/torvalds/linux/blob/v6.3/include/linux/mfd/rt5033-private.h#L211-L212
https://github.com/torvalds/linux/blob/v6.3/drivers/regulator/rt5033-regulator.c#L83

For the charger driver this seems sufficient.

Kind regards,
Jakob
