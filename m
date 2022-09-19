Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA115BC27C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 07:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiISFUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 01:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiISFUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 01:20:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE971262A;
        Sun, 18 Sep 2022 22:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA1A1B811D9;
        Mon, 19 Sep 2022 05:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9369AC433D6;
        Mon, 19 Sep 2022 05:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663564798;
        bh=qF05DrY3yt69GqyBseG8lIi7RijrYoCKsLQwIeqSou4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w2TW5OXHBnFGqdv7A8i0z/Yb5PcrkcUhe2/HOmNQuK9nZvLy+5+7xNFW81Yu/uTpE
         zwsB5bAGdYpBIQpDfB8RgLvOltUvqaYuSuDHYCj/5W+g/5iEL77zZiuiOq9q8Xdt4B
         hzyfa7UjSOTTM2acD6YBvf1+kv+uZ3fOh03cTsBY=
Date:   Sun, 18 Sep 2022 22:19:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Yu Zhao <yuzhao@google.com>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com
Subject: Re: [PATCH mm-unstable v15 00/14] Multi-Gen LRU Framework
Message-Id: <20220918221956.04beefd36e3622490059e537@linux-foundation.org>
In-Reply-To: <YyfPO8rVujtUzEwt@debian.me>
References: <20220918080010.2920238-1-yuzhao@google.com>
        <YyfPO8rVujtUzEwt@debian.me>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022 09:08:59 +0700 Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> The base commit is on what tree? Or I have to wait for rebasing this
> series on top of latest mm-unstable.

I pushed this series out in mm-unstable several hours ago.
