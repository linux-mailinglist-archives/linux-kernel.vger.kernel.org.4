Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782A873764C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjFTUzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFTUzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:55:52 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4441718
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:55:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C76E0320092D;
        Tue, 20 Jun 2023 16:55:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 20 Jun 2023 16:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687294549; x=1687380949; bh=jL
        wjxXidYR03NQqMGEOwIDdRP2UTQNWbZ7zItOdShrw=; b=kzzsNaPOa0XFhhBycA
        nWaMtSnqQ2DvpJ4s5KDSKzQwhuOmszKazGGgeWxgvQv/h+atmCnR105Dba7pOpEr
        qyw+mYIAvvX0oSLnhpWuWvU1OuEwc/dIDUtx+hNsd4tYulYIyUtc9gvcjMjb3qXe
        qlgV/hXaRg/dJWnzFTDl4u8WJpxuUAWBwfatNNnMqC1Ain9KegGGPrKQnmH4zWkG
        H9I7cnIxgSgFeZgR3a1T8jVSTIJXusCHWae1VN+iKEdO19lKDdBsMK/t94BJ0ILw
        lWqNDrvWfT9JTSK04wJ6Ky7f2FSViN3O7Qe6kwViGrxwj9WQLcrwhkQw8VTyUymF
        QwUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687294549; x=1687380949; bh=jLwjxXidYR03N
        QqMGEOwIDdRP2UTQNWbZ7zItOdShrw=; b=e0ziG89/qBaJj7UwzLjoc27dXQsOZ
        BVr0/4VI1Js1J8jF9H/Avt19GDmxYUn1t3bK+d19Rp525X9ySAxy+psiPxcC/XhO
        KBDOzPJ7SYGAli+KMkUsqCCtNi9Bvj4JJ22EpYZ1eiuf+EDpYxzu5vgLXQk8pEfK
        KfPkGxSUEVm3E7nTzG7BhwfDILGb+YLPo/lzI7pOxHEQi1mQqXqNIA6ewGO6Gn94
        RMWUu8mWvdeeKw1icLdncsDIfizCCgJNTxERiy1M7wiDQ6rDomO8fvoahr4CYpdo
        dtUFgUCHrojWVwb8/Q6zFQfpCcyBVLGKeusE8EdcxuvUnzN7+kk2JJ5ag==
X-ME-Sender: <xms:VBKSZHSya69zvadFqQ2g3IRMMg4klPpEbV_Nw7uOp7O6QYfDjXoksQ>
    <xme:VBKSZIxPFdYsnZFo_hzlcSn2wgnhoO2KH0jRcbXrby_D911F2-GDDI4YjkN1B-6sX
    IdSwCXjBt-imJzeJQ>
X-ME-Received: <xmr:VBKSZM3--gBMU_0Z-qxq1ZTLckn8RXSID02QOa-Mxt2fdouzTd27a9QrSrdffXrnbluYltESw63mAB1fdjgrhUSPjJaTba-S8pja0WO5OpKzyO_84fpXVdW8cj3d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefhedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
    udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:VRKSZHAXqttydf6bZkV2jF_HhEAbVA5WNbtrlBGGFQTVWpoJbNMABw>
    <xmx:VRKSZAhf_k_2S1xN_70UgzNCp5isdUUt34K_hApRhQUwyGaeVm0JoQ>
    <xmx:VRKSZLpC9qS_vBlHeQOUF80K4XXSCByMAkAzR8uopUSM2mBIJkbmYA>
    <xmx:VRKSZDP0M9a29fbW4a_8bGe7STs6lOzBWY8LbTmxkmqTeVXvu8MzVg>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jun 2023 16:55:48 -0400 (EDT)
Date:   Tue, 20 Jun 2023 13:55:47 -0700
From:   Andres Freund <andres@anarazel.de>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] mm/khugepaged: maintain page cache uptodate flag
Message-ID: <20230620205547.qzmivkjox2hkpzmm@awork3.anarazel.de>
References: <20230404120117.2562166-1-stevensd@google.com>
 <20230404120117.2562166-5-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404120117.2562166-5-stevensd@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-04-04 21:01:17 +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Make sure that collapse_file doesn't interfere with checking the
> uptodate flag in the page cache by only inserting hpage into the page
> cache after it has been updated and marked uptodate. This is achieved by
> simply not replacing present pages with hpage when iterating over the
> target range.
> 
> The present pages are already locked, so replacing them with the locked
> hpage before the collapse is finalized is unnecessary. However, it is
> necessary to stop freezing the present pages after validating them,
> since leaving long-term frozen pages in the page cache can lead to
> deadlocks. Simply checking the reference count is sufficient to ensure
> that there are no long-term references hanging around that would the
> collapse would break. Similar to hpage, there is no reason that the
> present pages actually need to be frozen in addition to being locked.
> 
> This fixes a race where folio_seek_hole_data would mistake hpage for
> an fallocated but unwritten page. This race is visible to userspace via
> data temporarily disappearing from SEEK_DATA/SEEK_HOLE. This also fixes
> a similar race where pages could temporarily disappear from mincore.
> 
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> Signed-off-by: David Stevens <stevensd@chromium.org>

I noticed that recently MADV_COLLAPSE stopped being able to collapse a
binary's executable code, always failing with EAGAIN. I bisected it down to
a2e17cc2efc7 - this commit.

Using perf trace -e 'huge_memory:*' -a I see

  1000.433 postgres.2/1872144 huge_memory:mm_khugepaged_collapse_file(mm: 0xffff889e800bdf00, hpfn: 46720000, index: 1537, is_shmem: 1, filename: "postgres.2", result: 17)
  1000.445 postgres.2/1872144 huge_memory:mm_khugepaged_scan_file(mm: 0xffff889e800bdf00, pfn: -1, filename: "postgres.2", present: 512, result: 17)
  1000.485 postgres.2/1872144 huge_memory:mm_khugepaged_collapse_file(mm: 0xffff889e800bdf00, hpfn: 46720000, index: 2049, is_shmem: 1, filename: "postgres.2", result: 17)
  1000.489 postgres.2/1872144 huge_memory:mm_khugepaged_scan_file(mm: 0xffff889e800bdf00, pfn: -1, filename: "postgres.2", present: 512, result: 17)
  1000.526 postgres.2/1872144 huge_memory:mm_khugepaged_collapse_file(mm: 0xffff889e800bdf00, hpfn: 46720000, index: 2561, is_shmem: 1, filename: "postgres.2", result: 17)
  1000.532 postgres.2/1872144 huge_memory:mm_khugepaged_scan_file(mm: 0xffff889e800bdf00, pfn: -1, filename: "postgres.2", present: 512, result: 17)
  1000.570 postgres.2/1872144 huge_memory:mm_khugepaged_collapse_file(mm: 0xffff889e800bdf00, hpfn: 46720000, index: 3073, is_shmem: 1, filename: "postgres.2", result: 17)
  1000.575 postgres.2/1872144 huge_memory:mm_khugepaged_scan_file(mm: 0xffff889e800bdf00, pfn: -1, filename: "postgres.2", present: 512, result: 17)

for every attempt at doing madvise(MADV_COLLAPSE).


I'm sad about that, because MADV_COLLAPSE was the first thing that allowed
using huge pages for executable code that wasn't entirely completely gross.


I don't yet have a standalone repro, but can write one if that's helpful.

Greetings,

Andres Freund
