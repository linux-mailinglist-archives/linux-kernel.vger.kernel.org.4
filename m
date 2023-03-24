Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E666C78E4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjCXHcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCXHcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:32:12 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28726FF14
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:32:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k15so588234pgt.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679643126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvqAtpUDp/R2AHKB23Y+FUdo7h9lz+W4or4pfdO+B1w=;
        b=TgxydYrnUs3E2dwNmXUIECaNfQrn0JhKhRzW/oJYnsF1YntYesPzi6R4Bw+L3sRo6x
         CH0bsPKjrnjJ9g1RCcpDCcf3IqTmZ05aKBqpP0qc0T/8lSIqqCTpgOX/9nBd8MWihaxV
         twiVaCBME/BT8YRoxA0oMceGJeRMtn5xtrjQj2+PxxcRpNlcA7v9v+zgrAmrDMyBith9
         AFCfRgg13j2VzbQG/cHEFfudPTwBmcA281h4XTCcyXlS+RnqZYB+hDN6EsyMrzQmJCpa
         UIAPJWR8VWZHxYo6QM3JCXyrWQsatIyd/lRi1SFWvgPZmSu/zeOiyWIUpkOUmhKNC8yx
         KhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvqAtpUDp/R2AHKB23Y+FUdo7h9lz+W4or4pfdO+B1w=;
        b=Rk1JjO+VVBAaJ0UkOk4kGrKZ/jyceVitDL0YQgD1/YuWsCUK5VZSfjm3ov7BT0mNOx
         25DWtmGMPuyGBPi6DaqxrhlS0NMZjqDkVX43syY/VEZq7RK9iP6/gGyl128MvzPUo1x/
         0nxzXNvgJsYtbhgwTvapN/FSpaJnKR1GzXdtOMtM+wpRfu/gAkxMVjfMnpG3Uen+MmZn
         M+uPOqoxTqFk5PztKq5v6u5fQ1+dINZry96ivMeNTFFHzrcaFg6+90CjWLmG3fz40Mv6
         iUDOqTVzrGDBfZYdDtVkVQvuNOE/X/awQV4rqCnwLynA0XlODiVtyhD3vwMjC2Nxupmn
         M56Q==
X-Gm-Message-State: AAQBX9ezIbUB+MTNFEVGiNWYWUUtY0yz80IHR8JM7Lh78oMIOx2NNaAr
        milvaveplIGqTlixwU6qdBouSPfkLipM/SWcbZb0og==
X-Google-Smtp-Source: AKy350Yc3qJ2BunrM47KLnlPyS3i5g7zatfj8XJQKN3gnQpmrtKvbPfhixTtCohL7Ow2LFKQagPeh1avkVsMjfmsGJc=
X-Received: by 2002:a63:c042:0:b0:513:1281:2796 with SMTP id
 z2-20020a63c042000000b0051312812796mr355798pgi.11.1679643125676; Fri, 24 Mar
 2023 00:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230323204427.3594372-1-maskray@google.com> <202303241443.0sSziFDY-lkp@intel.com>
In-Reply-To: <202303241443.0sSziFDY-lkp@intel.com>
From:   Fangrui Song <maskray@google.com>
Date:   Fri, 24 Mar 2023 00:31:54 -0700
Message-ID: <CAFP8O3+J47WNj76hK4tZad4wJJpZZjT28OBbRBkiYcaCVhJxMQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: use -z pack-relative-relocs
To:     kernel test robot <lkp@intel.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:51=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Fangrui,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on masahiroy-kbuild/for-next]
> [also build test WARNING on masahiroy-kbuild/fixes linus/master v6.3-rc3 =
next-20230323]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Fangrui-Song/Makef=
ile-use-z-pack-relative-relocs/20230324-044515
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-k=
build.git for-next
> patch link:    https://lore.kernel.org/r/20230323204427.3594372-1-maskray=
%40google.com
> patch subject: [PATCH] Makefile: use -z pack-relative-relocs
> config: arm64-randconfig-r022-20230322 (https://download.01.org/0day-ci/a=
rchive/20230324/202303241443.0sSziFDY-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/8f47a36faf182f96a=
2bbf4d3b9305fe9a90c5cde
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Fangrui-Song/Makefile-use-z-pack=
-relative-relocs/20230324-044515
>         git checkout 8f47a36faf182f96a2bbf4d3b9305fe9a90c5cde
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Darm64 olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Darm64 SHELL=3D/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303241443.0sSziFDY-lkp@i=
ntel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> aarch64-linux-ld: warning: -z pack-relative-relocs ignored
> >> aarch64-linux-ld: warning: -z pack-relative-relocs ignored
> >> aarch64-linux-ld: warning: -z pack-relative-relocs ignored
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests

I forgot to check aarch64-linux-gnu-ld. To address the issue I can use:

# ld.lld before 15 did not support -z pack-relative-relocs.
if ! $LD $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=3Drelr -o
$tmp_file 2>/dev/null; then
        $LD $tmp_file.o -shared -Bsymbolic -z pack-relative-relocs -o
$tmp_file 2>&1 |
                grep -q pack-relative-relocs && exit 1
fi



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
