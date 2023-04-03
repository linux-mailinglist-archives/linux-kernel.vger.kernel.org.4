Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81156D4FAD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjDCR4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjDCR4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:56:13 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219D72710;
        Mon,  3 Apr 2023 10:55:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C12715C0130;
        Mon,  3 Apr 2023 13:55:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Apr 2023 13:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680544550; x=1680630950; bh=dTmrn8YSJjQ6WsksbGTSgRXcTnrxTJU/czk
        blQD1EmQ=; b=u6E0++7A4iolZKYZppveiU6uMsdhrLJsiA1NYEfnBPYYrku4q5E
        xHW8SKvttqrviwOCf+3WsqlzHzUXJ48/ojtj1udc67hP5xzQ7iauZxeZxOMKdwDz
        Vn67SQvhU+T+HSCQnSAfjHH0+wP3fC8zQeAdwVOr+73NpCsPRmnvJk9s9mzgiWTd
        3CXY4+fJP72b+r4W96iH8vb9YXifrd/JK/7IKRt9wxKv0CBFeWxDGQL5G2XkJiHy
        DlHjPJ4bLZY65bDCtOLKTk7Ubvll9XvKNgmxApArEyvOnt9M0SnDVgvL45COp/Xq
        WWnpVHxnEBbKzzauZS69l7FbYO13KOCWJYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680544550; x=1680630950; bh=dTmrn8YSJjQ6WsksbGTSgRXcTnrxTJU/czk
        blQD1EmQ=; b=W3hnw3276B+lWcruHF/tn+EKlU3Aba1gKkyZtiX6JzwTLpw9jrG
        JuloL2JiwgEwZSj+kLx0W0kH/C824ASvHPimwXUtBlpkJ7ft+qsWFi5O+IVjswLh
        6x82iXYLjmGPsI7D9e9Tg3iZN3z7jXg1YB75uypmSxmx0vMCPClorwIaLuzZhZCe
        LHYGZ6w5yoo4ZENymFEvqClhmtwxer9oaSjlItwoMCW3PG1ODrniZUolSpcH8M59
        FNa8Ca3d/TwswQj/bkR5NhHK42rM9WfRQKaHhcqCTj9Q10pSJ6YZAvsbhElmuexa
        mnkVgYqc3OdfrI9F1JnyNyzjBznldT7/phw==
X-ME-Sender: <xms:JhMrZCFNrrvmvPJGBdv1D5up2CdUS35irMeNajTJMDHDx4sdzSNK2Q>
    <xme:JhMrZDWZ5IJdHUm7Ef4rmQGE_XW5fOeqVgsSuPHS9tfbZGRnHFlO7QwDm8twzW5b8
    NzB6f9xinfFKfvv1w>
X-ME-Received: <xmr:JhMrZMIxN0eArtQtH2pu18FeGwZ657T8pudTVLKsbvKz_cYJ06mwF7hTXSY2KvB08M9bGtZO885HVPE92GimkBR1Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    ephfehueeileevjeefkeetvdffveffudeuhffgtedvuefgiefgiedvjeegvdejleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:JhMrZMHn70hMGm4lBkaV-nv8hKncpERu0o30LYX_IB4yRAhAgIYoYA>
    <xmx:JhMrZIXXjNh8c9f-i85gsTHYupxRV_DHZES9SSjJAGTFoUsxzuw61w>
    <xmx:JhMrZPPdG0MN_rLwGJH6SJHo3YXE6G5qogrODyBY_ZeUBTO0dbiXUw>
    <xmx:JhMrZBNVHC45FoYYph5Y89nNuRn5K4pxH1EZ0Yo_nUMznpt1x2fxkA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 13:55:48 -0400 (EDT)
Message-ID: <b3a2bf3c-305a-029f-e4f8-f06d2beeb481@ryhl.io>
Date:   Mon, 3 Apr 2023 19:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH v5 01/15] rust: enable the `pin_macro` feature
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
 <20230403154422.168633-2-y86-dev@protonmail.com>
Content-Language: en-US
In-Reply-To: <20230403154422.168633-2-y86-dev@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 17:44, Benno Lossin wrote:
> This feature enables the use of the `pin!` macro for the `stack_pin_init!`
> macro. This feature is already stabilized in Rust version 1.68.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
