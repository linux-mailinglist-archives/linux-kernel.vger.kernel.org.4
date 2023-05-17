Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18770734E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjEQUqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjEQUqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:46:12 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC604420B;
        Wed, 17 May 2023 13:46:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 432005C00D0;
        Wed, 17 May 2023 16:46:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 17 May 2023 16:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1684356371; x=1684442771; bh=H5p3BP+00Lki0ST8KCunOuMh2yeCMco3Da8
        MtFm9HVY=; b=JFcvxX/uWdNMopUO+m88VnjPjJ3KtApbFqPSs40JHvt/avaIcTV
        SLYNqZ6GQyfJ5KYyc3KHjgxCnEvkN501E+uix1qES69V0gGSlJFk/ubYM+wKOl65
        PUabT7LaaeSas/okYgydQoOAHre3tA13Ig+946NAsgckHdCIqt/4xXidwv+KXIk6
        lqWcWXVyf1n2HN5N94tMTDDuHHTE+Fu2rVx1ObrX+PZWhkcmG9Xsn3tOYTsZhI/9
        XmSZvhQu7q8E70SKTb4zI6U65+n2g4JfOwbTSpligfG0LNkI2tp5nQOAy9C1G8+k
        0twcsF1Ddn0cFxAd1wE28a0JB8U8abpiASw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684356371; x=1684442771; bh=H5p3BP+00Lki0ST8KCunOuMh2yeCMco3Da8
        MtFm9HVY=; b=HjwbxaQIUVuPzR+yx1BuwI0L/Ed5y5qiOdPOI/xw1qV8wOIOoTD
        O2QzvMDydtM/QIDcWjDCpXVr/14CFmhzP6x5i66zLf9DZHqe6EYo7AncncvgU/8k
        dSqS1KEZH1pjYAOi/AbdrmQLApbGmKlml7YDjXRNH6CCGFSjFRDQwe5wAmnBeCQ7
        9gbkV/cC5uvTNn5Vng3rAxXr/IP0KK16bkPMhwnRUsK58Ukh+9fpwPSPPJXKUO/e
        u5/MdblSHsRaDVnxQbEeNM0ivnpImv6bAU4N/Bu+QLpUT7FeRprC5eY/W/jYZpl4
        EFCLQdrsB5V3jsn7cFS0hnRZm759aRS31mA==
X-ME-Sender: <xms:Ez1lZPN3bbPbmLJxgPa3WVpVdQjsdKZZhFTtvWCuHKgSr0Gue86skg>
    <xme:Ez1lZJ-AWlU3it7qisrrGPV8I1tUY5edfFVacOGGCFK4v-q41fRrszD6P1YnJIGXe
    Km-nDpDUkLksEk_vw>
X-ME-Received: <xmr:Ez1lZOT1CxMXwAHgt3WTr8tfg8bEi1M2R1p8DH0nyoE9YtbvtqmydH0ibQCHNxy4x_peSvj8xwtJyfdxOm2Qy1YwFea0jOz_V6N2hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epheduuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:Ez1lZDv2FYY47GkaOLrbg9CeZjD-NHeJJzWseFkkiogWExjy_gZ4-A>
    <xmx:Ez1lZHedOjdnKXwJWUxJ6GAbZYbQU7HJND5vEUBMUlDutvVJioRYiQ>
    <xmx:Ez1lZP2RCAqoKGx2REGVVdS1d-MiOQb4teqspzld_OUPfXiuoOT84A>
    <xmx:Ez1lZL4bUQegvMyAo-v-92xEDhIPaURSKHwt2_CUVz6dUED8NUvofg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 May 2023 16:46:08 -0400 (EDT)
Message-ID: <9ee86168-f470-23fe-5e1e-47b984ca069e@ryhl.io>
Date:   Wed, 17 May 2023 22:46:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/4] rust: macros: replace Self with the concrete type in
 #[pin_data]
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230424081112.99890-1-benno.lossin@proton.me>
 <20230424081112.99890-3-benno.lossin@proton.me>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230424081112.99890-3-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 10:11, Benno Lossin wrote:
> When using `#[pin_data]` on a struct that used `Self` in the field
> types, a type error would be emitted when trying to use `pin_init!`.
> Since an internal type would be referenced by `Self` instead of the
> defined struct.
> This patch fixes this issue by replacing all occurrences of `Self` in
> the `#[pin_data]` macro with the concrete type circumventing the issue.
> Since rust allows type definitions inside of blocks, which are
> expressions, the macro also checks for these and emits a compile error
> when it finds `trait`, `enum`, `union`, `struct` or `impl`. These
> keywords allow creating new `Self` contexts, which conflicts with the
> current implementation of replacing every `Self` ident. If these were
> allowed, some `Self` idents would be replaced incorrectly.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Reported-by: Alice Ryhl <aliceryhl@google.com>

It seems like you're missing a newline in the commit message?

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
