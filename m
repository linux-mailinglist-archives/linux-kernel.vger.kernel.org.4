Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228FC662B55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjAIQfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjAIQf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:35:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA77B8;
        Mon,  9 Jan 2023 08:35:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AECD8B80E79;
        Mon,  9 Jan 2023 16:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30543C433D2;
        Mon,  9 Jan 2023 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673282121;
        bh=umPOwY842WPvWxkEqRjKZxzSq09MaxAOymz700VqRaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mxSVAkFKU+d+OE0pcqgp/ey0snTrGmxrVzKT4+kH5Z9Gjy6LMo9iM1snpntAm6pZJ
         AqBucc1dJCGujWc2h7JT8GxDC5+oXMcDho+f80vPDtyLIq1gxMkl3VNlm3CPCN+d0c
         0GMSxhAw3chx2KHvMFVpe0OnKdJ/sI0vXLSrk4FwB3dzvRqAWgSTRgZw+mv1royWBA
         eKd1lRWFeCZ88So1JoCN01OJMwuBE0LJnnx8Rnk4YMtip0w7Ctm7KXJ8w01dJhmrcL
         g/46Cb6EicB+AcU91U9eGa4fAx4BOZoMGlWsU5ugCzNhkXZvcehtE2bplAmie3IEwR
         RIMlG3W8WA8tg==
Date:   Mon, 9 Jan 2023 16:35:15 +0000
From:   Lee Jones <lee@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Stephen Kitt <steve@sk2.org>, Jingoo Han <jingoohan1@gmail.com>,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH RESEND 1/4] backlight: aat2870: Use backlight helper
Message-ID: <Y7xCQ68aRTK19eRg@google.com>
References: <20230106164856.1453819-2-steve@sk2.org>
 <Y7hdyPAKBYv+gAzf@phenom.ffwll.local>
 <Y7vsAdMqGNgYS/m9@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7vsAdMqGNgYS/m9@aspen.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023, Daniel Thompson wrote:

> On Fri, Jan 06, 2023 at 06:43:36PM +0100, Daniel Vetter wrote:
> > On Fri, Jan 06, 2023 at 05:48:52PM +0100, Stephen Kitt wrote:
> > > Instead of retrieving the backlight brightness in struct
> > > backlight_properties manually, and then checking whether the backlight
> > > should be on at all, use backlight_get_brightness() which does all
> > > this and insulates this from future changes.
> > >
> > > Signed-off-by: Stephen Kitt <steve@sk2.org>
> >
> > Lee/Daniel, will you pick these up, or should I smash them all into
> > drm-misc-next for 6.3?
> 
> Outside of holiday, Lee usually hoovers up the backlight patches (and
> negotiates about who merges what).

Right, I'll collect these into the Backlight tree if there aren't any
build deps involved.  If there are, we'll need to devise a strategy
that will likely involve immutable branches.

-- 
Lee Jones [李琼斯]
