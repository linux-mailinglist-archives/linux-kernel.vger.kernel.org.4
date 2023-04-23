Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8946EBE02
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 10:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjDWIbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDWIbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 04:31:13 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB21E19A6;
        Sun, 23 Apr 2023 01:31:12 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54f8af6dfa9so47945067b3.2;
        Sun, 23 Apr 2023 01:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682238672; x=1684830672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QYHi1U0H8xeoz+ojliRlXjskKQpNh5ZppQiWqXTPmg=;
        b=n29GfRgV2KM71xU0PJGUus7tcaVrQNRqxRyd9+C9ZSMxc8Yq/JBo/iyYfjmiVoYYVj
         qyYpoSFV4EujOpAf8Wg1c+bCAVeXWsCkfQ2qKGa6aDClLJX5kdMICEN5JxRZPiOnrkjZ
         qk8nMo0M7GYahnpKfhmGCnZ2lgiCs82VuqTGk/yZSDcJrz9qMsp44xHGI8IK2GGFO1HA
         GyjMDS0KD10qaZ9TDbZt84E4LOQ5QQnu+EG/eKNjMOhMSRaOXXguE6q9kSopTiTOtl/k
         Ekx4/5wyneuO1PYQCELdkr6kn6rI2Vtz5FpnjdZPRMk3rnc9ySYn59vCp02SK2gn1IL/
         uRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682238672; x=1684830672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QYHi1U0H8xeoz+ojliRlXjskKQpNh5ZppQiWqXTPmg=;
        b=ZoJbyuTPEOy0lV8epccSQuhV71kkqpuvokxgNk5Nj0K3r4nPSYZYCDZPvFsBQC/GrI
         Ii8ZWx4Guy3jYjtj7fdcmeKoRi2MXUiH3m/VK/GgDONU5YJbqjUI+t6cEaWvZXP0a+dh
         1BSosqGndsWAxh2gMLHkywwQT0cLjnBCBvTwquDji09n0Stna5WfffPqczkHPe9udpmg
         sKb8OYeW0BUD06LAqKR1dh/0Gt59lV43FkBPb37Jpqt7uvpqXKVM1E2TAU78gRYKgpbo
         PjNpovYhA7m6RlgLgxIso76PfDvO8WvY+yyTDsfKQOdn9Jy+OsoOtQNNEOsEWGYEbfo+
         OvZQ==
X-Gm-Message-State: AAQBX9dvUsIsQU2OqLAySRyBjf82cl+SDAEAqkYoHveqm3hdi1Dw8+ej
        6OLyedjfWjor2xg0YpXC7HF2MVVtQjmNufjWkbo=
X-Google-Smtp-Source: AKy350ao+/7bEok4Abt9/zxZOar007y/ULFW6xkLcjzlu7/jxRV1Ag/ua7DsMXMSEICNjxr3Wld7QUpS6J0Lp/BeZVM=
X-Received: by 2002:a0d:df4a:0:b0:54f:b4fa:3271 with SMTP id
 i71-20020a0ddf4a000000b0054fb4fa3271mr5522576ywe.21.1682238671839; Sun, 23
 Apr 2023 01:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681887790.git.zhoubinbin@loongson.cn> <3b9c4f05eaf14bc3b16aebec3ff84c8a2d52c4a5.1681887790.git.zhoubinbin@loongson.cn>
 <f9b62f48-5c8b-2674-313d-4552c61c4302@linaro.org> <CAMpQs4JjHvVOzQz-1Y-q9ut6tWUpakrHeozuwPg0dzoDcUFEGA@mail.gmail.com>
 <75231886-cdf6-cfde-d6b9-183b1fbf98da@linaro.org>
In-Reply-To: <75231886-cdf6-cfde-d6b9-183b1fbf98da@linaro.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Sun, 23 Apr 2023 16:30:57 +0800
Message-ID: <CAMpQs4Jp8WPKJEuJD-_83oRPBbPELxS5ufqp-nHow0D9D+R+ig@mail.gmail.com>
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

On Thu, Apr 20, 2023 at 11:52=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/04/2023 15:00, Binbin Zhou wrote:
> >>> +examples:
> >>> +  - |
> >>> +    eiointc: interrupt-controller@1fe11600 {
> >>> +      compatible =3D "loongson,ls2k0500-eiointc";
> >>> +      reg =3D <0x1fe11600 0x10>,
> >>> +            <0x1fe11700 0x10>,
> >>> +            <0x1fe11800 0x10>,
> >>> +            <0x1fe114c0 0x4>;
> >>
> >> Binding is OK, but are you sure you want to split the address space li=
ke
> >> this? It looks like two address spaces (enable+clear+status should be
> >> one). Are you sure this is correct?
> >>
> > Hi Krzysztof:
> >
> > These registers are all in the range of chip configuration registers,
> > in the case of LS2K0500, which has a base address of 0x1fe10000.
> > However, the individual register addresses are not contiguous with
> > each other, and most are distributed across modules, so I feel that
> > they should be listed in detail as they are used.
>
> Do you want to say that:
> Between 0x1fe11600 and 0x1fe11700 there are EIOINTC registers and other
> (independent) module registers?

No, this section is all EIO-related configuration, but there will be
undefined space here.

Throughout the chip configuration space, there are some relatively
common areas, such as the definition of 0x1fe1_14c0.
Because our chip supports two interrupt modes, node legacy I/O
interrupt and extended I/O interrupt, both modes require interrupt
routing registers.
Their registers are then defined together: the legacy interrupt I/O
start address is 0x1fe1_1400, while the extended I/O interrupt start
address is 0x1fe1_14c0.

Then I have carefully compared the chip configuration space in
LS2K0500 and LS2K2000 and can see that:

1. The chip configuration space base addresses are different, but they
both have a size of 64KB;
2. The offset addresses of the EIO related registers are the same, for
example the offset of the enable register is 0x1600.

Wouldn't it be better to declare the entire configuration space (64KB)
directly in the dts and use the offsets to access the corresponding
registers?

Example:
reg =3D <0x1fe10000 0x10000>.

Thanks.
Binbin

>
> Best regards,
> Krzysztof
