Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E556155D1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKAXGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiKAXFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:38 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30D3117411;
        Tue,  1 Nov 2022 16:05:37 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 782E45196;
        Wed,  2 Nov 2022 00:05:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1667343936;
        bh=O4KPNylQ43Tq0Q+WVMGVMq6UXo84JvS+hpJnQ0AYxcs=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=Y0XPIdnB5KT0bAAutzRKGAbR4kutjWShMT1woG1DXMfHvaZ8ct/NohSb4838sVmKw
         h2xm+WI5KDDK/pAA3eyXr0GVJGC/lKVZL81WMfL2qiQSde+A/cEXyPLiA30TRAd+yT
         TY8qiHW+zZCYQHK9TMrpYLD+GeEFUmToWouR2uuJkks2PJJKXdamOYriwqmNRqjQeQ
         AVFvTMVYadzf8EVbuFadj4XiyTUyTi2ysn73WBmigvkK9EMQoomQhghkfjElol9Kts
         fS4+gPR8WvZdWr6CJlm8U88GwmKT3o5d1oB5xm9Ff3avt+quT8ljge4E5QWi0o5Oyi
         dE2C/s39oIefSAJ5bwQt/fQO7siO4OAMUJmnScEYAMkBLKV91+KPKFQmGRstTUVwq2
         Uym9bkCOMkilvccfJ/pJQVAJawDoaJgk/th3qPG1O262v8akLKwsxL+ONvDuPXcI2S
         VfAokIgImDyLLsk+CLH0rT2UqDG+5dbO9jrTUtodNh8U4KZ6syKYfh6DqYdbG0K/Br
         wFAY+irRiijfeAAI9K2istGCp1ZDMQGTanHoMo1WmdlE8OHAPNepoY+jJ8LxV3qsUv
         k8s9u0/j6gLTHRziQyI2Cv8jsmQXUqKmEl0yVrsp2n1a/HHcsqgzWtIlKAj6t+fXtM
         fYSB/8s6hdaST1WsW4a/FW0o=
Date:   Wed, 2 Nov 2022 00:05:35 +0100
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-mips@vger.kernel.org
Subject: [PATCH v2 08/15] MIPS: IP27: remove KV_MAGIC
Message-ID: <d0974d5b2fbfab94535ce6404fcd024e3daaec4b.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="trw4mxglpft7f3oc"
Content-Disposition: inline
In-Reply-To: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--trw4mxglpft7f3oc
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

--trw4mxglpft7f3oc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNhpj8ACgkQvP0LAY0m
WPHLBBAAgOI+2+3bitlgIILQGed1ZD3q7qNbt6de4rodEofL7w3SlEOQU8dEdolo
l9taUnLM+VNRllKjOhVoRaoVK+lqkM2IrjHOgCPI2GvfsMDIYdJY3JGnrcMSf0U1
Sqf4T5+e3fq5Fzbc+5AxN6HrJfuTXzbQj2sKob4lPTMJQtpngxq8E/PBg2hIb8sn
7AFQ0ZtCJimzJNLuZotifJTU+pt11VlaRUm/pQuMjCTJHcT+h1zNz9iSnzPlcyor
52a7h1SKZc4+PWevPUxftIs5zCnB3WfnxLDczKqX0Qfv1YMAmdNpaNWHQJ5RuYDm
z5DZ7YdKE8reoJc1ZGYk64ADjCNnjeTexw6RPEzq0gGwEGz5yKxLWtC7Z6hQGPIM
YWXy9PPkSuS7L3hv0tx7Q5gNnRbPk7BafUDnh9GkuFpy2IQVdMmucRts0NtXUvBB
prNRC0oYEuHEpoS1jQeaQqoVa6fC0WeNrynOx8pBsbKp+3L3D7CdwKgtHPCiSVqW
Rd+kK+fV42E/aE73htBFIrv+v53mk2SOD62abKpfc+sl0VOZMVCos2HggRu8B/kZ
yBnbwVXM3TnYeiGRLsWLrnksuN7D6KHEtwfyJAFt6H8EsW/UGfZ1xQm4RH/Wu7OI
LFrtDqKTIdHVSM6bj/f4xF4gXIDTh5muIzxh7l8s9d+OJ5gct6Y=
=1vgU
-----END PGP SIGNATURE-----

--trw4mxglpft7f3oc--
