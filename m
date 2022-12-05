Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BBB6434C5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiLETv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbiLETvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:51:32 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF3924BF4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:49:12 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h24so12197226qta.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 11:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MEijMZXeEEYvI1+AbjGx4iFFw51kYi6g3uzD8tWqzo=;
        b=R0CnFN6rKkRLxO3kNWfkCBQN+HRFXYC8Kj51xorDuDRAbin/6yDknK9b9imjrdmXST
         6s2exEyWzWZJsO/vXFutTzEUVtELTt3WmGOjDxloKGNl/FekhaceVE0hSF7M46uYKk6H
         ylA1F/v1JpoCzGoIZmjI0ckZOxTYGImLPqXKIZR4vfQeN/K52fxgkbZwj+h7pFiRY7l3
         4ioXnnUIHT3Ay/Lunf6JcwHkDmVysXwpDUCUEdQnFuJp76LxP/+rXlw4m/Zn3AW7tNGI
         sN0opyGTlsYe5mWUyxNKJA8f1gVHhKPLAwNlksJdMkktsZumH+Tk4pME7Ep25G4nOT59
         28UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MEijMZXeEEYvI1+AbjGx4iFFw51kYi6g3uzD8tWqzo=;
        b=CoPke7kKJGOO1akgC8y8xT2BJ6pUzNSopUgVzVMgZ0AkJ/ia/4oUqRTknphQhOofoe
         zbvdovvn1BlopHqXDawxZIg+RwedUtbUJ0js+F3vB8C4VuKmtfh60Dl99AAI3dybW3LJ
         f4Zuz64WezF5hLnWeOjVQ9ILkuKmVFbGW2KALt3wNN1f7woQe1bthDBsvqre9PGl4SMo
         IGhlLK90Tg7fyAL+uId31ow9rv6q+Rj7pWSSJrD7CXBk5pnJVFe8giWw2zzdl2MDeJGg
         Go6uv5bp1VRT4SoO2JTmDp6Wd2UHM95caqkL/MVvDRmA7jgwE2mbiMMl/bMN7JYIA02w
         SaTQ==
X-Gm-Message-State: ANoB5pl/sY6iNIa4tYGfm/G/fOSTS1DXPRn8FGC4Cow46dGn4kFMt40C
        c5rgpun1XeEOxGdklsHU248=
X-Google-Smtp-Source: AA0mqf7KdiBiZaQjttsa9oa6dG6huCy9GsbkMiQRqT/4My47X5WVajUurpxZQe1TzAg5CeV4TVqPkg==
X-Received: by 2002:ac8:60c:0:b0:3a6:37bd:ace5 with SMTP id d12-20020ac8060c000000b003a637bdace5mr64736870qth.426.1670269751734;
        Mon, 05 Dec 2022 11:49:11 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id l25-20020ac848d9000000b003a7ea0f797asm554387qtr.90.2022.12.05.11.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:49:11 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8556127C0054;
        Mon,  5 Dec 2022 14:49:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 05 Dec 2022 14:49:10 -0500
X-ME-Sender: <xms:NUuOYzNEDt0kH85iGmvdKPffOe4XGk9OArPqAgOabWc3Tv-BcHMLeA>
    <xme:NUuOY9_3UlEqaK9TR0-GZ8vHNDf-YNhwDlg3J8yTAJ4ZzX9acM5CQtl2WEV8U-CNo
    nsAapRxCgxaVc3Kjw>
X-ME-Received: <xmr:NUuOYyQ8-gVNSmciR6boHR3i05RRkY_QmTH-p_J_XMVl8lTrn0VAADwp5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeggddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:NUuOY3tfp0tapFDPeH1tJtxZEWMJ51h290fVFIRE757yzcQb_8Ppgg>
    <xmx:NUuOY7fts4GtZBnlUcRW-ENYX40b9-C8vc6f79uROwOny6jviTmbCQ>
    <xmx:NUuOYz09yTgWHy7bs9xVgQ0l75DTbJrqcZG38Iwf9Y4X8f8-Ily2qg>
    <xmx:NkuOY2tppxHlsvK4u7NPHbPb8WDLnjZj7zDbw7wvM10_GFaTyLwkIQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Dec 2022 14:49:09 -0500 (EST)
Date:   Mon, 5 Dec 2022 11:49:07 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
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
Message-ID: <Y45LM+VBFLCWtN1g@boqun-archlinux>
References: <Y4pIwqK7SWft1xCl@boqun-archlinux>
 <4262e55407294a5989e766bc4dc48293@huawei.com>
 <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
 <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4vAYzJTTQtNkXFh@rowland.harvard.edu>
 <20221203231122.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <43c7ea9ebdd14497b85633950b014240@huawei.com>
 <Y4xbQmnDEbFTvgQ/@Boquns-Mac-mini.local>
 <d86295788ad14a02874ab030ddb8a6f8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d86295788ad14a02874ab030ddb8a6f8@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 01:42:46PM +0000, Jonas Oberhauser wrote:
> > Without it, I guess the rationale of this patch is "plain accesses
> > shouldn't be weaker than registers" or "This (plain accesses don't
> > provide dependencies) is too conservative", and these don't seem
> > very strong without a bigger motivation behind it.
> 
> Good points, thanks.
> 
> 
> -----Original Message-----
> From: Boqun Feng [mailto:boqun.feng@gmail.com] 
> Sent: Sunday, December 4, 2022 9:33 AM
> >
> >  a real world code usage that needs this fix
> 
> Note that in the standard C world, 'int a' (and even 'register int a')
> declares an object, i.e., a memory location that is accessed with
> plain accesses. In my opinion, that 'int a' is a "register" in herd7
> is an implementation artifact that hides the current weakness
> addressed by this patch. So if you would actually analyze pretty much
> any code that looks like
> 
>    int a = <some atomic load>
>    if (a == ...) { <some atomic store> }
> 
> then under the standard interpretation of that code, a is a memory
> location, and there is (in current LKMM) no control dependency, and
> the code would be considered broken by LKMM.
> 
> Or in another view, whether something that is (provably) never
> accessed externally is to be considered a 'register' or a 'memory
> location' should be an implementation detail of the compiler etc.
> (with the possibility to freely do reg2mem/mem2reg), and not have any
> effect on the ordering guarantees. Notably most tools (GenMC for sure
> and I think also Dat3M) use such compiler transformations (especially
> mem2reg) because they live under the assumption that it doesn't change
> anything, but of course with current LKMM that renders all of these
> tools unsound; if you would carefully avoid to do any such
> transformations, then these tools would also report bugs in a lot more
> linux code.
> 

Thanks! This is exactly what I want to see ;-) Now I understand more
about the rationale of this change:

First, Linux kernel developers expect and use dependencies ordering.

Second, herd modeling has the concept of "registers" that carries the
dependency because herd also models asm code where "registers" do exist.

Third, for C standard or other models' viewpoint, LKMM has some
inconsistency since both "int a" and "*z" are "memory locations",
however LKMM currently respects dependencies carried by the first but
not those carried by the latter.

Finally, to close the gap with LKMM+herd with other model tools and C
standard, all dependencies that carried by "memory locations" should be
enforced in LKMM.

I must say I didn't get the "Third" part from your patch at first, now
re-read your patch, I think you did mention that in some degree. I guess
the reason I did get it first is because my mind is herded ;-)

How about adding some comments before "carry-dep", for example:

(* Redefine dependencies to include those carried through plain
accesses, since herd by default only generates dependencies via
"registers", while LKMM enforces dependencies carried by "memory
location" of C standard *)

I guess Alan and Paul can do better job on wording, so that just
expresses my idea. Maybe instead of saying "Make plain accesses carry
dependencies", we say "Make memory location carry dependencies" or
"Extend dependency carrying from registers to memory locations".

Thoughts?

> 
> 
> 
> > Also I'm in the impression that people love to put
> > READ_ONCE()/WRITE_ONCE() when they have some ordering issues (in
> > real world or with LKMM). 
> 
> Note that this would require to do 
> 
>   int a; WRITE_ONCE(&a, <some_atomic_load>); if (READ_ONCE(&a) == ...)
>   { <some_atomic_store>; }
> 
> to get a control dependency, and imho violate the point of relaxed
> marked accesses -- to point out where races are, but no (additional)
> ordering is required.
> 
> > Although I don't like this
> 
> I like this and I have forwarded Paul's email to some friends who like

"So you are these guys" ;-) I guess I shouldn't say "I don't like this",
I'm OK with either way since I also understand the benefit you mentioned
below.

> not to put relaxed marked/atomic accesses in their code "because it
> makes the code less readable". I completely disagree -- marking racy
> accesses makes the code more readable because it lets us know when
> something is subject to concurrent access, and modifying the logic may
> break code of other threads.
> 
> What I don't like is relying on dependencies in the first place, since
> they are hard to maintain -- some innocuous optimizations that people
> might want to do (like adding some read in front of a bunch of writes
> to see if they're really necessary) bypass the ordering imposed by the
> dependency. So I generally advise to use acq loads instead, unless
> there is a measurable performance impact. But that's a completely
> separate discussion...
> 

True. I actually agree with the "acq loads first, unless performance
benefit" approach.

[I will reply the ctrl/addr in a separate mail]

Regards,
Boqun
