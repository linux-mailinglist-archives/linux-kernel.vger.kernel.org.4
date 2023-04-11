Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617806DD4D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDKINV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDKINT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:13:19 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC9A172C;
        Tue, 11 Apr 2023 01:13:17 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A97DB320093C;
        Tue, 11 Apr 2023 04:13:14 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute6.internal (MEProxy); Tue, 11 Apr 2023 04:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681200794; x=1681287194; bh=NJ
        boNri+CC288UTjop87+vyXFr430ZEANuDrQsZnXeY=; b=A8xSBfNLcC7ifYpR5w
        ilzah4OcNCEAY2OMMa2EWT9kt8vCEYhySANOxaUIxYjIb3oMR/wpUs5yTIO+Zi4a
        wPB4LjqyHv3TI3UfEry43Dd5zyCsm4on2XX1ZF1saImtcXW0bP4of3ZLkFcc7t0P
        jEUoO4NKmDErwNwdKfE2bGeu9svO3TI/UcHfMJVZaCHHpun3bg5swh2u0Bvxzvd/
        +NeiJ0+boR5jz6OqCDLjHk75+YFqBYsl2tjmEDyvpDU370lc/wrpoAQ8EboNyLgx
        WkgBHjvTfvmZG2dOPtBeMFacgl6QACH8Ny8di+qYMgKuwZ+XlAiX/I1cmIWXhik9
        SoiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681200794; x=1681287194; bh=NJboNri+CC288
        UTjop87+vyXFr430ZEANuDrQsZnXeY=; b=HdAcjAALSgWwNNliFkrpvS6tg+SsA
        0NWqmOY5EkNTmylvUjrzgYAuYapvuBvzxSmNTCjcpaAbMHFWkbJjZSM6AYYUi5M4
        jmrZrdvvOyi15m+hHTnAC1GoBFrEBj7jfMEEicZzEVYEkK4Ey0oKM4RWmjQNUCbH
        HZ8xAfX2xo3bqLvcV5CJMxTRdayeQZFSo3+KvHxMDbkXQEID1B2Iqdn5pMgIPx7i
        GGCGkhlmflnVGE0tcIP3A3w1rBWCTWXdwHuMmK+7eM46sN9rjAgxKTd0bti3Tr7Y
        3Cr1GVniMTasf+CUFRyHCDw4gRKsusRZXt8NTVLQZNVMISMXrcBZH3gBw==
X-ME-Sender: <xms:mRY1ZEx_sDPdYJ-HwCxwJS0zVAXoW1Hp3ouByHKQoK7TVfKFF96eqQ>
    <xme:mRY1ZISXih7G4MmtPHMWePa77rT54hLgXP38rIozOc4rrqhVRfCTE6bDTDsdKlFKE
    IQJ8FEP2CS_eP7Txw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehl
    ihgtvgcutfihhhhlfdcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrh
    hnpeehffehfeefieettdelhefhkeegieejheeljeegffefjeevjeekveefgeduhfejhfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitg
    gvsehrhihhlhdrihho
X-ME-Proxy: <xmx:mRY1ZGVzM6J5wkHuoUJ88hmBbkhCme6MWlJ25scb5NaMNRMNNHatug>
    <xmx:mRY1ZChMlIUfWHzbLKMLQl8SG99oD6MCS0ccEY4ewHM5qLkJqrDX2Q>
    <xmx:mRY1ZGAhtD3AJkBPTa-1tSCs7JFjKNhEOERJjqg4ltYQY7m1ul_wbA>
    <xmx:mhY1ZK7L5cJogUYljaFNT4FZj2wRQYtj6q5fp8SsvyI4wUUhIoq9yA>
Feedback-ID: i56684263:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A31E9BC0078; Tue, 11 Apr 2023 04:13:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <048e6799-d7fa-40c0-8419-513a2c70a5f1@app.fastmail.com>
In-Reply-To: <20230408122429.1103522-14-y86-dev@protonmail.com>
References: <20230408122429.1103522-1-y86-dev@protonmail.com>
 <20230408122429.1103522-14-y86-dev@protonmail.com>
Date:   Tue, 11 Apr 2023 10:12:53 +0200
From:   "Alice Ryhl" <alice@ryhl.io>
To:     "Benno Lossin" <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, "Alice Ryhl" <aliceryhl@google.com>,
        "Andreas Hindborg" <a.hindborg@samsung.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Andreas Hindborg" <nmi@metaspace.dk>
Subject: Re: [PATCH v7 13/15] rust: types: add `Opaque::ffi_init`
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 8, 2023, at 2:26 PM, Benno Lossin wrote:
> This function allows to easily initialize `Opaque` with the pin-init
> API. `Opaque::ffi_init` takes a closure and returns a pin-initializer.
> This pin-initiailizer calls the given closure with a pointer to the
> inner `T`.
>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
