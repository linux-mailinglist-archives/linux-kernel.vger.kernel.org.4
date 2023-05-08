Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1EC6FB84D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjEHU3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEHU3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:29:08 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B3149C3;
        Mon,  8 May 2023 13:29:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C8025C0121;
        Mon,  8 May 2023 16:29:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 May 2023 16:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683577744; x=1683664144; bh=G+jMg55hOCbbocEq58MWNDAQoerhosGi6pJ
        guyIM6MA=; b=UUMbwrGeXkFMipqOEKf0dX+bYnqTaHbps0bjOM5+1ODVYLW5Sxv
        Ig+gcOoNtgT9js4RcUG4lY3bnS+O4v2cQXUP3PLuGETZWYDfood/lfgvht+Ld0I2
        /gt4D7eJFLQEeVMdm1rTAjzZajhnkqkMmvbZ4kiQGtgdHdqpmRSJrcpdDXhna+lk
        t3ijAC2QcJzFvJLG7PI3Tr/5qmye3CY3n/7uKcXpqOxtY4zBGbep2Fjk8bug9cRo
        +FTWjLcr8ebvts1IJMJI3j1OefQ5uqUj94iy0rLljhIxukZvnla1FvZiOat6xuom
        LsRD7iYmTcZXFr4XCp/JXmrsWiJdWfLQa+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683577744; x=1683664144; bh=G+jMg55hOCbbocEq58MWNDAQoerhosGi6pJ
        guyIM6MA=; b=T39FrWc6UnUy+llTJ+G4RR7R1tsi13odoejvkqf1fTWTgFcwIwm
        /W/7dl789lCqMOe3fc+jOeeSJ2GKlLH7Sp6BCM7TJbRtuXa5m6wLo1iYjrHxP81K
        1NYjvE8jq585Oq6M/lc+kbWOOiHt8LUbg86K8G5U5NV2HzoTCMB0ay29JpWh/h/E
        ui0vFOhuNtqzTlNltrjA+pxIMH8ugwwtx0Ji5Y9vYV4IqSORlkmyeKJk+6aCLo6y
        EYI13qNgkwRF1gTfA+VeQxbndH4u5xV9qZpM0KidNvV2QGb1ZKqe2U8Ay7+plXig
        04TIiJo9hyY3sP/NkcoBFPRzzPEhXVQAFZw==
X-ME-Sender: <xms:kFtZZADVOmLUocTraxTqeX5QsZQHAwKxtyeTflTGvFrjNZWgXf2QDw>
    <xme:kFtZZCjNYFK9MlPUvLG-0XKRUixXu2H_0-NjJQB0ei5AmlTA6WF0cyN_KaRKuHrFk
    YgBzfpMv3qkopIc0A>
X-ME-Received: <xmr:kFtZZDmiydNh-eopV4dsbBixKxCRdEpGyveTx0_0YCvw0wlnIngcZk0K8h25wMUOrtogX0yWWboZSFwsDJknOqVUtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefkedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epheduuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:kFtZZGy0CJTOlI3pPKxIIMSdNEWnI2iaxyh5QgUMu6h8xDRJ_qZkRQ>
    <xmx:kFtZZFSeoRGNRwYEAqLKFUtY_Cafveb4dVyxKcPC92zy37S6yXW28Q>
    <xmx:kFtZZBZ-ZgQ2_hhfGfOaJ-YdiKCLRBykxZBRGUfM55Cxseg2Egb63Q>
    <xmx:kFtZZC_IowVBjXMV4LBDPYE9oSFd-wbnmAk0lg7WjHeePUSDjMf47w>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 May 2023 16:29:01 -0400 (EDT)
Message-ID: <bb3bfbfb-0761-23b2-24e9-e5b4cb3ffac6@ryhl.io>
Date:   Mon, 8 May 2023 22:29:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] rust: str: add conversion from `CStr` to `CString`
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230503141016.683634-1-aliceryhl@google.com>
 <20230508124127.77a97c54.gary@garyguo.net>
Content-Language: en-US-large
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230508124127.77a97c54.gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 13:41, Gary Guo wrote:
> On Wed,  3 May 2023 14:10:16 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
>> These methods can be used to copy the data in a temporary c string into
>> a separate allocation, so that it can be accessed later even if the
>> original is deallocated.
>>
>> The API in this change mirrors the standard library API for the `&str`
>> and `String` types. The `ToOwned` trait is not implemented because it
>> assumes that allocations are infallible.
> 
> How about add a `TryToOwned` trait to the kernel crate and implement
> that trait for `CStr` instead?

Eh, I don't think it's worth it. It doesn't give anything new to the 
CStr api, and I think it's rather unlikely that someone will actually 
need to be generic over such a trait any time soon.
