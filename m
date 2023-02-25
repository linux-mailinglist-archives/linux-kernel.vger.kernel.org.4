Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FBF6A27EB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 09:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBYImB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 03:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 03:42:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F0F18B04;
        Sat, 25 Feb 2023 00:41:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B9221CE1AD8;
        Sat, 25 Feb 2023 08:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2263C433A1;
        Sat, 25 Feb 2023 08:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677314515;
        bh=niO7O0Rmdw9flhWi+a16uXTnlS3H4K5/29E7AT4Kkgg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k5fwJL0WwGrJfwS27hW0bRt2bAUyt0q0hS+93q9GPT+JSZLl1d8D9rtiW8N/gWFtI
         /NSXd8zwlwBxdRm6/u8cq1HOOM8bl9Fq+5+ECSb0aWNA1dMvU57M2etZWAM1u0NpYv
         Tnbo24SdvLTRhfirPEArT9hbDGxeJy7wrPllFrGtOvJvd7CwNwTQREPM4kGaJEfFA0
         0oLhWSsIyxcv7LnMSKvrA1YCFqdM7V2xAcHQHyE0eicOMlzKQcVn4z6Nr3xt9we8ce
         VDoNtPqeDKSwTBjHEXUAqS+o7vzLsgfT+5ykT2wXQRQHKIhcnkRnQDkmz1SSsM38vf
         F/0aPFIg/Jj3A==
Received: by mail-ot1-f53.google.com with SMTP id t7-20020a9d7487000000b00693d565b852so934648otk.5;
        Sat, 25 Feb 2023 00:41:55 -0800 (PST)
X-Gm-Message-State: AO0yUKX0wTJ3LfMvDTf4nsoMypxqATTwZBNfheQ3iBzjTVBAwP+G3bmM
        L67ETOTSiOZchDrFRohyj80jWrBZirU2hL700Vs=
X-Google-Smtp-Source: AK7set+Fqkij0tc73KS9oJ1xY3lw9JJaSlccZOZYUv7IuOxhU2vVMVFxun0RKc7SENlSW/6JPBOc2/3wuR5KzFvOfAI=
X-Received: by 2002:a05:6830:26c2:b0:68b:df73:951e with SMTP id
 m2-20020a05683026c200b0068bdf73951emr2631430otu.1.1677314515076; Sat, 25 Feb
 2023 00:41:55 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230222104856epcas1p3a6ff45f90292df33ef5fd8216b812f64@epcas1p3.samsung.com>
 <1666a6a9-4757-0e1d-f807-618c95e0b6ae@gmail.com> <20230222104719.16374-1-sangmoon.kim@samsung.com>
In-Reply-To: <20230222104719.16374-1-sangmoon.kim@samsung.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 25 Feb 2023 17:41:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASMb+nwqV6PBs2UB5YnsjQPNJDeh_BwPypPb5auv4uiPQ@mail.gmail.com>
Message-ID: <CAK7LNASMb+nwqV6PBs2UB5YnsjQPNJDeh_BwPypPb5auv4uiPQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs: kbuild: remove description of KBUILD_LDS_MODULE
To:     Sangmoon Kim <sangmoon.kim@samsung.com>
Cc:     bagasdotme@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 7:49 PM Sangmoon Kim <sangmoon.kim@samsung.com> wrote:
>
> Commit 596b0474d3d9 ("kbuild: preprocess module linker script")
> removes KBUILD_LDS_MODULE, yet the variable is still mentioned in
> kbuild documentation. Remove the reference to the now-nonexistent
> variable.
>
> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
> ---
> Thank you for your review.
>
> Changes in v2:
>  - Update the commit message.
>
>  Documentation/kbuild/makefiles.rst | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> index 38bc74eaa547..468e7830c1c3 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -1250,11 +1250,6 @@ When kbuild executes, the following steps are followed (roughly):
>
>         The linker script with full path. Assigned by the top-level Makefile.
>
> -    KBUILD_LDS_MODULE
> -
> -       The module linker script with full path. Assigned by the top-level
> -       Makefile and additionally by the arch Makefile.
> -
>      KBUILD_VMLINUX_OBJS
>
>         All object files for vmlinux. They are linked to vmlinux in the same
> --
> 2.17.1
>

Applied to linux-kbuild.
Thanks.


-- 
Best Regards
Masahiro Yamada
