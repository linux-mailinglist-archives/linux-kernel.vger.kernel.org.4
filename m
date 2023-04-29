Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4F6F2509
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjD2OY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 10:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjD2OY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 10:24:56 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE5A170D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 07:24:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8947A5C017D;
        Sat, 29 Apr 2023 10:24:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 29 Apr 2023 10:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682778295; x=1682864695; bh=GZ
        1r8chqJu9O8N9mQjNNJZHcqb8s0kPL+Id1lipx7Gg=; b=TP+xxB5Xv5L5XaMTCz
        JvKdo4SJevmykIap/mU0DRhRvX8IKLEIEiABHua2KzggZII0h5vEkR01aPwrk6+a
        ktd5fTqHkoHNzkkKr6JIDw7Duq1uTjut1PWJo8z4/zWkMnbFuxPHeUlUwN6IxlAD
        UyeVjxmZqFoo4fZPlyr3/0/ZJFJLhkfqX+Cq2CRBSD+qFW3MnT8/avTtc/dc+lzv
        AXOEKvaD035j5HGJmogUyit0/Q1EUzr2XZKyTtAvSVdldYhWuN5ZUMDUnbUG21pL
        P+syKL3IXrxUaFkDzV6hFIvEaUi4vWcBY/xoxik4lUOsetsxohqW1rC9mM+HSomS
        P5HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682778295; x=1682864695; bh=GZ1r8chqJu9O8
        N9mQjNNJZHcqb8s0kPL+Id1lipx7Gg=; b=PSYVGaqH2TMG9Qz8xtbHPZ3E0/VdM
        zY0EIRGX18ZjLWbg2e84R56Xs0V9jNL6RsPV2EOZ9ciLBe4SZw9uSZ6POLWHnwKv
        MRZIXNDK9EdQ9SWH77Fxnm1WQrOXw7JqG4B6W1vDL/icfnSxFvxN3hS/fpBpmw7O
        vXH7pQDQ7FMFNyqH1ZZxx+gxdJrH29xgN4fHsMlhEQU0RwrAXQuIML13FqWzVFcC
        gP6xBdqbqGp5LJalhbnarXHTh79HuoRL2G50/V+evjB8sBY2uH1d2yPDGNeKN4en
        YcGjCuAWQJpcfssKXFKsdKwXxznPZFefBECQNQa9gWx17glf9mm4GhBvQ==
X-ME-Sender: <xms:tihNZKYaIr_sjTODQ7UfLb3tU-b7xuIhkicP95XOSC0DgkaV3u_pxA>
    <xme:tihNZNaYdNLN4ZKvfax6GcsTPJ4xyeBCFt1cx_069sEOnA-vX5EZV0V2dXaSnuRtT
    geXi-C2OQnZ9KQ4y6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvtddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:tyhNZE-vnc2QB43LdT2ApCTFpb24ozGpuTnMjZ6ZmR-IyUVP3uEmeg>
    <xmx:tyhNZMoKXJsO4ymrI6AVDqKC8Jh8CLdlVN4RsvcEhe8ZiwSELIUiog>
    <xmx:tyhNZFrYXTJ6eYrIf--A24qeaN-JGZM67BR7lOyWRf3UOjGbQVLsSA>
    <xmx:tyhNZMWssznlhbNCF18liP_e7byjQNvVRLXwSmNfeECIB5xTwK2sOA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E3C5CB60086; Sat, 29 Apr 2023 10:24:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <edb707c2-2abb-4260-9c41-c60b5efed2a3@app.fastmail.com>
In-Reply-To: <20230428221240.2679194-1-trix@redhat.com>
References: <20230428221240.2679194-1-trix@redhat.com>
Date:   Sat, 29 Apr 2023 16:24:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Tom Rix" <trix@redhat.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: remove unneeded if-checks
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023, at 00:12, Tom Rix wrote:
> For ppc64, gcc with W=1 reports
> arch/powerpc/platforms/cell/spu_base.c:330:17: error:
>   suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   330 |                 ;
>       |                 ^
> arch/powerpc/platforms/cell/spu_base.c:333:17: error:
>   suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   333 |                 ;
>       |                 ^
>
> These if-checks do not do anything so remove them.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

The original intention was to document that there are other
flags that could be handled here, but clearly nobody is adding
code to spufs, so there is no point in keeping that.

Acked-by: Arnd Bergmann <arnd@arndb.de>
