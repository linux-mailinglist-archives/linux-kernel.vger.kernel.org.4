Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA1B733A52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345711AbjFPUDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345989AbjFPUC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:02:56 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3134F3C20
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1686945768; bh=7VIg2OskWnaHeGIh2/02xDBsEiU6cbaw6bxetVSvniY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XSfgOm84t1Q/PF7baXtE1kq3V6DUz/ew03bL6jFy++3hBk5KW88cgxRVHqaYwtjPBmfZznKRHoWcST2jOKs7zQwMfWRFqlYTzM7guJLblMyHiqmehEkix/TkyOdBuDAhDluu8erboUXU5twjPHfesopNY1lutRPIrOYdcSnu4uok+kEy3+RfFfqB7TagES8I2qF3HVOPwYBSDOKCNKaHpZO0wopEKABlBDEvPiGn1U3kvZSLpw5t5aLarHiykdw2KjdI2xxCiGzQeBYz6wlenlOMVrDuWMRhQXsdZtrwE4SGf3SlBKxeGOp8zTvui/PK9ilrXNvVaSAL3ADy5nJ4lA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686945768; bh=CB0V2BCA4hR4eBIB8o/GC/QgYjnmsr4ogI6UW55EfX4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VNpD57dVPLk3Jft4Wlh/K34jU8w+uJBPC7MyIMqPomcOGv0y0asF2oo4IcmMNY1SIceY7vlV04tdv/T5eD5V9fZb7x4y8fsAazEiFY/A+8eDX3fChfJy4S53fIlP8kof59pbOi/Rfpl1HSkUQXAsMhbxQR5SeimOrXIXXhd/fyN4ffGeszH2f7eXaTX+X0LO0xtFU1zEB/ei2GbrVkio3EaLBFDsxNN0b1K+jy29f2rHUYzpS8jdp+VlJPZGNAwsbupcL8xxM+fRcjtcg8gi8zhwK3+JjU3u0gkMqyjBFmGZq4WDC3JjTJOt56RIT9xZMqemofXPzxVorGgcxjubIg==
X-YMail-OSG: kOllkm8VM1m8IHFgxV.hizl2LUrDP7Tp1uRkTyzYIovcwM_ATgBilsQ3EORS.zW
 czQKCrXvnPqLoBCrPd8wwgpk_o7PRnFqw5Y_Z2h7OrNV3qV5004VND4bjGd0vx5PMjsgotn3S.HT
 gGn94Az9sBGyQY7B3L0QMw1kcldLpfCo.3HhlmwB.YYu31sv8eItFdw3NnM7aMKSd.vG7RdkyTRe
 noLkqqCBh_LyQQeaATg8vakclMId0V_.rGPtwMyVAM1_GqL0cP98NSSPaXLvbdE9IeLnsalsE8rM
 1rZitsm4TSomLZYtrE3YXO.dWJhHsBzhLtSVLAqnQEUbTzGsO._jKmqUXt1HY2UoAhvfzGEFJWsP
 83mdU90kpJr_yr92lYC.dAf57gBVnqEMuGzE7eJZhym8BBPCwU1Itj_DYb6dZ5V6.4GEMH_6RVVU
 qap0wUcblIS607qT4idHQC7_wO_JwVvkmvUDeGnzB1AYcWKW7xRr_vNXIqEUfyIyqdF_xiO79D3D
 qYiwHKNnpxp9GU1tay3a221YdaOBp6RkF3BSNK7y6Z4gVeABIRKu1EPQVob5VcxUkWO8D6Q.9gWJ
 kjmSvnhnQQcOUOV4y5XuaFq8prdCa8kxzGPVyxmovHQxjzCksvBzG1fDxiJPu8AeOjakA3N7UQu9
 .DDNrL9OmPDvPW1mZ2MA1xVkIYIzf4PFRHKPZaeE3T9tdMVjGIiUrGvjpjaYJ4E6pnUURBteGofG
 wrfqhH2t7suskI2n3GCoH0uoCRFvpHzaLnJxu2e5Cj7sHXGSRVt_7FGsPRSxF9SSb8UOTr4cV9Ve
 lQcgZL1PnnbhbRFl0vIktQfXDIoUImh4ZvNitiHkanBEY3UKntSwjVnIgEc0C5tx17RPe505uZwT
 UTrNZ853aya9sbDGHO9d1VPlNxxjKYGx6VRVYbM2iiNvMBE6Hjq0TBxnU4WyBM_zXtW5lBtEFopG
 ZUtfFbeE24zLezZRG5eSRqqwP9gaRFKSAJcvauUcH4FM3qr_eP5YO3kak1uFaFKgn0aePGSNXoNo
 dP9NYSmJe4q3SXu4_OViFeAGgBVMMTnBgwgQV25tjOtXlAiiWSt1KIEJLyQUSM30HBq_5DAEszoF
 59uwn02rQ08VqtoMCPatoz18jlqr3Tlx4YMz0aHAKuuwfNIhpgM3jKV.aPstjT4CAtAvuRfDB3cb
 CeVz.BIQjYqa9ZkYblQx_utd3elL4DQjcNGcI3r7P30ZcHZQLeCOVOSi_I_YrXOVVqst48XttI0h
 dCjEN7HVIRFURhsVfc2K1dUUt2Z6Ewr92UZcDF8L2jplUjNP3EJ.awdnncEw4n8IxXDEZ0hlfyb9
 TsYYi0uKAqWHzinH10bIHYBrPrcwBvLEKpUZW6HJQr6xOrT9.K0woN7ra6jYwun0xRWxMCxYzEOS
 tVPorHV36yOX3bOaW35hqraCCcwuTtiTgKy7qoxt_IUJVuJVwjI6pFUY855_D2.drFO3s84B7NIa
 u6Hzh_3zyjDO3gSXVR5aGwGkR8AU5lv7KG4._Jwtl4qtFDyEbZdNDpeAM8NUeQi8TQ42plu9.mdL
 NFfELDr1nUNQTZbAAKnzfTbfGycOn1L3fm_J2QdVIbXyAwXRwQk4_8KUL5CZbkUbiLJyxtWxu94d
 Sae3e2vr60mKbVRAGIUL38WpiD7m4vo7..MZ8am4OCNkG0LtRwJAaqhXFE5R2Uq5FvV4xWndAZGp
 8s.wjpFa1TyzuuVehZ62fvUQEyri51KWmOWSfd5kJFB7_lhLWxmXmjo_8mr9AxyQkJvOr1jmSs_R
 bZNyHbKctM_vdIXpUwEk1GWOUvQ25RKRWfm6LyKT5Q79BMFvUnLjGB8GgXcvqWsi6L4JcN8DpK8a
 s79w3mZ5R1VgHF7nc3zmWo3q0.X.9Yo8u5_3mFYAM7LwB_JBs11TnN74xVLQ3shLTx9WXpgPCvEa
 U0xH_6ZTy..qOa5ck1SNM57Ulix__KSh6h1vCGpwJaYSyTEDH3gj5mzaqOyhhgid.8vXiiLjU3c2
 fLafXkF6gCMU3.av8VIHKuFblYj_cEZbvLeUOdf.iGr7q75CFVKtYATjgWfDJhyScosTNOumQIIJ
 ary3dryfhHUu4upw9RxcpMlEdB3yQywtH4ltJHMVfNbo2ujEEip8ZfDzruO04aJzty4FJPluJkLl
 avUnbZtsJRPB32wm78eJ0Ws53YdwvLH8ONjm1ZoM_xwQMnrkqHiivoxr7AvXB6Sl.4Zf24UUcOZx
 8gNmShH45jJjHudbOaEm48gTk1u1fxIs0qukvg9aqLo_fynwr3Jq2Togc7nN5O1RA6gN6MHw-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: a147aced-bc38-408b-b8c0-f83847a401c3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Fri, 16 Jun 2023 20:02:48 +0000
Received: by hermes--production-ir2-7867f454fc-z6m77 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4c9e8265e02e87a162885ce9dfef0a17;
          Fri, 16 Jun 2023 20:02:43 +0000 (UTC)
Message-ID: <faff027d-2a6a-22ca-2487-2ae05223fabd@rocketmail.com>
Date:   Fri, 16 Jun 2023 22:02:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [GIT PULL] Immutable branch between MFD and Power due for the
 v6.5 merge window
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
References: <cover.1684182964.git.jahau.ref@rocketmail.com>
 <cover.1684182964.git.jahau@rocketmail.com>
 <20230609064753.GL3635807@google.com>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230609064753.GL3635807@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21557 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
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

On 09.06.23 08:47, Lee Jones wrote:
> Enjoy!
> 
> The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
> 
>    Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-power-v6.5
> 
> for you to fetch changes up to b54185c1e3b02c91e4a190ac5c346ea7bfb0de93:
> 
>    dt-bindings: Add rt5033 MFD, Regulator and Charger (2023-06-08 18:18:13 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD and Power due for the v6.5 merge window
> 
> ----------------------------------------------------------------
> Jakob Hauser (8):
>        mfd: rt5033: Fix chip revision readout
>        mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
>        mfd: rt5033: Apply preparatory changes before adding rt5033-charger driver
>        power: supply: rt5033_charger: Add RT5033 charger device driver
>        power: supply: rt5033_battery: Move struct rt5033_battery to battery driver
>        power: supply: rt5033_battery: Adopt status property from charger
>        dt-bindings: power: supply: rt5033-battery: Apply unevaluatedProperties
>        dt-bindings: Add rt5033 MFD, Regulator and Charger
> 
> Stephan Gerhold (1):
>        mfd: rt5033: Drop rt5033-battery sub-device
> 
>   .../devicetree/bindings/mfd/richtek,rt5033.yaml    | 138 ++++++
>   .../power/supply/richtek,rt5033-battery.yaml       |   2 +-
>   .../power/supply/richtek,rt5033-charger.yaml       |  65 +++
>   drivers/mfd/rt5033.c                               |   8 +-
>   drivers/power/supply/Kconfig                       |   8 +
>   drivers/power/supply/Makefile                      |   1 +
>   drivers/power/supply/rt5033_battery.c              |  38 +-
>   drivers/power/supply/rt5033_charger.c              | 472 +++++++++++++++++++++
>   include/linux/mfd/rt5033-private.h                 |  64 ++-
>   include/linux/mfd/rt5033.h                         |  24 --
>   10 files changed, 762 insertions(+), 58 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
>   create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
>   create mode 100644 drivers/power/supply/rt5033_charger.c
> 

I just realized that there is one patch missing in the immutable branch 
"ib-mfd-power-v6.5" [1]. Unfortunately I haven't noticed earlier. The 
immutable branch holds 9 patches, the patchset has 10 patches [2]. The 
missing patch is No. 6 "power: supply: rt5033_charger: Add cable 
detection and USB OTG supply".

As this patch No. 6 affects only the file 
drivers/power/supply/rt5033_charger.c and is the last patch on that 
file, it's no problem to add this patch on top of the other patches.

Could you submit another pull request for the v6.5 merge window to add 
this patch?

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=ib-mfd-power-6.5
[2] 
https://lore.kernel.org/linux-pm/cover.1684182964.git.jahau@rocketmail.com/T/#t

Kind regards,
Jakob
