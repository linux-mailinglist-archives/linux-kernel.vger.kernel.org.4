Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8053070E334
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbjEWRIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbjEWRIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:08:38 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF371BB;
        Tue, 23 May 2023 10:08:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 209F85C0040;
        Tue, 23 May 2023 13:08:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 23 May 2023 13:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1684861699; x=1684948099; bh=xtAMM6mnNcy2IBjIoSVCNnLL8ij8AZ6nMF5
        VcBqw3e8=; b=uvsiHWq7vuESpqxiY6QGQReZNHAux5qoRlBTdc0sIQuKEt/dfM+
        qFIffGmdbfdbVc/DguHpoT11wkfYzKdKeBpcXB4lFeCLPleS6OSrpCG/HaaJJWP3
        xPDGiVPEcXt+j8en8jgs9QP8DHDuKcAvIl6S2sugFR8eiwIoUNnnNDuFLCesjzcb
        CxzhdZ4RME74Ydr0LyS5ZgJV61IUABOViTs0QHX++4qmVzxh5/hfizvcxhOGd0Rt
        T187x8csHllvQ0yuLiCsfrAZOKjd528POosoSZw6Gqt2KH6Z62jfN9TEZwh0ElYB
        B0RCP9Br1+aaEgISoo5mSdqOdpiNXa9uwbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684861699; x=1684948099; bh=xtAMM6mnNcy2IBjIoSVCNnLL8ij8AZ6nMF5
        VcBqw3e8=; b=zKtHNt9PheMKA5jrjQLobzU6GeQJGxUJCnQMplNpnOx631mjUGx
        H0bwM8X+/iV7nuQYsNOpyKIJ5FmyZOnvODFzPyVAS/RJI/tcM9sH/f3YGuQvHSyx
        QN9Yc1s2l5UvjWwhRivbNSb90fymwLo3HDDKpheujpoadWYp7vwTOlrfuECgUzbp
        bTN1QxR+pouFgkW/noMce95izbX071EpKP0WEAZ0Ako+AVoEsGwA0MxbeiOV19Yt
        HzO59ehtwUIAwE1eQNltemKpzBSXlAvB5nEUXXrbk3SVn4DsN8oTZfQr0tfcxv2W
        83huFfLDqQ9ZjUzZ+B0xbpy6/RDjI+tXegQ==
X-ME-Sender: <xms:AvNsZEZkoe0DJSXfhZcssEcJiT0WyZE9lU--VqREwfnqQ6gud4MV9A>
    <xme:AvNsZPaxTJqbpUom3ZCCz3Rakx4jlMd7CYoMQPMDXb22RKZSMQqKXGzKG_PSBvzDJ
    rkYaQrD_S00ak9I3g>
X-ME-Received: <xmr:AvNsZO8hs_RW2TRt8rgXLAMlK7lNfDKBoSOquEVYnohNJUMGNFzbkHYj29XUPX4Wsz0Gm7E2ghjpm4_SlQOlDpwxrW8UZQVBl-3KtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejfedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epheduuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:AvNsZOqY-e_JG8ndqeXZZ7ARBksmWM5GZMHNmOXuk-Fxxj0GN5zYEg>
    <xmx:AvNsZPobpIxYSvC6n0wci63QdvySHGsq7dpSMAyLttjW9W6aMIq69g>
    <xmx:AvNsZMQhYWqs1kARRF59Llz_smTL53tvrCWEIVSjEqr-sfx66hPBGQ>
    <xmx:A_NsZKCI6DNtTy-8mvPb8Ce86mINJhjVP1QiZFsOz5vNC4qobsW1xQ>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 May 2023 13:08:15 -0400 (EDT)
Message-ID: <166384c2-7788-a295-fbe3-31fb350aac39@ryhl.io>
Date:   Tue, 23 May 2023 19:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/4] rust: sync: reword the `Arc` safety comment for
 `Sync`
Content-Language: en-US
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
References: <20230523144418.1250547-1-aliceryhl@google.com>
 <20230523144418.1250547-3-aliceryhl@google.com>
 <20230523165027.71600b4b.gary@garyguo.net>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230523165027.71600b4b.gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/23 17:50, Gary Guo wrote:
>> -// SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync` for the
>> -// same reason as above. `T` needs to be `Send` as well because a thread can clone an `&Arc<T>`
>> -// into an `Arc<T>`, which may lead to `T` being accessed by the same reasoning as above.
>> +// SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync`
>> +// because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
>> +// it needs `T` to be `Send` because any thread that has a `&Arc<T>` may clone it and get an
>> +// `Arc<T>` on that thread, so the thread may ultimately access `T` using a mutable reference, for
>> +// example, when the reference count reaches zero and `T` is dropped.
> 
> "for example" here implies that there are other case to get a mutable
> reference? I don't think that's true for our `Arc` since we don't
> provide a `get_mut` method.

Ah, yes, that's true. Good point.
