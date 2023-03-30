Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA466D06CC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjC3Nd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjC3NdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:33:25 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5603FAD27;
        Thu, 30 Mar 2023 06:33:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8602432003AC;
        Thu, 30 Mar 2023 09:33:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 Mar 2023 09:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680183200; x=1680269600; bh=ZNmR3kieAqctdwlbiLltTH+s1ytqrjcQ2ad
        U8yfZiJs=; b=V/S+FXPHaO8WyHojLbqH85/DnVNGqaU/58erWa5JKKm31BKzuUT
        nAHoQIDTvw6KEQh+h6990nMu8OO6U1767Z7c1Kg4571nkgAyVsXj+XEjrRA94aFT
        ak5UdbXmz3LVylnnpbvIMKkLN3Z0MoNnN7D1KcKqzazeQ8j/utCaS53bLmJEdz+x
        /zccVVYiEuFi06bX7Wii/fMswJu7SIf42g4c/Np0zXg1AHbwDNtoGOemCFOFhn1g
        MsneuNFFUplPFpuPyUtbngmakF0WnO+C80aU+ljGjv/IbJmjMzdRS/4IjuwfhAYp
        UmKA4BhquzNwmmFz1ljCCknaY9PGDuB8HAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680183200; x=1680269600; bh=ZNmR3kieAqctdwlbiLltTH+s1ytqrjcQ2ad
        U8yfZiJs=; b=hjprN0AK6NYt1bSpGF9fUFgOGKNE7L1QxlsC8EdLbckAze36Lfg
        MZY9Kahmt+7nms5e+rUeDWFKc+wg237nzPCSXBhchUQ/dyz2zqfJSVue+/ZClPH5
        jR2G1LJBK7QsDpcbjPUMXGjFztzs/qO8vh5fXiD7vphbZqrTx0teb6v0DPuAtDSK
        4qoLpKbvWm4vrVSNB2SR+rC/fxP7Hqhb0mYj8O+wefls+4Hw88UfjfOy0StnLH1B
        XOeFpnqR63puIzGBhBW9GGp7RPwKAbmRQ1XC1TQ3S5zBo1SzzQym1dLjb7jYd396
        vCPLE00q6PZqquCgpsY1Xxy3Fpckey2AfaA==
X-ME-Sender: <xms:n48lZIHRK6320eLy9er_Tm0mRcDIGWiKt9cl-2xlHqexttVooXr89w>
    <xme:n48lZBU2xGL_rZugJckv7g4zb9p8bx1kb-4P3deSG5PawYI6IsN652nGd6PCfHbQM
    Yd0wiWvP1PD_WGpNQ>
X-ME-Received: <xmr:n48lZCI93l7_zVhVF57WH8sRWJB_SSusRDgOjupiSFHlBEyLX0TEFTVjdXRIYfoRc5jOR7cu5R3qpNlMFC0wuOjNWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehkedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfhuffvvehfjggtgfesth
    ejredttdefjeenucfhrhhomheptehlihgtvgcutfihhhhluceorghlihgtvgesrhihhhhl
    rdhioheqnecuggftrfgrthhtvghrnhephfehueeileevjeefkeetvdffveffudeuhffgte
    dvuefgiefgiedvjeegvdejleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheprghlihgtvgesrhihhhhlrdhioh
X-ME-Proxy: <xmx:oI8lZKH_xysUrJ1WwOPnIvEu-ilVIZSt2FaJ1nQf8vm45i5BNTaR1g>
    <xmx:oI8lZOVBgtY6Kc0B4t3PdsZAEOUOzLgDb4TOXpUvIdBOSBiHqh_Ilg>
    <xmx:oI8lZNNorDLALW0IiGUTlwFD0VJFj74oC49xy3vEP87RkfAMEpqJew>
    <xmx:oI8lZLjGmwu3ztGz-Kmlav6jzOGeTsphzLsffMoxeK_Jb2DW1ANzrA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 09:33:18 -0400 (EDT)
Message-ID: <a51d2cd1-6f00-b4bf-99df-be2e906674a4@ryhl.io>
Date:   Thu, 30 Mar 2023 15:33:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH v3 01/13] rust: macros: add `quote!` macro
To:     y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-2-y86-dev@protonmail.com>
Content-Language: en-US
In-Reply-To: <20230329223239.138757-2-y86-dev@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 00:32, y86-dev@protonmail.com wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> Add the `quote!` macro for creating `TokenStream`s directly via the
> given Rust tokens. It also supports repetitions using iterators.
> 
> It will be used by the pin-init API proc-macros to generate code.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
