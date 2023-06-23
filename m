Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0ED73BC3C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjFWP7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjFWP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:59:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435062117;
        Fri, 23 Jun 2023 08:59:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBE7261A7B;
        Fri, 23 Jun 2023 15:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4021EC433CD;
        Fri, 23 Jun 2023 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687535943;
        bh=2bFJMU3So3NBTW7ijNLYI2gISWF8dqUQVXuPeh/kvkY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bUTZP8SDIxUABVappp+RfH8pqqiuLRFYXGkqISImDFeugRpAX/pzC/kT8rvgYJ1zH
         mCBCgd4TYlsbSYqLQd9OOGtmGdxk9Ng0Ynf83jGWqPiNXc9bCRi2yqPTrr3zwQ7OPL
         ETslRZbJAtW4UoYIfFBoSbR60Fp8dittUxvuJ+M9p6y3JSHxXkFOlJxrZ1YOYxiNya
         FKlqFXqBPymJoNcBxbgwYWLkeFcOCd8sRj0BJV11YiQANy7DDtOo6pMdJR+GFeFVpP
         Z6iuZndzE5mdO9K5Oz86SMjbKV1pnUpZh6XivF5pOMvKOTwuJRWwBFsxzXokbD/ejY
         6L78vuYmJRyvw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51bec9aaf7bso873560a12.1;
        Fri, 23 Jun 2023 08:59:03 -0700 (PDT)
X-Gm-Message-State: AC+VfDwLfUxsLZrWk3byUrEyRKe+lvbe6O61CEWmkgUXCTeBV2ZDjid3
        kef+EenZBVsqGTzljjXVh2PDGjJuTgvNJ52WeDw=
X-Google-Smtp-Source: ACHHUZ73VdZYwOmOuPZQuN7YfQ1nzlTv9Gfx4hEIYaXmGijBO3eHdTtHmAflxxl8xS69lY2xrpRsQduL3Q1pD8xgOFo=
X-Received: by 2002:aa7:cd43:0:b0:51b:df62:4f0b with SMTP id
 v3-20020aa7cd43000000b0051bdf624f0bmr5189723edw.6.1687535941516; Fri, 23 Jun
 2023 08:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230623134351.1898379-1-kernel@xen0n.name> <20230623134351.1898379-9-kernel@xen0n.name>
In-Reply-To: <20230623134351.1898379-9-kernel@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 23 Jun 2023 23:58:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6MpuJX+tva_-8MhavSw+XgDCZKezee8t3wuRSpRbX0Fg@mail.gmail.com>
Message-ID: <CAAhV-H6MpuJX+tva_-8MhavSw+XgDCZKezee8t3wuRSpRbX0Fg@mail.gmail.com>
Subject: Re: [PATCH 8/9] Makefile: Add loongarch target flag for Clang compilation
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui,

This is the enablement patch, I think moving it to the last is better.

Huacai

On Fri, Jun 23, 2023 at 9:44=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> From: WANG Xuerui <git@xen0n.name>
>
> The LoongArch kernel is 64-bit and built with the soft-float ABI,
> hence the loongarch64-linux-gnusf target. (The "libc" part doesn't
> matter.)
>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
>  scripts/Makefile.clang | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 058a4c0f864e..6c23c6af797f 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -4,6 +4,7 @@
>  CLANG_TARGET_FLAGS_arm         :=3D arm-linux-gnueabi
>  CLANG_TARGET_FLAGS_arm64       :=3D aarch64-linux-gnu
>  CLANG_TARGET_FLAGS_hexagon     :=3D hexagon-linux-musl
> +CLANG_TARGET_FLAGS_loongarch   :=3D loongarch64-linux-gnusf
>  CLANG_TARGET_FLAGS_m68k                :=3D m68k-linux-gnu
>  CLANG_TARGET_FLAGS_mips                :=3D mipsel-linux-gnu
>  CLANG_TARGET_FLAGS_powerpc     :=3D powerpc64le-linux-gnu
> --
> 2.40.0
>
>
