Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57CD65BB9A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbjACIIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjACIIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:08:43 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603592DD3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:08:41 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso15959953wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 00:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTwliKrauQumjNtvyJtaaJlzR8NJFQTmYrGQuZ3mV6o=;
        b=HJ5Nh/gkBbPAxieY2i0xdRjATfzppgZ9Iywl2e/BN9DZyfXTNfWn9TstyEtT7IQh1z
         cquYgBCD1/bN6cEL6eD5OWKGSGgJfJpm41vkrAEePvuEtlyW4b5Q0LFFrMwr3ko+pF+F
         WE3Gr5aTgHMm10GXKNxW9CM7pAECq9Xz3caGh3t+nT0QmjaUtIkEEFKuMGDrnUfdzaq9
         MAXxsGCv4Z+b8D9GxtDuA1U7814mOHj+vEBupY3QNgNDqmRW7ulMfo67mHYfexNSh88Y
         /MR4qdDwR8LR7n8MWbPOiZ+v7/el4ij1obXqZ8LEve3D8HJeC5oJm6cegrJvSFZNa8Ws
         Fw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTwliKrauQumjNtvyJtaaJlzR8NJFQTmYrGQuZ3mV6o=;
        b=LDePuXR5OxcesbJDQlLMZjhDG5hGGc/XnfN8DdPGdNts6IaL4KFtCzV+6WWerwfoiu
         z8t+TtjyMfv4bxuVyhCouOqBxlk8PCB1zY4hm0LFkTcYatFrHY8BCvunRA+1WUpHitOX
         y833dboKETFXMoqybQkYNtGflkQrOwIoQmpBFS8KN3sqmG1ur+TSQIDaHnTi5embYnv+
         wWMob1c3C614/V8bi63d4xmQQgfjKiQjDLERfgF8/A1kukJoda0Uas51Li4/0WitqRAN
         vRMXSsQKxXFbQmnSHc+mfggEAu1eX+6y0FyW0eYCq/FPCjXBAH84SLQFUT5+qPb7TCeg
         QZMQ==
X-Gm-Message-State: AFqh2kr2tjoHue4xcqbLLO0xsWqp603gv3AOahArZk4JP5Xfp2ebgzRb
        GCVqwtFFeMxbl3A4YHCT5cwDlt1x7ghD1d7FZ/9L3g==
X-Google-Smtp-Source: AMrXdXt72wOgqyvi0xQOSBls64b8m/WUQsSDgIVp6L2IqkXkthXW1vd381QXl5DkooAdUWxVuzWB/CS33NGuB9dtEW4=
X-Received: by 2002:a7b:cb97:0:b0:3c6:e1b5:71c2 with SMTP id
 m23-20020a7bcb97000000b003c6e1b571c2mr2506841wmi.94.1672733319900; Tue, 03
 Jan 2023 00:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20221231053421.2039591-1-yoochan1026@gmail.com>
 <202301020326.pzL5zDsa-lkp@intel.com> <CALQpDLcLghTY44YumjGj8McLsTUDkcxTKMOmjA5-oqEPGBG3ww@mail.gmail.com>
In-Reply-To: <CALQpDLcLghTY44YumjGj8McLsTUDkcxTKMOmjA5-oqEPGBG3ww@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 3 Jan 2023 09:08:29 +0100
Message-ID: <CAHUa44GDB592mgJsmYzFetM_T+VvwAn5LMoj77KnQFSNEM4nOw@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: ffa_abi: Fix use-after-free in optee_ffa_open
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

On Mon, Jan 2, 2023 at 1:17 AM Yoochan Lee <yoochan1026@gmail.com> wrote:
>
> I fix the error in the previous patch.
>
> From fde49d86f6401789ba51f267a0d79fbe4e7ffc24 Mon Sep 17 00:00:00 2001
> From: Yoochan Lee <yoochan1026@gmail.com>
> Date: Mon, 2 Jan 2023 09:16:05 +0900
> Subject: [PATCH 2/2] fix errors in previous patch
>
> ---
>  drivers/tee/optee/ffa_abi.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

Please fix up the original patch and post it as a v2. By the way, have
you tried to test this in some way?

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index ea76d7532419..65d9463d9ed8 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -741,28 +741,23 @@ static void optee_ffa_delete(struct kref *kref)
>
>  static void optee_ffa_release(struct tee_context *ctx)
>  {
> - struct optee *optee =3D tee_get_drvdata(teedev);
> -
> - optee_release_helper(ctx, optee_close_session_helper);
> + struct optee *optee =3D tee_get_drvdata(ctx->teedev);
> +
> + optee_release(ctx);
>   kref_put(&optee->refcnt, optee_ffa_delete);
>  }
>
>  void optee_ffa_release_supp(struct tee_context *ctx)
>  {
>   struct optee *optee =3D tee_get_drvdata(ctx->teedev);
> -
> - optee_release_helper(ctx, optee_close_session_helper);
> - if (optee->scan_bus_wq) {
> - destroy_workqueue(optee->scan_bus_wq);
> - optee->scan_bus_wq =3D NULL;
> - }
> - optee_supp_release(&optee->supp);
> +
> + optee_release_supp(ctx);
>   kref_put(&optee->refcnt, optee_ffa_delete);
>  }
>
>  static int optee_ffa_open(struct tee_context *ctx)
>  {
> - struct optee *optee =3D tee_get_drvdata(teedev);
> + struct optee *optee =3D tee_get_drvdata(ctx->teedev);
>   kref_get(&optee->refcnt);
>
>   return optee_open(ctx, true);
> --
> 2.39.0
>
> 2023=EB=85=84 1=EC=9B=94 2=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 5:12, =
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
optee-ffa_abi-Fix-use-after-free-in-optee_ffa_open/20221231-133611
> > patch link:    https://lore.kernel.org/r/20221231053421.2039591-1-yooch=
an1026%40gmail.com
> > patch subject: [PATCH] tee: optee: ffa_abi: Fix use-after-free in optee=
_ffa_open
> > config: arm-randconfig-c002-20221231
> > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project f5=
700e7b69048de958172fb513b336564e7f8709)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm cross compiling tool for clang build
> >         # apt-get install binutils-arm-linux-gnueabi
> >         # https://github.com/intel-lab-lkp/linux/commit/3fe68a00d912f9e=
5dbec5002a7d30cf2a0868679
> >         git remote add linux-review https://github.com/intel-lab-lkp/li=
nux
> >         git fetch --no-tags linux-review Yoochan-Lee/tee-optee-ffa_abi-=
Fix-use-after-free-in-optee_ffa_open/20221231-133611
> >         git checkout 3fe68a00d912f9e5dbec5002a7d30cf2a0868679
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
> > All error/warnings (new ones prefixed by >>):
> >
> > >> drivers/tee/optee/ffa_abi.c:744:40: error: use of undeclared identif=
ier 'teedev'
> >            struct optee *optee =3D tee_get_drvdata(teedev);
> >                                                  ^
> > >> drivers/tee/optee/ffa_abi.c:746:2: error: call to undeclared functio=
n 'optee_release_helper'; ISO C99 and later do not support implicit functio=
n declarations [-Wimplicit-function-declaration]
> >            optee_release_helper(ctx, optee_close_session_helper);
> >            ^
> >    drivers/tee/optee/ffa_abi.c:746:2: note: did you mean 'optee_release=
_supp'?
> >    drivers/tee/optee/optee_private.h:258:6: note: 'optee_release_supp' =
declared here
> >    void optee_release_supp(struct tee_context *ctx);
> >         ^
> >    drivers/tee/optee/ffa_abi.c:754:2: error: call to undeclared functio=
n 'optee_release_helper'; ISO C99 and later do not support implicit functio=
n declarations [-Wimplicit-function-declaration]
> >            optee_release_helper(ctx, optee_close_session_helper);
> >            ^
> > >> drivers/tee/optee/ffa_abi.c:750:6: warning: no previous prototype fo=
r function 'optee_ffa_release_supp' [-Wmissing-prototypes]
> >    void optee_ffa_release_supp(struct tee_context *ctx)
> >         ^
> >    drivers/tee/optee/ffa_abi.c:750:1: note: declare 'static' if the fun=
ction is not intended to be used outside of this translation unit
> >    void optee_ffa_release_supp(struct tee_context *ctx)
> >    ^
> >    static
> >    drivers/tee/optee/ffa_abi.c:765:40: error: use of undeclared identif=
ier 'teedev'
> >            struct optee *optee =3D tee_get_drvdata(teedev);
> >                                                  ^
> >    1 warning and 4 errors generated.
> >
> >
> > vim +/teedev +744 drivers/tee/optee/ffa_abi.c
> >
> >    741
> >    742  static void optee_ffa_release(struct tee_context *ctx)
> >    743  {
> >  > 744          struct optee *optee =3D tee_get_drvdata(teedev);
> >    745
> >  > 746          optee_release_helper(ctx, optee_close_session_helper);
> >    747          kref_put(&optee->refcnt, optee_ffa_delete);
> >    748  }
> >    749
> >  > 750  void optee_ffa_release_supp(struct tee_context *ctx)
> >    751  {
> >    752          struct optee *optee =3D tee_get_drvdata(ctx->teedev);
> >    753
> >    754          optee_release_helper(ctx, optee_close_session_helper);
> >    755          if (optee->scan_bus_wq) {
> >    756                  destroy_workqueue(optee->scan_bus_wq);
> >    757                  optee->scan_bus_wq =3D NULL;
> >    758          }
> >    759          optee_supp_release(&optee->supp);
> >    760          kref_put(&optee->refcnt, optee_ffa_delete);
> >    761  }
> >    762
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
