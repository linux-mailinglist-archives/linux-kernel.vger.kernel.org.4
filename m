Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4C26E95DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjDTN2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDTN2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:28:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F7844AD;
        Thu, 20 Apr 2023 06:28:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2a7b02615f1so5271331fa.0;
        Thu, 20 Apr 2023 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681997318; x=1684589318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsQHPIV1Ehf/4fM8YYUDLE/bFem2uzfIPTtkkuxRl1Y=;
        b=QLd/ptbEUn2g6q1+Pr/0hjD6DG2ZLeWQ0PBL/Mc/1rrb5aBoCY+qBUBV9CQ9mU7lvu
         DDkwkqNW+bjOlxDcCEX5Ux1fxBo3OPMUBLfIgjCxyhfLdff2jnj4Z9FwRx/VMvWPBGqy
         qsjtWJerMUXme5XVZGOspqIUMesPsx99gstNn4CizzyFQW072koLs4aQ8vyvfNRrp2vg
         af06mTB2yRRhKx+SqAlUmy9Fgq1RmL0FAtR3kCjno1xHB8O8mXooBRYyTfBuQQa1J8EP
         HOAy3PNvHXdU1NFRsrEOqIZX02T1KOPhdBMZT8deyGGy6UFyWZ4pVUAWuQvWr/4gQMab
         MIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681997318; x=1684589318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsQHPIV1Ehf/4fM8YYUDLE/bFem2uzfIPTtkkuxRl1Y=;
        b=T5n5D9K8n+w/BN04ynFah8RnCnwfdlHfln1QNrdJaMnCKwaNVgaBDoz4iou1g6pln3
         4h6YQRHHEsXEt+kuErtooZMmmqQLH1yTOkeAUD4TPH5wHp+BVGk22pb8TVYKs+pd4hbM
         bJQMm9GKayTywABeBuhWEncNhuCX2nLdniDBn0NOJGzAX8CuKe33U+dGp2jer6w/VOCR
         ly5UhYxQHftUYGmMV4FLAKkaGILTxz8mFCS8ZBJ36QyjNjCy1VgE9zPtSE+iYbRPNMxB
         aglpsRmrvxiVxkTnYPJZF9IyC7bob7x4Xhdz6kkL9GrJscRvNVn1TVWBaIotbYKDxpf0
         tQpA==
X-Gm-Message-State: AAQBX9cGtJhNaI9QzYgJQd/zMnoqP6g0YIrXpWNI/+Dooe3fyqbQmvfZ
        sex3DO8hjGfg63Vp2ifLRviTn4LtQOHkyMQAO18=
X-Google-Smtp-Source: AKy350brY4KkO9okJRBJGqEqnyIef1vhgAcE3Ag3OhSiUboNIUStN19Y6Qr75p7jFDaL36KIwu+IeODNN1LJSmZv6y8=
X-Received: by 2002:a19:5202:0:b0:4ed:d4c8:66c3 with SMTP id
 m2-20020a195202000000b004edd4c866c3mr403576lfb.2.1681997317943; Thu, 20 Apr
 2023 06:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230419151321.6167-14-jorge.lopez2@hp.com> <202304201100.r6QLG0Fc-lkp@intel.com>
In-Reply-To: <202304201100.r6QLG0Fc-lkp@intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Thu, 20 Apr 2023 08:28:15 -0500
Message-ID: <CAOOmCE8hHozxCbUnRYwAr5SNbwn8JdT16tvNMohktrDJv0tjKA@mail.gmail.com>
Subject: Re: [PATCH v10 13/14] HP BIOSCFG driver - Makefile
To:     kernel test robot <lkp@intel.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        oe-kbuild-all@lists.linux.dev
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

Thank you for the heads up.  I will look  them over.

Regards,

Jorge

On Wed, Apr 19, 2023 at 10:57=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
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
> config: i386-randconfig-s002-20230417 (https://download.01.org/0day-ci/ar=
chive/20230420/202304201100.r6QLG0Fc-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://github.com/intel-lab-lkp/linux/commit/cfbebfbd4ed15793f=
ab894715bfd74387adcf4f1
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Jorge-Lopez/HP-BIOSCFG-driver-Do=
cumentation/20230419-231828
>         git checkout cfbebfbd4ed15793fab894715bfd74387adcf4f1
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=
=3Dbuild_dir ARCH=3Di386 olddefconfig
>         make W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=
=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash drivers/platform/x86/hp/hp-biosc=
fg/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304201100.r6QLG0Fc-lkp@i=
ntel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c:80:23: spars=
e: sparse: symbol 'sure_start_audit_log_entries' was not declared. Should i=
t be static?
> --
> >> drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c:191:23: sparse:=
 sparse: symbol 'password_spm_status' was not declared. Should it be static=
?
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
