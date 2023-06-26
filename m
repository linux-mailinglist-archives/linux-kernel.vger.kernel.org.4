Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4865073D61C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjFZDGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjFZDGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:06:51 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CBCE6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 20:06:50 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b44eddb52dso39996751fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 20:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687748808; x=1690340808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nD4rzl7wHSnevOLG2NiHgv978jXc76hQfIAH8/FPQhU=;
        b=btDaLufx7cp58A8p/Se0hLvmXRbldFAC3h0fs5y5ViaFsEm9zl2vEQUednCysWwZGo
         SqhBvfEO/YXxxy8knMOuaClpSZt5QwxtGoHOZ8OSiED+u1ubIbZnl8e5EpgYWfMP7/Ig
         8lyd6/nVSYly7K4eQyhBkYJ9cv85ahUznwbbhvr6fzrCgTDv+bQaW3jnRVQg4EOVfg3t
         F354rBk3bieDTMvToztoTN6/2Tajc8GnzD9pKzFIyATvbfEAe4wokzIVZUakERZratg1
         WXkReZMUyw+IGknhNu6NO2FamPSiKqspIERa0WDsCeIqIsC+jMFTRlCRwjYrOKxrM2nt
         weYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687748808; x=1690340808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nD4rzl7wHSnevOLG2NiHgv978jXc76hQfIAH8/FPQhU=;
        b=andL7Vevgl2IiYQrpudRRa14gQpA9in6eFlO+x0PQ4XQtHs3//7LO01fG4iBfIONPR
         TzT/O4iqQEP3EnC/OzVrSRlDvsPVMptbDn/MiW8dWbaRfemUiRi1M4WxdgEth1ukEy/F
         nmQ8Gv2gl4dUNxWoH+PTqpwG5PhKdnBGFyR5Q8Gq4lGX7XybcqyXS4ZKXv1SJ4mh8/0g
         WSGKD9pWjxAd3I/UJmNahbOOPcv3HpJn2vXGXBdxsJOaAvXo5iQHN0XIBVoqgY+h9etC
         nCNIRkDm1tmxFaJcSfliWwTsZscHxOSDNHV1dD65W6kx3PTW63TqsrYwQ97lt9Mvdkpb
         WPNA==
X-Gm-Message-State: AC+VfDw8KWMLj9NOzge5xF8AY1IiM5qoC6dIiyvtm/MtIFqa3gAPp3im
        2wTGrFMB3AgC5OnY1hUBYZCgaJRkD9zWt1pdMiVCng==
X-Google-Smtp-Source: ACHHUZ5SJIsRasQJlGe1qGG6AGfTPj5v1Fyn2OBo8PDT4ECRnP81aOb/XVz50aecRQdy9Ytkj2s7lCyEZM8af7lVZaU=
X-Received: by 2002:a2e:8805:0:b0:2b6:a23d:57c8 with SMTP id
 x5-20020a2e8805000000b002b6a23d57c8mr416874ljh.14.1687748808365; Sun, 25 Jun
 2023 20:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230616063210.19063-1-eric.lin@sifive.com> <20230616063210.19063-4-eric.lin@sifive.com>
 <20230616-renovate-country-12b9873b4494@wendy>
In-Reply-To: <20230616-renovate-country-12b9873b4494@wendy>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Mon, 26 Jun 2023 11:06:36 +0800
Message-ID: <CAPqJEFrK8JPLjVEzLqr77kEx+KfYSQ_Fqh2hGXaA+BSL6pWwQw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, maz@kernel.org,
        chenhuacai@kernel.org, baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, jgross@suse.com, chao.gao@intel.com,
        maobibo@loongson.cn, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dslin1010@gmail.com, Zong Li <zong.li@sifive.com>,
        Nick Hu <nick.hu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Fri, Jun 16, 2023 at 6:12=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey Eric,
>
> On Fri, Jun 16, 2023 at 02:32:10PM +0800, Eric Lin wrote:
> > This add YAML DT binding documentation for SiFive Private L2
> > cache controller
> >
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Reviewed-by: Nick Hu <nick.hu@sifive.com>
>
> Firstly, bindings need to come before the driver using them.
>

OK, I'll fix it in v2.

> > ---
> >  .../bindings/riscv/sifive,pL2Cache0.yaml      | 81 +++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/sifive,pL2C=
ache0.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.y=
aml b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
> > new file mode 100644
> > index 000000000000..b5d8d4a39dde
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
>
> Cache bindings have moved to devicetree/bindings/cache.
>
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2023 SiFive, Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/sifive,pL2Cache0.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SiFive Private L2 Cache Controller
> > +
> > +maintainers:
> > +  - Greentime Hu  <greentime.hu@sifive.com>
> > +  - Eric Lin      <eric.lin@sifive.com>
>
> Drop the alignment here please.
>

OK, I'll fix it in v2.

> > +
> > +description:
> > +  The SiFive Private L2 Cache Controller is per hart and communicates =
with both the upstream
> > +  L1 caches and downstream L3 cache or memory, enabling a high-perform=
ance cache subsystem.
> > +  All the properties in ePAPR/DeviceTree specification applies for thi=
s platform.
>
> Please wrap before 80 characters.
>

OK, I'll fix it in v2.

> > +
> > +allOf:
> > +  - $ref: /schemas/cache-controller.yaml#
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - sifive,pL2Cache0
> > +          - sifive,pL2Cache1
>
> Why is this select: required?
>
OK, I'll fix it in v2.

> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - sifive,pL2Cache0
> > +          - sifive,pL2Cache1
>
> What is the difference between these? (and drop the caps please)

The pL2Cache1 has minor changes in hardware, but it can use the same
pl2 cache driver.
OK, I'll drop the caps in v2.

>
> Should this also not fall back to "cache"?
>
Yes,  I'll fix it in v2.

> > +
> > +  cache-block-size:
> > +    const: 64
> > +
> > +  cache-level:
> > +    const: 2
> > +
> > +  cache-sets:
> > +    const: 512
> > +
> > +  cache-size:
> > +    const: 262144
> > +
> > +  cache-unified: true
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  next-level-cache: true
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - cache-block-size
> > +  - cache-level
> > +  - cache-sets
> > +  - cache-size
> > +  - cache-unified
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    pl2@10104000 {
>
> cache-controller@
>

OK, I'll fix it in v2.
Thanks for the review.

Best Regards,
Eric Lin.

> Cheers,
> Conor.
>
> > +        compatible =3D "sifive,pL2Cache0";
> > +        cache-block-size =3D <64>;
> > +        cache-level =3D <2>;
> > +        cache-sets =3D <512>;
> > +        cache-size =3D <262144>;
> > +        cache-unified;
> > +        reg =3D <0x10104000 0x4000>;
> > +        next-level-cache =3D <&L4>;
> > +    };
> > --
> > 2.40.1
> >
