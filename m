Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6346979BA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjBOKT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjBOKTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:19:45 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ADA3346D;
        Wed, 15 Feb 2023 02:19:42 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 903B1320099E;
        Wed, 15 Feb 2023 05:19:38 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 15 Feb 2023 05:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676456378; x=1676542778; bh=q5E/e4i4oy
        VGmRBU38c6Pkpr1j0okcfftjblOsGQyQI=; b=DRbk2b+FXi6SUP6W+ojrbicoD0
        Ew5GnQj2LMnKFmCRAmxnCbOlLclnDxqX4J2XlCqfLANayML0rDX7SjfCk7mYvi3M
        eEClWb+22zugY6/tg7S2NWv8w0DhJ4Es2Rf5K90L36HVNvOh2qUttliZnxA2myU5
        b/c1he16qLicxbVJXJWSMEdkUnDaYoViYqSh9ENr+qo01Bl3O5MAL/tJ5sfEF4sv
        KjnLzQbuwspJtQU3kvthN/FA7vvOXZO55huEmyELk/y/Y9gqvswRq4dMxECiV8BX
        J2q8iDx1xGQm7Z8ZPR96Bl94DOSNHEahs8mlzua1Zw1Wyn4FkxDENSwb6sLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676456378; x=1676542778; bh=q5E/e4i4oyVGmRBU38c6Pkpr1j0o
        kcfftjblOsGQyQI=; b=EjTkd0PifDzqDA3DcI0Bn05hfuiggvGkV4KtS0KJacYk
        uGgl/r4aL5zcMu5OoadMNM1QIBM0Cuez1+DKOvIk+5eZhuzgFy7/74pHBRSIOUyX
        zI4kTcvX53552K9GHia26DPIBDh5XDOTq4roHO+ZAZwLOwfCVQGO2oDezi3i5QWf
        82TjmnJgxs5s4jIRzjivaQcyy8KjlSEO7TEhyGZDzOorsrpYpIru8s/NPzfueSuC
        M7ubCwSMB0PoEbe4cTRQaV9u1TzOlHO2joffwlMb9LwCC7yDTYWAaSIdw8ZprYYo
        X/IafuUnjL4yNGLDjtZAzd0VvCoztOBfv/9Dlptvkg==
X-ME-Sender: <xms:ubHsYz0Hy6b6MO2hPBHBNcGvx-9acqkJES8AKca0PNzgyIT8YywKdQ>
    <xme:ubHsYyH_JEekBQXrMboesMInvwjVnP4UGVatIiVNlTOKSW4S2C6dCtN0DI1IKTDdI
    exLaEw4oUhlbT373aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ubHsYz6fxE_-uzjtKjVWA5oMZhZBULmukf7QpH81xz9a4hG9np0LMA>
    <xmx:ubHsY43t1HPi-3PMxM_1oyenvidCgB1HDVvMl0jQUnLlEAIPrrYpPw>
    <xmx:ubHsY2GXVR97LalXWh1sdjlMQSw_YfoUFp8JBtWjd4T0NPQ9nwhe_Q>
    <xmx:urHsY0bT8WlsSHiKtvoqsY_z6pDWP_GvYeHvTuomY2LMTL45sh9DlQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A2774B60089; Wed, 15 Feb 2023 05:19:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <ea12dd12-db17-44a8-8c29-6b0a129f355d@app.fastmail.com>
In-Reply-To: <20230215100008.2565237-3-ardb@kernel.org>
References: <20230215100008.2565237-1-ardb@kernel.org>
 <20230215100008.2565237-3-ardb@kernel.org>
Date:   Wed, 15 Feb 2023 11:19:18 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ard Biesheuvel" <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     "Jonathan Corbet" <corbet@lwn.net>,
        "Tony Luck" <tony.luck@intel.com>,
        "Jessica Clarke" <jrtc27@jrtc27.com>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] kernel: Drop IA64 support from sig_fault handlers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023, at 11:00, Ard Biesheuvel wrote:
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/linux/sched/signal.h | 17 ++++---------
>  kernel/signal.c              | 25 ++++----------------
>  2 files changed, 9 insertions(+), 33 deletions(-)

The patch looks good, but I'd suggest adding a oneline description
referencing that ia64 as a whole is removed.

I see that you created a couple of patches looking for __ia64__
but not CONFIG_IA64. If we get consensus on patch 1, we should
do that as well, let me know if you you want to add those or
would like me to help here.

I can probably do the same recursive check for removed Kconfig
options that I used for finding dead code after the boardfile
removal.

     Arnd
