Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4F565D7D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbjADQFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjADQFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:05:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EBFB86;
        Wed,  4 Jan 2023 08:05:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCD8AB8169E;
        Wed,  4 Jan 2023 16:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7075DC433D2;
        Wed,  4 Jan 2023 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672848311;
        bh=JJul7yCNDp+w5GEK764w15reZx1qVqVJLDDBijdqf9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ke5zuvTAcSaLbRCxRqI5qC7Io3RSMDqf4/U+JmnCQMI+kqBqvP9LHOCYBeuukXg80
         oEuyZUrNUv4MQmeE1zeMJIcbqgMibYkDN2iaGTv6vUE6DUrFXTvN+nQDD2H4iSeJSq
         f/LYWPxQgIhdncxVJxfQ9nQTEwYDIBHHRUzvWPqS2jMu/PBIv4EzEh2aa1hd4/YEm/
         jtDBkjV9ODz1MG0oUC5YXfzKCWd6PNt3itO7u5k3VdMl5j26d7bP2omavrob9HlPxB
         5mUfmOXTgVWWveldCMEn2Lf3aHM8ZRMeDMfQraz+obRSvega0aKgwo6nlcKAnMoO/j
         w3Gk+WH5EMWGw==
Date:   Wed, 4 Jan 2023 16:05:02 +0000
From:   Lee Jones <lee@kernel.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
Message-ID: <Y7WjrrSvLanjNhyX@google.com>
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
 <20221221210917.458537-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdXDwEUzBpG+w_G6=CzKo=n92cdVw6v8JwOwf9o86HnOZQ@mail.gmail.com>
 <TYWPR01MB87758FB15ED12D396AE738DDC2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <Y7Qk/EgOI9mkJIjn@google.com>
 <TYWPR01MB87753C261831519F4D6788E5C2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <Y7WObZFfsCJuMdLW@google.com>
 <TYWPR01MB877591E80CE112429DE3FC9BC2F59@TYWPR01MB8775.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYWPR01MB877591E80CE112429DE3FC9BC2F59@TYWPR01MB8775.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > If you do not have any resources to share, you can simply register
> > each
> > > > of the devices via Device Tree.  I do not see a valid reason to force
> > a
> > > > parent / child relationship for your use-case.
> > >
> > > There would probably be overlapping on the same memory region, which
> > would
> > > lead to ioremapping the same region multiple times, which is something
> > > I would prefer to avoid if possible.
> > 
> > Okay, so you *do* have shared resources.
> > 
> > In which case, why is simple-mfd not working for you?
> 
> The corresponding dt-bindings got rejected, unfortunately. I had to drop
> simple-mfd as a result of dropping the children of my simple-mfd DT node.

You have to write DT bindings to be OS agnostic.

They *must* match the H/W.  Little else matters.

How we interpret those in Linux is flexible however.

-- 
Lee Jones [李琼斯]
