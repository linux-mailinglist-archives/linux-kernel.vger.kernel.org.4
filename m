Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8B170B6B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjEVHnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjEVHm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:42:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF21AC;
        Mon, 22 May 2023 00:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0A1E61E43;
        Mon, 22 May 2023 07:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAB2C433A8;
        Mon, 22 May 2023 07:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684741375;
        bh=rCgQcjqJskUJoH1uKQYYH1fJfOES/hn5rNtRBTxVkXA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TA5XhWBCWl2w2Ci0GyfAGgGBeIbPW9Xk5g1zSQUjMCmNY43qwIAMNdPUaOV8ZuT2u
         ZSdHq9D5806/SVrZmTjpRavFw7NIjy3+TYxS7w/GcFng4IvwbCaBYfaev352QG9qTq
         E4V1iwgKeNxSqI+BZU/Vzeg81B5ww4o4ciBRi/RErT6L99jdg+mxS8JfBS5PmyMRLU
         C0lTk7xMrvqJ7d9LP80DWaQyTswCD0lTTtV5XzJK5LoD6Ssf5FdJTv+SsUDgrfVPXp
         4gzgDUkcUM+a5iwPVKfsoJndMdhmsu68k1auKkvPZDtldRR97xkbxbY+rqpIkshe/P
         KjeCnmeA66W3g==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-510eb980ce2so6341563a12.2;
        Mon, 22 May 2023 00:42:55 -0700 (PDT)
X-Gm-Message-State: AC+VfDyNjspyQHRWUfiFFs8fFqFh7FlalzuPMKKcVL4ig9gR0CPdgnWp
        gJeBwXi7B/3ktoDevNdjwzUFTFjiaSoxR30NTAU=
X-Google-Smtp-Source: ACHHUZ5jPj0LgwefSc5JxBbskt/wdM9CeQLMEMD2PvsVcAyiNqABotsoo7fcOo561QQdx4vu7qii2PeFQ6q2n8njLs8=
X-Received: by 2002:a17:906:9743:b0:96a:bdb0:5744 with SMTP id
 o3-20020a170906974300b0096abdb05744mr11079139ejy.26.1684741373253; Mon, 22
 May 2023 00:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230518184541.2627-1-jszhang@kernel.org> <20230518184541.2627-5-jszhang@kernel.org>
 <20230518-driving-secluding-793b3192776e@spud> <CAJF2gTTGgLJ3SNcmhRGpAAw7jhOfYA5j=G9ZibwA8wUmeQN3UQ@mail.gmail.com>
 <20230522-motto-seducing-f0fa34f31c18@wendy>
In-Reply-To: <20230522-motto-seducing-f0fa34f31c18@wendy>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 22 May 2023 15:42:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRG5edPnVmhMtv67OANpOynL0br0wcrQCave88_KkyZcg@mail.gmail.com>
Message-ID: <CAJF2gTRG5edPnVmhMtv67OANpOynL0br0wcrQCave88_KkyZcg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] dt-binding: riscv: add T-HEAD CPU reset
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 3:09=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey,
>
> On Mon, May 22, 2023 at 10:16:19AM +0800, Guo Ren wrote:
> > On Fri, May 19, 2023 at 3:53=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > > On Fri, May 19, 2023 at 02:45:36AM +0800, Jisheng Zhang wrote:
> > > > The secondary CPUs in T-HEAD SMP capable platforms need some specia=
l
> > > > handling. The first one is to write the warm reset entry to entry
> > > > register. The second one is write a SoC specific control value to
> > > > a SoC specific control reg. The last one is to clone some CSRs for
> > > > secondary CPUs to ensure these CSRs' values are the same as the
> > > > main boot CPU. This DT node is mainly used by opensbi firmware.
> > > >
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > ---
> > > >  .../bindings/riscv/thead,cpu-reset.yaml       | 69 +++++++++++++++=
++++
> > > >  1 file changed, 69 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/riscv/thead,c=
pu-reset.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/riscv/thead,cpu-rese=
t.yaml b/Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml
> > > > new file mode 100644
> > > > index 000000000000..ba8c87583b6b
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml
> > > > @@ -0,0 +1,69 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/riscv/thead,cpu-reset.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: T-HEAD cpu reset controller
> > > > +
> > > > +maintainers:
> > > > +  - Jisheng Zhang <jszhang@kernel.org>
> > > > +
> > > > +description: |
> > > > +  The secondary CPUs in T-HEAD SMP capable platforms need some spe=
cial
> > > > +  handling. The first one is to write the warm reset entry to entr=
y
> > > > +  register. The second one is write a SoC specific control value t=
o
> > > > +  a SoC specific control reg. The last one is to clone some CSRs f=
or
> > > > +  secondary CPUs to ensure these CSRs' values are the same as the
> > > > +  main boot CPU.
>
> > > > +
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - description: CPU reset on T-HEAD TH1520 SoC
> > > > +        items:
> > > > +          - const: thead,reset-th1520
> > >
> > > You've only got one thing here, you don't need the oneOf.
> > > Also, s/reset-th1520/th1520-reset/ please - although I do not know if
> > > "reset" is the right word here. Do we know what the IP block is calle=
d
> > > in the TRM/T-Head docs? Perhaps Guo Ren does if not.
> > It's called CPU reset controller; every core has reset_ctrl &
> > reset_entry signals; Soc just gathers them into some regs.
> > For th1520, we have 4 reset_entries registers and 1 reset_ctrl
> > register. Fu Wei would give out more details about it.
>
> Okay, thanks. Sounds like this SoC will have multiple reset controllers
> then, since there is likely one for the peripherals too?
> thead,th1520-cpu-reset seems like a good idea to me?
>
> > > > +  entry-reg:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint64
> > > > +    description: |
> > > > +      The entry reg address.
> > > > +
> > > > +  entry-cn
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: |
> > > > +      The entry reg count.
> > > > +
> > > > +  control-reg:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > It should be uint64.
> >
> > > > +    description: |
> > > > +      The control reg address.
> > > > +
> > > > +  control-val:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: |
> > > > +      The value to be set into the control reg.
> > > > +
> > > > +  csr-copy:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +    description: |
> > > > +      The CSR registers to be cloned during CPU warm reset.
> > >
> > > All of these values set on a per-soc basis, right?
> > Yes
> > > If so, I don't think they should be in here at all since you should b=
e
> > > able to figure out the offsets from the base & the values to write ba=
sed
> > > on the compatible string alone, no?
> > The driver works with all T-HEAD CPUs, not only for th1520. Some
> > vendors may have their own custom CSRs, so the csr-copy feature is
> > flexible enough to adjust in dts. As far as I can tell, hardware teams
> > typically prefer to focus on the firmware binary rather than setting
> > up the software compiling environment.
>
> In this case "firmware" means opensbi, since that's where Jisheng
> mentioned in their cover that they intended using this.
Yes, firmware -> opensbi. The hardware guys just modify dtb without
recompiling the opensbi.

>
> > > Putting register values into the DT is always "suspect"!
> > It's not register values, it's register offset/ CSR number.
>
> So "control-val" is not a value? "The value to be set into the control
> reg" makes it sound oddly like one!!
>
> My point I guess is that this entry could be written like
>
> reset-controller@ffff019050 {
>   compatible =3D "thead,th1520-cpu-reset";
>   reg =3D <0xff 0xff019050 0xfoo 0xbar>, <0xff 0xff015004 0xfoo 0xbar>;
> };
>
> or even:
>
> reset-controller@ffff019050 {
>   compatible =3D "thead,th1520-cpu-reset";
>   reg =3D <0xff 0xff019050 0xfoo 0xbar>, <0xff 0xff015004 0xfoo 0xbar>;
>   reg-names =3D "entry", "control";
> };
Better naming, I agree with you at this point.
But, we have to make changes to the current opensbi implementation to
match your advice.

>
> And csr-copy, entry-cn and control-val can be derived from the
> compatible string given you've said they are set on a per-soc basis.
>
> > > > +required:
> > > > +  - compatible
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    cpurst: cpurst@ffff019050 {
> > >                ^^^^^^^^^^^^^^^^^
> > > This is also "suspect" and implies that "entry reg" should just be a
> > > normal "reg" property.
> > Yes, but we needn't reg, here. It should be:
> >
> > cpurst {
>
> I don't think it should! Firstly, "cpurst" is not a generic node name,
Yes, reset-controller is better.

> but I also don't agree that "control-reg" and "entry-reg" should not
> just be 2 reg entries.
Yes, Yes. You've said.

>
> Cheers,
> Conor.



--=20
Best Regards
 Guo Ren
