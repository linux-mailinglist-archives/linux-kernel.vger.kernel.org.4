Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8B66D0893
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjC3OpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjC3OpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:45:06 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8A86A42;
        Thu, 30 Mar 2023 07:45:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 879B1320093E;
        Thu, 30 Mar 2023 10:45:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 30 Mar 2023 10:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680187503; x=1680273903; bh=eEEZ+8AfxYs0SGGK+yrFh1itzbAaHrsVMFs
        UFFMshlo=; b=pfxN3IQjKzzMo0Ixa0+GXvS7zmYXHkbJBNrNDYsCCs30dB1EIv2
        vzO/B6wa06tdi8ZFO70TBX/8CpP8a66//bO3CF316ALp6O+gQyOOnHS2wETx4xlP
        DUNa+Rlx+JOEUBeatPX8Jb9jcKg1+toPj6PXFEHmSHn1JIbwnIAvHeF4u/u/nkaf
        x70N1rBGhYuGH0TWiwnAeTtFS2QD82qmUnWKviC2+iiJoUor/HFUNQaSr71tTAul
        KkGnDPjEUkH+vif4yn7Bz9vOFFUwEmiQMG/LRUUPOJ4Nlwi/czrOTxwzHwkz/Gpy
        RqdHs2+oyf5y6arkAIG884+pT7siHbDUoFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680187503; x=1680273903; bh=eEEZ+8AfxYs0SGGK+yrFh1itzbAaHrsVMFs
        UFFMshlo=; b=Dd1oKzSkUlSptfN3q8E81cbrplV2+wGgYzYTmsa+KYKJlu3AfJ6
        3tISYeksof/Ekt7lNAnOSGIjhnZvvsjzyZYWBS0ToQgq2qUqZ6Cq0YmGbSMOqGaw
        V37TDr4psdRb6aYJnQSRW2LCjQGdwzDFnWLV8JsC6K0X/Ce2sgbWOMoqyAyWzZAj
        Rep3y5UVerTAVHABpBlRY1c5ZHW9F7JPXMdgqo1zuDol0lbemLF4d/xykcQKhg4L
        h5koENzeteiz+7/DWuNBbiPSUGf9kJQ2mztBBwX0tdAMMHwcVJgmsk32SxRl1gYj
        6GJw4sY0qdVmd5me352RBlTQcEn/ii5VZwQ==
X-ME-Sender: <xms:bqAlZNd1BgzlxjB0BWTut3AqYlH1jBKy_Q2-QTAP3Oy7tQrI0QOzRQ>
    <xme:bqAlZLNyyUh-Rt4gTZql8fUVOK8J8SAS1bi9NPSmjTa2unqKYa1BX5T0BlAeTyM-E
    6wUUaMCkXUXbZ_Y2A>
X-ME-Received: <xmr:bqAlZGgAN-n5qfb8mG0KolhUvTXzNDot2PEdUOS8riF29EuWMJZTrMqmgAtpBjIvnvfw_5pE0YxCyB4rpPB95nKWvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehkedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudduvdetkedvkedtudeludfgfffhudegjeeguedvvedtteevjeehheeiffefgeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:b6AlZG8IjIsS-t5IHzWxFJ-mwIfNBfyJ8H2juHjnBtdkwmVthw-NRg>
    <xmx:b6AlZJsVy36bplWAHqxFP_Zd5KQERPF5e0Fma9yW_khj3EHOJtlguw>
    <xmx:b6AlZFERrEce4MrwEvlivLNYeGFahM5Bpm8G_6mH9HncoAZaf7kkzg>
    <xmx:b6AlZPDSxgveiF_p_M5LKhFJ3DouKldEJG0nsItMJhy8kHRzp3O8UA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 10:45:01 -0400 (EDT)
Message-ID: <a31d0ea3-710d-8ac9-5be1-fa268a7aa36c@ryhl.io>
Date:   Thu, 30 Mar 2023 16:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 07/13] rust: init: add `PinnedDrop` trait and macros
Content-Language: en-US
To:     y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-8-y86-dev@protonmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230329223239.138757-8-y86-dev@protonmail.com>
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
> The `PinnedDrop` trait that facilitates destruction of pinned types.
> It has to be implemented via the `#[pinned_drop]` macro, since the
> `drop` function should not be called by normal code, only by other
> destructors. It also only works on structs that are annotated with
> `#[pin_data(PinnedDrop)]`.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

I noticed the same thing as Gary with the name `create`, but otherwise LGTM.
