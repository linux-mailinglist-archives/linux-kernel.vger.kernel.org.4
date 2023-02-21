Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DAB69D80D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 02:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBUBhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 20:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjBUBhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:37:04 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C511EA3;
        Mon, 20 Feb 2023 17:37:03 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cy6so5724814edb.5;
        Mon, 20 Feb 2023 17:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dex/9E139pmrU5EhsVPWyzirLDTmPKMwVwBRqAZPrV4=;
        b=amfYrfEFl9ecib39xm5+f2XIF7Kwfz9ywYhsrVc6/ZZUXNoMan97srAqs+8hC7JgWo
         eM54pc+wWY/oPWt0GqBKpuGvJSDhNcWIdrjqCHAxXG0hOiRliYQivDowns8eANIpV5iI
         mfuydAduMnfUXh3AlQn9tGIsIR92SSE0k5ZGceX5tTQY9M6aGLB4HY1mWO2uPWon+VJF
         7FpybEqnKGuep2ctsGVp6LAK/9YuXU5bo4MfRW5/yF4MwNYMDoEXEVZOA7sLxpaXbmlE
         EnWI7TKXT3WX6t62CwbuO66QeQ70BKWLTs5zf4s2+aCau4tECGkkKTWQwj5gP2RvbwIK
         nPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dex/9E139pmrU5EhsVPWyzirLDTmPKMwVwBRqAZPrV4=;
        b=sZ62inmALja3Osh2aavGjrp5ld1h+gzRQyzYwoAUZzI9AwI2i2q/Ur7csuczpCAczU
         ih+QcZdyiLefvHLWwLYtJZ0Qm5xVRuDm5+Apmn4HY+vh3oNWS1gdXj3ZACaSmAcN1xvz
         jrHUN92UHW80DSd4qHaYEa09X7uSb51eP8VoiRRqL73lGKueujbMmwrYN/cMl0ttwLGX
         Bzjkxi5Dzri/NcTjvhdmTOFsU25RXuNUcDDB7f7rOLg/EaermP0rPAbpTITG9GuqStdh
         FbFHR0hwQyD0MFSNKY94Nzz7btR/56BNHfI+sEYSN3b16LS+aE9pWRhbTXC1hwAZI1yw
         JMvg==
X-Gm-Message-State: AO0yUKX/quFPnhrVpbijYYB9p9Re0G4iX/QjHdb3L6/djRiVJnZd58Yz
        ZqYc9kF3ysh96R12Vq9yeKBOo57n3K1NLKFcwgI54zoFNfQ=
X-Google-Smtp-Source: AK7set87RWp16SKTm7TXazRc2K9vLgmn5J0WguA1Bo/ewY4j0RHMkMqTUZpddGI1fwEHFcPpDw71cXtGnlViSQ6IPLc=
X-Received: by 2002:a17:906:40cc:b0:877:747d:4a82 with SMTP id
 a12-20020a17090640cc00b00877747d4a82mr5244448ejk.0.1676943421652; Mon, 20 Feb
 2023 17:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20230220111801.2037164-1-keguang.zhang@gmail.com> <4512df34-c2ea-cf00-1d2d-54ff961fd871@linaro.org>
In-Reply-To: <4512df34-c2ea-cf00-1d2d-54ff961fd871@linaro.org>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Tue, 21 Feb 2023 09:36:45 +0800
Message-ID: <CAJhJPsUJYo-po2M-mNYhm6vmvu=YYuVzNdfLXsZY4eree9UFWQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: convert
 loongson,ls1x-intc.txt to json-schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 8:16 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/02/2023 12:18, Keguang Zhang wrote:
> > Convert the Loongson1 interrupt controller dt-bindings to json-schema.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Unreviewed.
>
> > ---
> > V1 -> V2: Drop the description part
> > ---
> >  .../loongson,ls1x-intc.txt                    | 24 ----------
> >  .../loongson,ls1x-intc.yaml                   | 47 +++++++++++++++++++
> >  2 files changed, 47 insertions(+), 24 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> > deleted file mode 100644
> > index a63ed9fcb535..000000000000
> > --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> > +++ /dev/null
> > @@ -1,24 +0,0 @@
> > -Loongson ls1x Interrupt Controller
> > -
> > -Required properties:
> > -
> > -- compatible : should be "loongson,ls1x-intc". Valid strings are:
> > -
> > -- reg : Specifies base physical address and size of the registers.
> > -- interrupt-controller : Identifies the node as an interrupt controller
> > -- #interrupt-cells : Specifies the number of cells needed to encode an
> > -  interrupt source. The value shall be 2.
> > -- interrupts : Specifies the CPU interrupt the controller is connected to.
> > -
> > -Example:
> > -
> > -intc: interrupt-controller@1fd01040 {
> > -     compatible = "loongson,ls1x-intc";
> > -     reg = <0x1fd01040 0x18>;
> > -
> > -     interrupt-controller;
> > -     #interrupt-cells = <2>;
> > -
> > -     interrupt-parent = <&cpu_intc>;
> > -     interrupts = <2>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> > new file mode 100644
> > index 000000000000..48dd071ceeea
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/loongson,ls1x-intc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Loongson-1 Interrupt Controller
> > +
>
> What happened to description? Why did you remove it?
>
Sorry for misunderstanding your comments.
I will send patch V3 to add back the description.
> Best regards,
> Krzysztof
>


-- 
Best regards,

Kelvin Cheung
