Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD760E5DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiJZQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbiJZQ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:56:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1869AC11;
        Wed, 26 Oct 2022 09:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5B2CB82389;
        Wed, 26 Oct 2022 16:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CAAC43147;
        Wed, 26 Oct 2022 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666803409;
        bh=Vi8sx4aHNpojzRYzXmqjTrqY6mW5GyQ8eA3RJ1HlulQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=anP5j2gqPlA0CJUatDTr2DdhObFHUzWHqJfMkJ2XwAhpxjrmo9+g3+huQbX1jq544
         dNvq+Lj+aO/+ADOWr3wMz3fPM3StPYP/BfgTuiuQtLGzqen1ftnp7HbBCH7mIJ3YjD
         LnkRpUl4PufDhzyKpxewCF7hyXIuLHL+s9037D29o1S/gtMMd+BQhzQeHEjgvKnNXL
         XC3CiCVHG8umwyfVnrYHjNUl+hfoeFRHSvUpYOAqUjajznc5qyqe+Ky8taqLCzy2Mf
         C2t7zJBY/wlYUluEPXIfKLsZcWgUnTeZMCwe8V6Biv91Yv6X/JzJBoaZ3Eu2KI7QGg
         BNbjBnSBRx0Og==
Received: by mail-lf1-f46.google.com with SMTP id j4so30022202lfk.0;
        Wed, 26 Oct 2022 09:56:49 -0700 (PDT)
X-Gm-Message-State: ACrzQf2EELtfqnjpRayPEpG6FYES/RVUNYGAwI8WIm5TYRk9X7y6R1OH
        LaUkqKnpk1NSyvtzIrN8Iwn6zGfpsqA+kEWz7g==
X-Google-Smtp-Source: AMsMyM6LrfSRjX/HUKVBgz4AtfsuMXbX9k+asKJtcIXDWCakd6ADGIkff/pXR6/xCmQI+exsymHAHErxpqcm1TMu7Gw=
X-Received: by 2002:a05:6512:3f0e:b0:4a0:45b7:a8dc with SMTP id
 y14-20020a0565123f0e00b004a045b7a8dcmr16030816lfa.368.1666803407497; Wed, 26
 Oct 2022 09:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAL_JsqKC_BJDJLLFck_0CbQ-0rZ0oVWMAdiwwGep23nh2pP19g@mail.gmail.com>
 <CA+V-a8vMLuzJ8h5UDNXUiZRXPV1vJ9gguUMywe_+sPcU8tK+tA@mail.gmail.com>
 <20221014214029.GA2937999-robh@kernel.org> <Y0pLDFMsFmHhC/R8@pendragon.ideasonboard.com>
In-Reply-To: <Y0pLDFMsFmHhC/R8@pendragon.ideasonboard.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Oct 2022 11:56:38 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+K72HEEqA2inRRgk4wHjLsueJhvrLPTXFpfhnGK3HJiQ@mail.gmail.com>
Message-ID: <CAL_Jsq+K72HEEqA2inRRgk4wHjLsueJhvrLPTXFpfhnGK3HJiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] media: dt-bindings: ov5645: Convert OV5645 binding
 to a schema
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 12:54 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> On Fri, Oct 14, 2022 at 04:40:29PM -0500, Rob Herring wrote:
> > On Fri, Oct 14, 2022 at 10:27:53PM +0100, Lad, Prabhakar wrote:
> > > On Fri, Oct 14, 2022 at 10:05 PM Rob Herring <robh+dt@kernel.org> wrote:
> > > > On Fri, Oct 14, 2022 at 1:35 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > >
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Convert the simple OV5645 Device Tree binding to json-schema.
> > > > >
> > > > > The previous binding marked the below properties as required which was a
> > > > > driver requirement and not the device requirement so just drop them from
> > > > > the required list during the conversion.
> > > > > - clock-frequency
> > > > > - enable-gpios
> > > > > - reset-gpios
> > > > >
> > > > > Also drop the "clock-names" property as we have a single clock source for
> > > > > the sensor and the driver has been updated to drop the clk referencing by
> > > > > name.
> > > >
> > > > Driver requirements are the ABI!
> > > >
> > > > This breaks a kernel without the driver change and a DTB that has
> > > > dropped the properties.
> > > >
> > > I already have a patch for the driver [0] which I missed to include
> > > along with the series.
> >
> > You completely miss the point. Read the first sentence again. Changing
> > driver requirements changes the ABI.
> >
> > This breaks the ABI. The driver patch does not help that.
>
> I'm not following you here. If the DT binding makes a mandatory property
> optional, it doesn't break any existing platform. The only thing that
> would not work is a new DT that doesn't contain the now optional
> property combined with an older driver that makes it required. That's
> not a regression, as it would be a *new* DT.
>
> > > > Also, with 'clock-names' dropped, you've just introduced a bunch of
> > > > warnings on other people's platforms. Are you going to 'fix' all of
> > > > them?
> > > >
> > > Yes I will fix them, once the patch driver patch [0] is merged in.
> >
> > Why? You are just making extra work. We have enough warnings as-is to
> > fix.
>
> I agree that a DT binding change should patch all in-tree DTS to avoid
> introducing new warnings.

That is not what I was saying. Why not just keep 'clock-names' and go
spend the DTS fixing time fixing some other warnings that we already
have. Also, there is no requirement that converting bindings also fix
DTS files. The only wish is that any warnings we do see are ones
deemed needing to be fixed in the DTS file.

Anyways, there's patches now for the new warnings, so nevermind on this one.

Rob
