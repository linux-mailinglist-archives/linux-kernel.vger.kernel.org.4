Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEC56BBD12
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjCOTPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjCOTPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:15:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DB55BBB;
        Wed, 15 Mar 2023 12:15:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A189B5C04B5;
        Wed, 15 Mar 2023 15:15:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 15 Mar 2023 15:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678907701; x=1678994101; bh=v6
        ZoToA1k6gqpn+EgxrEPuv+QScgUq6fxEjc2tGsk1o=; b=g7ukc8xYAkKMllfnY0
        4QMFQIEk4LwU8sjFkcRie+wOfMrguoqUUjjyqKwy6goZUI1SJAot+4dvU2O1urwI
        daffMXL+7waw+KpfrFJ351hrKK58bu5cYZipM6wwbeDtdMxFT50Qy+buX0Xiw63y
        1LUa/Ar+Fy9wAVQARmrSrQsTt+EAO6IXyvgj+A8kgkMnBBbYYVwtULgY+wzLVvb/
        NQYl7UhDgfbhCgo/Hr1cklZPGgR0zbT4On7UFV1GM6/Ox9Tx09udXTa5n3+TfKJE
        ks1O7dHi/a9aWBujuWnHy3nLsGVwIFCZI3eD+2Fbufkzq8kqDkJg8h3zajNdpiW0
        MEMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678907701; x=1678994101; bh=v6ZoToA1k6gqp
        n+EgxrEPuv+QScgUq6fxEjc2tGsk1o=; b=jLaz5Qi/YDTukabJCwaIqer0DU0gt
        hpBDEaGKEIipdTEK6HYHqeZcgTyKxKSr4DyQdZeaiOijVIAYeGTWDgYcXhgrtTDI
        h9dmheLfVpqdJIK64sDHaMWXWwA7oXb/xH4m+ZJ6mOARz7HJZjWnhZj0+RtIqWtY
        PujCvSFSuPl23sEWFlfXTOQ4SRFCBOLOdtmcyAWO+z5GBtS/O6pd83JdykHbvOO7
        mNejrZu1N+mTlhiNEcyo7xf0r+mry8cchh4XXIy/2jyoyG4aMeRO7oVgjjQeuiag
        014N0RarIcEW6SYFVejB8NVZRmzJesF3Z+Sd00b2+fYugZzeTtHnA1Vsw==
X-ME-Sender: <xms:NBkSZL94wlppeLaMWKWUuV_YrGi_bFPUFLwxwMUjWYEKVnV2uvGjDw>
    <xme:NBkSZHsfU5ex2Jjio89Cxz48XG5tcwubLyOV1JPiuHICQHwRjypcZvAT7TpHZ71gP
    AFGW9YK9FYf-EYKsg>
X-ME-Received: <xmr:NBkSZJBBccMufxzHpFL8DPzSgRDYqElSFPBnazHDGS_F8z0mmPKKygAB3vogZ7xapVwmOB9CkLUHyi2KAz-YvS0evSS-9tSrxHBjCXWFVIlJVgmei_N7MCXWpXyc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomheptehnughrvghsucfhrhgvuhhnugcuoegrnhgurhgvshes
    rghnrghrrgiivghlrdguvgeqnecuggftrfgrthhtvghrnheplefhffdtveeuhfetjefhgf
    elgeefffdvhfekkeejudehkeffleekteetudefuefhnecuffhomhgrihhnpehlkhhmlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:NBkSZHe2w42AJuYfKnXOrtnGITQ4EiqDyOz18p_dsBILTCO6Uiyneg>
    <xmx:NBkSZANfO9bFuEQLVZA3Ogru8Xfx_QVDGJZmAOnMa6pkxOe8y5uzPQ>
    <xmx:NBkSZJnCTkC-7rAqOsnAeH5iNi0_ajlM_rf02HiwaQ5yDboWuEpT4Q>
    <xmx:NRkSZBiuM2-Dr0uoSY_309HpRjcmehNiA2xOTMh9qkN8jJ6ohNkbXg>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 15:15:00 -0400 (EDT)
Date:   Wed, 15 Mar 2023 12:14:59 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, arnd@arndb.de, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v11 0/3] cachestat: a new syscall for page cache state of
 files
Message-ID: <20230315191459.f3z3gahxdew4dwrv@awork3.anarazel.de>
References: <20230308032748.609510-1-nphamcs@gmail.com>
 <20230314160041.960ede03d5f5ff3dbb3e3fd0@linux-foundation.org>
 <20230315170934.GA97793@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315170934.GA97793@cmpxchg.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-03-15 13:09:34 -0400, Johannes Weiner wrote:
> On Tue, Mar 14, 2023 at 04:00:41PM -0700, Andrew Morton wrote:
> > A while ago I asked about the security implications - could cachestat()
> > be used to figure out what parts of a file another user is reading.
> > This also applies to mincore(), but cachestat() newly permits user A to
> > work out which parts of a file user B has *written* to.
>
> The caller of cachestat() must have the file open for reading. If they
> can read the contents that B has written, is the fact that they can
> see dirty state really a concern?

Random idea: Only fill ->dirty/writeback if the fd is open for writing.


> > Secondly, I'm not seeing description of any use cases.  OK, it's faster
> > and better than mincore(), but who cares?  In other words, what
> > end-user value compels us to add this feature to Linux?
>
> Years ago there was a thread about adding dirty bits to mincore(), I
> don't know if you remember this:
>
> https://lkml.org/lkml/2013/2/10/162
>
> In that thread, Rusty described a usecase of maintaining a journaling
> file alongside a main file. The idea for testing the dirty state isn't
> to call sync but to see whether the journal needs to be updated.
>
> The efficiency of mincore() was touched on too. Andres Freund (CC'd,
> hopefully I got the email address right) mentioned that Postgres has a
> usecase for deciding whether to do an index scan or query tables
> directly, based on whether the index is cached. Postgres works with
> files rather than memory regions, and Andres mentioned that the index
> could be quite large.

This is still relevant, FWIW. And not just for deciding on the optimal query
plan, but also for reporting purposes. We can show the user what part of the
query has done how much IO, but that can end up being quite confusing because
we're not aware of how much IO was fullfilled by the page cache.


> Most recently, the database team at Meta reached out to us and asked
> about the ability to query dirty state again. The motivation for this
> was twofold. One was simply visibility into the writeback algorithm,
> i.e. trying to figure out what it's doing when investigating
> performance problems.
>
> The second usecase they brought up was to advise writeback from
> userspace to manage the tradeoff between integrity and IO utilization:
> if IO capacity is available, sync more frequently; if not, let the
> work batch up. Blindly syncing through the file in chunks doesn't work
> because you don't know in advance how much IO they'll end up doing (or
> how much they've done, afterwards.) So it's difficult to build an
> algorithm that will reasonably pace through sparsely dirtied regions
> without the risk of overwhelming the IO device on dense ones. And it's
> not straight-forward to do this from the kernel, since it doesn't know
> the IO headroom the application needs for reading (which is dynamic).

We ended up building something very roughly like that in userspace - each
backend tracks the last N writes, and once the numbers reaches a certain
limit, we sort and collapse the outstanding ranges and issue
sync_file_range(SYNC_FILE_RANGE_WRITE) for them. Different types of tasks have
different limits. Without that latency in write heavy workloads is ... not
good (to this day, but to a lesser degree than 5-10 years ago).


> Another query we get almost monthly is service owners trying to
> understand where their memory is going and what's causing unexpected
> pressure on a host. They see the cache in vmstat, but between a
> complex application, shared libraries or a runtime (jvm, hhvm etc.)
> and a myriad of host management agents, there is so much going on on
> the machine that it's hard to find out who is touching which
> files. When it comes to disk usage, the kernel provides the ability to
> quickly stat entire filesystem subtrees and drill down with tools like
> du. It sure would be useful to have the same for memory usage.

+1

Greetings,

Andres Freund
