Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CBB6E22C8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDNMCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjDNMCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:02:30 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE66F4230;
        Fri, 14 Apr 2023 05:02:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 620365C0056;
        Fri, 14 Apr 2023 08:02:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 14 Apr 2023 08:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1681473748; x=1681560148; bh=jmg3WDJnOye7aJxA4k2ecYkrHqICWicLafd
        h+i740ss=; b=JA6lhI2UPYHwIx1gZKnZCxV62cD0efkjJ5sq1CxM0MP2SVcVOD1
        bGGz/7UKX22jDpKakRQzmn4YlYaizNWRK76Uilw2yytd05FGveEb6SuV8onYTLuT
        xRwWnK5ApYZxhZy7uO0dvQhJ31Exqb87E4oxCAfR1mM8ikHbaJ87R+s0bC17jKxP
        XG0JLu11cLbXIUSSKrgQnSC1wWLkFXN7r6SWvAE97U7nS8KRIBlisWCBsEou6K+/
        ZuDWjVk1lxc2ARbgDc++dt1DM7l8/iDzdNcj0oxRb1bJWIBViL7Wr0CMBYHLpAVC
        EeqnfXD2/JFCh4GKF8JrxR2HdgPhSWIFHww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681473748; x=1681560148; bh=jmg3WDJnOye7aJxA4k2ecYkrHqICWicLafd
        h+i740ss=; b=FjpZJ3v5V1wLMCnCXEwV4kPNJT+v3YN5//KeTHlX7Nbvq34CyMS
        kl8brX1IUsmOlQa3ACyEYBTAr/ZmT9uAJAMOgyg2zRBFC+M9/D/M5OpN9heVinKA
        G6mejKXatUIMuau+rAynpqQsRvn2B/Va5zz4smxHSgaGy1Uv5e2RIk6CXw4ZC9YZ
        rqds8m7dcM5KGAMiyo9LNnyTn4A1JuHmhbCJZRAgMbJVTk2rJ4fBcqn0OBcYhKj9
        NAFPHnfGuCef+WqZQ08qvJ4ME1cPjBwJBfKHekLvZ9/Vz5RB6jYRUI1liZfl+ISw
        lnCM2QIkBB+2L8C09XUSaBpPhQO5PenNl3g==
X-ME-Sender: <xms:1EA5ZF_Ugv0Afu98CF9HAQxrynkMy9ZWLuvBiLQRK_Iv99F1YB8CoQ>
    <xme:1EA5ZJviC-0F_1dq9Q4x1Q8HoLU7ulR1uWSywJTShULsduMD7or_RH9y94KPZWXNQ
    Obr2gpojehx_1iHUQ>
X-ME-Received: <xmr:1EA5ZDAW6-O43CC18kFAHqIT4D6__L5FmEq_tjfYM6qWK_oaPgk0_Wd9EF1CKye9aoI-CmdfFZcldkvkXtF-FnXOGw1u-RUEFW8zNH1QyV2B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    efvddvgeelgfdtjeegteelgffffeeljeetiedtveeghfeihefhteekgedvfefhheenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghlihgtvgesrhihhhhlrdhioh
X-ME-Proxy: <xmx:1EA5ZJf-KpohgFDa3HoLQCecRrOg0ZbO217uV_L1N93gfsvlk4Ck_Q>
    <xmx:1EA5ZKPUgSZG4kNvDPXKX_goq6m5SXERmoPhaKD7jaNKDe8EpEBiRQ>
    <xmx:1EA5ZLmXfOsHOxkyCFliaebGTNyeTGPZW6Imk-qBaDBEBOo8WHwo0g>
    <xmx:1EA5ZLjqS_prlWR54jRTW7x03gqNbsNDYkRAEoYweVYrtuueGH5L0Q>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 08:02:26 -0400 (EDT)
Message-ID: <5628890a-a975-9283-7ce7-969d1501de1f@ryhl.io>
Date:   Fri, 14 Apr 2023 14:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 02/13] rust: sync: introduce `Lock` and `Guard`
Content-Language: en-US
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
 <20230411054543.21278-2-wedsonaf@gmail.com>
 <20230411214205.5753343f.gary@garyguo.net>
 <CANeycqqM-k2odQzNffaYQ6Nrxii=XUp3VsQ8mQ3vw=WA5mykJw@mail.gmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <CANeycqqM-k2odQzNffaYQ6Nrxii=XUp3VsQ8mQ3vw=WA5mykJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 13:38, Wedson Almeida Filho wrote:
> On Tue, 11 Apr 2023 at 17:42, Gary Guo <gary@garyguo.net> wrote:
>>
>> On Tue, 11 Apr 2023 02:45:32 -0300
>> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>>
>>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>>>
>>> They are generic Rust implementations of a lock and a lock guard that
>>> contain code that is common to all locks. Different backends will be
>>> introduced in subsequent commits.
>>>
>>> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>>> --- >>
>> There is not drop implementation on `Lock`, which implies all locks can
>> be just forgotten?
> 
> Yes, all locks can be forgotten.

Are the locks not pinned? Pinning comes with the guarantee that the 
value remains valid until the destructor runs, so the only kind of 
forgetting you can do to a lock is the one where the memory containing 
it is leaked, meaning that its not a UAF to use it after forgetting it.

My understanding is that the issue had to do with forgetting the guard 
types, since those were not pinned.

>> I believe we discussed a case where this is can lead to UAF when a lock
>> is dropped while it is locked (e.g. because the guard is forgotten).
> 
> Yes, this is the issue brought up by Boqun:
> https://github.com/Rust-for-Linux/linux/issues/862
> 
> The issue arises when a mutex guard is forgotten and the task that
> owns it exits. Then another task trying to acquire the mutex will lead
> to a UAF. A drop implementation on the lock doesn't solve this.
> 
> One solution is to increment the refcount on the current task when we
> acquire the mutex and decrement it when we release, but if we do that,
> the cost of acquiring/releasing a mutex gets much worse in Rust than
> it is in C.
> 
> Another solution might be to force disable CONFIG_MUTEX_SPIN_ON_OWNER
> when Rust is enabled, which is undesirable because it affects the
> performance of C code as well.
> 
> Even a closure-based lock (which I believe you suggested at the time)
> doesn't solve this completely because the thread may exit during the
> closure execution and leave a dangling pointer in the mutex.
> 
> So we don't have a good solution for this yet.
