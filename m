Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26A1663D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjAJKJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjAJKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:09:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C54D731;
        Tue, 10 Jan 2023 02:09:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C415061589;
        Tue, 10 Jan 2023 10:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB743C433D2;
        Tue, 10 Jan 2023 10:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673345366;
        bh=wbyd3dtAWj+DS0fcJULsfdTl+t+d2B5Uw2ZuQAp6tpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKJ7hEZZUPaCSNrB26CzNsDjquQbBentUhlmtWHZJjjl5ajSRsc2cY1J6TlsbuK52
         UoeGdRXnxLZ8mTjHgbPSqEmh732Odonfjc467CustS3+5wXOJ8G7sxPOOj5OmOUNRy
         w0kKUTLk2m70RapGM9Y4KlCXmcVOjK/OPWsBagysaySfqoZm82qlsKdYmxswDYrer+
         TbB8sWFTiUPd3iYuGD/0RfH2xQw1GdiwwQtq6XoVkDXuGvwSpzZu+xjIKPR/5OQlxm
         16rTc6Mfdvm4x7QdvW8p5nVL1YDBiVFkf6NsLekUIa2pYUR8HMFXdeiKexpKNRNiyO
         ttG8j2EPjTphQ==
Date:   Tue, 10 Jan 2023 10:09:18 +0000
From:   Lee Jones <lee@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH 15/15] backlight: backlight: Drop the deprecated fb_blank
 property
Message-ID: <Y705TvBPWkHzeMrp@google.com>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-15-1bd9bafb351f@ravnborg.org>
 <Y7v1OxdowGdxgvUj@aspen.lan>
 <Y7xAgHgg0sfh32Ga@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7xAgHgg0sfh32Ga@ravnborg.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023, Sam Ravnborg wrote:

> Hi Daniel.
> 
> On Mon, Jan 09, 2023 at 11:06:35AM +0000, Daniel Thompson wrote:
> > On Sat, Jan 07, 2023 at 07:26:29PM +0100, Sam Ravnborg via B4 Submission Endpoint wrote:
> > > From: Sam Ravnborg <sam@ravnborg.org>
> > >
> > > With all users gone remove the deprecated fb_blank member in
> > > backlight_properties.
> > >
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Lee Jones <lee@kernel.org>
> > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > 
> > 
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Thanks for the follow-up on all the backlight related patches.
> 
> > 
> > 
> > PS Please don't treat this like a maintainer Acked-by: and merge it
> >    (Lee's not on holiday so work with Lee to figure out the merge
> >    strategy ;-) ).
> Nope, I am aware that the usual pattern here and wait for Lee to show
> up.

It's on the list.  Only 50 more reviews in the backlog now!

> For this patch there is a bug as I need to update a comment.
> I will fix this when I resend after all the patches in flight has
> landed. So likely after the next merge window,

-- 
Lee Jones [李琼斯]
