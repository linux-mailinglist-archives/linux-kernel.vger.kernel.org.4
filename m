Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7C274CB53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjGJElH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGJElF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:41:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177CE10C
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 21:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A989460DCF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DBAC43397;
        Mon, 10 Jul 2023 04:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688964064;
        bh=mv//6hNwk9M6NPBEMlu0lBzYoJfCRXlFZFV1BMnomHs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hQ3xhU9RyNnpwHFmPtb1JEi3QSDyRc+Ly9ZHnskvF9AW1crjOxtyXBpBB1xRUrkm+
         HenjCvTqG+UIgFfclX24vhuAEUFeu6yICjXLff88N6L+mCavjsgzU/owu8tCizjpAn
         ewhmtMvqvswX+NzQhHx+kO39OTkwbH7caDD6KCupnl6zqs9QcT21mUfZNB89GRIHU4
         eRy+hK2lLwdTuBFN3pwXWHa/CE7e/RSkDIFwW+JrSuTMT3YTlVzM5qjwkBccdR2iiW
         9PiJIDgy7IP2STq2gpSGpHEefnaycIBtUZ5Gt4kYf3ub4E0Q+zv0iDw2LlYANSE62G
         oC0h4T1xqQmHw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so9956353a12.0;
        Sun, 09 Jul 2023 21:41:03 -0700 (PDT)
X-Gm-Message-State: ABy/qLbavVDJJ8jz8mQmgGznqludWKUWRWoZm/xsZbhGrwVTwo2II7ix
        sZ/lP2xn3RYdIJP9r0gZEJt4IrA3Nunos9HHOcM=
X-Google-Smtp-Source: APBJJlE24fzgM5W0er2eZb1A+JkFH2SlI7nTJD6AILFEyjyQ2t6Gb3sEBHHiyn/fNNkYY0OvDUVpzlHRv4JgWAldyYg=
X-Received: by 2002:a05:6402:4304:b0:51e:4a1e:5f7a with SMTP id
 m4-20020a056402430400b0051e4a1e5f7amr8606822edc.4.1688964062079; Sun, 09 Jul
 2023 21:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230710015120.44818-1-jianghaoran@kylinos.cn>
In-Reply-To: <20230710015120.44818-1-jianghaoran@kylinos.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 10 Jul 2023 12:40:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6s3N=-brDz24PfrtEKNFjvnLjbDR2NpOVDF_fN7rA53A@mail.gmail.com>
Message-ID: <CAAhV-H6s3N=-brDz24PfrtEKNFjvnLjbDR2NpOVDF_fN7rA53A@mail.gmail.com>
Subject: Re: [PATCH] samples/bpf: Fix compilation failure for samples/bpf on
 Loongarch Fedora
To:     Haoran Jiang <jianghaoran@kylinos.cn>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        llvm@lists.linux.dev, bpf@vger.kernel.org, trix@redhat.com,
        ndesaulniers@google.com, nathan@kernel.org, jolsa@kernel.org,
        haoluo@google.com, sdf@google.com, kpsingh@kernel.org,
        john.fastabend@gmail.com, yhs@fb.com, song@kernel.org,
        martin.lau@linux.dev, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org, kernel@xen0n.name, yangtiezhu@loongson.cn
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

Please use LoongArch instead of Loongarch in the title and commit message.

Huacai

On Mon, Jul 10, 2023 at 10:08=E2=80=AFAM Haoran Jiang <jianghaoran@kylinos.=
cn> wrote:
>
> When building the latest samples/bpf on Loongarch Fedora
>
>      make M=3Dsamples/bpf
>
> There are compilation errors as follows:
>
> In file included from ./linux/samples/bpf/sockex2_kern.c:2:
> In file included from ./include/uapi/linux/in.h:25:
> In file included from ./include/linux/socket.h:8:
> In file included from ./include/linux/uio.h:9:
> In file included from ./include/linux/thread_info.h:60:
> In file included from ./arch/loongarch/include/asm/thread_info.h:15:
> In file included from ./arch/loongarch/include/asm/processor.h:13:
> In file included from ./arch/loongarch/include/asm/cpu-info.h:11:
> ./arch/loongarch/include/asm/loongarch.h:13:10: fatal error: 'larchintrin=
.h' file not found
>          ^~~~~~~~~~~~~~~
> 1 error generated.
>
> larchintrin.h is included in /usr/lib64/clang/14.0.6/include,
> and the header file location is specified at compile time.
>
> Test on Loongarch Fedora:
> https://github.com/fedora-remix-loongarch/releases-info
>
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> ---
>  samples/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 615f24ebc49c..b301796a3862 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -434,7 +434,7 @@ $(obj)/%.o: $(src)/%.c
>         @echo "  CLANG-bpf " $@
>         $(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS=
) \
>                 -I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
> -               -I$(LIBBPF_INCLUDE) \
> +               -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
>                 -D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-poi=
nter-sign \
>                 -D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-=
types \
>                 -Wno-gnu-variable-sized-type-not-at-end \
> --
> 2.27.0
>
