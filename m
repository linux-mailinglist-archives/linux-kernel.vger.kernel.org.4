Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546616D17EC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCaHCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCaHCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:02:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5A7AD0D;
        Fri, 31 Mar 2023 00:02:05 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C6C165C00EA;
        Fri, 31 Mar 2023 03:02:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 31 Mar 2023 03:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680246123; x=1680332523; bh=shvdN2nfnBWD0iXHq3tvXVrBe0NNSqWsfGz
        SZUWzcEw=; b=eqn++UeMd//IXWXBTpJ5urhnqaOBFYchAzzK5f4MHCOljSDDV14
        VWmsRjbi4uaNcZ2xiYEAEZ4iIdT1qdZB9GCk7jYN/zeXWfFG3OBygcT2CBLLBBYM
        uxc+wFfIWzif9oLx1UxnZ6o6GEDRgGMe+isQj9Fn4H7OeR8seWTOkcW0h5+ZaIqF
        F1mJMJsdJkWrasufxkTVoqVxlBtKzGdg4pn0zKIX+uhYWs5qK7GUeIqt5Ty8Gfdb
        Oj+WcpPKEY8WGTJYApn1RO/O2D8y2qCcIaZESX4alZEGTXpp0+At0zfHJJ8rB1m6
        SIk7vWEmfZOFRu9QshUs+46mE1qrDgmotnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680246123; x=1680332523; bh=shvdN2nfnBWD0iXHq3tvXVrBe0NNSqWsfGz
        SZUWzcEw=; b=kC6xXnlWez/V4qx5MUmqoGwWHQjroCB9LbfBXcNvzNOLDLvePuM
        Q1Z68fmjl1/1LuLHS2p0NWJ5QK/26kceH0hfCpe6FQ0H0y3vkR1lU2PIwiwxyoEn
        7zhek1TPgg5FXZf1M5eIZiPOVq7X3HFHjTKtwv9biO6FfI9XlavgZ1lFCbo0pSc1
        g6hy8VbMJVP9MDmNhpyA/YW0WyxZELe7xiSwg3CP5dpI3YCptwV2UgLJPx7fLrMc
        5tP/Ve+uS4FDZaLiE1YNwrBvd6IpcfG2hPrh5bFjypYAZ85LcBoBSJaWZNTOC7H8
        tvuuEuhvTS3IslTk09IhTaYXCP9SJNifTqQ==
X-ME-Sender: <xms:a4UmZNYyK8nLbHhOMysfC4B5JP-mTTqUApXnZ3GHjpWOUrlG1o-kaA>
    <xme:a4UmZEYFTzDattSmwWDoy5TsLomAlQdUi9p0Ld_VXIUyCkPIop00sWY24BRFxk5jr
    cSGr7_n4nsqNKZyJw>
X-ME-Received: <xmr:a4UmZP96Shjf5LtfZCKhj6MIk8QyVHKguMajBKGVz8Fct1E98eZAYAiDVvVMXb9VlPll2-jnroZGS5cSZiZIqC1dwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeitddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epheduuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:a4UmZLrkLgwnxpzod9x9vdN8GwRXCl-rHjWd0BoKB1W9B4s4JhxheA>
    <xmx:a4UmZIpDMrXyYJ6WY1Sp9Bm_JLFU4L55L7ZbUmW5g0EVVdGtAjzFhw>
    <xmx:a4UmZBRaM79oSXcfThqZjgtmMxdVCMVjcfY8MCCbx_HrBKu-E5VG5A>
    <xmx:a4UmZEchGlP1AmlpC5WDulvOOQskBIsfdsnb0PXownhbISg4xaP_Ew>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 03:02:01 -0400 (EDT)
Message-ID: <1e2a3b59-cb50-9c78-a7a0-829c2d500e4f@ryhl.io>
Date:   Fri, 31 Mar 2023 09:02:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 11/13] rust: types: add common init-helper functions
 for `Opaque`
Content-Language: en-US
To:     y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Gary Guo <gary@garyguo.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>
References: <20230329223239.138757-12-y86-dev@protonmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230329223239.138757-12-y86-dev@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 00:33, y86-dev@protonmail.com wrote:
> From: Benno Lossin <y86-dev@protonmail.com>
> 
> Add helper functions to more easily initialize `Opaque<T>` via FFI and
> rust raw initializer functions.
> These functions take a function pointer to the FFI/raw initialization
> function and take between 0-4 other arguments. It then returns an
> initializer that uses the FFI/raw initialization function along with the
> given arguments to initialize an `Opaque<T>`.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviwed-by: Alice Ryhl <aliceryhl@google.com>
