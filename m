Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EEA6879F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjBBKRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjBBKRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:17:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AE022A00
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675333031; x=1706869031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RE8KppuriIpS4OnnUNQ77ZJQmWIyQI5KLTAW/JHbLfQ=;
  b=UnecHz2SfsLJCowmEOttqsulJjeKoqvtd+TpG6egObJM5qYgN2OYNmm0
   ykwTetWH56eOqO2r2SoWXsFeeJBByev/1gPjwzQDXqxgF8htscTaAc/Z9
   vHWSUlJdM+cn6fL71DrZN/FChRcNqGzrAUDx41sXc1W1DJ3FTLuiVpSEP
   fmhgpTLdJiJXb/08hV14XdwoqBhc5r1N7oWbG+K0RZ8J457/ler0rLio5
   rULVs+WvAzUhYAsaJ8lHWrvszCCO1ed/R3cF6toYwvoMt1hYUIo1Lgtm+
   9vN6CCUUqGCszwKYPskS6XX1Gv1SsQ3O7NEnL2q2IRZivYU6frL84/Tjc
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,267,1669100400"; 
   d="asc'?scan'208";a="198596478"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Feb 2023 03:17:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 03:17:08 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 2 Feb 2023 03:17:06 -0700
Date:   Thu, 2 Feb 2023 10:16:42 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>, <bjorn@kernel.org>,
        <heiko@sntech.de>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liaochang1@huawei.com>
Subject: Re: [PATCH v6 04/13] riscv/kprobe: Add common RVI and RVC
 instruction decoder code
Message-ID: <Y9uNinPr0jR2+5H/@wendy>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
 <20230127130541.1250865-5-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ceVEnnn1dnSN8Qbv"
Content-Disposition: inline
In-Reply-To: <20230127130541.1250865-5-chenguokai17@mails.ucas.ac.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ceVEnnn1dnSN8Qbv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Chen, Liao, Bjorn, Heiko,

Heiko certainly has a more complete understanding of the newly added
stuff in insn*.h, but I've attempted to have a look at the insn stuff
that you have added here...

On Fri, Jan 27, 2023 at 09:05:32PM +0800, Chen Guokai wrote:
> From: Liao Chang <liaochang1@huawei.com>
>=20
> These RVI and RVC instruction decoder are used in the free register
> searching algorithm, each instruction of instrumented function needs to
> decode and test if it contains a free register to form AUIPC/JALR.
>=20
> For RVI instruction format, the position and length of rs1/rs2/rd/opcode
> parts are uniform [1], but RVC instruction formats are complicated, so
> it addresses a series of functions to decode rs1/rs2/rd for RVC [1].
>=20
> [1] https://github.com/riscv/riscv-isa-manual/releases

Please make these regular link tags, so:
Link: https://github.com/riscv/riscv-isa-manual/releases [1]

> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> ---
>  arch/riscv/include/asm/bug.h             |   5 +-
>  arch/riscv/kernel/probes/decode-insn.h   | 148 +++++++++++++++++++++++
>  arch/riscv/kernel/probes/simulate-insn.h |  42 +++++++
>  3 files changed, 194 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
> index 1aaea81fb141..9c33d3b58225 100644
> --- a/arch/riscv/include/asm/bug.h
> +++ b/arch/riscv/include/asm/bug.h
> @@ -19,11 +19,14 @@
>  #define __BUG_INSN_32	_UL(0x00100073) /* ebreak */
>  #define __BUG_INSN_16	_UL(0x9002) /* c.ebreak */
> =20
> +#define RVI_INSN_LEN	4UL
> +#define RVC_INSN_LEN	2UL
> +
>  #define GET_INSN_LENGTH(insn)						\
>  ({									\
>  	unsigned long __len;						\
>  	__len =3D ((insn & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_32) ?	\
> -		4UL : 2UL;						\
> +		RVI_INSN_LEN : RVC_INSN_LEN;				\
>  	__len;								\
>  })
> =20
> diff --git a/arch/riscv/kernel/probes/decode-insn.h b/arch/riscv/kernel/p=
robes/decode-insn.h
> index 42269a7d676d..785b023a62ea 100644
> --- a/arch/riscv/kernel/probes/decode-insn.h
> +++ b/arch/riscv/kernel/probes/decode-insn.h
> @@ -3,6 +3,7 @@
>  #ifndef _RISCV_KERNEL_KPROBES_DECODE_INSN_H
>  #define _RISCV_KERNEL_KPROBES_DECODE_INSN_H
> =20
> +#include <linux/bitops.h>
>  #include <asm/sections.h>
>  #include <asm/kprobes.h>
> =20
> @@ -15,4 +16,151 @@ enum probe_insn {
>  enum probe_insn __kprobes
>  riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *as=
i);
> =20
> +#ifdef CONFIG_KPROBES
> +
> +static inline u16 rvi_rs1(kprobe_opcode_t opcode)
> +{
> +	return (u16)((opcode >> 15) & 0x1f);

insn.h has a bunch of defines for this kind of thing, that have all been
reviewed. We definitely should be using those here, at the very least,
rather than having to review all of these numbers for a second time.
eg:
#define RVG_RS1_OPOFF		15

IMO, anything you need here should either be in that file, or added to
that file by this patch.

> +}
> +
> +static inline u16 rvi_rs2(kprobe_opcode_t opcode)

Also a note, these functions look really odd in their callsites:
+               if (riscv_insn_is_c_jr(insn)) {
+                       READ_ON(rvc_r_rs1(insn));
+                       break;
+               }

Sticking with the existing naming scheme would be great, thanks.
I think these should be moved to insn.h and renamed to:
riscv_insn_extract_rs1(), and ditto for the other things you are newly
adding here.

> +{
> +	return (u16)((opcode >> 20) & 0x1f);
> +}
> +
> +static inline u16 rvi_rd(kprobe_opcode_t opcode)
> +{
> +	return (u16)((opcode >> 7) & 0x1f);
> +}
> +
> +static inline s32 rvi_branch_imme(kprobe_opcode_t opcode)

RV_EXTRACT_BTYPE_IMM() already exists and provides the same capability,
no? I think the whole patch here should be moved to insn.h, reuse the
defines there and have the function names changed to match the existing,
similar functions.

> +{
> +	u32 imme =3D 0;
> +
> +	imme |=3D (((opcode >> 8)  & 0xf)   << 1)  |
> +		(((opcode >> 25) & 0x3f)  << 5)  |
> +		(((opcode >> 7)  & 0x1)   << 11) |
> +		(((opcode >> 31) & 0x1)   << 12);
> +
> +	return sign_extend32(imme, 13);
> +}
> +
> +static inline s32 rvi_jal_imme(kprobe_opcode_t opcode)

This is a re-implementation of riscv_insn_extract_jtype_imm() except
without the nice defines etc used there.

> +{
> +	u32 imme =3D 0;
> +
> +	imme |=3D (((opcode >> 21) & 0x3ff) << 1)  |
> +		(((opcode >> 20) & 0x1)   << 11) |
> +		(((opcode >> 12) & 0xff)  << 12) |
> +		(((opcode >> 31) & 0x1)   << 20);
> +
> +	return sign_extend32(imme, 21);
> +}
> +
> +#ifdef CONFIG_RISCV_ISA_C

As Bjorn pointed out, this guard can go.

> +static inline u16 rvc_r_rs1(kprobe_opcode_t opcode)
> +{
> +	return (u16)((opcode >> 2) & 0x1f);

Again, defines exist for all of this stuff already that you can go and
use.
rvc_r_rs1() should be renamed to riscv_insn_extract_csstype_rs1() or
something like that to match the existing users IMO.

Also, perhaps I've missed something, but how does a shift of 2 work for
a CR format rs1? Shouldn't it be a shift of 7?

> +}
> +
> +static inline u16 rvc_r_rs2(kprobe_opcode_t opcode)
> +{
> +	return (u16)((opcode >> 2) & 0x1f);
> +}

(snip)

> +static inline u16 rvc_b_rd(kprobe_opcode_t opcode)
> +{
> +	return (u16)((opcode >> 7) & 0x7);
> +}

All of these are so common, that I feel you'd be very well served by
defines and some macros.

> +static inline s32 rvc_branch_imme(kprobe_opcode_t opcode)

Similar comments apply here as in the G case, in particular you can use
RVC_EXTRACT_JTYPE_IMM(), no?

> +{
> +	u32 imme =3D 0;
> +
> +	imme |=3D (((opcode >> 3)  & 0x3) << 1) |
> +		(((opcode >> 10) & 0x3) << 3) |
> +		(((opcode >> 2)  & 0x1) << 5) |
> +		(((opcode >> 5)  & 0x3) << 6) |
> +		(((opcode >> 12) & 0x1) << 8);
> +
> +	return sign_extend32(imme, 9);
> +}
> +
> +static inline s32 rvc_jal_imme(kprobe_opcode_t opcode)

Ditto here, but BTYPE instead?

> +{
> +	u32 imme =3D 0;
> +
> +	imme |=3D (((opcode >> 3)  & 0x3) << 1) |
> +		(((opcode >> 11) & 0x1) << 4) |
> +		(((opcode >> 2)  & 0x1) << 5) |
> +		(((opcode >> 7)  & 0x1) << 6) |
> +		(((opcode >> 6)  & 0x1) << 7) |
> +		(((opcode >> 9)  & 0x3) << 8) |
> +		(((opcode >> 8)  & 0x1) << 10) |
> +		(((opcode >> 12) & 0x1) << 11);
> +
> +	return sign_extend32(imme, 12);
> +}
> +#endif /* CONFIG_KPROBES */
> +#endif /* CONFIG_RISCV_ISA_C */
>  #endif /* _RISCV_KERNEL_KPROBES_DECODE_INSN_H */
> diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel=
/probes/simulate-insn.h
> index a19aaa0feb44..e89747dfabbb 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.h
> +++ b/arch/riscv/kernel/probes/simulate-insn.h
> @@ -28,4 +28,46 @@ bool simulate_branch(u32 opcode, unsigned long addr, s=
truct pt_regs *regs);
>  bool simulate_jal(u32 opcode, unsigned long addr, struct pt_regs *regs);
>  bool simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *regs);
> =20
> +/* RVC(S) instructions contain rs1 and rs2 */
> +__RISCV_INSN_FUNCS(c_sq,	0xe003, 0xa000);
> +__RISCV_INSN_FUNCS(c_sw,	0xe003, 0xc000);
> +__RISCV_INSN_FUNCS(c_sd,	0xe003, 0xe000);

I think all of these should move to insn.h too, and have defines to
match the existing __RISCV_INSN_FUNCS there.
Perhaps Heiko has a more nuanced opinion on this.

Thanks,
Conor.

--ceVEnnn1dnSN8Qbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9uNigAKCRB4tDGHoIJi
0oRRAQDOeCLUPMkEPAxghxxpVc3PvNRbNG5Mx7ee10SmsKMEAwEAquK2rnZjHTAj
HBiP7cUl9yIPjuXWxAzVdpM3dX8XRAY=
=Cf46
-----END PGP SIGNATURE-----

--ceVEnnn1dnSN8Qbv--
