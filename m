Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC93A7111D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbjEYRRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjEYRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:16:59 -0400
Received: from sonic308-18.consmr.mail.ir2.yahoo.com (sonic308-18.consmr.mail.ir2.yahoo.com [77.238.178.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D2518D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1685035015; bh=xkgnHjBKgUoTwdkT61NT3PpvtEjCsZBF89ShWXMrk8A=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=HaTVT25f9lqUnbp8L5yar5hbbsHNlY0LyA4z4xDpKfjuquHCus8yaXs3rCDKo9x66KsZz+h6+Wp5VtIDnspos8woLlBvKFPipqzKx3nFKbKhJb/APNybvAcvSQ/wFCFdFBGQymd6ghuRfD1/lLb8SXYMUlpYaaFgns/UG60n/lJ6or4pNNlaHSaDBCeAZ8hxn84mGIJgW0ODm+C+NH8+WCBoExTCUvY8PwUDkKDvH/aBqk/7wY4vZzbiePXiCPD0fiGi+1HZrCw7qYqjFeoTD3saMq/XyZ5U9HuRi6yv+5hYj44MtBOpGndEaL8LilpR6JvxVSB4Y8bElbdjQ2KqpA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685035015; bh=PawQULQLg4LscEgh9vaZZDdtXDFK5uRu7EfNU7g6Wm4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JbdOqQ6ZdbOnTNnRm3U2tV1/BRfm7bpMlpIOpC4eX+uoZIuMOsGIz3kcg7ocdcD3jNtYgoHEkErTRhNkJ5hZqOTzhwsG9klQQbAF3nj1Vvybriys2E6JlcTTXDqlfRt9rBQAiqx+bbr83b+EphAnbaCg4RfHveqXGBRZi3o2Fij2upiZB9kY6SllgRAXCFvueSm84aPVkQsHmxg/IG7eqN2uSz4l5ri7wynJ8jIjrzlhsoTw2RrEQiOSY6T4tTHOgLA7VU3vN648++EA86XCvmsjodnc3j85FowixOJD2Nltacv9ZFIqyu75W5VJodiGgeLG/05Jk16/BIFKT1cJjw==
X-YMail-OSG: RgaBlaIVM1nUppqx0Hh5l3kHWwZNL_1F8cFW6_8SOqX8CAftl676FQNZCItEdLs
 CSG5XHlk3ZiKUuvCG7jkEr7sBbM0cJvdG8V8HpUaAte_xx_UkqvmSTto3jJ8OFqDsSqTq25.wXKN
 xF1Hyj_Bi1hOgJSMLuCjY1XF_ZJGF4Ta3TYVIyOem_Lv87szWzR6HjTVm7dXSNje40SGyfbkUJrv
 H2Ly6lsR8ZuJ6xeG0v9Nq81cO3Apm5VL5z0PDjxdoFUt5o8HkMoKDNjRkbf5i1MaccC0abH24cJq
 N.XeDPH1EIfZMcEhZbZhcApAZa6_sm61gS5zyqzHnZa3_TsW5BBDjLKQduMl_hE9BUY75Gsrfz3u
 SfHnVyiyC0hQjy1mx8Rj9Mecy.wNZtyHOmgXrT0yqteJv9kBpWMy.Y94.MJ6HqIOUdYFeFQztf3Q
 PR.4NPCxFnXrvmBmuqx.vU.CfT3IxH8lZsjW0lVyHl3nEEfM40UKHwQ7.bmNZSopxx_93Htopt6T
 3qgxmP1GcsEgobeZrwG2xTFlKuCQ8tD6gtWAR4zeLjQcXLNfLbGGeMKE0CgF5Tj.Du8FTddRzl5N
 DIOluI1N8esuPvBBBoQf1MTtmSUOA9f6ho5VCbh1WLAtHyGXNT4U8kwSSVKtvOvhDkWcgqqN0SnK
 KQtSAe6HQVD8_fF.8gz0Mxsffodk8oyaC9eE6HG_SVGSgPAV1wp65pEHZexiWdFW41SU5EEgKW0O
 i6LJH_VAH7gVEaFob6iccdzcw9VcFtWekBJWZv4uHV2c66q2WB_pTayN0C2TUTuX29M4xHv9c1F9
 WREzHvzNzvncX56AP0d55kdC9w0eveA_yP04sFhs4uo8kYHViC5k9NuprmbAbAhKkRImJQY61Qca
 RPDoXMwsZPDrEq9AjfxHVEotepGY8FGMmrMw4bTZw8BXqTNQCPt9DxbqQO0FdvSukIszIC5Cj5Iz
 HYPavvaVv4tliCGJ6ZA9ikZVgiwh89mIZG4DYzPlsRPaFyVgqC4oDtedwMOtgaTTccDNu3e8.3XO
 wHjr7FF6aTwoTMLfuq1iK9u3CsPt28ZnJWM.v8FffHQ.cIaYj5JdpGDCk2Ar8s3937w2471PoFYV
 wu1f5GwMl7EpNjUEE_7XiRjWbcaWdxdojZoNaRHcGO0GsPVGtvbKk3esyEHFptbL7My_b9dLQtdf
 71W0tuFHUk727cCz2VtdYRgXq5W62XTCPwNje6NmPDZlDJ58H6RPfnzpDQD_2Bz4cX2WdUEjrSlf
 CbkrUlgYxeJp8NoZp5TaoNpw6TiNOttl_2dCJcTw_07LxDOVYWb_Ej8lXjbyqqEYJ1LSmnoAZreW
 yPTgb5HanuoDFQVhon9VzFUWSdeFFBvIa0uhKQRR2TAj_7q2vckt8NkpVbVs6peyrn8RmAdgSO5m
 tXAUIDiFY5xvyK9AHFeJgad45l5L_BmS2P7fS_wxkVDjVVDzyJJ8XjAF0d9cjV9audh_9SzSVQDD
 2f.zLr.7PIbMvvgJo.1JTewYBYXLM3elEG_uaBn0WZqTtvhLaHpaXoAVyqSMOC8ZGzmHsvMG3Am1
 mGrfXpuOCGwjdiS.8wu195hq_XsqL.oHtUHOk1GqyoNEGJwv2fxYb41iT5yWGRHD3BQ9COoL2U0M
 qWEnv99aG_l2PitQIv8v1PP.9nvy8sYNtVH81HvbnTMJTd3v6sjsqL_CsJPI4KkKefNK8JhpNRqG
 Bc1RUCORhUuZ6jqcNoO6MEj1EEbL2XXl8rQ2wzLdhTXV9u8KCYX1Dt75IzwClIcSLrDKfQbY6460
 XhbXFDw4pvrfpZw6713ou4iiFvEs2CZ2MC7IlMdZUHj9Nsdu1VdZlaiiDOFf.oX0h5nAk76puZrB
 HNlOVuBla6dXq8BlPUID66yQYt7lkrYY03Qh0EHTJMuAsRrmeIk1jFCQMSUmvhxaOA_AjYGJDvZw
 MZuybCRml22EzhFR7oewV5zG7ZnQDmfrJJspdJdYpimh0xFUDRDPV6CyhNRj3VXQfTZN2yQdj6nT
 9IShBPDECyOhurwCgyg_C9WVkvmnmpj3Rsh.CqJb8UfTMN42TZ4o5j0jbyqJ8xJf74ph3BbEnyft
 evJ4HYF5Rqsmsv_VIOAv.LViEd2zNVE0KV2ckd1HiZY8GqktH2ZE3LQvcShtnsVOJCwNoZ2EcWDt
 oWJQ1NrM1tt_mHlgUdHSA_5E_xU8q3x0zRXafmby40u.m0.1MKIDO04yv.GG4xvFPqjTqyFIShYH
 trRF2yQzZJTLsjK3VU4ueTvyI_mWBKHYb6J3XGPAzjySizWw2p4NUMfrJ5LjFvGOS444kbaKFQlr
 W7RYuI._tXg--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 6296b9f7-b72c-4688-8d28-6ed9ad826277
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Thu, 25 May 2023 17:16:55 +0000
Received: by hermes--production-ir2-7867f454fc-tvsct (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 728940cf93f8512d21c18c5c5db9725e;
          Thu, 25 May 2023 17:16:50 +0000 (UTC)
Message-ID: <8ba9bb4c-6b9f-21ea-e9fe-89d5038dff2c@rocketmail.com>
Date:   Thu, 25 May 2023 19:16:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 04/10 RESEND] mfd: rt5033: Apply preparatory changes
 before adding rt5033-charger driver
To:     Lee Jones <lee@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
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
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1684182964.git.jahau@rocketmail.com>
 <31c750ae13a1c1896b51d8f0a0d9869f8b85624f.1684182964.git.jahau@rocketmail.com>
 <20230525104434.GD9691@google.com>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230525104434.GD9691@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 25.05.23 12:44, Lee Jones wrote:
> On Mon, 15 May 2023, Jakob Hauser wrote:

...

>> diff --git a/include/linux/mfd/rt5033.h b/include/linux/mfd/rt5033.h
>> index 8f306ac15a27..e99e2ab0c1c1 100644
>> --- a/include/linux/mfd/rt5033.h
>> +++ b/include/linux/mfd/rt5033.h
>> @@ -51,7 +51,7 @@ struct rt5033_charger_data {
>>   struct rt5033_charger {
>>   	struct device			*dev;
>>   	struct rt5033_dev		*rt5033;
>> -	struct power_supply		psy;
>> +	struct power_supply		*psy;
> 
> Is this current unused?

Currently this is not in use. The rt5033 charger driver gets introduced 
by this pachset.

The struct rt5033_charger was added in Dec 2014 with the mfd driver [1] 
but the charger driver didn't make it [2] and further effort to 
implement it phased out [3].

[1] https://lore.kernel.org/lkml/20141209140102.GZ3951@x1
[2] https://lore.kernel.org/lkml/20150122183037.GA24898@earth.universe
[3] 
https://lore.kernel.org/lkml/1425864191-4121-1-git-send-email-beomho.seo@samsung.com/T/#t

>>   	struct rt5033_charger_data	*chg;
>>   };
>>   

Kind regards,
Jakob
