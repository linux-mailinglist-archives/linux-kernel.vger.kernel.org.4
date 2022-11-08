Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47B5621CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiKHTUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKHTUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:20:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC926DCF0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:20:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0021BB81C1F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CDAC433C1;
        Tue,  8 Nov 2022 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667935248;
        bh=lSWh6KueHW2D2cCI1e6XgRgfCAZCXJp2SvH8ZCctdQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RjW5IuvVJuvf8m8jtlvWjN7IP5Lxg/IdYSVUHtB5w+3xcGR6Y51TqGAZlCEeLwCEm
         ru/aUCiSB8zCtT5VUboReSig9l/TVbM5YI/AomHEsi2MNek77kDzxWjYok9zXYd3O4
         s+PulOBtRKjVzig1A8gNDr6Bu2iv4eDom6dvJg9U=
Date:   Tue, 8 Nov 2022 11:20:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     zokeefe@google.com, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com,
        "Zach O'Keefe" <zokeefe@googel.com>
Subject: Re: [mm-unstable v3 PATCH 2/3] mm: khugepaged: allow page
 allocation fallback to eligible nodes
Message-Id: <20221108112047.38525702a68029769d4a04f7@linux-foundation.org>
In-Reply-To: <20221108184357.55614-2-shy828301@gmail.com>
References: <20221108184357.55614-1-shy828301@gmail.com>
        <20221108184357.55614-2-shy828301@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Nov 2022 10:43:56 -0800 Yang Shi <shy828301@gmail.com> wrote:

> Syzbot reported the below splat:
> 
> ...
>

"mm: don't warn if the node is offlined" remains in
mm-hotfixes-unstable, so I'll just drop it.

> 
> Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
> Suggested-by: Zach O'Keefe <zokeefe@google.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Zach O'Keefe <zokeefe@googel.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

I should add cc:stable, yes?

Are we able to identify a Fixes: target?


