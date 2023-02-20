Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7686269C914
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjBTK41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjBTK4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:56:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204CC1A963;
        Mon, 20 Feb 2023 02:55:54 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b12so2942782edd.4;
        Mon, 20 Feb 2023 02:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YJBqSoHTm30Gkb94U4Buka8kFJ+C7Ha8pIDKy2Dppcc=;
        b=NXEzJgUS0hwg9jz0QP/YyaXJrykJy0tLHbJWioUihy52d+/kw1c9ErizoUfw1r4gXS
         NnhQDudKeNImJZUnN8FWsfHmsweD0GF0pAFlMKs1wJl34BSa9FY3qNmc9+8HIc+EdErX
         Q9LZx64A89y5XzKZTDGnM7rNZNATIxYTxzKx0NaPw5mZmoKdVFlTvG9bkjhSnt+LVgDY
         vNbnI4KDiJHeJwVb5JaKFma81buxZMKIPGLLdTMSeY24sD9VFdpBOnXPVB4EZJ8aHD45
         FRla9Kscr4VJ3ka4znQmOjwjg9oa2H7HawR+prpMIA2jlW/LJlNfux6BytKff/cPKCi+
         f3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJBqSoHTm30Gkb94U4Buka8kFJ+C7Ha8pIDKy2Dppcc=;
        b=1E72VgS/sYKIKnLilQXukTVWJPSRmxd/FeeoGYMKQ1yeTpQ5mF2qdRRR6rtx/MD4Jd
         fmmxHjWVEBgMR1Qdzd9RDmSMRFqDUlOmOiE+YvplVzDM2G4qoymogTb+Uyt+IkOCDmsY
         ndSP73YBVnFETyyj5is8/6NVrO4j3WvQ0i8fSd9tfYX/PgjhldTi1uVizzZPPfNGGdS0
         HfBT7rQTwZqRujUjYTVTkq0EC1FJjQULmFgJDFPFv+HNn+akKrQWE++G8HPaBfjaaLcv
         kRh8xRObRlibn5dTXUGLayj6I9ZZomFmvWd/fOIMu5o6r4zPwWI2NQEqdHfEsRZ0R4tJ
         NxoA==
X-Gm-Message-State: AO0yUKVSrcpNV3KF876KF0LdBPFMuzXyrJfw7Z8BiVsBvtOaAKJ2T2BP
        6ECo/NYEgCCga1TLziRaGO7IUifdVaUyq4R2bZ4=
X-Google-Smtp-Source: AK7set+Qg1LDO3E3dRmVnuGqC1HZ6sSxwqH6QKyfnZSj1acRuNg6ugCpTTPHmJkGe3Y7iBARCXbFcH6nEJHI9DW57lA=
X-Received: by 2002:a50:c347:0:b0:4ad:6113:568e with SMTP id
 q7-20020a50c347000000b004ad6113568emr1248685edb.4.1676890497887; Mon, 20 Feb
 2023 02:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20230218122236.1919465-1-keguang.zhang@gmail.com>
 <646cc26f-ed98-10fc-217b-5dc4416670a6@linaro.org> <CAJhJPsU7KmR1Z1uGsKUDW_=wUwr_Bg_7DwqsMD7tKWrZYQMPhw@mail.gmail.com>
 <4cd266d0-0555-e1a3-f9d1-35d4179ccfd1@linaro.org> <CAJhJPsVhCKW6qgTm30wS_NhxF5cgrGg=vvj+v--FH+pg=JAKbg@mail.gmail.com>
 <ca6ebb35-ac8e-b49f-c2ab-b65492c1b4b4@linaro.org>
In-Reply-To: <ca6ebb35-ac8e-b49f-c2ab-b65492c1b4b4@linaro.org>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Mon, 20 Feb 2023 18:54:41 +0800
Message-ID: <CAJhJPsXrG3dpcG0iMjTFfG0GAHCghtWrWDij17JBD+aHRVR-Xg@mail.gmail.com>
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

On Mon, Feb 20, 2023 at 6:40 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/02/2023 11:36, Kelvin Cheung wrote:
> > On Mon, Feb 20, 2023 at 6:28 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 20/02/2023 11:25, Kelvin Cheung wrote:
> >>> On Mon, Feb 20, 2023 at 4:04 PM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 18/02/2023 13:22, Keguang Zhang wrote:
> >>>>> Convert the Loongson1 interrupt controller dt-bindings to json-schema.
> >>>>>
> >>>>> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> >>>>> ---
> >>>>>  .../loongson,ls1x-intc.txt                    | 24 ---------
> >>>>>  .../loongson,ls1x-intc.yaml                   | 51 +++++++++++++++++++
> >>>>>  2 files changed, 51 insertions(+), 24 deletions(-)
> >>>>>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> >>>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> >>>>> deleted file mode 100644
> >>>>> index a63ed9fcb535..000000000000
> >>>>> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> >>>>> +++ /dev/null
> >>>>> @@ -1,24 +0,0 @@
> >>>>> -Loongson ls1x Interrupt Controller
> >>>>> -
> >>>>> -Required properties:
> >>>>> -
> >>>>> -- compatible : should be "loongson,ls1x-intc". Valid strings are:
> >>>>> -
> >>>>> -- reg : Specifies base physical address and size of the registers.
> >>>>> -- interrupt-controller : Identifies the node as an interrupt controller
> >>>>> -- #interrupt-cells : Specifies the number of cells needed to encode an
> >>>>> -  interrupt source. The value shall be 2.
> >>>>> -- interrupts : Specifies the CPU interrupt the controller is connected to.
> >>>>> -
> >>>>> -Example:
> >>>>> -
> >>>>> -intc: interrupt-controller@1fd01040 {
> >>>>> -     compatible = "loongson,ls1x-intc";
> >>>>> -     reg = <0x1fd01040 0x18>;
> >>>>> -
> >>>>> -     interrupt-controller;
> >>>>> -     #interrupt-cells = <2>;
> >>>>> -
> >>>>> -     interrupt-parent = <&cpu_intc>;
> >>>>> -     interrupts = <2>;
> >>>>> -};
> >>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..4cea3ee9fbb1
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> >>>>> @@ -0,0 +1,51 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/interrupt-controller/loongson,ls1x-intc.yaml#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> +
> >>>>> +title: Loongson-1 Interrupt Controller
> >>>>
> >>>> You changed the title, so this binding now will cover all Loonson-1
> >>>> interrupt controllers?
> >>>>
> >>> Yes.
> >>
> >> OK, then with the dropped |
> >>
> > Sorry.
> > Should I send the patch V2 to drop the description part?
>
> Yes, please, with my tag.

Thanks for your time.
>
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>
>
> Best regards,
> Krzysztof
>


-- 
Best regards,

Kelvin Cheung
