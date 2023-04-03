Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99646D4103
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjDCJpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjDCJpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:45:11 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4E8113D1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:44:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A81A65C0158;
        Mon,  3 Apr 2023 05:44:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 03 Apr 2023 05:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680515063; x=
        1680601463; bh=2pcfFIJgR5HmBPHP1v+3gt9ctXXHOFIL+EutshVs9fg=; b=W
        +3Oj32TsZ2HMHjTi2MPIXNX1TRSAG87+b3XedOPC0NX3IxGAhrO1g3ZUbIkOlTM/
        eeAOBkOz7Y/WQ0hEljKi2wULs18jUxl75nHL6iPHIL6mxwE9pTWtLmOh4DrEs0Ej
        JcowUSrUYxlWtI23iEH0BFEPBtsefcpbJsm7ZEC3tdG/5cRFIGbSKyCKFhHeBLRw
        8jks8bGQrIXWlOP1VizwkFKDeT69SW+NRyoamZE/G50/LeKChndo1gkOcks3n+Q+
        X5MAhCEXNLXsrrgoEtmDd5RaeTSoD16I42NpEUWuyPokor6EoiXlwNIY/vITQHan
        V0uJ26+r9EFudbhxJiulg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680515063; x=1680601463; bh=2pcfFIJgR5HmB
        PHP1v+3gt9ctXXHOFIL+EutshVs9fg=; b=XUmijHB1aMmu3mAcL+QsIFrIp57mR
        X/0U4XHdR5ZzNLx4NAOiOZ/gMiDZRMMPC63Loxu6TGlcdPatM4jG+bUumC1C19cb
        DcmfYn3ZwBxHGo7Ybgp+qL94LUpPzzycz9ZqObqFJDN3D8lbQxOcSsrI1yaAFSJo
        CyGjOF9njKvZ5EkfiVbOO8KqHXUxF35Boh0y+ZKtnBCf4baPO1tSF6YdBVpw2ZjF
        6gRmqecmynfhfng5vGBPaS7v3iZ8yaqHs9abShZMt5+G0om/bYv4GmtVi/2ESxPk
        ziy9w08fFihiwtB42PP0xd0T+4M2CVuFT9x8lLnUfxP3sBn5ah3mzz9mw==
X-ME-Sender: <xms:958qZKo0tesXsfPY5F-kWCFezs8IKKjGu0i16uDKVWEcyOFB0ygR7g>
    <xme:958qZIpEJmrFJvFHazFDGHxfTKQ6wbzMQhysLugnva5OeVGame2HWTU9GaBMZHCtG
    -DIb_JwR-hyRBQR7Xs>
X-ME-Received: <xmr:958qZPOCd2ZDHCpkXOw59pTyWs0LqOe991ovtwNiz5GDZylhN1fnJpKVeHr98skxsFBPug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeeuveelveevleeggeevudefheeifeegvdejteel
    jeejtdfgfefgvdeiheeuvdeikeenucffohhmrghinhepphgrshhiugdrhhhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehs
    hhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:958qZJ5_cLde_ZT4E8HqMmazYm0Z0vSI3PmhFyUhsFpAuFr477klsA>
    <xmx:958qZJ4OehPCLcndBwQop3C2X9BTzZQTKO-paVPrzB-keMe3fwWD6Q>
    <xmx:958qZJjJqPI9DetB-RJT1YNMGLFhe5DwtugGjju4sBQzBLe0_TSxbA>
    <xmx:958qZGwX6oo1ZMIWKxpOYm9QfhzoJwGv41XYB892WWHRABgIyG2Xvg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 05:44:22 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 43B4610D7B3; Mon,  3 Apr 2023 12:44:19 +0300 (+03)
Date:   Mon, 3 Apr 2023 12:44:19 +0300
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
Message-ID: <20230403094419.zl2ncsd4qyd35fex@box>
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
 <20230312112612.31869-12-kirill.shutemov@linux.intel.com>
 <CACT4Y+bnR=v0vUC_wTpd98Kpfd1KK--daPwjgnBL__r+wbHUkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bnR=v0vUC_wTpd98Kpfd1KK--daPwjgnBL__r+wbHUkw@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 08:18:57AM +0200, Dmitry Vyukov wrote:
> Hi Kirill,
> 
> ARCH_ENABLE_TAGGED_ADDR checks that task->mm == current->mm,
> shouldn't ARCH_FORCE_TAGGED_SVA check that as well?

Do you a particular race in mind? I cannot think of anything right away.

I guess we can add the check for consistency. But if there's a bug it is a
different story.

> Also it looks like currently to enable both LAM and SVA.
> LAM enabling checks for SVA, but SVA doesn't and both are not mutually
> exclusive.

For LAM we check SVM with mm_valid_pasid() && !test_bit() in
prctl_enable_tagged_addr().

For SVM we check for LAM with !mm_lam_cr3_mask() || test_bit() in
arch_pgtable_dma_compat() which called from iommu_sva_alloc_pasid().

Hm?


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
