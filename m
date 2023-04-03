Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113156D4FB7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjDCR5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjDCR5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:57:08 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4D91FF9;
        Mon,  3 Apr 2023 10:57:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D411E5C00FD;
        Mon,  3 Apr 2023 13:57:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Apr 2023 13:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680544621; x=1680631021; bh=kFfxasQMqACHhdRBnxpY8CNWnpG5XzzT/yB
        z49wzpc0=; b=VZRTxaNrDgaIaBViRoC3xzGTJiPlyTjoVaNUX6Ns6nV1sWKMHDk
        IkZ0ddIw6sxULWNXaxBJDrBePV47QGD7FDHJeAxkEdeGzWrLHjQnObwzaMWtY396
        2WVufl6fl+NfsOfufjUrqQ2nPQ/apBw95P0Yw05fEZ6Ju2s+ePU2X66nV12kku9g
        gULv53G1ghRCEgkFIMZos3ajsOaXz1+POgNa8Tjb11hJz0agiSioQIMnyyGO6YHV
        SsdmcgriTDZ9FJEE2g5FZXJNmZATfzLAvJ3e9XdzgCCq6uMfoazAceanoppfe5Xv
        mYu/JW/CPc7cUu5lAyyB/aqcBTKNlEEw9qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680544621; x=1680631021; bh=kFfxasQMqACHhdRBnxpY8CNWnpG5XzzT/yB
        z49wzpc0=; b=Hn26aqzc/D3AWDs+Wved3Hye70pWkPMDybsAvv0G7xEUMpgTxIp
        G/dHDAih0QFsuBRt6WfEumphKO11dAWdopRNPS5/j6zGzV5wT17KNWHgogcJbu8D
        J1BtCSgk/wMLoe0+MST4+HG8B5oFY4iUUHZHfvADJPQpPDdJtg1I+SpPH/VnAXiq
        lpsv0Lhbb2WOZuUpqUIOE8lTvrmt0itAnQlCVfWie0DKXxZn102gFZ4U/F8mNFIp
        uyrkqGa9WlrEcy6g2q5xuYopkrwpo6VWBTNFv49t4AzkBtDw4gSPXoBIgHDr4zTr
        NhKd8RURSHW/OFgEaFi7dPF4Awf5wMjU+1A==
X-ME-Sender: <xms:bRMrZOmetHZ01PsaCM2Te_BzQ15P0hm7IXTAIObxk7QuA2X4IjuKPA>
    <xme:bRMrZF0bb6btyZiKQojMYvjwRe3DVsBIrmmqLSod904C8j9-Dprm-9YxRia5qTvQC
    LnSKom-OEPjgrCA2w>
X-ME-Received: <xmr:bRMrZMqMAIe2V7Z1p-vyWh7id7WzEkLprm_kMRLRPmMKVm740AWkp9iWNYIrmCDXf2vgBcXR_iP-eu7MPJafb3gk3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    ephfehueeileevjeefkeetvdffveffudeuhffgtedvuefgiefgiedvjeegvdejleejnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:bRMrZCna1DSNis7VLlcZciuYae1V1yWg5GcZVvhD3WSdNq1dAORrYg>
    <xmx:bRMrZM19saLTA2xILoy7k3Ldiy8GE2bjqYC_7FSZM6k2WW3Tf31DQw>
    <xmx:bRMrZJtae_xjqByP7wdz7NjZ_gTAWBrrerhFkJyp1ksiAEE448tT4A>
    <xmx:bRMrZFsdVyOiZT6MHwx-hO4zLzfKsLJZuCfhddxexHgWZQk-ALCgXw>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 13:56:59 -0400 (EDT)
Message-ID: <320e4b6f-fbb5-3b4c-1e9d-009d7156239a@ryhl.io>
Date:   Mon, 3 Apr 2023 19:56:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH v5 06/15] rust: add pin-init API core
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
 <20230403154422.168633-7-y86-dev@protonmail.com>
Content-Language: en-US
In-Reply-To: <20230403154422.168633-7-y86-dev@protonmail.com>
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

On 4/3/23 17:45, Benno Lossin wrote:
> This API is used to facilitate safe pinned initialization of structs. It
> replaces cumbersome `unsafe` manual initialization with elegant safe macro
> invocations.
> 
> Due to the size of this change it has been split into six commits:
> 1. This commit introducing the basic public interface: traits and
>     functions to represent and create initializers.
> 2. Adds the `#[pin_data]`, `pin_init!`, `try_pin_init!`, `init!` and
>     `try_init!` macros along with their internal types.
> 3. Adds the `InPlaceInit` trait that allows using an initializer to create
>     an object inside of a `Box<T>` and other smart pointers.
> 4. Adds the `PinnedDrop` trait and adds macro support for it in
>     the `#[pin_data]` macro.
> 5. Adds the `stack_pin_init!` macro allowing to pin-initialize a struct on
>     the stack.
> 6. Adds the `Zeroable` trait and `init::zeroed` function to initialize
>     types that have `0x00` in all bytes as a valid bit pattern.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
