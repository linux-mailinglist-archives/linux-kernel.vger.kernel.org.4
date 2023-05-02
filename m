Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6EA6F4786
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjEBPnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjEBPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:43:28 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0491AE
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:43:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f00d41df22so29117819e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683042205; x=1685634205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksBtAvIT0tt+UGPpxO6Jblux7JGuQy9A1nRJOgAb9pI=;
        b=px5MHukmh1ug97m+YREdCGgo5TYWBkkeuiP1JpoH4jJuen9G2YruZPJ2pwUikB5Jjs
         OII9ImsB414NzKGuby4YETq4QlnDMxEn5O1fxOs/6bCrLnDKISoXpQt6AIltksRQuXDD
         uKyYJrMZ6zZuyV3grj7SjD6sdqGuUokOrIsfbQWCxVyWC3JgazKweGYCUrq3tapfy0cw
         9MCXz+ld4bKorpOOfJkqtn1miDLL6sHboEn7F9UM7aIReSkx88lAcCWtuiHN5JrNCYif
         MgRVmRur/HIZuPV7hxggJ6DrDQL5Jxo/AoNH/NPdzslaBnCPpkdvILMcV0l0W6GM2Gk7
         9GCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683042205; x=1685634205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksBtAvIT0tt+UGPpxO6Jblux7JGuQy9A1nRJOgAb9pI=;
        b=QOPUoqBx1jJnSLlOcaDYwfKCTmZeTfF++p7xXdH7cNgBSJ6fPF8UawnS7w4SiSEnXQ
         YJ53aQA7Kam3BEmXKeangGmFbLHaYCYnvFfEsIHbs+OWYEsla6Jm/VNnkOGkIMdj3A8i
         exMBLp3HiwQGM9Kkg6Qs4++euVbllj6Yl17MtQIa8ForvnJKGy2QnIBXtO2PPnKKmW0F
         vRe3A7ILZ6J9t/AMYwFhMpyEWwa47Oy/bnkOoW1fpe1lmXq3xC97X8VDAbpYBuvqeWzB
         EJS9nMUW5gttWNuZJfDzL3/7GbrzHpBNcc0nGFwV/mTEoeo/WJX5XnG5yNOAW+cJAtpz
         pwcw==
X-Gm-Message-State: AC+VfDxLVnB81zNJVIYLMrTXgz4Hhs95lxVKAqYPQviU2MWwVzqbnxkb
        N59UApVu+em1/0S9dippvR09P0Meqlo4+cHmqXBMZA==
X-Google-Smtp-Source: ACHHUZ7gOdNromrFXE3GdvxQuypVtOi6MPPmvNTGlbEjC9mOtLkpHNBvPHRmxBsZYzJ6VP57vLjqq2EPZjRl+q3IfzY=
X-Received: by 2002:a05:6512:b83:b0:4ec:8cc6:55d9 with SMTP id
 b3-20020a0565120b8300b004ec8cc655d9mr88318lfv.9.1683042205630; Tue, 02 May
 2023 08:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <202305021414.EuPdM9kv-lkp@intel.com>
In-Reply-To: <202305021414.EuPdM9kv-lkp@intel.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 2 May 2023 08:42:49 -0700
Message-ID: <CALs-Hsuw5WCmphzFNEnM5dRzqvoBscppcKb2ukVrU+uyGXBedA@mail.gmail.com>
Subject: Re: arch/riscv/kernel/cpufeature.c:34:1: sparse: sparse: symbol
 '__pcpu_scope_misaligned_access_speed' was not declared. Should it be static?
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor, this one was fixed by your patch to include cpufeature.h in
cpufeature.c, right?
-Evan

On Mon, May 1, 2023 at 11:50=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   865fdb08197e657c59e74a35fa32362b12397f58
> commit: 62a31d6e38bd0faef7c956b358d651f7bdc4ae0c RISC-V: hwprobe: Support=
 probing of misaligned access performance
> date:   13 days ago
> config: riscv-randconfig-s052-20230430 (https://download.01.org/0day-ci/a=
rchive/20230502/202305021414.EuPdM9kv-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 12.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D62a31d6e38bd0faef7c956b358d651f7bdc4ae0c
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 62a31d6e38bd0faef7c956b358d651f7bdc4ae0c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=3Dbuild_dir ARCH=
=3Driscv olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=3Dbuild_dir ARCH=
=3Driscv SHELL=3D/bin/bash arch/riscv/kernel/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305021414.EuPdM9kv-lkp@i=
ntel.com/
>
> sparse warnings: (new ones prefixed by >>)
>    WARNING: invalid argument to '-march': '_zihintpause'
> >> arch/riscv/kernel/cpufeature.c:34:1: sparse: sparse: symbol '__pcpu_sc=
ope_misaligned_access_speed' was not declared. Should it be static?
>
> vim +/__pcpu_scope_misaligned_access_speed +34 arch/riscv/kernel/cpufeatu=
re.c
>
>     30
>     31  /**
>     32   * riscv_isa_extension_base() - Get base extension word
>     33   *
>   > 34   * @isa_bitmap: ISA bitmap to use
>     35   * Return: base extension word as unsigned long value
>     36   *
>     37   * NOTE: If isa_bitmap is NULL then Host ISA bitmap will be used.
>     38   */
>     39  unsigned long riscv_isa_extension_base(const unsigned long *isa_b=
itmap)
>     40  {
>     41          if (!isa_bitmap)
>     42                  return riscv_isa[0];
>     43          return isa_bitmap[0];
>     44  }
>     45  EXPORT_SYMBOL_GPL(riscv_isa_extension_base);
>     46
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
