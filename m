Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCEA65BB7D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjACH6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbjACH6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:58:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89290DF3C
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 23:58:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 202C26119D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D61C433EF;
        Tue,  3 Jan 2023 07:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672732690;
        bh=CZjw7I9UxotlvvY8MEtD8ZW6aSrpDpY1IbdlOy4X8H0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSlMbOct+Wj8OWic7zBFHd2d/tTsozpcHztyI0h/qZgLuR7MZBwUlycJ0RBSY5lMP
         /OfOttfH40FC+QxomJWDgFbcFMqBC78pp1lpnhxXxs1OAixTxsI7OcaBI/0+tt4Ghl
         hhk04j9qK44t8aXQmmtMuMtSBvPWyb5Z8EynZQNUci0lW+r0aZ4Q9VFzRanESmSML1
         N4wTsLr+uChAuVlbd8fSttgeJaBPmXcO05piBzjUcx8TyjiE9zXP1xlOME8QFmkVgT
         aDsvkQaDv1lKjeU56UEMAZxo1EzFnKxKHD7BvQGKOCy9TL7F0BnryON9/s7FLXjV2u
         naBV5uTNJx4Mg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCcBp-0005dq-Ig; Tue, 03 Jan 2023 08:58:29 +0100
Date:   Tue, 3 Jan 2023 08:58:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Steev Klimaszewski <steev@kali.org>,
        Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panel-edp: fix name for IVO product id 854b
Message-ID: <Y7PgJZtXBD42EobX@hovoldconsulting.com>
References: <20221231142721.338643-1-abel.vesa@linaro.org>
 <CAKXuJqjiEpxnX_E=HGqEaX91YA7XUmUoaK0NQqXHJCUkcqUPoQ@mail.gmail.com>
 <Y7KUFMjnra22YGlv@hovoldconsulting.com>
 <Y7Ncg9DMbHBagcoz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7Ncg9DMbHBagcoz@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 12:36:51AM +0200, Abel Vesa wrote:
> On 23-01-02 09:21:40, Johan Hovold wrote:
> > On Sun, Jan 01, 2023 at 10:58:42PM -0600, Steev Klimaszewski wrote:
> > > On Sat, Dec 31, 2022 at 8:27 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> > > >
> > > > The actual name is R133NW4K-R0.
> > > >
> > > > Fixes: 0f9fa5f58c784 ("drm/panel-edp: add IVO M133NW4J-R3 panel entry")
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > ---
> > > >
> > > > Assuming the information from here is correct:
> > > > https://raw.githubusercontent.com/linuxhw/EDID/master/DigitalDisplay.md

> > > Thanks for this - when I was looking for the panel, I simply went with
> > > what I found on panel-look.
> > 
> > Did you check what string your panel reports? For example, using
> > something like:
> > 
> > 	# strings /sys/class/drm/card0-eDP-1/edid
> > 	...
> > 	B133UAN02.1
> 
> Mine shows: M133NW4J R3
> 
> But since both R0 and R3 have the same product ID, I decided to drop the
> revision part, otherwise we would need to add a second entry with the
> only difference between them being the revision part (Rx). This is what
> I did in patch #2.

Makes sense. Thanks for confirming.

Johan
