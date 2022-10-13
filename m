Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51985FE5C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 01:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJMXHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 19:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJMXHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 19:07:02 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3180169132;
        Thu, 13 Oct 2022 16:07:00 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id v81so1524611vkv.5;
        Thu, 13 Oct 2022 16:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a5ykvIMx9PXDw/XbQTEsr1TUV23I2THVBFGAGMxhGXA=;
        b=UfwjEZiN368Fnrmu/LyULdyFVi4rljZMl8+CKtolWmF63TXFiB/dRMvcer1DaELOFp
         BvFChJx/iI29Tqu0uzlVGt8fT8zRrpG6HgPOPN8vf0Pe//wDruZzzgQ/e90HnCgKCZyf
         qGpkVKKHTLUbpHiOmVvQTHS7PwfvwI8Ew8E/BWYpdDeIglq4VdhJmErvGTxdX5F5XzMk
         uwe7njsQ2eZzIkVbMye/FKOBALS2oCP/ZcS32I+s2y1XD1lD3FhYXOLL3GhsJQxuna0s
         DBHuSNNvo39rq7y2jdC7yLDKbvAEI2wGL4XEuAy5zjOIBEAKPieL61b/egcb+xVPrB7z
         Fk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5ykvIMx9PXDw/XbQTEsr1TUV23I2THVBFGAGMxhGXA=;
        b=sAFNNUvxZZdn6xefwM8u4czzkUx8X291YQsuUM8ACjtjR1t74cDXqlfhJTPVhXJzEj
         jiC8Xt0q6Lp72qNjRMdTJCXwrR6KpuBpy++AW1zyBvbGRubBrLjJORiomVvQtBjI7UL1
         yp6eM6GM0J32V4GHSgA9Ea9btzz34DoRGGfPJsUCCLouiMfmzi4gE6SlSA5/JAFJks8H
         vH3GIgA8FrYXmu2SuTkgDL4VrrSCNxiG264rpqfWyaUvZyC/LYtxDZibS2u8NRT92P5R
         KrEP+MwW+vZA7sTafEcM/ObxhvWwPHIhpP+rILR3cVJQBuPQ3c68FOUD4pZyvQDjntuD
         B8/Q==
X-Gm-Message-State: ACrzQf13+Bpg5ad8MRopGJdG/vCOea3dGvaxYG/cAiV6eq+Wz2FHEDUk
        tg2vIOPrH4O4Qq9rVww0l2PAuxZYXt3kNCzbmZplRdiyuBE=
X-Google-Smtp-Source: AMsMyM5O3zogUSMGwBaJCFRAJCXyeGC2bapeIsjJtH+otYOPE8Vq9VdmZzJTtZ2dy82/hvYQerzNovmXTq658t0MfjY=
X-Received: by 2002:a1f:43cc:0:b0:3ab:ad61:bf73 with SMTP id
 q195-20020a1f43cc000000b003abad61bf73mr1120368vka.33.1665702419877; Thu, 13
 Oct 2022 16:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221013214638.30933-1-palmer@rivosinc.com>
In-Reply-To: <20221013214638.30933-1-palmer@rivosinc.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 14 Oct 2022 08:06:43 +0900
Message-ID: <CAKFNMonU3aVqwRdxyFefBJMg0-XC9j8bE-qYZ-9xx-4--NdkGg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for konis
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 6:49 AM Palmer Dabbelt wrote:
>
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d118acdce8b8..c9c396e2d8a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14363,7 +14363,7 @@ L:      linux-nilfs@vger.kernel.org
>  S:     Supported
>  W:     https://nilfs.sourceforge.io/
>  W:     https://nilfs.osdn.jp/
> -T:     git git://github.com/konis/nilfs2.git
> +T:     git https://github.com/konis/nilfs2.git
>  F:     Documentation/filesystems/nilfs2.rst
>  F:     fs/nilfs2/
>  F:     include/trace/events/nilfs2.h
> --
> 2.38.0
>

Ah, that's right, it needs to be fixed.

I'll pick this up unless it's decided to apply similar fixes all at once.
Thank you.

Ryusuke Konishi
