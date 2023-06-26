Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F21F73D64A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjFZD0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFZD0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:26:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D131137
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 20:26:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f954d7309fso3403432e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 20:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687749972; x=1690341972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d27TruML66ln41kwNbriVUdepzW6hpF0owzY5DYOBTc=;
        b=nixJQJW/JM6ZhF95VwmPO9q32GpVx4+kO1Jmhh/m7AxWBjPVzuurbPplCHiZUph8mw
         VnRHpeZ3gcLpVRVkfDX06lKeR4XaNhXausla1rXJrdpuGiKqBJfGxv76yyPKOJoEsJyS
         I5OwAaHw+Mq0hOSCYi9hLEEnAyhv7xVwJi0N9wxmDMYvmcoQqRMpLl2Y1JG66sJSMy+q
         T3S4xp4Z+gicg7GlFaO4KbttvqvArCRV8Euj44ijnI7DbobMrWJ/Chn5iX238i19mFAV
         FtmcPTBarugpL9drzBlyxjoj3bpyCgnVGBm0yH/dS5Z0QJ4LKgk+1IZ/oLJSz6E7FYVO
         V2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687749972; x=1690341972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d27TruML66ln41kwNbriVUdepzW6hpF0owzY5DYOBTc=;
        b=jDkmIsx8QYkcNRWNVCR0B4rLiTjsOobVlOp2v5qnO8cOqBVIbjLx7aMFJ2r0da1wX1
         b+z5IhSigTtkrAKAIoX3TMm9ZV6Ekw7pkPcG8Wb9F5ehpvWzKzg3t+VeFpwb0IjhDGHw
         l6VMSSecXPz5BSiqCuDEKYrmkj17HVW8kagNlxPkcF08L6wIxcIkixwW7DCNw7w4hifD
         MVqzyhOav3DGZx3o9+CtvZCACjvDtzbg6IUWr/f13Fp4wR8hvRVWPDvvNJkPpRIqwmK7
         2Ie2GYqhgtIZOph6/4wQOEpb0ft5rmURZ3SfJNIfUZmxLd6eYe0Ztm9/2kC5WxxmS+lu
         79mQ==
X-Gm-Message-State: AC+VfDySb2c9pRxLprjlko0ljdp8ZsxsXv6Yz/MXvRz+ZYaR0j1SvYjk
        vVtwxwtEYfOULh4MGRUC3kpS6LjCwQzFxQiDQVR73A==
X-Google-Smtp-Source: ACHHUZ5VXGFfIfcr1N1JRpfM8xoJIYXrZpWVXnEnMRRfEDsgxdragBOW5kVhTdzGVenAUlCT+DBser0m2zTw3Zexh0g=
X-Received: by 2002:a05:6512:3f18:b0:4eb:46c2:e771 with SMTP id
 y24-20020a0565123f1800b004eb46c2e771mr9802992lfa.14.1687749972447; Sun, 25
 Jun 2023 20:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230616063210.19063-1-eric.lin@sifive.com> <20230616063210.19063-4-eric.lin@sifive.com>
 <2437bda9-bbdb-ad80-7201-1e16e1388890@linaro.org>
In-Reply-To: <2437bda9-bbdb-ad80-7201-1e16e1388890@linaro.org>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Mon, 26 Jun 2023 11:26:00 +0800
Message-ID: <CAPqJEFoTsmVZ4kvsSB0RkQZaQGyXC96KV6RvdpeC5XxURCOZ0w@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Jun 16, 2023 at 6:45=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/06/2023 08:32, Eric Lin wrote:
> > This add YAML DT binding documentation for SiFive Private L2
> > cache controller
> >
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Reviewed-by: Nick Hu <nick.hu@sifive.com>
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
> > +
> > +description:
> > +  The SiFive Private L2 Cache Controller is per hart and communicates =
with both the upstream
> > +  L1 caches and downstream L3 cache or memory, enabling a high-perform=
ance cache subsystem.
> > +  All the properties in ePAPR/DeviceTree specification applies for thi=
s platform.
>
> Drop the last sentence. Why specification would not apply?
>
OK, I'll drop it in v2.

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
> > +          - sifive,pL2Cache
> > +
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> > +    items:
>
>
> You have only one item, so no need for items... unless you just missed
> proper fallback.

OK, I'll fix it in v2.

>
> > +      - enum:
> > +          - sifive,pL2Cache0
> > +          - sifive,pL2Cache1
>
> What is "0" and "1" here? What do these compatibles represent? Why they
> do not have any SoC related part?

The pL2Cache1 has minor changes in hardware, but it can use the same
pl2 cache driver.
May I ask, what do you mean about the SoC-related part? Thanks.

>
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
>
> Are you sure? So all private L2 cache controllers will have fixed size
> of cache?

The private L2 cache controllers will have different sizes.
OK, I'll fix in v2.

>
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
>
> required: goes before additionalProperties:.
>
OK, I'll fix it in v2.
Thanks for the review.

Best Regards,
Eric Lin.
>
> Best regards,
> Krzysztof
>
