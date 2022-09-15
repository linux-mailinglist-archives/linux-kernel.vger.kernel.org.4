Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5178F5BA2CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIOWkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiIOWjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:39:44 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0FD16332;
        Thu, 15 Sep 2022 15:39:38 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id AE31F13DE;
        Fri, 16 Sep 2022 00:39:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281577;
        bh=ByjdqOKH2DO5+ytci2mXsOS0Brk0KqFt5UV6CMuszwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8WxcshR9V982Ydlew+J8Cov0XvNhk20YVzjhOaji5zUk9qzBw7S/Pf1Rhb1TLWKx
         7s/SzC7n9DjSwiwXFoSpHMuH1LV6xA5mUjF5uG9mtaijGZ//D+pRrCMg1SLMESpTmN
         44PEP+EEvJm3XUFzXQ8zlrgJ8LB3IHOfYIRKfghZbpPVvpmPPA9JoryJlNXiHQ07mc
         M1Q5duS/NArdKa+7zBDdN63tfixB+xgmIDseiUd6UBUiLhTtvHvEFxbOx9Wn1s7MlI
         0zi9hNOnGwd0n676/dv4WocM1OEBVZ8VWUfQD4HKYwK8iMuXlFeCtHR1TmRGavcAwM
         uXE6xVn4XacCTERrQ5fjuWDC51m7yzDXnaOA6IQ/tk3w4IpOJL73l6PV+W9nMOV6No
         ukZ3D2gvBxBlGD12+IeR9RslQKdemtAoKpXBaVuGgoW+FruPW8WnfZGvBYhxEpI69k
         /3dpNTB8SzQl48cEAsdYYS+E7eJKL03B3HnCnSZn4Sj75jiJV3O0aRVn2XMyTJvCsR
         q1Urxv+G0zKbuDVhtBLcEXegjMJ0hGHWw+ajdkWU4HNH1aHWWFqVMOYqWVxm4ZWcJW
         9dOlh8844R8500husJtliIZvKogUfXtm0p7P4NwoNw6622ncsPCwLK9KEyrrR9bBJ6
         du2cWTYYSfVMeIgbVdG7+180=
Date:   Fri, 16 Sep 2022 00:39:36 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, Hu Haowen <src.res@email.cn>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH v4 08/18] Documentation: zh: remove stale magic numbers
Message-ID: <5d9fa062178c45822a600a723f6f71fdb92011f3.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vnkozavth5azkztm"
Content-Disposition: inline
In-Reply-To: <YyMlovoskUcHLEb7@kroah.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vnkozavth5azkztm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

English and it magic-number.rsts were updated when these were removed;
the zh translations weren't

This equalises these lists to be the same across all translations

Automated:
grep MAGIC Documentation/translations/process/zh_TW/magic-number.rst |
while read -r mag _; do git grep -wF "$mag" | grep -vq \
'^Documentation.*magic-number.rst:' || sed -i "/^$mag/d" \
=2E/Documentation/{,translations/{zh_CN,zh_TW,it_IT}/}process/magic-number.=
rst
; done

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/translations/zh_CN/process/magic-number.rst | 2 --
 Documentation/translations/zh_TW/process/magic-number.rst | 2 --
 2 files changed, 4 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 3e13a19a1fcc..8c4bef0760cd 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -68,7 +68,6 @@ TTY_DRIVER_MAGIC      0x5402           tty_driver        =
       ``include/linux/
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
 CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
-GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str            ``drivers/=
scsi/gdth_ioctl.h``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
@@ -83,7 +82,6 @@ LO_MAGIC              0x68797548       nbd_device        =
       ``include/linux/
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
-DPMEM_MAGIC           0xc0ffee11       gdt_pci_sram             ``drivers/=
scsi/gdth.h``
 YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 0fd7eb32d159..b071bd837e62 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -71,7 +71,6 @@ TTY_DRIVER_MAGIC      0x5402           tty_driver        =
       ``include/linux/
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
 CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
-GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str            ``drivers/=
scsi/gdth_ioctl.h``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
@@ -86,7 +85,6 @@ LO_MAGIC              0x68797548       nbd_device        =
       ``include/linux/
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
-DPMEM_MAGIC           0xc0ffee11       gdt_pci_sram             ``drivers/=
scsi/gdth.h``
 YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
--=20
2.30.2

--vnkozavth5azkztm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqagACgkQvP0LAY0m
WPHHXBAAo9E3FxnELzRgTRN7esSx633Z+jKN1l4IgUZkwAHBvrRy3wnPrpOnmOZ6
PQUdUr6BQWOl3GaEadhYgb1jD3V2Sd6AsHhZilD8mYGmCrKbEU0+8o7oM60pagpq
W1KQ6BnDcQuj04Y4M4ik8ISv+7FUqQFR26IjKRbyJ39lT+/zRQsjThKPfnMZ42pe
g63jucOfU1F5xMGh8sH596NdIBcdgJsQydVhKA38Om+0UW7K3hRcwNvw3eIP3Jlr
V/93Oz+VrKrBNJJSSE922b5x3lyQ6ujOke64YXt4JXEL3SAJgikYF//0JBQN54du
21BycvLdRi2uZSDWHH628B3SrkHLsGvgqFOd2K45v4ZDnANPHap0n9w8CELozOM7
V3lrb+Amvi9m1Eu/vpEBCYQ2eIjU+y4zTaU4VJvQsRimjr35pgEdVgm9I1dJt/31
xVvU2fQDEd6EQZpPBXcSYe/fP1KFS1q2XSnJyhRu1L2RxQU14YMgkrllgkV1sWdC
Et0OauuwRsZQMT9qEVyQAAr2hd07zYxPkfLtVRT3vygjYu3fJ8YAVL1nYEjvztA5
ItcIsi6UrNGvEOUb93slIaLS12ajsfI334uxZHUrMsz4VgcAijNR1+Ljg0/hGirm
JP0XU/OMGOXmdSF68YFHEinngPh6SOiuNWxEMjA2wDn2c71D7qE=
=O5Yx
-----END PGP SIGNATURE-----

--vnkozavth5azkztm--
