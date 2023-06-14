Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED12719EFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjFAOBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjFAOBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBE9184;
        Thu,  1 Jun 2023 07:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B90E64562;
        Thu,  1 Jun 2023 14:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECD8C4339B;
        Thu,  1 Jun 2023 14:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685628058;
        bh=k0lroTYvtzGNwTev1CPUc1dbilaAPIIZm6XNUqRGNLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRoX7cPhPvvJnIoEKa2MoFUn8l+YPPLQxGZp0KkE4D5M4OMjdNFagc1pic1TaDzFC
         zWOlIfTCBiIqQA//MIYLdhzh1BCBls/zq3gN062MoZvhKDRcsuJgdUqw6FGzIeSOll
         bH1QVDhTDzc74GjUpmfUajEk2dz80+XbokU4WwhLMX2y1oQCEpdPlZaL8B3xxEjxng
         nMJmY1yqGm2h2qt2uN22hTOgF7cq0eS1Nlfy5c8HLnL9I/ekUP0UUeati+kvqHi/v+
         ddhgngSXrIlfX6iJb7ax8iP9q55cnnjYoFMqssj8+Qx+RJfU5VY/M60CtPrWaxW1tj
         PUIwhunq6gX8Q==
Date:   Thu, 1 Jun 2023 15:00:49 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
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
Subject: Re: [PATCH v6 00/10 RESEND] Add RT5033 charger device driver
Message-ID: <20230601140049.GF449117@google.com>
References: <cover.1684182964.git.jahau.ref@rocketmail.com>
 <cover.1684182964.git.jahau@rocketmail.com>
 <a308cd6f-0f72-6a12-aa34-ce06290ce0bb@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a308cd6f-0f72-6a12-aa34-ce06290ce0bb@rocketmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023, Jakob Hauser wrote:

> Dear all,
> 
> On 15.05.23 22:57, Jakob Hauser wrote:
> > This patchset adds the charger driver "rt5033-charger". It is part of the
> > multifunction device rt5033. The patchset is based on an older version by
> > Beomho Seo of March 2015. For more information on the history and setup of
> > the patchset see the cover sheet of version v1, there is a link further down
> > below the changelog.
> > 
> > RESEND: Sorry for spamming. The first try of sending v6 got interrupted and
> > was split into two threads on the lore list. Therefore sending it again.
> > 
> > Changes in v6:
> >   - Patch 5: In function rt5033_charger_probe() after
> >     calling rt5033_charger_dt_init() replaced the return value from "-ENODEV"
> >     to "PTR_ERR(charger->chg)", as suggested by Christophe.
> >   - Patch 9: Changed the patch from adding "power-supplies: true" to replacing
> >     "additionalProperties: false" by "unevaluatedProperties: false", as
> >     suggested by Krzysztof.
> > 
> > v1: https://lore.kernel.org/linux-pm/cover.1677620677.git.jahau@rocketmail.com/T/#t
> > v2: https://lore.kernel.org/linux-pm/cover.1681646904.git.jahau@rocketmail.com/T/#t
> > v3: https://lore.kernel.org/linux-pm/cover.1682636929.git.jahau@rocketmail.com/T/#t
> > v4: https://lore.kernel.org/linux-pm/20230506155435.3005-1-jahau@rocketmail.com/T/#t
> > v5: https://lore.kernel.org/linux-pm/20230514123130.41172-1-jahau@rocketmail.com/T/#t
> > 
> > The result of the patchset v6 can be seen at:
> > https://github.com/Jakko3/linux/blob/rt5033-charger_v6/drivers/power/supply/rt5033_charger.c
> 
> What's missing on this patchset? I'm not familiar with the procedures. If
> all patches need ack's, then the ones for mfd (patches 2 & 4) and for
> dt-bindings (patch 10) are missing.

You're waiting on me.  I will apply all of the patches and submit a PR.

You're in the queue - please stand-by.
 
> Link to the current patchset v6:
> - on lore: https://lore.kernel.org/linux-pm/cover.1684182964.git.jahau@rocketmail.com/T/#t
> - on patchwork: https://patchwork.kernel.org/project/linux-pm/list/?series=747771&state=%2A&archive=both
> 
> > Jakob Hauser (9):
> >    mfd: rt5033: Fix chip revision readout
> >    mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
> >    mfd: rt5033: Apply preparatory changes before adding rt5033-charger
> >      driver
> >    power: supply: rt5033_charger: Add RT5033 charger device driver
> >    power: supply: rt5033_charger: Add cable detection and USB OTG supply
> >    power: supply: rt5033_battery: Move struct rt5033_battery to battery
> >      driver
> >    power: supply: rt5033_battery: Adopt status property from charger
> >    dt-bindings: power: supply: rt5033-battery: Apply
> >      unevaluatedProperties
> >    dt-bindings: Add rt5033 mfd, regulator and charger
> > 
> > Stephan Gerhold (1):
> >    mfd: rt5033: Drop rt5033-battery sub-device
> > 
> >   .../bindings/mfd/richtek,rt5033.yaml          | 138 ++++
> >   .../power/supply/richtek,rt5033-battery.yaml  |   2 +-
> >   .../power/supply/richtek,rt5033-charger.yaml  |  65 ++
> >   drivers/mfd/rt5033.c                          |   8 +-
> >   drivers/power/supply/Kconfig                  |   8 +
> >   drivers/power/supply/Makefile                 |   1 +
> >   drivers/power/supply/rt5033_battery.c         |  38 +-
> >   drivers/power/supply/rt5033_charger.c         | 744 ++++++++++++++++++
> >   include/linux/mfd/rt5033-private.h            |  64 +-
> >   include/linux/mfd/rt5033.h                    |  24 -
> >   10 files changed, 1034 insertions(+), 58 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
> >   create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
> >   create mode 100644 drivers/power/supply/rt5033_charger.c
> 
> Kind regards,
> Jakob

-- 
Lee Jones [李琼斯]
