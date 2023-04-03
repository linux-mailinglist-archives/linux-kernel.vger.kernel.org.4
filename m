Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF72B6D4FB4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjDCR5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjDCR47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:56:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E3B359C;
        Mon,  3 Apr 2023 10:56:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 165E95C0130;
        Mon,  3 Apr 2023 13:56:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Apr 2023 13:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680544613; x=1680631013; bh=d1S59PhxnSj4AeYVzX+B9aGqvJsridFhmS7
        IXjbfIZo=; b=KZykcpbBuIJLw9Uo/KL7sPShQgMgLCvpu3Z+NwWljc66P4xKOv4
        BBfOzuXasuB+7U7COdKKTDN8wnG4E5A8o6zKh0OLDEt5ZALAk7nsN1U+r/z7bzDC
        cNNuicBQe+EfMr2wgxOjgQlGWk5Uu1Y9JIsmvvkUszmQn63xuoadF7v5VjYw0B4b
        D3xemzxPYSW16eLAmzT4+Oelsuex72THHpPhZ8aiMlNhJdycC51SnWqDd14S29tu
        iaa+DZyL9h/ZLwbhb1TauM5KU2mVTzZ4PaDL2NJ50oGBwitYqqpRDrwbi8vFIsKW
        +6RGE6fu9NHxLO47ZDkylcQ7vhKKBdZBaLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680544613; x=1680631013; bh=d1S59PhxnSj4AeYVzX+B9aGqvJsridFhmS7
        IXjbfIZo=; b=FeneOD923NqNa8Oc5AB/Uo5uVwnHd2eynK+6giVE3gOpMXt9YdL
        fK+E6TMjjOi0ktaeNthWLMlo/C0k745F5iwrZD/gUJKSdUaayTxFSbsHWnJ2u0rq
        vl5L9CYKEdlLKuVijGBFj3/X6yr5peA3VwNmvxn9gTo5gb5ZIjUftoBJF9Ba154m
        +gG6+l5NY0JKepTyqTllFqY+9b4CqjPugpJLPZsDLQNbs0E98hoGIvAzJllyKKYp
        7eG7azKvQ6f4KAVC+/v+DQx+PNh5PIdti8uyRTVKME49nhf5tJH9EmipVXdVqFNC
        /0JyBs9xSAyT4uDCkKlwLy2sDhnL8/0cE6w==
X-ME-Sender: <xms:ZBMrZCsGPSVrz1pbC5O4IHjZYLD0wmGytDyJzdtGXVfY85wLDdHoJQ>
    <xme:ZBMrZHdeIPB5hr7uApbYAXbUMEMpoq07iem5AxCTlw9ScJAf1O_wCZxaoYhCg8hh3
    HiZAqIaEFx0G2Egxw>
X-ME-Received: <xmr:ZBMrZNx6u5Fbj9vlHVv0s1gilYsfbW2r2A6xZ30Zfuw8zyQ4-DBjLsQLG7x4usSc7fjR3kwAOrgCgbCkC3MrQNWdnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    ephfehueeileevjeefkeetvdffveffudeuhffgtedvuefgiefgiedvjeegvdejleejnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:ZRMrZNNj6MzEpyZBnvqI6qq7R15sNd9GqarSZjbQ_jdK3Zs9inAbeA>
    <xmx:ZRMrZC_XaUX4WwBpZMAFdJfree684Ap1FvEyF2aB3gEAII99jofGng>
    <xmx:ZRMrZFV1n0d8iwL7aEoduc63dPlQEtzozbQ1lQmsabr7Y3h_1JUZZw>
    <xmx:ZRMrZD2TQCVoF9Cg2TBkB-EYGxBJsWwl7Tf6G0emjX6IcY6POfqDhw>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 13:56:50 -0400 (EDT)
Message-ID: <40ca0d4a-a46f-787f-d227-1d64cdb3adc3@ryhl.io>
Date:   Mon, 3 Apr 2023 19:56:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH v5 02/15] rust: macros: add `quote!` macro
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
 <20230403154422.168633-3-y86-dev@protonmail.com>
Content-Language: en-US
In-Reply-To: <20230403154422.168633-3-y86-dev@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 17:44, Benno Lossin wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> Add the `quote!` macro for creating `TokenStream`s directly via the
> given Rust tokens. It also supports repetitions using iterators.
> 
> It will be used by the pin-init API proc-macros to generate code.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
