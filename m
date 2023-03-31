Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DE96D1819
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCaHHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjCaHHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:07:30 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390A8B474;
        Fri, 31 Mar 2023 00:07:29 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AA8D85C0154;
        Fri, 31 Mar 2023 03:07:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 31 Mar 2023 03:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680246447; x=1680332847; bh=rxemviTxQCpkhXo4VLRQYc4IouO2iUewwIc
        BnZ0fzzg=; b=AkSQ0A72qoPHTG95ZzvlksyUwHzzQHUad2CTA62UEYRhlccy+AD
        PyXmxTmKrbQSqaJRZT+4Y+3W6ofmlhxciNtn+EHuPoJ3lYom6dlrGo3dUcgDr+us
        xkonW9fYGRHLP+gBU84gQQuN4l9eNqliVImcivHhKqpQJirzGEuZL6qzt+mVXBlk
        7BoSfxx+HR0Bj0AsYz6l86qRueLOHgKLRiTT9xAXJaktj3qImbSTXKFmyASRt0G9
        LpxVsDSC+v09i8uThYVh/YiAaurRGhrKisoTplqeks2wkQqqP+YDbvOKMqz2urp8
        qFGYiaCRkyumBUI+447P7+wM+zfiden5ObA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680246447; x=1680332847; bh=rxemviTxQCpkhXo4VLRQYc4IouO2iUewwIc
        BnZ0fzzg=; b=W04vL5WmfTRCudlEXPwluwZ0CSsMYsIZBTDnuoaSUzKL77QiJCP
        MNd3YoKPt/7ZfuzxeoxiZTabs1Lzfb7vpwImDhRUZdE5x4noo+TH+K0oHgRD3gxF
        jkt7cAKoGFH+YbVcflUKf1cSulewjGA1n+oiZhXkGBoxY1OQeLNX446U1q5GubOF
        BC/J66HyBMlifbsBX5iAz/hwx2OmV6cWyF1c7c180FQr8SCWyzSHUruhKe9NRumb
        Nky9X8iEMpUZ2Bh+vciSGhhsiy15XvNLdm6nXRjWq8Qv6rfR/Q0y4p5Opn6s9T5k
        jePtaogMp+LGzqJtceYiEMWlAkTldWuL3Iw==
X-ME-Sender: <xms:r4YmZLwLQWJqcGE-Ay_e9Tn4wfoiPyYr52mX7i2-jwF_oFYQ_7SyDQ>
    <xme:r4YmZDQDg2d7Y-klJM12gex_S6B6U9LQv47f2LvBci0-9seMJrun9KvzOx_o3lBi3
    T9PGlPBPaUdGd_o7g>
X-ME-Received: <xmr:r4YmZFVt-cqxpr1qj4mHI10h79_JQ5YnFgdHWuMQmV1F7coIJGWWv9pdy3t0U7Tf0eoNb0Wsk-mvKqxU8ZFgZ5gOgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeitddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epheduuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:r4YmZFhXrUlKswsRqOM0QORQcvND2pq_6M6iJDRkyYEZPbEITeKrWg>
    <xmx:r4YmZNAEqywi8cUrl59SQoa23C7RVl1aRL1g5yJj5YSCrZEIa84CuQ>
    <xmx:r4YmZOKIyvtPevjN23xaaRVFjnymKqNpvsXmwcoCsOkQjBSCdbPlRA>
    <xmx:r4YmZB1VYh457RROXCbrYS8n9TmZ_xOV2H6YY-J8enYsGjmEC6sKLg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 03:07:25 -0400 (EDT)
Message-ID: <2943263c-4a6f-4d5f-c841-6fc638d5eb87@ryhl.io>
Date:   Fri, 31 Mar 2023 09:07:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 13/13] rust: sync: add functions for initializing
 `UniqueArc<MaybeUninit<T>>`
Content-Language: en-US
To:     y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230329223239.138757-14-y86-dev@protonmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230329223239.138757-14-y86-dev@protonmail.com>
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
> Add two functions `init_with` and `pin_init_with` to
> `UniqueArc<MaybeUninit<T>>` to initialize the memory of already allocated
> `UniqueArc`s. This is useful when you want to allocate memory check some
> condition inside of a context where allocation is forbidden and then
> conditionally initialize an object.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

I asked for this one because we will need it in the binder driver.
