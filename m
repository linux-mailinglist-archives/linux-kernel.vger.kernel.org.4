Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9974898C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjGEQyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGEQyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:54:22 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99FF10EA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 09:54:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C47353200917;
        Wed,  5 Jul 2023 12:54:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Jul 2023 12:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1688576055; x=1688662455; bh=bIBEWDOiL4fJXFNl0WDMqCyWtIZ42p2EH7N
        I3yU2aBM=; b=I1GlFKAQoX/Q/3dm7T/b496ijYJbseYeoZ49H8KuWPm3ciwd6iS
        rskoU9ZyKKIOwoG4ctMy/qOwE559yPN3ENEQ4QCN5sLg6Hec67G8kar73Hk2mJHm
        pMxFEpWbRzhTMbde09mkC7CY7lo8SZ9rdk9gfhiU48YjpL/WW/Q+yz/rBhJBY70E
        4mRJ8emWdEUZ8nK7gScZ4WgjjJI6wEmwgqnSbKOsmXW/dhhCF9tjN6EPjfYL9ytx
        Iqev5Qv0zWP103zVlDPZ11mNnv/Q5eZWNuUrLxj6hq47WevzK2aSNIaoIcJjCCfL
        VejQhdbYFDFxKli+hRjhP6QCJVE2z27EKNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688576055; x=
        1688662455; bh=bIBEWDOiL4fJXFNl0WDMqCyWtIZ42p2EH7NI3yU2aBM=; b=N
        MS+RVBjZFD3K9G2MKlYq1XzGdgJkQQEMpViM/E5D+4wF6JLhYxOX0cH2DgVf5Jy/
        5Zg78yDTBiKUeR+7kboFcG3F+YmNZiWlgoViRWKDFF9ov2cOJdu02X42Vfe6tuH6
        v3msXnD5LL0gijpkuqVSygFwujnYXmcl79kI8zxfFtLMfFm4Ajmq1UuAy2KqOQAs
        Av0jVVopyIYe3o2JgtTrr3NNv+KIz7k50sknFuhjPSEHQMGQ7r9aAurIMQUtXEUs
        GU2NE5mcU2o+YtyWuGkHIsvER2zQReWqqkuAeO5RRgbdfnd1VHQvCPvULGC8CaBt
        mzC/pAEG0SUqrzhQwhwtg==
X-ME-Sender: <xms:NqClZPtuwUJAiX4EfxD0FxVMMhENtsaRQEfIa_YkZ7NOjo1PXALnXQ>
    <xme:NqClZAffa3f5M4wKywBGylFaBzez-0DlJtJEY8tysel4344ry9cfzBqoKJheHs491
    kfH40pDkEMwvCg33ww>
X-ME-Received: <xmr:NqClZCyYImc1bK8GAGOxySe2h8Sa6602I6jLr9hfhbTioBVKS2Sm66Ekzjhc35cTFF7LjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkedttddttdejnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepveettdeuleduveekgfeiudeftdeugfelfeffffek
    keetieevieeiieeiteetheevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:NqClZOO-5bPHObNAUykF7dhe61pLdbszxoQm-mEbThjH_zhCAThbHw>
    <xmx:NqClZP_82REIV6A97lvSBY9PqR-0pYDjmCz83EIWrrJoAZcNqEDF_g>
    <xmx:NqClZOVuGFF3Fhp8Zji3eSe_sQr6qPe0AWeHsaBu9JPmJaCjlxfmkQ>
    <xmx:N6ClZOUEbCb-Vf_Bsm7fuayXJoSukw6Ef-NwmqvofzkMaZjT33bLqQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 12:54:14 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 67E251095F9; Wed,  5 Jul 2023 19:54:11 +0300 (+03)
Date:   Wed, 5 Jul 2023 19:54:11 +0300
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
Message-ID: <20230705165411.tfqqipcla7exkb7k@box.shutemov.name>
References: <20230606124939.93561-1-yu.ma@intel.com>
 <20230606192013.viiifjcgb6enyilx@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230606192013.viiifjcgb6enyilx@revolver>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 03:20:13PM -0400, Liam R. Howlett wrote:
> * Yu Ma <yu.ma@intel.com> [230606 08:23]:
> > UnixBench/Execl represents a class of workload where bash scripts are
> > spawned frequently to do some short jobs. When running multiple parallel
> > tasks, hot osq_lock is observed from do_mmap and exit_mmap. Both of them
> > come from load_elf_binary through the call chain
> > "execl->do_execveat_common->bprm_execve->load_elf_binary". In do_mmap,it will
> > call mmap_region to create vma node, initialize it and insert it to vma
> > maintain structure in mm_struct and i_mmap tree of the mapping file, then
> > increase map_count to record the number of vma nodes used. The hot osq_lock
> > is to protect operations on file’s i_mmap tree. For the mm_struct member
> > change like vma insertion and map_count update, they do not affect i_mmap
> > tree. Move those operations out of the lock's critical section, to reduce
> > hold time on the lock.
> > 
> > With this change, on Intel Sapphire Rapids 112C/224T platform, based on
> > v6.0-rc6, the 160 parallel score improves by 12%. The patch has no
> > obvious performance gain on v6.4-rc4 due to regression of this benchmark
> > from this commit f1a7941243c102a44e8847e3b94ff4ff3ec56f25 (mm: convert 
> > mm's rss stats into percpu_counter).
> 
> I didn't think it was safe to insert a VMA into the VMA tree without
> holding this write lock?  We now have a window of time where a file
> mapping doesn't exist for a vma that's in the tree?  Is this always
> safe?  Does the locking order in mm/rmap.c need to change?

We hold mmap lock on write here, right? Who can observe the VMA until the
lock is released?

It cannot be retrieved from the VMA tree as it requires at least read mmap
lock. And the VMA doesn't exist anywhere else.

I believe the change is safe.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
