Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F446890BF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjBCHZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjBCHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:25:13 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0239B8B7E8;
        Thu,  2 Feb 2023 23:25:13 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id f10so4648892qtv.1;
        Thu, 02 Feb 2023 23:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LgYhyoMoRD4udtqUM2qBfSLhp8K9vGhmae+KRWIDmA=;
        b=HA37JagceU+abjL5kPNzvDagNL5AOgjiRcW/ybO5fy5cSplpB0lW5fCzHny5V7G0Um
         XZRcJrBEVkyYUiTjI/KzSLspqfBHaT5TezxzzgPaPHMAcRbVSzarMf+KoUZ7JUjWCkUr
         cJZIyTF6eme9KyHfyVvWYBn9knp2pAIly9s41gZVYkV3Rikd9Srz3QuFfO/291Oot89r
         Shw9qdK4jnWNWKroLMLz9s36B2o2REaxNNFCqCgcxF9AN06v1fBOxZEfosxQOVfQyxo2
         CBzhKfQRI+trl2V1Te6DqVBYsVkWaJi1v7lINZGe33VJ29DVZq6tM1OwUgxPm3SnrOUi
         SbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LgYhyoMoRD4udtqUM2qBfSLhp8K9vGhmae+KRWIDmA=;
        b=YRq7Brn/L3Epl8D4G7Opxw2i55sAXsU/7kxTBLVUcNJY4kyAvW6cmoq/NNDmQPdJL0
         HJ4uX8MWL+X9h3HiF19+gYFHjmogQF9BPqKe2Ru7hCGT5Dw1ypm/kvy2giLht43l0xj8
         CSDzd9aABZpMSvpQcM1tNwTd7rr/32xcpjh9BxWcXtOZYh8i/STQaiaChBoJkCY4pmAr
         30sD0ouZ9Sg0OBDvhAYoPybca1jvOxo114Ewt6f94o1EegD6+qa8kcAZZisehUMxENG6
         yHVTOVX7LAsLezO+eYDRwaFKAMdJYaMcKxzuNhvS0esx3xCgbJdBWM+WwivZccfDCIwU
         zjqw==
X-Gm-Message-State: AO0yUKXNfEnDp79m4KFZWUeSBlM0aapDn3bAWEBHLGPFjJTYV0WNPnnr
        GzAJUGpWyMLnarslyTruD3I=
X-Google-Smtp-Source: AK7set8Iz3xLH2kZr3/wVm96lRXUAOUO0li4ogNMbg2Gus2eCliywWx5Xj1LTSlGT71cWLbdV2nE2Q==
X-Received: by 2002:a05:622a:1a0e:b0:3b1:c538:7026 with SMTP id f14-20020a05622a1a0e00b003b1c5387026mr15317547qtb.42.1675409112127;
        Thu, 02 Feb 2023 23:25:12 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s8-20020ac85cc8000000b003b9b4028d63sm1130863qta.80.2023.02.02.23.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:25:11 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id B9B5127C0054;
        Fri,  3 Feb 2023 02:25:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 03 Feb 2023 02:25:10 -0500
X-ME-Sender: <xms:1rbcYyMbUdYO9c3B1_4jTca788jFo6r61tYxIjd9wYzSthldutgUJg>
    <xme:1rbcYw8cJMU1ze8bbAuFip5Mm-UgriWmHkSFhrTzaVoxawN8uT1SYlFMwtBRLMFBy
    l-O-1Dt0AdX-mYE6Q>
X-ME-Received: <xmr:1rbcY5TEyTjPVccNNf6Mp2EvshVe5jU6gHmcUGOzwzrWSx_LOo7hcnbJy99f6t5ohJgc5Nt72Ci0tb8R2MA9-gpuDIBGIEQ-MRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefledguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:1rbcYysX2Uk80gckibCTSJWg-VyiOCOujMEvb1ktghARaaGOK82T5g>
    <xmx:1rbcY6dDJ15UYQ5kWgp9SSSIWfgWff2d272cbBJMWso7zDU5POR4YQ>
    <xmx:1rbcY210Wg7NnpYXHpsLalBvLhpY5tqUwCVMOJonMQ7_QJ71N6JYTA>
    <xmx:1rbcYw1sFxGjacLx1aOTt43dYkSiECwxvqJPmTzKflmxfxWV4CrujQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Feb 2023 02:25:09 -0500 (EST)
Date:   Thu, 2 Feb 2023 23:25:08 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Peter Zijlstra <peterz@infradead.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
Message-ID: <Y9y21JyuPF1nCCzr@Boquns-Mac-mini.local>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-3-boqun.feng@gmail.com>
 <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
 <20230202142153.352ba479.gary@garyguo.net>
 <Y9vZu08L2WaLNJIc@kroah.com>
 <Y9vga90K0aVfGUwW@boqun-archlinux>
 <Y9viM2POUsSnbKUh@kroah.com>
 <Y9vqJ1h2nkaFRpOY@boqun-archlinux>
 <CANiq72kMZ9XQvte41Mzu4oXX=ujGRCrGDZDiYUBVD3=JTGG57g@mail.gmail.com>
 <Y9yaBybest8JBu8A@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9yaBybest8JBu8A@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 06:22:15AM +0100, Greg KH wrote:
> On Thu, Feb 02, 2023 at 10:47:12PM +0100, Miguel Ojeda wrote:
> > On Thu, Feb 2, 2023 at 5:52 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > As I said, I'm open to remove the printing of the refcount, and if you
> > > and Peter think maybe it's OK to do that after the explanation above,
> > 
> > Perhaps part of the confusion came from the overloaded "safe" term.
> > 
> > When Gary and Boqun used the term "safe", they meant it in the Rust
> > sense, i.e. calling the method will not allow to introduce undefined
> > behavior. While I think Peter and Greg are using the term to mean
> > something different.
> 
> Yes, I mean it in a "this is not giving you the value you think you are
> getting and you can not rely on it for anything at all as it is going to
> be incorrect" meaning.
> 
> Which in kernel code means "this is not something you should do".
> 

Now what really confuses me is why kref_read() is safe.. or how this is
different than kref_read(). Needless to say that ArcInner::count() can
guarantee not reading 0 (because of the type invariants) but kref_read()
cannot..

Regards,
Boqun

> thanks,
> 
> greg k-h
