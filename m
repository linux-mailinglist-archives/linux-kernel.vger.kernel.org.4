Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820BA7416C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjF1Qu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjF1QuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A522972
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B289612A8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1D2C433C8;
        Wed, 28 Jun 2023 16:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687971000;
        bh=fz6oYL8WMM8A1SZ55vM28dFYjuy0qRd68EmZpoV7vm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qaW+J5YMvHxXpxoTnH+DHyvvdx0+xyJjRh+ENX5lt48tR8wtasuCNGKVV285BUDWd
         +wblad0tJfNzaImiu1+YU+j+vTxQ3xsHd9SgapSCKuPzOwzR5Rz3znz/0UQugueS6G
         F5w7Szh8myASt2lQuGpohmb5dtRtAXdGc1wMQD605x8YjwT4kBaBFQjFyw2GW7r1br
         T3WlSlBv9hzcoXKNXxqM8ICudPgge6X+ULalBqz+EDsvjZRFIl/eeq7hLbnYzwbLzK
         Z2HPiyAB2vFCubqG+vkhnKuUw1b4+pa+H9fUV+JqlHoFudImI8jQiKTQX7uQSvHGf9
         wNqMG5x8lxSyA==
Date:   Wed, 28 Jun 2023 17:49:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Samuel Ortiz <sameo@rivosinc.com>, Evan Green <evan@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, linux@rivosinc.com,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <20230628-onstage-uprising-7ffad98708de@spud>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-2-sameo@rivosinc.com>
 <CALs-HssMkVikspnEi-Ek2t=ABvFvgptAhsBjk1+aLuVjiP7P7w@mail.gmail.com>
 <20230627-debating-twelve-da2c1ed60948@spud>
 <ZJwE5wRVkoND3Z6P@vermeer>
 <20230628-unfeeling-tavern-edd4f58396fa@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aFSLZbliI7SJY281"
Content-Disposition: inline
In-Reply-To: <20230628-unfeeling-tavern-edd4f58396fa@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aFSLZbliI7SJY281
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 12:10:11PM +0100, Conor Dooley wrote:
> On Wed, Jun 28, 2023 at 12:01:11PM +0200, Samuel Ortiz wrote:
> > On Tue, Jun 27, 2023 at 07:48:15PM +0100, Conor Dooley wrote:
> > > On Tue, Jun 27, 2023 at 11:14:30AM -0700, Evan Green wrote:
> > > > On Tue, Jun 27, 2023 at 7:38=E2=80=AFAM Samuel Ortiz <sameo@rivosin=
c.com> wrote:
>=20
> > > > It would be nice to consolidate the ones together that search for a
> > > > single string and set multiple bits, though I don't have any super
> > > > elegant ideas for how off the top of my head.
> > >=20
> > > I've got a refactor of this code in progress, dropping all of these
> > > copy-paste in place of a loop. It certainly looks more elegant than
> > > this, but it will fall over a bit for these "one string matches many
> > > extensions" cases. See here:
> > > https://patchwork.kernel.org/project/linux-riscv/patch/20230626-thiev=
ing-jockstrap-d35d20b535c5@wendy/
> > > My immediate thought is to add another element to riscv_isa_ext_data,
> > > that contains "parent" extensions to check for. Should be fairly doab=
le,
> > > I'll whip something up on top of that...
> >=20
> > Nice, and thanks for the review.
>=20
> > Should I wait for your refactor to be merged before pushing this one?
>=20
> I don't know. I think that you should continue on with your series here,
> and whichever goes in second gets rebased on top of the other.
> I don't think it makes material difference to review of this patchset as
> to whether you rebase on top of what I'm working on, so I wouldn't
> bother until it gets merged.
>=20
> Rather hacky, had less time than expected this morning:
> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=
=3Driscv-extensions-strings-supersets
> Clearly there's issues with looping to RISCV_ISA_MAX_SUPERSETS & I just
> repurposed Zicsr for the sake of testing something in the time I had.
>=20
> Evan, at a high level, does that look more elegant to you, or have I made
> things worse?

Got some more time this afternoon, cleaned it up a bit. On top of what
is in
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=3Dri=
scv-extensions-strings
IOW, the not-yet-sent v2 of
https://lore.kernel.org/all/20230626-provable-angrily-81760e8c3cc6@wendy/
here's some infra for doing superset stuff...

Going to send my v2 without this, as there's nothing in tree right now
that actually needs this sort of thing.

-- >8 --
=46rom 0875e1aa2bf773b53cae02490ebc69e798e491c4 Mon Sep 17 00:00:00 2001
=46rom: Conor Dooley <conor.dooley@microchip.com>
Date: Wed, 28 Jun 2023 12:01:40 +0100
Subject: [PATCH] RISC-V: detect extension support from superset extensions

Some extensions, for example scalar crypto's Zk extension, are comprised
of anumber of sub-extensions that may be implemented independently.
Provide some infrastructure for detecting support for an extension where
only its superset appears in DT or ACPI.
SET_ISA_EXT_MAP() already served little purpose, move the code into an
inline function instead, where the code can be reused more easily by the
riscv_try_set_ext_from_supersets().

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/hwcap.h |   3 +
 arch/riscv/kernel/cpufeature.c | 107 ++++++++++++++++++++++++++++-----
 2 files changed, 96 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index c4d6faa5cdf8..5b41a7aa9ec5 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -73,11 +73,14 @@
=20
 unsigned long riscv_get_elf_hwcap(void);
=20
+#define RISCV_ISA_MAX_SUPERSETS 1
 struct riscv_isa_ext_data {
 	const unsigned int id;
 	const char *name;
 	const char *property;
 	const bool multi_letter;
+	const unsigned int num_supersets;
+	const char *supersets[RISCV_ISA_MAX_SUPERSETS];
 };
=20
 extern const struct riscv_isa_ext_data riscv_isa_ext[];
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 53b38f6c0562..0d56f4a11a3e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -104,6 +104,16 @@ static bool riscv_isa_extension_check(int id)
 	.property =3D #_name,				\
 	.id =3D _id,					\
 	.multi_letter =3D _multi,				\
+	.num_supersets =3D 0,				\
+}
+
+#define __RISCV_ISA_EXT_DATA_SUBSET(_name, _id, _multi, _num_supersets, ..=
=2E) {	\
+	.name =3D #_name,								\
+	.property =3D #_name,							\
+	.id =3D _id,								\
+	.multi_letter =3D _multi,							\
+	.num_supersets =3D _num_supersets,					\
+	.supersets =3D {__VA_ARGS__},						\
 }
=20
 /*
@@ -180,6 +190,39 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
=20
 const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
=20
+static inline int __init riscv_try_set_ext(const char *name, const unsigne=
d int bit,
+					   const char *ext, const char *ext_end,
+					   struct riscv_isainfo *isainfo)
+{
+	if ((ext_end - ext =3D=3D strlen(name)) &&
+	    !strncasecmp(ext, name, strlen(name)) &&
+	    riscv_isa_extension_check(bit)) {
+			set_bit(bit, isainfo->isa);
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+static inline void __init riscv_try_set_ext_from_supersets(struct riscv_is=
a_ext_data ext_data,
+							   const char *ext, const char *ext_end,
+							   struct riscv_isainfo *isainfo)
+{
+	for (int i =3D 0; i < ext_data.num_supersets; i++) {
+		const char *superset =3D ext_data.supersets[i];
+		const int bit =3D ext_data.id;
+		int ret;
+
+		/*
+		 * If the extension that's been found is a superset, there's no
+		 * reason to keep looking for other supersets.
+		 */
+		ret =3D riscv_try_set_ext(superset, bit, ext, ext_end, isainfo);
+		if (!ret)
+			return;
+	}
+}
+
 static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struc=
t riscv_isainfo *isainfo,
 					  unsigned long *isa2hwcap, const char *isa)
 {
@@ -311,14 +354,6 @@ static void __init riscv_parse_isa_string(unsigned lon=
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
 		if (!ext_long) {
@@ -328,12 +363,27 @@ static void __init riscv_parse_isa_string(unsigned lo=
ng *this_hwcap, struct risc
 				*this_hwcap |=3D isa2hwcap[nr];
 				set_bit(nr, isainfo->isa);
 			}
-		} else {
+
 			for (int i =3D 0; i < riscv_isa_ext_count; i++)
-				SET_ISA_EXT_MAP(riscv_isa_ext[i].name,
-						riscv_isa_ext[i].id);
+				riscv_try_set_ext_from_supersets(riscv_isa_ext[i],
+								 ext, ext_end, isainfo);
+		} else {
+			for (int i =3D 0; i < riscv_isa_ext_count; i++) {
+				const char *name =3D riscv_isa_ext[i].name;
+				const int bit =3D riscv_isa_ext[i].id;
+				int ret;
+
+				ret =3D riscv_try_set_ext(name, bit, ext, ext_end, isainfo);
+
+				/*
+				 * There's no point checking if the extension that the parser has
+				 * just found is a superset, if it is the extension itself...
+				 */
+				if (!ret)
+					riscv_try_set_ext_from_supersets(riscv_isa_ext[i],
+									 ext, ext_end, isainfo);
+			}
 		}
-#undef SET_ISA_EXT_MAP
 	}
 }
=20
@@ -416,6 +466,28 @@ static void __init riscv_fill_hwcap_from_isa_string(un=
signed long *isa2hwcap)
 		acpi_put_table((struct acpi_table_header *)rhct);
 }
=20
+static inline bool riscv_ext_superset_present(struct riscv_isa_ext_data ex=
t_data,
+					      struct device_node *cpu_node)
+{
+	if (!ext_data.num_supersets)
+		return false;
+
+	for (int i =3D 0; i < ext_data.num_supersets; i++) {
+		const char *superset =3D ext_data.supersets[i];
+		int ret;
+
+		/*
+		 * Once a single superset is found, there's no point looking
+		 * for any other ones.
+		 */
+		ret =3D of_property_match_string(cpu_node,"riscv,isa-extensions", supers=
et);
+		if (ret >=3D 0)
+			return true;
+	}
+
+	return false;
+}
+
 static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 {
 	unsigned int cpu;
@@ -435,8 +507,15 @@ static int __init riscv_fill_hwcap_from_ext_list(unsig=
ned long *isa2hwcap)
 			continue;
=20
 		for (int i =3D 0; i < riscv_isa_ext_count; i++) {
-			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
-						     riscv_isa_ext[i].name) < 0)
+			int ret =3D of_property_match_string(cpu_node, "riscv,isa-extensions",
+							   riscv_isa_ext[i].name);
+
+			/*
+			 * If the extension itself is not found it could be a
+			 * subset of another extension, so the supersets need to
+			 * be checked for too.
+			 */
+			if (ret < 0 && !riscv_ext_superset_present(riscv_isa_ext[i], cpu_node))
 				continue;
=20
 			if (!riscv_isa_extension_check(riscv_isa_ext[i].id))
--=20
2.39.2


--aFSLZbliI7SJY281
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJxksgAKCRB4tDGHoIJi
0uguAP9w6UGAbwdGVRmnHn0Ot1n3gcwF5jkS7Pm+zWlvJsneHwD/el1vCRlqkGBL
88Rrj3KVJBn5wlL3GhAdGkRzhEmFDgA=
=JbhN
-----END PGP SIGNATURE-----

--aFSLZbliI7SJY281--
