Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B812668B39F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBFBII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBFBIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:08:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6181CDF4;
        Sun,  5 Feb 2023 17:08:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7312060C4D;
        Mon,  6 Feb 2023 01:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D781AC433D2;
        Mon,  6 Feb 2023 01:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675645684;
        bh=XyBLgfQK6ge4EhdCnRlXceT5yEg/NKnPwHNtxHUH0+o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TFp/nNwV67HIdFc5vi8rwNLOpB0TJQOS9Z1aAEQk/ywmRw5oWzuETG7y0eeUCCt9D
         y2jTHN1SPxkaHlNnE5REHYMqcNuF1TyWkgez/DcNJ4lpBiWWlAJglq5QdbuLLIOHC5
         MdIuF/8k9HYFVpQLRbQ+8Kxj8DZ9t7ONoeKlvMnwpiBxc/+PU3YR97c0sSshrq8jz1
         fDeb52qd0fYrUJn4ut941v8DgvSOG5InuaQA+RgVoMiyLyEPyumEskJ9OtKZrRKAoO
         vDwvwkg+u6gX2ZOMDcGcqcdWubdsKDhvqNyNUiZA3ievQ7PlC2hmgrNf6GcdLMvJz9
         ymV7fu+ecAmZg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-15f97c478a8so13428750fac.13;
        Sun, 05 Feb 2023 17:08:04 -0800 (PST)
X-Gm-Message-State: AO0yUKXY0Jm0nxyXWB+i+oU4vCuCvx6uAv3c5KOUY3z9c9vlRZiMaPV3
        iLVt1EyWCaY5KpZwXyYS3ByAhWd0tOtsmv4dn74=
X-Google-Smtp-Source: AK7set8xoNkkqvVBNjBk9EbvclUMut0KpNh/NqPcJOx0XYTEkZbTCC+vIzJ2aYHACMV0LfSIms6VOVMi0gK5faJxh+M=
X-Received: by 2002:a05:6870:110f:b0:160:3296:a9b9 with SMTP id
 15-20020a056870110f00b001603296a9b9mr1494289oaf.287.1675645684087; Sun, 05
 Feb 2023 17:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20230205163752.2535-1-rdunlap@infradead.org>
In-Reply-To: <20230205163752.2535-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 6 Feb 2023 10:07:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNASGAk3sAaK0bDiTMdWR2ocRcRs8UBLekRddv0mizQKxqg@mail.gmail.com>
Message-ID: <CAK7LNASGAk3sAaK0bDiTMdWR2ocRcRs8UBLekRddv0mizQKxqg@mail.gmail.com>
Subject: Re: [PATCH v2] parisc: update kbuild doc. aliases for parisc64
To:     Randy Dunlap <rdunlap@infradead.org>, Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 1:37 AM Randy Dunlap <rdunlap@infradead.org> wrote:
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
> v2: drop "parisc for 32 bit" part since "parisc" is not an alias
>
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
> +- parisc: parisc64 for 64 bit
>  - sh: sh for 32 bit, sh64 for 64 bit
>  - sparc: sparc32 for 32 bit, sparc64 for 64 bit
>




If Helge will pick this up, please feel free to add

Acked-by: Masahiro Yamada <masahiroy@kernel.org>





-- 
Best Regards
Masahiro Yamada
