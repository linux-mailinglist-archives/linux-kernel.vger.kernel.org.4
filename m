Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC94698FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjBPJbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBPJa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:30:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8969D;
        Thu, 16 Feb 2023 01:30:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C6BD61EF4;
        Thu, 16 Feb 2023 09:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED1EC4339E;
        Thu, 16 Feb 2023 09:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676539856;
        bh=OdLf0lflbfPh6eJsxKZzkNPd+cBrLw4Nsh++3rLbo3U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lrYYx/UanFz71hs7kc/V2NG6UVveJtdnW2kR8C9HvO3hi0eQQO8VMeO6bPeuoj6tf
         Q6+HcJaB0Lpkli/UkxYeA9H4uIb/9ptldb3+7xRigtmf81ly82b9rADOAEozGBpUGG
         I/kfsYE6CT77A3/+RbEImNPtsj9Z2rVEQhvKBnmmNJmhWdhDsu/V68gxIwu7zOVGvD
         ztY3R3ubKykpJBfzNsfN47px7RWyJ6e4Ef1AfqtqGPJL0LSbrM3JI+FywkfRCvLxkx
         VgScCCPikOgVT8YSgPkdEetlGFkMbnBXG5oZfobwS3g0XpJ/vdstEAgal80WqQRfzY
         YqVXxwLWzSd3w==
Received: by mail-ej1-f51.google.com with SMTP id he33so3586122ejc.11;
        Thu, 16 Feb 2023 01:30:56 -0800 (PST)
X-Gm-Message-State: AO0yUKWeFUALvuhEnQci/npGa37BF/8TvPz89lILmsH9Epzw9F6mD6X+
        f8ETk8EzTFOuOZF5Z8xoPIcCoJ6uE214t1scyNI=
X-Google-Smtp-Source: AK7set98w9l2vIAxaf28W6wZ9k6ybYWesA0iLcj/ZtNswakBr1+s5dpgWQLdGVrV0xaSQr0Etr3j6M7lrYYXqzIrFmk=
X-Received: by 2002:a17:906:245b:b0:8b0:e909:9136 with SMTP id
 a27-20020a170906245b00b008b0e9099136mr2621638ejb.1.1676539854884; Thu, 16 Feb
 2023 01:30:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676289084.git.zhoubinbin@loongson.cn> <a9f697906df6599e6b001981e668479da71aa7a0.1676289084.git.zhoubinbin@loongson.cn>
 <df464409-9a93-c057-5f66-923a9e24696a@linaro.org> <CAMpQs4JX0Vgf5tvv5Yw5eLGANFfn1p=iQ_kMS0yQPV6kE2tN1g@mail.gmail.com>
 <23068d0c-d37c-0563-e1c1-e4d112059f5b@linaro.org> <CAMpQs4K+aYGrOoWy04vrbEy53kba9zUzGkOwD34pwAH0c=D8iA@mail.gmail.com>
 <49c8255e-66f3-fa1f-2949-1f03f77a0fa4@linaro.org>
In-Reply-To: <49c8255e-66f3-fa1f-2949-1f03f77a0fa4@linaro.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 16 Feb 2023 17:30:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6+aDYZ4JAPpdkefPR0P3QFqKCmt=RsZiw+FZRRax5TgA@mail.gmail.com>
Message-ID: <CAAhV-H6+aDYZ4JAPpdkefPR0P3QFqKCmt=RsZiw+FZRRax5TgA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: interrupt-controller: Add Loongson EIOINTC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Krzysztof,

On Thu, Feb 16, 2023 at 4:10 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/02/2023 02:46, Binbin Zhou wrote:
> > On Tue, Feb 14, 2023 at 8:43 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 14/02/2023 13:40, Binbin Zhou wrote:
> >>> On Tue, Feb 14, 2023 at 5:53 PM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 13/02/2023 13:15, Binbin Zhou wrote:
> >>>>> Add Loongson Extended I/O Interrupt controller binding with DT schema
> >>>>> format using json-schema.
> >>>>>
> >>>>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> >>>>> ---
> >>>>>  .../loongson,eiointc.yaml                     | 80 +++++++++++++++++++
> >>>>>  1 file changed, 80 insertions(+)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..88580297f955
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> >>>>> @@ -0,0 +1,80 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: "http://devicetree.org/schemas/interrupt-controller/loongson,eiointc.yaml#"
> >>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >>>>
> >>>> Drop quotes from bopth.
> >>>>
> >>>>> +
> >>>>> +title: Loongson Extended I/O Interrupt Controller
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - Binbin Zhou <zhoubinbin@loongson.cn>
> >>>>> +
> >>>>> +description: |
> >>>>> +  This interrupt controller is found on the Loongson-3 family chips and
> >>>>> +  Loongson-2K0500 chip and is used to distribute interrupts directly to
> >>>>> +  individual cores without forwarding them through the HT's interrupt line.
> >>>>> +
> >>>>> +allOf:
> >>>>> +  - $ref: /schemas/interrupt-controller.yaml#
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    enum:
> >>>>> +      - loongson,eiointc-1.0
> >>>>
> >>>> Why not using SoC based compatible? It is preferred.
> >>>
> >>> Hi Krzysztof:
> >>>
> >>> So far, from the datasheet, I know that only the EXIOINTC of the
> >>> Loongson-2K0500 is different from the other chips, and that is the
> >>> "loongson,eio-num-vecs" below, which is 128, while all the others are
> >>> 256.
> >>> My original idea was to add this property to make compatible
> >>> consistent, and also to make it easier to add new chips if they have
> >>> different eio-num-vecs.
> >>
> >> We talk about different things. SoC based compatibles are preferred over
> >> version ones. This was on the lists expressed many times. Please provide
> >> a reason why you deviate from general recommendation. Flexibility and
> >> genericness of bindings is not a reason - it's the opposite of the
> >> argument, thus this will be a: NAK. :(
> >>
> >>
> > Hi Krzysztof:
> >
> > Allow me to give a brief overview of the current status of eiointc (DT-based):
> >      Loongson-3A series supports eiointc;
> >      Loongson-2K1000 does not support eiointc now;
> >      Loongson-2K0500 supports eiointc, with differences from
> > Loongson-3, e.g. only up to 128 devices are supported;
> >      Loongson-2K2000 supports eiointc, similar to Loongson-3.
> >      ....
> >
> > As can be seen, there is now a bit of confusion in the chip's design of eiointc.
> >
> > The design of eiointc is probably refined step by step with the chip.
> > The same version of eiointc can be used for multiple chips, and the
> > same chip series may also use different versions of eiointc. Low-end
> > chips may use eiointc-2.0, and high-end chips may use eiointc-1.0,
> > depending on the time it's produced.
> >
> > So in the Loongson-2K series I have defined the current state as
> > eiointc-1.0, using the dts property to indicate the maximum number of
> > devices supported by eiointc that can be used directly in the driver.
> >
> > If there are new changes to the design later on, such as the
> > definition of registers, we can call it eiointc-2.0, which can also
> > cover more than one chip.
>
> Just go with SoC-based compatibles. If your version is not specific
> enough, then it is not a good way to represent the hardware.
EIOINTC is a bit like the existing LIOINTC which is already use
version to represent hardware.

Huacai
>
> Best regards,
> Krzysztof
>
