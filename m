Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9FF72ED27
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbjFMUi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbjFMUi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:38:26 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6074D1BD3;
        Tue, 13 Jun 2023 13:38:23 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 045EB5C01DD;
        Tue, 13 Jun 2023 16:38:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 13 Jun 2023 16:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1686688700; x=1686775100; bh=P33YgGs6OZIxngy95+ozg40+5//7kMaRyYq
        7qJmuQ0Y=; b=V19y85sgevW88E/PFN9v/F1+YVpGMdvbUVD0n3A9QLbv/t4ggdx
        fw7Ln3P72JE0ABvWtQuBS2R6YlQA4Eq70QIT5LqZmBuHpjby4OmeMhiCtkozpOEJ
        isgjJY/lh34zvEpBV1Z4/CW5cp3EDYA/HZdxzXF9VYQA+wofHiRCgYgJQ54zvmwR
        SeNkBNm/7ZR4/4B8UF5Ki8R3sDVwdd1mlvGhEb6LX8lChxzw0/Jh1DQxBLvGEZc/
        CfBrVfJLlQLH91C76fal51snoPUVJNtanOKUhUKvLxe62hFgO+IkhW5m0AMNAVfD
        LVjdljcDWfml2BKaRQI1/2luAPugXAb2trg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1686688700; x=1686775100; bh=P33YgGs6OZIxngy95+ozg40+5//7kMaRyYq
        7qJmuQ0Y=; b=nHa/66Y+wkQDCh0Wtfo2//OBIhTgEOcWP/DmmAx7S4hQKyJoVdt
        KCO/wG9lGDo7SkZ2TOSfeIgesthOvTogycHk+ZN1Hg2hWyparr8Rsmzj9ih+a9r0
        FdkN3ZeFMaUcCgXjdJTGH6zZH7DdRQUdQ4qtTxSm/447fUQKPzvoLN/XqsSLL1YL
        0WetCgimt5guRex/vPx+jQ9pV5aT9J243GAdUsHziUGrs5u1mvxx24kAt0ZuGPGI
        2kW3mq4RBBP2mHw7D2LmaBZj6Nq8yrNFW3enGA3Z4ureMSrt6fVvgJiMb8+nyDPi
        07h02Q9Sn1DY0vEvDxP8O96KJ5cLeKctTaQ==
X-ME-Sender: <xms:u9OIZGKB-fNl5wKjbRxQ70Qqk4T0R4s1N7o78m_56qL-AaLh79cP5Q>
    <xme:u9OIZOI-yJUuaF4lrSYivKEb2VLOeCQtS0AAqX3PHWFHMj2pWAplfxMg5iIrC-7eC
    YylJd5BdelYuMwyTw>
X-ME-Received: <xmr:u9OIZGsqepqJK1qiYkFpNK-NS2GSRgLFMmeofcMoxjY0gkU50MAmHsixY1KZQs3n1qudT5KRlIEknxxhzJhjXCS6pXNpERMvdoHkVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedujedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epheduuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:u9OIZLadp7E579akjkeELsSYg5A3wK2HJm-ycQSR4KdnTN1kjvuW2A>
    <xmx:u9OIZNZuG7BOL2S-IodW0U_RiAwZQQhlfOFke_I1bs8bhFbUxi8KrQ>
    <xmx:u9OIZHARceM2EZCJbJvekfCMg7RuKCIhe4a4msJBKkIFV2k5V4JniA>
    <xmx:u9OIZKQ2pmnuAUjHwtrSiovuaDYCQ0Cg3Nx_dy-UBn7Gq3d6So6Y5g>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jun 2023 16:38:14 -0400 (EDT)
Message-ID: <d31dac7e-671a-1741-5f13-c61624bceac0@ryhl.io>
Date:   Tue, 13 Jun 2023 22:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] rust: allocator: Prevents mis-aligned allocation
Content-Language: en-US-large
To:     Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andreas Hindborg <nmi@metaspace.dk>, stable@vger.kernel.org
References: <20230613164258.3831917-1-boqun.feng@gmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230613164258.3831917-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 18:42, Boqun Feng wrote:
> Currently the KernelAllocator simply passes the size of the type Layout
> to krealloc(), and in theory the alignment requirement from the type
> Layout may be larger than the guarantee provided by SLAB, which means
> the allocated object is mis-aligned.
> 
> Fixes this by adjusting the allocation size to the nearest power of two,
> which SLAB always guarantees a size-aligned allocation. And because Rust
> guarantees that original size must be a multiple of alignment and the
> alignment must be a power of two, then the alignment requirement is
> satisfied.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Co-developed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
> Signed-off-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: stable@vger.kernel.org # v6.1+

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
