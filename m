Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6984668712B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjBAWpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjBAWpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:45:42 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E18392AE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:45:39 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d14so148008wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 14:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nXEg1M/8Ow65IihrBRBuML6WIDNs1pKYceWi+8rT6PE=;
        b=qDInqtYujTo0IpmxoSiaW8ivIhtbPTHMjMQHFiUTrkQJvgGDw9nyD3Kvuo1p2aAXaR
         e2w7d8JHOyE8bqtRS7gRpkbGqTjvKH88ZtyVyphv4L8n7ny0pv1XqJyXEei1fMC6a4EM
         O3kviYo3Jo21H1r+SIBXtcTPlIMHRFJ/dD9i/3M/JRgIHDixrcq9AMHqLaNiHajgFMBP
         iQYuroK/pZ+Wm0PP+imuHPHBz97BJ2Z7S9YOJ4bsEN1uT5jA6jB6dUpL6XJ8c3F45G0f
         clmso6BDaXyj3hZjs4MfWBWRbbEahUE27DrL/wLlV+0sSoGifGUkkt54oxqwCiblSdVL
         yipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXEg1M/8Ow65IihrBRBuML6WIDNs1pKYceWi+8rT6PE=;
        b=U9nzjR3j7PMbqSWREwNY/QigPS7d/XUM9wnO56ueqnqgmJJXghuzOI+o97Y9jiAUPC
         AJvYLjoFzU7GomAiyJQwYM2oyvevz4GRs7XG14bvxnkvGzPcp7gsh3nu/M4ubzF/20vv
         SF3fzPkvYUiRhYnTqspcssm+snif4JGXd7gfOASOK9IyzskKZSze9SGHOVIy7rEIwrLt
         L3i4AHaLTXLwFmpzSsjbejw1wo6D/+NiEygZ85/15X3+gHBwvMirTNMINCcaEUleKXDC
         XWXUOyu07n1WPG0J86rX8/K/LOKFxjE6IM/cZ4H9c/sgmGPgxePnA7DfylkSZceo99BE
         ajLg==
X-Gm-Message-State: AO0yUKXWsWrjD1/EUlYDqS5GsKoI2ZgAvqqMUhrDxcywqVysW5dmvjXi
        1JogliocxXMWCSpWkhEp03Wx6g62/ajovhY9eQOsTQ==
X-Google-Smtp-Source: AK7set8hlhnmbtZBx98H8ICP56Fc5lHNYHDcGn2ClEg32Z21/F1mXiNlNLipP7v0YtJ/2DJTGfai3wxLoTqjPnVhszE=
X-Received: by 2002:adf:f94e:0:b0:2bf:edb9:78e5 with SMTP id
 q14-20020adff94e000000b002bfedb978e5mr127102wrr.383.1675291538313; Wed, 01
 Feb 2023 14:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20230201150011.200613-1-brgl@bgdev.pl> <20230201150011.200613-2-brgl@bgdev.pl>
 <e28c9048-635d-3936-e440-27e293501ff6@linaro.org> <CAMRc=Mc8gFpcB6k-qVmSAM0=iKHGBmGcqm3aV2xiyjWPG1wtvg@mail.gmail.com>
In-Reply-To: <CAMRc=Mc8gFpcB6k-qVmSAM0=iKHGBmGcqm3aV2xiyjWPG1wtvg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Feb 2023 23:45:25 +0100
Message-ID: <CACRpkdaFCG+PHXrOTGW4ZLMSOcJvJ6eYKRO-VLds1J13OuTYJA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: describe sa8775p-tlmm
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 4:15 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Wed, Feb 1, 2023 at 4:13 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 01/02/2023 16:00, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Add DT bindings for the TLMM controller on sa8775p platforms.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> >
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +
> > > +    tlmm: pinctrl@f000000 {
> > > +        compatible = "qcom,sa8775p-tlmm";
> > > +        reg = <0xf000000 0x1000000>;
> > > +        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> > > +        gpio-controller;
> > > +        #gpio-cells = <2>;
> > > +        interrupt-controller;
> > > +        #interrupt-cells = <2>;
> > > +        gpio-ranges = <&tlmm 0 0 149>;
> >
> > You have 148 GPIOs, so s/149/148/.
> >
> > I'll fix other bindings as we have such mistake in several places.
> >
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > Best regards,
> > Krzysztof
> >
>
> Ah, cr*p, sorry for missing it. Linus - can you change it when
> applying? I don't want to send more noise.

Of course :)

Yours,
Linus Walleij
