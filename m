Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAD3748FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGEVk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEVky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:40:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923261998;
        Wed,  5 Jul 2023 14:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FB68615C5;
        Wed,  5 Jul 2023 21:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A80EC433C7;
        Wed,  5 Jul 2023 21:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688593252;
        bh=43KgAy9/42rhJ/qdDtut0U8IYVof/FSFApFtVi0NS7w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=arRjBgE+Eu/fqU6RjT62qDCwUNGBrAdxDi6g7Qz7Q70iMYrm2Oor4Pix6c1Wm8aGI
         wa4j+B3zFeZvQ9AJdNFHxa49DSlUVybqGi1ypsooLc4OWuGjaprJyXtFhWuFYBREWY
         Ij8hY7mR7AxoE0A0a8ywbys314zG+kF97d+ZdxxMZx1eKlz3Z1sVSmIAv92TPb3Rft
         KD0NdY9SSAU9Fqvgx3K5V38aT71w9ZHgCE7GFVT2yE9uHkmiFOteXXAaRYcaZwW10Q
         BdOLGeRa0ypMSK8nRU1qaZKOD2MqKLRBoWeq2j//1+klx1a+b5fFcXCcL6rlGQ8tfi
         +xFlZ9O2pVFbg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b70224ec56so15416501fa.3;
        Wed, 05 Jul 2023 14:40:52 -0700 (PDT)
X-Gm-Message-State: ABy/qLb4/BUBQoZGacEfVpogSC9MrKg8lzRStWg2T6TxkkG7I8xBfgOp
        If15nzcDhoPz3gCL5cc7JSQqhLfVna7Reck4+A==
X-Google-Smtp-Source: APBJJlFoq5cIOIjbR+234mv24z/4earTsTW24z8akNDSm6Vi1gZP0JHzxc4vEmZtR5+/51uG0JXrLKV1JtatdjeeqoM=
X-Received: by 2002:a2e:a164:0:b0:2b6:fc60:776f with SMTP id
 u4-20020a2ea164000000b002b6fc60776fmr3445500ljl.30.1688593250544; Wed, 05 Jul
 2023 14:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230630185602.2175559-1-robh@kernel.org> <0aa7227d-264f-a87d-bef1-9f5d1c43a184@arm.com>
In-Reply-To: <0aa7227d-264f-a87d-bef1-9f5d1c43a184@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Jul 2023 15:40:38 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+T_8JNAQ1Ca8kNH0LCkiytJuSZPZeC_pvyOOG6xvQh+g@mail.gmail.com>
Message-ID: <CAL_Jsq+T_8JNAQ1Ca8kNH0LCkiytJuSZPZeC_pvyOOG6xvQh+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: pmu: Add Cortex-A520, Cortex-A715,
 and Cortex-A720
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jul 3, 2023 at 1:40=E2=80=AFPM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 2023-06-30 19:56, Rob Herring wrote:
> > Add compatible strings for the Arm Cortex-A520, Cortex-A715, and
> > Cortex-A720 CPU PMUs.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   Documentation/devicetree/bindings/arm/pmu.yaml | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documenta=
tion/devicetree/bindings/arm/pmu.yaml
> > index e14358bf0b9c..0cc468d6c372 100644
> > --- a/Documentation/devicetree/bindings/arm/pmu.yaml
> > +++ b/Documentation/devicetree/bindings/arm/pmu.yaml
> > @@ -49,7 +49,10 @@ properties:
> >             - arm,cortex-a77-pmu
> >             - arm,cortex-a78-pmu
> >             - arm,cortex-a510-pmu
> > +          - arm,cortex-a520-pmu
> >             - arm,cortex-a710-pmu
> > +          - arm,cortex-a715-pmu
> > +          - arm,cortex-a720-pmu
> >             - arm,cortex-x1-pmu
> >             - arm,cortex-x2-pmu
>
> Should we catch up on Cortex-X (3 and 4 now) while we're at it?

Yes. I'll add those.

Looking a bit further at this, it seems a bunch of platforms
(including a Cortex-X3 based one) are just using "arm,armv8-pmuv3".
That's supposed to be just for s/w models, but it's not enforceable.

Rob
