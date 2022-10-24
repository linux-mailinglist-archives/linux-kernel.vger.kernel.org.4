Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D24C60B67F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiJXTA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiJXTAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:00:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8D3726BC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:39:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v13-20020a17090a6b0d00b0021332e5388fso819769pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0SvrvFQbZJt7iDWYQmvN7U67sbT18oYJVK+RPEPBAvQ=;
        b=lBfQbxfMjOYjjVVAu8Vi6VTVn3QT2ScttZTJRCZEyujkbH41Lr59JYJaEDwAm7pt1t
         xQHy3VUPrWmEbVZjCCVcjLgWGySPQaYJCHJPZXXfB9WICSairI3xhRn6w5RneS6fcuWs
         /191zHzVa7wDwYUhDCFcjM4GRScANHBAO79dOIy3ApqLWhQi9/XrD8zFjQ59v/P+xNX+
         xCDcOvsK2t9vrJTU/hZ2WISRGkQOiie6exyOzS2FB51a0dRO79nJx/fuTr3i97V6HY7g
         OB9U2D97jOpYl0v4LoveN4mkBtLxqpTOwov+hYOErIJUGhPpMGlWmHvoU50PvC7DibgP
         4LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SvrvFQbZJt7iDWYQmvN7U67sbT18oYJVK+RPEPBAvQ=;
        b=PnzABMQl4gFbInfu962yOOWuv6X5OLjvnj5SeSWo514y6fnE+LGbUp+s6fNWTmP48P
         4xCb80aFI2jt/QHXLPoEc9Au2dmmnJYVC1gn3temkvt8gaCrgeYVMeu8jWDrvmYHth+4
         A7IJ+hHgYr68wond+R8qsVJ0caEVii1p1lLBM8cBsUMesnBfXS/vGDOZzC+RBzM+MmTC
         z1ATUZJL2OfLftQFsRiqKQu/dMW7lmKM6oheWBBlhADzsCC0QNbwBorce789r4AtamIk
         q8I4Foa0TL0S/YYrFFcCu8Ba1dJP93zEqmBItfDCIyxNgdOdXB2s/1Fx6X2SP6oRIVi/
         h3bg==
X-Gm-Message-State: ACrzQf0UGFWCPxfAAQa/uFIG+7hTqrqNArPEnBiP1Cbv4maFK8BwJjOA
        Q7a4TJgf3CsT9Zr+4o3WOfg=
X-Google-Smtp-Source: AMsMyM4ul+peWSJ5kBk/E8QtIu9ueJjvVDpG7haldk/47PgjDGdFhd9fWLyOZSUan3A6isvrAKnaMA==
X-Received: by 2002:a17:90b:3e82:b0:20d:2fa1:d071 with SMTP id rj2-20020a17090b3e8200b0020d2fa1d071mr75370882pjb.58.1666633115028;
        Mon, 24 Oct 2022 10:38:35 -0700 (PDT)
Received: from biggie ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id t18-20020aa79472000000b0056bf5e54961sm72858pfq.161.2022.10.24.10.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:38:34 -0700 (PDT)
Date:   Mon, 24 Oct 2022 23:08:28 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, akpm@linux-foundation.org,
        mhiramat@kernel.org, shy828301@gmail.com, vbabka@suse.cz,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: add tracepoint to collapse_file()
Message-ID: <Y1bNlKl1XSCxhaVT@biggie>
References: <20221024150922.129814-1-gautammenghani201@gmail.com>
 <20221024111621.3ba17e2c@gandalf.local.home>
 <CAAa6QmSKtj6T2dW1tkg5_HVj2+rXj5inOLdEzr0MkJzQxxcPXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa6QmSKtj6T2dW1tkg5_HVj2+rXj5inOLdEzr0MkJzQxxcPXQ@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:44:16AM -0700, Zach O'Keefe wrote:
> Thanks for your mail, Gautam.
> 
> > I try to keep dereferences out of the calling path as much as possible
> > (adds to I$ at the call site).
> 
> This was probably due to the way I handled
> trace_mm_khugepaged_scan_file(). Perhaps that can be cleaned up at the
> same time as this patch, for consistency.
>
Yes sure I'll send a patch for cleaning this up.
 
> Also, no qualms about adding this tracepoint; there are a few scan
> result codes that overlap between hpage_collapse_scan_file() and those
> possibly returned in collapse_file() such that, if we only have the
> one tracepoint in hpage_collapse_scan_file(), it could be ambiguous
> what callsite the error path stemmed from. Luckily this hasn't been an
> issue thus far.
> 
> Lastly, a few other items we might care about capturing:
> 
> - is_shmem (perhaps the filename is enough to know this - but I know
> at least once during development I was caught off-guard b/c a mount I
> thought to be file-backed turned out to be tmpfs (and something I
> didn't think to question until I had wasted some time on other
> paths)).
> - index

Yes noted.  
