Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C2A63D374
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiK3Kba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiK3KbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:31:16 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5910B48406;
        Wed, 30 Nov 2022 02:31:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g12so26258281lfh.3;
        Wed, 30 Nov 2022 02:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fv3Wp1f+QTDnSN5uykjtcq/j71xlTKfFkgX9bxQuGXc=;
        b=FRon3T2gVgOfoIGVXXk6Eres5nbKkb2IdBbrzgBFjsJNW4nD0SRIrwsjWFQ7AOX/sK
         cI6IPeg8l2hzOuHsXUzbkYiq2Kbvqxt89KzzrpdE53ab9AlVxsL/eMmcJUjf7JrimUir
         SSwWAdp/l7uVEqu0yDoKCgukZyx2SP/iJB/63Guv7Mt3f5W388hjRP9Ah1nzcYtQMPYm
         uQjWn7+q5VTQ3NG6Tw6NjWsbmxnKiNkUZLOE4EDsS83gN+V4ussGRVzOxslhFOwNi7QW
         Xad9318ZBrURj0IZews21eq/LDMAVJrT4uKSePY44qagIwXGbc8W+PZFJhSQXl4bnRG1
         hi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fv3Wp1f+QTDnSN5uykjtcq/j71xlTKfFkgX9bxQuGXc=;
        b=ESpFRu1h9SYsm7e8kKkAxyezmlRDbT69xbhq3bd4SFFNtlLA2Nh6i02JzxBRdNLykK
         M10E0PE5Na7MeWFOP4ipXrdGecvLYwT0QXk9lJpEvgpfYxQvn6u1Ct3vb6icczGFC8lg
         hveCsGxgaS5HD2Q59j5phe9uYZBK3igYme4ucInpRS8MGms4bHZj2LkhU/KTRy/8Qwe6
         E85E7zt3JmJlZ/B9pHlIrJJTw/aW2UDEimEbZS1+yovbyahmf0NjmpsrtGwXmvCpQlf7
         Yskv75bPPmkytykl/aMEegfzXIuuN8wFnbwi8U1tSj+0DkD4IGYHmCaN82gyOCGVJHzo
         /4XA==
X-Gm-Message-State: ANoB5pkVrY47j4r8ztaH9JUBkkZQdBR3gfk0dMTIewCoLPpmZtUIjM3y
        e0MNsQkSyjkc9tvR6YTdVV+i78YSUXQ49GUokYo=
X-Google-Smtp-Source: AA0mqf6nHQyoRCEMLjI55WiSFRP0VDvbS2r/qwG4xRgS7G8nmlGVgO/ru9udgXyFtS/ASOMtB6DZl5ZOC8G5fnKjL20=
X-Received: by 2002:a19:4352:0:b0:4b5:1334:a1f8 with SMTP id
 m18-20020a194352000000b004b51334a1f8mr4992189lfj.401.1669804273470; Wed, 30
 Nov 2022 02:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20221122201232.107065-1-tmaimon77@gmail.com> <20221122201232.107065-2-tmaimon77@gmail.com>
 <cedc0013-f0c0-3180-6995-477b77b919f8@linaro.org> <CAP6Zq1iGwqOVOnhmF0ijYw=KoTRJj5CUpFv6WDouZmjVxXhQ-g@mail.gmail.com>
 <5c7a06bf-94e3-5c65-f202-105f74a41d29@linaro.org> <CAP6Zq1jdy-qDGFsk4sKcp3tx7d-nBMxOK72CRt3LLO8CrWJyKQ@mail.gmail.com>
 <7661de74-f68c-6617-6a4e-3b0eb76a2a2e@linaro.org>
In-Reply-To: <7661de74-f68c-6617-6a4e-3b0eb76a2a2e@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 30 Nov 2022 12:31:02 +0200
Message-ID: <CAP6Zq1jQ7r4N5bc2yS0kuQrFqBvDD3mXxaASc=KkVt-fjBELuw@mail.gmail.com>
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

Thanks for your clarification

On Wed, 30 Nov 2022 at 10:27, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/11/2022 17:44, Tomer Maimon wrote:
> > hi Krzysztof,
> >
> > Thanks for your comments.
> >
> > On Thu, 24 Nov 2022 at 18:18, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 24/11/2022 16:38, Tomer Maimon wrote:
> >>> Hi Krzysztof,
> >>>
> >>> Thanks a lot for your comments.
> >>>
> >>> On Wed, 23 Nov 2022 at 12:03, Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 22/11/2022 21:12, Tomer Maimon wrote:
> >>>>
> >>>> 1. Subject: drop second, redundant "documentation" (dt-bindings are
> >>>> documentation).
> >>> O.K.
> >>>>
> >>>> 2. Use subject prefixes matching the subsystem (git log --oneline -- ...).
> >>> this is what I did dt-binding: soc: nuvoton... do you mean dt-binding: nuvoton.
> >>
> >> You didn't run the command, did you?
> > I did run this command "git log --oneline
> > Documentation/devicetree/bindings/soc" and I got this log list
> > e47206d71e67 dt-binding: soc: nuvoton: Add NPCM BPC LPC documentation
> > 121494030c53 dt-bindings: soc: add i.MX93 mediamix blk ctrl
> > 4fed4d20c59b dt-bindings: soc: add i.MX93 SRC
> > c7ebd54158d3 dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
> > 2345fc8dc2ec dt-bindings: soc: imx: add interconnect property for
> > i.MX8MM vpu blk ctrl
> > c1d9381ce430 dt-bindings: soc: imx: drop minItems for i.MX8MM vpu blk ctrl
> > f3894f969cf5 dt-bindings: soc: mediatek: Add display mutex support for MT6795
> > b2d7616e13c4 dt-bindings: soc: qcom: apr: add missing properties
> > 301628d80501 ASoC: dt-bindings: qcom,q6adm: convert to dtschema
> > 7b0ad4629d1f ASoC: dt-bindings: qcom,q6asm: convert to dtschema
> > b2496de1dfdd dt-bindings: soc: qcom: apr: correct service children
> >
> > most of the subjects are similar to what I did, if it is not correct
> > please let me know exactly what to write (beside the word
> > documentation that I will remove)
>
> None of them have "dt-binding", so fix that part.
>
> Best regards,
> Krzysztof
>
