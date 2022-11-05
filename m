Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007A061DDA5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiKETNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKETNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:13:30 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D28A1BD
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 12:13:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 477F35C009E;
        Sat,  5 Nov 2022 15:13:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 05 Nov 2022 15:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667675606; x=1667762006; bh=nf
        st00B3ar0fS6yyqnIszehJzeNqL8xbt2qu9HpZL+o=; b=Gz/ts10XdQhE6feVN6
        gBKQDWPR7PYYCj9NRPuk4M7uAjNGkdoU0ZBJlsACGNaVIA2XZ5J7NG9AIPmsdLF8
        Ye/6emYAD5wieC45FSGYXyOpZhnQYBv6bhHdNv6cKywDaVjgCvQInjTq8sEXfM/p
        yooXT0aofD70Sk1wjWRbJT6HmG/7Mk8pypzANIhNVLM9itCB40boBuZd9b3F37Cw
        t4CkcxfaZS00G+AbPwwdFOQXl0hza96BNtcuLuylWhfzh+OBda3lbdeq9/SrR2vT
        4vsIEsMa0ZJn31+UOFXabHBQrHEAbNigdBwry2ulreSsQ4drK/EYVnuSENZykDih
        EfOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667675606; x=1667762006; bh=nfst00B3ar0fS6yyqnIszehJzeNq
        L8xbt2qu9HpZL+o=; b=af8XiI9YOX23CCnxKxQsXeAvLiJqdz8DminAgnULd5iM
        W8m/DoLV9K/RSgk4OfuP9ILg4nC7wAy04CKbcQllNdret2uCchpbj10Ss5mZj32f
        JUAS8CDr0dvjlrfsLyjCw+1nIyCrNCrB2hQyv8VrKYgmcvyb0MWi9ytUKxEOj1v6
        Hkosyu35gIrM9Z78tXAcu2Z1/3XMITp6WKBG9EvMC4jbpJ0NY5VJuNK6hrN05Lul
        iGAvnW/fol0199qcUhuET5vwH6XrL2UuF5NtXiji8wiVD6A4GwOPq9FWlkRtqbvy
        c2AobcngU128DNoHhz1DID9VkbRsoc3bUZPaCcwQRA==
X-ME-Sender: <xms:1bVmYw4J6Yd5bHIrhDaPUFqj6ythJkw8iDIUdI8Cc8fWz6ZBYV6yXA>
    <xme:1bVmYx6LOQGtzrUrRKZZSwAB-SKPQSsMmQSgkOC4hdo9dFiIuXfjPuB34H4fXMTKm
    eB9qdP1Beui2hZyjgY>
X-ME-Received: <xmr:1bVmY_eHhXP-L-VRAq-EYfH6jZDAA48p7_GYGdFS3PnkRzgEh0MZUZUXj66f4kqG55PGww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepkedvvdejffehteegtddvgfeijeeivdegjeeiteej
    heeiheevffeukeefheffvdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:1bVmY1I6mvaNnisn-HB7xkdnCfubfV4j8oz6MuoZcwWSjPDe0MmiIA>
    <xmx:1bVmY0JF7KttCZrGACaDV0GLIU5hknNR9NlyJnupSILe4e7zhGf_kQ>
    <xmx:1bVmY2xlkQ-6qtUrrcum7OCcBdHB9jXuji463mMJVYX3DYA26izGiA>
    <xmx:1rVmY15v6gR2kH0mLx4gB7pYf4JLELRbTwKpHIinIp7RA7fdiTiLYg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Nov 2022 15:13:25 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D8FD9104449; Sat,  5 Nov 2022 22:13:21 +0300 (+03)
Date:   Sat, 5 Nov 2022 22:13:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 1/3] mm,hugetlb: use folio fields in second tail page
Message-ID: <20221105191321.572bdm67tulpva5k@box>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <3818cc9a-9999-d064-d778-9c94c5911e6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3818cc9a-9999-d064-d778-9c94c5911e6@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 06:48:45PM -0700, Hugh Dickins wrote:
> @@ -260,13 +267,16 @@ struct page {
>   *    to find how many references there are to this folio.
>   * @memcg_data: Memory Control Group data.
>   * @_flags_1: For large folios, additional page flags.
> - * @__head: Points to the folio.  Do not use.
> + * @_head_1: Points to the folio.  Do not use.
>   * @_folio_dtor: Which destructor to use for this folio.
>   * @_folio_order: Do not use directly, call folio_order().
>   * @_total_mapcount: Do not use directly, call folio_entire_mapcount().
>   * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
>   * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
> - * @_private_1: Do not use directly, call folio_get_private_1().

Looks like it misses

  + * @_flags_2: For large folios, additional page flags.
  + * @_head_2: Points to the folio.  Do not use.

to match the first tail page documentation.

Otherwise the patch looks good to me:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
