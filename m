Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E1368719D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBAXJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBAXJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:09:50 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D1B69B1A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 15:09:49 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0E2A35C0175;
        Wed,  1 Feb 2023 18:09:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 01 Feb 2023 18:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1675292987; x=1675379387; bh=/s
        KWUZMDVI94wHC4x6lwKTIhggnPQvFEE4dYpx4w/HQ=; b=b8RQRP5np+jz807OEH
        DHu5YAt8x5RYyinq+y6LBzpG+nKRIv5T4jAUEVBjj63BRWQTin+AgUziBUC6h8Km
        1rWdX7O6llZS36L1j9SuWElnwRgVJp0nSNkBTwMDjRtLcpHBDEw71NkeIQSJ32H+
        BQyWCFmS3jKKY8IuqkHy8BEFbNmIQ+nP0wGRJj9sWGgsTYcJRr11oF8t0R9/3yD5
        WL1tbISA4nRY4XDi7wgDA/HDSyITwL2uv5I2bomGW2qJJtlDRBv+YJKBnrg/404t
        gYpXHkh3dOzVJSvlB3VyZAjvXA//OPg0Eei9+D7FJS9Daas+XbqSg1QOq2dS7JYu
        C+tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675292987; x=1675379387; bh=/sKWUZMDVI94wHC4x6lwKTIhggnP
        QvFEE4dYpx4w/HQ=; b=pHh0WxDyyzBT7DrH1FApGkT/BM8H2burTrCSRagoYQ4j
        c1Htpdd/KaA9cLzbDKs6RHp29vS3F3oYfOglCxQloyIl3p/SX/L7Otpc6SxVFzhp
        rKFhZsIS66xVWUhlxew1rJdDrLBV1JMpcOYpb6hMTXPlaGu8yD1VvQGy0fhWk9d4
        4Vffq68kxAgvxgXFjsILifo8SB43u1aq0uJJL75xQeBTCWYbIjppu1/rT8UOuRVF
        tKdAGvLEHfQh1hb8eUxQod1gj2ZHrZf8xYgymp6ngROOAdCpKa+7wZjP1pcdff22
        MHsFDBYeX1aLK8f3v2BwAG+OiUPZ7GBOzUSRiKZ7yA==
X-ME-Sender: <xms:OvHaY8sLpoaub0iiwG3dAupsYiCxw0bIJAbk8S9wtjM7-0zweewVdA>
    <xme:OvHaY5eDZbQcz2Da5CwPrFMJauBofsbRk2iNcOvutQ3eo0lo45F3zgt085GrBNQ7j
    ip-y37zBHnbOfXE9Lw>
X-ME-Received: <xmr:OvHaY3wJBzySt0KANEFSXGQJ0a1zgBUhfKbqS2Ph0UlzPUVD1jdtoqFz19s367krZnkxXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefjedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:OvHaY_Pdt2ypsvT9E2IXo7t9F0yjCjRidqixBWGD2b0L4mB3eOyZSQ>
    <xmx:OvHaY8-W-Q3G-4yAB3879lOaGur7X9wCs6A2K3qrtKxuXgLzEduNFg>
    <xmx:OvHaY3XMfTrCpG7wRlr1ZbtITYvDI2hLmA8eIMwdBF2iG-W-fCrN5w>
    <xmx:O_HaY-IOjeuSjRgdO-JdPP3tumXGSADbRHcJb_M-sKDQsjQ0jXdfFw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Feb 2023 18:09:46 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0691410E381; Thu,  2 Feb 2023 02:09:44 +0300 (+03)
Date:   Thu, 2 Feb 2023 02:09:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: skip shmem with armed userfaultfd
Message-ID: <20230201230943.fg2q6fmvu7gggxar@box.shutemov.name>
References: <20230201034137.2463113-1-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201034137.2463113-1-stevensd@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 12:41:37PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Collapsing memory in a vma that has an armed userfaultfd results in
> zero-filling any missing pages, which breaks user-space paging for those
> filled pages. Avoid khugepage bypassing userfaultfd by not collapsing
> pages in shmem reached via scanning a vma with an armed userfaultfd if
> doing so would zero-fill any pages.

Could you elaborate on the failure? Will zero-filling the page prevent
userfaultfd from catching future access?

A test-case would help a lot.

And what prevents the same pages be filled (with zeros or otherwise) via
write(2) bypassing VMA checks? I cannot immediately see it.

BTW, there's already a check that prevent establishing PMD in the place if
VM_UFFD_WP is set.

Maybe just an update of the check in retract_page_tables() from
userfaultfd_wp() to userfaultfd_armed() would be enough?

I have very limited understanding of userfaultfd(). Sorry in advance for
stupid questions.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
