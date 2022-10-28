Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE23E611A64
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiJ1SpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJ1SpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:45:12 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2853044496;
        Fri, 28 Oct 2022 11:45:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g12so9716477lfh.3;
        Fri, 28 Oct 2022 11:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7q2OB//2hf9lUeahKYT3i6qbY00fQQMbGM4w7OVkbIc=;
        b=SZ4XUKfHaI8T1FxSok6Z79YUgsNwcY4xaw8GBd+tmIKFvz9cR0JakKPt5noszTQogG
         SvNurd1sq9s7aFjHA4RkFb258YmUKz3iAzkj7Op8smoGJYCypubBH3+0M1iNCsLZ5gs1
         s6ztwuy8Q2mAYiBJBOh5iGo4/8qW7I/TCpmV0SqPtViWdwkYEopdML+Ip13R/QzQSz8U
         JFl47XXlwkM46RVraBjtSdiTJ2YhcXINjoAD8Ae7MDJmgkslMVS9s0+QmjB34bGNVpm9
         E9hsyYzyY/bQuufjtEGfNe0UxJ2hWSiy4MILr63AOY2qKLrpS2gzzYJeL4GzZcDsv4wj
         0//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7q2OB//2hf9lUeahKYT3i6qbY00fQQMbGM4w7OVkbIc=;
        b=MK7/hLQ0FuQx/jL3TmBAVm0eedPyRJlIubLYouyh2Xq8dTAceGX10v1FwOE/NhYbmY
         dK/OIxxtaqn2f6P1WdIYIs95qZ/Yi+DL0UkSGqMA7E6PeIOSlFiXAteijKWKPsDqrNXu
         XQQQna1wan/ttaZPOrbPslwtuKy8rllPpeyPkD1l5woImDvvIgM4r/7YEtZ7I0jpE/vR
         6nKtq2Zk2x0YhWrYvYx3iOZ8+aIF5yPo8o5cJ7ZJUy6t1RAOtLSwIi4K3h5FRBs0/7AG
         jwak4oSzqlfUSdb16ivz2D1cTYzRO8/cvEJQ7hSyic+W6pQlC1FKWYvkzxs062bFAIhz
         hB6Q==
X-Gm-Message-State: ACrzQf1lhTbjIl3LJkOWTWBKascblLM254CtIzc81llhMrZ8deInpKuh
        VziHkBW6Nmy0E6wTIYo/8guD+AAts07iv6H9Jk7duVQ/LedkD5C/
X-Google-Smtp-Source: AMsMyM5hB5vHw5irh4m8H9U/NidFo6WSQwcEdaHTHBns4LI10bhMMEbZU1JhOWV8M3vUd26wJDIWIDSuTeeyFXEcBRY=
X-Received: by 2002:a05:6512:75:b0:4a4:6c3e:a75d with SMTP id
 i21-20020a056512007500b004a46c3ea75dmr256491lfo.408.1666982709426; Fri, 28
 Oct 2022 11:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165215.43662-1-fnkl.kernel@gmail.com> <20221028165215.43662-2-fnkl.kernel@gmail.com>
 <5b194c93-48df-055a-f532-abd98657dc41@linaro.org>
In-Reply-To: <5b194c93-48df-055a-f532-abd98657dc41@linaro.org>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Fri, 28 Oct 2022 21:44:57 +0300
Message-ID: <CAMT+MTQAe_eKoiNvmL4fje0__V16VDFWDGzehkN6M-jRuuMn7A@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: pwm: Add Apple PWM controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 28 Oct 2022 at 20:53, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/10/2022 12:52, Sasha Finkelstein wrote:
> > +  PWM controller used for keyboard backlight on ARM Macs
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - apple,t8103-fpwm
> > +          - apple,t6000-fpwm
> > +          - apple,t8112-fpwm
> > +      - const: apple,s5l-fpwm
>
> Is it then derived from Samsung platform? If yes, it is candidate for
> merging.
Apple calls it the 'AppleS5L8920XFPWM' which suggests some samsung
lineage, but the register interface is different from the one in
pwm-samsung driver.
