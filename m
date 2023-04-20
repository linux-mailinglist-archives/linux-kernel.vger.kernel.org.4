Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052096E95E9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjDTNeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDTNeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:34:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B3B49E5;
        Thu, 20 Apr 2023 06:34:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4edbd6cc46bso570065e87.2;
        Thu, 20 Apr 2023 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681997658; x=1684589658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBx+eefuD3mlwASOnAXXaphvTZnbQD+D9i1G2I4aLj8=;
        b=qmB7IgRNrOg7Yiy3/TCCuLJTdZB4SeCbSJttL+VR1cUJ04+ObsDD9YNoCesG+AnTHJ
         aTeVhRRCY5DH9nEbVtHUHA46SG7WHzuheX2uLfll+cHdp7LAjEqFRzwamv7j4ZRlpYWo
         LEWj3a6svuA2UrbTejkMtUNjhba6LI+KwaWc5ejbGx99wt79qmebAVLxUZp0cn6zBI/d
         r+iWKXXsu5bcz9v81h5zaXe2/YBUu1c/lwRSqIOnlFrtvbsetPjfOWpUPQm8WBbBU2Rd
         dJoZoLwtjUfqSjMspUZ7yJoKBkIURWO4PLxVccPS+Xc8LISsIDwtU5IcglUK/Ea+MJas
         QJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681997658; x=1684589658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBx+eefuD3mlwASOnAXXaphvTZnbQD+D9i1G2I4aLj8=;
        b=ZcYF8PawvgjFBcyNRs/pzUw7fCV8eEtpAvB2BBTEWBpVogYbq8lzMSkoomZcD2MPDQ
         5lQ1sJ3M3gjt9KU/0HiAQd9sz4nQSeluDF2g5H11/pQHVAl/juWXXi1+YqwoUuaiisn/
         36fKYiSDCIRbuEV1eg1PuDHTCoWa8q7839+RZxv3ncbKb9Hsag0IizvZaqTrgW3KJmGU
         3vzSn1IVjn9PGFFrhIgj78RtQxSZhIfVQHXl/YBHAAEHsfEiEggLcm/46ikT0BtV13l7
         dEnS/SC40Ri2zFb7NTJq03EWEBsKoMGtx/GZUX44qqxVsMMWedUAsv3OVSw2K6cyRKBF
         5Hwg==
X-Gm-Message-State: AAQBX9esOAAyxs0xcUFyD6H1Uz5gk2jBZfrvOTSIcyY5Cx82U9xrKprq
        85sK84/vsJ7H3zjrbFPT3m8JsUmyo2l0x64yiY5ffD+S
X-Google-Smtp-Source: AKy350btAzYnXLlPTv04Y7unRU8YAvfOdqZn0Lxv4Zt4Os2OAzHN86GYf4hNuxyadHt2aEVCWzfucLKCiIJ2BZ7vVzA=
X-Received: by 2002:a19:ee0e:0:b0:4ea:e799:59f7 with SMTP id
 g14-20020a19ee0e000000b004eae79959f7mr393073lfb.2.1681997657435; Thu, 20 Apr
 2023 06:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230419151321.6167-14-jorge.lopez2@hp.com> <202304200914.VfJcRutc-lkp@intel.com>
In-Reply-To: <202304200914.VfJcRutc-lkp@intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Thu, 20 Apr 2023 08:33:54 -0500
Message-ID: <CAOOmCE_+UL31C50Md-eV5H76jy2Ta1q1xB7b=QqdNU95Q4y6fw@mail.gmail.com>
Subject: Re: [PATCH v10 13/14] HP BIOSCFG driver - Makefile
To:     kernel test robot <lkp@intel.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you.  I will address those issues.

Regards,

Jorge

On Wed, Apr 19, 2023 at 8:45=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Jorge,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.3-rc7 next-20230419]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jorge-Lopez/HP-BIO=
SCFG-driver-Documentation/20230419-231828
> patch link:    https://lore.kernel.org/r/20230419151321.6167-14-jorge.lop=
ez2%40hp.com
> patch subject: [PATCH v10 13/14] HP BIOSCFG driver  - Makefile
> config: i386-randconfig-a015-20230417 (https://download.01.org/0day-ci/ar=
chive/20230420/202304200914.VfJcRutc-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c=
006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/cfbebfbd4ed15793f=
ab894715bfd74387adcf4f1
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Jorge-Lopez/HP-BIOSCFG-driver-Do=
cumentation/20230419-231828
>         git checkout cfbebfbd4ed15793fab894715bfd74387adcf4f1
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Di386 olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash drivers/platform/x86/hp/hp=
-bioscfg/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304200914.VfJcRutc-lkp@i=
ntel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:141:2: warni=
ng: variable 'id' is used uninitialized whenever 'if' condition is true [-W=
sometimes-uninitialized]
>            if (!buf_cp) {
>            ^~~~~~~~~~~~
>    include/linux/compiler.h:56:28: note: expanded from macro 'if'
>    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) )=
 )
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_=
var'
>    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __=
trace_if_value(cond))
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~
>    drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:169:18: note=
: uninitialized use occurs here
>            clear_passwords(id);
>                            ^~
>    drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:141:2: note:=
 remove the 'if' if its condition is always false
>            if (!buf_cp) {
>            ^~~~~~~~~~~~~~
>    include/linux/compiler.h:56:23: note: expanded from macro 'if'
>    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) )=
 )
>                          ^
>    drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:138:8: note:=
 initialize the variable 'id' to silence this warning
>            int id, ret =3D -EIO;
>                  ^
>                   =3D 0
>    1 warning generated.
> --
> >> drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:76:2: warning:=
 variable 'ret' is used uninitialized whenever 'if' condition is true [-Wso=
metimes-uninitialized]
>            if (!start)
>            ^~~~~~~~~~~
>    include/linux/compiler.h:56:28: note: expanded from macro 'if'
>    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) )=
 )
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_=
var'
>    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __=
trace_if_value(cond))
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~
>    drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:87:9: note: un=
initialized use occurs here
>            return ret;
>                   ^~~
>    drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:76:2: note: re=
move the 'if' if its condition is always false
>            if (!start)
>            ^~~~~~~~~~~
>    include/linux/compiler.h:56:23: note: expanded from macro 'if'
>    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) )=
 )
>                          ^
>    drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:72:2: warning:=
 variable 'ret' is used uninitialized whenever 'if' condition is true [-Wso=
metimes-uninitialized]
>            if (!start)
>            ^~~~~~~~~~~
>    include/linux/compiler.h:56:28: note: expanded from macro 'if'
>    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) )=
 )
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_=
var'
>    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __=
trace_if_value(cond))
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~
>    drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:87:9: note: un=
initialized use occurs here
>            return ret;
>                   ^~~
>    drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:72:2: note: re=
move the 'if' if its condition is always false
>            if (!start)
>            ^~~~~~~~~~~
>    include/linux/compiler.h:56:23: note: expanded from macro 'if'
>    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) )=
 )
>                          ^
>    drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:43:2: warning:=
 variable 'ret' is used uninitialized whenever 'if' condition is true [-Wso=
metimes-uninitialized]
>            if (instance < 0)
>            ^~~~~~~~~~~~~~~~~
>    include/linux/compiler.h:56:28: note: expanded from macro 'if'
>    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) )=
 )
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_=
var'
>    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __=
trace_if_value(cond))
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~
>    drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:87:9: note: un=
initialized use occurs here
>            return ret;
>                   ^~~
>    drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:43:2: note: re=
move the 'if' if its condition is always false
>            if (instance < 0)
>            ^~~~~~~~~~~~~~~~~
>    include/linux/compiler.h:56:23: note: expanded from macro 'if'
>    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) )=
 )
>                          ^
>    drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c:30:9: note: in=
itialize the variable 'ret' to silence this warning
>            int ret;
>                   ^
>                    =3D 0
>    3 warnings generated.
>
>
> vim +141 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
>
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  132
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  133  static ssize_t new_password_s=
tore(struct kobject *kobj,
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  134                               =
 struct kobj_attribute *attr,
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  135                               =
 const char *buf, size_t count)
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  136  {
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  137      char *p, *buf_cp =3D NULL=
;
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  138      int id, ret =3D -EIO;
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  139
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  140      buf_cp =3D kstrdup(buf, G=
FP_KERNEL);
> 1780f5eca27fb8 Jorge Lopez 2023-04-19 @141      if (!buf_cp) {
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  142              ret =3D -ENOMEM;
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  143              goto exit_passwor=
d;
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  144      }
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  145
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  146      p =3D memchr(buf_cp, '\n'=
, count);
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  147
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  148      if (p !=3D NULL)
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  149              *p =3D '\0';
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  150
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  151      id =3D get_password_insta=
nce_id(kobj);
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  152
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  153      if (id >=3D 0)
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  154              ret =3D validate_=
password_input(id, buf_cp);
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  155
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  156      if (!ret)
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  157              strscpy(bioscfg_d=
rv.password_data[id].new_password,
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  158                      buf_cp,
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  159                      sizeof(bi=
oscfg_drv.password_data[id].new_password));
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  160
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  161      if (!ret)
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  162              ret =3D hp_set_at=
tribute(kobj->name, buf_cp);
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  163
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  164  exit_password:
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  165      /*
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  166       * Regardless of the resu=
lts both new and current passwords
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  167       * will be set to zero an=
d avoid security issues
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  168       */
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  169      clear_passwords(id);
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  170
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  171      kfree(buf_cp);
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  172      return ret ? ret : count;
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  173  }
> 1780f5eca27fb8 Jorge Lopez 2023-04-19  174
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
