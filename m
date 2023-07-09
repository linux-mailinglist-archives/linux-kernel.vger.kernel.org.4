Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDBF74C0C3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 05:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjGIDwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 23:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGIDwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 23:52:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C078C1BC
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 20:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B6B260B6A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 03:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810D8C433C8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 03:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688874750;
        bh=QbeU9C1eV5NDrPryCedGiMb3A34VmKXr6ljBa+OLAhs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rfnGvzRgMUPnuMufh52HzW6da7ZRdVt83aUppo/e2b7cvML58MH/Oc9Vx850G/l3d
         dXKEoi/6xuJ7eDwOvsMuK3tf9DoQxbCbYtfRf7E6Jywq0ZmnFVuKyZu5M5qH4obhVK
         rj2xBYHNTBwQdfiH2O8jsnSlopew5jaqM+T/MFv2AmL/hfyqFmyK8iHnZt5XMy8e2d
         NSJ4s8ljG5EepetIsnMdCdyqb/m0bXjHR1IzUVsiYiLQtpr6hCAYuwyl885QHGdtqV
         YzOmFLaaz1JhgazozHnFVAFOM4BZYUisY8PYMpuxj5Gz8/Xiw9k72r0EvWu/4qpXIX
         TXai3TxCQacRw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso4502655a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 20:52:30 -0700 (PDT)
X-Gm-Message-State: ABy/qLYjY4GjNzGbGdC55XSH5tSu/NorQd3kgPDSKamrmCzBAuU1f9bB
        wsAkPblhmpfHxbcKbarjvXUurgPslyD655h2pLk=
X-Google-Smtp-Source: APBJJlGNCUL6QDorEqtymyKx6PttpF9SBpMnoOu55iTaodjTA54nw7G5G8NBbW3t3qfwZPJ/SI56nv5qiI+a46v3Rc4=
X-Received: by 2002:aa7:d3cc:0:b0:51e:ca7:a107 with SMTP id
 o12-20020aa7d3cc000000b0051e0ca7a107mr6981521edr.31.1688874748799; Sat, 08
 Jul 2023 20:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230701083247.177482-1-xry111@xry111.site>
In-Reply-To: <20230701083247.177482-1-xry111@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 9 Jul 2023 11:52:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H623HAbKBp5emSo_-gL-7bJmA3TfqkmajS+PKABPwUdYw@mail.gmail.com>
Message-ID: <CAAhV-H623HAbKBp5emSo_-gL-7bJmA3TfqkmajS+PKABPwUdYw@mail.gmail.com>
Subject: Re: [PATCH] loongarch: loongson3_defconfig: Enable CONFIG_JUMP_LABEL
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

This has already been enabled here [1] for the next cycle.

[1] https://github.com/chenhuacai/linux/commit/03f4dca2d838b34aa8618b9d378a=
fb706f810d56

Huacai

On Sat, Jul 1, 2023 at 4:33=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> As it's an optimization without any real disadvantages, let's enable it
> like the defconfig of other architecture supporting it.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/configs/loongson3_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/=
configs/loongson3_defconfig
> index 6cd26dd3c134..33a0f5f742f6 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -63,6 +63,7 @@ CONFIG_EFI_ZBOOT=3Dy
>  CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=3Dy
>  CONFIG_EFI_CAPSULE_LOADER=3Dm
>  CONFIG_EFI_TEST=3Dm
> +CONFIG_JUMP_LABEL=3Dy
>  CONFIG_MODULES=3Dy
>  CONFIG_MODULE_FORCE_LOAD=3Dy
>  CONFIG_MODULE_UNLOAD=3Dy
> --
> 2.41.0
>
>
