Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44A567298C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjARUiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjARUiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:38:08 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97844A1F8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:38:07 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b10so282109pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SEbbH/UMi7mhLJTxAtXYqm1kXgdPVoWLCPyhz4xcgtg=;
        b=XXLBV70FnhGmEwNbUGoC/dELIFJuniWmQrNckfgER3vBIIcsqqkROzZ1SZja/A0sxA
         vva9xiPmBSsS/ZCln6Ax13OUJFuAswSHAMhYspSe37Pn+FHpt8JOx1sKqZWqIUWYkNsg
         gOjDlFzmjFQJMp25hQkAXagOMjjHnURTCbBTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEbbH/UMi7mhLJTxAtXYqm1kXgdPVoWLCPyhz4xcgtg=;
        b=555yZFfHJmLLqE47BKO1xiIH27i1OynGUb/TXFd0hcvybKAYb8tFF3AVLpiVHx7WY5
         BKxQ6WbzadF5oWOLTxJF4RuEQKsKHCQu8jIIdOrJAKJWtpfPGhJ4bPxP0uiGfivOzNOf
         AmOhgeGRRYCyIsE5aV+CbnkENyYFmFhJOLJqNpxzPna6OJXgwkgRPFYGLw8kgMRHIPqJ
         ZRMvg43RZxLsUJ1/CPCH97z/3EJtxDc+Wz+NLjj7ZODTMe1JzOjosW5yeDGGvmDxL8FV
         XdGweBmygQHRaioJf8sjSPMjTUAisF1myHX75h5RtT+XMZ3XHxjdcmOtIEraNm1Cn+iy
         /wpQ==
X-Gm-Message-State: AFqh2krSS0AGgqf7/4hZTLdL3Pf7hDl18NaouOUx6YbjQlyU9qkycjpG
        hDrqmXqqDiesu1yym0QoHyJRBaxkbOdRZtlv
X-Google-Smtp-Source: AMrXdXvTGd1Ph6IwQQ/i88zipRB2EfVxpj1z81G8vbnBbc8jB1as+U2VQXgEr++hrfN80BwOfwBKKw==
X-Received: by 2002:a17:902:bd4c:b0:194:bb2a:c8ce with SMTP id b12-20020a170902bd4c00b00194bb2ac8cemr3043341plx.16.1674074287337;
        Wed, 18 Jan 2023 12:38:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0017ec1b1bf9fsm23423229plp.217.2023.01.18.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:38:06 -0800 (PST)
Date:   Wed, 18 Jan 2023 12:38:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the kspp tree
Message-ID: <202301181237.061950D0D5@keescook>
References: <20230117150212.3d8ee843@canb.auug.org.au>
 <CACO55ttvqwnmGS=4gig-AOy+67bDesdj2S9HDJ3hS=uyN0NGOQ@mail.gmail.com>
 <20230118075620.60250ca2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118075620.60250ca2@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 07:56:20AM +1100, Stephen Rothwell wrote:
> Hi Karol,
> 
> On Tue, 17 Jan 2023 14:52:12 +0100 Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Tue, Jan 17, 2023 at 5:02 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > The following commit is also in the drm-misc tree as a different commit
> > > (but the same patch):
> > >
> > >   06b19f46455c ("drm/nouveau/fb/ga102: Replace zero-length array of trailing structs with flex-array")
> > >  
> > 
> > which branch? Because I just fetched the remote and don't have this
> > commit in my local repo
> 
> That was from
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git (branch
> for-next/kspp) yesterday.  It was the top commit in that branch.  It is
> still there today (I am not saying it should not be).

I've dropped my instance of the patch. Thanks!

-- 
Kees Cook
