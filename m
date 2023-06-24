Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F3873C6E3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 07:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjFXFS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 01:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFXFSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 01:18:52 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110102703
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:18:49 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 725445C0156;
        Sat, 24 Jun 2023 01:18:48 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Sat, 24 Jun 2023 01:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687583928; x=1687670328; bh=aCAkAELSWrDsVs+f+L47uCAlMAmTkP4Y7mb
        0CCnXof4=; b=YfwGfMxIWkCYdpq6gRx+lqFDfQ7D00FGKRqu1Pr1hftUsITq6KR
        obn6rAeDy7vIlRy3xPPlkrq+kDzl/Jocwwe7GbQB+sk0Tce+zXY4EJujXJPQH0Yd
        YMS4rLU18TztFuMHDkQyVxw0sgm0Dn4vp4WLH+/CkoVc3Hc5OWcJhbjbNJoIl578
        x2SfO0Itv8DA/hVvVip7xl9MHRiQCpS71/YMORjp+qZANwAAt7FxOvfZPMFzuTt8
        fRz2udJ7ohXKD4Xy/uZyGNSdAlfWU4GJ8cURB2Rdq3umYysAEma85hh/mla/PxsE
        T+F8BSSvpbWt+3ZVpuyKIELmUvURpWxxasg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687583928; x=1687670328; bh=aCAkAELSWrDsVs+f+L47uCAlMAmTkP4Y7mb
        0CCnXof4=; b=Gbj3j/UcFwCB0fT5KaOAsdE/x3wFOUhjM8N+tLViSAPD3TGIqa3
        9iACZcc8lVDPOs//CMkG/thpuk0lAEnRrPw+cR5dT4a3/PHTEg2h7U1gnTBenPIW
        6fVYOfVD3lVtPsBC14MZgEGkdaN/bfvSAABxo53Ox6FjjqRxCDwLKBUj98vAv5FH
        tlDtoUlXMG4ErpPJ8zmQV9NPw3C3MumU9x0ELV+bp6Zk095+1xC7TdXwunGTcyTd
        +qtVdJPa1/DKu0iK6WsiuYLpyyy7daT37dqyXGo9Yvj+UXIzA/iXITvdF7QV9RO/
        BSWaaEwQ+NymTyZSwL95WxifHc/wQF9rjdQ==
X-ME-Sender: <xms:t3yWZDWQVJTm_i_-aimEPFPw7xreH3MU832d5qDUZ18ZJthPsQHloQ>
    <xme:t3yWZLkgY1A_y8fLT6e44nNmhgVqehv6iS3aQeP8cY7Qf82J-uIz7y1gGPEq0LoaY
    _6W7tAXL2NNGkDtmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfu
    thgvfhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqe
    enucggtffrrghtthgvrhhnpeffteehhefguedtleeufeekgfduvddufffhuddvkeevhfff
    uedttdffheelfefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhhfrhgrug
    gvrggurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepshhorhgvrghrsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:t3yWZPZ8h9n3iWPIw4JezE6Niqk5KJdTpdX6Jk3vO0omhVp2sXwjIg>
    <xmx:t3yWZOWkoCSk10YhuTlvEHhbzJZj22zTEX9v3SFwEPmDVGPxjdfsFw>
    <xmx:t3yWZNm368Es_sRsATGG8ntIKtUfN3s9rXBRWLiKaIioM2Zb4cBywA>
    <xmx:uHyWZLZsCjYXKuiwCwPQevweKOb9mLu83SB5C6COtF8OOPT9820Qrg>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B5A351700096; Sat, 24 Jun 2023 01:18:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <0904a831-82c5-47a0-be55-f1a59d0115c2@app.fastmail.com>
In-Reply-To: <1908808.taCxCBeP46@diego>
References: <20230622231305.631331-1-heiko@sntech.de>
 <20230622231305.631331-4-heiko@sntech.de>
 <20230623-excluding-sprint-aea9cca0cb02@wendy> <1908808.taCxCBeP46@diego>
Date:   Sat, 24 Jun 2023 01:18:26 -0400
From:   "Stefan O'Rear" <sorear@fastmail.com>
To:     "Heiko Stuebner" <heiko@sntech.de>,
        "Conor Dooley" <conor.dooley@microchip.com>
Cc:     "Palmer Dabbelt" <palmer@dabbelt.com>, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, samuel@sholland.org,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] RISC-V: add T-Head vector errata handling
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023, at 6:40 AM, Heiko St=C3=BCbner wrote:
> Hey Conor,
>
> Am Freitag, 23. Juni 2023, 11:49:41 CEST schrieb Conor Dooley:
>> On Fri, Jun 23, 2023 at 01:13:05AM +0200, Heiko Stuebner wrote:
>> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>> >=20
>> > T-Head C9xx cores implement an older version (0.7.1) of the vector
>> > specification.
>> >=20
>> > Relevant changes concerning the kernel are:
>> > - different placement of the SR_VS bit for the vector unit status
>> > - different encoding of the vsetvli instruction
>> > - different instructions for loads and stores
>> >=20
>> > And a fixed VLEN of 128.
>> >=20
>> > The in-kernel access to vector instances is limited to the save and
>> > restore of process states so the above mentioned areas can simply be
>> > handled via the alternatives framework, similar to other T-Head spe=
cific
>> > issues.
>> >=20
>> > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
>> > ---
>> >  arch/riscv/Kconfig.errata            |  13 +++
>> >  arch/riscv/errata/thead/errata.c     |  32 ++++++
>> >  arch/riscv/include/asm/csr.h         |  24 ++++-
>> >  arch/riscv/include/asm/errata_list.h |  45 ++++++++-
>> >  arch/riscv/include/asm/vector.h      | 139 +++++++++++++++++++++++=
++--
>> >  arch/riscv/kernel/vector.c           |   2 +-
>> >  6 files changed, 238 insertions(+), 17 deletions(-)
>> >=20
>> > diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
>> > index 0c8f4652cd82..b461312dd452 100644
>> > --- a/arch/riscv/Kconfig.errata
>> > +++ b/arch/riscv/Kconfig.errata
>> > @@ -77,4 +77,17 @@ config ERRATA_THEAD_PMU
>> > =20
>> >  	  If you don't know what to do here, say "Y".
>> > =20
>> > +config ERRATA_THEAD_VECTOR
>> > +	bool "Apply T-Head Vector errata"
>> > +	depends on ERRATA_THEAD && RISCV_ISA_V
>> > +	default y
>> > +	help
>> > +	  The T-Head C9xx cores implement an earlier version 0.7.1
>> > +	  of the vector extensions.
>> > +
>> > +	  This will apply the necessary errata to handle the non-standard
>> > +	  behaviour via when switch to and from vector mode for processes.

Doesn't make sense.  "This will apply the necessary errata to handle the
non-standard behavior when enabling, disabling, or swapping vector state=
 for
processes."?

>> > +
>> > +	  If you don't know what to do here, say "Y".
>> > +
>> >  endmenu # "CPU errata selection"
>> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/t=
head/errata.c
>> > index c259dc925ec1..c41ec84bc8a5 100644
>> > --- a/arch/riscv/errata/thead/errata.c
>> > +++ b/arch/riscv/errata/thead/errata.c
>> > @@ -15,6 +15,7 @@
>> >  #include <asm/errata_list.h>
>> >  #include <asm/hwprobe.h>
>> >  #include <asm/patch.h>
>> > +#include <asm/vector.h>
>> >  #include <asm/vendorid_list.h>
>> > =20
>> >  static bool errata_probe_pbmt(unsigned int stage,
>> > @@ -66,6 +67,34 @@ static bool errata_probe_pmu(unsigned int stage,
>> >  	return true;
>> >  }
>> > =20
>> > +static bool errata_probe_vector(unsigned int stage,
>> > +				unsigned long arch_id, unsigned long impid)
>> > +{
>> > +	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_VECTOR))
>> > +		return false;
>> > +
>> > +	/* target-c9xx cores report arch_id and impid as 0 */
>> > +	if (arch_id !=3D 0 || impid !=3D 0)
>> > +		return false;
>> > +
>> > +	if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT) {
>> > +		/*
>> > +		 * Disable VECTOR to detect illegal usage of vector in kernel.
>> > +		 * This is normally done in _start_kernel but with the
>> > +		 * vector-1.0 SR_VS bits. VS is using [24:23] on T-Head's
>> > +		 * vector-0.7.1 and the vector-1.0-bits are unused there.
>> > +		 */
>> > +		csr_clear(CSR_STATUS, SR_VS_THEAD);
>> > +		return false;
>> > +	}
>> > +
>> > +	/* let has_vector() return true and set the static vlen */
>>=20
>> Hmm, I was wondering about how you were going to communicate this to
>> userspace, since you're not going to be setting "v" in your DT, so
>> there'll be nothing in /proc/cpuinfo indicating it. (I am assuming th=
at
>> this is your intention, as you'd not need to drop the alternative-bas=
ed
>> stuff from has_vector() if it wasn't)
>
> I'm working on the assumption that the t-head vector is way to differe=
nt
> from the official vector, that a userspace will definitly need to hand=
le this
> in some way specially and we can't claim to use a "real" vector spec.
>
> So in this first step, my goal is to simply allow userspace programs
> compiled to use the t-head vector instructions (i.e. 0.7.1 presumably)=
 to
> not hang the kernel and do all the necessary bringup and teardown need=
ed
> for executing those vector instructions ;-) .
>
>
>> I don't think you can do this, as things stand, because of how hwprobe
>> operates:
>>=20
>> static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>> 			     const struct cpumask *cpus)
>> {
>> 	...
>>=20
>> 	if (has_vector())
>> 		pair->value |=3D RISCV_HWPROBE_IMA_V;
>>=20
>> 	...
>> }
>>=20
>>   * :c:macro:`RISCV_HWPROBE_IMA_V`: The V extension is supported, as =
defined by
>>     version 1.0 of the RISC-V Vector extension manual.
>>=20
>> You'll need to change hwprobe to use has_vector() &&
>> riscv_has_extension_unlikely(v), or similar, as the condition for
>> reporting.
>
> ah right, and yes I need to adapt hwprobe as you wrote.
>
>
>> You'll also need some other way to communicate to userspace
>> that T-Head's vector stuff is supported, no?
>
> As I said above, baby-steps - not-dying first ;-) .

(Count me as a vote for adding a new RISCV_HWPROBE_KEY_ - ints are cheap=
 and
apart from the half-implemented heterogenous case, the only advantage of
hwprobe over hwcap is that we can support a virtually unlimited number of
draft and vendor extensions.)

>> I'm also _really_ unconvinced that turning on extensions that were not
>> indicated in the DT or via ACPI is something we should be doing. Have=
 I
>> missed something here that'd make that assessment inaccurate?
>
> Hmm, DT (and ACPI) is a (static) hardware-description, not a configura=
tion
> space (sermon of DT maintainers for years), so the ISA string in DT wi=
ll
> simply describe _all_ extensions the hardware supports. So there _shou=
ld_
> never be a case of "I want to disable vectors and will remove the lett=
er
> from the ISA string".
>
> For T-Head we _know_ from vendor-id and friends that the core supports
> this special brand of vectors.

C906 supports t-head/0.7.1 vectors as a configuration option.  The C906 =
in
the D1 and BL808 has vectors, the recently announced CV1800B has one C906
with vectors and one without, and I vaguely remember seeing a chip with =
only
a non-vector C906.

C908 (announced, no manual yet) claims V 1.0 support.  Presumably it will
not support 0.7.1.

C910 (exists on evaluation boards) lacks vector support.

C920 (TH1520, SG2042, etc) has 0.7.1 support, at least superficially
compatible with C906-with-vectors.  Hopefully we can share errata.

This probably needs to be handled as an orthogonal "xtheadv" or "v0p7p1"
extension in whatever replaces riscv,isa.

> We're also turning on the t-head equivalent of svpbmt and zicbom with
> probably the same reasoning.

In an ideal world those would be handled as extensions as well - T-Head =
fixed
their vectors with the C908 so they might do standards-compliant Svpbmt =
and
Zicbom in the future.

>> FWIW I am currently working on kernel-side support for the new
>> extension properties that I have posted dt-binding patches for.
>> I'll go post it once Palmer has merged his current set of patches in =
his
>> staging repo into for-next, as I've got a lot of deps on riscv,isa
>> parser changes.
>> I'm really hoping that it provides an easier way to go off probing for
>> vendor specific stuff for DT-based systems, since it will no longer
>> require complex probing, just an of_property_match_string() for each
>> possible cpu and we could very well provide a vendor hook during that
>> process.
>> Clearly though, that stuff is not yet merged as it has not even been
>> posted yet.
>
> And with the comments I received, T-Head vector also is not ready for
> prime-time yet, so we're all good :-)
>
>
> Heiko
>
>
>> Current WIP of that is here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?=
h=3Driscv-extensions-strings-on-palmer
>>=20
>> > +	riscv_vector_supported();
>> > +	riscv_v_vsize =3D 128 / 8 * 32;
>> > +
>> > +	return true;
>> > +}
>> > +
>> >  static u32 thead_errata_probe(unsigned int stage,
>> >  			      unsigned long archid, unsigned long impid)
>> >  {
>> > @@ -80,6 +109,9 @@ static u32 thead_errata_probe(unsigned int stage,
>> >  	if (errata_probe_pmu(stage, archid, impid))
>> >  		cpu_req_errata |=3D BIT(ERRATA_THEAD_PMU);
>> > =20
>> > +	if (errata_probe_vector(stage, archid, impid))
>> > +		cpu_req_errata |=3D BIT(ERRATA_THEAD_VECTOR);
>> > +
>> >  	return cpu_req_errata;
>> >  }
>> > =20
>> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/=
csr.h
>> > index 2d79bca6ffe8..521b3b939e51 100644
>> > --- a/arch/riscv/include/asm/csr.h
>> > +++ b/arch/riscv/include/asm/csr.h
>> > @@ -24,11 +24,25 @@
>> >  #define SR_FS_CLEAN	_AC(0x00004000, UL)
>> >  #define SR_FS_DIRTY	_AC(0x00006000, UL)
>> > =20
>> > -#define SR_VS		_AC(0x00000600, UL) /* Vector Status */
>> > -#define SR_VS_OFF	_AC(0x00000000, UL)
>> > -#define SR_VS_INITIAL	_AC(0x00000200, UL)
>> > -#define SR_VS_CLEAN	_AC(0x00000400, UL)
>> > -#define SR_VS_DIRTY	_AC(0x00000600, UL)
>> > +#define SR_VS_OFF		_AC(0x00000000, UL)
>> > +
>> > +#define SR_VS_1_0		_AC(0x00000600, UL) /* Vector Status */
>> > +#define SR_VS_INITIAL_1_0	_AC(0x00000200, UL)
>> > +#define SR_VS_CLEAN_1_0		_AC(0x00000400, UL)
>> > +#define SR_VS_DIRTY_1_0		_AC(0x00000600, UL)
>> > +
>> > +#define SR_VS_THEAD		_AC(0x01800000, UL) /* Vector Status */
>> > +#define SR_VS_INITIAL_THEAD	_AC(0x00800000, UL)
>> > +#define SR_VS_CLEAN_THEAD	_AC(0x01000000, UL)
>> > +#define SR_VS_DIRTY_THEAD	_AC(0x01800000, UL)
>> > +
>> > +/*
>> > + * Always default to vector-1.0 handling in assembly and let the b=
roken
>> > + * implementations handle their case separately.
>> > + */
>> > +#ifdef __ASSEMBLY__
>> > +#define SR_VS			SR_VS_1_0
>> > +#endif
>> > =20
>> >  #define SR_XS		_AC(0x00018000, UL) /* Extension Status */
>> >  #define SR_XS_OFF	_AC(0x00000000, UL)
>> > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/incl=
ude/asm/errata_list.h
>> > index fb1a810f3d8c..ab21fadbe9c6 100644
>> > --- a/arch/riscv/include/asm/errata_list.h
>> > +++ b/arch/riscv/include/asm/errata_list.h
>> > @@ -21,7 +21,8 @@
>> >  #define	ERRATA_THEAD_PBMT 0
>> >  #define	ERRATA_THEAD_CMO 1
>> >  #define	ERRATA_THEAD_PMU 2
>> > -#define	ERRATA_THEAD_NUMBER 3
>> > +#define	ERRATA_THEAD_VECTOR 3
>> > +#define	ERRATA_THEAD_NUMBER 4
>> >  #endif
>> > =20
>> >  #ifdef __ASSEMBLY__
>> > @@ -154,6 +155,48 @@ asm volatile(ALTERNATIVE(						\
>> >  	: "=3Dr" (__ovl) :						\
>> >  	: "memory")
>> > =20
>> > +#ifdef CONFIG_ERRATA_THEAD_VECTOR
>> > +
>> > +#define THEAD_C9XX_CSR_VXSAT			0x9
>> > +#define THEAD_C9XX_CSR_VXRM			0xa

These CSR numbers haven't changed.  Assuming that we actually need to ha=
ndle
vxsat and vxrm as part of the vector state (if t-head decided to make th=
em
controlled by sstatus.VS despite being in fcsr), why not unconditionally
define CSR_VXSAT and CSR_VXRM in csr.h?

>> > +
>> > +/*
>> > + * Vector 0.7.1 as used for example on T-Head Xuantie cores, uses =
an older
>> > + * encoding for vsetvli (ta, ma vs. d1), so provide an instruction=
 for
>> > + * vsetvli	t4, x0, e8, m8, d1
>> > + */
>> > +#define THEAD_VSETVLI_T4X0E8M8D1	".long	0x00307ed7\n\t"
>> > +
>> > +/*
>> > + * While in theory, the vector-0.7.1 vsb.v and vlb.v result in the=
 same
>> > + * encoding as the standard vse8.v and vle8.v, compilers seem to o=
ptimize
>> > + * the call resulting in a different encoding and then using a val=
ue for
>> > + * the "mop" field that is not part of vector-0.7.1
>> > + * So encode specific variants for vstate_save and _restore.
>> > + */
>> > +#define THEAD_VSB_V_V0T0		".long	0x02028027\n\t"
>> > +#define THEAD_VSB_V_V8T0		".long	0x02028427\n\t"
>> > +#define THEAD_VSB_V_V16T0		".long	0x02028827\n\t"
>> > +#define THEAD_VSB_V_V24T0		".long	0x02028c27\n\t"
>> > +#define THEAD_VLB_V_V0T0		".long	0x012028007\n\t"
>> > +#define THEAD_VLB_V_V8T0		".long	0x012028407\n\t"
>> > +#define THEAD_VLB_V_V16T0		".long	0x012028807\n\t"
>> > +#define THEAD_VLB_V_V24T0		".long	0x012028c07\n\t"

.insn isn't supported by the kernel's minimum binutils version, but it _=
is_
supported by the oldest version of binutils that can assemble rvv 1.0
instructions.  OP_V requires 2.39 so I use a literal 0x57 instead.

very untested, and I leave it to your judgement whether it actually impr=
oves
readability:

#define THEAD_VSETVLI_T4X0E8M8D1  ".insn i 0x57, 7, t4, x0, 3\n\t"
#define THEAD_VSB_V_V0T0		".insn r STORE_FP, 0, 1, x0,  t0, x0\n\t"
#define THEAD_VSB_V_V8T0		".insn r STORE_FP, 0, 1, x8,  t0, x0\n\t"
#define THEAD_VSB_V_V16T0		".insn r STORE_FP, 0, 1, x16, t0, x0\n\t"
#define THEAD_VSB_V_V24T0		".insn r STORE_FP, 0, 1, x24, t0, x0\n\t"
#define THEAD_VSB_V_V0T0		".insn r LOAD_FP,  0, 9, x0,  t0, x0\n\t"
#define THEAD_VSB_V_V8T0		".insn r LOAD_FP,  0, 9, x8,  t0, x0\n\t"
#define THEAD_VSB_V_V16T0		".insn r LOAD_FP,  0, 9, x16, t0, x0\n\t"
#define THEAD_VSB_V_V24T0		".insn r LOAD_FP,  0, 9, x24, t0, x0\n\t"

>> > +
>> > +#define ALT_SR_VS_VECTOR_1_0_SHIFT	9
>> > +#define ALT_SR_VS_THEAD_SHIFT		23
>> > +
>> > +#define ALT_SR_VS(_val, prot)						\
>> > +asm(ALTERNATIVE("li %0, %1\t\nslli %0,%0,%3",				\
>> > +		"li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,		\
>> > +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)	\
>> > +		: "=3Dr"(_val)						\
>> > +		: "I"(prot##_1_0 >> ALT_SR_VS_VECTOR_1_0_SHIFT),	\
>> > +		  "I"(prot##_THEAD >> ALT_SR_VS_THEAD_SHIFT),		\
>> > +		  "I"(ALT_SR_VS_VECTOR_1_0_SHIFT),			\
>> > +		  "I"(ALT_SR_VS_THEAD_SHIFT))

I think this can be simplified by removing the shifts and using the li
pseudoinstruction (which will become lui on the _THEAD_ arm).

>> > +#endif /* CONFIG_ERRATA_THEAD_VECTOR */
>> > +
>> >  #endif /* __ASSEMBLY__ */
>> > =20
>> >  #endif
>> > diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/a=
sm/vector.h
>> > index 315c96d2b4d0..fa47f60f81e3 100644
>> > --- a/arch/riscv/include/asm/vector.h
>> > +++ b/arch/riscv/include/asm/vector.h
>> > @@ -18,6 +18,55 @@
>> >  #include <asm/hwcap.h>
>> >  #include <asm/csr.h>
>> >  #include <asm/asm.h>
>> > +#include <asm/errata_list.h>
>> > +
>> > +#ifdef CONFIG_ERRATA_THEAD_VECTOR
>> > +
>> > +static inline unsigned long riscv_sr_vs(void)
>> > +{
>> > +	u32 val;
>> > +
>> > +	ALT_SR_VS(val, SR_VS);
>> > +	return val;
>> > +}
>> > +
>> > +static inline unsigned long riscv_sr_vs_initial(void)
>> > +{
>> > +	u32 val;
>> > +
>> > +	ALT_SR_VS(val, SR_VS_INITIAL);
>> > +	return val;
>> > +}
>> > +
>> > +static inline unsigned long riscv_sr_vs_clean(void)
>> > +{
>> > +	u32 val;
>> > +
>> > +	ALT_SR_VS(val, SR_VS_CLEAN);
>> > +	return val;
>> > +}
>> > +
>> > +static inline unsigned long riscv_sr_vs_dirty(void)
>> > +{
>> > +	u32 val;
>> > +
>> > +	ALT_SR_VS(val, SR_VS_DIRTY);
>> > +	return val;
>> > +}
>> > +
>> > +#define SR_VS		riscv_sr_vs()
>> > +#define SR_VS_INITIAL	riscv_sr_vs_initial()
>> > +#define SR_VS_CLEAN	riscv_sr_vs_clean()
>> > +#define SR_VS_DIRTY	riscv_sr_vs_dirty()
>> > +
>> > +#else /* CONFIG_ERRATA_THEAD_VECTOR */
>> > +
>> > +#define SR_VS		SR_VS_1_0
>> > +#define SR_VS_INITIAL	SR_VS_INITIAL_1_0
>> > +#define SR_VS_CLEAN	SR_VS_CLEAN_1_0
>> > +#define SR_VS_DIRTY	SR_VS_DIRTY_1_0
>> > +
>> > +#endif /* CONFIG_ERRATA_THEAD_VECTOR */
>> > =20
>> >  extern bool riscv_v_supported;
>> >  void riscv_vector_supported(void);
>> > @@ -63,26 +112,74 @@ static __always_inline void riscv_v_disable(vo=
id)
>> > =20
>> >  static __always_inline void __vstate_csr_save(struct __riscv_v_ext=
_state *dest)
>> >  {
>> > -	asm volatile (
>> > +	register u32 t1 asm("t1") =3D (SR_FS);
>> > +
>> > +	/*
>> > +	 * CSR_VCSR is defined as
>> > +	 * [2:1] - vxrm[1:0]
>> > +	 * [0] - vxsat
>> > +	 * The earlier vector spec implemented by T-Head uses separate
>> > +	 * registers for the same bit-elements, so just combine those
>> > +	 * into the existing output field.
>> > +	 *
>> > +	 * Additionally T-Head cores need FS to be enabled when accessing
>> > +	 * the VXRM and VXSAT CSRs, otherwise ending in illegal instructi=
ons.
>> > +	 * Though the cores do not implement the VXRM and VXSAT fields in=
 the
>> > +	 * FCSR CSR that vector-0.7.1 specifies.

(for completeness only: this was found to be inaccurate in the previous =
thread)

>> > +	 */
>> > +	asm volatile (ALTERNATIVE(
>> >  		"csrr	%0, " __stringify(CSR_VSTART) "\n\t"
>> >  		"csrr	%1, " __stringify(CSR_VTYPE) "\n\t"
>> >  		"csrr	%2, " __stringify(CSR_VL) "\n\t"
>> >  		"csrr	%3, " __stringify(CSR_VCSR) "\n\t"
>> > +		__nops(5),
>> > +		"csrs	sstatus, t1\n\t"
>> > +		"csrr	%0, " __stringify(CSR_VSTART) "\n\t"
>> > +		"csrr	%1, " __stringify(CSR_VTYPE) "\n\t"
>> > +		"csrr	%2, " __stringify(CSR_VL) "\n\t"
>> > +		"csrr	%3, " __stringify(THEAD_C9XX_CSR_VXRM) "\n\t"
>> > +		"slliw	%3, %3, " __stringify(VCSR_VXRM_SHIFT) "\n\t"
>> > +		"csrr	t4, " __stringify(THEAD_C9XX_CSR_VXSAT) "\n\t"
>> > +		"or	%3, %3, t4\n\t"
>> > +		"csrc	sstatus, t1\n\t",
>> > +		THEAD_VENDOR_ID,
>> > +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
>> >  		: "=3Dr" (dest->vstart), "=3Dr" (dest->vtype), "=3Dr" (dest->vl),
>> > -		  "=3Dr" (dest->vcsr) : :);
>> > +		  "=3Dr" (dest->vcsr) : "r"(t1) : "t4");
>> >  }
>> > =20
>> >  static __always_inline void __vstate_csr_restore(struct __riscv_v_=
ext_state *src)
>> >  {
>> > -	asm volatile (
>> > +	register u32 t1 asm("t1") =3D (SR_FS);
>> > +
>> > +	/*
>> > +	 * Similar to __vstate_csr_save above, restore values for the
>> > +	 * separate VXRM and VXSAT CSRs from the vcsr variable.
>> > +	 */
>> > +	asm volatile (ALTERNATIVE(
>> >  		".option push\n\t"
>> >  		".option arch, +v\n\t"
>> >  		"vsetvl	 x0, %2, %1\n\t"
>> >  		".option pop\n\t"
>> >  		"csrw	" __stringify(CSR_VSTART) ", %0\n\t"
>> >  		"csrw	" __stringify(CSR_VCSR) ", %3\n\t"
>> > +		__nops(6),
>> > +		"csrs	sstatus, t1\n\t"
>> > +		".option push\n\t"
>> > +		".option arch, +v\n\t"
>> > +		"vsetvl	 x0, %2, %1\n\t"
>> > +		".option pop\n\t"
>> > +		"csrw	" __stringify(CSR_VSTART) ", %0\n\t"
>> > +		"srliw	t4, %3, " __stringify(VCSR_VXRM_SHIFT) "\n\t"
>> > +		"andi	t4, t4, " __stringify(VCSR_VXRM_MASK) "\n\t"
>> > +		"csrw	" __stringify(THEAD_C9XX_CSR_VXRM) ", t4\n\t"
>> > +		"andi	%3, %3, " __stringify(VCSR_VXSAT_MASK) "\n\t"
>> > +		"csrw	" __stringify(THEAD_C9XX_CSR_VXSAT) ", %3\n\t"
>> > +		"csrc	sstatus, t1\n\t",
>> > +		THEAD_VENDOR_ID,
>> > +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
>> >  		: : "r" (src->vstart), "r" (src->vtype), "r" (src->vl),
>> > -		    "r" (src->vcsr) :);
>> > +		    "r" (src->vcsr), "r"(t1) : "t4");
>> >  }
>> > =20
>> >  static inline void __riscv_v_vstate_save(struct __riscv_v_ext_stat=
e *save_to,
>> > @@ -92,7 +189,8 @@ static inline void __riscv_v_vstate_save(struct =
__riscv_v_ext_state *save_to,
>> > =20
>> >  	riscv_v_enable();
>> >  	__vstate_csr_save(save_to);
>> > -	asm volatile (
>> > +	asm volatile (ALTERNATIVE(
>> > +		"nop\n\t"
>> >  		".option push\n\t"
>> >  		".option arch, +v\n\t"
>> >  		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
>> > @@ -103,8 +201,18 @@ static inline void __riscv_v_vstate_save(struc=
t __riscv_v_ext_state *save_to,
>> >  		"vse8.v		v16, (%1)\n\t"
>> >  		"add		%1, %1, %0\n\t"
>> >  		"vse8.v		v24, (%1)\n\t"
>> > -		".option pop\n\t"
>> > -		: "=3D&r" (vl) : "r" (datap) : "memory");

Pre-existing bug: The assembly code modifies %1, which is an input opera=
nd.
I think this should be

-		: "=3D&r" (vl), "+r" (datap) : : "memory");

>> > +		".option pop\n\t",
>> > +		"mv		t0, %1\n\t"
>> > +		THEAD_VSETVLI_T4X0E8M8D1
>> > +		THEAD_VSB_V_V0T0
>> > +		"addi		t0, t0, 128\n\t"

We don't have a promise from T-Head that they won't introduce a core with
0.7.1 vectors and VLEN=3D256, and I'd rather not have code lying around =
that
will cause silent data corruption if that happens.  THEAD_VSETVLI_T4X0E8=
M8D1
has rd=3Dt4 so adding t4 should work in this arm.

>> > +		THEAD_VSB_V_V8T0
>> > +		"addi		t0, t0, 128\n\t"
>> > +		THEAD_VSB_V_V16T0
>> > +		"addi		t0, t0, 128\n\t"
>> > +		THEAD_VSB_V_V24T0, THEAD_VENDOR_ID,
>> > +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
>> > +		: "=3D&r" (vl) : "r" (datap) : "t0", "t4", "memory");

The bugfix for the existing code isn't needed here since you copied the
address into t0.

>> >  	riscv_v_disable();
>> >  }
>> > =20
>> > @@ -114,7 +222,8 @@ static inline void __riscv_v_vstate_restore(str=
uct __riscv_v_ext_state *restore_
>> >  	unsigned long vl;
>> > =20
>> >  	riscv_v_enable();
>> > -	asm volatile (
>> > +	asm volatile (ALTERNATIVE(
>> > +		"nop\n\t"
>> >  		".option push\n\t"
>> >  		".option arch, +v\n\t"
>> >  		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
>> > @@ -125,8 +234,18 @@ static inline void __riscv_v_vstate_restore(st=
ruct __riscv_v_ext_state *restore_
>> >  		"vle8.v		v16, (%1)\n\t"
>> >  		"add		%1, %1, %0\n\t"
>> >  		"vle8.v		v24, (%1)\n\t"
>> > -		".option pop\n\t"
>> > -		: "=3D&r" (vl) : "r" (datap) : "memory");

-		: "=3D&r" (vl), "+r" (datap) : : "memory");

-s

>> > +		".option pop\n\t",
>> > +		"mv		t0, %1\n\t"
>> > +		THEAD_VSETVLI_T4X0E8M8D1
>> > +		THEAD_VLB_V_V0T0
>> > +		"addi		t0, t0, 128\n\t"
>> > +		THEAD_VLB_V_V8T0
>> > +		"addi		t0, t0, 128\n\t"
>> > +		THEAD_VLB_V_V16T0
>> > +		"addi		t0, t0, 128\n\t"
>> > +		THEAD_VLB_V_V24T0, THEAD_VENDOR_ID,
>> > +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
>> > +		: "=3D&r" (vl) : "r" (datap) : "t0", "t4");
>> >  	__vstate_csr_restore(restore_from);
>> >  	riscv_v_disable();
>> >  }
>> > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
>> > index 74178fb71805..51726890a4d0 100644
>> > --- a/arch/riscv/kernel/vector.c
>> > +++ b/arch/riscv/kernel/vector.c
>> > @@ -140,7 +140,7 @@ bool riscv_v_first_use_handler(struct pt_regs *=
regs)
>> >  	u32 insn =3D (u32)regs->badaddr;
>> > =20
>> >  	/* Do not handle if V is not supported, or disabled */
>> > -	if (!(ELF_HWCAP & COMPAT_HWCAP_ISA_V))
>> > +	if (!has_vector())
>> >  		return false;
>> > =20
>> >  	/* If V has been enabled then it is not the first-use trap */
>>=20
>
>
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
