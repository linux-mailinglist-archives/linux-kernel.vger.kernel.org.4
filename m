Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AE9718B02
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 22:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjEaUVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 16:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjEaUVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 16:21:41 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E1E126
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1685564496; bh=6OgdwRPEVOAnUypYBZcbRGwsqbPIwbDvaah8upw7a50=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sch8Ao8he/yAvlM9s41ZXYOjCyH9fpBAzm0+RmlPq751Q+c8Z6x5V4SWoUTDNX7SAvvFSHK5VsA3MAcXRBNi5TohJnsDPtqgTeGIKnsmSEo1EYj0DL8m9NNmwW0DkNEqYp98JP7mSo869E4i15SZD7n9QVibKQ0i0BnxTl63B+u8WSFgekXEy4KTKsu3oXLB1LCC0yrTdoOWPIfErgxFA0xYa80JQgzlC3faoDJ3jaq5GzhRd6MZTcPyY00GsLLngyjN2oKOdYsiqOJWix/S2xr7OsTuHGF7jJ29kVP2E6eTwIYfq2b7oXd7dl3r+K7cPuGhYeJ9COrg6T170VTE3Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685564496; bh=7Je2vZxEGGzhri1FBqIPmiqoPlQfNhqzCiWOlzzQpj+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=scQl0fFzY1u3jol08gDwwEAjCyk9bDFJZvQuIt4446Se7mi6j4bAEZq1wCmy7TLBG7T1EGYdnTy2/YbIfRbi79DiIPWIH0MBkjFB+zV/1h278zBdABRaqUqS9dKABzhGOvS0iSbw3C4El5ZRHucp/as/oOGYfUfYZkvTt/4yw9ZAIaHB24BwP4GyGW0yMOS8msJS9Lx5Leswg3fPpVoCPbfdxDQmxQaAy5P0AuXVcKZu89fu4a5BDeovyo3Vaq4LejIcSO3CvTso1VEDd/WCM7UcXkczKUrqMs8TSEjp1M0J7bN/6cEZHJLVwmMb3AhJ0Y/Y7/MWMQ2slBLE5w8zLQ==
X-YMail-OSG: 0eaclWIVM1lHU45eX7fNlAgMKec1QeirNvDCCEPzkSz41h.E6Dn4z6w.yXX6Qky
 DvMYxqXlR9fM.KuzF2UAZnE86SnlZ7H.MK8IkuUbSpKqS6fRQc291r9ZFHq6gX23hk0pk1DEtTdd
 fRUIgt5rUsuiczWotSQA0PBDnrQiNcxAy0fAZkv64SwFw9HoGWN4L5G.D9kXMERVNeSgIIQwv4mW
 EDzx_ZMSnllAel5SXz5o4NaovZtzg7UI7.tS8JroiFq8Uh_cTAMnYqCbguVTX1JHsn15flWGkXlc
 3YvPPDFqRIM8EvRRq6ZC8hD_.slr6bXX02BrAx8fea15mIa3IzB7cg1w5n7DmYCZ67dQUpOClDdW
 zpNff5A9vrDy3kcDz20RLlCEH9FwTbUXOMIZ2hm3ebizQKMAIOnSS.Wzt6PGpnCp07TBFZh3QEJy
 twc6YxiotXpw25u5p9ZLmBCw2sL_lcvk3Nq9r9Z5XuVWqokAFspc_NS9rOnbywYdZ4NgRDkwg5ih
 ynUjrpRdol.5HQ7T.YohzxYm_L9oyvcQqooIJXOSViFbW8b_B5enUx_uVUXN_Ymz9zQfkdtJS.J8
 SkoHlVlJz.LbAwoFRawZcqkbMN9LfECJPgu768vRAa1Lxx805KSpoSu3o9iMZzYktcPGpeV2IAGb
 fnPNeiG579_yO8ruqRFiFBV9gDHfUmy2ZpwBTXgrg9bNd7YNrEXA1yiE3JWVbRwiL4gFyqV5UT9u
 ge1TaMozMU6ldWI5v5yqsL_l6I6lh18jYImxxwhrlrIHcMdrUBIaNl3ZY1szByzRSWqmJzTMjtnM
 KhC1WuZJdY5qtPgfy7V3x1_uU9aoLR0vwu_iYHOaoUeE7fJkCOrTUaAYdImY1QdkQijcw3eTeh4G
 BbK2kgXf6.sR3QOfcu2spSs0ES.sa1iR2NCJ94x164yXaNiPzh9E3kUbs_XVlAX_fkMRJPaOtStt
 AfdORlUA24msHgzWjpf4cYAE0GJ077ezFuHYPJNy9W21_UF97_o1YQkGrrrH5MRsVExnh5RBny05
 0ixIBOKbLTWYk3xGM70gyf1Y6No.lj.hLzyfM7S3paDVFZiAJqhnH7B_E6GuHBDSxLV14rP.7Tg1
 g8v1Xnef0JfiBY_nuzdwpKuP0VbUDjVEZ4LcHJD6CU7WLiYl_Yi.k.mjXctgpiVQrnL82QuixaNy
 Z9Gg5eHLBKCuACUXsenFU8Fhu0cmXzwHl8uNu3TVleHj48EMZfMCdBWYCLNHxhJw75bTFScrlCK5
 7nkSVqGKeh_JtjR4Bh79XAsIPR7RbsO930JzsSy6IQ_p2pEHqM70l42Vf_TvdnBA6FdFeKC9c68M
 F_rxXU18y0_SN9hPZhGBlR1qjtRLcAHNUS_Z.GrUFfuGwmG9SM7captj2d6NoS.7mD7sDIjDCLru
 jjl53MJ03MKfDwNTznugnnO.zrRnMBLSnDmykXdiI0Z4FpuviA.DboerwEEV0tYqttciVhFRRk2a
 aUw_uNmPuwFpNcPGtc.eZA45jXyxKfX9h6ffkWpIjDMhnKDc1cxGsn.syXEnH1Qs8xE_dEVkkXna
 1kyVPYmNMu4lXsX2qbNUlduz1mUhy6d8iArmg3cTuWfiU9G8YMQoA4OOXkl2WePuGtXUC0KIcGGe
 BBAINizXF86r44m.Ur.2plmBlsiuNXDWcARthMdBOQPMNvR.IlgPFtmdASGmPGmrIuDKzjEtP8UW
 rlJ5AsvBM.82vUS.po4r6tfvsfI3RJBB8KHFYUuT5HIWti2QVbNIUvOdmNo_kzlN5Bvtp32dGs8v
 nVrCxPP3HxX2Uuk33z7VCece8O8JG5HiJvlfCIGLSCKfTR2HD_3ewGHVk5pzphCKVE0wssZ_vlQw
 tO9kSeuX6Tf8LeHfTNgr4wa1MjW.2eMqz1Mdx0p9QisTWZziwkis1Ezt7SI_cKKZuPJknk1Kv_TQ
 nSxZkXWLbJ0hEeN_7R5pWIa4sCR9s6GSiFeCNPMc0k_AGg.L4LD2kMJV9YbS1Ns0g8k4993HYe.C
 7mNSuanrk33.U8e00jx7WQCKnLDQp3SVhrmeIifQAPVQu.OjMkgnchbxwjdSQUuNOIkA3D9bAVWQ
 PfJN2bjzqMpAIU9R_oqG0ePm0eG.AlcpV72xrZnC6qYQwUD900EJvVzAsC7EpTyiogGLDUhB5RtM
 _SL7Jv105s0TsAUU8TLVHJTMe5J7Mj_SeWWGZ5IVeyWaKGBNodVGeyqfCuOATg4E27.mNf5wSWEu
 5CwS9iqlrAWZGGXAP_BBst9Cub2yWqx2GUwMa8eYIJSZg0qcMXJ2_AehQQgkwF9HUEcBw8jwo_ze
 LNgwIpIgA
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 8b609f84-0906-48bc-8a41-980051ad6cc6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Wed, 31 May 2023 20:21:36 +0000
Received: by hermes--production-ir2-7867f454fc-ns8nf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID eb42ef6bd1d82c8aa9c19bb50c192c5e;
          Wed, 31 May 2023 20:21:35 +0000 (UTC)
Message-ID: <a308cd6f-0f72-6a12-aa34-ce06290ce0bb@rocketmail.com>
Date:   Wed, 31 May 2023 22:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 00/10 RESEND] Add RT5033 charger device driver
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <cover.1684182964.git.jahau@rocketmail.com>
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

Dear all,

On 15.05.23 22:57, Jakob Hauser wrote:
> This patchset adds the charger driver "rt5033-charger". It is part of the
> multifunction device rt5033. The patchset is based on an older version by
> Beomho Seo of March 2015. For more information on the history and setup of
> the patchset see the cover sheet of version v1, there is a link further down
> below the changelog.
> 
> RESEND: Sorry for spamming. The first try of sending v6 got interrupted and
> was split into two threads on the lore list. Therefore sending it again.
> 
> Changes in v6:
>   - Patch 5: In function rt5033_charger_probe() after
>     calling rt5033_charger_dt_init() replaced the return value from "-ENODEV"
>     to "PTR_ERR(charger->chg)", as suggested by Christophe.
>   - Patch 9: Changed the patch from adding "power-supplies: true" to replacing
>     "additionalProperties: false" by "unevaluatedProperties: false", as
>     suggested by Krzysztof.
> 
> v1: https://lore.kernel.org/linux-pm/cover.1677620677.git.jahau@rocketmail.com/T/#t
> v2: https://lore.kernel.org/linux-pm/cover.1681646904.git.jahau@rocketmail.com/T/#t
> v3: https://lore.kernel.org/linux-pm/cover.1682636929.git.jahau@rocketmail.com/T/#t
> v4: https://lore.kernel.org/linux-pm/20230506155435.3005-1-jahau@rocketmail.com/T/#t
> v5: https://lore.kernel.org/linux-pm/20230514123130.41172-1-jahau@rocketmail.com/T/#t
> 
> The result of the patchset v6 can be seen at:
> https://github.com/Jakko3/linux/blob/rt5033-charger_v6/drivers/power/supply/rt5033_charger.c

What's missing on this patchset? I'm not familiar with the procedures. 
If all patches need ack's, then the ones for mfd (patches 2 & 4) and for 
dt-bindings (patch 10) are missing.

Link to the current patchset v6:
- on lore: 
https://lore.kernel.org/linux-pm/cover.1684182964.git.jahau@rocketmail.com/T/#t
- on patchwork: 
https://patchwork.kernel.org/project/linux-pm/list/?series=747771&state=%2A&archive=both

> Jakob Hauser (9):
>    mfd: rt5033: Fix chip revision readout
>    mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
>    mfd: rt5033: Apply preparatory changes before adding rt5033-charger
>      driver
>    power: supply: rt5033_charger: Add RT5033 charger device driver
>    power: supply: rt5033_charger: Add cable detection and USB OTG supply
>    power: supply: rt5033_battery: Move struct rt5033_battery to battery
>      driver
>    power: supply: rt5033_battery: Adopt status property from charger
>    dt-bindings: power: supply: rt5033-battery: Apply
>      unevaluatedProperties
>    dt-bindings: Add rt5033 mfd, regulator and charger
> 
> Stephan Gerhold (1):
>    mfd: rt5033: Drop rt5033-battery sub-device
> 
>   .../bindings/mfd/richtek,rt5033.yaml          | 138 ++++
>   .../power/supply/richtek,rt5033-battery.yaml  |   2 +-
>   .../power/supply/richtek,rt5033-charger.yaml  |  65 ++
>   drivers/mfd/rt5033.c                          |   8 +-
>   drivers/power/supply/Kconfig                  |   8 +
>   drivers/power/supply/Makefile                 |   1 +
>   drivers/power/supply/rt5033_battery.c         |  38 +-
>   drivers/power/supply/rt5033_charger.c         | 744 ++++++++++++++++++
>   include/linux/mfd/rt5033-private.h            |  64 +-
>   include/linux/mfd/rt5033.h                    |  24 -
>   10 files changed, 1034 insertions(+), 58 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
>   create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
>   create mode 100644 drivers/power/supply/rt5033_charger.c

Kind regards,
Jakob
