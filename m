Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE16D64FF54
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 16:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiLRPio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 10:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 10:38:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D046564E5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 07:38:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B41A60D2D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 15:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC2AC433EF;
        Sun, 18 Dec 2022 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671377918;
        bh=/45chhHZN7LvW7tG0SV0uxRS7NQX9LMWO7egMZomOmU=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=aqxMCpAiKkDTglWgrKmthVHVpTHzR5pQwpkLuLkFzlM7UXXmrGEi6FMqzBOpTEGqp
         vwG44azOjE3y+XYDA2IhWxUI1+j1s7G0e8Kuh2j9uwb/bP3l/Loo9pHAwf2g2L5lVk
         QSCkN342h8pV+5MXWqXWYDhJAH4iCqd9L6FTFuDhtkDIPy/bTpXIT57/QGdBjKqjOB
         jJ6flShfP6QVQMIrGAKUDjhpSgenHM7TDaSZI1QzE1geb3HPYCrUw4LuYU84Qf9Oyu
         FCjBtQbbs8qd0elbR0u9djoH5iRPPxDV7uZp/XPXQI1bqWeYjGycPrjFAUcE8eCH5A
         YfMsMQHaO0hsw==
Date:   Sun, 18 Dec 2022 16:38:33 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbd] [patchv2 3/3] VT: Bump font size limitation to 64x128
 pixels
Message-ID: <Y58z+e7DF+YpJYbR@example.org>
References: <20221218003209.503539532@ens-lyon.org>
 <20221218003237.503424466@ens-lyon.org>
 <Y58mKmE9Km+NujDa@example.org>
 <20221218145532.syqzu76q23rz4tx6@begin>
 <Y58wzU081UB1IsxB@example.org>
 <20221218152857.qle75c6lhexkdoym@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221218152857.qle75c6lhexkdoym@begin>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 04:28:57PM +0100, Samuel Thibault wrote:
> Alexey Gladkov, le dim. 18 déc. 2022 16:25:01 +0100, a ecrit:
> > On Sun, Dec 18, 2022 at 03:55:32PM +0100, Samuel Thibault wrote:
> > > Alexey Gladkov, le dim. 18 déc. 2022 15:39:38 +0100, a ecrit:
> > > > On Sun, Dec 18, 2022 at 01:32:12AM +0100, Samuel Thibault wrote:
> > > > > -#define max_font_size 65536
> > > > > +#define max_font_width	64
> > > > > +#define max_font_height	128
> > > > > +#define max_font_glyphs	512
> > > > > +#define max_font_size	(max_font_glyphs*max_font_width*max_font_height)
> > > > 
> > > > As a suggestion that you can safely ignore. Maybe make max_font_glyphs a
> > > > sysctl parameter to be able to use larger fonts ?
> > > > 
> > > > I get requests from time to time in kbd that it is not possible to load a
> > > > larger font.
> > > 
> > > 64KiB was really low, while the theoretically possible max was
> > > 32*32*512 = 512KB, so I understand there used to be such requests :)
> > > 
> > > Here, by setting the max to 64x128*512, I don't think we'll need more.
> > 
> > I was not talking about the size of one glyph, but about the number of
> > glyphs in the font. Right now the font cannot have more than 512 glyphs.
> 
> That one is unfortunately *very* hardcoded in the VT code, since it's
> the very representation of the console text in vc_screenbuf which is set
> to the VGA-based 16bits per glyph, with a 8+8 or 9+7 separation between
> glyph number and color number. Lifting that would be way more involved.

Yeah, but I thought that since someone decided to touch this old code,
then this someone will improve this old limit :)

-- 
Rgrds, legion

