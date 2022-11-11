Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966AA624F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiKKBPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiKKBOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:14:40 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 701586314C;
        Thu, 10 Nov 2022 17:14:19 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C2455512;
        Fri, 11 Nov 2022 02:14:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1668129258;
        bh=Ll41Eia4YFIaHQ+bYX+2DwMFLW+igGoHhF2oNt/mOVY=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=phrgfsvvPcXtLKdt5te5tZODin71YsWa5CHRHjH4lgcbrF1ytnYqeUAq14hgACMl4
         mcarQVDoTJhAUdgWD0hAkuzidCyd9vC4f83UeeQkjqHHzC9l4Sr2ap5IQiZhqpbQLj
         8E+5kuvDHcgkRW8oR2usVfcKYjMvIJIjfpiJ5GdKy2dEbKBJ7NyiN3llTqhkuOlh9x
         sBYKfoP4gbd1VPozKajgB3lbNiypQKRYIr2ZLWcA8rHiUW6SKzZMPXmkRD7EKM2IAM
         hyNVVPDQOn+6d/fYUG1tau17YiAi9j6/gVF7hkHICJAdYr1HyXBSj2HE8raS+AT9TK
         EtRIuTNutltaA==
Date:   Fri, 11 Nov 2022 02:14:17 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-mips@vger.kernel.org
Subject: [PATCH v3 08/15] MIPS: IP27: remove KV_MAGIC
Message-ID: <60f6526fffa99416d2429dfb0b454148170cce8a.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pwqz45zq5jlhaxj5"
Content-Disposition: inline
In-Reply-To: <cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pwqz45zq5jlhaxj5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It appeared in the original import of SGI code in 2.4.0-test3pre8 and
has never been used anywhere.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 arch/mips/include/asm/sn/klkernvars.h                     | 8 ++------
 arch/mips/sgi-ip27/ip27-klnuma.c                          | 1 -
 6 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 7dada7abc733..d8ffbc21872e 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -72,7 +72,6 @@ APM_BIOS_MAGIC        0x4101           apm_user          =
       ``arch/x86/kerne
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index f9634a04d349..0e59704aa617 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -78,7 +78,6 @@ APM_BIOS_MAGIC        0x4101           apm_user          =
       ``arch/x86/kerne
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 966b9e6b1a46..17a73661ef17 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -61,7 +61,6 @@ APM_BIOS_MAGIC        0x4101           apm_user          =
       ``arch/x86/kerne
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index f3e87a6b3a01..9d44d49b93bf 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -64,7 +64,6 @@ APM_BIOS_MAGIC        0x4101           apm_user          =
       ``arch/x86/kerne
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
diff --git a/arch/mips/include/asm/sn/klkernvars.h b/arch/mips/include/asm/=
sn/klkernvars.h
index ea6b21795163..93d5eb873255 100644
--- a/arch/mips/include/asm/sn/klkernvars.h
+++ b/arch/mips/include/asm/sn/klkernvars.h
@@ -6,18 +6,14 @@
 #ifndef __ASM_SN_KLKERNVARS_H
 #define __ASM_SN_KLKERNVARS_H
=20
-#define KV_MAGIC_OFFSET		0x0
-#define KV_RO_NASID_OFFSET	0x4
-#define KV_RW_NASID_OFFSET	0x6
-
-#define KV_MAGIC		0x5f4b565f
+#define KV_RO_NASID_OFFSET	0x0
+#define KV_RW_NASID_OFFSET	0x2
=20
 #ifndef __ASSEMBLY__
=20
 #include <asm/sn/types.h>
=20
 typedef struct kern_vars_s {
-	int		kv_magic;
 	nasid_t		kv_ro_nasid;
 	nasid_t		kv_rw_nasid;
 	unsigned long	kv_ro_baseaddr;
diff --git a/arch/mips/sgi-ip27/ip27-klnuma.c b/arch/mips/sgi-ip27/ip27-kln=
uma.c
index abd7a84df7dd..82bb7ac20ef8 100644
--- a/arch/mips/sgi-ip27/ip27-klnuma.c
+++ b/arch/mips/sgi-ip27/ip27-klnuma.c
@@ -61,7 +61,6 @@ static __init void set_ktext_source(nasid_t client_nasid,=
 nasid_t server_nasid)
=20
 	KERN_VARS_ADDR(client_nasid) =3D (unsigned long)kvp;
=20
-	kvp->kv_magic =3D KV_MAGIC;
 	kvp->kv_ro_nasid =3D server_nasid;
 	kvp->kv_rw_nasid =3D master_nasid;
 	kvp->kv_ro_baseaddr =3D NODE_CAC_BASE(server_nasid);
--=20
2.30.2

--pwqz45zq5jlhaxj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNtoekACgkQvP0LAY0m
WPF16A/9F5lQWkaXt3oVQYoFM4UiSHZP/tJdzsRZC32lJhaP/jeT+/H9x7cxhKjr
rNQOA+HXKmLmU8wUIcz5zjIDydwSJFsy6WXfIsw+e5+1DkAMIIwonYSGxfGpYPJ5
psCxz5xaxEOnV8T9gP8gHEiQv7ZXm0u0R/UNcxd+ps/DlBC5ZiItgZ3ZTsTh6C++
yWSURfbt3M9mtQyL9urr7NIwZHG+faFaoeRwlTJG1oFrw7kN7T6L+3nh1Z423zf2
LRVpfC7J7s4GcauqQQ6jnAQyG0mJZE7O5kT8ZX2P+9+zurWxswxHCTUqktceDnNZ
h7UiUlYKuh9SGqsey12lKAno/G+/EySa1PCxJHsJ8/NFTaltWyxOeXhBlLa+vVAf
kRJzRicgucDR5zzWM42nB8G9NTSLzrETOLTPNhsiw1pxmzg+Wf9d/r/yHE2VGJAd
CZv4B6ECClH09X71mOef4hA8bml0wIuZJyKkHWhnVxyzqEG+TTqAYZEer7YRF9uy
cvH6G9KcilJs3EAmFQWxRJtjJUxeOEXNb32XrHVuI7ylPgyEfYpZ+sY/NCbPKGOm
INuq+woXEqnKjU7Z0yPRn9SGek+sD2PcSjbfRD1kscgMyEROwBQp3yBU8iRgV1wM
JyG3eB5MTxo8zCe75RhA20cyh4Ss4XUBmbc/Ji1gvRtchnBbGb0=
=BdmV
-----END PGP SIGNATURE-----

--pwqz45zq5jlhaxj5--
