Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4A7504EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjGLKkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGLKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:39:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CAC1BCF;
        Wed, 12 Jul 2023 03:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689158393; x=1720694393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZbHtoayEoeve83kiK7UlBDBcFh+4f4unYakqBC0xVDU=;
  b=kbaIHvxRHvaiAPNL54ALMJP+5izk7l2mG2CS2RaoI/GYxoLBjIACbS4I
   m+Oigo+EHcJTKzIh3qBwdpfTs/SfVM7yCsRd0nw7OG25F3+euaw9wRF82
   KllcQ8OUzr78bkUXfEHFdOmNsSBum5NoW1djt+aG0RsqctlPMV2a3rmlm
   vBnJGIU1UCkf1341xaad8waIneeMqWpAFdVys326onj+4mTbSCLCdtDQK
   0AHcB0x1fep7K10jSiLGvUt8u58S9mq10GEbU0XMLSa4/+Yv5uaHUVclx
   d3sOO22YWPadWl0f97FxMhkjlHN/VFp8KoU31Gjcfm/jIP3hHmdAxGmqR
   A==;
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="asc'?scan'208";a="235053683"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2023 03:39:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Jul 2023 03:39:52 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Jul 2023 03:39:48 -0700
Date:   Wed, 12 Jul 2023 11:39:16 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Ortiz <sameo@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, <linux@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        <linux-kernel@vger.kernel.org>, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>, <devicetree@vger.kernel.org>,
        <sorear@fastmail.com>, Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH v4 1/4] RISC-V: Add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <20230712-bulldozer-affected-199042dc3afd@wendy>
References: <20230712084134.1648008-1-sameo@rivosinc.com>
 <20230712084134.1648008-2-sameo@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c48Ux8GZXj1FBAWH"
Content-Disposition: inline
In-Reply-To: <20230712084134.1648008-2-sameo@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--c48Ux8GZXj1FBAWH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Samuel, Evan,

On Wed, Jul 12, 2023 at 10:41:17AM +0200, Samuel Ortiz wrote:
> From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
>=20
> Parse Zb/Zk related string from DT and output them to cpuinfo.

One thing that has sprung to mind is that this is not limited to DT
anymore, since the information could in theory come from ACPI too.
Ditto the title I guess.

> It is worth noting that the Scalar Crypto extension defines "zk" as a
> shorthand for the Zkn, Zkr and Zkt extensions. Since the Zkn one also
> implies the Zbkb, Zbkc and Zbkx extensions, simply passing the valid
> "zk" extension name through a DT will enable all of the  Zbkb, Zbkc,
> Zbkx, Zkn, Zkr and Zkt extensions.
>=20
> Also, since there currently is no mechanism to merge all enabled
> extensions, the generated cpuinfo output could be relatively large.
> For example, setting the "riscv,isa" DT property to "rv64imafdc_zk_zks"
> will generate the following cpuinfo output:
> "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed_zksh_zkt".

On that note, I've created another version of what checking for
supersets could look like, since it'll be needed either by my series or
this one, depending on what gets merged first. I've yet to test the
dedicated extensions part of it, but I wanted to get this out before I
went looking at other fixes in the area.

Evan, since it was you that commented on this stuff last time around,
could you take another look? I'm still not keen on the "subset_of"
arrays, but they're an improvement on what I had last time around for
sure.

(I took authorship since only the #defines & part of the commit
message came from the original commit)

-- >8 --
=46rom 2351c46fd1c9f6de312463875a4887f03d365b76 Mon Sep 17 00:00:00 2001
=46rom: Conor Dooley <conor.dooley@microchip.com>
Date: Wed, 12 Jul 2023 11:25:36 +0100
Subject: [PATCH] RISC-V: add detection of scalar crypto extensions

It is worth noting that the Scalar Crypto extension defines "zk" as a
shorthand for the Zkn, Zkr and Zkt extensions. Since the Zkn one also
implies the Zbkb, Zbkc and Zbkx extensions, simply passing the valid
"zk" extension name through a DT shold enable all of the Zbkb, Zbkc,
Zbkx, Zkn, Zkr and Zkt extensions.
For example, setting the "riscv,isa" DT property to "rv64imafdc_zk"
should generate the following cpuinfo output:
"rv64imafdc_zicntr_zicsr_zifencei_zihpm_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_z=
kt"

riscv_isa_ext_data grows a pair of new members, to permit searching for
supersets of the extension in question, both while parsing the ISA
string and the new dedicated extension properties.

Co-developed-by: Hongren (Zenithal) Zheng <i@zenithal.me>
Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
Co-developed-by: Samuel Ortiz <sameo@rivosinc.com>
Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/hwcap.h | 13 +++++
 arch/riscv/kernel/cpufeature.c | 95 +++++++++++++++++++++++++++++-----
 2 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b7b58258f6c7..46d54f31e162 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -58,6 +58,17 @@
 #define RISCV_ISA_EXT_ZICSR		40
 #define RISCV_ISA_EXT_ZIFENCEI		41
 #define RISCV_ISA_EXT_ZIHPM		42
+#define RISCV_ISA_EXT_ZBC		43
+#define RISCV_ISA_EXT_ZBKB		44
+#define RISCV_ISA_EXT_ZBKC		45
+#define RISCV_ISA_EXT_ZBKX		46
+#define RISCV_ISA_EXT_ZKND		47
+#define RISCV_ISA_EXT_ZKNE		48
+#define RISCV_ISA_EXT_ZKNH		49
+#define RISCV_ISA_EXT_ZKR		50
+#define RISCV_ISA_EXT_ZKSED		51
+#define RISCV_ISA_EXT_ZKSH		52
+#define RISCV_ISA_EXT_ZKT		53
=20
 #define RISCV_ISA_EXT_MAX		64
=20
@@ -77,6 +88,8 @@ struct riscv_isa_ext_data {
 	const unsigned int id;
 	const char *name;
 	const char *property;
+	const unsigned int superset_count;
+	const char **subset_of;
 };
=20
 extern const struct riscv_isa_ext_data riscv_isa_ext[];
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 5945dfc5f806..e862958d5495 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -103,8 +103,22 @@ static bool riscv_isa_extension_check(int id)
 	.name =3D #_name,				\
 	.property =3D #_name,			\
 	.id =3D _id,				\
+	.superset_count =3D 0,			\
+	.subset_of =3D NULL,			\
 }
=20
+#define __RISCV_ISA_EXT_DATA_SUBSET(_name, _id, _subset_of) {	\
+	.name =3D #_name,						\
+	.property =3D #_name,					\
+	.id =3D _id,						\
+	.superset_count =3D ARRAY_SIZE(_subset_of),		\
+	.subset_of =3D _subset_of,				\
+}
+
+static const char * const riscv_subset_of_zbk[] =3D { "zk", "zkn", "zks" };
+static const char * const riscv_subset_of_zkn[] =3D { "zk", "zkn" };
+static const char * const riscv_subset_of_zk[]  =3D { "zk" };
+static const char * const riscv_subset_of_zks[] =3D { "zks" };
 /*
  * The canonical order of ISA extension names in the ISA string is defined=
 in
  * chapter 27 of the unprivileged specification.
@@ -167,7 +181,18 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
+	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
+	__RISCV_ISA_EXT_DATA_SUBSET(zbkb, RISCV_ISA_EXT_ZBKB, riscv_subset_of_zbk=
),
+	__RISCV_ISA_EXT_DATA_SUBSET(zbkc, RISCV_ISA_EXT_ZBKC, riscv_subset_of_zbk=
),
+	__RISCV_ISA_EXT_DATA_SUBSET(zbkx, RISCV_ISA_EXT_ZBKX, riscv_subset_of_zbk=
),
 	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
+	__RISCV_ISA_EXT_DATA_SUBSET(zknd, RISCV_ISA_EXT_ZKND, riscv_subset_of_zkn=
),
+	__RISCV_ISA_EXT_DATA_SUBSET(zkne, RISCV_ISA_EXT_ZKNE, riscv_subset_of_zkn=
),
+	__RISCV_ISA_EXT_DATA_SUBSET(zknh, RISCV_ISA_EXT_ZKNH, riscv_subset_of_zkn=
),
+	__RISCV_ISA_EXT_DATA_SUBSET(zkr, RISCV_ISA_EXT_ZKR, riscv_subset_of_zk),
+	__RISCV_ISA_EXT_DATA_SUBSET(zksed, RISCV_ISA_EXT_ZKSED, riscv_subset_of_z=
ks),
+	__RISCV_ISA_EXT_DATA_SUBSET(zksh, RISCV_ISA_EXT_ZKSH, riscv_subset_of_zks=
),
+	__RISCV_ISA_EXT_DATA_SUBSET(zkt, RISCV_ISA_EXT_ZKT, riscv_subset_of_zk),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
@@ -179,6 +204,31 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
=20
 const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
=20
+static inline int __init riscv_try_match_extension(const char *name, const=
 unsigned int bit,
+						   const char *ext, const char *ext_end,
+						   struct riscv_isainfo *isainfo)
+{
+	if ((ext_end - ext =3D=3D strlen(name)) && !strncasecmp(ext, name, strlen=
(name)) &&
+	    riscv_isa_extension_check(bit)) {
+		set_bit(bit, isainfo->isa);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static inline void __init riscv_try_match_supersets(struct riscv_isa_ext_d=
ata ext_data,
+						    const char *ext, const char *ext_end,
+						    struct riscv_isainfo *isainfo)
+{
+	for (int i =3D 0; i < ext_data.superset_count; i++) {
+		const char *superset =3D ext_data.subset_of[i];
+		const int bit =3D ext_data.id;
+
+		riscv_try_match_extension(superset, bit, ext, ext_end, isainfo);
+	}
+}
+
 static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struc=
t riscv_isainfo *isainfo,
 					  unsigned long *isa2hwcap, const char *isa)
 {
@@ -310,16 +360,9 @@ static void __init riscv_parse_isa_string(unsigned lon=
g *this_hwcap, struct risc
 		if (*isa =3D=3D '_')
 			++isa;
=20
-#define SET_ISA_EXT_MAP(name, bit)						\
-		do {								\
-			if ((ext_end - ext =3D=3D sizeof(name) - 1) &&		\
-			     !strncasecmp(ext, name, sizeof(name) - 1) &&	\
-			     riscv_isa_extension_check(bit))			\
-				set_bit(bit, isainfo->isa);			\
-		} while (false)							\
-
 		if (unlikely(ext_err))
 			continue;
+
 		if (!ext_long) {
 			int nr =3D tolower(*ext) - 'a';
=20
@@ -327,12 +370,21 @@ static void __init riscv_parse_isa_string(unsigned lo=
ng *this_hwcap, struct risc
 				*this_hwcap |=3D isa2hwcap[nr];
 				set_bit(nr, isainfo->isa);
 			}
-		} else {
+
 			for (int i =3D 0; i < riscv_isa_ext_count; i++)
-				SET_ISA_EXT_MAP(riscv_isa_ext[i].name,
-						riscv_isa_ext[i].id);
+				riscv_try_match_supersets(riscv_isa_ext[i], ext, ext_end, isainfo);
+		} else {
+			for (int i =3D 0; i < riscv_isa_ext_count; i++) {
+				const char *name =3D riscv_isa_ext[i].name;
+				const int bit =3D riscv_isa_ext[i].id;
+				int ret;
+
+				ret =3D riscv_try_match_extension(name, bit, ext, ext_end, isainfo);
+				if (ret && riscv_isa_ext[i].superset_count)
+					riscv_try_match_supersets(riscv_isa_ext[i], ext,
+								  ext_end, isainfo);
+			}
 		}
-#undef SET_ISA_EXT_MAP
 	}
 }
=20
@@ -434,8 +486,23 @@ static int __init riscv_fill_hwcap_from_ext_list(unsig=
ned long *isa2hwcap)
 			continue;
=20
 		for (int i =3D 0; i < riscv_isa_ext_count; i++) {
-			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
-						     riscv_isa_ext[i].property) < 0)
+			struct riscv_isa_ext_data ext =3D riscv_isa_ext[i];
+			int ret;
+
+			ret =3D of_property_match_string(cpu_node, "riscv,isa-extensions",
+						       ext.property);
+
+			if (ret < 0 && ext.superset_count) {
+				for (int j =3D 0; j < ext.superset_count; j++) {
+					ret =3D of_property_match_string(cpu_node,
+								       "riscv,isa-extensions",
+								       ext.subset_of[j]);
+					if (ret >=3D 0)
+						break;
+				}
+			}
+
+			if (ret < 0)
 				continue;
=20
 			if (!riscv_isa_extension_check(riscv_isa_ext[i].id))
--=20
2.40.1



--c48Ux8GZXj1FBAWH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK6C1AAKCRB4tDGHoIJi
0tD/AQDlvIraPbF1evwYo66BA1BzWBy4uEvE8kaRCmRrQAVpdQEAujpS9SldE/5W
tg5nKVk2N0LAgJyJ/rIIZioKQhPooAQ=
=3f/A
-----END PGP SIGNATURE-----

--c48Ux8GZXj1FBAWH--
