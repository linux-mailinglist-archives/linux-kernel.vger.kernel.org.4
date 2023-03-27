Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C926E6CA9B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjC0P54 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 11:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjC0P5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:57:54 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568373588;
        Mon, 27 Mar 2023 08:57:51 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pgpE4-000614-21; Mon, 27 Mar 2023 17:57:40 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     =?utf-8?B?T25kxZllag==?= Jirman <megi@xff.cz>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Martijn Braam <martijn@brixit.nl>,
        Kamil =?utf-8?B?VHJ6Y2nFhHNraQ==?= <ayufan@ayufan.eu>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rk3399-pinephone-pro: Add internal display support
Date:   Mon, 27 Mar 2023 17:57:39 +0200
Message-ID: <1924921.PYKUYFuaPT@diego>
In-Reply-To: <87wn32rynm.fsf@minerva.mail-host-address-is-not-set>
References: <20230327074136.1459212-1-javierm@redhat.com>
 <20230327130147.wgxl2qayhzsi2xak@core>
 <87wn32rynm.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. März 2023, 17:39:57 CEST schrieb Javier Martinez Canillas:
> Ondřej Jirman <megi@xff.cz> writes:
> 
> Hell Ondřej,
> 
> > Hi Javier,
> >
> > I've tried the patch on top of linus/master and it works as expected. My
> > DRM test app shows 16.669ms between frames. The display output is ok on
> > developer batch pinephone pro, and is corrupted on production version.
> > Display also doesn't come back after blanking. All as expected.
> >
> > Tested-by: Ondrej Jirman <megi@xff.cz>
> >
> 
> Thanks for testing.
> 
> > A few more comments below.
> >
> 
> I'm OK with these comments but I did a git diff with your orange-pi-6.3
> branch just before posting and this was the latest that's in your tree.
> 
> So feel free to either post a v3 addressing the things you are pointing
> out or lets land this and we can post any further cleanups on top IMO.

I would really like to _not_ apply essentially broken code, so really
would prefer the v3-approach.

Thanks
Heiko


