Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE3967CE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjAZOmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAZOml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:42:41 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7978C65EDA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:42:12 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 96DF8320076F;
        Thu, 26 Jan 2023 09:42:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 09:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674744130; x=1674830530; bh=aq
        Er9M3IhLFsWX8M1o8hgQ8n4fY5RMhug8h/ILJQTL4=; b=byyiq2qW/PGCxbIjYG
        6NQTsIrqzijB0Lvbu4hUKYLVDmv8ZIsgDr766LDqZFHljg5saQjsVGX7N9BNo/Sz
        EAJ8C4fBzixyacVWcuNjqwyJzR1KKDkKvCfA6yDN1EfbKsr1SF1LIzuPwY8m+QtG
        tkV7Wf5ExvA+L8kSpZ+UsWOq+Xq2g177P5FXtsidzyg0VzJL8omVzwQ0mC8Xos2H
        x7UJGekQd6sn4NYO9R/yLnUJ+9O33SnYEPHLb6erjaJ5wcoqvHfOXSzOmg2RbgkI
        nQmi4c/OKKvZK6l/7OjOH5tfGLpvhqVqY0USdrrO9+FRb3kyGnbnFm0PxbeQAn7U
        Mi2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674744130; x=1674830530; bh=aqEr9M3IhLFsWX8M1o8hgQ8n4fY5
        RMhug8h/ILJQTL4=; b=dBjrtJ/5cD7JXRFAiULUbjuu4FXgNeV0cpK99UQdazyG
        KK73tci4xN7YOIAe+aw00eawWnOlaiuF5lGIFWz1C3EkmBSc5+TFrI2vQF/7JF6I
        BKI1bbFSrW3OBMqW7/93I4VlvIREP4P8/INYKYp+MXBqHBFvHFBuG/OHTB6mWZRp
        xYJ/jTnPUAsAg09S0+Co7Bd55XpzAE21W8XoYPHzIJMtSi0OwSCIuUxWy2kfNJu4
        y3cwodtzVFaMcY82lec7s01Nouel04ksW/+T6mgrhnA/hwWpeZhzJxwoBiHPHSD2
        4jhibCajL7/NmA+fYigRsmLcLKlUkrDYOKM8RxsKyw==
X-ME-Sender: <xms:QpHSY7nEZY0CbTdYWnVBwQhwKYNxJEKk-1lI4qjuuY3UBbmQfeP3Dw>
    <xme:QpHSY-0UlbOBTZhOSmZRw6rDmFuvBtwvDRp4E2r9qPT8P5PQpNrtp4aG0alwjFngz
    pA74rplEhQ82Wds-wM>
X-ME-Received: <xmr:QpHSYxovIy_zL1gGtRvmgQLS-eN4tI4eRpVM5nFHh3em_Nm_1sxrHVYsgp2Rg4cCcqYCTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:QpHSYznWJ-t7CreBGWHIodWS8tSePQFgmsQhfyzvykFwmZDXL0ykVA>
    <xmx:QpHSY50wPRH4qV0WSdPVMOg5drvaE9OndWlB1cCi9TyofoFNhK5O0Q>
    <xmx:QpHSYytdXcjCp4IyAKiXm1ZHOJGuuBXhYrradK7N-YtBaeXMAgt1BA>
    <xmx:QpHSYwtQjLI7eW7TgYXh0DSNwpZzYxRa--RDQDHw0mAOojFV6nheYw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 09:42:09 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C240510C9D0; Thu, 26 Jan 2023 17:42:06 +0300 (+03)
Date:   Thu, 26 Jan 2023 17:42:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv15 00/17] Linear Address Masking enabling
Message-ID: <20230126144206.mebmtx5ku3qy6xf6@box.shutemov.name>
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wjJ2-ReHbDfLwjTVY=Sx=cFq+zNzp80ALQOb=V1+y0taQ@mail.gmail.com>
 <20230124110158.bwqu3v2evoa3ffw6@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124110158.bwqu3v2evoa3ffw6@box.shutemov.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:01:58PM +0300, Kirill A. Shutemov wrote:
> On Mon, Jan 23, 2023 at 06:07:20PM -0800, Linus Torvalds wrote:
> > On Mon, Jan 23, 2023 at 2:05 PM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > > 64-bit linear addresses, allowing software to use of the untranslated
> > > address bits for metadata.
> > >
> > > The capability can be used for efficient address sanitizers (ASAN)
> > > implementation and for optimizations in JITs and virtual machines.
> > >
> > > The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
> > > this time.
> > 
> > I didn't react to anything objectionable in the series.
> > 
> > My only reaction was actually to ask "when / what CPU cores are
> > expected to support this feature"?
> > 
> > Maybe it was mentioned somewhere, and I'm just blind and not finding
> > it.  But even the "Instruction Set Extensions and Future Features"
> > paper seems to just be talking about the CPUID bits, not about any
> > actual "this is when we expect it".
> 
> There's no announced CPUs that have the feature. And it is above my pay
> grade to disclose anything beyond that.

I've asked around and if everything goes well it will be available early
2024.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
