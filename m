Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37595BE0BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiITItm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiITIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:49:27 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D64647CC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:49:25 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p5so2092638ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=avM2JaVz9NzVtQII/XtgHHxaQA02fvGFDYoIGdJRzAY=;
        b=h3MEJo8KfgdtxNKfxd7Bn1dOV8WYJXSTSzVFDgnJS9ErCWyOA+MrJrX/HldOGC6Qy0
         ACCgLZEQIiUeE1cR2S9KI2RlDVje5wCZgwkJnkLBV9OGfOmduTRbYTko1A43M+lzLk5p
         f3Sz1guQXSnM7ms1ObceO6f05ilrLGT7GBwJ5ISAXfCN2XkQePLbkx7syTQek18Ie93A
         VgbvcZuC1Jyp39bOuKx26q3DRAf6jCwL/QZI8H9HFbG3CWt9dQC1OpV/6sw1sIiFzXYT
         zmqCuXMN+UKGy4kSFbUnE6+BeMt1BdXxvGC3Y0Ur4VVOrW+x/6puf0TnNXFtXYeN2nG3
         UwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=avM2JaVz9NzVtQII/XtgHHxaQA02fvGFDYoIGdJRzAY=;
        b=HuK72pL2ymKbU9NM9dw+oB8PdynWagnuTfeW4MEzZlL+cGV6XBvXnI3I6mPU6dwGyy
         v0kpnzp7gpaLBrGwkQ3gWA1yVXpejuNcM/EmDnqng7Y8MYmGTzhkstWgn1shWbxVTxmB
         A958x1THMsLWH8dDHcLZSKimLJhwiZVxh1tjrzhyGwM+3WnqyFKeWe9Smi8Ydsez3ibk
         RoFR3tgoT1shC759vqWZOmtYVQcpnAY5WbB2St4K2hDcqAQL7JqBBqjWOMlfMr/rAGwO
         2/+CLNBJFXfnDX2IwvQklsI0DJaTCwqyBxpHUz1hjmSDA/GJcQN43JIE0oR8c8vVypi3
         igfw==
X-Gm-Message-State: ACrzQf2uSPbznEe4HooDcw1i7EGvAL3qUqLjPq0eg/3MWRJJ/Eb0q1lR
        NCECwcQYxIbM0dFgh3wQkZEvtAcs69DPrW/4KJ6rI8wu
X-Google-Smtp-Source: AMsMyM6jDHLoSohMNs5WAtMtfasbnBmxT4I+611rAp0kp9gyW2OmBeNYK7Quk+AY4vYeBrglnXPtotv4l0lSkFKkiv4=
X-Received: by 2002:a05:651c:222c:b0:26b:dec5:a4f0 with SMTP id
 y44-20020a05651c222c00b0026bdec5a4f0mr7132005ljq.359.1663663761407; Tue, 20
 Sep 2022 01:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <1663325892-9825-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20220919101629.xlafi2y2dk357wk3@techsingularity.net> <CAGWkznFEBDwDVeR1AH6gk30PHU3pvSHBusOSQgEB2L7mZD4Mxg@mail.gmail.com>
 <20220920084555.rzphzayirdbtht2w@techsingularity.net>
In-Reply-To: <20220920084555.rzphzayirdbtht2w@techsingularity.net>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 20 Sep 2022 16:48:53 +0800
Message-ID: <CAGWkznF2VvT=3sj3w8TC4JJ4XN0Y+CLGg_AYxxc4iuuVR518PQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: check global free_list if there is ongoing
 reclaiming when pcp fail
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
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

On Tue, Sep 20, 2022 at 4:46 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Sep 20, 2022 at 09:45:35AM +0800, Zhaoyang Huang wrote:
> > On Mon, Sep 19, 2022 at 6:22 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Fri, Sep 16, 2022 at 06:58:12PM +0800, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Check the global free list again even if rmqueue_bulk failed for pcp pages when
> > > > there is ongoing reclaiming, which could eliminate potential direct reclaim by
> > > > chance.
> > > >
> > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Patch does not apply and may be based on a custom kernel that introduced
> > > a problem. There is no description of what problem this is trying to
> > > fix. Checking the status of reclaim for a specific zone in this path would
> > > be a little unexpected.  If allocation pressure is exceeding the ability
> > > of reclaim to make progress then the caller likely needs to take action
> > > like direct reclaim. If the allocation failure is due to a high-order
> > > failure then it may need to enter direct compaction etc.
> >
> > Agree with the above comment. This is a proposal aiming at avoiding
> > direct reclaiming things with minimum cost, that is to say, about 5
> > CPU instructions in return with the overhead of function calls which
> > has both of several loops inside and potential throttle sleep by IO
> > congestion etc.
>
> If the refill fails and kswapd is failing to keep up then actions like
> direct reclaim or compaction are inevitable. At best, this patch would
> race to allocate pages in one context that are being freed in parallel by
> another context.
>
> Nak.
ok, I have noticed that the latest modification has made some changes
on this path. thanks for comment
>
> --
> Mel Gorman
> SUSE Labs
