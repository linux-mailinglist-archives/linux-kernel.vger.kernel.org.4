Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E826F6D2D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjEDNqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjEDNqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:46:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FBC83C9;
        Thu,  4 May 2023 06:45:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f139de8cefso9305213e87.0;
        Thu, 04 May 2023 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683207958; x=1685799958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Euvwf4w+PF7dcGdqI4XhoSfNb4B+m4UWdOdTdv+MuqM=;
        b=KrKTHJFZ+LghXyg6cVbPfp31a4auBIA65987yHRH3IzsTDFwozej6/PXVlVXLPiXLz
         wUfdOFtudeZQIZ99glYbXNFhFaNQf6rFzeXdWXYjuFdn7iVxDpgGvji0zK+Z7aBtKMuN
         lvt3DkM5YEMG8mF+1Vpvk218aE9oS00ixNnUkKjQjEna/tfZ/xjGC8Z3Pho56QpIGedM
         i4ASMeJA3h9xPZS3bZLyM37MW+eyiYC5Swm2H4VacsKDlZWXUWeCfNpq6qtfuysMerm/
         bUP5ll7WRyv/Z0yQyHdStS3CZ2SGq+Jr5FPbmJgff+GHeDLGccIuiKT04gmDfDblrJF5
         equg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683207958; x=1685799958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Euvwf4w+PF7dcGdqI4XhoSfNb4B+m4UWdOdTdv+MuqM=;
        b=WBtH9CZct+iRfPeidj183I+mDsO/LAAtvUFq8r9WQraIxicKYPIUprpTRPDwIHboNX
         j7u9ml2A3fJAYXJRxCEUD5d6BW/PXNtWaXiRGw+65Ks2aI+1z34tCXaP39j3Gh8Sb9Tp
         qCm19yhxe6K3HXeMSrQ20mHgwzYeCwVoTBBlbva2DFVbRQePhrNoX0H+NDCeJIgVdB1A
         crta2fMVptgfhbPehTW0w2jDzQxjdCtdqc6dHXtXQVe70uZKWNWUVmVJl/566Zxd5vXk
         vijfHQBXXfmgv1z4gjqjyvccTiHZiwvRaMMPtyf+YIw3B1y5nuCzSeKbnXoVb9svDo5g
         5Vcw==
X-Gm-Message-State: AC+VfDyoDXHnPg3YPQ6Ouwt9DWb7kDgHpoyaa/2wEtVgPNz1h0LIsDJb
        62/dp3NQNzzMy0N8QPsSHuY/fLxYbeMH4AauYp4=
X-Google-Smtp-Source: ACHHUZ4MDMoaiOp+0PQmwK/1IfdL7SymXUJ+Ul3aNoMrbyho03TdaRJXiJ/fQRyHg166g6col/TDj2eCt6PCIDH6btU=
X-Received: by 2002:a05:6512:224f:b0:4ec:36d6:1517 with SMTP id
 i15-20020a056512224f00b004ec36d61517mr1202176lfu.2.1683207957592; Thu, 04 May
 2023 06:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-14-jorge.lopez2@hp.com> <202305041942.Cc0sqwxY-lkp@intel.com>
In-Reply-To: <202305041942.Cc0sqwxY-lkp@intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Thu, 4 May 2023 08:45:30 -0500
Message-ID: <CAOOmCE-rsvHd8rNqNqyAvZi6orMbMzR-DcpHyEUPq8dt-sZ_Pw@mail.gmail.com>
Subject: Re: [PATCH v11 13/14] HP BIOSCFG driver - Makefile
To:     kernel test robot <lkp@intel.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

A quick note letting you know that the failures are reported when
trying to compile HP-BIOSCFG driver and it is including compile
sources from a DELL driver.   No DELL portions of driver are and will
be included in HP-BIOSCFG driver.

ld: drivers/platform/x86/hp/hp-bioscfg/bioscfg.o: in function
`get_wmiobj_pointer':
>> bioscfg.c:(.text+0x750): multiple definition of `get_wmiobj_pointer'; dr=
ivers/platform/x86/dell/dell-wmi-sysman/sysman.o:sysman.c:(.text+0x830): fi=
rst defined here

Additionally,  functions init_bios_attr_pass_interface() and
exit_bios_attr_pass_interface() were renamed and the new definition
will be included in patch v13  for HP-BIOSCFG driver.

Regards,

Jorge

On Thu, May 4, 2023 at 6:59=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Jorge,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.3 next-20230428]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jorge-Lopez/HP-BIO=
SCFG-driver-Documentation/20230421-012956
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20230420165454.9517-14-jorge.lop=
ez2%40hp.com
> patch subject: [PATCH v11 13/14] HP BIOSCFG driver  - Makefile
> config: i386-allyesconfig (https://download.01.org/0day-ci/archive/202305=
04/202305041942.Cc0sqwxY-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=3D1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/55e860a942040b0d0=
f1b58362dc4885b1a8acaf2
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Jorge-Lopez/HP-BIOSCFG-driver-Do=
cumentation/20230421-012956
>         git checkout 55e860a942040b0d0f1b58362dc4885b1a8acaf2
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 O=3Dbuild_dir ARCH=3Di386 olddefconfig
>         make W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305041942.Cc0sqwxY-lkp@i=
ntel.com/
>
> All errors (new ones prefixed by >>):
>
>    ld: drivers/platform/x86/hp/hp-bioscfg/bioscfg.o: in function `get_wmi=
obj_pointer':
> >> bioscfg.c:(.text+0x750): multiple definition of `get_wmiobj_pointer'; =
drivers/platform/x86/dell/dell-wmi-sysman/sysman.o:sysman.c:(.text+0x830): =
first defined here
>    ld: drivers/platform/x86/hp/hp-bioscfg/bioscfg.o: in function `get_ins=
tance_count':
> >> bioscfg.c:(.text+0x7ac): multiple definition of `get_instance_count'; =
drivers/platform/x86/dell/dell-wmi-sysman/sysman.o:sysman.c:(.text+0x88c): =
first defined here
>    ld: drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.o: in functi=
on `init_bios_attr_set_interface':
> >> biosattr-interface.c:(.text+0x4dc): multiple definition of `init_bios_=
attr_set_interface'; drivers/platform/x86/dell/dell-wmi-sysman/biosattr-int=
erface.o:biosattr-interface.c:(.text+0x33c): first defined here
>    ld: drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.o: in functi=
on `exit_bios_attr_set_interface':
> >> biosattr-interface.c:(.text+0x4f8): multiple definition of `exit_bios_=
attr_set_interface'; drivers/platform/x86/dell/dell-wmi-sysman/biosattr-int=
erface.o:biosattr-interface.c:(.text+0x358): first defined here
>    ld: drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.o: in func=
tion `init_bios_attr_pass_interface':
> >> passwdattr-interface.c:(.text+0x68): multiple definition of `init_bios=
_attr_pass_interface'; drivers/platform/x86/dell/dell-wmi-sysman/passwordat=
tr-interface.o:passwordattr-interface.c:(.text+0x338): first defined here
>    ld: drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.o: in func=
tion `exit_bios_attr_pass_interface':
> >> passwdattr-interface.c:(.text+0x84): multiple definition of `exit_bios=
_attr_pass_interface'; drivers/platform/x86/dell/dell-wmi-sysman/passwordat=
tr-interface.o:passwordattr-interface.c:(.text+0x354): first defined here
>    ld: drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.o: in functio=
n `calculate_security_buffer':
> >> spmobj-attributes.c:(.text+0x4c4): multiple definition of `calculate_s=
ecurity_buffer'; drivers/platform/x86/dell/dell-wmi-sysman/sysman.o:sysman.=
c:(.text+0x714): first defined here
>    ld: drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.o: in functio=
n `populate_security_buffer':
> >> spmobj-attributes.c:(.text+0x524): multiple definition of `populate_se=
curity_buffer'; drivers/platform/x86/dell/dell-wmi-sysman/sysman.o:sysman.c=
:(.text+0x744): first defined here
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
