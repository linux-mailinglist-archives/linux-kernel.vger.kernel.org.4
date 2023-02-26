Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB86A33C5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 20:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBZTvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 14:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZTvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:51:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C5FCA0A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 11:51:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C706360C50
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AABC433D2;
        Sun, 26 Feb 2023 19:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677441062;
        bh=2QXctkD8k3HFIzMIRhHltAB2/f2+KokissGTQsAOBGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EfIBXqfAuly+kWLKq1/3UeS/SZpxE/UfiuKnucLBUhnsL+pzC3TOBPJCicsVnhyHI
         Hu8mdoYa1t/aK/e49MyuSuOXvvyDkSf9su6G7qIYhX/nFEaZ3AW560KtgYoOPU4Ur+
         IE8zaxeJB+iQEI7NwYkurhGKaI+21NcLw2daev4M=
Date:   Sun, 26 Feb 2023 11:51:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, sultan@kerneltoast.com,
        dave@stgolabs.net, penguin-kernel@I-love.SAKURA.ne.jp,
        paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] make slab shrink lockless
Message-Id: <20230226115100.7e12bda7931dd65dbabcebe3@linux-foundation.org>
In-Reply-To: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Sun, 26 Feb 2023 22:46:47 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> Hi all,
> 
> This patch series aims to make slab shrink lockless.

What an awesome changelog.

> 2. Survey
> =========

Especially this part.

Looking through all the prior efforts and at this patchset I am not
immediately seeing any statements about the overall effect upon
real-world workloads.  For a good example, does this patchset
measurably improve throughput or energy consumption on your servers?


