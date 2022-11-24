Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735F363714D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKXDzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKXDze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:55:34 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0F085173
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:55:32 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bs21so678167wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=COzKK8Up3qBWqlxAYeMyVO6CKMAGgr0ohhO3K3yCcrA=;
        b=lqPjcjEcjDRyDIHF/3xu1/qYXjbiwrDf5vCJEOZXGtsMxpeHq+ps8Mw1KHIygle/qQ
         WuJaWQiV4CWXIqXMdYd6m2X3sotmlRf19eb1Uu7F8rhqWlG3bK5m4gm+BOxrMgnUxtjQ
         6glGifJ7hKewQtM+VmyiJ38iePJKOXmVJhZSLQBqfCEj3YWT82v+ZW0YjKL5oggbhjM4
         0YlbsWoh4ywpYp5I0hBBGU2eZvaqiM2H8yAtnCr9QVz6bjLFLZ1iMpchc2ZaiqeiJ9PB
         at3VzX7x1rR2WvYoZitzJsibtRb3UUDR5YKo9yoiOBDnN8Io3gEw4CJz2/PNu4owdFEE
         8fNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COzKK8Up3qBWqlxAYeMyVO6CKMAGgr0ohhO3K3yCcrA=;
        b=Lzf6xtLrlETnhUjmzv0WNc/t2pZIHP/OsX0LEezL1OuIvpO+Tnb2axgK/x2GIoBKiQ
         0E7V+0Kkb7R/c8j4eOUUsdA/SYaxI5O71F1zTFNJYP0VrVykhZMaHgE2QdNQAQYt/+sF
         drE5dkfO6pO4bqbzqDDpxfeaRbN0kYM7nm94/Q3TJPHgHsaM2nny5UNpCMi1TE919Q+H
         CJmm6fqEds9YzkE2HRypmrMUQqfH8UvH71dW9fGolRmyYGBtJkG6Hnml0X/+MMVgHhtp
         H6DtSE7nncWODGfSwryOPWcWmNbfOqjZVkBitCnJoajh3OC9+vzna4aknXP7OfhzvVXv
         pMDg==
X-Gm-Message-State: ANoB5pme0hYDLFfCaBoYEeHFQbYIHC64JQBPtZAf7qu+o2DF29ZqpB0e
        xylOtxFgVv/KVB29afIerl7o0buCfWe3/D1esWw=
X-Google-Smtp-Source: AA0mqf7LgCZoZ07/92iZ3thrh0L+z+qVc3ww/JjzRrnfKw6vtd0GR9kaVUW6OfFyNKkp93fldJlYxi0tkXrI8TxKrQg=
X-Received: by 2002:a05:6000:1084:b0:241:f866:6bc8 with SMTP id
 y4-20020a056000108400b00241f8666bc8mr1775664wrw.501.1669262130610; Wed, 23
 Nov 2022 19:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20221122013338.3696079-1-senozhatsky@chromium.org>
 <Y3w/DFTAypX7L2mp@cmpxchg.org> <Y3xCTr6ikbtcUr/y@google.com>
 <Y37l3Xxb172q632L@google.com> <20221123194243.4031e6918c55437071d3a344@linux-foundation.org>
In-Reply-To: <20221123194243.4031e6918c55437071d3a344@linux-foundation.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 23 Nov 2022 19:55:19 -0800
Message-ID: <CAKEwX=Ni6V=8cLvff-F_Vu8jR0x2mXvbDGAzyqgD3uJOpnHVWA@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not allocate from atomic pool
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 7:42 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 24 Nov 2022 12:32:45 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>
> > Folks, how do we want to proceed with this? One of the hunks here
> > conflicts with https://lore.kernel.org/lkml/20221119001536.2086599-2-nphamcs@gmail.com/
> >
> > Do we want to remove conflicting hunk from "[PATCH 1/6] zswap: fix writeback
> > lock ordering for zsmalloc" and pick this patch up?
> >
>
> The "Implement writeback for zsmalloc" series is clearly due for one or
> more new versions, so I will drop that series and I will apply "zswap: do
> not allocate from atomic pool".  Let's ask Nhat Pham to prepare future
> revisions of the "Implement writeback for zsmalloc" series against
> mm-unstable.

Will do! Apologies for the constant churning - but this should be a
quick and easy change
from my end. v7 should be out next week. Have a nice Thanksgiving everyone!
