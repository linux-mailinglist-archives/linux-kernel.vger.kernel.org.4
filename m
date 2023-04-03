Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E586D41FD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjDCK1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjDCK1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:27:52 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9806512875
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:27:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E04B5C0109;
        Mon,  3 Apr 2023 06:27:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 Apr 2023 06:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680517624; x=
        1680604024; bh=lUUNllY8YalVB4WW6NDGWZcMU+uWScy5adnBQ8xJC98=; b=r
        P1I4DsnFNmzuQK4WQ8zXmWi5PKN0ZEYKSb+7g9V7zigwr4kX2b9rk3ZSVMgz1FC7
        m+JASbITUPx3dBhXawLdVsRZyQ/rbZ0ZcHBAv3tNNKyyQJlZCrmYfMxbKRSKMhfG
        XeIFFPDbnzKQRzW+6bNMp97TMDz6/wVeV4bafiC+Cy/ENo7hs+QGc3lYaXPQF0UW
        4M8vyvM3omx5YkpJ3A0Z4wrWmhCDN+Pdo1QdZcLEzmBXcKUw4SgPcPqtFuN4Apnj
        hJKNhivtdwhCAgFTneX+ADBBwo0Z2xpPMLIYTtZ4w2jZGYJ6nG4Elbp/HzSz7nOC
        DM/+fG30vLdN2BDjwGv/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680517624; x=1680604024; bh=lUUNllY8YalVB
        4WW6NDGWZcMU+uWScy5adnBQ8xJC98=; b=pbOs7yb1OMx9jALcWtp8nQ4OyTHiW
        75PHGIpI5ej4jOA9AMG3gxzrj2rsXxW4dDvm3lqMG2RwGZVmFyapuzNXIitSZsxI
        +bgeB3LZY1ZwMXNEYMY2QMeZzxTonbCBMj2vWCgVrqxLv8lAd4/rCx7VCbnM4J8z
        uoBMSWFJ6W7adX+XX61XcNusna2nOVWELIHyY7F5QvHbg+NUsG6z56tSmw0+/te4
        0VakuK2uPotVc5etgKBFAQtPJn7wCUAszzLXaqCVgBH6vU2qg3G0Vcn28YQOhiZK
        Q/VLpPO6n7knN0PxqOq2EAlscjptq2A4NFB5+VxMoh2GoF1ynmCjuH+Dw==
X-ME-Sender: <xms:-KkqZFcjJXg6n92cLqArTvuWM8eF2q-dF27C3FcThIJXY7o0LL5nBw>
    <xme:-KkqZDNSutP6uZ8jtQleJHWiRHMc9W74pKZAXdLkXBKhC2lyiFg2GwFWe6zEO01X5
    0djM6FKWif8rnppAXQ>
X-ME-Received: <xmr:-KkqZOgpk4Qq-ZeEWthJvUtq_oyU4uFyJ9fvfI3ctTmE61JgR39u8vr_8PlZZ5Gt31VfKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeekvddvjeffheetgedtvdfgieejiedvgeejieet
    jeehieehveffueekfeehffdvveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:-KkqZO-zEsF6nxD8PRYjCBYNOBv6sCxHlrenCIX7EQe5jllg_UCbvw>
    <xmx:-KkqZBsbN2HO9zBfzH0jpMdfyGl0vZHy9V_tfFjp6YTEqfUTvnDtcQ>
    <xmx:-KkqZNFom84VUCX67r3QBuprSHSRKx3Rq5z_BITREHqKhpyzG7rTQg>
    <xmx:-KkqZMlXDZTiYu3DtpfMBwGB5EG5xs1g-HSQAQQCNN1WJ5t53vEyew>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 06:27:03 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1678310D7B3; Mon,  3 Apr 2023 13:27:02 +0300 (+03)
Date:   Mon, 3 Apr 2023 13:27:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv16 11/17] x86/mm/iommu/sva: Make LAM and SVA mutually
 exclusive
Message-ID: <20230403102702.teplnhqhvxs4tn4o@box>
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
 <20230312112612.31869-12-kirill.shutemov@linux.intel.com>
 <CACT4Y+bnR=v0vUC_wTpd98Kpfd1KK--daPwjgnBL__r+wbHUkw@mail.gmail.com>
 <20230403094419.zl2ncsd4qyd35fex@box>
 <CACT4Y+Y8ANFPwGd+UALu63mLxWoiiXnp2Z5GXnFhg14DdJUc=A@mail.gmail.com>
 <20230403101707.satsniziz3tn2zyd@box>
 <CACT4Y+YfqSMsZArhh25TESmG-U4jO5Hjphz87wKSnTiaw2Wrfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YfqSMsZArhh25TESmG-U4jO5Hjphz87wKSnTiaw2Wrfw@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 12:22:01PM +0200, Dmitry Vyukov wrote:
> Then I misunderstood what it means. Ignore.
> 
> While we are here:
> 
>         if (mm_valid_pasid(mm) &&
>             !test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags))
>                 return -EINTR;
> 
> should be EINVAL?

Yes. My bad. Will fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
