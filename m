Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578EB6B3AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCJJfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjCJJfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:35:14 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D091F10821A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:32:19 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-536c02c9dfbso86390567b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678440737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Njdqrsn+QSy6WW8NbM32NbcKQVZ2VRKXnbBVlDR43PE=;
        b=I4V7wPWYRdZegJ8DhUHATpp0Vxwip13k/L0Q9o2h/IqJJ4HQ8nQHgrYEpOhZxEFSVl
         4xLe8AJCo+ll9a6vAqMKqlwWRdJHamEN+RBPOZ3y3rmuYMV1YaX9x+iUq3EsABUBSRIh
         jlUmsgbotNkL3QXBBPIAUH5yfbk7Qgbk4L0bjMnxotUL2DocWwrxb4mmtD/YEL1g2qa2
         yDcRrygRlC/k6fdd+fdRxEp2toTVcXgN/vHKHU8VoQ2lFoHBiYw7Jv4L832qtkbRNjQk
         4em/Xk4rT08xX49fZyrlCYk0im75utMZdJUK5ONjBMOV+SWdNI0iCYN9kzFhDUBRAJPU
         5iwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678440737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Njdqrsn+QSy6WW8NbM32NbcKQVZ2VRKXnbBVlDR43PE=;
        b=QsySEGq9OaZoqG3/QUmiRwoGZw8C06gsZY1ocPFb5GTr++hEnmLy7Aa/x1ke7G01Oe
         jDSc65vyMqppdSvsooJDcC5VVCh8Kl8m5ep1lzXccJX4c6jDiwwJLN/zf106Ru5sjLJO
         GOe1iv3/eTnx8tpWD0DufYK3F9Oq7Qbn9015bSzE60i9XySgbKZOZUs+9WiRWemKJfrg
         AAk8P9mWGNkrWu+QWXq9pZnkD0jxg8D7fPhaLYotZzQPTIf79yH/v9WtPre+L3hKsCmS
         LT3MrFeC3ihQjvyqc+jTznAZqpqojYdaza7oHU/u3I2Xs3J9GowcP4pV5SHsIlsKNTuN
         kpGA==
X-Gm-Message-State: AO0yUKUQGqMYJJ+ORegGnwCYUnoQ7wx15HliVuNFxx7akAA3uv4jKgZm
        Ir7Qf0izsYARjx7j42P4hP4hbeWNZfnML3wlm4zATlMcyfpHFyVL
X-Google-Smtp-Source: AK7set9uX6AxQgDrnxQYufSXnfjSvA23OWB2dnkfvaqc1us5wsw0bn5Hf9b8WA3gyUWET9UjY31bpqu63bKUd+bXlng=
X-Received: by 2002:a81:ac4b:0:b0:533:9ffb:cb12 with SMTP id
 z11-20020a81ac4b000000b005339ffbcb12mr16453153ywj.10.1678440737032; Fri, 10
 Mar 2023 01:32:17 -0800 (PST)
MIME-Version: 1.0
References: <20230308084309.396192-1-nm@ti.com> <CACRpkdbBWeFupRin=JuMCGDWkzbsR18N+4ZEbQOPJq=p3w0yLw@mail.gmail.com>
 <20230310004311.5e5ekv7edpbahjap@groggily>
In-Reply-To: <20230310004311.5e5ekv7edpbahjap@groggily>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 10:32:05 +0100
Message-ID: <CACRpkdaL3Sbn8Jv_etgFcVZT1spD0qa9RuMGon2LF-SvgTs6+A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: k3: Introduce debounce select mux macros
To:     Nishanth Menon <nm@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 1:43 AM Nishanth Menon <nm@ti.com> wrote:
> On 15:03-20230309, Linus Walleij wrote:
> > On Wed, Mar 8, 2023 at 9:43 AM Nishanth Menon <nm@ti.com> wrote:
> >
> > > Introduce the debounce select mux macros to allow folks to setup
> > > debounce configuration for pins. Each configuration selected maps
> > > to a specific timing register as documented in appropriate Technical
> > > Reference Manual (example:[1]).
> > >
> > > [1] AM625x TRM (section 6.1.2.2): https://www.ti.com/lit/pdf/spruiv7
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> >
> > Patch applied.
> >
> > Consider doing what Krzysztof recommends: move thes <dt-bindings/*.h>
> > down to the arch where you're using it and have them as .dtsi files instead
> > or something.
>
> Yep, that sounds like a better idea. If you are ok to drop this
> patch, then lets do the cleanup first and move the pinctrl to something like
> arch/arm64/boot/dts/ti/k3-pinctrl.h

OK let's proceed like that, I dropped it!

Yours,
Linus Walleij
