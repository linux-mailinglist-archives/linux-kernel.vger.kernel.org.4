Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA6360DA6B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 06:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiJZExN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 00:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJZExJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 00:53:09 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D349E0C3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 21:53:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m6so14247465pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 21:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUatcekvUHl52e6kKZ24DbmCCp6yIPudmgeORti4bbc=;
        b=b5y/M9Jw/rrLdQSOuRJZpGtRzcDBCOsqHFzFmBfnCXh+Z/zgFdOQvpQKLuO5OQW/dR
         clzCLZDxishZBYhFJHP+2uZiYd8xUQviM65AhwwIDzdHdLEHgBBno5CmXJ5BZVEb0NzA
         7t5boBbYoMSRksju3pYAQB6KKKmdV8kdWKfiNbnWW0Ltr0ZwRjWleWVV9u7gh+u5GEUM
         ZuRbctK6niFt5sdFN8X3k+ur7tPmq01t9J59GSzWAcdnsMdHPX4n3iZkxPK/x+QptpCw
         SinE9/eLcNUGjnTLGeBB6Bf0N3fpf4PsO+AdmEnp1EVL2B5AfwB2+RgzzKpoTT6NshOO
         hnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUatcekvUHl52e6kKZ24DbmCCp6yIPudmgeORti4bbc=;
        b=CN4BockvpZ1g4AkfGMaRJI1gRo55nFobA6am5rlMFqkQVJzgV3m0j/XsiI7GyXbTCD
         twr4eW7Z/otyWx2/0rqx8JUSuzC9FREyqsBFYZdk8P3wN8prgYs/TOXASEf/yxZPpkeU
         QIHbICrdOGx7edXiWI3fzlu0yp30m1sd6q2lra9cIOQ2UreCmTPh7b72/QnnNbbPeKG6
         i/FR5Ud/TX4hqT8+YN83m7kNelW4I3FpkDmA3hJB1cpsI8PanJIi42bmTaDonB6rDaQQ
         XTCTXgrbBR4Xj0bOgCc6r9ABXkvi1uKB596Mhk0QPqOJTCMtVptXKaLDFV5BR6SEClGK
         JaJQ==
X-Gm-Message-State: ACrzQf0lWzPPWTmzJAHhbNF8myHmydvhpR86y4S60d7HwcTIyQIZF36G
        Mqwi3rUY7THtMEPn+WpucQE=
X-Google-Smtp-Source: AMsMyM568cX0dGncCmQUNaJnHgVfBa6/B+t+4cHHdigJqbPMd9D+OgCUwDSrNwFoRcbfPPjFYe+SaA==
X-Received: by 2002:a63:2c8:0:b0:46e:9da9:8083 with SMTP id 191-20020a6302c8000000b0046e9da98083mr25837512pgc.186.1666759988197;
        Tue, 25 Oct 2022 21:53:08 -0700 (PDT)
Received: from biggie ([103.230.148.186])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b0017f8094a52asm2009719pla.29.2022.10.25.21.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 21:53:07 -0700 (PDT)
Date:   Wed, 26 Oct 2022 10:23:01 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, rostedt@goodmis.org,
        mhiramat@kernel.org, shy828301@gmail.com, vbabka@suse.cz,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] mm/khugepaged: add tracepoint to collapse_file()
Message-ID: <Y1i9LW7GBgiLxQLE@biggie>
References: <20221024173559.332324-1-gautammenghani201@gmail.com>
 <20221024131706.3d58bd92c332684386c7df13@linux-foundation.org>
 <Y1duhy5kbhLoMqWO@biggie>
 <Y1go+BSdpGELmIZS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1go+BSdpGELmIZS@google.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:20:40AM -0700, Zach O'Keefe wrote:
> On Oct 25 10:35, Gautam Menghani wrote:
> > On Mon, Oct 24, 2022 at 01:17:06PM -0700, Andrew Morton wrote:
> > > On Mon, 24 Oct 2022 23:05:58 +0530 Gautam Menghani <gautammenghani201@gmail.com> wrote:
> > > 
> > > > In the file mm/khugepaged.c, a TODO in the function collapse_file() asks
> > > > to add tracepoints. Add the tracepoint named "mm_khugepaged_collapse_file".
> > > 
> > > This isn't a very satisfying explanation for changing the kernel.  Maybe
> > > the comment is stale are this tracepoint is unneeded.
> > > 
> > > Please explain afresh how this addition benefits kernel users?
> > > 
> > The function collapse_file() is called by the function hpage_collapse_scan_file(). 
> > Without a tracepoint in collapse_file(), we won't know if it was called or not and as a result,
> > we also won't know if it returned successfully or not. Also, as Zach mentioned earlier [1]:
> > 
> > there are a few scan result codes that overlap between hpage_collapse_scan_file() and those
> > possibly returned in collapse_file() such that, if we only have the one tracepoint in 
> > hpage_collapse_scan_file(), it could be ambiguous what callsite the error path stemmed from.
> > 
> > [1]:https://lore.kernel.org/lkml/CAAa6QmSKtj6T2dW1tkg5_HVj2+rXj5inOLdEzr0MkJzQxxcPXQ@mail.gmail.com/
> > 
> > Please do let me know if a v3 is needed.
> > 
> > Thanks,
> > Gautam
> 
> Thanks Guatam,
> 
> The ambiguous codes in particular are:
> 
> SCAN_PTE_MAPPED_HUGEPAGE
> SCAN_PAGE_COMPOUND
> SCAN_PAGE_COUNT
> 
> ; properties of a page that are checked before/after the page is
> locked/isolated.  This personally hasn't been an issue for me, as someone who's
> spent considerable time in these codepaths over the last little while.  There
> are certainly other codes (like SCAN_FAIL) which are ambiguous within functions
> (and likewise haven't been an issue) so this reason alone isn't particularly
> motivating.
> 
> However, some of the extra information (is_shmem, index), at times, would have
> been useful if was already available -- but it was never enough of a pain to
> force my hand to put this tracepoint in.
> 
> If the tracepoint is staying, then 2 nits:
> 
> CHECK: Alignment should match open parenthesis
> #74: FILE: mm/khugepaged.c:2064:
> +       trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem,
> +               addr, file, nr, result);
> 
> and, apply Steven's advice to trace_mm_khugepaged_scan_file() for consistency.
Yes I've sent a patch to refactor the mm_khugepaged_scan_file() tracepoint - 
lore.kernel.org/linux-mm/20221026044524.54793-1-gautammenghani201@gmail.com/T/#u
