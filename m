Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0766CC42
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjAPRXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbjAPRWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:22:47 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD134C2E;
        Mon, 16 Jan 2023 09:00:53 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a184so21401437pfa.9;
        Mon, 16 Jan 2023 09:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSIOC3Gn/9SIls3qNZfym7CwZZUFwTyp9pKmMhHwRqw=;
        b=B1j5WC6MnTb42cuh6VictjIgWVZG7QH98yEBI0k+nE+A1PIO54u03mKy3FAuu7WED+
         ukh4JMdWmFT4Tr7+jVPY7PzZH7HiqIDlZfzFhlPqORPACvyUnwEp0yvMPQJPGbeLPhY9
         DQTqHPgGobH9CyTTS3Q8hF32ploqTTMXheyXN9zX1CxYlE3+JJayF6qICdNoY1Zz6E10
         TOp/CWQkjJF4GwPkoQsgXwDiyMv8j6xnn8DFjFaCBhnJgd/MggW9MqKS+Sloz2Q39577
         gF8P1ymHC9sJl1dlwtq2Ihu0DiYPG+xcrXjELIy5siWZW2lQi58yCkyJD2iql9qGvntw
         VXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSIOC3Gn/9SIls3qNZfym7CwZZUFwTyp9pKmMhHwRqw=;
        b=yanzHKs6Vdpc3lK52cx2/isSLnasZ8PbBOzhNcifoHByOsbHkdqB/1PI52SQljV/2J
         cR+z74I0kg8fn49WvjnTF00vd5SmsAbJulyVqRKsPibRhzxHMM13A/pn7ipAi+fjWFKS
         I8v8H6r1vGcAv6Z3v9vO0Rj3Z07EKYzoCMUzSxAio/djUOQfJBwe4uBaxXxr5F18BSjQ
         2d12+ZEpMCPKIBIRmEUkC6RDIJP8fblrM8iMDH4GK3vE6inBlYYENThKrmDr63hE6+12
         g9bzkWPfrJRsb/fWHsOuCjjb2VG5Xqmfb7yxVSBM1FrMWZmmd/UDp7anCSmQ2UZa2ZuR
         6fvw==
X-Gm-Message-State: AFqh2kpFaNVH+U34ncEjASSOoHLetOzQHe9Aw89HX+dbJFFJhCeYSKxB
        ywx/aD5abdbG1UCzgttLEp4FB55XfsT6sX30sN0=
X-Google-Smtp-Source: AMrXdXv/LO2/K03rf6b9myWHkk8T+BNwlcIsLrELXDR8PTS94Cu6I9Fgwpwx6gphca7WKRutzEOgxVZJbwQXzcZZs58=
X-Received: by 2002:a05:6a00:1995:b0:582:33b5:3f4b with SMTP id
 d21-20020a056a00199500b0058233b53f4bmr21317pfl.19.1673888452323; Mon, 16 Jan
 2023 09:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20230113211151.2314874-1-andreas@kemnade.info>
 <CAHCN7xJH+c41Yas+xnWA57KNi9arOOJDxJ=joEDEJr2k6jrRrw@mail.gmail.com>
 <Y8VkjQ2yZQssx/wJ@atomide.com> <20230116173922.585904bf@aktux> <Y8WBuKt6mw6TN1Cp@atomide.com>
In-Reply-To: <Y8WBuKt6mw6TN1Cp@atomide.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 16 Jan 2023 11:00:41 -0600
Message-ID: <CAHCN7x+b2_dnpRs8RarhhgTfBrTVfGfmcQNbfHLoWBwkZ_3Puw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: gta04: fix excess dma channel usage
To:     Tony Lindgren <tony@atomide.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 10:56 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Andreas Kemnade <andreas@kemnade.info> [230116 16:39]:
> > On Mon, 16 Jan 2023 16:51:57 +0200
> > Tony Lindgren <tony@atomide.com> wrote:
> >
> > > Hi,
> > >
> > > * Adam Ford <aford173@gmail.com> [230116 14:16]:
> > > > Would it make sense to make this default in the omap3.dtsi file and
> > > > enable them in the individual boards that need it?
> > >
> > > In general disabling the unused devices by default for omaps will break
> > > the power management. The disabled devices are completely ignored by the
> > > kernel, and the devices are left to whatever the bootloader state might
> > > be.
> > >
> > hmm, shouldn't ti-sysc keep things disabled in most cases? It is still a bit
> > known because there is no status = "disabled" in the target-module@xxx node.
>
> Oh right, if the child device is tagged disabled (instead of the the parent
> ti-sysc tagged disabled) the module should get idled just fine as long as the
> module related quirks are implemented for ti-sysc.c.
>
> But still, I'd rather not start tagging devices disabled by default and then
> re-enabling everywhere since we never needed it before. It just adds a lot
> of pointless status tinkering, see commit 12afc0cf8121 ("ARM: dts: Drop
> pointless status changing for am3 musb").
>
> So considering things, IMO it's best to set only the child device with
> status disabled, and set it at the board specific dts file in this case.

Doesn't this imply the target-module stuff needs to be implemented for
the drivers?  It looks like a lot of the omap3 drivers are still using
hwmods although some have target-modules. In this case, the mcspi
drivers that Andreas is disabling don't appear to have target-module
stuff configured.

adam

>
> Also note that the dma channels could be freed with /delete-property/ at the
> board specific dts file even for devices that are usable if not really
> needed.
>
> Regards,
>
> Tony
>
