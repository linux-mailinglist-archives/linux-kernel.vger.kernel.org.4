Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEEF5F849D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 11:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJHJdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJHJds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 05:33:48 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25B51030
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 02:33:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D1925C012B;
        Sat,  8 Oct 2022 05:33:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 08 Oct 2022 05:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665221622; x=
        1665308022; bh=hUl3Ir3x++r50yiN713hcR9ZO+kB6wQMi6hsc1U36Xw=; b=I
        Y+NE0MjMY5RcIhUaqp10J3RXs6gSuRYVdubxg1QJMtgL184jmzWLIHP6VaLR3QKp
        4PxjbEufYCNR0KoROW3Bcxoc50U/tBQWXy75ovzanv7HQfChOG6usxFaw4m6Ly7Y
        b3jVUWa/58tD5bq4vYdtSYHNjMq2A8ziqZOjkC01kZxrDqXvN/X4x+UcqXBlQw9Y
        MFwD3PUnGWsXSgG4P75rOmnJIwjBJ2bTbmh9AD3Y790ZNG9U9O4h/2wVAUV7XylK
        AafbDT/BhOvSUJzoOuFFbpTmH312zJn1BtMKcQ0JbJIgJYnoEQ0IOJLg+nGPUgEb
        2ZaKS+51V5JMizjlg/RBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665221622; x=
        1665308022; bh=hUl3Ir3x++r50yiN713hcR9ZO+kB6wQMi6hsc1U36Xw=; b=B
        dSZtnw6OFgUrfSNdGQISvvbmSRnB7uftiA4kAdwSmIePnF9Rvz32cf1M8q7D5N8V
        xzxmNs/ctcjpfsmwCLCsP3FsTruiahMQpergqS9I/1dhUKwCjbST6GiViuKLAWFh
        bvlqpsZ8KnihJyalIWNo33UwoDsxHPTKbkojljyJMYCUfN6zvt7qvlA3wGhsy8ap
        2lAkuEpe4n1mAfNudwhGWcckKKCvWL13LCNbCDUoC5xVulvD7RnkRlEe9tdHMVoX
        BmGEn9XuSB5+Ms67gsnp0tFmkM9Rf2gi+fss5L0A2VNJrIlfeZc+ukuvhDnMfnYb
        2gzjfIRxT5sOGekb7v+DA==
X-ME-Sender: <xms:9UNBY9ilDxiznHExg5qeWuZ-QNdYgd7cIlTb2TKP2kkFFw1Z5Beqgg>
    <xme:9UNBYyDJv8hZ4Fe4STLCg4KZbLqVTePZY7x4RyYOGJHmbT3_5P3GKhx2__y4U5MAR
    WqNceqMChL6wDm-UYY>
X-ME-Received: <xmr:9UNBY9G6O-nB8FAieWkZEVlSg8SRpDChhfFOeS6uqy4BpOiw24PbSl0PKBeUrlnv5VhZmseIZNrrDSXGA-WNuOo2yxeiqzCdqfT7C2ni_hz8FWiQI1ooX3Fwcpactg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptgfghfggufffkfhfvegjvffosehtqhhmtdhhtdejnecuhfhrohhmpefuvhgv
    nhcurfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepvdfhtdduuddvueejueffgfdukedvfeevgfeuieeivdeltdehgeeivefftdet
    kedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:9UNBYyS91bOQ8-WzY82Xpzcy9wPTVLM1dSdE9fomvARGsltDCKqLDA>
    <xmx:9UNBY6ykY2uJWifrqg_j2i3PANr2qZs_6XS8lW08sVrZqoH1XoN2Eg>
    <xmx:9UNBY45B1rZTvDOHytUemGGjbV3hSAfPBh4VCnfkYVwfPhbIU-EbKw>
    <xmx:9kNBY87T10vjR26vuQvZlU9DekNUhKU8916Vi17Ffqb5sM7G4nWMZw>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Oct 2022 05:33:41 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Sven Peter <sven@svenpeter.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
Date:   Sat, 8 Oct 2022 11:33:27 +0200
Message-Id: <65B38F6C-4E97-49CE-84F6-22CC9929B14B@svenpeter.dev>
References: <20221007200022.22844-3-konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221007200022.22844-3-konrad.dybcio@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: iPhone Mail (20A362)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> On 7. Oct 2022, at 22:00, Konrad Dybcio <konrad.dybcio@somainline.org> wro=
te:
>=20
> =EF=BB=BFAdd support for A7-A11 SoCs by if-ing out some features only pres=
ent
> on A11 & newer (implementation-defined IPI & UNCORE registers).
>=20
> Also, annotate IPI regs support in the aic struct so that the driver
> can tell whether the SoC supports these, as they are written to,
> even if fast IPI is disabled.

No.

> This in turn causes a crash on older
> platforms, as the implemention-defined registers either do
> something else or are not supposed to be touched - definitely not a
> NOP though.

This entire description needs to be rewritten. All you want to do is guard b=
oth fastipi and uncore reg access on pre-A11.

>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v3:
> - Replace use_fast_ipi with has_uncore_ipi_regs in aic_init_cpu
> (logic error, this was written to regardless of FIPI usage before,
> but touching Sn_... regs on SoCs that don't explicitly use them for
> IPIs makes them sepuku..)
> - Drop A11 compatible
>=20
> drivers/irqchip/irq-apple-aic.c | 47 ++++++++++++++++++++++-----------
> 1 file changed, 32 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-a=
ic.c
> index 1c2813ad8bbe..2609d6b60487 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -230,6 +230,9 @@
>=20
> static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
>=20
> +/* True if UNCORE/UNCORE2 and Sn_... IPI registers are present (A11+) */
> +static DEFINE_STATIC_KEY_TRUE(has_uncore_ipi_regs);
> +
> struct aic_info {
>    int version;
>=20
> @@ -246,6 +249,7 @@ struct aic_info {
>=20
>    /* Features */
>    bool fast_ipi;
> +    bool uncore_ipi_regs;

Why two flags? Didn=E2=80=99t we come to the conclusion last time that fasti=
pi and uncore were introduced at the same time? Below you also either have b=
oth true or both false so there=E2=80=99s really no need to track both of th=
em.


> };
>=20
> static const struct aic_info aic1_info =3D {
> @@ -261,6 +265,7 @@ static const struct aic_info aic1_fipi_info =3D {
>    .event        =3D AIC_EVENT,
>    .target_cpu    =3D AIC_TARGET_CPU,
>=20
> +    .uncore_ipi_regs    =3D true,
>    .fast_ipi    =3D true,
> };
>=20
> @@ -269,6 +274,7 @@ static const struct aic_info aic2_info =3D {
>=20
>    .irq_cfg    =3D AIC2_IRQ_CFG,
>=20
> +    .uncore_ipi_regs    =3D true,
>    .fast_ipi    =3D true,
> };
>=20
> @@ -524,12 +530,14 @@ static void __exception_irq_entry aic_handle_fiq(str=
uct pt_regs *regs)
>     * we check for everything here, even things we don't support yet.
>     */
>=20
> -    if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
> -        if (static_branch_likely(&use_fast_ipi)) {
> -            aic_handle_ipi(regs);
> -        } else {
> -            pr_err_ratelimited("Fast IPI fired. Acking.\n");
> -            write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> +    if (static_branch_likely(&has_uncore_ipi_regs)) {
> +        if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
> +            if (static_branch_likely(&use_fast_ipi)) {
> +                aic_handle_ipi(regs);
> +            } else {
> +                pr_err_ratelimited("Fast IPI fired. Acking.\n");
> +                write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);

This still can=E2=80=99t be reached because both static branches will always=
 have the same value. Didn=E2=80=99t we also realize a version or two ago th=
at this can just be dropped?

> +            }
>        }
>    }
>=20
> @@ -566,12 +574,14 @@ static void __exception_irq_entry aic_handle_fiq(str=
uct pt_regs *regs)
>                      AIC_FIQ_HWIRQ(irq));
>    }
>=20
> -    if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) =3D=
=3D UPMCR0_IMODE_FIQ &&
> -            (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
> -        /* Same story with uncore PMCs */
> -        pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
> -        sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> -                   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> +    if (static_branch_likely(&has_uncore_ipi_regs)) {
> +        if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)=
) =3D=3D
> +            UPMCR0_IMODE_FIQ && (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & U=
PMSR_IACT)) {
> +            /* Same story with uncore PMCs */
> +            pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
> +            sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> +                    FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> +        }
>    }
> }
>=20
> @@ -944,7 +954,8 @@ static int aic_init_cpu(unsigned int cpu)
>    /* Mask all hard-wired per-CPU IRQ/FIQ sources */
>=20
>    /* Pending Fast IPI FIQs */
> -    write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> +    if (static_branch_likely(&has_uncore_ipi_regs))
> +        write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>=20
>    /* Timer FIQs */
>    sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
> @@ -965,8 +976,9 @@ static int aic_init_cpu(unsigned int cpu)
>               FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
>=20
>    /* Uncore PMC FIQ */
> -    sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> -               FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> +    if (static_branch_likely(&has_uncore_ipi_regs))
> +        sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> +                   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
>=20
>    /* Commit all of the above */
>    isb();
> @@ -1125,6 +1137,11 @@ static int __init aic_of_ic_init(struct device_node=
 *node, struct device_node *p
>    else
>        static_branch_disable(&use_fast_ipi);
>=20
> +    if (irqc->info.uncore_ipi_regs)
> +        static_branch_enable(&has_uncore_ipi_regs);
> +    else
> +        static_branch_disable(&has_uncore_ipi_regs);
> +
>    irqc->info.die_stride =3D off - start_off;
>=20
>    irqc->hw_domain =3D irq_domain_create_tree(of_node_to_fwnode(node),
> --=20
> 2.37.3


Sven

