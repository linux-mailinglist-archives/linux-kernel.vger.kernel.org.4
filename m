Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E20E5EB891
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiI0DRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiI0DQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:16:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0C881694
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 20:16:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i6so4340001pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 20:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cQ6zVkpqugLa9891w98RVMCjnbNxIhz4C6HrHMJZK8I=;
        b=Ys70lYwi0UuItAyKdztaa/QvN/zNeHvK+DYTxNBDjsJxCxH44M11cP9jPnxzHQPNjb
         igvguKL8YyFJNtFEBrZ5W6daU3oui1F9DXIVaw4aE/szAfv+15cUzVL5WS2GxWMW7Yt8
         IPCeEYWTOOuxdVg8giuH8nTC6Yhi4Ev8pRtpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cQ6zVkpqugLa9891w98RVMCjnbNxIhz4C6HrHMJZK8I=;
        b=S/bfxngHAwExva7zfVhpAJlpclMqO51rWm8zjT2UF++MMfv4+w76VO/BFLzEpcybPZ
         5QDvKtlLQQWXYhV0stzr9R5Gp91056x9wDALyaPnsMzPwa1QPFHRj9mDDNMqZcLfhFct
         UFrbDc4gsSpOq0D8fWdQNa5jkwJHisqRuclwKXAZfM1dNm95pu7gGpY355ylccWK/ABO
         XdLzTbaVx84vlPOQNme95YjObpcNOuDS5aG9JloupHX3BiRzYG1VWeTPAJ89cnRBu7RG
         nHUXOZC+rvOrFzXZ7Mx6q4eGcdEoH2ojoHCG6NEg8wI4LbRgfvzUzkuP1TUS72bPbInw
         5YqQ==
X-Gm-Message-State: ACrzQf1k6qCGPaJyOy1RKAO+l0T4nmTcn6Q/HBuMAr4aqihUqrjiJWWq
        BwgMzM7DjVQ1TTUIFvAC8Yz48BVvH9pxOw==
X-Google-Smtp-Source: AMsMyM4aPQZJmufIlgB90yFaVfoE50JmAVMSvaBvUb81fg56HsalOTyKUNoRqQO6/X3VOyQ7j9y52w==
X-Received: by 2002:a05:6a00:c89:b0:543:edb9:9dbc with SMTP id a9-20020a056a000c8900b00543edb99dbcmr27379913pfv.50.1664248577744;
        Mon, 26 Sep 2022 20:16:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 82-20020a621955000000b0053812f35a41sm269573pfz.194.2022.09.26.20.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 20:16:17 -0700 (PDT)
Date:   Mon, 26 Sep 2022 20:16:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: control.h: Replace zero-length array
 with DECLARE_FLEX_ARRAY() helper
Message-ID: <202209262009.D1377D0C3@keescook>
References: <YzIcZ11k8RiQtS2T@work>
 <YzIj6tdtDe9YrX+I@sirena.org.uk>
 <81af0106-a732-ce45-bb1c-c45db9e1aeb9@embeddedor.com>
 <YzIqNqhTIuaWZrOl@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIqNqhTIuaWZrOl@sirena.org.uk>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 11:39:50PM +0100, Mark Brown wrote:
> On Mon, Sep 26, 2022 at 05:27:41PM -0500, Gustavo A. R. Silva wrote:
> > On 9/26/22 17:12, Mark Brown wrote:
> > > On Mon, Sep 26, 2022 at 04:40:55PM -0500, Gustavo A. R. Silva wrote:
> 
> > > As documented in submitting-patches.rst please send patches to the
> > > maintainers for the code you would like to change.  The normal kernel
> > > workflow is that people apply patches from their inboxes, if they aren't
> > > copied they are likely to not see the patch at all and it is much more
> > > difficult to apply patches.
> 
> > That's exactly what I intended to do:
> > 
> > $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback include/sound/sof/control.h
> > Jaroslav Kysela <perex@perex.cz> (maintainer:SOUND)
> > Takashi Iwai <tiwai@suse.com> (maintainer:SOUND)
> > alsa-devel@alsa-project.org (moderated list:SOUND)
> > linux-kernel@vger.kernel.org (open list)
> > 
> > Did you see anything wrong with this or something...?
> 
> Yes, you should've also included me and the SOF maintainers.  It looks
> like the MAINTAINERS patterns aren't entirely up to date there
> unfortunately.  Though that said given that you'd picked up on the
> subject line I'd have expected the signoffs on the commits to also be
> pointing at the right tree as well.

Subject line heuristics look at X-many commits, but it looks like
get_maintainers stops looking at git history by default after 1 year,
which seems kind of odd. I had to work at it to get it to emit your
name. :)

scripts/get_maintainer.pl --git --git-since=3-years-ago

Seems like it's worth getting the MAINTAINERS regex updated? Is this
right?

diff --git a/MAINTAINERS b/MAINTAINERS
index a34ec41fbf7a..2560dded0e3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19261,6 +19261,7 @@ F:	Documentation/devicetree/bindings/sound/
 F:	Documentation/sound/soc/
 F:	include/dt-bindings/sound/
 F:	include/sound/soc*
+F:	include/sound/sof/
 F:	sound/soc/
 
 SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS
@@ -19275,6 +19276,7 @@ L:	sound-open-firmware@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 W:	https://github.com/thesofproject/linux/
 F:	sound/soc/sof/
+F:	include/sound/sof/
 
 SOUNDWIRE SUBSYSTEM
 M:	Vinod Koul <vkoul@kernel.org>

-- 
Kees Cook
