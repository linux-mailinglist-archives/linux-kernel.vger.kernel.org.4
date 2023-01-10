Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2B3663A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbjAJIIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbjAJIHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:07:25 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899551BCBF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:07:24 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 203so10989833yby.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lgm6ODdOTwOgRGqASG5+FLZjAIQNUGHiBENFY4rx6AE=;
        b=V0xpg82iQUd9dT5xPOTG3/m8tBPVpHuTPXAtiwHxPFV+JXUF874AArehAQxX0VVPJI
         dMsU8IjB0nJYsiznJSb/PYFizQV45MoTWnzwnH/99oNTWswLxlP0RptldeKhf91G3Xh0
         y4EZSyKCHhoJKUmrACDCXIzLAedkAKm+p/bHduQZdhRLMdT3iyQNLNLogmzStWhKqEbg
         diLboFRTfph13beMnuL5K55ThIEliUl469Z3Ow24e6WQ0cEtV49RtY0pSapgBibJwe0x
         GuNlJGTiNECUynDKRzkvrcCBZggsrOjoBuzCNTaEecTv2LEwsPZxSOhTEu/E0Sv4nA6a
         rX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lgm6ODdOTwOgRGqASG5+FLZjAIQNUGHiBENFY4rx6AE=;
        b=ZsigypVyrwAyuJfxY9lP2Dl5vOK3obOam69PT+r6UvXQ5y0yWIIXXY7J52ks8Wm89r
         BY+KPCnRAbKoWLPKNTnsMjZz0fu4cutPXmM2yxjn7HMBdxS5mhMI3VaAAlBiBQcuQvuE
         /zBLVMzqqL54m1oOIgXtILjoHhUCwfnOToaerImyTkvaZB8EZOCVVxaNxkxglCqlE4D3
         QRlyFf1EKQl+pHtuqmPAPOO21FxegqoQ5FT18q0wMwsn0zMlcF6J2RckkK3aUAxIHdNZ
         3maJBoJgKuU0Jof4ic2xn7jgXdze8avC6xJbY75dAcRYta2E2p/Qi+tZOvwkdxDKAmpy
         lK0w==
X-Gm-Message-State: AFqh2kq44FOZFWfQNC2bTDmYnZXaBea2y6ewVRawkR541KJ5ifSLBcif
        lunCJU3IVgiXuCkv6hlEzL280b+GQ9oCJ72LcPV9Xw==
X-Google-Smtp-Source: AMrXdXsSNEutsWI33WWfecxyGagsThBzSAOklrH71wj/xUCISGHJEa9zcolX34/qr68ealayxmCXwNNMIQCmsNAkmYg=
X-Received: by 2002:a5b:a90:0:b0:70b:87d5:4a73 with SMTP id
 h16-20020a5b0a90000000b0070b87d54a73mr5220169ybq.584.1673338043778; Tue, 10
 Jan 2023 00:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20221222161420.172824-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222161420.172824-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Jan 2023 09:07:12 +0100
Message-ID: <CACRpkdbvBLEf-_J+RiBnXVzxm_e4Ga-w1URpv3BjVARhZ9HqUA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: add
 input-enable and bias-bus-hold
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Dec 22, 2022 at 5:14 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Allow bias-bus-hold and input-enable properties (already used in SM8450):
>
>   sm8450-qrd.dtb: pinctrl@3440000: dmic02-default-state: 'oneOf' conditional failed, one must be fixed:
>     'pins' is a required property
>     'function' is a required property
>     'clk-pins', 'data-pins' do not match any of the regexes: 'pinctrl-[0-9]+'
>     'input-enable' does not match any of the regexes: 'pinctrl-[0-9]+'
>
> Compact the properties which are just set to true for readability.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij
