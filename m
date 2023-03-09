Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265E26B2573
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCINbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCINaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:30:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587BDF1693;
        Thu,  9 Mar 2023 05:30:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 384D1B81EE0;
        Thu,  9 Mar 2023 13:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBCAC433A8;
        Thu,  9 Mar 2023 13:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678368552;
        bh=7V354Spv5IUkBJIg8jXo9ixLOnbIWtGCEOzt13+mHNY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZgAs1LHavVbpt/2FRRvMTB/isX7s1oq2Mm6axPkOQ/aw0tKiJDq79Ondp3TmP41r0
         3n21y80t5sxyiKTEZMcMJAM+5CRE6Rg5f3AbL1Bph7we57LZNHbQyzDrmEpnucPB0j
         xwv2BgFbTFd0WEqL6nvXp4p70U2ezTFxAIuqqN2x8IV02TuRue60dI6esijQSLgfty
         OVRFEKNPNRCLETk1b0JxhKEINeQh+6t8IT3Yo/FrBnmba1K2lvGb/7UUBaVomO9zOE
         jf4TsdLZbmhrTqTq9K87/qugmwE2fGfCX3AqT2ieHZ9lgl6w5WH0jTB3oVtJ7lC9lo
         IgtgKZTGCEWvw==
Received: by mail-ua1-f52.google.com with SMTP id v48so1117233uad.6;
        Thu, 09 Mar 2023 05:29:11 -0800 (PST)
X-Gm-Message-State: AO0yUKWh0cWxozuYLcA4H/T3ICiftC/CZtEjRxdfczVT+VyZOrtWMzPy
        bN5HbQw45VNpCucILjvUNCemSuf53iIJouNqDQ==
X-Google-Smtp-Source: AK7set/UtlhkNYhNExNPyFO1gM3SmkCcbPOZsx+tIDLnmUllfa/2k5vXtp1lR3nqmqn8GAzcbB+evRXlrjrOrrh5PSQ=
X-Received: by 2002:ab0:4a1a:0:b0:68b:8665:a73b with SMTP id
 q26-20020ab04a1a000000b0068b8665a73bmr13895606uae.1.1678368550753; Thu, 09
 Mar 2023 05:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
 <20230307165359.225361-4-miquel.raynal@bootlin.com> <20230308001903.GA513330-robh@kernel.org>
 <fca549f7-a79a-4d8f-b609-efef830becd2@mercury.local>
In-Reply-To: <fca549f7-a79a-4d8f-b609-efef830becd2@mercury.local>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 9 Mar 2023 07:28:59 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+bs1mxdTTeazhzD39fV0EBjCKZ_HKKjLpWgSezTLJ-4A@mail.gmail.com>
Message-ID: <CAL_Jsq+bs1mxdTTeazhzD39fV0EBjCKZ_HKKjLpWgSezTLJ-4A@mail.gmail.com>
Subject: Re: [PATCH v2 03/21] of: Rename of_modalias_node()
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 4:06=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Tue, Mar 07, 2023 at 06:19:03PM -0600, Rob Herring wrote:
> > On Tue, Mar 07, 2023 at 05:53:41PM +0100, Miquel Raynal wrote:
> > > This helper does not produce a real modalias, but tries to get the
> > > "product" compatible part of the "vendor,product" compatibles only. I=
t
> > > is far from creating a purely useful modalias string and does not see=
m
> > > to be used like that directly anyway, so let's try to give this helpe=
r a
> > > more meaningful name before moving there a real modalias helper (alre=
ady
> > > existing under of/device.c).
> > >
> > > Also update the various documentations to refer to the strings as
> > > "aliases" rather than "modaliases" which has a real meaning in the Li=
nux
> > > kernel.
> > >
> > > There is no functional change.
> > >
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > > Cc: Len Brown <lenb@kernel.org>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > > Cc: Wolfram Sang <wsa@kernel.org>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/acpi/bus.c                |  7 ++++---
> > >  drivers/gpu/drm/drm_mipi_dsi.c    |  2 +-
> > >  drivers/hsi/hsi_core.c            |  2 +-
> >
> > These should not have been using this function. The matching on just th=
e
> > product was a relic from I2C and SPI which we don't want to propogate.
> > No clue why ACPI needed it...
> >
> > If you respin or want to fixup while applying, can you add a kerneldoc
> > comment to not add new users of the function. Not that anyone will
> > follow that... :(
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> I just checked and HSI is not using the data for matching. Instead
> it uses the returned data to set the device name. Matching happens
> using the full compatible.
>
> FWIW the MIPI HSI standard never became a big thing, so we have only
> one HSI DT driver upstream and that is the Nokia N900 modem driver.

Can we add a patch in removing the call then.

I'm pretty sure MIPI stands for Must Invent Peripheral Interfaces.

Rob
