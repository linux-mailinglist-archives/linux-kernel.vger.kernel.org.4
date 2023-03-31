Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DFD6D188E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjCaH2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCaH2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:28:21 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1621C768B;
        Fri, 31 Mar 2023 00:28:21 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 813DF5C019A;
        Fri, 31 Mar 2023 03:28:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 31 Mar 2023 03:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680247700; x=1680334100; bh=5MJfRpO+dCBuD2QslsP+SHMLwF08YAQPZ56
        IkAHTbT0=; b=XLCxyHafha+KRYaz/Xp/c2jIG4Q+V18mqz9L5W1fhQmGBqiNlVv
        7j8vZ3S2AfG2SIClEEwMv7/XC/htYnuvcNqoyvGmXvn1kkEcxINFNicBjBRQVVLF
        iz5dqgp2RnxKOfKrMNsgjDDcU4qaZgFwWQKgHvC8HEzGQ/PApmuNRid0QliTgM8m
        VTAgWxBxi6Xg04e06wSVFrAaP0aiK+TrjiLvuXr05lPb7IFlie0a87o7c4nj6VeV
        rSPs4e3fzbP4KRQoZdWQV/XAx+sPwRdSV8/NBFhX1E1DCVZmmY9e5PK4dvWblkWw
        +dhK6oSscSztWdpueJsQ6qjmb0tJgRD4M1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680247700; x=1680334100; bh=5MJfRpO+dCBuD2QslsP+SHMLwF08YAQPZ56
        IkAHTbT0=; b=EJLBUuFHcas3fEMOIEwV1AgefTVcrxPr7G5wkugubuV37eS6RAa
        efX7mMYC8+3sqk8AA49pe82WX9VmcT3ne1QCMd6cQrfi0InVAnKBot02MZqqBqDe
        fVJVIOcSz1e/u2okUC3yMkzdH5sJmzx4WbVpaUWRcApRs9slc06IHn0ZHUPYWC1h
        H8XmEloTjTJOBixeKvYpKYZnVXsLCtLD9eZyq6lqd48NaYXwMjeXFIOCWlCvozMt
        0UcRBMz5rryBbkjj2vwMAVn6FmaoDxFkxZ5Z2GkQNMTGs+4tt9H4OvREMjVTK66F
        WXffatQVyvoTXT2jxT6gHgUGXXs/m63o9FQ==
X-ME-Sender: <xms:lIsmZCxROcorE8JDboyMqAa1kUmw8MhJF81dq2tEn1gK6Kzm79OQgA>
    <xme:lIsmZOQz293jC9gSf9RLEOnHi7JnSJdnEIUd6JmTup3O6SvuocmXWLZNPLwmBSQ27
    RoatHC-cd92rF-lIg>
X-ME-Received: <xmr:lIsmZEVIhOzhuglxbgFY2fX4PUVeJtbM0MmYGig7VwTPJot4z4cse7xw5IxCWOZajjJ7HNvFIG1MOqePXBHEWMet8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeitddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epheduuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:lIsmZIgvwEfrWPsWIPGu0p-K9ekXvkV_RqMdh5d7sS4f3gs0mIPoPw>
    <xmx:lIsmZEAxLDUknQKkN30GQtdqg44a4gQykjPgPvlLcB1We5HGsFLNMg>
    <xmx:lIsmZJIU97-7qVrnswYonGot2ZcQyzppuw2-pG98gfiwcAOw13tdPw>
    <xmx:lIsmZNJvo_yQqazjeEqlR6tVruIKuGSFCUgPyxh9kjUMGjyz4g8Q5g>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 03:28:16 -0400 (EDT)
Message-ID: <1cd137de-6ca0-a079-429f-6cb964a0f811@ryhl.io>
Date:   Fri, 31 Mar 2023 09:28:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/13] rust: sync: introduce `LockClassKey`
Content-Language: en-US
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230330043954.562237-1-wedsonaf@gmail.com>
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

On 3/30/23 06:39, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> It is a wrapper around C's `lock_class_key`, which is used by the
> synchronisation primitives that are checked with lockdep. This is in
> preparation for introducing Rust abstractions for these primitives.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> +// SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
> +// provides its own synchronization.
> +unsafe impl Sync for LockClassKey {}

No Send?

> +
> +impl LockClassKey {
> +    /// Creates a new lock class key.
> +    pub const fn new() -> Self {
> +        Self(Opaque::uninit())
> +    }
> +
> +    #[allow(dead_code)]
> +    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> +        self.0.get()
> +    }

I would just make this pub and drop the `#[allow(dead_code)]`. I think 
it is often useful to have methods like this available publicly.
