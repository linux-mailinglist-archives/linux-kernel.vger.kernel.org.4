Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7306D0869
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjC3Og5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjC3Ogy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:36:54 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3AC5BA0;
        Thu, 30 Mar 2023 07:36:53 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 5C848320092D;
        Thu, 30 Mar 2023 10:36:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 30 Mar 2023 10:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680187011; x=1680273411; bh=mEU0nion2muXlTfUR8cesDV/AWMQCwWe/7k
        pJqZM+CM=; b=lOcePaeEvFUwkff08Ll9SURQYawK4c3C361GvZCwPNO8rSTU1vg
        srgt5wYHN1Yy40ktgnBGN0nd3E3TsYANDXNm9/Ozsp55ZAoFXN4VZ3Z2QkbhL6jN
        hdWhhPsgTK/DBP8IEvRTtPD1VsIKmszGKwp21ztfYvT4sWTWLUyIJ8CjdynUooII
        g7KufWKRbsCK4z+CVq0dUPvraGm8nGf5vU8R2FpDFI+RYwEiFzkQ+9HT/bBNFdCU
        AxeH8n1EkukN7daXHS4H8FpOOVPKr+08KlXq28/ENZIMDzWQlkqaOZblQ9qD3U39
        oJNz4/eioT5pmdrZdgYlKcvdrcHjObCryqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680187011; x=1680273411; bh=mEU0nion2muXlTfUR8cesDV/AWMQCwWe/7k
        pJqZM+CM=; b=U+1Ihw8g8cVw3w0tdthGsHQW7Sg73ShV9oapDg+bYlxpaITQJpF
        fOzcy6YWltiSJp9TFqtLRiS1R/PA20uF8f2t/j9oadz1isaD6OvLQ78TdlWRdYk9
        KrCAfDgJlou6E8VcCM/VNnLpfqal0YXiD1WyH6E/C2mLRc5dTpzsyDl9WCn9B5jk
        /kMZKcQjkM82Eb5yfrKFMZexfgV3jBChJXpnS7YC/P7asXQV2p5edjEZHOISA+eo
        AdYqnlQiRiERUpgPa7eubr1Pb/Wgdw7nkFgl8QKsIECfbQARGi5yW6JgrXd2dU1+
        Fa2accxo1rTadDmsrOUb2mUXjxJ0HO2akdw==
X-ME-Sender: <xms:g54lZOB8RWwbfUdP-D5bdUHz7zOyDrUybfCnvvu--9FMsli_EVmbHQ>
    <xme:g54lZIiHPS6I74Wp0Dh7Jq7xXPXpWwBN6ZFcL-ksCIuij_12u6j9DJF202M9Ou3Xu
    hZCi3edGxwvKr-sxQ>
X-ME-Received: <xmr:g54lZBk9t9Ao68W-pCXjJtsXJcL5u_F0ADlMyDtQ0_WH1viM1C4SRU3ftULEIMABppQ3byGBXy2kI0h4fD8Y6ELdzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehkedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudduvdetkedvkedtudeludfgfffhudegjeeguedvvedtteevjeehheeiffefgeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:g54lZMzl2MQKpXrn4Wletjsbn7txpcmKyElTTielHY319dlscAOaQA>
    <xmx:g54lZDTkIqtNEKVGhmUfiqhf2Sq8TorCRlfOT3kLjyyPaB2DY-tTkA>
    <xmx:g54lZHZ-uC-atbcq6IGYswS_zopJwyERLc00TctXQr1l-4U9bRRxNQ>
    <xmx:g54lZOGdA7QC66m6Firw3oWfIqCU-FJH5ikTynN7TOaPNNg9bbFZnw>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 10:36:49 -0400 (EDT)
Message-ID: <1f93a045-5bd8-e07f-cf1b-7b1196c8ab54@ryhl.io>
Date:   Thu, 30 Mar 2023 16:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 06/13] rust: init/sync: add `InPlaceInit` trait to
 pin-initialize smart pointers
Content-Language: en-US
To:     y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-7-y86-dev@protonmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230329223239.138757-7-y86-dev@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 00:33, y86-dev@protonmail.com wrote:
> From: Benno Lossin <y86-dev@protonmail.com>
> 
> The `InPlaceInit` trait that provides two functions, for initializing
> using `PinInit<T, E>` and `Init<T>`. It is implemented by `Arc<T>`,
> `UniqueArc<T>` and `Box<T>`.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
 > ---
 >
> +/// Smart pointer that can initialize memory in-place.
> +pub trait InPlaceInit<T>: Sized {
> +    /// Use the given initializer to in-place initialize a `T`.
> +    ///
> +    /// If `T: !Unpin` it will not be able to move afterwards.
> +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
> +    where
> +        Error: From<E>;
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>;
> +}

This definition is potentially rather limiting, because it can only be 
used with error types that can be converted into a `kernel::Error`. What 
do you think of this alternative?

pub trait InPlaceInit<T>: Sized {
     fn pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
     where
         E: From<AllocError>;

     fn init<E>(init: impl Init<T, E>) -> Result<Self, E>
     where
         E: From<AllocError>;
}
