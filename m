Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA796D4FB9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjDCR52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjDCR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:57:17 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8A73A9D;
        Mon,  3 Apr 2023 10:57:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A8CCC5C0050;
        Mon,  3 Apr 2023 13:57:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Apr 2023 13:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680544626; x=1680631026; bh=zquIB4O70SLQT/QPGcACFv3gsmoOH4kMknn
        BEMc9nds=; b=B60GAjD9jzWAK6fJX0WJP2dXxBM4Q97zwSQSJp9q/rahF/nL9M3
        CXPonV4yiWQeFht+LCghiTs7b2sK1ORSr1BQ3dYjX2jmeM3Azh53nVAmwBdrSgyl
        3wFLgn/ILoaOoEcdZ30CbbKgFmBwlGpW2b43fgQu+7bAYT6tgxpPFBB6Twc9SDex
        hdAcPe8hbGPFs9iXATZKaIxi0rlqXIrCd9LedFKFQQXAQcR3RFzJNFxaF21bAbRM
        uYtn1ky0QIFwt4UveZrCY82J9oY6wysRUIP8UUAUzo9ePCE+VjtmPlXuzoeFPwaT
        kya1efmE67m1ZaDrLVItudBfCDzj074k68A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680544626; x=1680631026; bh=zquIB4O70SLQT/QPGcACFv3gsmoOH4kMknn
        BEMc9nds=; b=GBIr/QT8ZO07yJXys6q/tRl0kwanzQMUAgKlPP8kJUXBdz/A9LO
        f9uLTNvrlAXo1HrR3MJ+MSwpgbW7bqs4QgtjagRXaQZZ6wLmJK4XTFTFxK552nry
        bA9aZXwqFgPY+QqRvjxUlR0b7mnmJq5B+tfn/T6NEtuKzho4uh2RX+c/kb4HNXZd
        IylElVnjWTAqD5XbVj9UZFEk/ix3ewZijWdUSW42X7+76T0+sScieTT6UlOnOZIo
        vatm1PYMmvQjHluQiieuNRlTLr+tzMy3H9ejzUg3ZUO4s9srfBpIDsPlDTBcw2ua
        bUmmcW9+Sx4ETT5CZNDXPvW8gxlE3a3JkBA==
X-ME-Sender: <xms:chMrZDWNpUQv_TGV42TiXawP7r1M5Y_rFopOtzjTL_12VRjq6ILX2g>
    <xme:chMrZLnZLGI92twqpi7Fw4BciiL3Nf4e19uqfz8emEFVVhq-RxRC1rZmvvadS9VkD
    fhZbuUdqSx-HF7RVw>
X-ME-Received: <xmr:chMrZPZBoTRQ7n-Wu3Mg_-0ASt7nkQuDiaYXznpDEuTP5QmaK-4DhEfMjl9_1INlc7pmFvq2wIZI-XbUHn9Qo2URhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    ephfehueeileevjeefkeetvdffveffudeuhffgtedvuefgiefgiedvjeegvdejleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:chMrZOWFl7HfLJ0FHoJM3VYM0S1CFLPmG-U5QZepIpX-tVxsM8Oxxg>
    <xmx:chMrZNmELwEldhw7Q3zoyjPKhjCxR4RMV63IvE6vqjtl-uREONfP9Q>
    <xmx:chMrZLciiVl7ln5ZLfR7syke-SLk75gjmFNEhelXKVPw2QAAlu7Bgg>
    <xmx:chMrZGf_1M7Ng53T3Tr7HaMogqeiveM_iYJP_Z5-SyuG2UNfaD-AZA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 13:57:03 -0400 (EDT)
Message-ID: <62df1021-ad53-9fd9-d8b8-cc7a21ca36a7@ryhl.io>
Date:   Mon, 3 Apr 2023 19:56:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH v5 07/15] rust: init: add initialization macros
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
 <20230403154422.168633-8-y86-dev@protonmail.com>
Content-Language: en-US
In-Reply-To: <20230403154422.168633-8-y86-dev@protonmail.com>
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
> Add the following initializer macros:
> - `#[pin_data]` to annotate structurally pinned fields of structs,
>    needed for `pin_init!` and `try_pin_init!` to select the correct
>    initializer of fields.
> - `pin_init!` create a pin-initializer for a struct with the
>    `Infallible` error type.
> - `try_pin_init!` create a pin-initializer for a struct with a custom
>    error type (`kernel::error::Error` is the default).
> - `init!` create an in-place-initializer for a struct with the
>    `Infallible` error type.
> - `try_init!` create an in-place-initializer for a struct with a custom
>    error type (`kernel::error::Error` is the default).
> 
> Also add their needed internal helper traits and structs.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
