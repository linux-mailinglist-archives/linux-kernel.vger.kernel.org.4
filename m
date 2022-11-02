Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71D5616889
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiKBQW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiKBQVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:21:47 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1899A31F86
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:15:32 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-13c2cfd1126so20805995fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgdHlgFUL52ZSlgJoR2BWxLy/c2ChtXsX4iM/BXcyqc=;
        b=ho8Lt6cCmihgvDFQsW1Yod9zxSYinMTGeBkJpi7Z9kRRm94PktrqsKojXGwz8PTa22
         ylgX6D5aVmt463Z5uEMjQ5mYf/FrjayBb94syCzgDLnttyg9Ph9Kzd6ZYgx9PNQ4B5+Z
         RKEflZvPevS8Y+vjindMbLmh3ku4RuY64NutN+HMb/lgzYK42JB9eRsb2SEilvLnPsmx
         sdBBL5lC/5ObFeW4jhfOQMtHraKfShq/EVfFhYdVFGx02ndLkGcbwxOtEsfttViwAh4g
         c5JHz3n4NrKqr5Vy+UmIcpuBZmX/zi8dcyXea4Jyn8WdzlRpzz7xFuFQzB+xOnp+wL3n
         2Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgdHlgFUL52ZSlgJoR2BWxLy/c2ChtXsX4iM/BXcyqc=;
        b=Fjy2v8hRnW+fz3lvzawTxZ4dOWLZpczbw03EF5UvC5MTjapEVGRByVz2bjYar/x49n
         6i7KrRMdKWpXi01Of8iwq2VpFrerLgw6sBby5iItF2k8U+fbkeHLXPUjJZzc2veLJGcd
         9KwOZugTwusQIErZpvG8MW8L8G/rNMWjvwzGoGHyIcfd/IS3kDkub5P0fG2w0/OKLih8
         IliRP4v685uhMiw6p6VimII2kBYdH4EwdIdEj6avwyRVjlYeTjhfcf7UCXWubsvEWpIz
         4TH0M4lJOZ8tUqyaXrfnbKl5N9YGobeFkuUz8CRcdDBY9avne+Sf/LUOxG3ln/2NUNP3
         HfeA==
X-Gm-Message-State: ACrzQf2G185BocogaO+Gb+XYNaECMxfcAqJMQ70ZHQl6KgcYos8z4bZO
        PKU3/wtp1a26qPzQQ/YzjC3WIVC7h5oyrfhMmU3t4k+Y
X-Google-Smtp-Source: AMsMyM4e5KRS5+wtnu+5IMwyVsDM0J1Z9m0fl9VvwJLdX+CyYgyy3luD7SpqwqGASkuDfYCIT1DxBn+1OauaueJkz1Y=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr15352738oao.96.1667405731170; Wed, 02
 Nov 2022 09:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221102152540.2389891-1-nathan@kernel.org> <20221102152540.2389891-2-nathan@kernel.org>
 <202211020842.8B8E29F8@keescook>
In-Reply-To: <202211020842.8B8E29F8@keescook>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Nov 2022 12:15:20 -0400
Message-ID: <CADnq5_NFtZHzOC2o1yq6VjqT8DYB+q200R_xjf+b1qZonRh4=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix type of second parameter in
 odn_edit_dpm_table() callback
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@lists.linux.dev, amd-gfx@lists.freedesktop.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied the series.  Thanks!

Alex

On Wed, Nov 2, 2022 at 11:43 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Nov 02, 2022 at 08:25:40AM -0700, Nathan Chancellor wrote:
> > With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> > indirect call targets are validated against the expected function
> > pointer prototype to make sure the call target is valid to help mitigat=
e
> > ROP attacks. If they are not identical, there is a failure at run time,
> > which manifests as either a kernel panic or thread getting killed. A
> > proposed warning in clang aims to catch these at compile time, which
> > reveals:
> >
> >   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:3008:29: error: i=
ncompatible function pointer types initializing 'int (*)(void *, uint32_t, =
long *, uint32_t)' (aka 'int (*)(void *, unsigned int, long *, unsigned int=
)') with an expression of type 'int (void *, enum PP_OD_DPM_TABLE_COMMAND, =
long *, uint32_t)' (aka 'int (void *, enum PP_OD_DPM_TABLE_COMMAND, long *,=
 unsigned int)') [-Werror,-Wincompatible-function-pointer-types-strict]
> >           .odn_edit_dpm_table      =3D smu_od_edit_dpm_table,
> >                                      ^~~~~~~~~~~~~~~~~~~~~
> >   1 error generated.
> >
> > There are only two implementations of ->odn_edit_dpm_table() in 'struct
> > amd_pm_funcs': smu_od_edit_dpm_table() and pp_odn_edit_dpm_table(). One
> > has a second parameter type of 'enum PP_OD_DPM_TABLE_COMMAND' and the
> > other uses 'u32'. Ultimately, smu_od_edit_dpm_table() calls
> > ->od_edit_dpm_table() from 'struct pptable_funcs' and
> > pp_odn_edit_dpm_table() calls ->odn_edit_dpm_table() from 'struct
> > pp_hwmgr_func', which both have a second parameter type of 'enum
> > PP_OD_DPM_TABLE_COMMAND'.
> >
> > Update the type parameter in both the prototype in 'struct amd_pm_funcs=
'
> > and pp_odn_edit_dpm_table() to 'enum PP_OD_DPM_TABLE_COMMAND', which
> > cleans up the warning.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> > Reported-by: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
