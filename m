Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991AA6E53FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjDQVkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjDQVkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:40:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71484EDE;
        Mon, 17 Apr 2023 14:39:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v21-20020a17090a459500b0024776162815so6609408pjg.2;
        Mon, 17 Apr 2023 14:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681767599; x=1684359599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/g58k9yYsP2ysFNVf9CiMtu4KEAj9Kt/TUR/AOahR8=;
        b=YciCyIEEF/6axZK4cPeVMdw01IWCU/9I+ISpvIsJ+vhgLMvf1I9XnE50TkAEiLk6D6
         YvBCCVdKnIb44uT9DDn65+UjpKRS5Dg/oLUUXUtgeUfIL3up1qHSYTdt6F4435ke5JQW
         JTYE5xgDa4NDtDqXc6y2Adu6m57wKwhskyys61lhjYM157MghKm7vn9C1G3ig4iA+Qac
         UnrcMGU7of2O0AZQ5P79PlBFi7rEOfP/9oryEStepO+I07FQScBomqUPcZ/E+i7g1ftm
         4ScYdTzdp78t9U4ZhukuWsfGZ0KSpuvpZc3xs2Azy8FJRAY5b9xA+7I/xzdJRkGKLUlQ
         ClBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681767599; x=1684359599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/g58k9yYsP2ysFNVf9CiMtu4KEAj9Kt/TUR/AOahR8=;
        b=NyJG3aVDrtoV/trukLkDaSFBVQf4l+W/3A28lXYmdGLtWHF2egLOdQaBbM6Uuw+SMv
         kWJV9M9cP+baL//wU1Xor6SLJID6pelB13BPqrBPligK9F/yfI6YF5mLzKcYbWGaP0H6
         DSuL6NDFaxfO2c0j81gxXATPogQtkHl6WRsEMfhadytZ15HfsTwiAKv1r91IjqrktVZ8
         EO38OgBaYjQT5T5jauQ0lupMbsgnc+zFW51p7oR+qg7JU33h7RulslnjuwNLrHpVDdtB
         3jBgLVmBZf6dCNEakWZa+frDGFwMtj/xMcPC0rWRDS2x8/A9uRdtHDElVQYBK3jc3ZlJ
         YY1A==
X-Gm-Message-State: AAQBX9drZXbOUMDNWhTnTb33zJ1CtJ8Hgi6vKclaI+vzjTbD/W2egrOT
        /cJfJkrJvORpFqJJjovsUxDYpCmXBJbXAN7zLp8=
X-Google-Smtp-Source: AKy350ZNeII3beFbEIq9JFrL7k1MAAbu3y7/QAI8GMn36fVLR9aj4Q+pxoLYvdF31AH/yAqGoAYe6FgAUH5ZIWKUqA4=
X-Received: by 2002:a17:90a:6a8c:b0:247:5922:aacf with SMTP id
 u12-20020a17090a6a8c00b002475922aacfmr2414252pjj.7.1681767599349; Mon, 17 Apr
 2023 14:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230414181302.986271-1-mmyangfl@gmail.com> <20230414181302.986271-2-mmyangfl@gmail.com>
 <20230417204934.GA3334964-robh@kernel.org>
In-Reply-To: <20230417204934.GA3334964-robh@kernel.org>
From:   Yangfl <mmyangfl@gmail.com>
Date:   Tue, 18 Apr 2023 05:39:23 +0800
Message-ID: <CAAXyoMOuNx_3eJyPHt4TYOtpzh0U5opWBPgEEeXF7izw==pNFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add reg-clock-controller
To:     Rob Herring <robh@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=BA=8C 04:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Apr 15, 2023 at 02:12:59AM +0800, David Yang wrote:
> > Add DT bindings documentation for reg-clock-controller, collection of
> > basic clocks common to many platforms.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >  .../bindings/clock/reg-clock-controller.yaml  | 245 ++++++++++++++++++
> >  1 file changed, 245 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/reg-clock-c=
ontroller.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/reg-clock-controll=
er.yaml b/Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
> > new file mode 100644
> > index 000000000000..a6a7e0b05821
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
> > @@ -0,0 +1,245 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/reg-clock-controller.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Simple straight-forward register-based clocks
>
> 'simple' means extended one property at a time with little foresight. In
> the end, 'simple' bindings are never simple. s/simple/generic/ as well.
>
> When we first started the clock binding, we had exactly this. There's
> still bindings for at least some of it. It turned out to be a bad
> idea because it was difficult to get correct and complete. So this
> binding is exactly what we don't want.
>
> Rob

Thanks. So in the next version v2, clock-controller are made merely
container of clocks. The real jobs are done by sub clock nodes, so
that clocks, with or without hardware-specific clock types
"compatible", can be declared independently and individually as dt
nodes, instead of hardware clock "controllers" with quite arbitrary
clock identifiers listed under include/dt-bindings/clock/.
