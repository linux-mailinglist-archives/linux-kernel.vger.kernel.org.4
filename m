Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE606CAC31
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjC0Rt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjC0RtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:49:11 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE440E7;
        Mon, 27 Mar 2023 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1679939336; bh=PipWPWkBFS1GgoXZt9XVYf8bnGqWk6b5DvNg8L6icis=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=oFt0UzfsxU3d6jLwx+2Zz5OB3qb6w3eIp31DHUKAgjTJRfQKpvpIXEsHuh1X3JNQ3
         IH3jQRfELvITxHZHpaHL2+yHL3UOqsMKAqNKORvCcmzpaGN34IeAAHpvjKFA0pnvix
         RlRFbNITTZr0fKwMeVHgBE3KKB5ATx7gRwsdjBu4=
Date:   Mon, 27 Mar 2023 19:48:55 +0200
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
Message-ID: <20230327174855.xpxrdfldqcxk463r@core>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mt3yrwzo.fsf@minerva.mail-host-address-is-not-set>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 06:15:55PM +0200, Javier Martinez Canillas wrote:
> Heiko Stübner <heiko@sntech.de> writes:
> 
> Hello Heiko,
> 
> > Am Montag, 27. März 2023, 17:39:57 CEST schrieb Javier Martinez Canillas:
> >> Ondřej Jirman <megi@xff.cz> writes:
> >> 
> >> Hell Ondřej,
> >> 
> >> > Hi Javier,
> >> >
> >> > I've tried the patch on top of linus/master and it works as expected. My
> >> > DRM test app shows 16.669ms between frames. The display output is ok on
> >> > developer batch pinephone pro, and is corrupted on production version.
> >> > Display also doesn't come back after blanking. All as expected.
> >> >
> >> > Tested-by: Ondrej Jirman <megi@xff.cz>
> >> >
> >> 
> >> Thanks for testing.
> >> 
> >> > A few more comments below.
> >> >
> >> 
> >> I'm OK with these comments but I did a git diff with your orange-pi-6.3
> >> branch just before posting and this was the latest that's in your tree.
> >> 
> >> So feel free to either post a v3 addressing the things you are pointing
> >> out or lets land this and we can post any further cleanups on top IMO.
> >
> > I would really like to _not_ apply essentially broken code, so really
> > would prefer the v3-approach.
> >
> 
> It is broken though? This is what is in Ondrej downstream tree and I see
> no issues on my Pinephone Pro. He mentioned some flicker when looking at
> the signals with a scope and hooking a photoresistor.

LED regulator is driven out of spec by a frequency that's 20x lower than
recommended, if you want short version of what's broken about the DT patch.

> But that's fair. I'll let Ondrej then post a v3 if he wants to address the
> issues he pointed out, since is his patch after all.

It's not my patch. Original author of the DT is Martijn or Kamil. I just carry
their DT work in split-up patches in my tree, and I sometimes try to find solutions
to bugs I find when using PPP. That's the story of these DT changes you're posting.

Since you posted this DT patch for upstreaming, I wanted to help you by reviewed
it more completely, so I opened the schematic and datasheets for the components
that are described in this patch, and discovered these new issues I commented
about. And I also tested it on top of linus/master.

Just because something is in my tree doesn't mean it's mine, or that I reviewed
it in detail and prepared it for upstreaming, or that I'm interested in
upstreaming it. I'm just trying to help you with your upstreaming effort by
testing and review since I got to know the hardware quite well over the last
years and can check the schematics and datasheets quickly, and I like to think
upstream code is held to higher standard. That's all.

kind regards,
	o.


> -- 
> Best regards,
> 
> Javier Martinez Canillas
> Core Platforms
> Red Hat
> 
