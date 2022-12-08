Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB5D6477AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLHVHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiLHVGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:06:39 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46A689313
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:06:34 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id r15so1819383qvm.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 13:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySNqNVpUd0Jr6m4PSPTli04tB1pzsF8IDPxXORzHhuY=;
        b=HpoKD0dsnLlaidNJD8KDUQaaGZt5ZfTaSMBOzXj5rbTwcayHiVN3461frPj52SopCL
         GChmakiYjd8UrAYdem2q32n74zE1W+C1V5dvDJEl70f8fjjRRPcdgtPcUw6/e5DcFjTt
         he7k4ZrX6yRpVw2sUAa3JYNGA8MZO+SId9LwyQZJqY28EuZc1CMxkoDQb35jxFiJ98lu
         xwLnbO1ULX8QNsAxNW9agydC/JUB56mtF30kC1igf6lwpC30uN9zczesMikJoC5TDl68
         YoNbQ2cx13YUt22BhBKRKkc0aEbgiAzGyS+mSW4rpIH7J9wSpzsp1IneT57tep+MdDdq
         7Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySNqNVpUd0Jr6m4PSPTli04tB1pzsF8IDPxXORzHhuY=;
        b=GluGOg7mGGrgqOPcb5NQXiWmU1B4lPCLRF5l320cdQCDVOemd1ixabTi5q0duSr/F5
         JiUrpdtlGC1uFbbDl/PmiajCDMQ50J8ZQslXPANrmcyIP3k26+T/ZMBlgAMKclgARnyI
         PhPkRjeqHG8tDHiIK7GQ6MZtEdwjnvT5rv/YHRhruGlrFo3GsLL1ABkqvqM+KrgJUBAW
         tHAyvwoi0Ns3lcrQ8oMKUgWQ9cMLEG55IgicyBvFmtb7B21Sh5jfW8peN03+04DBVzDu
         SLlelhCsOtuAdwgGvVChLv4zY/JPjnPLZOI1ZcMp0Em5+I+dGVkw9qUoAZQZtBoTiq8x
         MM9w==
X-Gm-Message-State: ANoB5pmEAamIh7swG/2d60Io72CX7L5mAirKYRvomd4+4zu0cgVRUVWx
        YBYBugoEtBA7oIEvFNGI6Wk=
X-Google-Smtp-Source: AA0mqf6YFhS2LkskBm36JcSBkzNLbldVdHggIHYpagKHKtzmm04PUc0itJn5ybIXxz5QBpDKC8fbLA==
X-Received: by 2002:ad4:57a8:0:b0:4c7:8c20:9ec9 with SMTP id g8-20020ad457a8000000b004c78c209ec9mr6911631qvx.131.1670533593766;
        Thu, 08 Dec 2022 13:06:33 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w21-20020a05620a0e9500b006e07228ed53sm19355406qkm.18.2022.12.08.13.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:06:32 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id E8F7527C0054;
        Thu,  8 Dec 2022 16:06:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 08 Dec 2022 16:06:31 -0500
X-ME-Sender: <xms:11GSY_TCi2M9pjUjOFEIJfwD-tfyypo8eo7xsAcZcFxt30i7G9K5-A>
    <xme:11GSYwxWj4zGOnVqU9cd45amipti70N2H_mjOq-R6EFhb9KMMGGfVmK0OX_0vIDV_
    nx1SFxWjaX6PO0eTw>
X-ME-Received: <xmr:11GSY03DxlISylj09457jXpf8VnqEp2iBreLgz8YC5_B93mGRJmN08KdEf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhveetgfevkedvteeigeeivdeitdffhfevgeefudeuffduheefudehueet
    iedtgeenucffohhmrghinheprhgvfihrihhtvgdrmhigpdhkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvg
X-ME-Proxy: <xmx:11GSY_DB9-fOMRKtVpXyHEuVbzdpTZog-54QvxlNkCBATTw2k1Nfzw>
    <xmx:11GSY4j3PoLHEsrFbVlpTtc0albqAyNTZWFMG8jeMATTt7_YhTIfeg>
    <xmx:11GSYzoxeqm-1oM-cImU-rIjSOQhC0ua12-GgvW_d0R4DSIf5KAN0A>
    <xmx:11GSY7WdSxqAAuNs9C5l47w2W3SMpJc-4zpraKqNhM_ylvZ_zP-JWw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 16:06:30 -0500 (EST)
Date:   Thu, 8 Dec 2022 13:06:20 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
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
Message-ID: <Y5JRzG78dHfnp0bR@boqun-archlinux>
References: <4262e55407294a5989e766bc4dc48293@huawei.com>
 <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
 <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4vAYzJTTQtNkXFh@rowland.harvard.edu>
 <20221203231122.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <43c7ea9ebdd14497b85633950b014240@huawei.com>
 <Y4xbQmnDEbFTvgQ/@Boquns-Mac-mini.local>
 <d86295788ad14a02874ab030ddb8a6f8@huawei.com>
 <Y4/v1bCjahxA1LVt@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4/v1bCjahxA1LVt@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 05:43:49PM -0800, Boqun Feng wrote:
> On Mon, Dec 05, 2022 at 01:42:46PM +0000, Jonas Oberhauser wrote:
> [...]
> > > Besides, could you also explain a little bit why only "data;rfi" can
> > > be "carry-dep" but "ctrl;rfi" and "addr;rfi" cannot? I think it's
> > > because there are special cases when compilers can figure out a
> > > condition being true or an address being constant therefore break
> > > the dependency
> > 
> > Oh, good question. A bit hard for me to write down the answer clearly
> > (which some people will claim that I don't understand it well myself,
> > but I beg to differ :) :( :) ).
> > 
> > In a nutshell, it's because  x ->data  [Plain]  ->rfi  y ->... z
> > fulfils the same role as storing something in a register and then
> > using it in a subsequent computation; x ->ctrl y ->... z (and ->addr)
> > don't. So it's not due to smart compilers, just the fact that the
> > other two cases seem unrelated to the problem being solved, and
> > including them might introduce some unsoundness (not that I have
> > checked if they do).
> > 
> > Mathematically I imagine the computation graph between register
> > accesses/computations r_1,...,r_n and memory accesses m_1,...m_k that
> > has an unlabeled edge  m_i -> r_j when m_i loads some data that is an
> > input to the access/computation r_j, similarly it has an unlabeled
> > edge r_i -> r_j  when the result of r_i is used as an input of r_j,
> > and finally r_i ->data/ctrl/addr m_j when the value computed by r_j is
> > the address/data or affects the ctrl of m_j.  So for example, if 'int
> > a' were to declare a register, then
> >     int a = READ_ONCE(&x);
> >     if (a == 5) { WRITE_ONCE(&y,5); }
> > would have something like (*) 4 events  (*= since I'm avoiding fully
> > formalizing the graph model here I don't really define to which extent
> > one splits up register reads, computations, etc., so I'll do it
> > somewhat arbitrarily)
> > m_1 = READ_ONCE(&x)
> > r_1 = store the result of m_1 in a
> > r_2 = compare the content of a to 5
> > m_2 = WRITE_ONCE(&y, 5)
> > 
> > with the edges m_1 -> r_1 -> r_2 ->ctrl m_2
> > 
> > Then in the LKMM graph, we would have m_i ->ctrl m_j (or data or addr)
> > iff there is a path m_i -> r_x1 -> ... -> r_xl ->ctrl m_j (or data or
> > addr).
> > So in the example above, m_1 ->ctrl m_2.
> > 
> > Now what we would do is look at what happens if the compiler/a
> > tool/me/whatever interprets 'int a' as a memory location. Instead of
> > r_1 and r_2 from above, we would have something like
> > 
> > m_1 = READ_ONCE(&x)
> > r_3 = the result of m_1 (stored in a CPU register)
> > m_3 = a := the r_3 result
> > m_4 = load from a
> > r_4 = the result of m_4 (stored in a CPU register)
> > m_2 = WRITE_ONCE(&y, 5)
> > 
> > with m_1 -> r_3 ->data -> m_3  ->rfi  m_4 -> r_4 ->ctrl m_2
> > and hence
> > m_1 ->data m_3 ->rfi m_4 ->ctrl m_2
> > 
> > What the patch does is make sure that even under this interpretation,
> > we still have m_1 ->ctrl m_2
> > Note that this ->data ->rfi applies in every case where something is
> > considered a register is turned into a memory location, because those
> > cases always introduce a store with a fixed address (that memory
> > location) where the data is the current content of the register, which
> > is then read (internally) at the next time that data is picked up. A
> > store to register never becomes a ctrl or addr edge, hence they are
> > not included in the patch.
> > 
> 
> Let me see if I can describe your approach in a more formal way (look at
> me, pretending to know formal methods ;-))
> 
> Bascially, what you are saying is that for every valid litmus test with
> dependencies (carried by local variables i.e. registers), there exists a
> way to rewrite the litmus test by treating all (or any number of) local
> variables as memory locations.
> 
> Lets say the set of the litmus tests to start with is L and the set of
> the rewritten ones is L'is. Here is a rewrite rule I come up with:
> 
> 1)	for every local named <n> on processor <P>, add an extra memory
> 	location (maybe named <n>_<P>) in the processor function, for
> 	example
> 
> 		P0(int *x, int *y) {
> 			int a ...;
> 		}
> 
> 	became
> 		P0(int *x, int *y, int *a_P0) {
> 		}
> 
> 2)	for each <n> in 1), for each assignment of <n>, say:
> 
> 		int <n> = <expr>; // H
> 
> 		or 
> 
> 		<n> = <expr>; // H
> 	
> 	rewrite it to
> 	
> 		int computer_register_<seq> = <expr>; // A
> 		*<n>_<P> = computer_register_<seq>; // B
> 	
> 	where <seq> is a self increasing counter that increases every
> 	step or the rewrite.
> 
> 	This step introduces an extra edge A ->data B.
> 
> 3)	for each <n> in 1), for each the read of <n>, say:
> 
> 		Expr; // T
> 	
> 	rewrite it to
> 
> 		int computer_register_<seq> = *<n>_<P>; // C
> 		Expr[<n>/computer_register_<seq>]; // D
> 
> 	where <seq> is a self increasing counter that increases every
> 	step or the rewrite.
> 
> 	"M[x/y]" means changing the expression by replace all appearance
> 	of variable x into y, e.g. (n1 = n + 1)[n/y] is n1 = y + 1.
> 
> 	Note that for every rewrite 3), there must exists a
> 	corresponding rewrite 2), that C reads the value stored by the
> 	B of the rewrite 2). This is because the litmus tests in set L
> 	are valid, all variables must be assigned a value before used.
> 
> 	This step introduces an extra edge B ->rfi C, and also for every
> 	dependency between H -> T in the old litmus test, it preserves
> 	between C -> D in the new litmus test.
> 
> 4)	for each <n> and <P> in 1), for each expression in the exist
> 	clause, say:
> 
> 		Expr
> 	
> 	rewrite it to
> 
> 		Expr[<P>:<n>/<n>_<P>]
> 
> For example, by these rules, the following litmus test:
> 
> 	P0(int *x, int *y) {
> 		int r = READ_ONCE(*x);
> 		WRITE_ONCE(*y, r);
> 	}
> 	exists(0:r = 1)
> 
> is rewritten into
> 
> 	P0(int *x, int *y, int *r_P0) {
> 		int computer_register_0 = READ_ONCE(*x); // by 2)
> 		*r_P0 = computer_register_0;             // by 2)
> 		int computer_register_1 = *r_P0;         // by 3)
> 		WRITE_ONCE(*y, computer_register_1);     // by 3)
> 	}
> 	exists(r_P0 = 1)                                 // by 4)
> 
> 
> It's obvious that the rewritten litmus tests are valid, and for every
> dependency
> 	
> 	H ->dep T in litmus tests of set L
> 
> there must exists a
> 
> 	A ->data ->rfi ->dep D in L'
> 
> ("dep" is not the same as in linux-kernel.cat).
> 
> And note since L' is a set of valid litmus tests, we can do another
> whole rewrite to L' and get L'' which will contains
> ->data->rfi->data->rfi->dep, and this covers the (data;rfi)* ;-)
> 
> 
> Now the hard part, since the rewrite is only one-direction, i.e L => L',
> or more preciselly the transverse closure of the rewrite is
> one-direction. We can only prove that if there exists a valid litmus
> test with dependency ->dep, we can construct a number of litmus tests
> with (->data ->rfi)*->dep.
> 
> But to accept the new rules in your patch, we need the opposite
> direction, that is, if there exists a (->data ->rfi)* ->dep, we can
> somehow find a litmus test that preserves anything else but reduce
> 
> 	(->data->rfi)*->dep
> into
> 
> 	->dep.
> 
> (I'm not sure the following is sound, since some more work is needed)
> 
> The first observation is that we can ignore ->data [Marked] ->rfi,
> because if we can reduce
> 
> 	(->data [Plain] ->rfi)* ->data [Marked] ->rfi -> (->data [Plain] ->rfi)* ->dep
> 
> to
> 	
> 	->data [Marked] ->rfi ->dep
> 
> we get "hb", which already has the ordering we want.
> 
> Now we can focus on ->data [Plain] ->rfi ->dep, e.g.
> 
> 	x = READ_ONCE(..); // A
> 	*<N> = <expr>; // B, contains x
> 	r = Expr; // C, Expr contains *<N>
> 	WRITE_ONCE(.., r); // D
> 
> We need to assume that the litmus tests are data-race free, since we
> only care about valid litmus tests, then it's OK. The rewritten looks
> like the following:
> 
> 	int computer_register_<seq>;
> 	x = READ_ONCE(..); // A
> 	computer_register = <expr>; // B, contains x
> 	// ^^^ basically reverse rewrite of the 2) above	
> 
> 	r = Expr[*<N>/computer_register_<seq>]; // C
> 	// ^^^ basically reverse rewrite of the 3) above	
> 
> 	*<N> = computer_register_<seq>; // R
> 	// ^^^ need this to keep the global memory effect
> 
> 	WRITE_ONCE(.., r); // D
> 	
> We need the data-race free assumption to replace a memory cell into a
> local variable.
> 
> By this rewrite, We reduce
> 	A ->data B ->rfi C ->dep D
> into
> 	A ->dep D.
> 
> A few details are missing here, for example we may have multip Cs and
> need to rewrite all of them, and we need normalization work like
> converting litmus tests into canonical forms (e.g change the += into
> temporary variables and assignment). Also we need to prove that no more
> edges (or edges we care) are added. But these look obvious to me, and
> enough formally digging for me today ;-)
> 
> As a result, the rewrite operation on L is proved to be isomorphic! ;-)
> In the sense that we think reducing to (->data [Marked] ->rfi)* ->dep
> is good enough ;-)
> 
> Now for every litmus test with
> 
> 	(->data ->rfi)* ->dep
> 
> we can rewrite it into another litmus test preserving all other edges
> except replacing the above with
> 
> 	(->data [Marked] ->rfi)* ->dep
> 
> and the rewrite only contains replacing non-data-race accesses with
> local variables and in the sense of C standards and maybe other model
> tools these litmus tests are equivalent.
> 
> > Please let me know if this is convincing and clear. If so we could
> > link to your e-mail and my response to provide context, without having
> > to put a huge explanation into the commit message. If that's not
> > desirable I can also think about how to compress this into a shorter
> > explanation.
> > 
> 
> My intution now is the rewrite explanation above, which is good enough
> for me but not sure for other audience. Thank you for keep explaining
> this to me ;-)
> 
> 
> Regards,
> Boqun
> 

Paul, I think Jonas and I reach out to some degree of argeement on more
details of this change, at least I learned a lot ;-)

Could you add the following lines in the commit log if you haven't send
a PR?

	More deep details can be found at the LKML discussion[1]

	[1]: https://lore.kernel.org/lkml/d86295788ad14a02874ab030ddb8a6f8@huawei.com/

I think Jonas' email covers most of the details behind the change and
can server as a "Quick Quiz" for the readers of the commit log ;-)

Thoughts?

Regards,
Boqun

> > Best wishes,
> > Jonas
> > 
> > PS:
> > 
> > > sometimes I'm just slow to understand things ;-)
> > 
> > Well, welcome in the club :D
