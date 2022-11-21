Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72C463235E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiKUNYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiKUNYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:24:11 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334C94090C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:24:10 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0E14C3200958;
        Mon, 21 Nov 2022 08:24:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 21 Nov 2022 08:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669037047; x=1669123447; bh=go
        HhriPmNqgVzqWoz0ND7EocwpjpXPEn5qxwNPjIXSg=; b=Id1m2sP4DMPbLCTncm
        2FtRqFLhncK04RL7vHhLHUwPqhkpUPItoejM0umsr7X6VvDOXM4zhimx4K3hbmGB
        eXxCXh2cnsreGKUrhB19peUvFjMSFHSNk1lYOxxI0OPXdnwPK6RK+JW0s07MDa7g
        bk+E9Wkl6Ic+FhAFtKod7hgxIMOjVwaAsmvNtX0GopeR17i6KNQ17C45Qbap/7V0
        VeHlrRBXwYcHogCsr+lcmtdRiEJMjV1031cAE2szuAVmAeUDk31S/Z6J9lyKDgSU
        eKRVpgG0gWjsy+HRQeJ2HeG565DKCNcKcVpdn0q9y2hTlZE4bol40ScjkilDc4AW
        vfDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669037047; x=1669123447; bh=goHhriPmNqgVzqWoz0ND7Eocwpjp
        XPEn5qxwNPjIXSg=; b=Z9WLe9WiuyUTaxQldSvu7z0FfOcGZYwQWTEKk1WtzLHQ
        cgNRE6B2lXpobH1L8Wl8yh+vrwwXBezQ1AvRziFWv7QbaqGYHdp2bIV+ZAOKpC7B
        OGXorQFThUNc0+ZhOQQ23z3CHB8JAzaRy0CYr5egt9nzFMd4DU9pAQJWNV3xmEgJ
        1D5BUvWLUzia4vTr3f1NV8PfFp+SoXTT7IcIHfqygEcdwNs1klewXEE6nmZlwuVZ
        QtM+h7CxS8QfFmtw99Q1+nuI3jhn1KzvuLlAUjN6Fad9FGJzu/zxS6TKvxCg6SiP
        h6VDoTtyH9X0J8H0i5P8k4jf9WRpbTFHe4V9ojjWyg==
X-ME-Sender: <xms:9nt7Y3E9Dpx0uyKUz_pHce5HlCC5Ce3sYqpTvnjoHOIGNHIiBxr1Ow>
    <xme:9nt7Y0XLZSdMUo1l3S4sXJIshWrwUyktTwzwUuh3oDbOTmGfAmVkbSRqh-mXcw-A0
    G71gHw-R_eftE4JSIQ>
X-ME-Received: <xmr:9nt7Y5Li82vnKOz8xHbj1kunXhBKh17b4FmqqQJbMJ65SuEt3oE31zWW2HI1qOh-Dj_amA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheeigdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:9nt7Y1EQ4tPhawoczBBqSOjggdBoQDyJoAaLRYGBzDZ8DFH6TZe7qg>
    <xmx:9nt7Y9V82dYxB2ohDaWIDwH8n3brkh6rk6geZ4EUND7qyz0z6Qy29A>
    <xmx:9nt7YwMhBCxmM7bAD8UhRIm8iSEeBmedIB7hLZdLSlJTb8sjwFgyVg>
    <xmx:93t7Y0Mp3q4Wh0wG-tw2BrQGzK0YiKs3k67vpGzMEl5VPy7Q3RFLCQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Nov 2022 08:24:06 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CD83F109A30; Mon, 21 Nov 2022 16:24:04 +0300 (+03)
Date:   Mon, 21 Nov 2022 16:24:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm,thp,rmap: clean up the end of
 __split_huge_pmd_locked()
Message-ID: <20221121132404.sebpecbc5joto7h7@box.shutemov.name>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
 <2f4afe60-40d2-706c-af21-914fbbbd164@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4afe60-40d2-706c-af21-914fbbbd164@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 01:16:20AM -0800, Hugh Dickins wrote:
> It's hard to add a page_add_anon_rmap() into __split_huge_pmd_locked()'s
> HPAGE_PMD_NR set_pte_at() loop, without wincing at the "freeze" case's
> HPAGE_PMD_NR page_remove_rmap() loop below it.
> 
> It's just a mistake to add rmaps in the "freeze" (insert migration entries
> prior to splitting huge page) case: the pmd_migration case already avoids
> doing that, so just follow its lead.  page_add_ref() versus put_page()
> likewise.  But why is one more put_page() needed in the "freeze" case?
> Because it's removing the pmd rmap, already removed when pmd_migration
> (and freeze and pmd_migration are mutually exclusive cases).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
