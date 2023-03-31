Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA596D1815
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCaHGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCaHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:06:17 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7338A1CB8D;
        Fri, 31 Mar 2023 00:05:52 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id F37B05C00EB;
        Fri, 31 Mar 2023 03:05:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 31 Mar 2023 03:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680246315; x=1680332715; bh=jwSBLhduLUSok4WjC4KaatdQySnT3Bd+oD4
        A9p2QnUE=; b=EZP9geKZrG+OZyfI4TI1Aa3sc0Z1fpqPyhDugA5v/1XwD3/FURB
        /hV8UIBEMKi6Htr0AaDf68ZnBBB1EXq22YhulDDaqT/S5yJ8ol1k/KQhvljqcrz8
        B31a7/GKKPn6w0mQMKo3Adm665w5aMkYXH3YLElV9vcigVp5wiLRe0ShF3OR6xXe
        75rhMwVx8pmdpFmP0HQ2ILz5/ctQ+zrLIgM0+LyZ+n+n2PcqzgY6Hc4BblA7kh2L
        Ij2wTQWDUzAsfSmlar8J7dS8bLUnrRZ05YNVnp9suoSC5kjDbruJYTmZaXgGXRvq
        Qrq9gqEuVJr+/asg+n3pi59fc0aaPX6o6eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680246315; x=1680332715; bh=jwSBLhduLUSok4WjC4KaatdQySnT3Bd+oD4
        A9p2QnUE=; b=PUDx69DxCJgwkSqMb+t8dPBlxQDBgRsCaubR2xHmj/OBZtLxmWF
        EsNVt/qW4Zm+7wIOb6NL8pNluwZD0B49QR2UMXFnjVDz9ywBgH7CiF3qV74BbY6B
        iUHL/xCydlCU76kq6gGMBP9KHbp2FUdICebC5cYlzQNuSktOnB46wSvJVh0HizXE
        pg1fy712nqsnJi0E0W/fPEM4yGsZy3L+WruOBjrTQwYCCleluNGSVRLUUezW6JVg
        dBykvsZMSmLLbIBES68XtE51ssnePbCcxT+fEorph5W35gvXJxCR45UbPIIooQFv
        vctTEuGJqxcj2RkCvAE9MysvUF3MnJ1a7Dw==
X-ME-Sender: <xms:K4YmZLroYsWFyJhxAYOX8aPhgRoQJZMTcIgkE0BSz2VkCMOyzu2Blg>
    <xme:K4YmZFpPogfh9K3LCDIxLh3L7_PdF5pKANOmm3tuDRygLq93h1EhfiOsXQ4MP1fm-
    PSz8HzagDvoLjeGvA>
X-ME-Received: <xmr:K4YmZIP9vj1UzgbRN5hEO5MBeNsEq3q8AlDfzRUhHIAVr3frW0UuCBX_llMp4tKJXS5sLaQo8FBBTs55pYabKkVcjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeitddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epheduuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:K4YmZO4OvXX5BJBgkddE-DFupTfPw90qwyjkv4zIl1yE4P7gE-bp1w>
    <xmx:K4YmZK7zlGB27qXRAZLZTdH-dE2-B9DJUWpyfT-B-fZ_S_qDUvdtvA>
    <xmx:K4YmZGixqPsHLcBuB5EBohhytD_pXNDM8lGq0nK304OZpcxmgzcb_Q>
    <xmx:K4YmZMtMhGL7ivK_R3sytFuUnzLH4TlyM2QWR_DpoX2zpZdDxITzTg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 03:05:14 -0400 (EDT)
Message-ID: <3c628166-b836-4ea8-bc4b-d25902e75b49@ryhl.io>
Date:   Fri, 31 Mar 2023 09:05:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 12/13] rust: sync: reduce stack usage of
 `UniqueArc::try_new_uninit`
Content-Language: en-US
To:     y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230329223239.138757-13-y86-dev@protonmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230329223239.138757-13-y86-dev@protonmail.com>
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
> `UniqueArc::try_new_uninit` calls `Arc::try_new(MaybeUninit::uninit())`.
> This results in the uninitialized memory being placed on the stack,
> which may be arbitrarily large due to the generic `T` and thus could
> cause a stack overflow for large types.
> 
> Change the implementation to use the pin-init API which enables in-place
> initialization. In particular it avoids having to first construct and
> then move the uninitialized memory from the stack into the final location.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
