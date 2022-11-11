Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6382A625D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiKKOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiKKOuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:50:16 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2DC26106
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:50:14 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E827C5C0156;
        Fri, 11 Nov 2022 09:50:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 11 Nov 2022 09:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668178211; x=1668264611; bh=sl
        toumMgbd2Y0dgw40UCIpr6gt4ZyAxTL8p2m2/tu4s=; b=Jo8ot5ZV+wng2sLJ/B
        pxEVfMTI2h99BmdiQQPzh78GZd4NAWzS+WFi/sdiC8gJNyiYLk/qyYamnaXuUP14
        Fu9sYjwXRx573/gdS2ZDap6HLt0K7I0jo8dWVZE8CtIsQo+h94sLNcNL3UkV48Sp
        SdOO20v7M+yUZPZcXIMdyqCPZtsi3GtU+5U1nDitfo76kVL0Rj5WvFXsQA1pF7mh
        sO0fkp+siKBLS2P6edsvLlpxV6k6l3UAqKg0lhvAKxB0Xz+5i/4yZcCrCDkN1hDF
        SUAW/8T6d+6QsvgTHNcYasM3D57CAC+BIdCXs6uqP4wb5uPDMzYSjGhvMx3QbljN
        RMxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668178211; x=1668264611; bh=sltoumMgbd2Y0dgw40UCIpr6gt4Z
        yAxTL8p2m2/tu4s=; b=O2aS6Vy4GpeAx0DEdlCisSzuq+rkD3pfBaPBW+/c+MKf
        Jnj8kF4SABBoW3E1Vlcnn2nfYGJcfDQ8Z8tZyoFmPRG+MBE94IQ6BEqHJ3ue4Bkg
        sFZW1em1jY9F1g4Bqq5Bdi1MF48xyuJ9CSd58VFPW6lq5GwJZQdJxPIq2OtC6MLQ
        KpT+GpHtC/5hIHK6jiCGATmm3KIPD3DxWBtlRNOe/4yxeVY0mzH9EhOmehPrE7tD
        e6soMtjgayt96Fy2Y2V874iOvAL4PncKUWIs2fZ0DYzVNjzmkaNPxZ3wTzu14pHv
        3BZgiveGSqQEaZwYSYa7MbK3t5LZummJ/D/0X9SC2A==
X-ME-Sender: <xms:I2FuYy3bmFY_ZSmK_sQcvNE5bnJ8WNpMnbwSEGsG82znF1PnZ9-Hyw>
    <xme:I2FuY1HccY9jOxtPrtK-G2xkq5rf-GEQC13Up_h4Uo6PX1zIf6McKSJd9ERJLm-uE
    b4935YKsZGxQBqHlzY>
X-ME-Received: <xmr:I2FuY67sd68NK6xCYvmFHNvSxW9RvSsiC3-qAo8io-mOI9BsB01mlklXLjQJ6ttE9SOU4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeigdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:I2FuYz2G_81rkkbGkQPymqMxLFeKlhA4MeBxr992LXU9su4tRr4lRg>
    <xmx:I2FuY1G65iqm7dj6yP9dzjPsnScFNJUT9PVMNbpwJyYrdQ6ovNx_Aw>
    <xmx:I2FuY8-2NBEC5ZWUfe8H5-jchysjSwKfgJB6vRoXyHJ9ESpugq-oGQ>
    <xmx:I2FuYwmTajT02N2XUvRKjG8Bct7IXmNMAI0vyXNrdLYIEG5DGPLpyQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Nov 2022 09:50:11 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 187A11094F9; Fri, 11 Nov 2022 17:50:08 +0300 (+03)
Date:   Fri, 11 Nov 2022 17:50:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCHv12 09/16] mm: Expose untagging mask in /proc/$PID/status
Message-ID: <20221111145008.cbll6av2cxnqd6hb@box.shutemov.name>
References: <20221109165140.9137-1-kirill.shutemov@linux.intel.com>
 <20221109165140.9137-10-kirill.shutemov@linux.intel.com>
 <Y24c8WpfTWVWAC4F@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y24c8WpfTWVWAC4F@arm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 09:59:13AM +0000, Catalin Marinas wrote:
> On Wed, Nov 09, 2022 at 07:51:33PM +0300, Kirill A. Shutemov wrote:
> > Add a line in /proc/$PID/status to report untag_mask. It can be
> > used to find out LAM status of the process from the outside. It is
> > useful for debuggers.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> 
> I though I acked v11. Here it is again, for arm64:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Sorry, my bad. Dave has already noticed that and will add it on apply.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
