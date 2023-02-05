Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA00F68AFF2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 14:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBENUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 08:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBENUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 08:20:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46417206BF;
        Sun,  5 Feb 2023 05:20:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFD0960BB9;
        Sun,  5 Feb 2023 13:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABE0C4339C;
        Sun,  5 Feb 2023 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675603228;
        bh=7mGBs/jrz5JwGpuB1eeglNge0UoUZ/Gcw//0fLt1KrM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FaaNAH1TYNDFgzrEdsCziIGXQv8yQAHNvzHEjif1jZmR+WLev/O8mNHofzW5kAxCI
         GtR0YQHd8WiyfRg7q7NJPC68RFmL45vSGbKXKgrqbmnfZQyDJ9fGaclM/ey0V7t/+x
         xFlK1NBlchyJS9GrJnSlxg707bV6eCMv0kvI1PO3tACENB1feKSaN+RlPVTmpyVHa0
         C9lU31D6AJnNztMkLqJwxTLE7V+es970tu2O6DiLlCeRPwbTlslQ6X4jMt2QScZhl3
         YtQR77W+FH9aM13B9coaKRuk5eHqISbfjZkFNg8QZKqPDJ8r2dORK/xsU97jzXqUOO
         lm0vhblnMcUuQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-142b72a728fso12213899fac.9;
        Sun, 05 Feb 2023 05:20:28 -0800 (PST)
X-Gm-Message-State: AO0yUKUcBlM0tgc/YnTxxeA3+MKywECEHs3pVABvoBDFT9V3jvhVTb8X
        RRjct4ubsnAtoURb35x6OGLXkktARN4MuVOV2Cc=
X-Google-Smtp-Source: AK7set/8HKtdSwGS+vytjIC+DRUGXDOIz0/AlE5nM1ImDHLLzbR8vytijxUxwvv/4CjqPJXPH506OWBnDxH7ge7+Z70=
X-Received: by 2002:a05:6871:151:b0:163:a45a:9e41 with SMTP id
 z17-20020a056871015100b00163a45a9e41mr969412oab.194.1675603227451; Sun, 05
 Feb 2023 05:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20230205010425.11932-1-rdunlap@infradead.org>
In-Reply-To: <20230205010425.11932-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Feb 2023 22:19:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ0-i_CciUELv+G9imYL-JA1LLiqRYYbj_N0jJZ2Ro-Mw@mail.gmail.com>
Message-ID: <CAK7LNAQ0-i_CciUELv+G9imYL-JA1LLiqRYYbj_N0jJZ2Ro-Mw@mail.gmail.com>
Subject: Re: [PATCH] parisc: update kbuild doc. aliases for parisc64
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 5, 2023 at 10:04 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> ARCH=parisc64 is now supported for 64-bit parisc builds, so add
> this alias to the kbuild.rst documentation.
>
> Fixes: 3dcfb729b5f4 ("parisc: Make CONFIG_64BIT available for ARCH=parisc64 only")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/kbuild/kbuild.rst |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -160,6 +160,7 @@ directory name found in the arch/ direct
>  But some architectures such as x86 and sparc have aliases.
>
>  - x86: i386 for 32 bit, x86_64 for 64 bit
> +- parisc: parisc for 32 bit, parisc64 for 64 bit




'parisc' is not an alias since it matches the arch/parisc/
directory, is it?




>  - sh: sh for 32 bit, sh64 for 64 bit
>  - sparc: sparc32 for 32 bit, sparc64 for 64 bit
>


-- 
Best Regards
Masahiro Yamada
