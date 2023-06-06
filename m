Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813A3723C54
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbjFFI5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbjFFI4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:56:49 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC18E7F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:56:30 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id DD8843200B43;
        Tue,  6 Jun 2023 04:56:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 06 Jun 2023 04:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1686041787; x=
        1686128187; bh=TDh4L+clH7e0D9NAM99reV6x/2Nq0Zi6BrkhSQ4xHfk=; b=S
        pA0yk8F2m2zq0kF4KAmGe8gRJFS+BcbdJuZJFZMe0j3cEZ2V1cOY60jngZrUsL4d
        T9xK0i2wm2olhnE2UFn/6I0hgbAPMWfJ8mapdZn1mmA9A7wOf6PEA6XgkrYNrAZu
        6+tnWMx3aV9zC16Z4v4tzW2TgbBmTgfw/b32oVfU1rBRycuJKYwLfNOY+gkJCFM2
        nqs67tpDMnOw23UjslYho+R4G1tlyRd4f5Vh2W8bCoh9bsgtmB56SNaQB0SzbY6M
        ZnWOXqGFcAZX2FElUf7HzgMcuai7oKLsBK7IiobKB8wMl1wxBG9tDoZFj5eUrLVW
        8BHnfNAuFnQFHSx4UszAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686041787; x=1686128187; bh=TDh4L+clH7e0D
        9NAM99reV6x/2Nq0Zi6BrkhSQ4xHfk=; b=h3RhbhhRU4lNnrhHBgmq9mc42j+zo
        fWegk8Los5wuzoRprEekNolS29X+hlvMtuAUewIkaRsTYgdnQErOxuCLljAbnRm6
        kyNCmagmvLTWkLkipNCGwFvDX/gTVN4X57U7CX4hKkpC8ID0iXwKk9Ld8GrL3z58
        /c8Oa7b7GbiQPU1EaGodY4kkCueFna4eu0NbAHb3dHIS2EXx6TV6td/5PqG4373U
        2wxOcOBQ0OYkBX8G4UVmqcW9TRkipv7MY6gVU740S1LirK2LZkVobcWO2UvN1L8Z
        /5IGDjE7ub5WeGUF4WR+6A0DBeDnwuVxJ3rHaNLF+aDwVKZIthPqb1jzg==
X-ME-Sender: <xms:uvR-ZIiRKSYUSRwrqzQfDsi1z__xP21t3Ein96M2DdNzyhO8sVHSqw>
    <xme:uvR-ZBBDyfmXztpvsJ_22b5sj05iFbL58du3tFvhvl49YxcOJcpuWO2plbrZ6cvPR
    V4W583mUhKpTpHrNl4>
X-ME-Received: <xmr:uvR-ZAFGEtd4R-9yUWehkgykt__swKnnOiyOpd3ibA0aCglTh3IQnVMnHLLkcRgKurfTjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:u_R-ZJQgfKlTEYlOY0R18rLDf2BoPmpfDle2UBUMpVKSTADlXOw3qg>
    <xmx:u_R-ZFyb0kuPUZFz_8vKbDcjqDbMseV97eOf5-JvLCZiN1dZ3VcKUA>
    <xmx:u_R-ZH5q9wFtFM5xmXCBQ0ULPCzjSd08TSJIb9vmRdAkEt6tBNi8pA>
    <xmx:u_R-ZHulmmPZB_BUJ4lHAbspqV1ZSYkvAYrC1tLMAnNr7OP6QuCzlQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 04:56:26 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DDA1110A637; Tue,  6 Jun 2023 11:56:23 +0300 (+03)
Date:   Tue, 6 Jun 2023 11:56:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kai Huang <kai.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: Re: [PATCH] x86/tdx: Explicitly include <linux/errno.h> in
 <asm/tdx.h>
Message-ID: <20230606085623.ljkzrxcmbzhvs32p@box.shutemov.name>
References: <20230606034000.380270-1-kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606034000.380270-1-kai.huang@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 03:40:00PM +1200, Kai Huang wrote:
> Currently, in <asm/tdx.h> tdx_kvm_hypercall() simply returns -ENODEV
> when TDX guest isn't enabled in the Kconfig w/o having <linux/errno.h>
> header explicitly included.  Although the current code doesn't have
> build error, in general it is a good practice to explicitly include the
> header to make sure any future patch which uses <asm/tdx.h> won't get
> build error due to error code not being defined.
> 
> Fixes: cfb8ec7a31f2 ("x86/tdx: Wire up KVM hypercalls")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
