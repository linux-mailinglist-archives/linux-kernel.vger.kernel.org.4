Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E1669C8B1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjBTKhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjBTKhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:37:32 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE6619F28;
        Mon, 20 Feb 2023 02:37:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id h16so2980493edz.10;
        Mon, 20 Feb 2023 02:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o18cessp6dJwK0nMBBUb6S+dtQdinOyZDu+pZzBVc24=;
        b=OkXFgkBCWiT+V6Rpb8pld5tCj5NLmRDheW7hWxhU3K3ZObZhiE4FRTJRJOhwoWLEFq
         Ytz/3GoxHFKVrkjpXRCzSIYDrTuPY89vvJeuO12hVk5ir6bNpo3XDnXGcQVhb7eZPS2r
         gt3xxZAALG2YoRP1VSBJtxWaUzY9y+vbke6nh7+MpR3mZCvbkuU1EoFBssisVyD5AN8q
         kxZRqef9Yfg5HNbfVutDwuAF8fIZUaRKlFAtyU3Uk+AVLnL5LjSQaEc4wFh/BDRp8K3u
         CKf6oYn7J2leBNx2DgaV6SGwyeVnyGXYElExfPV/+vc31kJK9PjUMGxvLTxH/VHbsX5T
         dDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o18cessp6dJwK0nMBBUb6S+dtQdinOyZDu+pZzBVc24=;
        b=2/Im9MKjDTmM4lQENsv/HgGhsXybKFPQE4WZPbnl13TNKz1KrUmpYkRpQtdp9npGij
         Te9FqBUHKQp9coSPAwWueT7TgQ5wVve6EmTKO4jmmqkPEm10ixdXeuDz+TT9HF9fkkvb
         pDA1f4SlWCwvic0uElKKUBY4ev5EQyW4dzA7hZ18LDEokVpxiME7oesnXwgH6zfHQ7Ls
         is8ACFX0Q0a687U8QRK+D3g8l170ZvfAURO9FB3rV33P5U1n/+t0idah6KDV/tt0LlpK
         RZfEmtQhN3VdKn0/R9RCRAwSgrxaAGOvjRVbwJbUklR2IiOtTGW6H5EZ/nDMtWuMrnw6
         x2ww==
X-Gm-Message-State: AO0yUKU8nI+iwva/T7oSyLeAMewPW0KwPfY8tkrscN1SKJi3MJIPulDg
        4ARqYHM4mPjVM7CwEJhsQtyGUl1lWx9xNMod3n67UVDz+IT75g==
X-Google-Smtp-Source: AK7set8C2ovFbu5XsmSt8Y2751Ugx3alLIaGhADo5OpsryHngZuGShpr5zOxR1nlwnKkzz1SjiUzNSgf/hlEyXzWKBI=
X-Received: by 2002:a05:6402:3216:b0:4ad:7bb2:eefb with SMTP id
 g22-20020a056402321600b004ad7bb2eefbmr1600504eda.3.1676889423185; Mon, 20 Feb
 2023 02:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20230218122236.1919465-1-keguang.zhang@gmail.com>
 <646cc26f-ed98-10fc-217b-5dc4416670a6@linaro.org> <CAJhJPsU7KmR1Z1uGsKUDW_=wUwr_Bg_7DwqsMD7tKWrZYQMPhw@mail.gmail.com>
 <4cd266d0-0555-e1a3-f9d1-35d4179ccfd1@linaro.org>
In-Reply-To: <4cd266d0-0555-e1a3-f9d1-35d4179ccfd1@linaro.org>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Mon, 20 Feb 2023 18:36:46 +0800
Message-ID: <CAJhJPsVhCKW6qgTm30wS_NhxF5cgrGg=vvj+v--FH+pg=JAKbg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: convert
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

On Mon, Feb 20, 2023 at 6:28 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/02/2023 11:25, Kelvin Cheung wrote:
> > On Mon, Feb 20, 2023 at 4:04 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 18/02/2023 13:22, Keguang Zhang wrote:
> >>> Convert the Loongson1 interrupt controller dt-bindings to json-schema.
> >>>
> >>> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> >>> ---
> >>>  .../loongson,ls1x-intc.txt                    | 24 ---------
> >>>  .../loongson,ls1x-intc.yaml                   | 51 +++++++++++++++++++
> >>>  2 files changed, 51 insertions(+), 24 deletions(-)
> >>>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> >>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> >>> deleted file mode 100644
> >>> index a63ed9fcb535..000000000000
> >>> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> >>> +++ /dev/null
> >>> @@ -1,24 +0,0 @@
> >>> -Loongson ls1x Interrupt Controller
> >>> -
> >>> -Required properties:
> >>> -
> >>> -- compatible : should be "loongson,ls1x-intc". Valid strings are:
> >>> -
> >>> -- reg : Specifies base physical address and size of the registers.
> >>> -- interrupt-controller : Identifies the node as an interrupt controller
> >>> -- #interrupt-cells : Specifies the number of cells needed to encode an
> >>> -  interrupt source. The value shall be 2.
> >>> -- interrupts : Specifies the CPU interrupt the controller is connected to.
> >>> -
> >>> -Example:
> >>> -
> >>> -intc: interrupt-controller@1fd01040 {
> >>> -     compatible = "loongson,ls1x-intc";
> >>> -     reg = <0x1fd01040 0x18>;
> >>> -
> >>> -     interrupt-controller;
> >>> -     #interrupt-cells = <2>;
> >>> -
> >>> -     interrupt-parent = <&cpu_intc>;
> >>> -     interrupts = <2>;
> >>> -};
> >>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> >>> new file mode 100644
> >>> index 000000000000..4cea3ee9fbb1
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> >>> @@ -0,0 +1,51 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/interrupt-controller/loongson,ls1x-intc.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Loongson-1 Interrupt Controller
> >>
> >> You changed the title, so this binding now will cover all Loonson-1
> >> interrupt controllers?
> >>
> > Yes.
>
> OK, then with the dropped |
>
Sorry.
Should I send the patch V2 to drop the description part?
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>
>
> Best regards,
> Krzysztof
>


-- 
Best regards,

Kelvin Cheung
