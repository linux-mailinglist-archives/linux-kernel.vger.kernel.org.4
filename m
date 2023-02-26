Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75316A2D2D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 04:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBZDJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 22:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZDJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 22:09:37 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE46C672
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:09:36 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id w42so3502619qtc.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45JVd2JEFVlVOtXTTPZkiyushi1vQbwcjXrildEUaI8=;
        b=qWhWSx7EzdDEG5j0ldf0kxJRLq+l77P3m8jebHpj+hfwiniY0l2aQXpMLE1KKLXdWn
         PkafHuaoF3OA0r37S9EEfPLQWubbE1vir/UN5LSdYUAX9sY8OZ2dlLolNsI/IKyOccQX
         ze18w+fW9SIih4ncEFcNa0Ee6WP3594ooUwoEQqDKvYDJPG1uT5YkHwHq/PnHCd0zC/I
         HSV3wEJRlSd3ZFk8ZDBWE6YULmrV8sbgKYO2AGbhxyyKtmqAg5RuS+B0T8NFjyd/6ypA
         BWbUHkPntYj5v0hrehWRO3Mac4s4LZbCOjayfS6cYH/couCbY5RM0uv8DNtBBbJThxkc
         X1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45JVd2JEFVlVOtXTTPZkiyushi1vQbwcjXrildEUaI8=;
        b=V+oJZH2yFKBiNkOD7RJRGB3tPMyzJGqpRRbGuiq0dORBzGYqnMzz5Hmdm8bvf7Nvsp
         LYHfiXHrVAnmgLBudYdq02/sqRRK1WE1QoNAVQUdTISy3O7MmmK+Oo2r3aMnYb3AXIJ5
         csevTGh3r536KxyzWRHeBxNGqfvZJzu2+Qj3B81M3pqfGtiwgV3sgST/Nxzv+nrlTyGC
         HAxXpnfR0EBhiUQI0K9mEqZhpG9Tb0qmaCdJAbiSc+BCghIRYL1U+dW9UKYkhOXQhlWB
         IegEF7BnC1itNJLLTW2FeAS2788i3bnpi0L/MEaakiFXnibUDE/YOhHhBPvt3gfh6/v6
         OY7Q==
X-Gm-Message-State: AO0yUKU59CW4WZ3AFoGh5DyqJ/B8UHZvRLAvmLUIELrao3gi1/yWFDz7
        nCxp5LDfXznMoQcK2PQNOCU=
X-Google-Smtp-Source: AK7set95jIUkoinz7NkCmpnOyu2a+A7PKN+oT9bwqOsqyesXqnWdhgle+bnSUuBm+M8E46Vrh+8j4w==
X-Received: by 2002:a05:622a:115:b0:3bf:a08d:b265 with SMTP id u21-20020a05622a011500b003bfa08db265mr9204633qtw.24.1677380975385;
        Sat, 25 Feb 2023 19:09:35 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c75-20020ae9ed4e000000b00738e8e81dc9sm2278211qkg.75.2023.02.25.19.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 19:09:34 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6A43F27C0054;
        Sat, 25 Feb 2023 22:09:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 25 Feb 2023 22:09:34 -0500
X-ME-Sender: <xms:bc36Y4fg2zJY_b3-naD9wR70RhZsndjo8lCKJc6IjX-Mk4060HCElA>
    <xme:bc36Y6P_wYk5yKhVTZiEQPWm7jZJ2GzI2NGCAnGSi-bM8s6gfa88eu8rxqqiLO3Q3
    CdrNE2GebDe6-SZUA>
X-ME-Received: <xmr:bc36Y5ii6u7ydhGKYe2uFJKJGcM1C18x4TIqB9k5P3TxJCDn5wFW380LnIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekjedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:bc36Y982_4B_FoszoXMIv9lmFGAF8PAP32ADFmqwYj2imNojSY-2jQ>
    <xmx:bc36Y0t7zms4pYH1SPrzqZuK-phl2Q2px6MHdwJN0k2Rc19mkGz3TA>
    <xmx:bc36Y0F9up2jh-L2hnGHqPmuS0dWGJV1cVyzbiYp98KM8p3eHCU6NQ>
    <xmx:bs36Y1_P7FDIQ1kA48OIwgbbcdRwRd2su8rLecn0rMhkIZ83GemF3g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Feb 2023 22:09:33 -0500 (EST)
Date:   Sat, 25 Feb 2023 19:09:05 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y/rNUfW509AQYCYn@boqun-archlinux>
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 09:29:51PM -0500, Alan Stern wrote:
> On Sat, Feb 25, 2023 at 05:01:10PM -0800, Paul E. McKenney wrote:
> > A few other oddities:
> > 
> > litmus/auto/C-LB-Lww+R-OC.litmus
> > 
> > 	Both versions flag a data race, which I am not seeing.	It appears
> > 	to me that P1's store to u0 cannot happen unless P0's store
> > 	has completed.  So what am I missing here?
> 
> The LKMM doesn't believe that a control or data dependency orders a 
> plain write after a marked read.  Hence in this test it thinks that P1's 
> store to u0 can happen before the load of x1.  I don't remember why we 
> did it this way -- probably we just wanted to minimize the restrictions 
> on when plain accesses can execute.  (I do remember the reason for 
> making address dependencies induce order; it was so RCU would work.)
> 

Because plain store can be optimzed as an "store only if not equal"?
As the following sentenses in the explanations.txt:

	The need to distinguish between r- and w-bounding raises yet another
	issue.  When the source code contains a plain store, the compiler is
	allowed to put plain loads of the same location into the object code.
	For example, given the source code:

		x = 1;

	the compiler is theoretically allowed to generate object code that
	looks like:

		if (x != 1)
			x = 1;

	thereby adding a load (and possibly replacing the store entirely).
	For this reason, whenever the LKMM requires a plain store to be
	w-pre-bounded or w-post-bounded by a marked access, it also requires
	the store to be r-pre-bounded or r-post-bounded, so as to handle cases
	where the compiler adds a load.

Regards,
Boqun

> The patch below will change what the LKMM believes.  It eliminates the 
> positive outcome of the litmus test and the data race.  Should it be 
> adopted into the memory model?
> 
> > litmus/auto/C-LB-Lrw+R-OC.litmus
> > litmus/auto/C-LB-Lww+R-Oc.litmus
> > litmus/auto/C-LB-Lrw+R-Oc.litmus
> > litmus/auto/C-LB-Lrw+R-A+R-Oc.litmus
> > litmus/auto/C-LB-Lww+R-A+R-OC.litmus
> > 
> > 	Ditto.  (There are likely more.)
> 
> I haven't looked at these but they're probably similar.
> 
> Alan
> 
> 
> 
> --- usb-devel.orig/tools/memory-model/linux-kernel.cat
> +++ usb-devel/tools/memory-model/linux-kernel.cat
> @@ -172,7 +172,7 @@ let vis = cumul-fence* ; rfe? ; [Marked]
>  	((strong-fence ; [Marked] ; xbstar) | (xbstar & int))
>  
>  (* Boundaries for lifetimes of plain accesses *)
> -let w-pre-bounded = [Marked] ; (addr | fence)?
> +let w-pre-bounded = [Marked] ; (rwdep | fence)?
>  let r-pre-bounded = [Marked] ; (addr | nonrw-fence |
>  	([R4rmb] ; fencerel(Rmb) ; [~Noreturn]))?
>  let w-post-bounded = fence? ; [Marked] ; rmw-sequence
