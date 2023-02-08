Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3846A68F335
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjBHQeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBHQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:34:22 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9DC2B2B2;
        Wed,  8 Feb 2023 08:34:20 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 5so11426299qtp.9;
        Wed, 08 Feb 2023 08:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI0hGCc7tabCq/rHs0uEIWFtsIquDYqO7b2bVAx/NrA=;
        b=MMPgIRJai+HPuTNFbuYx8Uis/ICrbBdlJQ3vVmM+oZZg17qySSXd2Juf5WiJQZgNWh
         b2uwHR/vL2zc63Z0Wg/kp/aELw/g/1mvLy0O4x0zHKdibVtlOJyU27z8OSXznnJhL6al
         I5aFEIZcUCQlnKy1zyuu8CLR+1SmOAIeqF2McUmaRzzKtf0Tef4P8jr0vuDSrvtGfYzq
         paDLz6NaTDKwrBzPEw0TnVuOLTlpE/f2Xpzo7iHui5IZw2u5vaILaVLcvvljoZ73sXrT
         puEfShxc/wm0HBgFcZcv7dVTltcWC1LIBktPBGbkAQT9yHSNhslLZPN1XBCsn7tUl/ZW
         O0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI0hGCc7tabCq/rHs0uEIWFtsIquDYqO7b2bVAx/NrA=;
        b=2cGVoqtsTNLG+UgNlIKcLgGR5AdUbCWpAis4et2mruGff0QIfgqiOwQoJYqZ8qVovB
         bFUjr187x8o4YYYjNF08I6Lkc1yOFjmXJjLlg5oNB4zjD7PiR7FoJ0zyeuHYzAwGsAuj
         CIWgJWp0lUzvvFEuauCWEWyW0L00eV/Vku05sQMmjDwuKOWnIBZ90x6kCUXsB50ixLrh
         p5b5AxUGjAx1DMV457KN6asksgBu2P43156yLTHxRMEA1GFNJeL/UAz86KMqCPL54+OI
         ikP94auZShcg6yObU8yAgbeVKhIGqOwQUIYTUyjxndeLFPjdNEI2U7m+pSIc6izoWrwc
         N/+Q==
X-Gm-Message-State: AO0yUKU1YyWZXofBfbUGoHDaYtUZJQVl2769IgmgExSYkTHETIsQ3wj6
        O0STslTELABw/VNfZf/3J5Y=
X-Google-Smtp-Source: AK7set+GboLx7+eHG57hJ03/JnIpf6qdwo8N8amwL6D7hMXp0+USlVkqm6+9Ivd/xPznsczUu31xdA==
X-Received: by 2002:a05:622a:164e:b0:3b9:a42b:7099 with SMTP id y14-20020a05622a164e00b003b9a42b7099mr15817423qtj.30.1675874059832;
        Wed, 08 Feb 2023 08:34:19 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o12-20020ac841cc000000b003b9a573aec6sm11803068qtm.70.2023.02.08.08.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:34:19 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id A646927C0054;
        Wed,  8 Feb 2023 11:34:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 08 Feb 2023 11:34:18 -0500
X-ME-Sender: <xms:Cs_jYxSaK66hK24kGIksgx8s-OhFMF8CQ5VpULOnJ5020A832darWw>
    <xme:Cs_jY6yuZP-xZ5y-Kes04699X6aekWmrJmKVsMAaO7wF_URHv4oJOEmoVTYLV6mMI
    41K6JmbMlVLwTB5uw>
X-ME-Received: <xmr:Cs_jY20_vVi39X1wfTEt8BWnC12LBfCuDF39bNBciIPMUhyn49R385-Qzc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehuddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhvedvjeehkefhffefhfettefhhfdvfeevjeettdduudevhfdtvefggffh
    kefhgeenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghdpghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsgho
    qhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqd
    dujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihm
    vgdrnhgrmhgv
X-ME-Proxy: <xmx:Cs_jY5Bb7xKEkz_HkUZ1whsDOK3-bWUFbEBbDWCxIVwG1XDH4ofMAw>
    <xmx:Cs_jY6ggMaE2DI8XrisHQgowznKqFZJFGRLclWxxYIt7DruEmi_5zg>
    <xmx:Cs_jY9pzCBHboaFvSXnSCyor_ZPOSL3ciYOjsYVnKfjJ2JNvnvlb7g>
    <xmx:Cs_jY67pfY6fUqvtM8LQTwfr-aU1W5vaWyDly1iWsEibMEdmAqzweA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Feb 2023 11:34:17 -0500 (EST)
Date:   Wed, 8 Feb 2023 08:33:57 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado 
        <sergio.collado@gmail.com>, Finn Behrens <fin@nyantec.com>
Subject: Re: [PATCH v2 2/2] sample: rust: print: Add sampe code for Arc
 printing
Message-ID: <Y+PO9SXyQaWgbQlK@boqun-archlinux>
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
 <20230207185216.1314638-3-boqun.feng@gmail.com>
 <CANiq72kyrz4efU5=MexgGNth1XxkU1z-GP6xVa7WxApB+PMdFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kyrz4efU5=MexgGNth1XxkU1z-GP6xVa7WxApB+PMdFQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 04:19:04PM +0100, Miguel Ojeda wrote:
> On Tue, Feb 7, 2023 at 7:52 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > +    // Uses `dbg` to print, will move `c`.
> > +    dbg!(c);
> 
> Perhaps:
> 
>     // Uses `dbg` to print, will move `c` (for temporary debugging purposes).
>     dbg!(c);
> 
> To make it clear it is not meant to be usually committed into the tree.
> 

Thanks!

> > +    // Prints debug fmt with pretty-print "#" and number-in-hex "x".
> > +    pr_info!("{:#x?}", a);
> 
> Apparently, `:#x?` is a bit of an accident: `#` means "alternate"
> form, but it turns out it applies to both `x` and `?`, i.e. it is not
> that `#` alone implies pretty-printing.
> 

Oh, good to know!

> Given the above and that there are improvements under discussion
> upstream, perhaps we could avoid giving details for the moment and
> just say what it does as a whole, e.g.
> 
>     // Pretty-prints the debug formatting with lower-case hexadecimal integers.
>     pr_info!("{:#x?}", a);
> 
> Some links for those interested:
> https://doc.rust-lang.org/std/fmt/index.html#sign0,
> https://github.com/rust-lang/rust/issues/75766,
> https://github.com/rust-lang/rust/pull/99138#issuecomment-1385331055
> and https://github.com/rust-lang/libs-team/issues/165.
> 
> Finally, there is a small typo in the commit title. What about:
> 
>     rust: samples: print: add sample code for `Arc` printing
> 

Hmm.. I'm OK with this change, but it's not a typo ;-)

I deliberately

1)	capitalize the first letter after subsystem tags in the title
	since that's kinda the rule for a few subsystems I usually work
	on, I don't have my own preference, just something I'm used to
	;-)

2)	avoid using "`" in the title to save space because title space
	is precious.

> I can change these bits on my side if you want & agree with them, to
> avoid a v3 just for this.
> 

That'll be great, thanks!

Regards,
Boqun

> Thanks for these patches, Boqun!
> 
> Cheers,
> Miguel
