Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD027372AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjFTRYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjFTRYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:24:50 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B63AFC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:24:49 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1acfce1fc0bso460829fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687281888; x=1689873888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KRN5tzGweg8LErYfcrxjZ1KmGTE3sKhMIQTVdGenkIU=;
        b=Usjnz0IqQahZbMcDM0lEsP3d4I8nCqUfG8kT+14iuDuvrKAJTFr+WwPKudbnm6Y+j6
         ztyfCzpJ+7BCnTpsSOHWwlQ9cR4eIF2u4BD/fTGxBOoafI1/saUyKl5Iuz8cdqodWFMp
         Pqoa5g018fMi0+iV/9GL3889I3bDRqe1P9qY8E72KECK2yuFOiuLfC/dQwbID6lYPRci
         FG/6bgwild1VvaQdrkfbwpV8OqJBTrRC7PMjr65Z6+B69ctXFBg4P4y45T4Im++0Gf/T
         js7WPmRci62wf3Sh/TOtEfSYXV3EFnjo2i5f9A6LY/rl9BSMORaSdArcKQ0zxuPzuFKz
         HowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281888; x=1689873888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRN5tzGweg8LErYfcrxjZ1KmGTE3sKhMIQTVdGenkIU=;
        b=ef4tKVEztRvPJEEL8IIaIWcteLMVpwrUhSAv5dT1wBCptRDi1qdbPZHRXt5yx2I2DR
         ltBTq3iPDNE9LBvAoFWtA2EdnslFLTOXBCPJLy5y8IPtJbT4D0GRE3D9URKfUcU+ZNvs
         JgPklHR5B+fOcQxdZSNuARJ7T8zRair96sbNoJSuRDmpTjoR6f5JCYr8J1TMtPGKsM1B
         DL9QD583b7zeMrdLJWa8JxXIKVhEN7QJFxO0b+O/NU+Pu1xllltXiGgCdMsJiECQxvmf
         4f7gIgpGqZxfbGlJ+dEhSK1EoXPEoxn2Kct3JIYRbV8BTFb8dm2QnBvq+DvjLxs/FTi7
         f/uA==
X-Gm-Message-State: AC+VfDwqlIuJRip6j0BCzX215G9jeD86Wcmrst7HkpJCe5W4LVCEcKnl
        nD1nmyXzp8IGiUlebolHm9NMLzduZW3GVc0mx9ljwhwm6b37zf8Y
X-Google-Smtp-Source: ACHHUZ5Utdl0V9qTJ29ktbaxPrSyDw+hSKuoiO5/DDMSHktSe7P1zryVOx5jWnV3I2ia4SHYy5HhbbDmQkhulvO+m64=
X-Received: by 2002:a05:6870:499a:b0:1a6:b74e:afd9 with SMTP id
 ho26-20020a056870499a00b001a6b74eafd9mr4658024oab.35.1687281888568; Tue, 20
 Jun 2023 10:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230616035813.255062-1-jaswinder.singh@linaro.org>
 <20230620170725.13794-1-jaswinder.singh@linaro.org> <5ae8c143-64cf-469d-b4f2-bed5bd9ee87b@linaro.org>
In-Reply-To: <5ae8c143-64cf-469d-b4f2-bed5bd9ee87b@linaro.org>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Tue, 20 Jun 2023 12:24:38 -0500
Message-ID: <CAJe_Zhc7-LU0X6epmOoo3nE0j+e_zROsA+J0s0vSUA-sTJ6jBw@mail.gmail.com>
Subject: Re: [PATCHv2] dt-bindings: arm: socionext: add Synquacer platforms
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023 at 12:16, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/06/2023 19:07, jaswinder.singh@linaro.org wrote:
> > From: Jassi Brar <jaswinder.singh@linaro.org>
> >
> > Socionext's DeveloperBox is based on the SC2A11B SoC (Synquacer).
> > Specify bindings for the platform and boards based on that.
> >
> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > ---
>
> Attach changelog after ---.
>
> >  .../bindings/arm/socionext/synquacer.yaml     | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/socionext/synquacer.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/socionext/synquacer.yaml b/Documentation/devicetree/bindings/arm/socionext/synquacer.yaml
> > new file mode 100644
> > index 000000000000..c582d9c31213
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/socionext/synquacer.yaml
> > @@ -0,0 +1,29 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/socionext/synquacer.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Socionext Synquacer platform
> > +
> > +maintainers:
> > +  - Masahisa Kojima <masahisa.kojima@linaro.org>
> > +  - Jassi Brar <jaswinder.singh@linaro.org>
> > +
> > +description:
> > +  Socionext SC2A11B (Synquacer) SoC based boards
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - socionext,developer-box
> > +              - socionext,synquacer
> > +          - const: socionext,sc2a11b
>
> That's quite different change.
>
So it is not carrying your ack.

> What is synquacer in this case? You claim
> now it is a board, but based on previous discussions and U-Boot source
> it does not look like such.
>
I never made that claim. I said Kojima-san will confirm. He informed
Synquacer is a brand name.

Currently no code internally or externally differentiates between
SC2A11B and Synquacer and we might as well keep living with Synquacer
only. This patch is an attempt to be accurate.

-j
