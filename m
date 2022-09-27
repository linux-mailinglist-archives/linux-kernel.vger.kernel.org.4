Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA555EC581
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiI0OH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiI0OHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:07:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F20E1B14DB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:07:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y136so9800756pfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=bZMxWAC+LHys6lv035SqnZh6LxG78CMqqD7T8X44m5s=;
        b=AWTSS9q0IWgLXo3UA7tSmdMqfI+w2/bt92CD5o35I/G9txXgpFt7FCObhybkrrk1zz
         jl9z+hTHHBQD6X1Byh7EQM9oGNg4+baMSDh+L/mhwvL3VqWeezjYr4awl2wsgfKYHKrM
         wakB3ki1KAzt9gzbsnAlIV2Qm9Z40qXZuP5E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bZMxWAC+LHys6lv035SqnZh6LxG78CMqqD7T8X44m5s=;
        b=uI2HnhBwJPvqyMoCYEPi7/iStXVcQlbpO9V9w/wIrvU6Q9JgqPC534XaKNrcD2Bavi
         eNfqOME/1av7VGr5pTL56SCUTRRxPlyAdhFxUGbH+77MS3YqatzmNiLttKXnxYVKsOV4
         7OmheRmJ7sDSYBL127JxizJa/Bt38GVkqmvgIaWN3FKyVwATp0OTEedHMoH4wTMSujUS
         cx+g5JGBV1s/wVNJO4nxhutebLKCXNdnkWqsuBoczu4S5qd8DOVeO1HOC/7DqKKMbH8t
         Zij3gVjUu9BoWXS4ndZo2qyPLRT/6Q7POVgs8+p/KJPbxxLZfkrSwIf/3GtVBYz49ENw
         JjDg==
X-Gm-Message-State: ACrzQf0BoRismiRHH4Gh31/vbcEdEM3lxUGeVLJZSpLjazHQGxzY6h/1
        e91eyKxnA46QV5Rln2wFxwtOkg==
X-Google-Smtp-Source: AMsMyM5ONlFy4ihyw0vSWPzLSFmq3N2mYdTChbGyXsf3a6NizQTc+G5MDCsu42tigb3y5Fzyi4364A==
X-Received: by 2002:a05:6a00:1a55:b0:557:b7a3:6738 with SMTP id h21-20020a056a001a5500b00557b7a36738mr17337479pfv.61.1664287649636;
        Tue, 27 Sep 2022 07:07:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902dac300b00177faf558b5sm1607088plx.250.2022.09.27.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:07:29 -0700 (PDT)
Date:   Tue, 27 Sep 2022 07:07:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, yashsri421@gmail.com,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] checkpatch: Don't count URLs for "line too long"
Message-ID: <202209270706.DADC6346@keescook>
References: <20220927021517.1952202-1-keescook@chromium.org>
 <91bb341a01ad5cfe4269ef6857387cf3db9619d0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91bb341a01ad5cfe4269ef6857387cf3db9619d0.camel@perches.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 10:40:50PM -0700, Joe Perches wrote:
> On Mon, 2022-09-26 at 19:15 -0700, Kees Cook wrote:
> > URLs (not in a Link: field) should be ignored for "line too long"
> > warnings. Allow any line containing "https://" or "http://".
> 
> More generally, this should be for any URI
> 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3175,6 +3175,8 @@ sub process {
> >  					# file delta changes
> >  		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
> >  					# filename then :
> > +		      $line =~ /https?:\/\// ||
> > +					# URLs
> >  		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
> >  					# A Fixes: or Link: line or signature tag line
> >  		      $commit_log_possible_stack_dump)) {
> 
> And I don't recollect why this wasn't applied, but I think it's a rather better,
> more complete, patch:
> 
> https://lore.kernel.org/lkml/20210114073513.15773-2-yashsri421@gmail.com/
> 
> I believe I did ack it and forward it to Andrew Morton, but I don't
> see it on a lore list.

Many patches have internal references in the commit log (that aren't
appropriate for "Link:") like:

[1] https://some.domain/path/

It seems more flexible to just ignore lines with "http" in it...

-Kees

-- 
Kees Cook
