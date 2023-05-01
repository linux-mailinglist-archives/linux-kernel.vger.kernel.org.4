Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B46F337B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjEAQTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 12:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjEAQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:19:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670DB171E
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 09:19:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so2055665b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682957962; x=1685549962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FGuwB8DZaGL5fmexOM8fuvxUhs14V0EADfy1lJEIKY=;
        b=Nyhxg6KoMv5DCAGM6mCPXn6ItenAW7c9QV20p31a0qYhzUuuPPWSPWIEunfg7MZGBX
         hvbJsvBo3U58pWAw2c/kzLOQD9kLiPrO9QMsDd8VQrqPikgs1wq+zpmPFHQoHQQ569Cy
         oTOiyB6hPuBk4CiO6pz8Fe2zoWRqemoOGGEzUT+dk/zKc6lKhWSQ7lhp4GHBG4Kyt+eU
         OH3MEzklYYBX4u7sk6s8IPDnNBCU1hsEL08Nv2qA8Hvoi+GhrZ2f+H+kkWkLB8XpVuRY
         CBn0WlzlKP0alqt8rt8XACki8K5zYFOz2BaMXAdhGnP35ait50bb1lKSXSTzcVMgF/gW
         gP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682957962; x=1685549962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FGuwB8DZaGL5fmexOM8fuvxUhs14V0EADfy1lJEIKY=;
        b=ddUMRCL3uGKATOj2aTDAdj9K82W7lX/EN06xrTkkkkuEWZIG39dwa5aGLq1+yhnHX6
         3kzx0xveM/HokTZmw0eJUPIjE0/fjJFQZjnUyvjI8qChAVRYy/t57Wtxx1sRVXFLpwFO
         EiEeHGx+y7JENlrg9yBb+WLcXtobrJsKPVIphwmIYyNfJ/3IjzP6OwPbQbMat5bs8O3Y
         GF2+H2Oul1CY0/B+3O5f85BJiY8PQhcKmtt712UxNsnbIvTqGxgM64FPsBcRFns/3lB4
         AZl2QKfYj0vfsZOyrSaLQKJwg6plGV4b79B9j1mdkCJTdRu4Dxf+wTcpv3/iz+9kEY+g
         9ySw==
X-Gm-Message-State: AC+VfDwQsFo4+KStR7xmZS45sqebjEZqSyAhJchbm/thk4tKV5nm+GNN
        5vmSTcxPTFCz2vWyr2rQT74kewtNrLuSlRrJTXYRsA==
X-Google-Smtp-Source: ACHHUZ6RwItANJ/R5G0kwGBHYfYxEFLhUkM0VFd5rJeaVtkIhzWcYIQu18UznRkT5L5a5Vr226WpFX8ruirZ7cWLUO8=
X-Received: by 2002:a05:6a20:1588:b0:f9:1f3e:cccb with SMTP id
 h8-20020a056a20158800b000f91f3ecccbmr17087658pzj.10.1682957961585; Mon, 01
 May 2023 09:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org> <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org>
In-Reply-To: <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 May 2023 09:19:10 -0700
Message-ID: <CAKwvOd=9RMivtkKX27nDDsagH5yCWjpAOvpE2uaW38KYC57vtg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Simon Horman <horms@kernel.org>, llvm@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 1, 2023 at 5:39=E2=80=AFAM Ricardo Ribalda <ribalda@chromium.or=
g> wrote:
>
> If PGO is enabled, the purgatory ends up with multiple .text sections.
> This is not supported by kexec and crashes the system.
>
> Cc: stable@vger.kernel.org
> Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory=
")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Hi Ricardo,
Thanks for the series.  Does this patch 4/4 need a new online commit
description? It's not adding a linker script (maybe an earlier version
was).

> ---
>  arch/riscv/purgatory/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefil=
e
> index 5730797a6b40..cf3a44121a90 100644
> --- a/arch/riscv/purgatory/Makefile
> +++ b/arch/riscv/purgatory/Makefile
> @@ -35,6 +35,11 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
>  CFLAGS_string.o :=3D -D__DISABLE_EXPORTS
>  CFLAGS_ctype.o :=3D -D__DISABLE_EXPORTS
>
> +# When profile optimization is enabled, llvm emits two different overlap=
ping
> +# text sections, which is not supported by kexec. Remove profile optimiz=
ation
> +# flags.
> +KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D% -fprofile-use=
=3D%,$(KBUILD_CFLAGS))
> +
>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>  # also link a purgatory.chk binary without -r to check for unresolved sy=
mbols.
>  PURGATORY_LDFLAGS :=3D -e purgatory_start -z nodefaultlib
>
> --
> 2.40.1.495.gc816e09b53d-goog
>


--=20
Thanks,
~Nick Desaulniers
