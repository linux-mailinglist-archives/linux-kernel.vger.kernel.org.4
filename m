Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669D469406F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjBMJLw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Feb 2023 04:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjBMJLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:11:42 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20726125B8;
        Mon, 13 Feb 2023 01:11:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9D552642ECB0;
        Mon, 13 Feb 2023 10:11:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Z3htFc1xU6Ay; Mon, 13 Feb 2023 10:11:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3E50D642ECB2;
        Mon, 13 Feb 2023 10:11:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wrLymRRQYtIb; Mon, 13 Feb 2023 10:11:38 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1AC61642ECB0;
        Mon, 13 Feb 2023 10:11:38 +0100 (CET)
Date:   Mon, 13 Feb 2023 10:11:38 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Rust for Linux Kernel <rust-for-linux@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado 
        <sergio.collado@gmail.com>, davidgow <davidgow@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <1058405569.122806.1676279498018.JavaMail.zimbra@nod.at>
In-Reply-To: <20230213085920.19726-1-bagasdotme@gmail.com>
References: <20230213152714.78b844f4@canb.auug.org.au> <20230213085920.19726-1-bagasdotme@gmail.com>
Subject: Re: [PATCH] Documentation: rust: Fix arch support table
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Documentation: rust: Fix arch support table
Thread-Index: +miLz6ioQeMRrAcdk82UN8LwT8Au7A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Bagas Sanjaya" <bagasdotme@gmail.com>
> Stephen Rothwell reported htmldocs warning when merging uml tree:
> 
> Documentation/rust/arch-support.rst:20: WARNING: Blank line required after
> table.
> 
> Fix the arch support table by removing extraneous simple table marker.
> 
> Link:
> https://lore.kernel.org/linux-next/20230213152714.78b844f4@canb.auug.org.au/
> Fixes: 0438aadfa69a34 ("rust: arch/um: Add support for CONFIG_RUST under x86_64
> UML")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Documentation/rust/arch-support.rst | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/rust/arch-support.rst
> b/Documentation/rust/arch-support.rst
> index a526ca1c688be6..ed7f4f5b3cf157 100644
> --- a/Documentation/rust/arch-support.rst
> +++ b/Documentation/rust/arch-support.rst
> @@ -16,6 +16,6 @@ support corresponds to ``S`` values in the ``MAINTAINERS``
> file.
> Architecture  Level of support  Constraints
> ============  ================  ==============================================
> ``x86``       Maintained        ``x86_64`` only.
> -============  ================  ==============================================
> ``um``        Maintained        ``x86_64`` only.
> ============  ================  ==============================================
> +

Applied to linux-um next. :-)

Thanks,
//richard
