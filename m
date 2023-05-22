Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040A970B317
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 04:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjEVCQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 22:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjEVCQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 22:16:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE1FB7;
        Sun, 21 May 2023 19:16:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC7EF61946;
        Mon, 22 May 2023 02:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1892BC4339C;
        Mon, 22 May 2023 02:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684721794;
        bh=n2uaZ9rV4gw+Dcgfo0DSk4CEyQozD7dCVzjmhdw+dyA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=McmCYlHhVDzHL5kc9dRRAsAuH8eHQrfIKjNgAFmIHR8b+WsIXqluaqokvmVoA6Urs
         JVtb2sic/Hw0Eoyx77hO8ZWA6mkz6GAttMvZ98b8AWpbUad4BoBgxnM4pkk5lk8FNF
         zPoL0UVJsRcBYHvytdIxHWfxHaYqgB9x7IzKEd2mvQ3AAeKsx3NnqZVKB1gIDU9WP6
         mddSrh6Fne00SjCxscAZAwtQGkq+TyqXBvAPl3OL32VhytWhp9CrsXxSqew0hGb6n6
         74I4xgNt88bx9RdzIcBgN3yf1C4IDDsNXa0Q8Lo9x4V2b0kj02T8fAm4LREMZurWhv
         8d6GoeQYA7Gcw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-510eb980ce2so6007775a12.2;
        Sun, 21 May 2023 19:16:33 -0700 (PDT)
X-Gm-Message-State: AC+VfDwZwAtvnFsYF4fta7MI4yQEoTT8JxbaiogcapTKS1lWU7sixyD6
        yb8IIwpe3vfXTcxk5s9TH8h7ruGpwl2jYbJd4nI=
X-Google-Smtp-Source: ACHHUZ5xwayM/aFmbQ7NrqIngfedoekz46hxMtF2WEz5MLCZ/hk7/GMyHcg22kmLw3lIgY9iSEEtMBhb3acllwZ12M4=
X-Received: by 2002:aa7:c6c8:0:b0:50b:c397:bbac with SMTP id
 b8-20020aa7c6c8000000b0050bc397bbacmr7184287eds.29.1684721792303; Sun, 21 May
 2023 19:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230518184541.2627-1-jszhang@kernel.org> <20230518184541.2627-5-jszhang@kernel.org>
 <20230518-driving-secluding-793b3192776e@spud>
In-Reply-To: <20230518-driving-secluding-793b3192776e@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 22 May 2023 10:16:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTGgLJ3SNcmhRGpAAw7jhOfYA5j=G9ZibwA8wUmeQN3UQ@mail.gmail.com>
Message-ID: <CAJF2gTTGgLJ3SNcmhRGpAAw7jhOfYA5j=G9ZibwA8wUmeQN3UQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] dt-binding: riscv: add T-HEAD CPU reset
To:     Conor Dooley <conor@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
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

On Fri, May 19, 2023 at 3:53=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> Hey Jisheng,
>
> On Fri, May 19, 2023 at 02:45:36AM +0800, Jisheng Zhang wrote:
> > The secondary CPUs in T-HEAD SMP capable platforms need some special
> > handling. The first one is to write the warm reset entry to entry
> > register. The second one is write a SoC specific control value to
> > a SoC specific control reg. The last one is to clone some CSRs for
> > secondary CPUs to ensure these CSRs' values are the same as the
> > main boot CPU. This DT node is mainly used by opensbi firmware.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  .../bindings/riscv/thead,cpu-reset.yaml       | 69 +++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/thead,cpu-r=
eset.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/thead,cpu-reset.ya=
ml b/Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml
> > new file mode 100644
> > index 000000000000..ba8c87583b6b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/thead,cpu-reset.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: T-HEAD cpu reset controller
> > +
> > +maintainers:
> > +  - Jisheng Zhang <jszhang@kernel.org>
> > +
> > +description: |
> > +  The secondary CPUs in T-HEAD SMP capable platforms need some special
> > +  handling. The first one is to write the warm reset entry to entry
> > +  register. The second one is write a SoC specific control value to
> > +  a SoC specific control reg. The last one is to clone some CSRs for
> > +  secondary CPUs to ensure these CSRs' values are the same as the
> > +  main boot CPU.
>
> Okay..
>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^cpurst"
>
> Firstly, why the nodename enforcement? We have a compatible, so we
> should be okay, no?
Yes, it needn't.

>
> > +
> > +  compatible:
> > +    oneOf:
> > +      - description: CPU reset on T-HEAD TH1520 SoC
> > +        items:
> > +          - const: thead,reset-th1520
>
> You've only got one thing here, you don't need the oneOf.
> Also, s/reset-th1520/th1520-reset/ please - although I do not know if
> "reset" is the right word here. Do we know what the IP block is called
> in the TRM/T-Head docs? Perhaps Guo Ren does if not.
It's called CPU reset controller; every core has reset_ctrl &
reset_entry signals; Soc just gathers them into some regs.
For th1520, we have 4 reset_entries registers and 1 reset_ctrl
register. Fu Wei would give out more details about it.

>
> > +  entry-reg:
> > +    $ref: /schemas/types.yaml#/definitions/uint64
> > +    description: |
> > +      The entry reg address.
> > +
> > +  entry-cn
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      The entry reg count.
> > +
> > +  control-reg:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
It should be uint64.

> > +    description: |
> > +      The control reg address.
> > +
> > +  control-val:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      The value to be set into the control reg.
> > +
> > +  csr-copy:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: |
> > +      The CSR registers to be cloned during CPU warm reset.
>
> All of these values set on a per-soc basis, right?
Yes
> If so, I don't think they should be in here at all since you should be
> able to figure out the offsets from the base & the values to write based
> on the compatible string alone, no?
The driver works with all T-HEAD CPUs, not only for th1520. Some
vendors may have their own custom CSRs, so the csr-copy feature is
flexible enough to adjust in dts. As far as I can tell, hardware teams
typically prefer to focus on the firmware binary rather than setting
up the software compiling environment.

>
> Putting register values into the DT is always "suspect"!
It's not register values, it's register offset/ CSR number.

>
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    cpurst: cpurst@ffff019050 {
>                ^^^^^^^^^^^^^^^^^
> This is also "suspect" and implies that "entry reg" should just be a
> normal "reg" property.
Yes, but we needn't reg, here. It should be:

cpurst {

Thx for debugging.

>
>
> > +      compatible =3D "thead,reset-th1520";
> > +      entry-reg =3D <0xff 0xff019050>;
> > +      entry-cnt =3D <4>;
> > +      control-reg =3D <0xff 0xff015004>;
> > +      control-val =3D <0x1c>;
> > +      csr-copy =3D <0x7f3 0x7c0 0x7c1 0x7c2 0x7c3 0x7c5 0x7cc>;
> > +    };
> > --
> > 2.40.0
> >



--=20
Best Regards
 Guo Ren
