Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA3A61E7BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 00:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiKFXzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 18:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKFXzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 18:55:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2723ED2C8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 15:55:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91F6260E04
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6F3C433C1;
        Sun,  6 Nov 2022 23:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667778908;
        bh=bjJ8NTyavDSRWAsWa9+hTtgMREs2cKp4Ko75e1GmCas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mEWhuXlOGMXOKcrvEk0IOgGkl+h8jyuhPESeshfMv7OBErObyl5trr50jJ+Iifuxj
         jxbdluIpHQar+hQ4aUsWar+SocBo/LKMHtrozHFP4kvd+7PrDyCF2vSWrbFL5VK4j6
         vUqWMLLDixIGhVY12Jj+Us5w32jd6/I+Og5oN4FU=
Date:   Sun, 6 Nov 2022 15:55:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
Message-Id: <20221106155506.64c5d42a73c507d666da2172@linux-foundation.org>
In-Reply-To: <97b7ae87-797c-4ebb-d2d3-9415975188@google.com>
References: <20221104142259.5hohev5hzvwanbi2@techsingularity.net>
        <97b7ae87-797c-4ebb-d2d3-9415975188@google.com>
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

On Sun, 6 Nov 2022 08:42:32 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> I'd advocate for dropping this patch of yours too; but if it's giving
> nobody else any trouble, I can easily continue to patch it out.

Thanks, I'll drop it for now.  Please keep plugging away at mm-unstable
until we can get it less so, then let's start moving forwards again.

