Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF966F9958
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjEGP2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:28:41 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5324440E1;
        Sun,  7 May 2023 08:28:40 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C54C15C0053;
        Sun,  7 May 2023 11:28:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 07 May 2023 11:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683473317; x=1683559717; bh=jSecnGEXP3oKiemnPTucAF4AVP7Y26l75Iy
        Xcjx5H4s=; b=hi2GOU70BRy+g8KosP0q3kD/9mJbkAcYPR3alWPPSEMTx8/13K0
        Vgd0DQsexDyPuppf+vCgEP8OYFnAUwJk8SoRlH4TUE4MBLoUMRGdvwQ8HMnm/Yk8
        1qgHKs/lv1Pvdru65uLVuFiG9NNrmMLED/t1U7pth9FT/aJhrkl2BlpvpSaDOCy1
        psYz4sNQWZkLw+6MoYgudqYHtcVajUeHXv+CW9BvA5d70VkA3UaOgp24vYx9odCY
        C9Z2zw/60gSM3lT4oN5SIeju/zGBRv5fhGKTdcHoqJYxb2uWy9/Butj83nVmgraz
        dDmpvXniBYLrmspgl0OSY9D3V0uqOZ6v1yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683473317; x=1683559717; bh=jSecnGEXP3oKiemnPTucAF4AVP7Y26l75Iy
        Xcjx5H4s=; b=QUAzPGFn9Xi7NUWu4t9J09hSnZbUmKSYXbGA6a+h4/+eJPDMoUv
        1sG97gEmlIxXy8SxTqaZaC10gU/k9vArQpQXbU+BP2owSVon8MzY5ksUVLgx73mU
        rvLHDln0HpGxyOoVrtvislP3dC87IbSN2HhOmHcssYIahScXRiZYMsmU61IzZ16M
        97NBv0+ZvbvdYVemHaqlOu1yimIdfqnbB4WoorUXVjtVc/AhZNVnXUwbYjlXXGw8
        wXAg+xdde7ceLeGvu4EqVE/2uGJDpuQqcLtjAGtn95Rcpc1LBhwBHlTHhcR2EXWK
        Y4Zz2keOJuVl4d00Gn0aljR4qj5Clm1CTRg==
X-ME-Sender: <xms:pcNXZPRM-aJpRN_CqqIrT-kVK3mXmyEUiS0Vdbzig5XoYh8y0veWZg>
    <xme:pcNXZAwYLzCvRIj2yRyOOUePSs_DFFk5QF21SRZw0kblSa2tEovbi_fdgqfAXHDas
    Mn_xnJkPEPYg6iTQw>
X-ME-Received: <xmr:pcNXZE1dGF6knh09hfZ6OpizL_kjWDdWXhd01TXBJv4DYVf6vfQ3APgWABCmu5RLJfyuR-ayK2qFizNloF1GqPsodg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    ejfeetudeuteehkeduteffvdeviefgteejhfefiedvtddvlefffedtueeggfekheenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvsehrhihhlhdr
    ihho
X-ME-Proxy: <xmx:pcNXZPBTEgLQhlBISZI_1QEajWQBm9N8_YQ_FXEc3GLf3mXPUb3bfw>
    <xmx:pcNXZIghuxZeC9S8CXfqnNO-EW-1aqBhV--YrCmCJVrGd9lGeZirGg>
    <xmx:pcNXZDoTFCiGMp3KBKV-OZGmLr99iJ00QEPuPE-ZnpbcLIOI892zfg>
    <xmx:pcNXZLNQJNFGul_MutsXCTvr0WdgYENyVaflHdgJ3puFZCtq_w0AmQ>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 May 2023 11:28:35 -0400 (EDT)
Message-ID: <7f464c01-d4ec-d632-fa40-0c3f18c2ffca@ryhl.io>
Date:   Sun, 7 May 2023 17:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] rust: lock: Add intra-doc links to the Backend trait
To:     Ben Gooding <ben.gooding.dev@gmail.com>
Cc:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230507152232.803-1-ben.gooding.dev@gmail.com>
Content-Language: en-US
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230507152232.803-1-ben.gooding.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/23 17:22, Ben Gooding wrote:
> Also fix a minor typo in one of the comments
> 
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/94625fe6-b87a-a8f0-5b2a-a8152d5f7436@proton.me/
> Link: https://github.com/Rust-for-Linux/linux/issues/1001
> Signed-off-by: Ben Gooding <ben.gooding.dev@gmail.com>
> ---
> -/// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock backend
> +/// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock [backend](Backend)

This line is too long. Please reflow at 100 characters.

You can also consider this option:

/// Exposes one of the kernel locking primitives. Which one is exposed 
depends on the lock [backend]
/// specified as the generic parameter `B`.
///
/// [backend]: Backend
