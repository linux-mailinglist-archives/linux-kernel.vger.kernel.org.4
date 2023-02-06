Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB06968C5E1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjBFSf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjBFSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:35:24 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069CD2B0B5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:35:23 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 141so8865392pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=00L1YIX4H8zKf3PuLUq07QOm26y5Ud4TCvFHdvWnTKQ=;
        b=ikhdd2Npj6TQEvKy94NLWFo/n/aSnbPjpScVDW1c6xKVtRknrIfjkl46nx8UvIPFX6
         xV911PqOZ9ZUc6HE08ydc5yEYX02pX/ld5BzLfEWgiPjNK1mw4EnY5wXsKK8cQZ7lWpi
         4S3hvlULN0StlGnkwyNq/wBn2r8gHr3nnqOXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00L1YIX4H8zKf3PuLUq07QOm26y5Ud4TCvFHdvWnTKQ=;
        b=OG+7t2/h4DBLF2AzAMFnisZUCH/FSh/F/mEO76lTy583JuGeUT9+zR1V2u0mq+ACbq
         ZKmq6AX/ecoKy8v4HFtsROOPcJzozOOO0ZbVsrvx7AJ4/NORjWsNJ+9781Z7z/foWMFf
         81fA6G6kE7TLZW4w95e0tlJ00XeP2vImb0gI901ar1cWxySZRqxGoJwKvYf5GR90UWhq
         wGUhOSFurhXVnrPXGngoZkACAag2tBpuq5fagoYJDadm83m10RX//8nd96GzxzX6yWoN
         tm4dFVblMUGcczNuxBm3jhX6MqFAguMESr2ETZRtVS76bgGcLTbNNBaCU3LbwsXsZJUO
         d3jA==
X-Gm-Message-State: AO0yUKXkm5LWylLhhttAN0DyDY1CMGPpMkwCFCu9lGL6MYB+SgacQVQf
        2uVzYKdwiB4z+UwWvc1Gcba1xQ==
X-Google-Smtp-Source: AK7set9WEz94AKlTh9/C9AYG20przHY2Z0FJe/l8y9IyrENZ/EkFE2DkTJi5xJd1g7WaQ1QEjgUB8Q==
X-Received: by 2002:a05:6a00:9:b0:586:a3a9:6163 with SMTP id h9-20020a056a00000900b00586a3a96163mr347726pfk.28.1675708522461;
        Mon, 06 Feb 2023 10:35:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bt22-20020a056a00439600b0056be1581126sm7712592pfb.143.2023.02.06.10.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:35:22 -0800 (PST)
Message-ID: <63e1486a.050a0220.7001.ca15@mx.google.com>
X-Google-Original-Message-ID: <202302061033.@keescook>
Date:   Mon, 6 Feb 2023 10:35:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     Dave Kleikamp <shaggy@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] jfs: Use unsigned variable for length calculations
References: <20230204183355.never.877-kees@kernel.org>
 <Y96/SUlPUl7xH1NO@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y96/SUlPUl7xH1NO@gallifrey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 08:25:45PM +0000, Dr. David Alan Gilbert wrote:
> * Kees Cook (keescook@chromium.org) wrote:
> > To avoid confusing the compiler about possible negative sizes, switch
> > "ssize" which can never be negative from int to u32.  Seen with GCC 13:
> > 
> > ../fs/jfs/namei.c: In function 'jfs_symlink': ../include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' pointer overflow between offset 0 and size [-2147483648, -1]
> > [-Warray-bounds=]
> >    57 | #define __underlying_memcpy     __builtin_memcpy
> >       |                                 ^
> > ...
> > ../fs/jfs/namei.c:950:17: note: in expansion of macro 'memcpy'
> >   950 |                 memcpy(ip->i_link, name, ssize);
> >       |                 ^~~~~~
> > 
> > Cc: Dave Kleikamp <shaggy@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Dave Chinner <dchinner@redhat.com>
> > Cc: jfs-discussion@lists.sourceforge.net
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  fs/jfs/namei.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> > index b29d68b5eec5..494b9f4043cf 100644
> > --- a/fs/jfs/namei.c
> > +++ b/fs/jfs/namei.c
> > @@ -876,7 +876,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
> >  	tid_t tid;
> >  	ino_t ino = 0;
> >  	struct component_name dname;
> > -	int ssize;		/* source pathname size */
> > +	u32 ssize;		/* source pathname size */
> 
> Had you considered using size_t - this is set from a strlen and used by a memcpy
> that both talk size_t.

I considered that, but I've had other maintainers upset about doubling
the variable size. I opted to keep the variable 32-bit here, so the
machine code would only change to lose signed-ness.

-Kees

-- 
Kees Cook
