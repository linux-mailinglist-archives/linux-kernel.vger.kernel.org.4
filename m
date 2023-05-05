Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847F46F7DFF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjEEHgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEEHf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:35:59 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D873359E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:35:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24eab83867dso1341777a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 00:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683272158; x=1685864158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvsnarLTa+h+9wv1WpDyAYds2du3eDCIdc9d4CYX4ho=;
        b=Q/8r8vRGLeizfKDO0jDFZcU36Hwao9qDxKV0GaMq1cM3fYp3T+MKADyCoJFS5W4+a/
         oePfBgFZgZl9fDggzJPPteThYATDZfkeYjaJwEt0YunPLWy1Sfe6y4a2bWzboJZc+4l3
         Rc/3s50czCg7LkCw0YoxVt6lWPAnvZgofpORbNnHwWDh5OPUgrKRKvXKutQCa8OPVCJe
         VRHRQY7gq2XPBxBG97K3CfXx7/k8AhULmD14tAh/eQm16UeH2I9q+nZxQF4iXGTiRz6r
         1tDFlaGg+RBwrkiT5vybiHstPhMZw0IKAUEJzL5KT/UNQqOudefDzhVOBI0Uv972XqW+
         IRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683272158; x=1685864158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvsnarLTa+h+9wv1WpDyAYds2du3eDCIdc9d4CYX4ho=;
        b=ivoUyJyS584sAu/JQKsBh6uD+2kDHn3CozIRyLvovZ2lT1+PIHSoe+d1XOjRnChk3h
         5JBhCm6cuCmddpIE1Fuh6+H3KPYWQcRgPExX9tSfzR/nNij1N+ESFD/GkcFS+AWzgxGP
         njm7jOE+8p9MROEC1Ruo3/Y36Nw02Ll2YL5feQ1z+GWighu0PDJjydnvRuoqx5dHuhaa
         HvsNcISzA1WYynyLQFvxmP1TesYjlWz6HSGZmT4gapPc0LriJhaIYLdJL3+qksjmvzkG
         ZQgrQ4CxqLvbpixArnOw9LugfpItCyxFAB9uLu1o2dpiaIOhEPnar8r089RdNaDCk07q
         SqnQ==
X-Gm-Message-State: AC+VfDzztjlOILGONBj1cjJ0pQrOuegNHvk/aF5HdFlPOgVdsSsvMqj4
        aCR7RASZGSa9Dba0vsbVrXogP3WTr0AQTd/Vw94=
X-Google-Smtp-Source: ACHHUZ6T9+MEh7JB/f+oExg1S8KnfJmqI99GacG1jntcX9grbzFkhTfkoTYJk3ZTLBHLzKsvMOU/JX1Bi6ZyXZi522M=
X-Received: by 2002:a17:90a:6545:b0:249:64d2:4122 with SMTP id
 f5-20020a17090a654500b0024964d24122mr613266pjs.21.1683272157864; Fri, 05 May
 2023 00:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230417165246.467723-1-zyytlz.wz@163.com> <cabf202f-a58e-4637-9d55-b0382360c27e@kili.mountain>
 <CAJedcCzuPkHHy=uxtyuRT-Qvs56ooZ_irL89KdPq99XxgxfLBw@mail.gmail.com> <daacdf0d-605a-4a3b-a599-3a15857ec224@kili.mountain>
In-Reply-To: <daacdf0d-605a-4a3b-a599-3a15857ec224@kili.mountain>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 5 May 2023 15:35:46 +0800
Message-ID: <CAJedcCwwOkTcKvJ7PXa+s=46MnaVRCRK8HSehoj2bziLUhaD5w@mail.gmail.com>
Subject: Re: [PATCH] misc: hpilo: Fix use after free bug in ilo_remove due to
 race condition with ilo_open
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        matt.hsiao@hpe.com, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter <dan.carpenter@linaro.org> =E4=BA=8E2023=E5=B9=B45=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=BA=94 15:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, May 05, 2023 at 12:01:17PM +0800, Zheng Hacker wrote:
> > Dear Dan,
> >
> > Thanks for your reply. I'm not so familiar with the code here. Is the
> > warning says we should check ilo_hw to see if it's not NULL?
> >
>
> Just delete the NULL check.  It's impossible.
>

Thanks for your explaination.

Best regards,
Zheng

> regards,
> dan carpenter
>
> > Best regards,
> > Zheng
> >
> > Dan Carpenter <dan.carpenter@linaro.org> =E4=BA=8E2023=E5=B9=B45=E6=9C=
=882=E6=97=A5=E5=91=A8=E4=BA=8C 19:46=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hi Zheng,
> > >
> > > kernel test robot noticed the following build warnings:
> > >
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Zheng-Wang/mis=
c-hpilo-Fix-use-after-free-bug-in-ilo_remove-due-to-race-condition-with-ilo=
_open/20230418-005502
> > > base:   char-misc/char-misc-testing
> > > patch link:    https://lore.kernel.org/r/20230417165246.467723-1-zyyt=
lz.wz%40163.com
> > > patch subject: [PATCH] misc: hpilo: Fix use after free bug in ilo_rem=
ove due  to race condition with ilo_open
> > > config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive=
/20230430/202304300909.ALHN6Vry-lkp@intel.com/config)
> > > compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Reported-by: Dan Carpenter <error27@gmail.com>
> > > | Link: https://lore.kernel.org/r/202304300909.ALHN6Vry-lkp@intel.com=
/
> > >
> > > smatch warnings:
> > > drivers/misc/hpilo.c:755 ilo_delete() warn: can 'ilo_hw' even be NULL=
?
> > >
> > > vim +/ilo_hw +755 drivers/misc/hpilo.c
> > >
> > > 13a22f45e6cb1e Zheng Wang      2023-04-18  749  static void ilo_delet=
e(struct kref *kref)
> > > 13a22f45e6cb1e Zheng Wang      2023-04-18  750  {
> > > 13a22f45e6cb1e Zheng Wang      2023-04-18  751          int i, minor;
> > > 13a22f45e6cb1e Zheng Wang      2023-04-18  752          struct ilo_hw=
info *ilo_hw =3D container_of(kref, struct ilo_hwinfo, refcnt);
> > > 13a22f45e6cb1e Zheng Wang      2023-04-18  753          struct pci_de=
v *pdev =3D ilo_hw->ilo_dev;
> > > 89bcb05d9bbf8b David Altobelli 2008-07-02  754
> > > ebf1b764aa5cb3 Mark Rusk       2012-11-06 @755          if (!ilo_hw)
> > >                                                             ^^^^^^^
> > >
> > > ->refcnt member isn't the first struct member so this NULL check
> > > doesn't make sense.  Generally checking container_of() is ugly.  Some
> > > people do it and add BUILD_BUG_ON() to ensure that they're checking t=
he
> > > first struct member but really it's best to avoid that if possible.
> > >
> > > ebf1b764aa5cb3 Mark Rusk       2012-11-06  756                  retur=
n;
> > > ebf1b764aa5cb3 Mark Rusk       2012-11-06  757
> > > 89bcb05d9bbf8b David Altobelli 2008-07-02  758          clear_device(=
ilo_hw);
> > > 89bcb05d9bbf8b David Altobelli 2008-07-02  759
> > > 89bcb05d9bbf8b David Altobelli 2008-07-02  760          minor =3D MIN=
OR(ilo_hw->cdev.dev);
> > > 98dcd59dd063dd Camuso, Tony    2012-06-10  761          for (i =3D mi=
nor; i < minor + max_ccb; i++)
> > > 89bcb05d9bbf8b David Altobelli 2008-07-02  762                  devic=
e_destroy(ilo_class, MKDEV(ilo_major, i));
> > > 89bcb05d9bbf8b David Altobelli 2008-07-02  763
> > > 89bcb05d9bbf8b David Altobelli 2008-07-02  764          cdev_del(&ilo=
_hw->cdev);
> > > 9f7048412163d8 David Altobelli 2009-08-17  765          ilo_disable_i=
nterrupts(ilo_hw);
> > > 9f7048412163d8 David Altobelli 2009-08-17  766          free_irq(pdev=
->irq, ilo_hw);
> > > 89bcb05d9bbf8b David Altobelli 2008-07-02  767          ilo_unmap_dev=
ice(pdev, ilo_hw);
> > > 89bcb05d9bbf8b David Altobelli 2008-07-02  768          pci_release_r=
egions(pdev);
> > > bcdee04ea7ae04 Jiri Slaby      2012-09-13  769          /*
> > > bcdee04ea7ae04 Jiri Slaby      2012-09-13  770           * pci_disabl=
e_device(pdev) used to be here. But this PCI device has
> > > bcdee04ea7ae04 Jiri Slaby      2012-09-13  771           * two functi=
ons with interrupt lines connected to a single pin. The
> > > bcdee04ea7ae04 Jiri Slaby      2012-09-13  772           * other one =
is a USB host controller. So when we disable the PIN here
> > > bcdee04ea7ae04 Jiri Slaby      2012-09-13  773           * e.g. by rm=
mod hpilo, the controller stops working. It is because
> > > bcdee04ea7ae04 Jiri Slaby      2012-09-13  774           * the interr=
upt link is disabled in ACPI since it is not refcounted
> > > bcdee04ea7ae04 Jiri Slaby      2012-09-13  775           * yet. See a=
cpi_pci_link_free_irq called from acpi_pci_irq_disable.
> > > bcdee04ea7ae04 Jiri Slaby      2012-09-13  776           */
> > > 89bcb05d9bbf8b David Altobelli 2008-07-02  777          kfree(ilo_hw)=
;
> > > 98dcd59dd063dd Camuso, Tony    2012-06-10  778          ilo_hwdev[(mi=
nor / max_ccb)] =3D 0;
> > > 89bcb05d9bbf8b David Altobelli 2008-07-02  779  }
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests
> > >
