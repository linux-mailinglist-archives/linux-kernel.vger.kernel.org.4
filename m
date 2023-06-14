Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72854730219
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbjFNOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjFNOhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:37:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D634BE4D;
        Wed, 14 Jun 2023 07:37:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 51C635C010A;
        Wed, 14 Jun 2023 10:37:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 14 Jun 2023 10:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1686753420; x=1686839820; bh=jc9ujq43JBUFnTtaQ2eqgsCeobbT+I566SB
        q26GvICE=; b=QzVkbKjILQuShB1JLrgex/3GM/yDLdIh98NXn4pSo+gmoz10912
        igAKEkhRS442Xe3m4BFCKq6KXD5BtD1qcTTnkZrdAM++2/yu0org6DO6SLpXsfDm
        l8Dcy1ASkv0gXpYtLhM4dFrEEYKU+/hOrNQjyCQwJ9kutO+eFPmL53kCB5nnoAS7
        3NSwU05VEcs/wObXN/0sRaZ9SLpMlArGT0YqNuIhY4mvle9eKPUmwImsydQ4j8sO
        rvsp+FD2hitG+rGtYAAmD4XHJUtHQEw1md4f10oM2MikBeV/6aeL1VjTghoLZQkR
        as9k8Xj4TXSotiGEM0cafPEmaTr8zwHcjLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1686753420; x=1686839820; bh=jc9ujq43JBUFnTtaQ2eqgsCeobbT+I566SB
        q26GvICE=; b=qFOXJYQ0s/rWnRv08KppoLGlIiFqYXgRZAYDg+KGuvUxylX02oP
        A7pr6kyHuG0OozAmQyre3IetLhkQh5iaFF2t0Z8JFTxV8Rqceyb0yF3ebzLeh4S6
        GmRtAsCb42UY4F3+JTVon8a1YJ4H1qxuLQVB4/S63igz72ZgruI2tFAW6I2m0Kzc
        Ob17ce5rkVGiC4DTmIvPAC6jwSWnWI0xmSy/7kFBVPrc4BvH+lG91tvbhKGTpUa1
        iS0WsT4QE8lEcw+wz+QXJkCo2bXEP1vc8eNLCL3K3KyfS6WVQ2NzqkkPzOfSgxQV
        xKC9mIlNLBMg39GpcpVq0KJR79fVWmm/htg==
X-ME-Sender: <xms:jNCJZDnYOPCjnqjl8qTdnSITXgDmUnsb7W6ClqB9bNcuQQiplxcYOw>
    <xme:jNCJZG1i-WSBuQ3Fpw0SDvli_TagKhg9drg0txPzka4ul-bxoZMm0NKs0lGNU6yye
    vw2cxvVpEdunI33vg>
X-ME-Received: <xmr:jNCJZJoueUZf9IBcxPAI-KM7kIo3K1G7SFNsg3bqxeDj-Vl5ndmHgjACfjQpsGtH4s7Li88CYIo0nX6E1okpabR7pNJRZBTB0LC7zFXHpaPm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudduvdetkedvkedtudeludfgfffhudegjeeguedvvedtteevjeehheeiffefgeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:jNCJZLmfUqh503BTJoVj1qAxksyYiXC_Ve5VzlmSuFrq1SZpYZj3-A>
    <xmx:jNCJZB38fc8TP-ueT-S6fCqUeFm4ON7166_H6m1o9qWfB30JOGE3uA>
    <xmx:jNCJZKsCyZqWmwhQ4nBg2yv2d6gQ-a9OUSWv-5DlRxKvxfZnmm2ZpA>
    <xmx:jNCJZKLxmOwRp0qwsql8eh26RJwiHxav6aEl1FhvSQX9yIIu9C1QXQ>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jun 2023 10:36:58 -0400 (EDT)
Message-ID: <77089cc6-233c-9329-a994-95ae6d3d07e3@ryhl.io>
Date:   Wed, 14 Jun 2023 16:37:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] rust: make `UnsafeCell` the outer type in `Opaque`
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230614115328.2825961-1-aliceryhl@google.com>
 <zirWeKUZRqFhiN23v0pXHMmvuceI7EZyVvNUiREGf-UNbIbXLrHjbC8diUNg9v802jbX1978ezQLDCl--1M5S6K8l7CVWs8JGB-znEEMRNE=@proton.me>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <zirWeKUZRqFhiN23v0pXHMmvuceI7EZyVvNUiREGf-UNbIbXLrHjbC8diUNg9v802jbX1978ezQLDCl--1M5S6K8l7CVWs8JGB-znEEMRNE=@proton.me>
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

On 6/14/23 16:27, Benno Lossin wrote:>> @@ -258,7 +258,7 @@ pub fn 
ffi_init(init_func: impl FnOnce(*mut T)) -> impl PinInit<Self> {
>>
>>        /// Returns a raw pointer to the opaque data.
>>        pub fn get(&self) -> *mut T {
>> -        UnsafeCell::raw_get(self.0.as_ptr())
>> +        UnsafeCell::get(&self.0).cast::<T>()
> 
> Is there a reason you don't do `self.0.get().cast::<T>()`?
> 

Not really. I just modified what was already there.
