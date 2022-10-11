Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416A25FB0DE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJKLBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJKLBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:01:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5468A7F3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 04:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAD5CB815A3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FA8C433D7;
        Tue, 11 Oct 2022 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665486105;
        bh=7QbwsFF5lAubiJj42U1xHr2EmoYsGUiK17Ub7u1HHxY=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=I3Si+ttKkPoSDW7TYyQ533VRzs4Qlb6t5piGO0X5r+XvJfnpPfWBe4po87ICIksq2
         VDg5E4MNtfmKifA2EDzEqLW5AHv2pDiF45+HxByRTuQnA0m/7+hWqsK/GBiu0RBpfW
         z8dPvm9I317jNAddPCcwleDSGmGU9WlxHjzCMfgcZxGvBV9y5YztEL/qmF8WC+Z9wy
         e8sARtrNTZe9rMbgwd13U4pDtQEO1cp3doDcRpVLVRfFR0dhC47B1AgrLpphETXBxd
         JSHgkI6BpvAsyO/IO6dA4Jie8KzBcU2WvHtiFqgcziNuOi3tB5XDKyb+tXDYaUKUFj
         M0XRYGEpF19XQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id C8D7F27C005A;
        Tue, 11 Oct 2022 07:01:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 11 Oct 2022 07:01:43 -0400
X-ME-Sender: <xms:F01FY39VVrKkp6Gcdob5Ww1Q8QTryg9jAuAOUa6USe73_sIAhN4Wuw>
    <xme:F01FYzudnLoStHTWi0IHmbAU0pXQCg7YUuvk5VL-DGD3wHvgry23qicPDfeI9dAPh
    xre1CRFcX3vXYILFu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejiedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnheptddvteffleehffeghfeileetudekuedtteevveeuueelleelkeevffef
    vdeigfegnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnug
    eppehkvghrnhgvlhdrohhrghesrghrnhgusgdruggv
X-ME-Proxy: <xmx:F01FY1BMtj1nvvS8mU7Umpm28npxJNfM0akKvMH1IYzUGu_MPnBr3Q>
    <xmx:F01FYzfK0Q2JTniQVRWDcnM8r0YdgCOONrKT3y_FHFtogz4ebSaiaA>
    <xmx:F01FY8NH-LbMAFA4gRbS60PZuJYd-qmw8mdmbwNv1fax9w-c-ugpVg>
    <xmx:F01FY9FQXJoPs3F8ugL4ik94U-E70n0stlpqD0sDwLKnddrxzDVjS_NOxqM>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1FE6FB60086; Tue, 11 Oct 2022 07:01:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <679c0129-ca59-47a4-aa83-f79ec166951a@app.fastmail.com>
In-Reply-To: <20221010225342.3903590-1-ndesaulniers@google.com>
References: <CAKwvOdnQ-tWa0oY0CKAwJD5WQDgVBvxDtf6=E3hS8Ytz5J1OKg@mail.gmail.com>
 <20221010225342.3903590-1-ndesaulniers@google.com>
Date:   Tue, 11 Oct 2022 13:01:22 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Nick Desaulniers" <ndesaulniers@google.com>,
        "Russell King" <linux@armlinux.org.uk>
Cc:     "Tom Rix" <trix@redhat.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Ard Biesheuvel" <ardb@kernel.org>, "Gary Guo" <gary@garyguo.net>,
        "Craig Topper" <craig.topper@sifive.com>,
        "Philip Reames" <listmail@philipreames.com>, jh@jhauser.us,
        "Nathan Chancellor" <nathan@kernel.org>
Subject: Re: [PATCH] ARM: NWFPE: avoid compiler-generated __aeabi_uldivmod
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022, at 12:53 AM, Nick Desaulniers wrote:
> clang-15's ability to elide loops completely became more aggressive when
> it can deduce how a variable is being updated in a loop. Counting down
> one variable by an increment of another can be replaced by a modulo
> operation.
>
> For 64b variables on 32b ARM EABI targets, this can result in the
> compiler generating calls to __aeabi_uldivmod, which it does for a do
> while loop in float64_rem().
>
> For the kernel, we'd generally prefer that developers not open code 64b
> division via binary / operators and instead use the more explicit
> helpers from div64.h. On arm-linux-gnuabi targets, failure to do so can
> result in linkage failures due to undefined references to
> __aeabi_uldivmod().
>
> While developers can avoid open coding divisions on 64b variables, the
> compiler doesn't know that the Linux kernel has a partial implementation
> of a compiler runtime (--rtlib) to enforce this convention.
>
> It's also undecidable for the compiler whether the code in question
> would be faster to execute the loop vs elide it and do the 64b division.
>
> While I actively avoid using the internal -mllvm command line flags, I
> think we get better code than using barrier() here, which will force
> reloads+spills in the loop for all toolchains.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1666
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Works for me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I would have been fine with disallowing NWFPE for clang, or with
adding a barrier in the loop as well, i.e. any approach that
doesn't cause invalid behavior or a maintenance burden, given that
there is probably nobody that actually needs nwfpe on a clang built
kernel.

    Arnd
