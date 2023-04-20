Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9B66E9543
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjDTNB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjDTNBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:01:24 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3117A9B;
        Thu, 20 Apr 2023 06:00:58 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54fb615ac3dso40498997b3.2;
        Thu, 20 Apr 2023 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681995658; x=1684587658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOz2vJX6O8WYQA+86dOvET6FW/q2m4As7J1doBwYieQ=;
        b=SFRtVWPbBXUIMuQ5P64CLBS539wch2e8cP9vsCUiPg+MkKM1b6+nHJeIRma1Q6nfuK
         2Xkt9YhXhCLJJDY4Eoj+HOSRlAOi29R+7GNtTRQCr3rFvzIYFrhx+tN6A5ZJAoKEVNt/
         dIkO8/SDhE2/lJXuibw7QLyOZr6gn3O/YEZWSYPJLs/Sr6VIcUskUVRD4N1SsU88+i3c
         x/R6malWXYad5p55JNi/JMAm/sKSADuSZz9GhivHU1NIf/Ozptz6YpIjuysVjzULsfsj
         cFZ1oD6bSFQON9lmQnOkarivg3aQZT7ejPxI8tF/48fBVWJKbcshoVRRuctm1+Pk23Ud
         QIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681995658; x=1684587658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOz2vJX6O8WYQA+86dOvET6FW/q2m4As7J1doBwYieQ=;
        b=K7GJ+/ZbxVdD6BYEsEznRoGDvP4YwN94wcFwIA1FWRjnm0PBTD4hpwXZuZazCW8gsC
         g/ymRW9AWfpaSD6J1sbUqD0JZ7vKYRZTv09krRxR5TxUHmunaFYOJ+zAB8wbDWmtV2j9
         +xNWi9uROBaep8F10Imnlf93MoOK8YnAjNArs3xgt4gBuh204u+hfNqldjxOVPgI+eeV
         7he0LF4ssXLrOIwKBpKuehgWdXvP2plAv+72f6lGzlMQTwtIZ+10TpBuGfXL1ONufoU9
         77oK/+bOnxLyRQX+snvuwHtzBTmhOdpXFYE7lxzsf0nhx+CTifS2HenlmbJD8R0X6VZY
         H41Q==
X-Gm-Message-State: AAQBX9cmc7MimmaYOQbcPuJWxHpFNUNMAgDjIh6hbFauNUQPeG+f9imQ
        MfMTRvcYFQrXchJTHZjxHcJFeJuotseAfibim2s=
X-Google-Smtp-Source: AKy350ZkKzpMEQFQALpd3cUpdAhLhNufP4l2LeGvrYz2hiijurncKr1W1aLvwH6jsswb6m6sGIjecPmAmxB6QTrh0pk=
X-Received: by 2002:a0d:e0c1:0:b0:54c:1405:2ce with SMTP id
 j184-20020a0de0c1000000b0054c140502cemr712660ywe.49.1681995657810; Thu, 20
 Apr 2023 06:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681887790.git.zhoubinbin@loongson.cn> <3b9c4f05eaf14bc3b16aebec3ff84c8a2d52c4a5.1681887790.git.zhoubinbin@loongson.cn>
 <f9b62f48-5c8b-2674-313d-4552c61c4302@linaro.org>
In-Reply-To: <f9b62f48-5c8b-2674-313d-4552c61c4302@linaro.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Thu, 20 Apr 2023 21:00:42 +0800
Message-ID: <CAMpQs4JjHvVOzQz-1Y-q9ut6tWUpakrHeozuwPg0dzoDcUFEGA@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: interrupt-controller: Add Loongson EIOINTC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
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

On Thu, Apr 20, 2023 at 4:09=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/04/2023 09:17, Binbin Zhou wrote:
> > Add Loongson Extended I/O Interrupt controller binding with DT schema
> > format using json-schema.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  .../loongson,eiointc.yaml                     | 74 +++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-control=
ler/loongson,eiointc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/loo=
ngson,eiointc.yaml b/Documentation/devicetree/bindings/interrupt-controller=
/loongson,eiointc.yaml
> > new file mode 100644
> > index 000000000000..4ab4efb061e1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,e=
iointc.yaml
> > @@ -0,0 +1,74 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/loongson,eioin=
tc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Loongson Extended I/O Interrupt Controller
> > +
> > +maintainers:
> > +  - Binbin Zhou <zhoubinbin@loongson.cn>
> > +
> > +description: |
> > +  This interrupt controller is found on the Loongson-3 family chips an=
d
> > +  Loongson-2K series chips and is used to distribute interrupts direct=
ly to
> > +  individual cores without forwarding them through the HT's interrupt =
line.
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - loongson,ls2k0500-eiointc
> > +      - loongson,ls2k2000-eiointc
> > +
> > +  reg:
> > +    items:
> > +      - description: Interrupt enable registers
> > +      - description: Interrupt status registers
> > +      - description: Interrupt clear registers
> > +      - description: Interrupt routing configuration registers
> > +
> > +  reg-names:
> > +    items:
> > +      - const: enable
> > +      - const: status
> > +      - const: clear
> > +      - const: route
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  '#interrupt-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-controller
> > +  - '#interrupt-cells'
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    eiointc: interrupt-controller@1fe11600 {
> > +      compatible =3D "loongson,ls2k0500-eiointc";
> > +      reg =3D <0x1fe11600 0x10>,
> > +            <0x1fe11700 0x10>,
> > +            <0x1fe11800 0x10>,
> > +            <0x1fe114c0 0x4>;
>
> Binding is OK, but are you sure you want to split the address space like
> this? It looks like two address spaces (enable+clear+status should be
> one). Are you sure this is correct?
>
Hi Krzysztof:

These registers are all in the range of chip configuration registers,
in the case of LS2K0500, which has a base address of 0x1fe10000.
However, the individual register addresses are not contiguous with
each other, and most are distributed across modules, so I feel that
they should be listed in detail as they are used.

Thanks.
Binbin

> Best regards,
> Krzysztof
>
>
