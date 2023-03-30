Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0A86D06CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjC3Ndi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjC3Ndd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:33:33 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4763EB755;
        Thu, 30 Mar 2023 06:33:29 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 216A7320093F;
        Thu, 30 Mar 2023 09:33:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 30 Mar 2023 09:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680183207; x=1680269607; bh=ezMXuHjPOuB03SV5rXQnVOkIW3zTOsXZBD3
        Pms4ZoFQ=; b=D5NtLpss8uAL/03IG6PLmC3H7cETTT79AlovkrGLkR9jdHsrVdq
        YBhCNK7qyQ5uWtC4SUlQODWY4P9NU8J3N/LAgIlqV68joAZS+l/4xylbGq3QSjei
        Qrs6sCaLjlii0j0IGOHdRNEb2IcaapGtZWx4zSohBmzuhGOfng08uAy9x2jl6zdl
        TE2uzM8QxEabdr/ZYQ0HJ6dPh84OdZtn+dvISi0Z3RMwD2nJb6Ar16AnbArWIk3x
        697+1gkcglz2hMot5NHPD9ydj6KnLC5QwMvzvUfWFj6XgvTxAGaQWJYIZEDxLEZs
        rC9lIvRV1JKYQe8yWAXszO7ONDvWNNiYjig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680183207; x=1680269607; bh=ezMXuHjPOuB03SV5rXQnVOkIW3zTOsXZBD3
        Pms4ZoFQ=; b=QiPOnrFmyxGKjs2VW4hlskcEjP5goyNOb4fYwsVJ+sTzcZGaJm8
        JQKXhdM3Cfr20M/iKYdreiP5rAg04iWM/7cVZXqKRVSvfe72E0hF2Z5MwJqNd9r5
        TvTxy7wczeNjQ5ZiSXGlBJSgs7JUs35d7A3fmEwNeO7OS3m0HeEof9B7/8eP3TEE
        aUQ1P8LN4RV1ah5y/JvFFBvnvSBtpS/7ZP/PQw3IHvnFwE3IIpwDjGiDcYnXNXfq
        PfpdrBVz+0OwLUbJUn4rFmLd4zChkr+KIVK55O9QQQ9Ip7gKtmlwF8Lw9QmSsk8n
        mmssMz463/ZLT1+gyfTGMNrs568LRxEMI0w==
X-ME-Sender: <xms:p48lZJLaclz1qwzkiD1JDlK3r8Hq0qeO91T99vt4UV9UrFNip38NHA>
    <xme:p48lZFJY1O-yaqi_CLZZ-Ihm_lCWfXxy9rK7P1PBk9k0doGnp9nIe93hftfWOZ5Xv
    nF497RWuJJpJ1eZ5w>
X-ME-Received: <xmr:p48lZBufu2NQghc-T8WVtRiGDrQh-O0b_vBo-LYJ66NdMj-Zlrpf-yRC5MxMlyAmTDZ0R-7YSnlzXSKLbEXQ5-oA7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehkedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfhffuvfevfhgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    fhheeuieelveejfeektedvffevffduuefhgfetvdeugfeigfeivdejgedvjeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:p48lZKZsnGOwxR1HpkuHCjUH0uHkWpZ7n6AwGtTSM_0yWXbxTbpTlQ>
    <xmx:p48lZAYrg0w8KOF4K267XOKTFccbLare1h9Q0p5-G_cm2TkvuJUuFw>
    <xmx:p48lZOBR78or-ylmR_U7dHE1zPalNI80TJwaofC6Iqj-PP-3Q9PI3A>
    <xmx:p48lZGOEzDknxZHWF1aZt7SqVdY7PhNTHSr2XroO1d86Dq8lotT3rg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 09:33:25 -0400 (EDT)
Message-ID: <e40bd476-13c9-73cf-10c2-a1c1cb84a043@ryhl.io>
Date:   Thu, 30 Mar 2023 15:33:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH v3 03/13] rust: types: add `Opaque::raw_get`
To:     y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-4-y86-dev@protonmail.com>
Content-Language: en-US
In-Reply-To: <20230329223239.138757-4-y86-dev@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 00:33, y86-dev@protonmail.com wrote:
> From: Benno Lossin <y86-dev@protonmail.com>
> 
> This function mirrors `UnsafeCell::raw_get`. It avoids creating a
> reference and allows solely using raw pointers.
> The `pin-init` API will be using this, since uninitialized memory
> requires raw pointers.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
