Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC976D124A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjC3Wkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjC3Wkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:40:39 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF88ACC36;
        Thu, 30 Mar 2023 15:40:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A83473200932;
        Thu, 30 Mar 2023 18:40:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 30 Mar 2023 18:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680216037; x=1680302437; bh=gOmL1aQ44MXyuPpeP7TtE2q5Dtn70Ay6Jf7
        0/jGPMbQ=; b=UmmpMWz0c+/b8wwa2Lmx3vygWTGvVa9srjxzpTn7XgG2Xc6GLce
        5fLx7HH6GjpiV/Xf1v40gSPD8Tg14U6mcsr2ME8FvR7IRIq6rWFpd6oYsm3rfQNr
        G5Xm266MiTrwYAev5Wy3medhnNRhAH3WfH1niG0Gm40vIyaHJBbIWPHyE21Cc83V
        ufEHnJn7mTC3WhF65RhDCIXAcn4CrfWat5lkEYgo6t4v3/Km1ic/h7y0fH+ppIuS
        UaIbMq/4iVou8s6OjQmUufAUbTGs1j3JUY7zPYod0pdxBVAMr4/0wShjtbTeGMb8
        eLrzSW5c9a226CDxTGDjCkR7FzVHFWeRCqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680216037; x=1680302437; bh=gOmL1aQ44MXyuPpeP7TtE2q5Dtn70Ay6Jf7
        0/jGPMbQ=; b=i3rXtGRcGYyhzkDZjq7IEqnCOzWxIzUhWMLZDKpA5kRjbOASX/M
        TYsr8Opm0p29D1OWHLHD42QOER3saz/kedrVs2A1riDOkVtmUDlasypKD6dCGPnq
        HQOWxruE0kmPu4f4I4moat/cN5y+phK6hpDaQD1HyH1h5GXtJVQxZjoP3RMBiRWq
        joaLSQtPwl7Y2EXIvi+Yz5dxWTYonE/cPfOY+2PUnVjNBCI+eu87D1L2AKHXn+yM
        SsS/C0iESqr3hd0wn4ZHRKyvhK/VSbLNK2GHRExgr8BwPjsTUV2ha5tpr3aJK/8j
        FLPEDQfqghtWjz17r+vf6tf9wV9rXoUCP0Q==
X-ME-Sender: <xms:5Q8mZMyGfESz8yCeb_LxTLIC72pVZL755z06Rf7Sh9v5vtndN_5Sww>
    <xme:5Q8mZATJJn6HKV2MMOpi60XmEH9tGLmUnvdcjkQ87dmVRvucpu2YLK6AFmXYSQrfH
    3gNWB0JQOPF1hN1Fg>
X-ME-Received: <xmr:5Q8mZOWGLU5MlU3WtIpoSOSPRY_ApeWkkaWfWgLR5Btr3CUPSVRZ8nfmcRsGj6KJ8WIljaBtRs0atiFKXkO8FAUITA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeitddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    fgvdeggeelvdeggeffveekheevleevkeeuudelhfefffefuedtteejjeekleffjeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdiivghrohgrsghlvgdrrhhsnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrhihhhhl
    rdhioh
X-ME-Proxy: <xmx:5Q8mZKiZk2aZcYKYriKP_UE50Ce_D4SA7EYoKIyp8VpdCtwgEcaVPw>
    <xmx:5Q8mZOAgCdzxpLyXlz_-fQicUz-eh_tXqZfkWAyswXfEdGBGjUz0og>
    <xmx:5Q8mZLLb0vJ10hyOBXsTOxLK6UHpL2oaSaQR19i6FCK0WNq5aLOsPg>
    <xmx:5Q8mZK3yD2zYPkIFZcsd3ef0r3prEE_NTSts3gWQ1qrBZu-kUUx1aw>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 18:40:35 -0400 (EDT)
Message-ID: <19db6213-297b-a33d-7331-3c1a5b72fad9@ryhl.io>
Date:   Fri, 31 Mar 2023 00:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 09/13] rust: init: add `Zeroable` trait and
 `init::zeroed` function
Content-Language: en-US-large
To:     y86-dev@protonmail.com, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230329223239.138757-10-y86-dev@protonmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230329223239.138757-10-y86-dev@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 00:33, y86-dev@protonmail.com wrote:
> From: Benno Lossin <y86-dev@protonmail.com>
> 
> Add the `Zeroable` trait which marks types that can be initialized by
> writing `0x00` to every byte of the type. Also add the `init::zeroed`
> function that creates an initializer for a `Zeroable` type that writes
> `0x00` to every byte.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> ---
> +// SAFETY: `null` pointer is valid.
> +unsafe impl<T: ?Sized> Zeroable for *mut T {}
> +unsafe impl<T: ?Sized> Zeroable for *const T {}

Actually, I just realized that this is not ok for unsized types. When T 
is unsized, the raw pointer is a fat pointer with a vtable, and the 
vtable part is not necessarily zeroable.

However, it would be ok to do it for `*const [T]` since the fat part of 
the pointer is just the length in this case, and a length of zero is fine.

See more here:
https://github.com/Lokathor/bytemuck/blob/8391afa876ba2e99dffb0c991cc7fa775287d106/src/zeroable.rs#L56-L65
