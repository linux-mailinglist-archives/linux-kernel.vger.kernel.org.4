Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AFE68E8DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjBHHWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjBHHWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:22:23 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6EE8A70
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:22:22 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B31EE3200904;
        Wed,  8 Feb 2023 02:22:17 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 08 Feb 2023 02:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675840937; x=1675927337; bh=nGo5PwpZwS
        KOtQGCgUwGUupaP5O/PMh+8I0vq8PnmXg=; b=iy0yM7X0CGOwst4PTZOPXmP1kh
        6z2iVfdSYhWs8J73KqdJ70VHIX5A83OT92hBuDZlkfgxL4zDPBIboofIKfewThlb
        snpk726BNU7MMDxujtzLa4PgBb+utSwrhZXsDQheLKCuoLlMsc3I7L3s9nHyM4iO
        fF7FPLaLtKZZePLk/R15aIl57DNIX2QNsPOkIugIzwHR09lYuAZdR0hMM/oIKj/+
        odCCbr6kdOLkDf23UPDD3XcbBIwyj8fSbIIuxd1eDShSTeHVIodVoRn7Jlm8PfrP
        AvYN/rC39/mU9ROtyAHOn/eqFw6vG2YWmwgOzh5p33a4lZ08834rsboNJaig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1675840937; x=1675927337; bh=nGo5PwpZwSKOtQGCgUwGUupaP5O/
        PMh+8I0vq8PnmXg=; b=fsFsjzKN1oOTkg2k3crEgXP3I7riBWfpIAJxZFuVyL1A
        k5vENfNLKNQgYo93eLQB2d3fixYMiESKcDoX8YfJsTT2/oogQ4B863IxXJhsW+8D
        pOFFg8l1Dkc7YMz7w9hcQzaL+jD1THv0X4c/ALe00/ccTX2o49HPJb+lYEmfF4FY
        1M2YUoHju1Z8zUS8m+3QxqHq2fPVr+rYxt7YMwBhrQ2sGhDS7vspSFv5jllHwrsy
        s2ENFRFyEvs4TisRoV67qAULD4AxmnpCMvdponE5A3QhgO4Xf31M9EZ7Ze+Gyt62
        g+J1+Ecg98eV9TAhaXuRk3z1eoMoTq34+aqEnh/4Yw==
X-ME-Sender: <xms:qU3jY7a0Td4lOn_XuFx_IXyXbQUC3qNlC3EqyH8M3S6uCWXxiWRpCA>
    <xme:qU3jY6aRLysMQG6MvOecWsDENWg37xIDd0PoOk8eE0QwUXW7fSW9WtEKRLxEYGuoD
    KjdHNp9f3vR8LGsd6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qU3jY99_hFBMVKl3huG3o4yOjfaj9XSXc6brAEXWZqWiuD6Me-Ypzg>
    <xmx:qU3jYxo4xNsd-_awHkOi_J1j5qpXfqIDPzL98rwWUA-CcjpBYo4kGA>
    <xmx:qU3jY2oDL13-7Dy7m8HAmwL4t17jgYtCnD3L-iJ5HggGMTxUXEU2hQ>
    <xmx:qU3jY3ezCdvcNN0q-_vlvDoAZU-tglt1bExHLttuZXI7GGH9iR-8MA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0170DB60086; Wed,  8 Feb 2023 02:22:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <ce2301d2-2bdc-423a-9501-bc45951bb52a@app.fastmail.com>
In-Reply-To: <20230208070559.19589-1-jiasheng@iscas.ac.cn>
References: <20230208070559.19589-1-jiasheng@iscas.ac.cn>
Date:   Wed, 08 Feb 2023 08:21:58 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jiasheng Jiang" <jiasheng@iscas.ac.cn>,
        "Oded Gabbay" <ogabbay@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        ttayar@habana.ai, dliberman@habana.ai, obitton@habana.ai,
        osharabi@habana.ai, dhirschfeld@habana.ai
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] habanalabs: Fix freeing uninitialized pointers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023, at 08:05, Jiasheng Jiang wrote:
> As the memory allocated by kcalloc has not been set to zero, it may
> contain uninitialized pointers.
> Therefore, free the non-NULL pointers may cause undefined behaviour.
>
> Fixes: 5574cb2194b1 ("habanalabs: Assign each CQ with its own work queue")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Did you run into a bug here or find that by inspection?

kcalloc() is definitely meant to return zeroed memory, so I don't see
a bug here:


static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flags)
{
        return kmalloc_array(n, size, flags | __GFP_ZERO);
}


       Arnd
