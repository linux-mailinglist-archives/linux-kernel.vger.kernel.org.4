Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFBE63C579
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbiK2Qp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbiK2Qov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:51 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B511461770;
        Tue, 29 Nov 2022 08:44:40 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g12so22956168lfh.3;
        Tue, 29 Nov 2022 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QDjFWsc3ucw3ostvFNx34ed5EAV3FJBU5/wGZt6zl+k=;
        b=JsSc9WVmFjT9unOXNGX8hEhSmMEnajrb6Fn2ZjfjXkxwU7GrS7cPp+/fm/7/cIDpLH
         u6L6XQaK7MDqG1DednOXagnCiwe3x3Ajn+cAoLREfuDwYYu0rT7QcQgSA3iZgEaNRB0Y
         iAkcCTPzXyZ3DvQTznFXEE6lJ/WaCTV9YAu5Mr/DU5IfpGoNZndlwKdcKi24YMH4BzGC
         rBDN8CqeyIw52VU47n0upEs+gW4aFlWa6xDBzxdht838rzapg3ARjAPjsyuREa+XL4ah
         s3mAX3XIur9MuG9PxsGYEuouFDXnUj+NWKRJCTb39YxehdnOSwYbXm/pE9fv2ha6lHEV
         reCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDjFWsc3ucw3ostvFNx34ed5EAV3FJBU5/wGZt6zl+k=;
        b=7gfDUSf+RlLJs36r52ZH/cE0CWtigzc4OzhYmpPZAlEnXfqEHhGlOPlHDAsfDCJ20b
         BtRwVwpSY8bbTF26knCGKWyItnkaqII9OawqGXHcZtqjMu4ubLVxF7KZnYnjMByM3ODA
         8FVHGUBfH0Mrluhip5CcTO9IPER2v27wglm9SXdls6EMKzaB6DAAirUsae3J7frGX81D
         Td/hE+zJGiuYxJV9LunuWFdDS7FhS5lF5dF4fR+La5bII98NjGV++5kU+FiyueLObVGL
         +lX7UglcVn9Wy5VBsJ9clx6MYipvSZg5Erv6Qh2gn64D2QMlRFpMWPnBaVbEYZd3gsr8
         QCxQ==
X-Gm-Message-State: ANoB5pnyz/cD1W390dewLeeP/ZSdEA1fNKNACS7Q7EFfvsxkednA046T
        Jlhmpedzaz6WsyrAsi/ssF8xpOuEDDHzbx0ZDWI=
X-Google-Smtp-Source: AA0mqf4QtXRnfiyyYZOjf8Dt1CKWPHFPr+deEfd0mlEsGGtOXUksstAbNmDzprx2v1QZdaMOkGuJee454LsLiGKKvlM=
X-Received: by 2002:a19:4352:0:b0:4b5:1334:a1f8 with SMTP id
 m18-20020a194352000000b004b51334a1f8mr4072943lfj.401.1669740278843; Tue, 29
 Nov 2022 08:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20221122201232.107065-1-tmaimon77@gmail.com> <20221122201232.107065-2-tmaimon77@gmail.com>
 <cedc0013-f0c0-3180-6995-477b77b919f8@linaro.org> <CAP6Zq1iGwqOVOnhmF0ijYw=KoTRJj5CUpFv6WDouZmjVxXhQ-g@mail.gmail.com>
 <5c7a06bf-94e3-5c65-f202-105f74a41d29@linaro.org>
In-Reply-To: <5c7a06bf-94e3-5c65-f202-105f74a41d29@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 29 Nov 2022 18:44:27 +0200
Message-ID: <CAP6Zq1jdy-qDGFsk4sKcp3tx7d-nBMxOK72CRt3LLO8CrWJyKQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-binding: soc: nuvoton: Add NPCM BPC LPC documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        arnd@arndb.de, hasegawa-hitomi@fujitsu.com, marcan@marcan.st,
        nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        heiko@sntech.de, sven@svenpeter.dev, briannorris@chromium.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Krzysztof,

Thanks for your comments.

On Thu, 24 Nov 2022 at 18:18, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/11/2022 16:38, Tomer Maimon wrote:
> > Hi Krzysztof,
> >
> > Thanks a lot for your comments.
> >
> > On Wed, 23 Nov 2022 at 12:03, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 22/11/2022 21:12, Tomer Maimon wrote:
> >>
> >> 1. Subject: drop second, redundant "documentation" (dt-bindings are
> >> documentation).
> > O.K.
> >>
> >> 2. Use subject prefixes matching the subsystem (git log --oneline -- ...).
> > this is what I did dt-binding: soc: nuvoton... do you mean dt-binding: nuvoton.
>
> You didn't run the command, did you?
I did run this command "git log --oneline
Documentation/devicetree/bindings/soc" and I got this log list
e47206d71e67 dt-binding: soc: nuvoton: Add NPCM BPC LPC documentation
121494030c53 dt-bindings: soc: add i.MX93 mediamix blk ctrl
4fed4d20c59b dt-bindings: soc: add i.MX93 SRC
c7ebd54158d3 dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
2345fc8dc2ec dt-bindings: soc: imx: add interconnect property for
i.MX8MM vpu blk ctrl
c1d9381ce430 dt-bindings: soc: imx: drop minItems for i.MX8MM vpu blk ctrl
f3894f969cf5 dt-bindings: soc: mediatek: Add display mutex support for MT6795
b2d7616e13c4 dt-bindings: soc: qcom: apr: add missing properties
301628d80501 ASoC: dt-bindings: qcom,q6adm: convert to dtschema
7b0ad4629d1f ASoC: dt-bindings: qcom,q6asm: convert to dtschema
b2496de1dfdd dt-bindings: soc: qcom: apr: correct service children

most of the subjects are similar to what I did, if it is not correct
please let me know exactly what to write (beside the word
documentation that I will remove)

>
> >>
> >>> Added device tree binding documentation for Nuvoton BMC NPCM BIOS Post
> >>> Code (BPC).
> >>>
>
>
> (...)
>
>
> >>
> >> No, only bus schemas could have it. Here additionalProperties: false.
> >>
> >> It seems there are already few LPC controllers and all are put in
> >> different places:
> >> Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> >> Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.yaml
> >>
> >> Maybe Rob why this was made not really as two bindings - for bus
> >> controller and devices?
> > As mention above, next patch I will describe only the BPC device.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >
> > In general, I waiting for Arnd approval for adding the NPCM BPC driver to SoC.
> > After Arnd approval, I will send a new patch revision.
>
>
> To be clear - bindings must be accepted (Reviewed or Acked) before
> driver is.
>
> Best regards,
> Krzysztof
>

Best regards,

Tomer
