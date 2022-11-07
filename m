Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8D61FAE9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiKGRO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKGRO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:14:26 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93D13F28
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:14:25 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A9A985C01CE;
        Mon,  7 Nov 2022 12:14:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 07 Nov 2022 12:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667841263; x=1667927663; bh=Dm
        yUXNZ+fiVM/sdn2N2qusiIy/T/bjR57f0aptB5wzY=; b=dofw4hdBQYT/oaVaV+
        mFQR7GiWpyb7KjE4AoeN1GQr14+srrdklWpZ1lP1ZV7tCnbopYv02d+CfUj7Vkkg
        mlkdHpx6bMC+t2ffOs3mJYk9E4NhE35fPwgfGhDy7xtsgjw5OhGqVvViWOaytp6+
        syae99VdGonliJNkfljWiWTPCnnbDwLpoLyA3CZE3nPpCyJimLC8QjyGUa79jt4B
        XP1QFQPqAu03moh/QGehDg2ROFIBPsoOAbX9D4sfVXDSgc9Kdy7elVZwU33cPLIQ
        axP5T5Xztn4gjHcalwXYbbrs1uiexVMARIfz0Zg8vWSbqCzATFqHRNfYJuaWnefn
        x5zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667841263; x=1667927663; bh=DmyUXNZ+fiVM/sdn2N2qusiIy/T/
        bjR57f0aptB5wzY=; b=atcQUgLybH0wFkJud2+BfAwPf6dqd3EYt3LEjCpvF8Kg
        n0TD/H+l5C9RexVIBbUZdBwXiFL+HfuHrNl7VqLNYrjM6XAqoHdnOR8Vl7dwwCjc
        DBp0b0/ix9TJcsM/mdSGLm/YUmLKIG+qU/Va+qLlp2MwJ19i1lTdYNbtp16gghTC
        rG+mc5u55pAkvWrDBqbacnY8k2xv12uMYQxKpRHgI0uKvCTnV3DFMZoua8LhqVo9
        tbTgFS2eurWQvcRa7SOG/gfOnPauW7M7/q4hl7OZp6T/W/BnaubWxm5DumnY3zMH
        8N98tLTsF8MY++74BbjWhgzU12tDZ7668x3+bDTB8g==
X-ME-Sender: <xms:7zxpY7hOZKxqTm6H9FtnVXujINnorc3z-4l-faNi3GLzoPIJ9rdi_A>
    <xme:7zxpY4DwBO_86nSHxbFYjVkYT6eRN2o1nt8Iv8uNjsMtRdxsWqg9YQ-E7xqy6e7JC
    d2U6kQm47t1piPOXqk>
X-ME-Received: <xmr:7zxpY7G-jeL9abgkXXSN_M7eHeYoyBCYAueaBN4SA93kGq-sRLNTUgE8KdbwbnOv-9qa0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:7zxpY4SjvF2Owg2rLO9u8YUiL_nKD8tEOtfFtQXAegv645kHPt70yQ>
    <xmx:7zxpY4z7LdZjdiOT9kI6ay453UI3S049JOybADrEn1mkn4RpkPjY9A>
    <xmx:7zxpY-5-ik_NYHN51pjBsVVClVfwM5PCjBwUVVZ9-Wi220C_-r7N0w>
    <xmx:7zxpY8nKO5jSczDoThkXBlLCWBOi-cQ-gh9LwhDoK0T7KYo4zbj0qw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 12:14:22 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B757010964A; Mon,  7 Nov 2022 20:14:19 +0300 (+03)
Date:   Mon, 7 Nov 2022 20:14:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv11 04/16] x86/mm: Handle LAM on context switch
Message-ID: <20221107171419.k33qd4rz3tyfrovs@box.shutemov.name>
References: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
 <20221025001722.17466-5-kirill.shutemov@linux.intel.com>
 <b38f15de-436e-489c-b8db-9beff4466748@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b38f15de-436e-489c-b8db-9beff4466748@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 06:58:59AM -0800, Andy Lutomirski wrote:
> > @@ -554,6 +561,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
> >   	if (real_prev == next) {
> >   		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
> >   			   next->context.ctx_id);
> > +		VM_WARN_ON(prev_lam != new_lam);
> 
> What prevents this warning from firing if a remote cpu does
> prctl_enable_tagged_addr() and this cpu hits this code path before getting
> the LAM-enabling IPI?  Conceptually this would be like if we asserted that
> LDTR matched the mm_context's ldt setting in this code path.
> 
> I think (haven't really verified) that you can fix this by removing the
> warning and adding a comment explaining that CR3 can be out of sync due to a
> race against changes to LAM settings.  I don't think there's any way to
> eliminate the race -- there is no lock you can take while changing lam that
> prevents a remote CPU from switching mm or scheduling.

Something like this?

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d6c9c15d2ad2..c6cac1a1bc64 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -561,7 +561,15 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	if (real_prev == next) {
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
-		VM_WARN_ON(prev_lam != new_lam);
+
+		/*
+		 * 'prev_lam' does not necessary match 'new_lam' here. In case
+		 * of race with LAM enabling, the updated 'lam_cr3_mask' can be
+		 * been before LAM-enabling IPI kicks in.
+		 *
+		 * The race is harmless: it is okay to update CR3 with new LAM
+		 * mode. The IPI will rewrite CR3 shortly.
+		 */
 
 		/*
 		 * Even in lazy TLB mode, the CPU should stay set in the
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
