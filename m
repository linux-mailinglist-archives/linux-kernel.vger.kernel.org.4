Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF38613E19
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJaTTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJaTT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:19:29 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11FAFD09
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:19:28 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6B2395C00FF;
        Mon, 31 Oct 2022 15:19:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 31 Oct 2022 15:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667243966; x=1667330366; bh=Ow
        zjylfpiTW7nzhK3yVGXrAQ6LvEHswtijkqWXvX+D0=; b=jl/GLqtmJc+HNuofyJ
        mFfTv5jq4ai1SLfGU9N7KZ2Lc6WtJv3+GUtp3P3tWiZo7XJ19gzTxFLA5dEzZIAW
        jG/9qNelXba8TfBd4Of+XBfVyV5EHW9Mx5xHQ+8yLwpYnzCoTdffa6Yi75M8dNA1
        +iRixZEfsyMG4JTxeiZr1AugnFqHMKkwvWcoM6UMSQRHteKFes7D9fQrWJagttC3
        E05qwDNt+jSuT1Qpb2rGGymHgLj2eZEizpKaRZpkC0zO2kHzwI9A2NXfa9oq54U1
        lfRTwNQDXrBMSPsX1iGkBvLON8cfoR9j7wVlxfyM0uprUoZP6BpcdBYF92swJxuY
        xb7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667243966; x=1667330366; bh=OwzjylfpiTW7nzhK3yVGXrAQ6LvE
        HswtijkqWXvX+D0=; b=Q5AVzYvxQLRA9xVpuuIwmQLg7m+ioDIYeKV6HUAxAZDc
        B6XCvvc+pcOW9OJnnIP45wKjdK5W5HT7Y4zWS5EMKZkd5uZsArBsAfyWzlEuvG6n
        viCCQ7ofmGqKEtpsiGVgcDZDtJR+PWno6d4SESQi9EfEDQJk9SbfD4lpSbBT7vlL
        q4DTy3MJT8w446bTRmcJhWII5HaHgipHDlbuoy6EfzTafkQReJzK9Obh3TkObzT5
        VdKEIlfVUBdZToZbQLRs+W/PCYk0trTklEkmL1K5N26Dwh1EtgZQ4OWTaHQFMPWr
        Sej2KsOaGkY6RY3PuxvgqJgcvf3D5SGJ9inNKE+uFA==
X-ME-Sender: <xms:vR9gYwCFUug8uRcqmR-d2q2eO-7UphV9xa8Q8UdZ9m_WtdQvAk5dVA>
    <xme:vR9gYyi9lvKldEUitEhw9lXoHS1A1HyCooz6CS_GhJyfE8hd06APHmhV9IaWidH-d
    mv536RyK7Kk87R062E>
X-ME-Received: <xmr:vR9gYznSYMBx0zxORj0j631p18IwKjE4IFrpIAkLeh6OV1vrrDtsfttT3q1F9dfncSFbig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudefgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeelgffhfeetlefhveffleevfffgtefffeelfedu
    udfhjeduteeggfeiheefteehjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:vR9gY2wkiGVvpWl1Wj4BWkSEj18tu0g4WPwNjOGsRC_ZawG0YaEFuw>
    <xmx:vR9gY1ROhAN3ULpdKCLkN2wP_CcZKJbqfpWFo1aRxrUU5zRD4UvEVQ>
    <xmx:vR9gYxZuC-x2BFyuiKskzCs01JbpQkIHgdTa3eKYvKcbcmuyk3dTBA>
    <xmx:vh9gY-g11dGdKOZAFe843nbSCYGf4Krcl2h5Eg7MiR0kx3Yp928Wbw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Oct 2022 15:19:24 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D196F10956C; Mon, 31 Oct 2022 22:19:21 +0300 (+03)
Date:   Mon, 31 Oct 2022 22:19:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com,
        elena.reshetova@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/tdx: Extract GET_INFO call from get_cc_mask()
Message-ID: <20221031191921.hekalona4n3lls4j@box.shutemov.name>
References: <20221028141220.29217-1-kirill.shutemov@linux.intel.com>
 <20221028141220.29217-2-kirill.shutemov@linux.intel.com>
 <c97e9273-60b6-2ca7-1993-05bfbf471f3f@intel.com>
 <20221028235951.p2vdu7drbbf3ccg7@box.shutemov.name>
 <20221031041252.mdcjocqn6k4k4gvy@box.shutemov.name>
 <812cb868-1729-8d78-cf91-1e63c7933fae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <812cb868-1729-8d78-cf91-1e63c7933fae@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 09:42:15AM -0700, Dave Hansen wrote:
> On 10/30/22 21:12, Kirill A. Shutemov wrote:
> > On Sat, Oct 29, 2022 at 02:59:51AM +0300, Kirill A. Shutemov wrote:
> >>> Can you please take a look through this and make sure I didn't botch
> >>> anything:
> >>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=tdxbadve
> >>>
> >>> The end result is about 50 lines less than what was there before.  Most
> >>> of it is comment removal but the code is simpler too.
> >>>
> >>> Acks and Tested-by's would be appreciated.
> > 
> > One thing that I must bring up is that it seems that there's no way to get
> > the panic message to user. I tried to convinced myself that it is qemu
> > misconfiguration on my part or some race, but no: it is just too early for
> > earlyprintk.
> > 
> > We only get earlyprintk working after parse_early_options() which happens
> > well after tdx_early_init().
> > 
> > Moving panic() after earlyprintk working is not good idea as it exposes
> > kernel more: by the time we already have full #VE handler.
> 
> How about we soften the panic() to a pr_err() if it's a debug guest?

The plan is to have pr_warn() + check in handle_mmio(), as I mentioned
before. But pr_err() also works.

> The first thing a user is going to do if they get an early boot failure
> is flip the debug switch and try it again.  That gets us safe,
> well-defined behavior when we need security and also lets us figure out
> what went wrong.
> 
> Also, did anyone ever actually implement that TDX earlyprintk simple
> console thing?  A TDCALL up to the host with some characters in a
> register or two is as dirt simple of a console as you can get.  It would
> be very easy to improve the user experience here if there were a:
> 
> 	tdx_puts("uh oh");
> 
> interface.  It's a shame if it didn't get done by now.  I asked for it
> years ago.

There's nothing like this, unfortunately.

There's ReportFatalError TDVMCALL that intended for the task, but it only
takes an error code as input which is useless here. Nobody will decode it.

> And, yeah, I know it wouldn't help us in this precise situation because
> earlyprintk doesn't work yet.  But, it *would* be one of those really,
> really early bitbanging-style consoles that _could_ be in use very, very
> early if the printk() infrastructure could take advantage of it.
> 
> > We can move it earlier into decompresser which has different earlyprintk
> > implementation. Not sure if it worth this. What do you think?
> 
> There's the puts()/printf() gunk that's really early like in
> validate_cpu().  Is that what you were thinking of?

More like error() in arch/x86/boot/compressed/kaslr.c.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
