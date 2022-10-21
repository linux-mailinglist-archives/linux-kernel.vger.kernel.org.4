Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA236607F59
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJUT5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJUT53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:57:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1C229B8B4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7107B82CF8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 19:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C01DC433D6;
        Fri, 21 Oct 2022 19:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666382245;
        bh=r/gH1vZeM2eaYq/F6qx5zNBBsm+/2ttTexROId1tGkc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aTkzUyECW1oOAFZ0ollGbwtQhcKMmHrkTOZkhH1/l9gBu+/BEMrrFgenpWFXV9L9G
         fNbTQ0hyZgPLE4FQr4OaeI5Kf6p2KDNti08VhXTUKo57rrv63V+yB/MYfPttDTjWma
         VS0aA6InrFHv/YqxPHe7kRHxlBJVuewFnPjZnoFk=
Date:   Fri, 21 Oct 2022 12:57:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 0/9] mm/ksm: break_ksm() cleanups and fixes
Message-Id: <20221021125724.0bc29fdad1c696b8fe92f7f9@linux-foundation.org>
In-Reply-To: <20221021101141.84170-1-david@redhat.com>
References: <20221021101141.84170-1-david@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 12:11:32 +0200 David Hildenbrand <david@redhat.com> wrote:

> This series cleans up and fixes break_ksm().

Quite a lot of fixups were needed merging this.  I guess you couldn't
develop against mm-unstable because the v1 series was already in there.

For this reason I'll henceforth be more inclined to drop serieses when
I know a full resend is coming out.

So please do let me know when a full resend is coming out.  Or, of
course, send little fixes against the current version.
