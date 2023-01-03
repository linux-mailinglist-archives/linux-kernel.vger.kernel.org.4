Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5E465BB99
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbjACIIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjACIID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:08:03 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825CC7649
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:08:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso15969923wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 00:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPtt+PqO7/eJ9o2x3G9QMOyWUbtViBpnXxIT+kwxqD4=;
        b=omP4T8iceDSdVamXnCjxjSaoJNwDr4KE94kiBH5lXia/DTSH0QIbpvmXHzTpPsawZD
         NhIVvN+gx9W+MHqWYN3w6bswNlwgKP+faJdEtNPWSjaM8Q2w5JkLpManQQPop+oTRXxy
         IsTcNS8KwldoHWyMDPxoTyxfBinL8ak+nlV2WQYK5X6tYJK0oB1KhxVlbgtR0CKivW5v
         qYXolaPX8RCCiQRnzPiCgYAArsAu3r3XFN9zpjKWSAjw3UwMbgqtXJOK+wUZzq3ADhEr
         CWlAaMG8i1Fh0P99Ml0+/hIi0UPUKsD9VeCGeEnpRMZMhpvuUOs3+Jup45AO/hhN49mB
         32JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPtt+PqO7/eJ9o2x3G9QMOyWUbtViBpnXxIT+kwxqD4=;
        b=2/quXQpAdHZ+znHlPOuUu5kGwPMvejxpqfDO3AgTgRg3uJ4hdfOuMQyzoT98jG2XAN
         QrCFlsrc1Q3PeUXnYHm8oWpuwq5+byGTHnS3VKgR/qa4klRonUpH5SW4zRWi/wgs+IQH
         CW5+i+4Yr2u7KTnjtw6QJFb1EpW0d4T0ej28yggsfUHICU0mM2V8yJaqlKgzTXGXPzgI
         HzzOiY5cNfcazXeYz8u0pCA1opsclY5NFzHCQh5fgTFgWntQNJ8NVZu+qig0O8UKIHZ2
         kx9ekW2Tp8AUoEp7FQtVwsA48iiaJMPrZAWS3g6PwhhN+qKa1lfUSdB4S16xkTRHgTmo
         +yQA==
X-Gm-Message-State: AFqh2kr8P7njWi3Dld15GflSIPM7L5SjPNPWg12zC0R0vW9SF+wXSiJD
        +pdMf9Y/HzplWuJwHohUPx8kOC3XXQ0sI3U0qp68VA==
X-Google-Smtp-Source: AMrXdXtRWHjlevoC6i29DlUAEcwW1u2qHtkrFZujzVTCY73dGowZc7I3M4JMFP40OjpGDrM+0vGZaNzoi+KqkEmh6Qg=
X-Received: by 2002:a05:600c:54e7:b0:3cf:e0ef:1f6c with SMTP id
 jb7-20020a05600c54e700b003cfe0ef1f6cmr1437359wmb.75.1672733280976; Tue, 03
 Jan 2023 00:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20221231051954.2038772-1-yoochan1026@gmail.com>
 <202301020540.wMrbqIkY-lkp@intel.com> <CALQpDLd+eEYv=qkPOoPkRGe5RX2eTgUfj_pp838eDX39Cfke2w@mail.gmail.com>
In-Reply-To: <CALQpDLd+eEYv=qkPOoPkRGe5RX2eTgUfj_pp838eDX39Cfke2w@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 3 Jan 2023 09:07:50 +0100
Message-ID: <CAHUa44HpDg39ohLGV73rgswLxQ4J8RV+iRaGGri6aNqhGZspMQ@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: smc_abi: Fix use-after-free in optee_smc_open
To:     Yoochan Lee <yoochan1026@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 2, 2023 at 1:18 AM Yoochan Lee <yoochan1026@gmail.com> wrote:
>
> I fix the errors in the previous patch.
>
> From 2046cc19aeaddb5f6fb5e9b1d9a380a116892657 Mon Sep 17 00:00:00 2001
> From: Yoochan Lee <yoochan1026@gmail.com>
> Date: Mon, 2 Jan 2023 09:18:23 +0900
> Subject: [PATCH 2/2] fix errors in previous patch
>
> ---
>  drivers/tee/optee/smc_abi.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Please fix up the original patch and post it as a v2. By the way, have
you tried to test this in some way?

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 4fbec2acc255..be662f263f29 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1103,12 +1103,7 @@ static void optee_smc_release_supp(struct
> tee_context *ctx)
>  {
>   struct optee *optee =3D tee_get_drvdata(ctx->teedev);
>
> - optee_release_helper(ctx, optee_close_session_helper);
> - if (optee->scan_bus_wq) {
> - destroy_workqueue(optee->scan_bus_wq);
> - optee->scan_bus_wq =3D NULL;
> - }
> - optee_supp_release(&optee->supp);
> + optee_release_supp(ctx)
>   kref_put(&optee->refcnt, optee_smc_delete);
>  }
>
> @@ -1116,7 +1111,7 @@ static void optee_smc_release(struct tee_context *c=
tx)
>  {
>   struct optee *optee =3D tee_get_drvdata(ctx->teedev);
>
> - optee_release_helper(ctx, optee_close_session_helper);
> + optee_release(ctx);
>   kref_put(&optee->refcnt, optee_smc_delete);
>  }
>
> --
> 2.39.0
>
> 2023=EB=85=84 1=EC=9B=94 2=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 6:43, =
kernel test robot <lkp@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > Hi Yoochan,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on linus/master]
> > [also build test ERROR on v6.2-rc1 next-20221226]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Yoochan-Lee/tee-=
optee-smc_abi-Fix-use-after-free-in-optee_smc_open/20221231-132046
> > patch link:    https://lore.kernel.org/r/20221231051954.2038772-1-yooch=
an1026%40gmail.com
> > patch subject: [PATCH] tee: optee: smc_abi: Fix use-after-free in optee=
_smc_open
> > config: arm-randconfig-c002-20221231
> > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project f5=
700e7b69048de958172fb513b336564e7f8709)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm cross compiling tool for clang build
> >         # apt-get install binutils-arm-linux-gnueabi
> >         # https://github.com/intel-lab-lkp/linux/commit/6d3d5f78a2463a5=
77c1a908cdedda61affba9c01
> >         git remote add linux-review https://github.com/intel-lab-lkp/li=
nux
> >         git fetch --no-tags linux-review Yoochan-Lee/tee-optee-smc_abi-=
Fix-use-after-free-in-optee_smc_open/20221231-132046
> >         git checkout 6d3d5f78a2463a577c1a908cdedda61affba9c01
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
W=3D1 O=3Dbuild_dir ARCH=3Darm olddefconfig
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
W=3D1 O=3Dbuild_dir ARCH=3Darm SHELL=3D/bin/bash drivers/tee/optee/
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> drivers/tee/optee/smc_abi.c:1106:2: error: call to undeclared functi=
on 'optee_release_helper'; ISO C99 and later do not support implicit functi=
on declarations [-Wimplicit-function-declaration]
> >            optee_release_helper(ctx, optee_close_session_helper);
> >            ^
> >    drivers/tee/optee/smc_abi.c:1106:2: note: did you mean 'optee_releas=
e_supp'?
> >    drivers/tee/optee/optee_private.h:258:6: note: 'optee_release_supp' =
declared here
> >    void optee_release_supp(struct tee_context *ctx);
> >         ^
> >    drivers/tee/optee/smc_abi.c:1119:2: error: call to undeclared functi=
on 'optee_release_helper'; ISO C99 and later do not support implicit functi=
on declarations [-Wimplicit-function-declaration]
> >            optee_release_helper(ctx, optee_close_session_helper);
> >            ^
> >    2 errors generated.
> >
> >
> > vim +/optee_release_helper +1106 drivers/tee/optee/smc_abi.c
> >
> >   1101
> >   1102  static void optee_smc_release_supp(struct tee_context *ctx)
> >   1103  {
> >   1104          struct optee *optee =3D tee_get_drvdata(ctx->teedev);
> >   1105
> > > 1106          optee_release_helper(ctx, optee_close_session_helper);
> >   1107          if (optee->scan_bus_wq) {
> >   1108                  destroy_workqueue(optee->scan_bus_wq);
> >   1109                  optee->scan_bus_wq =3D NULL;
> >   1110          }
> >   1111          optee_supp_release(&optee->supp);
> >   1112          kref_put(&optee->refcnt, optee_smc_delete);
> >   1113  }
> >   1114
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
