Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755DD748DA7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjGETWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjGETWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:22:08 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEFD46B7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:18:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AA03F5C023D;
        Wed,  5 Jul 2023 15:06:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 05 Jul 2023 15:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1688583966; x=1688670366; bh=FdlxGSSLp6tolBO74VVirW7wUfppCI5xiiK
        HdFx4B08=; b=fqQ5HCngeeqMUvgN9JYDZ8MpBBrq2mZr1ijbXp14mORAzg7+56Z
        XjSU07H5y4aV7ZcrCJEUHCUZh1GCim5OqouXGdOjl9ri4hHAnmi5og0WMs+v/j6j
        XpK9OFe6XRBAxH0f54fQUoDqCdAaXthsYlmuYteQqevk3aXacDJYQjjzU9l041OR
        6tZNY37pMRQTs5597hhDLWolawstqjQintOH6Re56wfqKyMMYxt6nn9vvtxZKpEk
        9LREF/rhBwWjxlUvo2E70DX76Bh55CDcU1FURTzMayf04u3Qw9+D0LQcPziaq2sH
        T07ZXBB1sNCNVCMzP76ccc5+9bY2P3ad06g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688583966; x=
        1688670366; bh=FdlxGSSLp6tolBO74VVirW7wUfppCI5xiiKHdFx4B08=; b=e
        jdVqcIoJpVJYBoS+XpO5O2iVG97y6Mhf98eZz+7dYWmOpDH5qms3qAF7nIA/BgDe
        glzBwYY/z82g52hFhfPbfFThDJ06TUK+FdIcjNwFsqhwWBJ+rUG+E0nZlIuigqcK
        rS6gIqxsF4YNK9oAzVatxRsVZyO6B9Fly465Ad7r5WRXZ7w6IMTa4g0Oeivhu26c
        es14adEDT72nfqca7R58n7/xZn7KvhUEAQKQn8aPA6gF4dP+fpfQI8pUjO381CuE
        pnV27LcnuqKI7lWUGkaGHN35twAAylA48W8IFRL95NWAEcXBLfCgipfcgfaiDt6A
        D8XUA6m20hv6IGQS6ccBA==
X-ME-Sender: <xms:Hb-lZAx6qIxIInk2i4HvMtVZj2I3RKJjfV-yrDFKqBzHRkOL2hw_wA>
    <xme:Hb-lZETbaHRTWOH3v1L8OhCcfbFCw73TZYlOWwAxi1JqOLgV_WiFbltchd8K2H6o4
    HMviSKT2RYFToiizqo>
X-ME-Received: <xmr:Hb-lZCXMtNedN7MzsS3vI0cSr-IJWTW-6zPNP8JLhmI6rakqs4OsHaal2Nj8ItUKb9IXIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkedttddttdejnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepveettdeuleduveekgfeiudeftdeugfelfeffffek
    keetieevieeiieeiteetheevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:Hb-lZOiVY9RgKLMmyE2A7OpCpc4VsGyQ5qHYl1hkZu8zEkndtk_eig>
    <xmx:Hb-lZCAIOYXb7m2Bm0sVq_9OJE_8pFfisDiElyNY5awIRq_InDCv1Q>
    <xmx:Hb-lZPLR-7QHRWr8mYIXsvFa3N4kCGZI9Hk_gYh0PIeWfjoW7JA0kg>
    <xmx:Hr-lZDJF0gsLqhTv1tW3JIkhQ4p9I8LagjIDUMO7OEKdqIIQa8ZvBA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 15:06:05 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E54EE1095F9; Wed,  5 Jul 2023 22:06:01 +0300 (+03)
Date:   Wed, 5 Jul 2023 22:06:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Yu Ma <yu.ma@intel.com>, akpm@linux-foundation.org,
        tim.c.chen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        dan.j.williams@intel.com, shakeelb@google.com, pan.deng@intel.com,
        tianyou.li@intel.com, lipeng.zhu@intel.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH] mm/mmap: move vma operations to mm_struct out of the
 critical section of file mapping lock
Message-ID: <20230705190601.4atlxzh2wxc7zlu6@box.shutemov.name>
References: <20230606124939.93561-1-yu.ma@intel.com>
 <20230606192013.viiifjcgb6enyilx@revolver>
 <20230705165411.tfqqipcla7exkb7k@box.shutemov.name>
 <20230705173348.rxgzxge6ipb4hapy@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230705173348.rxgzxge6ipb4hapy@revolver>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 01:33:48PM -0400, Liam R. Howlett wrote:
> * Kirill A. Shutemov <kirill@shutemov.name> [230705 12:54]:
> > On Tue, Jun 06, 2023 at 03:20:13PM -0400, Liam R. Howlett wrote:
> > > * Yu Ma <yu.ma@intel.com> [230606 08:23]:
> > > > UnixBench/Execl represents a class of workload where bash scripts are
> > > > spawned frequently to do some short jobs. When running multiple parallel
> > > > tasks, hot osq_lock is observed from do_mmap and exit_mmap. Both of them
> > > > come from load_elf_binary through the call chain
> > > > "execl->do_execveat_common->bprm_execve->load_elf_binary". In do_mmap,it will
> > > > call mmap_region to create vma node, initialize it and insert it to vma
> > > > maintain structure in mm_struct and i_mmap tree of the mapping file, then
> > > > increase map_count to record the number of vma nodes used. The hot osq_lock
> > > > is to protect operations on file’s i_mmap tree. For the mm_struct member
> > > > change like vma insertion and map_count update, they do not affect i_mmap
> > > > tree. Move those operations out of the lock's critical section, to reduce
> > > > hold time on the lock.
> > > > 
> > > > With this change, on Intel Sapphire Rapids 112C/224T platform, based on
> > > > v6.0-rc6, the 160 parallel score improves by 12%. The patch has no
> > > > obvious performance gain on v6.4-rc4 due to regression of this benchmark
> > > > from this commit f1a7941243c102a44e8847e3b94ff4ff3ec56f25 (mm: convert 
> > > > mm's rss stats into percpu_counter).
> > > 
> > > I didn't think it was safe to insert a VMA into the VMA tree without
> > > holding this write lock?  We now have a window of time where a file
> > > mapping doesn't exist for a vma that's in the tree?  Is this always
> > > safe?  Does the locking order in mm/rmap.c need to change?
> > 
> > We hold mmap lock on write here, right?
> 
> Yes.
> 
> >Who can observe the VMA until the
> > lock is released?
> 
> With CONFIG_PER_VMA_LOCK we can have the VMA read under the rcu
> read lock for page faults from the tree.  I am not sure if the vma is
> initialized to avoid page fault issues - vma_start_write() should either
> be taken or initialise the vma as this is the case.

Right, with CONFIG_PER_VMA_LOCK the vma has to be unusable until it is
fully initialized, effectively providing the same guarantees as mmap write
lock. If it is not the case, it is CONFIG_PER_VMA_LOCK bug.

> There is also a possibility of a driver mapping a VMA and having entry
> points from other locations.  It isn't accessed through the tree though
> so I don't think this change will introduce new races?

Right.

> > It cannot be retrieved from the VMA tree as it requires at least read mmap
> > lock. And the VMA doesn't exist anywhere else.
> > 
> > I believe the change is safe.
> 
> I guess insert_vm_struct(), and vma_link() callers should be checked and
> updated accordingly?

Yep.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
