Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D325627A42
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbiKNKPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiKNKOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:14:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633C41D0E1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:13:49 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u24so16484298edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bWpDJZx8s8TqHa3dJij9Er/yWcw9t9Zuq4Q2LMKSWTc=;
        b=cjIVuxX4EEpXLMXV2WzT6KB3lCTMfAzo5a/4HH4bnaQj8WYSdU2b4hOg/1XuhEFqTm
         MIVJcOjRmnpDTodd9l48wPFyNzSjQk58K0mfSytAiALhZ3F+2BZSxvDVJzQkbaE+EP5z
         o/pd2iHNzokxzR4uDeZa7hytJoY8Kw7SkFftbAQIeyHk6G+zS/sdZ7fw0sA2bYXhhhc7
         5812tgdjdoHIx+pn1Xk8Ehd7iPIwmzXzELEnCVoAgqHVyJsIyrdXf8NngIuamDquzjNQ
         U76qfYjMshYPaUzDSFNsNU20vSf1Rj0i/wEPpmqDg2cIZdOzVQZlwV4DnUNfd2azOCtN
         ffEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWpDJZx8s8TqHa3dJij9Er/yWcw9t9Zuq4Q2LMKSWTc=;
        b=CeHgx+3GC5vfkJ91iz654kZZCddAZrRKeXwg/BfHCxoubI8Wlj+hzRD1g5N8wNWICa
         Y95+IY3cLAPhSxr55JyX5x8cRx7PTCwkFwdtDMi1SfmQ9PvsUBAn99hejhHtpWy5f7t9
         vBCnZaW8pCZxfV81TROzt77qiVL1xRaKKCpPVbNcgeuEeRUx1dLhY9xbso/sIgc85Yjt
         wjyniR/FQn27g5Svj2U8chxj9xy54UkUFyg2jbQlaDEHo4Yw3tK8F5ZlDne/E6/RN18f
         c4trqotVZwMtAi/78aPatVf8N12GqKk0MjKZilN68Fo2jIzfxeK0dU7Iw3chUlT773v5
         uxIw==
X-Gm-Message-State: ANoB5pn0ZcCz7KdwQZM6ZYDl4+ssHo9ZWbhReBHvS9kQV95j0pTIASsT
        IBxCi7YwkORDHvwKFkYJiNNWmp+Vk1g8wTeBvdTiFoTmths=
X-Google-Smtp-Source: AA0mqf5EFr3zFnVVb9aA5hK6QctCVyxWWEaL3OJbKudAWnizBxBvsdlv7Ut8KhK4OsxnKbIUo3GwC1JBgOIcKRhKfsc=
X-Received: by 2002:a50:ee13:0:b0:463:a83c:e0af with SMTP id
 g19-20020a50ee13000000b00463a83ce0afmr10150851eds.158.1668420827920; Mon, 14
 Nov 2022 02:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20221108092840.14945-1-JJLIU0@nuvoton.com> <20221108092840.14945-4-JJLIU0@nuvoton.com>
 <CACRpkdb+Bkwa8yCKGtRcsJ6KnJh+RUuz_gOrQV63pcYQLaHCaw@mail.gmail.com>
 <CAKUZ0+GCf_Zv=VhnY5Z=yYAfR1=_ha98BVVxRGVy8ui6so_Yrg@mail.gmail.com>
 <CACRpkdYW0P8gqtGdiRX_frP32WF2W=NVg1JTu1fVMBXxEL0-WA@mail.gmail.com> <CAKUZ0+Hy5suFg9VZ8-+cH7kGc5KLqUnf9hjnT+iaw+a1HF8x0A@mail.gmail.com>
In-Reply-To: <CAKUZ0+Hy5suFg9VZ8-+cH7kGc5KLqUnf9hjnT+iaw+a1HF8x0A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Nov 2022 11:13:36 +0100
Message-ID: <CACRpkdYbS_syVwgc=YndkV-DpEF0K8NpH6WzP=g0AFpN+OTN8A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: gpio: Add Nuvoton NPCM750 serial I/O
 expansion interface(SGPIO)
To:     Jim Liu <jim.t90615@gmail.com>
Cc:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 9:38 AM Jim Liu <jim.t90615@gmail.com> wrote:

> Our sgpio module has 64 pins output and 64 pins input.
> Soc have 8 reg to control 64 output pins
> and  8 reg to control 64 input pins.
> so the pin is only for gpi or gpo.
>
> The common property ngpio can be out or in.
> so i need to create d_out and d_in to control it.
> customers can set the number of output or input pins to use.
> the driver will open the ports to use.
> ex: if  i set d_out=9   and d_in=20
> driver will open two output ports and three input ports.
>
> Another method  is the driver default opens all ports , in this
> situation the driver doesn't need d_out and d_in.

Finally I get it!

Some of the above should go into the binding document so that
others understand it too.

Have you considered splitting this into 2 instances with 2 DT nodes:
one with up to 64 output-only pins and one with up to 64 input-only pins?
That means more nodes in the DT and more compatibles. If all
the registers are in the same place maybe this is not a good
idea.

If you feel you need to keep the two properties, create something custom
for your hardware because this is not generally useful, e.g.

nuvoton,input-ngpios = <...>
nuvoton,output-ngpios = <...>

By this nomenclature it also becomes more evident what is going on.

Yours,
Linus Walleij
