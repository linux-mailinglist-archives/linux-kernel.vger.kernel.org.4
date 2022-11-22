Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1AB63352C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiKVGU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKVGUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:20:54 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFB52D768;
        Mon, 21 Nov 2022 22:20:45 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.54]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M2fM1-1ousrZ3p9j-004Edz; Tue, 22 Nov 2022 07:20:15 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 082133C0C9;
        Tue, 22 Nov 2022 07:20:13 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id DF42A1D3; Tue, 22 Nov 2022 07:20:10 +0100 (CET)
Date:   Tue, 22 Nov 2022 07:20:10 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] kbuild: warn objects shared among multiple modules
Message-ID: <Y3xqGhVXAladyxfg@bergen.fjasle.eu>
References: <20221118191551.66448-1-masahiroy@kernel.org>
 <20221118191551.66448-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HDHNqeNCmU9MyyfY"
Content-Disposition: inline
In-Reply-To: <20221118191551.66448-2-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:zbUCQwvMaCZqtljLJA/QwYwp/KwQ/fPw3UNPZOjTNZKLs/MWXMs
 YLpA3cl1vk0ETouTf7hkJrhr++UyEIyk44MrU1sOCJeXz4GIhNr/Po14636am1VqE0K/sz6
 0XFgEgB8Tbv0F1EPEILMFynUeN9dTA/dB5ph+iCuF6HbDUWN5h802JGkw1TMyZAwP0X5+Lk
 el70jpdjnF840QPYGXvOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4I4PArsRhHE=:mXgf1OtDhbnKEMgQfR4vMU
 c59MsldGHYguWscPBlyY7T4feHckg0HkIhJjXHcuDn9VhlqSBmVj0iBDvPc8bEdB1AEBBKxAn
 p6feUp5vt/zdvSToco9gYQhb9IzDtfMBsjlzCNwVK7yAekAs5eaJiNWzYpRXmSnRKwJmCsKqi
 VX6xEghjvV5vcyvdtfQILGD16Yq//ebpigI6U7VyEBhrUH786T0FApst6+6Xbl8bUFbx68q16
 F1xjoPjFTyvNuXY2JYECcPShnG25QIflWe95SH7ismtZPu593i+8SN0zf3Y8EMDnpb7D4qLHE
 AYQ0gtiVIntMr/9J9MlKu4iK0Aya4oU4rgqfdy4WQuzzD3r2PSNvtMpDEaHVZgsP+6Ec25J3N
 Cu7L02TmzKE5q6RGnSuOrRtT4sZ/wVkkNtqr0ft4EkEqAPjjtrDZzvoU7DjB3e3pw0rLIc8sr
 17BsJWAB0khzScSULCGgA5LfAZhEpEkfDdRKgZQrXSnKsagxogR8XYshp/76Bn9EWPrq0xxSZ
 X2URUhJhONsYLbK8SRamKTR4YgvVZJxpzIrbc5qUA4EnvVR8uiWZ19HO1jIcfs1nBvFlIf8FI
 DvdQ1WLvzaxzO89GoLbzfeOXGgtIqe/Yb+f7TtEuuHNn7nUH9jO+EHQVs5Jfsu78UILD5K1Et
 sKvoLcjhDq7Au6rU99XCeTC29YZhpAVPY6Sv+cndp4xQy+6ZKZgVYU/NuzvLRsdedTqyW1p9j
 HdgmsO31pqEMqbYr032GtxR2mtUUfLcjUj4J+Ds+kBIxbrhhdT7iGKnwpXlKiIUlXBsNifdDv
 1r9C750
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HDHNqeNCmU9MyyfY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 19 Nov 2022 04:15:51 GMT, Masahiro Yamada wrote:
> If an object is shared among multiple modules, amd some of them are

amd -> and

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> configured as 'm', but the others as 'y', the shared object is built
> as modular, then linked to the modules and vmlinux. This is a potential
> issue because the expected CFLAGS are different between modules and
> builtins.
>=20
> Commit 637a642f5ca5 ("zstd: Fixing mixed module-builtin objects")
> reported that this could be even more fatal in some cases such as
> Clang LTO.
>=20
> That commit fixed lib/zlib/zstd_{compress,decompress}, but there are
> still more instances of breakage.
>=20
> This commit adds a W=3D1 warning for shared objects, so that the kbuild
> test robot, which provides build tests with W=3D1, will avoid a new
> breakage slipping in.
>=20
> Quick compile tests on v6.1-rc4 detected the following:
>=20
> scripts/Makefile.build:252: ./drivers/block/rnbd/Makefile: rnbd-common.o =
is added to multiple modules: rnbd-client rnbd-server
> scripts/Makefile.build:252: ./drivers/crypto/marvell/octeontx2/Makefile: =
cn10k_cpt.o is added to multiple modules: rvu_cptpf rvu_cptvf
> scripts/Makefile.build:252: ./drivers/crypto/marvell/octeontx2/Makefile: =
otx2_cptlf.o is added to multiple modules: rvu_cptpf rvu_cptvf
> scripts/Makefile.build:252: ./drivers/crypto/marvell/octeontx2/Makefile: =
otx2_cpt_mbox_common.o is added to multiple modules: rvu_cptpf rvu_cptvf
> scripts/Makefile.build:252: ./drivers/edac/Makefile: skx_common.o is adde=
d to multiple modules: i10nm_edac skx_edac
> scripts/Makefile.build:252: ./drivers/gpu/drm/bridge/imx/Makefile: imx-ld=
b-helper.o is added to multiple modules: imx8qm-ldb imx8qxp-ldb
> scripts/Makefile.build:252: ./drivers/mfd/Makefile: rsmu_core.o is added =
to multiple modules: rsmu-i2c rsmu-spi
> scripts/Makefile.build:252: ./drivers/mtd/tests/Makefile: mtd_test.o is a=
dded to multiple modules: mtd_nandbiterrs mtd_oobtest mtd_pagetest mtd_read=
test mtd_speedtest mtd_stresstest mtd_subpagetest mtd_torturetest
> scripts/Makefile.build:252: ./drivers/net/dsa/ocelot/Makefile: felix.o is=
 added to multiple modules: mscc_felix mscc_seville
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefi=
le: cn23xx_pf_device.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefi=
le: cn23xx_vf_device.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefi=
le: cn66xx_device.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefi=
le: cn68xx_device.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefi=
le: lio_core.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefi=
le: lio_ethtool.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefi=
le: octeon_device.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefi=
le: octeon_droq.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefi=
le: octeon_mailbox.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefi=
le: octeon_mem_ops.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefi=
le: octeon_nic.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefi=
le: request_manager.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/cavium/liquidio/Makefi=
le: response_manager.o is added to multiple modules: liquidio liquidio_vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/dpaa2/Makefi=
le: dpaa2-mac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
> scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/dpaa2/Makefi=
le: dpmac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
> scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/enetc/Makefi=
le: enetc_cbdr.o is added to multiple modules: fsl-enetc fsl-enetc-vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/enetc/Makefi=
le: enetc_ethtool.o is added to multiple modules: fsl-enetc fsl-enetc-vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/freescale/enetc/Makefi=
le: enetc.o is added to multiple modules: fsl-enetc fsl-enetc-vf
> scripts/Makefile.build:252: ./drivers/net/ethernet/hisilicon/hns3/Makefil=
e: hns3_common/hclge_comm_cmd.o is added to multiple modules: hclge hclgevf
> scripts/Makefile.build:252: ./drivers/net/ethernet/hisilicon/hns3/Makefil=
e: hns3_common/hclge_comm_rss.o is added to multiple modules: hclge hclgevf
> scripts/Makefile.build:252: ./drivers/net/ethernet/hisilicon/hns3/Makefil=
e: hns3_common/hclge_comm_tqp_stats.o is added to multiple modules: hclge h=
clgevf
> scripts/Makefile.build:252: ./drivers/net/ethernet/marvell/octeontx2/nic/=
Makefile: otx2_dcbnl.o is added to multiple modules: rvu_nicpf rvu_nicvf
> scripts/Makefile.build:252: ./drivers/net/ethernet/marvell/octeontx2/nic/=
Makefile: otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf
> scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: cpsw_ale.=
o is added to multiple modules: keystone_netcp keystone_netcp_ethss ti_cpsw=
 ti_cpsw_new
> scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: cpsw_etht=
ool.o is added to multiple modules: ti_cpsw ti_cpsw_new
> scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: cpsw_priv=
=2Eo is added to multiple modules: ti_cpsw ti_cpsw_new
> scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: cpsw_sl.o=
 is added to multiple modules: ti_cpsw ti_cpsw_new
> scripts/Makefile.build:252: ./drivers/net/ethernet/ti/Makefile: davinci_c=
pdma.o is added to multiple modules: ti_cpsw ti_cpsw_new ti_davinci_emac
> scripts/Makefile.build:252: ./drivers/platform/x86/intel/int3472/Makefile=
: common.o is added to multiple modules: intel_skl_int3472_discrete intel_s=
kl_int3472_tps68470
> scripts/Makefile.build:252: ./sound/soc/codecs/Makefile: wcd-clsh-v2.o is=
 added to multiple modules: snd-soc-wcd9335 snd-soc-wcd934x snd-soc-wcd938x
>=20
> Once all the warnings are fixed, it can become an error irrespective of
> W=3D option.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> Changes in v2:
>   - Add drivers/block/rnbd/Makefile for commit log
>=20
>  scripts/Makefile.build | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 37cf88d076e8..799df12b53f3 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -222,6 +222,10 @@ endif
> =20
>  cmd_check_local_export =3D $(srctree)/scripts/check-local-export $@
> =20
> +ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
> +cmd_warn_shared_object =3D $(if $(word 2, $(modname-multi)),$(warning $(=
kbuild-file): $*.o is added to multiple modules: $(modname-multi)))
> +endif
> +
>  define rule_cc_o_c
>  	$(call cmd_and_fixdep,cc_o_c)
>  	$(call cmd,gen_ksymdeps)
> @@ -231,6 +235,7 @@ define rule_cc_o_c
>  	$(call cmd,gen_objtooldep)
>  	$(call cmd,gen_symversions_c)
>  	$(call cmd,record_mcount)
> +	$(call cmd,warn_shared_object)
>  endef
> =20
>  define rule_as_o_S
> @@ -239,6 +244,7 @@ define rule_as_o_S
>  	$(call cmd,check_local_export)
>  	$(call cmd,gen_objtooldep)
>  	$(call cmd,gen_symversions_S)
> +	$(call cmd,warn_shared_object)
>  endef
> =20
>  # Built-in and composite module parts
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--HDHNqeNCmU9MyyfY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmN8ahYACgkQB1IKcBYm
EmnxXA/7Biajb0rFzOI7VQvYixV47wyOfxNAb+evRlN84CeruhaR71mLAg2NZQ6H
SjAF1e/OLYuk3JhUK3XKYJ+1nFOG/8oP88cOCEmOjzW3f93iBNLhCHao1tSxCoOT
trx5kk2kEQjWX2pJgnhe/nOJmuO3KcgtYIRyEJqqFwbfHq0bHCcHYP1rU1CiTGGE
ipEOjcMPkD4kxO9OqPrj4SJnn0ahwQY8tmwSTIwUUOzvWrAW1r2osIaMDk10eO/I
TLyxo8IDZ9Hi3rh+ifLzfFw147EfV4a574NwUH7gcuMzr3BOtz8iXVIzsoffzZdb
LVXiU4JhO+T5XphTo0EQfEbl/LOvi6ivjt1uAtDH2/TA9Syr3dx3SsgsKYJLex2+
nP5DAoLklgSQdksdm1g0cshStotyqstcDjCtkEL3YshVUy6bS+i72zJO61MCjfSM
x2yQweXmV72IQSrhkX9Rc2xzd7r7j66bwOujhCwggEhY4pYIedYFfpVwsTJxuHUg
0TgTCUvtAwj50FUGdeYCjuOCmdrOYiKUe0vvAZXP3yD8bWlYXuj8BrWXwM+XRaAn
T2DDK/rLHOIK0uVxsKcCsHKmjYbmdTVPqD2k+tlctbswi0HWB95hOEP6OuNQWceY
zcBySlnT+jc7FgrBwymz7OFrqQ7OJbLQ9gBnb7QSgFjtv8uC8FI=
=Y7+9
-----END PGP SIGNATURE-----

--HDHNqeNCmU9MyyfY--
