Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F083E6EB823
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 11:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDVJC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 05:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDVJC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 05:02:58 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353D01BC2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 02:02:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8348D5C008C;
        Sat, 22 Apr 2023 05:02:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 22 Apr 2023 05:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1682154174; x=1682240574; bh=P5W/tZc+jrDEyYtJgXRbhfTOY7Y7Gp944oZ
        Eon4USlw=; b=RKtED9bpQ8WdUYuAn90UQ/FB1rx8Q/ibLhjKHIJd3WRFis2XAnB
        cF60cfHKae782loaTK3A9JngP9X9NWiN0R8D1Wr5VHfUKkZlyvzBV41TSKf07tXf
        uXGGprA5MbcgqVlBqJXKK5fXAZej1criGbQ/WOtJWqlyBuXyxFAEhlste0crBW7I
        0PKS9JGTyJnuFmciYxvWdQY9ycPuMVc0QIYNiSF8vLbAY7cK9+BrvCPSjk3DV6IX
        0gPMCERa4sr4jUbpROAZNWgXnbkqWP8Vtc2ac7JH4G1F/H9lruyDURFGa8r6x+cm
        vm2c7yweJ9O71a4h7Q1yhFAIe2Z1EYcRkRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682154174; x=1682240574; bh=P5W/tZc+jrDEyYtJgXRbhfTOY7Y7Gp944oZ
        Eon4USlw=; b=BOvkMXnD3UIByzfJXr3wTMNfjNJHFff/Pk85zQwU0QY/0DWJyhL
        DBUwaginZTpEyk7YJ6au80de1RhbSMflMZIUzAdMPkCfPGGhu1dUoxneIz0PKZgO
        Ec6/nNHn/0IDugkCMtU+Z1qXvgqNS8vFFeDkC1PtB2ydV6oRfcE4yd+AD/tmkJth
        3jQwEkx1FWFaOXG7HQDApgBTeuwr0joyjPiucoZmvdLbabMTHI13tPGuXl+K+W9y
        PuCELuKqnR1ZZ7+opvWxiuMnf7sPvhGW5HKD+9uACl6QzRJh8/xvL7vWNcXhXegR
        fSxnOmKfV/UGx8TWdd3oChQtm9ezKXyQHVw==
X-ME-Sender: <xms:vaJDZDRWRf1k3g_v9JkUfO7GYlfvH8r8gi16xYM2MytqDwZuNTMVaQ>
    <xme:vaJDZEyI3vk1LYSRsCsYo4ha6nJr-ud4TMciZyBdYSPadGSOKdyT8SzJtISXZWh-J
    jSCwr09vMD5lR_r_us>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtiedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:vaJDZI2opNflkjYKyx3qd61ptBqWTetfni8Gcggz6UsNsmQrNS8wGQ>
    <xmx:vaJDZDDeaa0rNT1nGVQv1ZumtcfJIr4RU2pMeTRUWQNFxGaxTB1CNg>
    <xmx:vaJDZMh-NqTKwzEJFJz5_dvjEx8-H2gix8pFREUctzbD2SkYvn3Iyg>
    <xmx:vqJDZBZT2iGzCcsgcUI-U6wAB6b2Mvh69Bv6wOULuJmJeSFcXi4CmA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9A75DB60086; Sat, 22 Apr 2023 05:02:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <7d0389aa-4fc0-499b-8f2e-5a96102efa24@app.fastmail.com>
In-Reply-To: <168146523405.6279.3632248068235163346.stgit@skinsburskii.localdomain>
References: <168146523405.6279.3632248068235163346.stgit@skinsburskii.localdomain>
Date:   Sat, 22 Apr 2023 11:02:33 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stanislav Kinsburskii" <skinsburskii@linux.microsoft.com>
Cc:     "Stanislav Kinsburskii" <stanislav.kinsburskii@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Chris Down" <chris@chrisdown.name>,
        "Helge Deller" <deller@gmx.de>, "Omar Sandoval" <osandov@fb.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: asm/io.h: Harden virt_to_phys/isa_virt_to_bus prototypes
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023, at 11:40, Stanislav Kinsburskii wrote:
> From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
>
> These two helper functions - virt_to_phys and isa_virt_to_bus - don't =
need the
> address pointer to be mutable.
>
> In the same time expecting it to be mutable leads to the following bui=
ld
> warning for constant pointers:
>
>   warning: passing argument 1 of =E2=80=98virt_to_phys=E2=80=99 discar=
ds =E2=80=98const=E2=80=99=20
> qualifier from pointer target type
>

The change looks fine, and this is clearly useful for spreading
more 'const' annotations, but I have two concerns:

- I'd really like this to be done consistently across architectures,
  so at least the asm-generic/io.h version should get the same
  annotation, or ideally all of them in one patch.

- I would not describe this change itself as "hardening", as it
  also does the opposite, when you have a pointer that is actually
  "const" but converting it through virt_to_phys() and back
  through phys_to_virt() ends up losing the annotation.

     Arnd
