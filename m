Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17CF66AB5B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 13:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjANM3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 07:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjANM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 07:29:50 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D1A8696;
        Sat, 14 Jan 2023 04:29:49 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ja17so16827935wmb.3;
        Sat, 14 Jan 2023 04:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8hEz2tX8WQVqiCTWA57MURUodaicwe88KrWVwxOA660=;
        b=fArAzC8zckycuaKGc5pDDHO87Spn/L59v3TNbShCjpldOlBR0VrbvHmnAcThw8VQL0
         C4idtWaQ74ql6aENxyJ/4P6UgiOOuiPG4Be2u2RKKnFPdUaIQS0bKo+GJjyH7NImMww3
         921z3xItHbk1TdBZypQ/tkbD2bzL+FcNND6a5JACIr5380u0Khs++RUaEUTC5fvD/2X5
         qKMdr/G4LWZXCL/8wMnE2fOSogyKZXYT8L8z9m0kKzbZZ1oDGasjjm6IiBUboiuKrF1F
         EE0IhRJazPcDuFuF84TRMTuvQm1b69fL1j09Ir7OzY6UPPYzNFsvg7lYLNiMiEoItxoZ
         TMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hEz2tX8WQVqiCTWA57MURUodaicwe88KrWVwxOA660=;
        b=XYq9LPM3mLWJNHalxACgG0YZE47w4p63A04ac3BR5jyP29dk2ubGpa9r12P5Yk5vP2
         i5c+4LCj1SiqVCC/wnj24Lg+yufUrbnKmY23uAnxcsESPMHhYw6CckRyrs2RZwWACQX7
         PBqbtAdBmTmcMwcU08CigBYFVggf3m9t/k8au+lTBUyHyzZ875hlUmJ3CpuE83qRTzFQ
         jcI1DPHGMXQprrLk9rhxhq+aTVHwZJoDCEgeLYLh6JSNRPwyjkTpsLMwt9C7WUH4wgaV
         iOLgxv/vQAYvUV8JQurlxV3CVIjXDsTdB0X2Uv0EcU0yJoKUgiP/5re2s5IfovGddcXp
         1DwA==
X-Gm-Message-State: AFqh2krwZSgMsoL6MO9vyuqQ5MY+rBwI7sxxbjhoYs71PBbu5udzbdYV
        f1iUL3DpkjiuCqTdA7plO/kUy7CMoVnL0r5U8Pk=
X-Google-Smtp-Source: AMrXdXvw2i0sEgylDMZh0UrOxxDo36xx2QXyFSJvqx7RcfkWioGzsHpjoWNvSz6Tv78yA720Sr9dqoLU7GAeUTai9fw=
X-Received: by 2002:a05:600c:1e24:b0:3d3:48f4:830e with SMTP id
 ay36-20020a05600c1e2400b003d348f4830emr5010922wmb.31.1673699388009; Sat, 14
 Jan 2023 04:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20221212045558.69602-1-gch981213@gmail.com> <20221212045558.69602-3-gch981213@gmail.com>
 <c592dd31-5e9a-c2a2-1c70-46b7cffa9c5d@linaro.org> <Y6XjHNCLXY9s1IOF@duo.ucw.cz>
 <9d2c05f6-af5a-2d79-02ea-85c49e244957@linaro.org> <Y7xGUiWBKIAm9YFA@google.com>
 <1905de3e-438e-b729-7c1c-b154998c5eb6@linaro.org> <Y708DfB41c/ZivRw@google.com>
 <CAJsYDVJC15cePQ65BR=dxKY8ADoRepbiiFqXTNQzh_6RTAeMYA@mail.gmail.com> <Y8FxM/qW3IL2y4YY@google.com>
In-Reply-To: <Y8FxM/qW3IL2y4YY@google.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sat, 14 Jan 2023 20:29:35 +0800
Message-ID: <CAJsYDVK2Q22me0LtvuHk5WJ6n18jfFBBNVeis2k4KbwEMoDiEw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: leds: add worldsemi,ws2812b
To:     Lee Jones <lee@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

Hi!

On Fri, Jan 13, 2023 at 10:57 PM Lee Jones <lee@kernel.org> wrote:
> [...]
> So the description is for 'this device' rather than any re-use.
>
> And the handling of this property is only contained in your driver?
>
> In which case, my understanding is that you should use a prefix.

(Just out of curiosity. I don't want this property now.)

My understanding is that a vendor prefix means this property
is for devices by this vendor. However color-index is for supporting
clones, which are chips not made by this vendor. Does a vendor
prefix really apply in this case?

--
Regards,
Chuanhong Guo
