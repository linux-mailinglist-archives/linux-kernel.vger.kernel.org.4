Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9786FD2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 01:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjEIXAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 19:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjEIXAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 19:00:21 -0400
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A971423A
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683673217; bh=efwMUGbErxTdtTuyqM6Z+L+G8MnBDN3MVzDgcAgdTLc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=un0ekRKOAypG+FJH8UOskd/LrxRVq+2WlQF8SxSt3gwbMsoxbWqQK3+EXrbLbNtMbfmSEe5RbuwJdi3V5H/sM60ORGoMPywmTXe9jKMgk1zLU0NhbKTbeeZBtnlDNr672rQItiJWDtdA5AuX6Sz4L0F8Mk9geIDJuheTqvfBV0CReYGn3iySLLVjPkaGiLkK9hsf9+MnCsB0wVDvsABwLlTfjRyN4V734MIWwq43FsvxT8rK3qI9mhDrVjS3V0Ca/x55j52VX5864stUWnL4BvEWsUnwFqkI9hW+5oVPoML7egFz8LpKBoEo0giylo4bmp4z5nNfPCIKysorIKjHZg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683673217; bh=E4he1DJpKd6YHNuO15fjs01Lz4q4U5Xll03swPnt2GG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Ioz74w3d3xW/P9Z7Eqpz1S9pxoYwpTK+2IEVgZxsRnXW6EXjsIIC1bKB4sYAgkby1XidJPPJF+DkpfL5CIFgwb0I71lMaZU8OGQ5jGFD6oJehRKbcVC3gtOmn6BlzKPIpZjf5bPPb2uWeizdKG+gVNw+BaXPs352uuJCQGYZekVh3ABxpJ3GU/y5QvTWewDvu1P/vePq098hgvb1ffC9puLjuegqOEFoFAXbaNw3qcA1XCj3K1mCMGNXwCxTHrvmc0V0GbjfZFsZ18uTwNA4RmNRQB2qiqCQe7GvSVa/1hyVY5icJ0xeEYX/a/oqJ1/x22RjzJ1uECfmclwh8fKDRA==
X-YMail-OSG: Fj6uY6wVM1lqz925VZqg6mq9mq0y0tGUQ2Am8pHJp_c7QrNj5al09L29x__gXe4
 BhxzCI5_vn86NfBbBOh2dfCCiF1i6oFjG7xg9zCbfpAQAKs8zUj0lBrZkmp98vcYrNyAqhejOh_H
 PxvXVWpo.1NpzTIHT2i0Pj0wJNeFx2wCArI6cDUsLM6hWRIbTtWi3gVDitRE.q7ZH_0fJD2h9Ey5
 TI7lv2.guQHY85stdtTpiM937h4FmO1FiJR179HdH8zA3OQQ1HIRM7_qRSrHep_CRltQgi1ZRj20
 YwZpClrrlYqUz2kTxKtq4RAB7SYYw_uGXjE6.RTFqXHO0JwTBNxnLvxryMcQ5zgAzO4sGZxEWwgs
 yKyuEDN0ZVWt6k0P8JufoBei_F8hqwAl2hVFj1jVWmd8J0v_zn7AVuZtZHhSRbLRz1D7A2Dy7pow
 .zWBd3HRa68aa4pjqtdJifbTz0x0gFkzeCE.BBUkfDqDIgmawIdV6Enuvc9ZRjOLtjNv8Wi8CVja
 0airdBT2o0BEQ5x5P1vFySiIVHnZ1k94ELFF5NE4V4mVnJN4TlwRoeYWa8sgahcb_ukvTdcvSq55
 JbMSX8uHBkT9NXwYcKKakOo6wHxZI.tlnK6uSs3iqi_XeU0SQi5o6y17ufjVWa_E6WWTMD.0f1WP
 FW5GbxB6q9jets8R.UVkFwnsCO_.6gL6O9tGvlzc67_FXVLRlnz1z3yeU6hSt3lc36CMvrfSIGmQ
 6iMzzELj7PljsTm8wSm43xr.o3xuixZU3apyaRJoOgWo2xJaEp2Ui2_g0cEUDZqsbn0PKCteMhOY
 8vgZHOi0PNTOHvCrRUrMgWMpm1iL2q9RmwZmuwMXXTmaO_LGmcg54DvqCY679HwKuV343SWhpuiM
 p_AtpPlxLl7xVl9LaLC9shi_wJePWmYZrM.pYa7IX2Tq5iEe.B_83bs6woV.4TK1JM5zKH5gvhtn
 eeuqFxKfWgciZ08lMYXvKSEVD7g1Jo5_iAV3yScS8WfzveAZ_lIeQSXFKiW72n82WwUIjwc67jPH
 GNeNRfexmJ9ncwisdd4MR9soa8Hc4h4B.ovvLOvaJUOJ.ftpk6ockFTAAEyfNRSxT.hpfh0Vs33B
 o4p3AqzakvZI.drwpuMYPOsekQeVmmFsJ5XPzqaOmXBy8ebHD8nas3WmULghCMiHgjyztyKYF8rR
 spza0twpcHQ2Iwuhzo3Gu4GoKWxY4oPfW1tr4ZoAPQkTqquqPofBAdwUDfec5Ae63K1NUK86MZwB
 S0IKRVAAzz.h0BK4WarTfvcNjxsb6Y96BS172.g__lwJSG.IvVaQvXTHo3O7ddox2id7gVUiOxU_
 7x9jlCISeKXJljAcq8.zDQrZbAtmeUEAf7_3PQd4H9VaVmXGvFPNRbLjG7QtfD1Ji4FPVLVmUygf
 sCcNe.bEnQLeHI2BkiHFX7tCLdvcK0sIA.tm3YJQz6pLLEnAParQaGonG6_zmLerzO_lj1XcGgBo
 5Lxqv8VirCqx2wasKzhebmNkogD81TefIonR_AviH14xbzLhsKa19Dj1cGb02u2drqoQrJgdGzWW
 oAmg68YeQC8fVvteFwBB1ZuFxWyDMNL39XYyOPLbyGJc3JDE4_ZXu7CB0mtekVo46RiItsaaq2bd
 5_zkST_gWMs2.65u4vSvTC27LyOhKVXSsc7GHAeFusTIzzRFHYRsmvdC8a6a9SDyQQWCVs4S7maP
 GZ9yFSWnIdxt.E4sVuReNOHk5GbQf0YdmgW2VIEnDjef3Fke8JX7mtY8VHSk8G9Q37lkGPjYOtWe
 xqvP45A30zoQKd9x_ITNp2vVNYc8SJuB_9paWMXFWqsxmt7Rw4Q1aM67mQmajqTHec5ojzqOp0FD
 8w1KQCIX1MG.1xCu2w0KANpGtw3UCO9uM5Zi35JdKfDPMw4jlM4w1RBIACYKigkqa9HNEfxPdl3b
 sySOy8_MPD1S5p74E8aO73zjEAuIdTLcDXep1OW3l8YKyrZKN3uAon_4WBRlWhydXYyd88Fbgb.R
 7AFKQave90VbmIRfdSPVV5dft51BICRqxJ8poyCRu0aTFruB5yCdFLbbsYWFQTiIYhO70Vs4vThW
 rgCtXNWeeF6LLxlkEsZzdZyMBzBDOJJnKoUqTVeKzMdlm7H9gU7GvM7vbeckdrMhqOgL5zDiyyrw
 T.3J4O87ne65PQ3wUGhlNmBVrRod550SHVuccRu._ugvyGf4..pBEgELuBgEQPE85Gcm2JVBnSON
 5JQQv3mN_ynwvDVk5Ch.6dLra.zYL4f6dopmUEf3pFdBMUjQX_HiEJ9jHE7eahZ3gzmVYKvbL8A-
 -
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: e0a13fea-ff0a-415b-8570-c46facaa5388
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Tue, 9 May 2023 23:00:17 +0000
Received: by hermes--production-ir2-74cd8fc864-msrld (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7d1c0b57b762ec8cc7f8c54878d263b3;
          Tue, 09 May 2023 23:00:15 +0000 (UTC)
Message-ID: <fb554a6f-6058-a9b3-b39b-eb9f634a212c@rocketmail.com>
Date:   Wed, 10 May 2023 01:00:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 7/8] power: supply: rt5033_battery: Adopt status
 property from charger
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
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
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230506155435.3005-1-jahau@rocketmail.com>
 <20230506155435.3005-8-jahau@rocketmail.com>
 <20230508113518.nfwchl5wusmnkjp6@mercury.elektranox.org>
 <899d6604-7b15-ac37-c624-987a2bb7875e@rocketmail.com>
 <20230508220605.kderc3nihhezouit@mercury.elektranox.org>
 <55fd9835-4246-00e8-b641-c8b0ee3f7e22@rocketmail.com>
 <20230509072520.3e4jibiis654izom@mercury.elektranox.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230509072520.3e4jibiis654izom@mercury.elektranox.org>
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

Hi Sebastian,

On 09.05.23 09:25, Sebastian Reichel wrote:
> On Tue, May 09, 2023 at 03:01:32AM +0200, Jakob Hauser wrote:
>> On 09.05.23 00:06, Sebastian Reichel wrote:

...

>>> I suppose your DT is missing the connection between the charger and
>>> the battery:
>>>
>>> rt5033_charger: charger {
>>>       compatible = "rt5033-charger";
>>>       ...
>>> }
>>>
>>> fuel-gauge {
>>>       compatible = "rt5033-battery";
>>>       ...
>>>       power-supplies = <&rt5033_charger>; // you are probably missing this
>>> };
>>>
>>> See also Documentation/devicetree/bindings/power/supply/power-supply.yaml
>>
>> ...
>>
>> Thanks for the hints.
>>
>> This leads to updating the dt-bindings because adding the "power-supplies"
>> property is important to be aware of.
> 
> It should already be part of the binding, because richtek,rt5033-battery.yaml has
> 
> allOf:
>    - $ref: power-supply.yaml#

Uh, I see, you're two steps ahead ;)

>> Btw. first it didn't work. It took me quite some time to debug. I needed to
>> add "psy_cfg.of_node = client->dev.of_node;" to the rt5033-battery probe
>> function.
>>
>> Now it works. However, there is a new problem. The battery driver gets
>> probed first. The charger driver a bit later. In the meantime the battery
>> driver spams dmesg with several "Failed to register power supply" because
>> the charger driver isn't available yet. Once the charger driver is there, it
>> works fine and dmesg becomes silent.
>>
>> With the current state of the patchset:
>> dmesg | grep rt5033
>> [   13.628030] rt5033 6-0034: Device found (rev. 6)
>> [   13.633552] rt5033-led: Failed to locate of_node [id: -1]
>> [   13.790478] rt5033-charger rt5033-charger: DMA mask not set
>>
>> With the changes discussed here:
>> dmesg | grep rt5033
>> [   15.741915] rt5033-battery 4-0035: Failed to register power supply
>> [   15.752894] rt5033-battery 4-0035: Failed to register power supply
>> [   15.795458] rt5033-battery 4-0035: Failed to register power supply
>> [   15.910760] rt5033-battery 4-0035: Failed to register power supply
>> [   15.913187] rt5033 6-0034: Device found (rev. 6)
>> [   15.914341] rt5033-led: Failed to locate of_node [id: -1]
>> [   15.920052] rt5033-battery 4-0035: Failed to register power supply
>> [   15.927262] rt5033-battery 4-0035: Failed to register power supply
>> [   16.017131] rt5033-battery 4-0035: Failed to register power supply
>> [   16.017401] rt5033-charger rt5033-charger: DMA mask not set
>>
>> The message is comming from the rt5033-battery probe function, it's the
>> power_supply_register() that fails.
>>
>> Any ideas what could be done about this?
> 
> Replace the dev_err() with dev_err_probe():
> 
> if (IS_ERR(battery->psy))
>      return dev_err_probe(&client->dev, PTR_ERR(battery->psy), "Failed to register power supply\n");
> 
> That will avoid printing an error for -EPROBE_DEFER.

Confirming, that works. Thanks!

Kind regards,
Jakob
