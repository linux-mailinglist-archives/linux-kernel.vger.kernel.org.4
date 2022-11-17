Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6B662E7A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbiKQWD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbiKQWDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:03:01 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BED8E86
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:01:35 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f3so3330235pgc.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt6ioOinpgj3hMNhf3INdav13IL3VvYdTMM5tKc55hs=;
        b=fXXPpVBiRM3ejT7uJgam/jeGMEAa6qjY/UFCdVq+RMwmW9fWGZ95uguYKJegBuw7Kj
         b5epn2BfMtu+da95UodBRUu+URZA0xAqyECuJPp/zEJC3+o6fbaUAyPTvRAnSZZyqY99
         3Cv8LtU4avYofql0wQt7pl1PWpPkiaFN18M6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt6ioOinpgj3hMNhf3INdav13IL3VvYdTMM5tKc55hs=;
        b=x1A6DqpD5bdQVWLOs4S1XaDTNeJD0ZsANTVy+E7VGn6TXPzztZSIcoDuWx9Jma6rHM
         sOJ1nJEocoCSrohXlNb6CHEg9oklUgLU2eBGtZDxfOTilfh9CUgc3tOqdHPnf7hZZvZM
         nfsqnN3zszGoRWEwgFq8yFMDysMX0dkPNjIiq2NEaCO1uId4MZG9TOvP0OSZP9LFzfs0
         DSSMTLRwR1PoUkEkvSLfsOQF3BgMu2nmmFkbz39WRmLQVWjEM/WCZiTBKlL3Hu5MV/J7
         FoCxs8GC/pgFdT6DXtKkjONm3nDG094HGrDYqMKH5XUI4KWBdx8kQfUK+3ouHMLK9fR8
         4Uxw==
X-Gm-Message-State: ANoB5plTnTn5m1J+G90cKk8JqV3jX5jWCuVUNes84ew3bxRP8G1w2lVy
        uL1iW61423lZQLPX+wtjmg+WIQ==
X-Google-Smtp-Source: AA0mqf6a3M4WqJQk9uaiVBtkSBfgGVUP1Kw1s4HtP1D+unruSZElFl8tOA4T4e2Wr2MKCNn3x99axw==
X-Received: by 2002:a63:4c59:0:b0:476:c490:798a with SMTP id m25-20020a634c59000000b00476c490798amr3833829pgl.564.1668722494968;
        Thu, 17 Nov 2022 14:01:34 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h31-20020a63575f000000b0047696938911sm1516588pgm.74.2022.11.17.14.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:01:34 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:01:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-hardening@vger.kernel.org,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] MAINTAINERS: Update pstore maintainers
Message-ID: <202211171359.232C769E3A@keescook>
References: <20221011200112.731334-1-keescook@chromium.org>
 <20221011200112.731334-6-keescook@chromium.org>
 <542aa83d-6227-ea7d-2150-a74293cbf59a@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542aa83d-6227-ea7d-2150-a74293cbf59a@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:42:53PM -0300, Guilherme G. Piccoli wrote:
> On 11/10/2022 17:01, Kees Cook wrote:
> > Update pstore to better reflect reality of active contributors:
> > 
> > - Remove Anton and Colin (thank you for your help through the years!)
> > - Move Tony to Reviewer
> > - Add Guilherme as Reviewer
> > - Add mailing list
> > - Upgrade to Supported
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  MAINTAINERS | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Hi Kees, sorry to revamp this thread for a "tangential" topic, but it
> feels a "kinda" proper thread.
> 
> Since I was added as a reviewer on pstore (in linux-next so far), I
> started to receive a bunch of emails from ARM device-tree folks; they're
> adding ramoops entries to their DTs and looping pstore folks.
> 
> Examples:
> 
> https://lore.kernel.org/linux-hardening/20221111120156.48040-1-angelogioacchino.delregno@collabora.com/
> 
> https://lore.kernel.org/linux-hardening/20221116145616.17884-1-luca@z3ntu.xyz/
> 
> 
> Personally, I have no knowledge of these HW to evaluate if the ramoops
> setting is appropriate, so they're nop from my side, I just delete them.
> But that raises the question - are you/Tony reviewing this kind of
> change? It's not related to pstore/ramoops code, it's just users setting
> ramoops in their DTs, so seems to me a bit far from the purpose of the
> pstore entry.

I usually look at it very quickly, but I can't meaningfully positively
review it because I don't know the hardware, etc.

> What do you/Tony think about that? Likely the DT folks are following
> this entry in the MAINTAINERS to send these emails:
> 
> PSTORE FILESYSTEM
> M:      Kees Cook <keescook@chromium.org>
> [...]
> F:      include/linux/pstore*
> K:      \b(pstore|ramoops) <------
> 
> Should this be kept? Maybe only the ramoops entry could be removed?

I would like to keep it -- if something mentions pstore and ramoops, I'd
like to see it. I can't review all of it, but I'd like it to at least
show up in my inbox. :)

-- 
Kees Cook
