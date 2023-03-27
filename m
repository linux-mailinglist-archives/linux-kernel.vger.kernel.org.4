Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57516CAF0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjC0Tp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjC0TpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:45:25 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6826930F7;
        Mon, 27 Mar 2023 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1679946319; bh=oxmK92xKDmUDCfivDFeZAnn0jp1onvjYGp6dhItp8CU=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=W/QSBpIY+ehzrfFrRYhdqlYndxeQINnji9LdNotUr0jtMs1fliPLNbhbIWVRkpUcG
         wM9E25XRsHkKjlqW2HAbGcw09mZqKYOQs+TurpuTJocOFWvyjikrFt0LFkG7GlZc9o
         LyeLgqRw8HMLy7bUp30APaoCba98kLojrv83pDec=
Date:   Mon, 27 Mar 2023 21:45:18 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org,
        Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Martijn Braam <martijn@brixit.nl>,
        Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rk3399-pinephone-pro: Add internal
 display support
Message-ID: <20230327194518.qkm5qgap6vkivpeg@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org,
        Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Martijn Braam <martijn@brixit.nl>,
        Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20230327074136.1459212-1-javierm@redhat.com>
 <20230327130147.wgxl2qayhzsi2xak@core>
 <87wn32rynm.fsf@minerva.mail-host-address-is-not-set>
 <1924921.PYKUYFuaPT@diego>
 <87mt3yrwzo.fsf@minerva.mail-host-address-is-not-set>
 <20230327174855.xpxrdfldqcxk463r@core>
 <87jzz2rrfr.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzz2rrfr.fsf@minerva.mail-host-address-is-not-set>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 08:15:52PM +0200, Javier Martinez Canillas wrote:
> Ondřej Jirman <megi@xff.cz> writes:
> 
> > On Mon, Mar 27, 2023 at 06:15:55PM +0200, Javier Martinez Canillas wrote:
> 
> [...]
> 
> >> 
> >> It is broken though? This is what is in Ondrej downstream tree and I see
> >> no issues on my Pinephone Pro. He mentioned some flicker when looking at
> >> the signals with a scope and hooking a photoresistor.
> >
> > LED regulator is driven out of spec by a frequency that's 20x lower than
> > recommended, if you want short version of what's broken about the DT patch.
> >
> >> But that's fair. I'll let Ondrej then post a v3 if he wants to address the
> >> issues he pointed out, since is his patch after all.
> >
> > It's not my patch. Original author of the DT is Martijn or Kamil. I just carry
> > their DT work in split-up patches in my tree, and I sometimes try to find solutions
> > to bugs I find when using PPP. That's the story of these DT changes you're posting.
> >
> > Since you posted this DT patch for upstreaming, I wanted to help you by reviewed
> > it more completely, so I opened the schematic and datasheets for the components
> > that are described in this patch, and discovered these new issues I commented
> > about. And I also tested it on top of linus/master.
> >
> > Just because something is in my tree doesn't mean it's mine, or that I reviewed
> > it in detail and prepared it for upstreaming, or that I'm interested in
> 
> Thanks for the clarification. Because the patch had your authorship I
> wrongly assumed that came from you. Sorry about the confusion.

Ever since base DT support for Pinephone Pro was merged, none of the DT patches
in my tree are in the original form as prepared by the authors + fixes I've
added. That's simply impossible anymore.

To look up who did what, you'd have to look at older branches, pre-merge.

Patches after the merge just came from squashing everything into one patch,
cleaning it up, and re-splitting along some vague functionality boundaries,
while trying to keep best-effort original SoBs as faithfully as possible, so
that I can keep maintaining the PPP support in a sane manner.

Anyway, SoB's are added in chronological order. So:

https://github.com/megous/linux/commit/471c5f33ba74c3d498ccc1eb69c098623b193926

Means the author of the changes is Martijn + Kamil (roughly) and I may have
a line of code in there too, since my SoB is last. For some reason, the order is
inverted in the patch you posted, making it seem I developed these changes
originally.

> > upstreaming it. I'm just trying to help you with your upstreaming effort by
> > testing and review since I got to know the hardware quite well over the last
> > years and can check the schematics and datasheets quickly, and I like to think
> > upstream code is held to higher standard. That's all.
> >
> 
> Appreciate your help and I agree that upstream code should be held to a
> high standard. But since the DTS in mainline is pretty basic anyways (you
> can only boot to serial right now), is not really usable for other thing
> than development and keep adding the missing support.

Having wrong frequency used is not a missing support for something. Sorry it's
too bothersome to get the review piecemeal, but sometimes people have more time to
look at patches in-depth, and at other times they don't and you just get surface
level or no review.

One point of posting patches to the mailing list is to get review. And it's not
that great to do in-depth review for you, up to going through schematics and
datasheets, testing, and even proposing and testing solutions for found issues,
just to be dismissed without technical reason.

The thing is this review will most likely happen just once, and noone will go
back, read through the entire huge DT along with a schematic, to look at whether
this or that pullup is really necessary, whether some parameter is out of spec
from the datasheet for each part, or things like that. That's just not
pragmatic.

Instead, people will happily attribute non-obvious issues caused by these
omissions of manual review to shoddy or slow or power-inefficient HW. "1kHz
+ harmonics interference in codec because high power backlight DC-DC regulator
basically spews off 1kHz of 1-2W load + harmonics because it's driven
incorrectly? Ah, the phone just has a shitty audio codec!"

So, don't take it as some perfectionism. Upstreaming just seems like the best
time to look at things that were overlooked in the past in more detail and get
these little things right, because the DT additions are done piecemal and
slowly/gradually, so it's more manageable to review and fix right away. This
will just not happen later on for these obscure devices like Pinephone Pro,
where the whole effort that goes into it is like one half of a fulltime
developer time split over 4 mildly interested real persons, slowly tapering off
over time as the device ages.

regards,
	o.

> So I thought that we could do it in steps without creating that much work
> for the people trying to post the downstream patches and having to re-spin
> too many times.
> 
> -- 
> Best regards,
> 
> Javier Martinez Canillas
> Core Platforms
> Red Hat
> 
