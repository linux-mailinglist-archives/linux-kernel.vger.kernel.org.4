Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44409644D71
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiLFUrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLFUrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:47:07 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279D243852
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 12:47:06 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c15so14736089qtw.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 12:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqCq8TKN4kmB8YNzNOAmt9/ZhwoeUqepaj79gxCSZA0=;
        b=gDLj+Mq4iIY3GH6MgEpu3S4ef4ao0I1kDVlTkZKBKIe9ibrHZMvhKPj4ZXrmRbCyhS
         48qoMRuNKUGu4i9h3Z3JbdkI69xuRgiiYlxo2Xnsxhj8SEPfXsmEEOXujJ8oS9CAy207
         +nhQvIkdNvncROQKuBA9BzNSCj/3v/WMzHHnFofZf8iiQR4CiaQ2dhxp2iGDRjPiigUF
         WXW9VAOBILy7+6m7eCRcGIbvR+HOLjX3mBmdSNGAEhfjcmushTgiwy48FDTvtkUIAs/k
         Q5ZMbIjAK57C7WNM7/P3WkZk2dIMzpcW3FxttPVJMui2YBAdxG43IAN4sH1103s2+gKp
         lpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqCq8TKN4kmB8YNzNOAmt9/ZhwoeUqepaj79gxCSZA0=;
        b=WW29roY/wnpQSK5XOLwZkXAJvp0UN1umG30jzouZ8B2HoPQcFeFnRV9bglN4JkHirG
         TDKvSicVMGhCBiAgpMfjto+rB6OKQ9yXQZd7bb9S45HLdDhTqtTbiJpmbOGK5/gUNPBI
         ILkBRg3mAWM9xPDBGHml6KDGpUr/zzsN/BIUYSsQxcOVsnMzbs6xBw/+LQcIfip+DkPw
         7zg4xcqJpG636SQ/Y7bKAFpe2+JdR/W7ZTmsnHHx/xuj2HozFtFRm9LhceMjw2DK9jRb
         +ltrvS0rlT6eiUIf1zktKfMWb5Vkc19RRWG1SPXEBjv2c/SgFvxGUqRdPdKY7o5hbKMm
         Dr0g==
X-Gm-Message-State: ANoB5pmDHdgko+CSyfflqVop8tJTxzKMmSCZgFk0W5kbHXNLgMx3qcO7
        YNMzFFnyIT0Bgo2tkvhlDzA=
X-Google-Smtp-Source: AA0mqf4JZD9i6JFqIv+J8ppJBVkOcZN1eiw37cWg8OzA4eiqgfs27oCoR+cV0VX060v00j9/ZPs56A==
X-Received: by 2002:ac8:570a:0:b0:3a5:7c31:2e3e with SMTP id 10-20020ac8570a000000b003a57c312e3emr62922770qtw.111.1670359625248;
        Tue, 06 Dec 2022 12:47:05 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id bk4-20020a05620a1a0400b006ee77f1ecc3sm15511089qkb.31.2022.12.06.12.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 12:47:04 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id F193527C005A;
        Tue,  6 Dec 2022 15:47:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Dec 2022 15:47:03 -0500
X-ME-Sender: <xms:R6qPY9euBsNUXz90pvAiwbIAXUY4h3UoDADOjTo3jjb5R59YaM2O3A>
    <xme:R6qPY7O3F_MJWo2LAXYt2sFoOJXq7_iTrIlGs0DhR79WN2W-etfeeBsRIZMRHq4e7
    6Bx8kopTYpEQX-7WQ>
X-ME-Received: <xmr:R6qPY2hhiFp7cBzioMJKj1NqEH5eIIxzkQr-NS4H1obCOHZkd4feQx_c6W8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeigddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:R6qPY29VWFRfyL1oJT6uQuVu5c44Cx5OsVSeM8BZVqmN_tguqb_IjA>
    <xmx:R6qPY5ve9YbCeQBfIo8aNiFRLCIgSHfUExE4oKI35YVU-BKwyJPTag>
    <xmx:R6qPY1GmeX45Oj132ZZehYsRMEJRUzYI7q5XwC0H4xtEfBx69fgpmQ>
    <xmx:R6qPYy9s2feTD2jBYwCa1N1iJx0jJb79Xqvk72w8XMR3PMuduvoRWQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Dec 2022 15:47:02 -0500 (EST)
Date:   Tue, 6 Dec 2022 12:46:58 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
Message-ID: <Y4+qQrhxrcqOUolZ@boqun-archlinux>
References: <4262e55407294a5989e766bc4dc48293@huawei.com>
 <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
 <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4vAYzJTTQtNkXFh@rowland.harvard.edu>
 <20221203231122.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <43c7ea9ebdd14497b85633950b014240@huawei.com>
 <Y4xbQmnDEbFTvgQ/@Boquns-Mac-mini.local>
 <d86295788ad14a02874ab030ddb8a6f8@huawei.com>
 <Y44ZxWYQkMN60a1E@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y44ZxWYQkMN60a1E@rowland.harvard.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 11:18:13AM -0500, stern@rowland.harvard.edu wrote:
> On Mon, Dec 05, 2022 at 01:42:46PM +0000, Jonas Oberhauser wrote:
> > > Besides, could you also explain a little bit why only "data;rfi" can be "carry-dep" but "ctrl;rfi" and "addr;rfi" cannot? I think it's because there are special cases when compilers can figure out a condition being true or an address being constant therefore break the dependency
> > 
> > Oh, good question. A bit hard for me to write down the answer clearly 
> > (which some people will claim that I don't understand it well myself, 
> > but I beg to differ :) :( :) ).

Nah, I think your answer is clear to me ;-)

> > 
> > In a nutshell, it's because x ->data [Plain] ->rfi y ->... z fulfils 
> > the same role as storing something in a register and then using it in 
> > a subsequent computation; x ->ctrl y ->... z (and ->addr) don't. So 
> > it's not due to smart compilers, just the fact that the other two 
> > cases seem unrelated to the problem being solved, and including them 
> > might introduce some unsoundness (not that I have checked if they do).

So it's about whether a value can have a dataflow from x to y, right? In
that case registers and memory cells should be treated the same by
compilers, therefore we can extend the dependencies.
> 
> More can be said here.  Consider the following simple example:
> 
> 	void P0(int *x, int *y)
> 	{
> 		int r1, r2;
> 		int a[10];
> 
> 		r1 = READ_ONCE(*x);
> 		a[r1] = 1;
> 		r2 = a[r1];
> 		WRITE_ONCE(*y, r2);
> 	}
> 
> There is an address dependency from the READ_ONCE to the plain store in 
> a[r1].  Then there is an rfi and a data dependency to the WRITE_ONCE.
> 
> But in this example, the WRITE_ONCE is _not_ ordered after the 
> READ_ONCE, even though they are linked by (addr ; rfi ; data).  The 
> compiler knows that the value of r1 does not change between the two 
> plain accesses, so it knows that it can optimize the code to be:
> 
> 	r1 = READ_ONCE(*x);
> 	r2 = 1;
> 	WRITE_ONCE(*y, r2);
> 	a[r1] = r2;
> 
> And then the CPU can execute the WRITE_ONCE before the READ_ONCE.  This 
> shows that (addr ; rfi) must not be included in the carry-deps relation.
> 
> You may be able to come up with a similar argument for (ctrl ; rfi), 
> although it might not be quite as clear.
> 

Thank you, Alan! One question though, can a "smart" compiler optimize
out the case below, with the same logic?

	void P0(int *x, int *y, int *a)
	{
		int r1, r2;

		r1 = READ_ONCE(*x); // A

		*a = r1 & 0xffff; // B

		r2 = *a & 0xffff0000; // C

		WRITE_ONCE(*y, r2); // D

	}

I think we have A ->data B ->rfi C ->data D, however a "smart" compiler
can figure out that r2 is actually zero, right? And the code get
optimized to:

	r1 = READ_ONCE(*x);
	r2 = 0;
	WRITE_ONCE(*y, r2);
	*a = r1 & 0xffff;

and break the dependency.

I know that our memory model is actually unware of the differences of
syntatics dependencies vs semantics syntatics, so one may argue that in
the (data; rfi) example above the compiler optimization is outside the
scope of LKMM, but won't the same reasoning apply to the (addr; rfi)
example from you? The WRITE_ONCE() _syntatically_ depends on load of
a[r1], therefore even a "smart" compiler can figure out the value, LKMM
won't take that into consideration.

Am I missing something subtle here?

Regards,
Boqun

> Alan
