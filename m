Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2376D66153C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjAHMwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjAHMwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 07:52:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA66DEE0;
        Sun,  8 Jan 2023 04:52:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC9E860C63;
        Sun,  8 Jan 2023 12:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB18C433EF;
        Sun,  8 Jan 2023 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673182327;
        bh=VnGhcg4zxSgX4xZuHSdJDrQ5iUTrHtILPmmSMksv9w4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YN9YXrawrN7Sr+6pEtFesgn7DnMKXFAafpFaVD8IQ0u8xkhDMFzSDvZa870mFptgZ
         0gaVXH32i+vZSDaHlwnhg4Eb6D3l6adXFu0o3uFya3nXuVeu0Z7Bh1FzVjxofjxpeu
         PeyhOzxY32WVpAl6hKG8ioiS3aedaL15Ckd7xa2bxFxZQy0jjOfS/S6JKfycvgCyGv
         4xu+ofN7i80kqvQFMolXP5XMhCJOSWXey5/XCsDOnlBB3dov6A1MCfq0XOnYzNMPIk
         jt75SlUQJmlGeCdcuv3jT89Vp7aCcmf0mCf88j4AUxB50Dd8P/uv4csTMLJHfYK5K5
         JzMdrFkZdwdaw==
Received: by mail-oi1-f174.google.com with SMTP id c133so4989393oif.1;
        Sun, 08 Jan 2023 04:52:07 -0800 (PST)
X-Gm-Message-State: AFqh2kpvGOXDN4W2ng06czwxjGaTiEjB8ewr+amATGEAha+Vz7OhAIYS
        xL8L3KB59yYfO8ajGgOXl3guglSzOTcWK3axtwM=
X-Google-Smtp-Source: AMrXdXu5aNI5c7PDY2/YYpeRfYOcd4kjo2KqcZg51Q1nIVZmiL1vxxXX13wDKne+iSFJbbCp4lwz/gvTYsoUERygPrA=
X-Received: by 2002:aca:3755:0:b0:35e:7c55:b015 with SMTP id
 e82-20020aca3755000000b0035e7c55b015mr3677001oia.287.1673182326467; Sun, 08
 Jan 2023 04:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20230107143747.64802-1-ojeda@kernel.org>
In-Reply-To: <20230107143747.64802-1-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 8 Jan 2023 21:51:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNARWCeYew_sWmYYnrm87vYDBLs0LQOdc0XkCUy+b45zmBQ@mail.gmail.com>
Message-ID: <CAK7LNARWCeYew_sWmYYnrm87vYDBLs0LQOdc0XkCUy+b45zmBQ@mail.gmail.com>
Subject: Re: [PATCH] docs: kbuild: remove mention to dropped $(objtree) feature
To:     ojeda@kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 7, 2023 at 11:38 PM <ojeda@kernel.org> wrote:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> Commit 8d613a1d048c ("kbuild: drop $(objtree)/ prefix support
> for clean-files") dropped support for prefixing with $(objtree).
>
> Thus update the documentation to match that change.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>


Applied to linux-kbuild/fixes.
Thanks.


> ---
>  Documentation/kbuild/makefiles.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> index 6b7368d1f516..38bc74eaa547 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -1042,7 +1042,7 @@ $(clean-files).
>
>  When executing "make clean", the file "crc32table.h" will be deleted.
>  Kbuild will assume files to be in the same relative directory as the
> -Makefile, except if prefixed with $(objtree).
> +Makefile.
>
>  To exclude certain files or directories from make clean, use the
>  $(no-clean-files) variable.
>
> base-commit: 88603b6dc419445847923fcb7fe5080067a30f98
> --
> 2.39.0
>


-- 
Best Regards
Masahiro Yamada
