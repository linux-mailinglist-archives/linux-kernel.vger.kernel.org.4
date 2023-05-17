Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901AA70734A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjEQUoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEQUoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:44:12 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747543C26;
        Wed, 17 May 2023 13:44:10 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E51BB5C0127;
        Wed, 17 May 2023 16:44:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 17 May 2023 16:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1684356249; x=1684442649; bh=HovA2aBrCor3Q17F+fDmTxCq7878dGESxOg
        v5brW2DI=; b=ZsffjI3uEeF+t/uzV2g3STC5DstwGCRuQEDKvVkH7ZOALum0286
        SXFdXre5fbazLr+N3CPihlLFPyHoiW9zMhiP/VUZuwAfe1uxXS3cxU0xu4rdSasV
        n2Ml7dc2eIlQBLYJlXKPlzOR92/UZgFZ7BOwldk57/nC+oMA2tTzsvfEoRX+SK7Z
        xZ4HJ9tUxNOZg6007DNZ2kmaJBWynfvtA289w65CwW7sgAuDMJckQUk4/lfvPf73
        vhpSepxIc/w1jSu6n9hGB7ep+y1QqTlpVRRUqDbp77PwXyoQc8FYuN3hnmWx/+Gf
        VzANIxFRVOW1GUY2FpPAo+iqXZ9vL+Z+fRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684356249; x=1684442649; bh=HovA2aBrCor3Q17F+fDmTxCq7878dGESxOg
        v5brW2DI=; b=WC8QymsV4iKtF3Cia6Ed9KgbRCQCvKqdutOhGkeTjlQkqe3cl/i
        wmGh2lKvTq6OUV93dETusKxDT2WmHQtogUgf+P8ubZZPOskKllDfrjLTmqoAtgHw
        lWNY8HVbX0NSE0sgDVc/6Uw6cL176hsc1hEzn+NxYyWvkDamujt/qFArdWRtdqLU
        XmnuKHvVUGkQFeQVXflv1xwk4CcvuhzhxIR5BQQP/YEOEagLzAwefQGGUQiOeXAA
        fDBHMV1XzFqKrnuTzGhNO/qtqisDvzqSq9hsKNY6RLEtfAUbD9Uf3IJd/tAxtPly
        aVt6B0CgJIP6ueagrsVzeO6hh1YRXJSmpZA==
X-ME-Sender: <xms:mTxlZEx5TRfkfJjYF5Wdk5IYfDcedg6ZnsKwpuO2u-rr8DZLh4QCCQ>
    <xme:mTxlZIQJ_YjykjmV1fx5Vxh_vCAw9QzWhy93azMoozpPqpkpdI7LBlf9umxX7grTk
    IjzaY9wAITXDob3Fg>
X-ME-Received: <xmr:mTxlZGX9Wd9SHasYTWzw2XmMyd_VbWr5MaPHFaBEH_SiFV8zZvlJxm03P3QMhRCdhRgZ6bO_uyqx-Fzt_5ZtmU3gc7MxWP3VqVQbOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epheduuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:mTxlZCgO-WYZxMPYwHVjLK19K8he_k4303GfrjwsJkWdhkAsAkxGSw>
    <xmx:mTxlZGC75pNAJsUt2QKWBj9BuVkD2gZqpP_sDjmKk0Ux6YTr3Q2Dag>
    <xmx:mTxlZDKk_MLcRg8UmQfk62XbnW9JN2uc8q3fzqjk3yOZBwUuPGOlSA>
    <xmx:mTxlZC0JR1PyGU_iSfvOp9bgdybmJAHgnKfM0nGhGFqIJNMyynyasA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 May 2023 16:44:08 -0400 (EDT)
Message-ID: <3532c544-7804-3dba-225e-69a7fb8418c4@ryhl.io>
Date:   Wed, 17 May 2023 22:44:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/4] rust: macros: refactor generics parsing of
 `#[pin_data]` into its own function
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230424081112.99890-1-benno.lossin@proton.me>
 <20230424081112.99890-2-benno.lossin@proton.me>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230424081112.99890-2-benno.lossin@proton.me>
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
> Other macros might also want to parse generics. Additionally this makes
> the code easier to read, as the next commit will introduce more code in
> `#[pin_data]`. Also add more comments to explain how parsing generics
> work.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +/// Parses the given `TokenStream` into `Generics` and the rest.
> +///
> +/// The generics are not present in the rest, but a where clause might remain.
> +pub(crate) fn parse_generics(input: TokenStream) -> (Generics, Vec<TokenTree>) {
> +    // `impl_generics`, the declared generics with their bounds.
> +    let mut impl_generics = vec![];
> +    // Only the names of the generics, without any bounds.
> +    let mut ty_generics = vec![];
> +    // Tokens not related to the generics e.g. the `where` token and definition.
> +    let mut rest = vec![];
> +    // The current level of `<`.
> +    let mut nesting = 0;
> +    let mut toks = input.into_iter();
> +    // If we are at the beginning of a generic parameter.
> +    let mut at_start = true;
> +    for tt in &mut toks {
> +        match tt.clone() {

Do you need the call to `clone` here? Not a big deal either way.
