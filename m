Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3BC6CB79B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjC1HG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC1HG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:06:26 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8D2681;
        Tue, 28 Mar 2023 00:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eYBnUlsCULcl9F5IqWLKlsEwry61lEH/hm9ZY2E0v18=; b=oxCTpwwPOrlp+dYMglAS+hxi0O
        QdS/76SytGhA6O/LUrLBbQL7yqg+AOiwM1osRVehNhnwL7BZbESWNRBXABZyiy4iCyZz/06QPGPEM
        u6P5CmWAbGohj0sf5YBACPWXR7nGU9XL76cN+Nr14VG7vU5RnslrZrjROMhMqIy0wiETUvavkUWeU
        oa5hJnWooOaGbRkrt68Y0uK38seNJ3SQAFQx18qIUlNkio1aVqvMj9ArHkq/DLAfs5/5TC7VZRYEh
        p/+PqQmjwCA17PuSB5RONJfUWKwzsgrBu14Ksy6WIg7tuLatKiH8Oli6iGSTEjl8wgg3NdJpYGuoA
        SF+Xul+A==;
Received: from p200300ccff15bb001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff15:bb00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ph3PA-0002DP-Jz; Tue, 28 Mar 2023 09:06:04 +0200
Date:   Tue, 28 Mar 2023 09:06:03 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Andrew Davis <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 1/2] ARM: dts: omap: Drop ti,omap36xx compatible
Message-ID: <20230328090603.317196c7@aktux>
In-Reply-To: <20230328050115.GI7501@atomide.com>
References: <20230216153339.19987-1-afd@ti.com>
        <20230216153339.19987-2-afd@ti.com>
        <20230327211838.580af7a9@aktux>
        <20230328050115.GI7501@atomide.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 08:01:15 +0300
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [230327 19:18]:
> > On Thu, 16 Feb 2023 09:33:38 -0600
> > Andrew Davis <afd@ti.com> wrote:
> >   
> > > This was not matched anywhere and provides no additional information.
> > > 
> > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > ---
> > >  arch/arm/boot/dts/omap3-beagle-xm.dts              | 2 +-
> > >  arch/arm/boot/dts/omap3-cm-t3730.dts               | 2 +-
> > >  arch/arm/boot/dts/omap3-igep0020-rev-f.dts         | 2 +-
> > >  arch/arm/boot/dts/omap3-igep0020.dts               | 2 +-
> > >  arch/arm/boot/dts/omap3-igep0030-rev-g.dts         | 2 +-
> > >  arch/arm/boot/dts/omap3-igep0030.dts               | 2 +-
> > >  arch/arm/boot/dts/omap3-lilly-dbb056.dts           | 2 +-
> > >  arch/arm/boot/dts/omap3-n9.dts                     | 2 +-
> > >  arch/arm/boot/dts/omap3-n950.dts                   | 2 +-
> > >  arch/arm/boot/dts/omap3-overo-storm-alto35.dts     | 2 +-
> > >  arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts | 2 +-
> > >  arch/arm/boot/dts/omap3-overo-storm-gallop43.dts   | 2 +-
> > >  arch/arm/boot/dts/omap3-overo-storm-palo35.dts     | 2 +-
> > >  arch/arm/boot/dts/omap3-overo-storm-palo43.dts     | 2 +-
> > >  arch/arm/boot/dts/omap3-overo-storm-summit.dts     | 2 +-
> > >  arch/arm/boot/dts/omap3-overo-storm-tobi.dts       | 2 +-
> > >  arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts    | 2 +-
> > >  arch/arm/boot/dts/omap3-pandora-1ghz.dts           | 2 +-
> > >  arch/arm/boot/dts/omap3-sbc-t3730.dts              | 2 +-
> > >  arch/arm/boot/dts/omap3-sniper.dts                 | 2 +-
> > >  arch/arm/boot/dts/omap3-zoom3.dts                  | 2 +-
> > >  21 files changed, 21 insertions(+), 21 deletions(-)
> > >   
> > hmm, we have
> > drivers/clk/ti/dpll.c:         of_machine_is_compatible("ti,omap36xx"))
> > 
> > but that is more completely
> >   if ((of_machine_is_compatible("ti,omap3630") ||
> >              of_machine_is_compatible("ti,omap36xx")) &&
> > 
> > so missing omap36xx will not harm if 3630 is there. SO this should
> > be probably ok.  
> 
> Looks like we still have these that should be patched away first:
> 
> drivers/cpufreq/ti-cpufreq.c-   { .compatible = "ti,omap34xx", .data = &omap34xx_soc_data, },
> drivers/cpufreq/ti-cpufreq.c:   { .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
>
seen that but there is also
    { .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
    { .compatible = "ti,omap3630", .data = &omap36xx_soc_data, },

so, no trouble will appear when omap36xx is removed.

Regards,
Andreas
