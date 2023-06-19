Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3059C73528B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjFSKgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjFSKfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7B3173D;
        Mon, 19 Jun 2023 03:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0CAE60B6D;
        Mon, 19 Jun 2023 10:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC56C433C9;
        Mon, 19 Jun 2023 10:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687170931;
        bh=5dt6l3lx8FHqgt+yEGvI0hRPuTRkjicnDuM52S/ToEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZektIom2LsRtOyxwQz8sOmWcQciXT8JR4ZjkunidMtKtQvHPoKihYbDXYj7jb8/vU
         hPNrYAL0YBaU3WLs0kYtWu+mwxs/owBgjD3NNWW8lgIWnbFSRFYNXZ9drkrNS/EGqV
         g1XzT83U7UMZ7vH1hzwvYbcih25AMOhSnfOWGTQueLHP2klGaqI81AUmvZlhb7A3ld
         11BHHDw733l04et6x9BJwan0nQ0019Z1TQJ81ni18nKLyKxWGtxvG20zPDonFh5MGF
         0P/gCyZ2aDF9HXTlpWTWffoh0r3YT5XW/jGQg1Evijre2cX8IagbSdg53Z2EQXJ3je
         N36FmOjONZjXA==
Date:   Mon, 19 Jun 2023 11:35:24 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
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
Subject: Re: [GIT PULL] Immutable branch between MFD and Power due for the
 v6.5 merge window
Message-ID: <20230619103524.GA1472962@google.com>
References: <cover.1684182964.git.jahau.ref@rocketmail.com>
 <cover.1684182964.git.jahau@rocketmail.com>
 <20230609064753.GL3635807@google.com>
 <faff027d-2a6a-22ca-2487-2ae05223fabd@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <faff027d-2a6a-22ca-2487-2ae05223fabd@rocketmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian,

On Fri, 16 Jun 2023, Jakob Hauser wrote:
> On 09.06.23 08:47, Lee Jones wrote:
> > Enjoy!
> > 
> > The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
> > 
> >    Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
> > 
> > are available in the Git repository at:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-power-v6.5
> > 
> > for you to fetch changes up to b54185c1e3b02c91e4a190ac5c346ea7bfb0de93:
> > 
> >    dt-bindings: Add rt5033 MFD, Regulator and Charger (2023-06-08 18:18:13 +0100)
> > 
> > ----------------------------------------------------------------
> > Immutable branch between MFD and Power due for the v6.5 merge window
> > 
> > ----------------------------------------------------------------
> > Jakob Hauser (8):
> >        mfd: rt5033: Fix chip revision readout
> >        mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
> >        mfd: rt5033: Apply preparatory changes before adding rt5033-charger driver
> >        power: supply: rt5033_charger: Add RT5033 charger device driver
> >        power: supply: rt5033_battery: Move struct rt5033_battery to battery driver
> >        power: supply: rt5033_battery: Adopt status property from charger
> >        dt-bindings: power: supply: rt5033-battery: Apply unevaluatedProperties
> >        dt-bindings: Add rt5033 MFD, Regulator and Charger
> > 
> > Stephan Gerhold (1):
> >        mfd: rt5033: Drop rt5033-battery sub-device
> > 
> >   .../devicetree/bindings/mfd/richtek,rt5033.yaml    | 138 ++++++
> >   .../power/supply/richtek,rt5033-battery.yaml       |   2 +-
> >   .../power/supply/richtek,rt5033-charger.yaml       |  65 +++
> >   drivers/mfd/rt5033.c                               |   8 +-
> >   drivers/power/supply/Kconfig                       |   8 +
> >   drivers/power/supply/Makefile                      |   1 +
> >   drivers/power/supply/rt5033_battery.c              |  38 +-
> >   drivers/power/supply/rt5033_charger.c              | 472 +++++++++++++++++++++
> >   include/linux/mfd/rt5033-private.h                 |  64 ++-
> >   include/linux/mfd/rt5033.h                         |  24 --
> >   10 files changed, 762 insertions(+), 58 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
> >   create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
> >   create mode 100644 drivers/power/supply/rt5033_charger.c
> > 
> 
> I just realized that there is one patch missing in the immutable branch
> "ib-mfd-power-v6.5" [1]. Unfortunately I haven't noticed earlier. The
> immutable branch holds 9 patches, the patchset has 10 patches [2]. The
> missing patch is No. 6 "power: supply: rt5033_charger: Add cable detection
> and USB OTG supply".

Did you take this pull-request?

If so, would you like to apply the missing patch or would you like me to
take it via MFD (without a subsequent PR)?

> As this patch No. 6 affects only the file
> drivers/power/supply/rt5033_charger.c and is the last patch on that file,
> it's no problem to add this patch on top of the other patches.
> 
> Could you submit another pull request for the v6.5 merge window to add this
> patch?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=ib-mfd-power-6.5
> [2] https://lore.kernel.org/linux-pm/cover.1684182964.git.jahau@rocketmail.com/T/#t

-- 
Lee Jones [李琼斯]
