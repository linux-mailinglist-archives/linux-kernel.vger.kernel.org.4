Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08954641B9D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 09:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiLDIdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 03:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiLDIdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 03:33:12 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4B511803
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 00:33:11 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h24so9544598qta.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 00:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E51rwtqdWfTEHC0Ucie+676M3PpLjwYDNxb1JD0wnhk=;
        b=Sh0Fl423xm5ZvkqEMLKn0ScprV1NQS0cuv999y/ZVOCRpFaLdfdoONWw+PrjJ87z5c
         YYgHArabE0CupsoHIEAf+zbP9wzQyOIAxTUtIlDUcDP2S2fhsxm+e/ZVf/BvdiK8Gj5l
         DQDmRQtpmCues/z81YTMYcsKfjXirDawoRrMJtViJbLpqbne4lhAdDy3Cx1p84LPbbPj
         CoQOZWW37JEUDNhRyC35XQVGTjkm4J4D7/6s3IIQ8QUIGpshRf2G7oSjIAL6StjBHmEn
         FmthQMXlO5JmfIIqclvAjvmMZiqPX4+sQWnuAKkIAHARMbExXN95CDIvKZ7mUiNVdx0X
         08qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E51rwtqdWfTEHC0Ucie+676M3PpLjwYDNxb1JD0wnhk=;
        b=C1S35uu1Gf3M2wgighx+2QYstXLe3L2QNXvvAM0elfVq4tbeIxuA2ABvqZVHRhHrGN
         eCVUQpk6xKgc03u0qXbmhJcMEBRJ2NgYBkJkXAI67y1pK15r7J/PXOy+gXeabazdiQq8
         BY4tmH/OzV+PRVHQ8bJYlo5Si5raKRYHwu15RAUV2BxFtK1bO5GEglRBxOhne3RAxJHX
         mnJCOHrD30mrxPBACMpuivy+m0wninbUnYZRCmQoIddePAWpxaAZBzYI8vLNRewbWmdo
         EGT1Q06bj+61y/Elcue3pKhLVsLnLAA8ecY6gSFCaHFDFfrSVkFN5YLvEwL0/8owaLhe
         zzdQ==
X-Gm-Message-State: ANoB5plkhLYnUWRyNAKTXN0i/Go8sEe5gdkDTwh3Me4S+o+Arnwo3BWX
        breiu9fOOHxE1wkIoeZba7g=
X-Google-Smtp-Source: AA0mqf6dW1msh6KXkGNJ7hnzBDUROyFAifqIlcIXLpBSBMZSb2aqkBmNEcjbd5rOBm4+4qZ2UHGCng==
X-Received: by 2002:a05:622a:2488:b0:39c:de22:9ae9 with SMTP id cn8-20020a05622a248800b0039cde229ae9mr73781576qtb.668.1670142790411;
        Sun, 04 Dec 2022 00:33:10 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a288d00b006fbbdc6c68fsm9973441qkp.68.2022.12.04.00.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 00:33:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id D16DC27C0054;
        Sun,  4 Dec 2022 03:33:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 04 Dec 2022 03:33:08 -0500
X-ME-Sender: <xms:RFuMYyxJlUBfbb52k8wPSHV74ava6rmbfvNdxUd6iBwpyi0YsJrC3g>
    <xme:RFuMY-TL04MOEYk7FODghCFH6b9VzqLLDZXN7Y8DPLY0Tq2yknhvfjSuqcOnmrHWV
    TszHb-vMqnv97EXjg>
X-ME-Received: <xmr:RFuMY0UA7Q-kD-_V8C4RYmuO-uLbB64pgC2xHSwf_YPCQreF8bYdJPVTszdRVxJQQIQ6syaCEyeKdFbKLvmhe6Ma57SuC2jOYlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddugdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:RFuMY4iHphAmT-TKBXH4yq0Ekvu1TiP_dxWyNyYgdjU7uBAKOHHwgw>
    <xmx:RFuMY0CpT9KKb-5fOfefa7iGoIaq4ng-s20lDElJR3YZs6c3o65FlA>
    <xmx:RFuMY5Is4SUPgrfyzbrd43d3-2fuwCBuJtnSbs0mH9FPEFywmSuiXA>
    <xmx:RFuMY-yCvFzAMCJ2ORxh-48Pz3ES8ohL33OvnqHk06dhOn5D7SPwrg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Dec 2022 03:33:07 -0500 (EST)
Date:   Sun, 4 Dec 2022 00:33:06 -0800
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
Message-ID: <Y4xbQmnDEbFTvgQ/@Boquns-Mac-mini.local>
References: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
 <Y4pIwqK7SWft1xCl@boqun-archlinux>
 <4262e55407294a5989e766bc4dc48293@huawei.com>
 <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
 <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4vAYzJTTQtNkXFh@rowland.harvard.edu>
 <20221203231122.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <43c7ea9ebdd14497b85633950b014240@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43c7ea9ebdd14497b85633950b014240@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 12:15:27AM +0000, Jonas Oberhauser wrote:
> 
> 
> -----Original Message-----
> From: Paul E. McKenney [mailto:paulmck@kernel.org] 
> Sent: Sunday, December 4, 2022 12:11 AM
> To: stern@rowland.harvard.edu
> > On Sat, Dec 03, 2022 at 04:32:19PM -0500, stern@rowland.harvard.edu wrote:
> > > My advice: Omit them both.
> > It would be good to reference something or another.  ;-)
> 
> I also prefer to not refer to that presentation. 
> If there is a feeling that more context is needed, I would first
> prefer to enhance the commit message itself in some way. (Personally I
> don't feel that this is needed, and the imho the issue stands by
> itself even without reference to OOTA, which could be resolved fully
> independently e.g. by Viktor's suggestion to just axiomatically forbid
> OOTA --- the issue addressed by this patch would still exist). If

The reason that I'm gving you a hard time is that I haven't seen a real
world code usage that needs this fix, maybe there is one and I'm just
stupid and not knowing about. Your litmus explains the problem very well
but it's better if there is real world code expecting this ordering.

Not saying real world code is essential for memory model changes, but
without it, I guess the rationale of this patch is "plain accesses
shouldn't be weaker than registers" or "This (plain accesses don't
provide dependencies) is too conservative", and these don't seem very
strong without a bigger motivation behind it.

Also I'm in the impression that people love to put
READ_ONCE()/WRITE_ONCE() when they have some ordering issues (in real
world or with LKMM). Although I don't like this, but you cannot blame
people who just want more guarantee allowing their code to work ;-( This
is also another reason that I'd like to see strong reasoning of this
change.

Besides, could you also explain a little bit why only "data;rfi" can be
"carry-dep" but "ctrl;rfi" and "addr;rfi" cannot? I think it's because
there are special cases when compilers can figure out a condition being
true or an address being constant therefore break the dependency? But
maybe I'm wrong or missing something. Thank you!

(Please don't be mad at me, sometimes I'm just slow to understand things
;-))

Regards,
Boqun

> that's not satisfactory, I would also consent to publishing the
> e-mails from the thread starting where I relayed Viktor's observation
> of the relaxed accesses, but I don't recall it saying anything
> substantially beyond the current commit log + the documentation
> included in the patch.
> 
> best wishes, jonas
