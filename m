Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B964602079
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJRBfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJRBfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:35:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FCF52E48
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDFBBB81BF0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23851C433C1;
        Tue, 18 Oct 2022 01:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666056909;
        bh=VfAtN/IPo47bfjyS5rb/uySzxPxu5vxEkMuM5gOYO74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kK6S8uS5qCx8fi1c5YGvXdGuhL3RriGLefAr+XyuMTBfhgRlt73GVI4It3X+Fm109
         3XwWg2gU45qom//1RIN/AMJER5KqgDy5kOjk93ipsNNi4W6T74Ij9dM8smIz7RWGw0
         aX+s4mv3FJCUT47XWGwhhI1iDvNRog2hxg6P2ZEU=
Date:   Mon, 17 Oct 2022 18:35:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Christoph Lameter <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/8] cgroup/cpuset: use hotplug_memory_notifier()
 directly
Message-Id: <20221017183508.de7172a0ab6b18e4a1ec4625@linux-foundation.org>
In-Reply-To: <20220923033347.3935160-2-liushixin2@huawei.com>
References: <20220923033347.3935160-1-liushixin2@huawei.com>
        <20220923033347.3935160-2-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
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

On Fri, 23 Sep 2022 11:33:40 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> Since patch 316346243be6 

That's a merge commit.  I'll rewrite this to 76ae847497bc52
("Documentation: raise minimum supported version of GCC to 5.1"). 
Which, although misnamed is the commit which made the change.

> has already updated the minimum gcc version to 5.1.
> The previous problem mentioned in patch f02c69680088

I'll make that f02c69680088 ("include/linux/memory.h: implement
register_hotmemory_notifier()").

And hot damn I write good changelogs!  Wrote :(

> is not existed. So we
> can now revert to use hotplug_memory_notifier() directly rather than
> register_hotmemory_notifier().

I redid the changelogs thusly:

: Commit 76ae847497bc52 ("Documentation: raise minimum supported version of
: GCC to 5.1") updated the minimum gcc version to 5.1.  So the problem
: mentioned in f02c69680088 ("include/linux/memory.h: implement
: register_hotmemory_notifier()") no longer exist.  So we can now switch to
: use hotplug_memory_notifier() directly rather than
: register_hotmemory_notifier().

