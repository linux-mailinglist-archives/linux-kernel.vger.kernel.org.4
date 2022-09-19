Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AD65BCF7C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiISOsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiISOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:47:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD182CCA4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:47:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so2005601pjo.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cq1FhOS5h+5LNfxhpGiYVbkgxRPdMbmbJNEctNfAl44=;
        b=hsEYJ2tlBfGXJKHFqm8EdND9zicJvQm1Z5le662zVf8vXhbxpIjsZqZmUFL+mJlLXW
         P5w4foWiYlf24yzVzoyuU+CEm8Q75m8Wu8DvBXUJ9ePX3Dz4XUNyNhBJUJMGfUaFnduv
         67VEa8tvL+78g2Rrm7pZI2RR+cIODkilCDqp3U6+rIj8uFONjii89U6xIwJwzT1jFoTs
         gWx58+g5XHUi29mGi7FmY6+52WfLbE1WTuuRqluCZX1QCQxEd8Oib5ZV0uVD7e1SunSB
         W/G3Zlr56epOF293jfc6SFND0vdrq7AnE2rgtLwn/3kzuAndAbp37dTgE6UMqqdkXmqd
         9H9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cq1FhOS5h+5LNfxhpGiYVbkgxRPdMbmbJNEctNfAl44=;
        b=P578w2iXvNheK5psQQmePs1pd9BY4hfIUW49sZhpTycOPx7C70EXeQ60OTlXdT1Tqq
         weKDcob0tpDGgVu2YjRXDm1N0gLUP5WdTXn0HckitPXpszZuQYvdWXUHBPi3V0zbzCJV
         o/XSAMgFWIPafY9P14BZepiEAbkKuiFvyzgB/S1u3WHrWsadraAKNKB9hYzWDXNu2i2K
         5Bm3FVVKF4IiXOmOvIc1fNJhcont67JD+FaJMEKgGnLN9PQrg84wTaDi2aMsn76yHkcd
         M9LjgvLrpP1lZ8k9tnRJmQvBmv0dbem8Mvj8bM9z9McqIM9x9dAAFmNZXr+PZtnuVaRP
         JTXQ==
X-Gm-Message-State: ACrzQf2XcwSvmWn0y+p6yyWZShmlkeoaxxtg2Q9bFQ1MGqgIXuCvjoMq
        W7W6fZakFxysrmtJE/7QCGYycHs3fiFiNyks
X-Google-Smtp-Source: AMsMyM7n4E/rgHTnjgJDLn2+GeTohli5iHjjMG6BtljYGR0/3QJLSSh1TFioXq4IwCtXb0DqDOck+Q==
X-Received: by 2002:a17:902:8549:b0:178:6399:3e0f with SMTP id d9-20020a170902854900b0017863993e0fmr98362plo.35.1663598876223;
        Mon, 19 Sep 2022 07:47:56 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j11-20020a17090a840b00b001fbbbe38387sm6813232pjn.10.2022.09.19.07.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:47:55 -0700 (PDT)
Date:   Mon, 19 Sep 2022 07:47:51 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <YyiBF5V6I7SYHqJy@google.com>
References: <20220919082105.73c0e270@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919082105.73c0e270@canb.auug.org.au>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 19 08:21, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   3a41f36f7083 ("selftests/vm: fix "add thp collapse file and tmpfs testing" for tmpfs")
> 
> Fixes tag
> 
>   Fixes: 64b9fb1fa904 ("selftests/vm: add thp collapse file and tmpfs testing")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'
> 
> So
> 
> Fixes: 64b9fb1fa904 ("selftests/vm: add thp collapse shmem testing")
> 
> or maybe
> 
> Fixes: 465c955b7343 ("selftests/vm: add thp collapse file and tmpfs testing")
> 
> -- 
> Cheers,
> Stephen Rothwell

Hey Stephen,

Apologies here.  Yes, the correct Fixes tag should be, based off latest
mm-unstable,

Fixes: 8d88fef0b3d8 ("selftests/vm: add thp collapse file and tmpfs testing")

Now, I'm quite confused as to has this happened as I've been generating
citations using something similar to the --format string you reference, but
perhaps this time I chose to do it manually and messed it up.  Anyways, will
write something to catch these mistakes in the future.

Andrew, there are a few changes incoming to the "mm: add file/shmem support to
MADV_COLLAPSE" series based off recent reviews (including another patch with
a commit description change).  Perhaps it's easier for me to send a new (v4)
series to mm-unstable to address these?  Otherwise, I'm not sure how to
request these metadata changes.

Best,
Zach

