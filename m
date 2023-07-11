Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DDB74EBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGKKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGKKtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:49:40 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147B2E74;
        Tue, 11 Jul 2023 03:49:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id AA47632004E7;
        Tue, 11 Jul 2023 06:49:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 11 Jul 2023 06:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1689072574; x=1689158974; bh=Tbdbrnoaq3VxVhi4rC7fx0v2ZGZtfQdGNuw
        gKYtKHTo=; b=agWsRevIiibR93q6r0c+IXVCCE2GFofcH8b+LFKIvEJQxDIGohI
        ew79TpR46j3c1OaRo8L/nqv71uDu5s3MFVsqZvA6H1Oe8Ynk5AeDI2UBY2uWnOaV
        5hQYFrDy0T2dBFZST8gP6VfnbMYR5LKR2z+vGSzpXI9BrAj9mWxYb9xvgoMSgOu4
        Iz75YSmERt/9hD1i+V5xlc8bjOsocfiEgGngbuzRd8z3AeZmeERRizOXDX0n0b7j
        ltHhVHfJtD83tePEry05rtSNZmdvlXibz05H/EFpl9JaKbo7zjFKeqftPSJkQZ0Z
        CNqHrw2vcA4q/wrzfls4hg8S8kKd+SpPFuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1689072574; x=1689158974; bh=Tbdbrnoaq3VxVhi4rC7fx0v2ZGZtfQdGNuw
        gKYtKHTo=; b=cxXF9LJlXkyaVZi+mtMmAwydoPuWxySPAfvvx/eZvo590ry9SKl
        QSSTWkbiz8/Prtt7LuhOb+RgQfLbh1tAY/Yy1tqwEWE88VXijF+k+UiuCJYEo81f
        wZ2HPU2TH0KPDuWJK01mthZhclaSrvRDzO2EQgwA0/zIrF/L7thoC+flOQXf8Rlu
        WUCkAoaUDJ5/BpejIQ2J/NiFa3xY94ycHoVJhywh60WKWQV/7Cwn9DnGQOaee7Cy
        0Nze6il6gpBPfe8PCrENA37GmWbZx1VgdKSiz6cbxrYoYuz8AQTD4maCbErEMeYO
        XHdXd+P9AEJQJPaNE6rO9T8jl6O+pEFwlmQ==
X-ME-Sender: <xms:vjOtZO34J2QyYumRzTTFRqT6U42OMSlE6rsbXiqaNzhsSDP3KuBBww>
    <xme:vjOtZBEHHNdibQKf09VMI9kFJvmRjFMNvr2DO1Es5DV_O_jQMaKbqeft7wxUW_cri
    CKGxZBIM7Tu3xWmgg>
X-ME-Received: <xmr:vjOtZG6gVP7qxCerByNGuOiqtjpfp6nZ3b6x9BTN_6cbiWX1DRNZBi5KbXZhE1leJH3yMtA3fAKCBMY5U8btEplctviiAwWj5E_WHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhephe
    duuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrh
    ihhhhlrdhioh
X-ME-Proxy: <xmx:vjOtZP2OduDpFtI4G3B3gQSzAIgQKgtem8Kz57y7A7HyFIcZlDdw4A>
    <xmx:vjOtZBH0cYrrhew50MnUN0dMcj_FeCpsg6_dYX_3mgt3C0DvqjxtHw>
    <xmx:vjOtZI_NXpIAxa6ErEeoz2S87RHq5Vc2SIO8vDF1jWPSl2WNRLlNQQ>
    <xmx:vjOtZAe-RDjrs1tERWO_0JCD3mZA4lEssxaAZz1_uyBI1Ax4Iv2lAg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jul 2023 06:49:31 -0400 (EDT)
Message-ID: <9c46542e-e756-839a-0bbb-9348cb00658a@ryhl.io>
Date:   Tue, 11 Jul 2023 12:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/9] workqueue: introduce `__INIT_WORK_WITH_KEY`
Content-Language: en-US-large
To:     rust-for-linux@vger.kernel.org
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Alice Ryhl <aliceryhl@google.com>, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
References: <20230711093303.1433770-1-aliceryhl@google.com>
 <20230711093303.1433770-4-aliceryhl@google.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230711093303.1433770-4-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/23 11:32, Alice Ryhl wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> A Rust helper (introduced in a later patch) needs to call
> `__INIT_WORK` with a passed key, rather than define one in place.
> 
> In order to do that, this moves the initialization code from
> the `__INIT_WORK` macro into a new `__INIT_WORK_WITH_KEY` macro
> which takes the key as an extra parameter.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Oops, I messed up the subject of this one. It was supposed to say
[PATCH v3 3/9].

Sorry about that.
