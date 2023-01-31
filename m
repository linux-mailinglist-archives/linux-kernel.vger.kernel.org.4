Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874D5682AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjAaKlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjAaKld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:41:33 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBCE7EC1;
        Tue, 31 Jan 2023 02:41:32 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C028C320027A;
        Tue, 31 Jan 2023 05:41:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 31 Jan 2023 05:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675161688; x=1675248088; bh=TVxjDBSu1i
        e5u50iotYtRrYYAxo0Sl13eXcUmtaQi2k=; b=Bx/iSXMH5eR7WrbFxsLsPrqMV3
        lDEnjcbiemHV+l4Sj4IN5uHwDuw0jrk7RxeMH/ic83FT8UeqYYKtr/rpuFnpo2OA
        jHEQfrgCBJF4sp+C5v9sIEEYakwM07Q2oqRpcsuT/+XUVpo2dxJhjfMf1qAozNhQ
        W2Hm1E2BGb2mvfySjHQMTY6bOqwpAIm8qLD+EYUaCB5d655+U+mbtnGO8XaOaDP8
        gNl3OeqNOvpyUezzRhGfJVOOUx+nz36MRwRaUckmJzd9ap9w60SaBOlFqx0elmi3
        eiDjoS0GblR8AmKBAVPeHe/oj4TR1n3XEwPpMP3YlXDadnIhFDpu+bqrYNyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675161688; x=1675248088; bh=TVxjDBSu1ie5u50iotYtRrYYAxo0
        Sl13eXcUmtaQi2k=; b=P/Gg362oqMfr86ojRPVsB0Tvu7fhnNc7OIBoksnuRwnd
        lHScTBOWCznm3bdmEr+3O6YGPEmZHP/KMhCEId4c5jer5r7+XncHLPXMGovJfuwH
        /AAVUc9yd6rqDZ1WfniUBnFHylXgFUVy/KJ1fVG6c3bqP0k9oBxngdK9JbWlTa79
        1AbYuvT6PTmxuYCS4QS//vxLlEAJjBmMZS0VwiQpAXgEpMu/CBQ26ZeeL4pyYhJA
        yqs/nhF+ZErYYYMLmkBRG4hmvwIKSRn7XyBn4ViIUNZ5H7QgcWIUekXk62JMdkKB
        R2mPdT+1RS8UgEqdwak4vCnKMUeFbjDC0cQUGH+faw==
X-ME-Sender: <xms:WPDYYxbwgEwUvSBNGF0pDIbTeCnUqJB1frbrW62uohKEkpgS8WtP2A>
    <xme:WPDYY4YZ2Bqr0ItvRJrnE1ZuCg3shz4H-BId2-KDdPoz-Po1OTIUni2nCNgZlx1dJ
    65nFTjSfVVH0MXLNvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefgedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:WPDYYz-a2UeSHS38zn3pXSXznjdelKupFaKdW0X1cvwNJCyQToVi6g>
    <xmx:WPDYY_qyMjFV8xcB4jhVQciM7WYhabmY5cDgybS2otUFk_EJX53hNg>
    <xmx:WPDYY8qUHobFGIxLX2fUvOfdWU7QpNqCgwt4EhlFwIyHfSo1Vp_F8Q>
    <xmx:WPDYY3VOzpO_YL3wGHlMz7m6VAgw3qevJjoGaXXrqvrtNLqd6he70w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0BEBCB6044F; Tue, 31 Jan 2023 05:41:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-106-gfe3ab13a96-fm-20230124.001-gfe3ab13a
Mime-Version: 1.0
Message-Id: <9d2450ce-6ba2-49eb-9f00-bcb1b8590eeb@app.fastmail.com>
In-Reply-To: <35c0fc4ba93b11c4b8a55c2907f736a840cd12a3.1675161286.git.geert+renesas@glider.be>
References: <35c0fc4ba93b11c4b8a55c2907f736a840cd12a3.1675161286.git.geert+renesas@glider.be>
Date:   Tue, 31 Jan 2023 11:41:08 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] compiler-intel: Remove duplicate RELOC_HIDE()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023, at 11:37, Geert Uytterhoeven wrote:
> The RELOC_HIDE() implementation for the Intel compiler is identical to
> the generic version in <linux/compiler.h>, so the former can just be
> removed.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Not even compile-tested.
> ---
>  include/linux/compiler-intel.h | 5 -----
>  1 file changed, 5 deletions(-)

I thought the entire file was gone already. I don't see anyone
objecting to the earlier patch

https://lore.kernel.org/all/20221016182349.49308-1-masahiroy@kernel.org/

but it never made it in. Maybe we can revive that instead?

Otherwise, your patch looks obviously correct as well.

Acked-by: Arnd Bergmann <arnd@arndb.de>
