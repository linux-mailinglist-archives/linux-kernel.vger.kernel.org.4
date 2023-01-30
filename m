Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B57568071A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjA3ILW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjA3ILR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:11:17 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD07ECB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:10:51 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B61665C0446;
        Mon, 30 Jan 2023 03:08:30 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 30 Jan 2023 03:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1675066110; x=
        1675152510; bh=QbO6RgTyZCH0F7lsFXKAl1hu80urlER2Gg9x2aAGIYk=; b=q
        vQnZ1x2L0GPuiM9klXMW/u3+DUcOQpuFvszXRiJBwHIxNbzX9HtPMU2CXQMR0I2E
        ehSpg3cPEFwDtTmIpwSwOjI8N3N8QCiikF3LhkVTxYWz7AmFbqUfkyifV2YGQAAP
        uy5pfmxSTmrE4N17BAWA0ek7uBUOe73pB59xyzEahpSOwWrjfv+3Qz8nJWY5B9RC
        0Jdm65MGcVOLWMORTWVZogLMFij5LpsagfQ1CkzzkV9GzJHSy2ZHaUUW40n8dyQJ
        nADlU2QCxf6oHyXKBfEWtGq05cvy0AssjQkelzN5uW999+0jha6j0cLs1LqKFFw2
        8A2fQw9Jbo70BbVseY+aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1675066110; x=
        1675152510; bh=QbO6RgTyZCH0F7lsFXKAl1hu80urlER2Gg9x2aAGIYk=; b=a
        HWzctS41U+v6uQ6New/Bc+suvJoC649V5JKYq4Vp70Xd1UAYi4K/BsyPbDOFRPra
        nIjyPFGW3v2N78umqXr/vd6ufOptbEa7FTZ7QOH1VKaD7AtDdbXdYV7h43g73wGv
        Ks5iLw0Ke93tP9YAAx9BV9TCl7tMqxTIqEs2S+S5vt2MdjT03O7q6w6kvcAhdgkU
        tj64TSIj4h44vYRL3g6brmtxFXeyEcyXLvgNgdsXehYvRnIJEUHs05OFWewLFsEG
        qk4ZqWSRR+lJ2WK2qQNQ8+bfnB37sZ6QkC/b8Ui8GRgkUG/PiGLeBpWAvIusf146
        8LIAXcpxK02yFqy1eNTHg==
X-ME-Sender: <xms:_XrXY_QwGHluOhfuctdGTEraEd9D7B5gfiIybbFCiqnnu_etyunWAg>
    <xme:_XrXYwwsLkwYemoK1uRiBcOhFaYY7qkKdEZ1qL7ga1i5wUR8nUpgB5UnOyMUfRA9I
    MnichuZxHXjgVA8eIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefuddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:_XrXY03hq-U8pKtl2pnQz3HgVZRoScmIoN_f5UH4_M_7xiRl1VQ7Dw>
    <xmx:_XrXY_CHefQAUZWHhekl1rj6-u3F82UpTI4XRL_pBiBMlREFgJquEA>
    <xmx:_XrXY4hFZPWIWrb47iYyJN_Uc8ho5f_v9yAwXljViTPhhfsGCBGFcA>
    <xmx:_nrXY0jR6hsue7IyBoLwuYmVRZsCD_noYuWd1dBptJ359sx6_U-hVA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 57789B60086; Mon, 30 Jan 2023 03:08:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <6d1f3696-c94a-44ac-996c-83233f694cc0@app.fastmail.com>
In-Reply-To: <20230129160039.1598347-1-j.neuschaefer@gmx.net>
References: <20230129160039.1598347-1-j.neuschaefer@gmx.net>
Date:   Mon, 30 Jan 2023 09:08:10 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "William Zhang" <william.zhang@broadcom.com>,
        "Michael Walle" <michael@walle.cc>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>,
        "Kavyasree Kotagiri" <kavyasree.kotagiri@microchip.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: Allow DEBUG_UNCOMPRESS on ARCH_MULTIPLATFORM
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023, at 17:00, Jonathan Neusch=C3=A4fer wrote:
> A kernel with DEBUG_UNCOMPRESS=3Dy will only work on one platform, but
> that is already the case with DEBUG_LL=3Dy (and documented in its help
> text), and DEBUG_UNCOMPRESS depends on DEBUG_LL. Therefore, I don't
> think users need to be prevented from enabling DEBUG_UNCOMPRESS on
> ARCH_MULTIPLATFORM kernels.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

I think we should instead change the help text for CONFIG_DEBUG_LL.

There is a very significant difference between the requirements
of DEBUG_LL compared to DEBUG_UNCOMPRESS. The former only provides
the platform specific functions but does not call them unless
a user explicitly passes the "earlyprintk" command line argument
or adds explicit function calls to printascii(), while the latter
makes the kernel immediately unbootable.

     Arnd
