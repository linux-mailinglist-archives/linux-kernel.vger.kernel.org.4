Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5351D5BA42E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIPBzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiIPBzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:55:14 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7AE31A055;
        Thu, 15 Sep 2022 18:55:11 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id F1AEB125A;
        Fri, 16 Sep 2022 03:55:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663293311;
        bh=l0Up1jZyTCS2dKkFauxESzl8/7NdhtmhF1IzaGGwj58=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=cyTjTMVtElMdkrFiSsakaxBpI7R+ATMUnzUtk0+9KgNhnTw+odQ8SXkHy5yOFUAky
         4WzlLKE6eJPoKTRYLT1cyY5IWPeURCt0c37na3aOwPLGRI3ULuMzQq5cGl4PeaVZv6
         H3DXsE0HTe4PTKwLxdjS5GkZcw77uO/5HsWmKCeihXxCPfy6kL/DybK9C2qobFtZ9E
         hS7C6mvdqp+tRyoqxCSpYjGuYhMeYrm7oUsh7nCWitCqfmnGJejIdMS5494Znh4S96
         qLgpqQMrN2vx+l5wXqaU6bEoZghxP82WahDniEDf2kFKrhlyXtTVSf8a7gQ5lB5U8J
         JrXw+X0QSpsYzAf8iJdU7svgSdKbTQGaPxNKchtvWzln3D78UAa0Cjf2SS766szGNX
         nKgqOot/U6PA6aKfs/fyhgL57BOKaGGyLS+oDSHs+MuL9EAbWLzsdAS2m7kITHaMyU
         E2+fsf6Zq2QgpaBS3aJao/PyxU0cJ9tJROvY8ImC02g5DBl6Us3hv+QzzL8D3YnOch
         mG2H2ob+DpGCFO/g52zgKtDd7behwJslFANFKNPIToKodhDA5gA+9rGeVxw3EuM7mU
         aiXCpUnlKkZkG0LccKErl/XwGxz8/MzDzuwiVaXu2TDJhtLBTH+vMCbUq6CWA9fhxA
         v2C3yQbExTkHTyCpDpyUItVM=
Date:   Fri, 16 Sep 2022 03:55:09 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH 3/5] tty: n_hdlc: remove HDLC_MAGIC
Message-ID: <c31d228302da3f426cebf6fcff855181a5590a66.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
References: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="txf7e6nlcjptf72l"
Content-Disposition: inline
In-Reply-To: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--txf7e6nlcjptf72l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

According to Greg, in the context of magic numbers as defined in
magic-number.rst, "the tty layer should not need this and I'll gladly
take patches"

Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst        |  1 -
 .../it_IT/process/magic-number.rst            |  1 -
 .../zh_CN/process/magic-number.rst            |  1 -
 .../zh_TW/process/magic-number.rst            |  1 -
 drivers/tty/n_hdlc.c                          | 27 -------------------
 5 files changed, 31 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index d47799ba0ca4..fdaa3e4b1953 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -71,7 +71,6 @@ Magic Name            Number           Structure         =
       File
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
 CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
 MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
-HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
 DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 24022ab52ebb..1898f98875de 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -77,7 +77,6 @@ Nome magico           Numero           Struttura         =
       File
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
 CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
 MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
-HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
 DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 811804996283..911cdaeaf698 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -60,7 +60,6 @@ Linux =E9=AD=94=E6=9C=AF=E6=95=B0
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
 CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
 MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
-HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
 DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 8e37e00590f5..ac87f188235f 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -63,7 +63,6 @@ Linux =E9=AD=94=E8=A1=93=E6=95=B8
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
 CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
 MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
-HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
 DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 94c1ec2dd754..b5aa27051119 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -76,8 +76,6 @@
  * OF THE POSSIBILITY OF SUCH DAMAGE.
  */
=20
-#define HDLC_MAGIC 0x239e
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -124,7 +122,6 @@ struct n_hdlc_buf_list {
=20
 /**
  * struct n_hdlc - per device instance data structure
- * @magic: magic value for structure
  * @tbusy: reentrancy flag for tx wakeup code
  * @woke_up: tx wakeup needs to be run again as it was called while @tbusy
  * @tx_buf_list: list of pending transmit frame buffers
@@ -133,7 +130,6 @@ struct n_hdlc_buf_list {
  * @rx_free_buf_list: list unused received frame buffers
  */
 struct n_hdlc {
-	int			magic;
 	bool			tbusy;
 	bool			woke_up;
 	struct n_hdlc_buf_list	tx_buf_list;
@@ -200,10 +196,6 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc =3D tty->disc_data;
=20
-	if (n_hdlc->magic !=3D HDLC_MAGIC) {
-		pr_warn("n_hdlc: trying to close unopened tty!\n");
-		return;
-	}
 #if defined(TTY_NO_WRITE_SPLIT)
 	clear_bit(TTY_NO_WRITE_SPLIT, &tty->flags);
 #endif
@@ -386,12 +378,6 @@ static void n_hdlc_tty_receive(struct tty_struct *tty,=
 const __u8 *data,
=20
 	pr_debug("%s() called count=3D%d\n", __func__, count);
=20
-	/* verify line is using HDLC discipline */
-	if (n_hdlc->magic !=3D HDLC_MAGIC) {
-		pr_err("line not using HDLC discipline\n");
-		return;
-	}
-
 	if (count > maxframe) {
 		pr_debug("rx count>maxframesize, data discarded\n");
 		return;
@@ -542,9 +528,6 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty,=
 struct file *file,
=20
 	pr_debug("%s() called count=3D%zd\n", __func__, count);
=20
-	if (n_hdlc->magic !=3D HDLC_MAGIC)
-		return -EIO;
-
 	/* verify frame size */
 	if (count > maxframe) {
 		pr_debug("%s: truncating user packet from %zu to %d\n",
@@ -609,10 +592,6 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, un=
signed int cmd,
=20
 	pr_debug("%s() called %d\n", __func__, cmd);
=20
-	/* Verify the status of the device */
-	if (n_hdlc->magic !=3D HDLC_MAGIC)
-		return -EBADF;
-
 	switch (cmd) {
 	case FIONREAD:
 		/* report count of read data available */
@@ -673,9 +652,6 @@ static __poll_t n_hdlc_tty_poll(struct tty_struct *tty,=
 struct file *filp,
 	struct n_hdlc *n_hdlc =3D tty->disc_data;
 	__poll_t mask =3D 0;
=20
-	if (n_hdlc->magic !=3D HDLC_MAGIC)
-		return 0;
-
 	/*
 	 * queue the current process into any wait queue that may awaken in the
 	 * future (read and write)
@@ -739,9 +715,6 @@ static struct n_hdlc *n_hdlc_alloc(void)
 	n_hdlc_alloc_buf(&n_hdlc->rx_free_buf_list, DEFAULT_RX_BUF_COUNT, "rx");
 	n_hdlc_alloc_buf(&n_hdlc->tx_free_buf_list, DEFAULT_TX_BUF_COUNT, "tx");
=20
-	/* Initialize the control block */
-	n_hdlc->magic  =3D HDLC_MAGIC;
-
 	return n_hdlc;
=20
 }	/* end of n_hdlc_alloc() */
--=20
2.30.2

--txf7e6nlcjptf72l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMj130ACgkQvP0LAY0m
WPG2tQ/+L191UhW+L1B+imMg2Sa99fKn6Zma6p1sAUJVHPcWxT6UIIyCoBg5GBvn
9qmZKWQDxyIuRCvLvgSpoWYAydAGCfXk9V7oc52g2ecxRprNmnRDwNYNOREjnQiA
NVKgqRa7WT3lJK8oZZ0ftPEi2dAT4Xmo1QycntpbRUC8KPYLoojWFpN951CmFiPn
XT+dfkda3dUU+FCoSFY5+ATqAhLu6SWl0AK/LZyBr9CVWjicVCZPOdHjuMfeHL0O
PHkUUfgX7d6nqp9xUrKAAfOc6qK9YlMiLk8QyCajgdqW4nB08ZwyRr10ngbkURUz
XuqRK1u10kl6KDnCnBUeWQlA6fR1qSg8mGKzCWJPgsH8PQasei+Ww37O4ilj6LAi
FOgPKazbrFA83GA9Diae9dvpeOo5Ta4vrFcJz11Ydsdcz+l7bexkMnSQRsRrXHZ6
1na8A5edh6dcbBgIYrD43nG7I2jbhFGH/lkFU153ErJ0b8dUi4MqIRN6Y87lJreq
rwQCYqwOl3vOBIntXCt7x5VsEDnLiuw0h+o4jWCgv+1prELJ7KBhBjB4LsPo6iAr
E2FjOAUPwivVL72X655T01KDdeeT6twUhQ5HAMOJ8FnnKstVHpjOtWpVklzp0hmj
KOjQGN55GP09/l6ull6y0fd469VIXJSJOAxMhzk26ncT6BubelA=
=fK9M
-----END PGP SIGNATURE-----

--txf7e6nlcjptf72l--
