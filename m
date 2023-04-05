Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE96D8930
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjDEVD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDEVD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:03:27 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA03840D3;
        Wed,  5 Apr 2023 14:03:26 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t19so36277837qta.12;
        Wed, 05 Apr 2023 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680728606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iC6S0Dd2wld+hFfeTW38jpjfvqTCQBMPpfTFPRnn/3Y=;
        b=eVWI8JOB0Had3eImwcXP0NoKKQ6I2s3MyEt3DNSFiUrTVYCm104vOLyhAjR/VAT7ad
         PPEF/QAko3n3Q/io0d/zmQJO9DWimzOr4tkqXrygIY4InIIaKRjflbIRTosoplEZpPi5
         VpeDsFVvfttkDAb8JN8PZnOj69ZTtXTSGxuQ+KQlxc69faA1Fz33khhfMIW6MrzwfXVk
         UdOn736Mh8vUSwjQgQghEr61biqcyq6Z0p1OPTO1XVOpl7dRqeIj59y8+fqQ9qa3fPXu
         a+4sc8QFjNWCHRjGJ1cPwTaD4+4rgOxx0GH1AmeovU1I8E9li58kn0ZUCzioSp8keiOz
         YJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680728606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iC6S0Dd2wld+hFfeTW38jpjfvqTCQBMPpfTFPRnn/3Y=;
        b=3HthH86z4RxapDDaN23wnKQLyoQKUT06xpgOdNzgLxbHD4tHei6FrPqHP3FvakIdZp
         CjHe9scxRrGaC9FBUao+kJfTjPrV2uvAI2o1FZUG4k4a/JZb2EnXmiZZqzlhT4fIL54L
         WtQi8p4j9YN1qeaIomstHbxcYSfs85v/FCn4jiazSjAkjRspmBZtO++2/DMeIk4I7dOS
         jtLpYfZkufjCwEmmxPbYxpYa/CKIaLX60DTipuHeDAOVpLOgelKBysvjxdeUj0+XZhNn
         XzaerM3O+oOuCtpThCPzwutYFpvi0z0euLIxOByyS3cmkxSwkyotS9WjQsG76oBymGZG
         OUZA==
X-Gm-Message-State: AAQBX9c+PwC7aBH35PFop5+nL+udBL8nDVy7YOySnZB8c73k26PjEP4Q
        45JXxWT9VgZQrf0tTTJYdX4=
X-Google-Smtp-Source: AKy350aRL7IyXF1vZb82PW7LiWWRNpZCTqbPmjXNkeYpJSLW6nfQdG7gkP1VaMxaYraVyWiWYIVzzg==
X-Received: by 2002:ac8:5a84:0:b0:3d3:fe29:1caf with SMTP id c4-20020ac85a84000000b003d3fe291cafmr6902530qtc.0.1680728605725;
        Wed, 05 Apr 2023 14:03:25 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 15-20020a37080f000000b007485a383921sm4686543qki.116.2023.04.05.14.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:03:25 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id B2DCF27C0054;
        Wed,  5 Apr 2023 17:03:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 05 Apr 2023 17:03:24 -0400
X-ME-Sender: <xms:HOItZJx3fVNX-q2IeOqrKBXk2JG6hCxtnPdDBEUV7TLHwVlOCoxPEQ>
    <xme:HOItZJQxqBmoyZioJiw7SkqQWw41IRs7sgXxIOaEIEb6sL2pqq42fImUubknd_2Qw
    9DSzxr3ZhN2m4D7lg>
X-ME-Received: <xmr:HOItZDVs-AyUF5YGTsgSNUehQxxe4zF9XHAt7mSGv7Mmo3Kh_GyK3PXzdnlcDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:HOItZLgcvbIXFoL62LJyL9wrDorZ9Clnzd0Z_hXLuxkTbNtdzzrVbg>
    <xmx:HOItZLBONkhNe_qEkICkn9z6uSoGClmEPjxa3PrgDUDuA-JREaHHCQ>
    <xmx:HOItZEI9-DTwcujZQ2D63OZvZOU3c2UL6JlHXwy6K5e9_6X0PKFTvA>
    <xmx:HOItZP7sjfqG4TDmELTOvSYi6SQ1aIdrGJNI1XKAPkrIRyIIuVHuiw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 17:03:23 -0400 (EDT)
Date:   Wed, 5 Apr 2023 14:02:22 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v6 00/15] Rust pin-init API for pinned initialization of
 structs
Message-ID: <ZC3h3q+56gM8pKOX@boqun-archlinux>
References: <20230405193445.745024-1-y86-dev@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405193445.745024-1-y86-dev@protonmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 07:35:30PM +0000, Benno Lossin wrote:
> Changelog:
> v5 -> v6:
> - Change `pinned_drop` macro to allow `mut self` in the signature.
> - Change statement fragment to tt fragemnt in `pinned_drop` to prevent
>   parsing errors.
> - Move evaluation of the value in `stack_pin_init!`/`stack_try_pin_init!`
>   to the beginning.

Could you elaborate why? To make sure the $val evaluation happens
unconditionally?

> - Move setting uninitialized flag in front of dropping the value in
>   `StackInit::init`.
> - Remove `Unpin` requirement on `zeroed()`.
> - Add note about `Pointee` to the `Zeroable` impl on raw pointers.
> 

Regards,
Boqun
