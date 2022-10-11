Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A470B5FB729
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJKP3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiJKP2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:28:43 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A9D10326B;
        Tue, 11 Oct 2022 08:19:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2D2A55801D6;
        Tue, 11 Oct 2022 11:18:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 11 Oct 2022 11:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665501514; x=1665505114; bh=IYkyi6bmsK
        t19Dqbw/69YsSocwZmqtEOH4a98ozex4I=; b=dZTgeZnKBYo3dq0eZF2BIVbtIJ
        QjpA/XJTZeNs/dEPnxZxhaU9AYifrGwG/fVAnCqUQhH4kyHqs7848VlCExTOgiA2
        V+TDb+DNdTrbgWIbuiemWyR4WMeQriYxfuy97Uws9tOXNHM9YBZq82fMz58GjcX+
        L6YoHte1fy4W0GObeYZYjrWuMkS+7Y9VjOtl1UFiOBWWTWVTQK9EnlRtZge5k/3D
        LKUtZkTwtRGPUmHAHtIZUpm5gKBJvaYTnj7z9URcXh+cXLYNMf5FeLT2e6xdihX3
        yQrWKb1ibHleWOcczhATRwGRbkZlorA3UrbeeVgG6MFJhq5KajBtoOi2fFGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665501514; x=1665505114; bh=IYkyi6bmsKt19Dqbw/69YsSocwZm
        qtEOH4a98ozex4I=; b=f5ZKyRO/Mr2PDSwAokn+Kk/z0W/LrmXWcHvrVgRmRplW
        otVNmjWJv03Y6Mbrt78ke8l9N3pNzQbGK2svUN7Pp5du9VDiFm/rBlP6cU5f6ihw
        LsqTLxbWSGYFOftFrHXGw6PqWLjX74I7vLiVggzWvs2bRGsxUoaEtYwxO5oa1uby
        KyqB5GQHRHTRoeMcit0NOqxuAb9+1pOdpj3Znl0UrHPdDUMV5KSP0JEn9ZzJwR6L
        3PyyVPWRImGVH8TBCRzQYHWBtGvj7QTp5ajCTFORQJGn0ZUgsbckcPTVk7/q59lU
        B1kQsCvgveSOJCWQJHTu+GbomebJAQtKb4xXXFz8mg==
X-ME-Sender: <xms:R4lFYyFYm92oWILoBssqVAoPMy4tWk48CZIE6TR_vaQPs1CqdRG8mQ>
    <xme:R4lFYzVItBA-DAn63dTIQl7cCKIxpb1tZc34n6Kmcpl-GLNg_CNOjnLugOP5L492E
    4U3xc8VqVDUIeJFGRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnheptdetfeekudeigeegheeujeeuhedtteffheelteegveevudfgvdekkeffleef
    gffgnecuffhomhgrihhnpehinhhtvghlrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:SIlFY8K03pMcjyawGrEJIRBx34B-CHkEjEOuYR82HSCCURrq2tGc5Q>
    <xmx:SIlFY8Gu9C94SxV0lUnvLI7D22uAHB1_EgmpxmHPvNlatfFI2LtX-Q>
    <xmx:SIlFY4WSX_Ti2r75YrxaCxFGKQOJmk0ejX6NWQLvW-aAM3Qo8C0osw>
    <xmx:SYlFYzY_hrXArQ2t--cmSPcS-aA04jQH5ODj_3YvuTJfROPRsaV_hkagJew>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E3E67B60086; Tue, 11 Oct 2022 11:18:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <08db7754-ecd8-4425-875b-4f2b44497f6b@app.fastmail.com>
In-Reply-To: <20221011031843.960217-1-masahiroy@kernel.org>
References: <20221011031843.960217-1-masahiroy@kernel.org>
Date:   Tue, 11 Oct 2022 17:18:10 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Masahiro Yamada" <masahiroy@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Miguel Ojeda" <ojeda@kernel.org>, "Len Brown" <lenb@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Terrell" <terrelln@fb.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Robert Moore" <robert.moore@intel.com>,
        "Tom Rix" <trix@redhat.com>, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [RFC PATCH] Remove Intel compiler support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022, at 5:18 AM, Masahiro Yamada wrote:
> include/linux/compiler-intel.h had no update in the past 3 years.
>
> We often forget about the third C compiler to build the kernel.
>
> For example, commit a0a12c3ed057 ("asm goto: eradicate CC_HAS_ASM_GOTO")
> only mentioned GCC and Clang.
>
> init/Kconfig defines CC_IS_GCC and CC_IS_CLANG but not CC_IS_ICC,
> and nobody has reported any issue.
>
> I guess the Intel Compiler support is broken, and nobody is caring
> about it.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> I am sending this to Linus and the x86 maintainers with RFC.
> If somebody is still using ICC, please speak up!

Acked-by: Arnd Bergmann <arnd@arndb.de>


I had the same thought a while back and tried to show that it as
already broken, but I never managed to actually download the compiler
at the time.

It appears that in the meantime, Intel have completely dropped their
old codebase and moved to using LLVM[1], so my guess is that with the
current releases it will behave the same as clang. It might help
to verify that this is indeed the case if you want to add that
to the changelog text.

     Arnd

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/adoption-of-llvm-complete-icx.html
