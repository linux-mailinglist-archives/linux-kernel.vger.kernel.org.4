Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5E6EB1C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjDUSjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjDUSjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:39:07 -0400
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9921FF3;
        Fri, 21 Apr 2023 11:39:06 -0700 (PDT)
Message-ID: <b6dfbc63d89715a1298117bc0afeb436.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1682102343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xu/A0sGZABzTtCZ5T1EI8r0dy3MZmrDAsQUyPMNdKJ8=;
        b=od/6EJKJcn1yXwsU4vEpxhv++WsIFIwBxgLe2VSqk1MeH0oeGEKs2vgK7+7yh2ZmBNxZue
        tV9O3qB7eKPXoQfLxH50blDVQej7/vWfU1kKHPdQpPHcmk7TpESqT4fE3ZUCHNcEB5jriz
        Cbk7SPDRI5PjX7n1IcWNOoUmK5PqcZxllosU+sY1xuUxvVhsYWFvRZOIyQv8B+kAuCWh6m
        g98Pk8NC6kGphI5St5683Rj6hX8X0rRBdcuONOx+N+xxVNHG7e0Dg/60fUC4XmHDXK16eh
        cbHxZ+2dDlnBGStncBw8d00RFYq549Fts6wYfo//+UewYhNpOsoCOZor7tyPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1682102343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xu/A0sGZABzTtCZ5T1EI8r0dy3MZmrDAsQUyPMNdKJ8=;
        b=fXzXe3Gu1UkMJVoUdfLFJoMA8wATq2vY3FLKJh0yRyRNYi0ofDuN8Qqp6piSG8f9dxllsM
        rnQggNgCylYnLvsTS3lHYY+k59Kdvcv8vAONUt8aTQGsXAEikJX+CwJoqpHMcpEJlOWii3
        ZTffFHRn0VD3zXIMwEzdLgRIxCYEEG33HFA6gTc5Dd8ab85xKn9/bV+fUJ2ExLBwJPNiPb
        mUO4VdOtvJ0yXsWjN5jLfnGv6W8af6ahk4qESjXFJmaAul5Sv4ui5uBe1GLNMvUxTXCCrO
        dADfD+QWdM6jqgKz/T+mfWAi3r4Zg6Xc6iEoUvqVkYJET+cssJ7JUHBC33Bk2w==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1682102343; a=rsa-sha256;
        cv=none;
        b=CcghgD5TFQ9bquEGIUo3Cd1UvctPVoaIo8l501jebbUbUY7XjxeXPssmjZ4SHKgK4XcXLB
        s2qOzvI7KBOT2PQ/lMVuy9XZJ8SI4/BnCHiSOgGsx63m2VPQXS3ntZqqqoQ+8lmscrOwbT
        EcvDRl2khXG8z4Tum/Yz8AwKcJBXnvfkeq53LsT8DalBiZE7PiUuZfM3Tfi4uc6BFmCiRm
        4ARwfkjpYJe4mUxvtg0RtDsQy+2ChxZwr0A1RXrC8zmiohxd/0JvGI7ibX4PPsA1n7hySX
        jdwOKzsgJuZOHmEc1Ms5wH12+eykvcKU8A802psCx/7AIAcb8+YqRSqH078E0Q==
From:   Paulo Alcantara <pc@manguebit.com>
To:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: Re: [PATCH 17/22] cifs: Use alloc_ordered_workqueue() to create
 ordered workqueues
In-Reply-To: <20230421025046.4008499-18-tj@kernel.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-18-tj@kernel.org>
Date:   Fri, 21 Apr 2023 15:38:57 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> BACKGROUND
> ==========
>
> When multiple work items are queued to a workqueue, their execution order
> doesn't match the queueing order. They may get executed in any order and
> simultaneously. When fully serialized execution - one by one in the queueing
> order - is needed, an ordered workqueue should be used which can be created
> with alloc_ordered_workqueue().
>
> However, alloc_ordered_workqueue() was a later addition. Before it, an
> ordered workqueue could be obtained by creating an UNBOUND workqueue with
> @max_active==1. This originally was an implementation side-effect which was
> broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
> ordered"). Because there were users that depended on the ordered execution,
> 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
> made workqueue allocation path to implicitly promote UNBOUND workqueues w/
> @max_active==1 to ordered workqueues.
>
> While this has worked okay, overloading the UNBOUND allocation interface
> this way creates other issues. It's difficult to tell whether a given
> workqueue actually needs to be ordered and users that legitimately want a
> min concurrency level wq unexpectedly gets an ordered one instead. With
> planned UNBOUND workqueue updates to improve execution locality and more
> prevalence of chiplet designs which can benefit from such improvements, this
> isn't a state we wanna be in forever.
>
> This patch series audits all callsites that create an UNBOUND workqueue w/
> @max_active==1 and converts them to alloc_ordered_workqueue() as necessary.
>
> WHAT TO LOOK FOR
> ================
>
> The conversions are from
>
>   alloc_workqueue(WQ_UNBOUND | flags, 1, args..)
>
> to
>
>   alloc_ordered_workqueue(flags, args...)
>
> which don't cause any functional changes. If you know that fully ordered
> execution is not ncessary, please let me know. I'll drop the conversion and
> instead add a comment noting the fact to reduce confusion while conversion
> is in progress.
>
> If you aren't fully sure, it's completely fine to let the conversion
> through. The behavior will stay exactly the same and we can always
> reconsider later.
>
> As there are follow-up workqueue core changes, I'd really appreciate if the
> patch can be routed through the workqueue tree w/ your acks. Thanks.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Steve French <sfrench@samba.org>
> Cc: Paulo Alcantara <pc@cjr.nz>
> Cc: Ronnie Sahlberg <lsahlber@redhat.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> ---
>  fs/cifs/dfs_cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
