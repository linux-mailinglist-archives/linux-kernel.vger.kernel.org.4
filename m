Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C23641C8C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 12:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiLDLDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 06:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiLDLDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:03:15 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D8D60
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 03:03:15 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3b10392c064so92095787b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 03:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qJbRZNBQzOqDd0GP/QZxbHmKYFnTEGrpdxvaDa8mKDE=;
        b=wtiowsuDqmuSv5Zv9544YX26H1xGWSolEiBEMptpYHzqafEx7FShIePKWp4jVo2dpu
         VyMK8JgUeoBzg1v0n/olxhrh/GSWRg7CkbXPspDi58r3C30Lfa48m9tYRPYjVXjIBLwp
         gcypxy29RlwRadTMXyZGBpq8yZDYPuX6/StAUrsvzPLNJv320czfU2wRL5BSmYFceLyF
         +pwZBYiNcArlkLwF4EhU6bD3D0ZpcPS8gi5rNjV3tka+ahmUx+ZU9zAaLxRSBuUv+wgc
         oFiPgm8yfvNghpU6pbvAebsd2UKpLUfoCI3lntq3kT8xEaqlXqO51qh6pjQ32QAoPKQu
         NyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJbRZNBQzOqDd0GP/QZxbHmKYFnTEGrpdxvaDa8mKDE=;
        b=avvKlifnkkfV9ZExly+WUCpEDJ1WAK2FxIHZ3Hu5bXD1IzslDrSorc7XLoe2FVhyft
         L85YVs061W+y98EzJcAHKbE7Wq5oKKiRiaTEA795LF5es6P/jR00AGhcdhTXNG0RhT6t
         tXRdrUPv+3VXqlCaEi+6AvTKfND/Sm1BUjIqlvLl1B/oiPUuogsrCz5lxgoz3MKDzu2L
         Z9vzTeZvLHMjhweHHE8sgoO7r1zFiRyQsXLTiwqblwj9RZpfgFDVAz7El5qgqnYsvMZ+
         AB0vPR0o1lHqsqewUQ2UlDptW5ZO2zs2n1LVuuiEImmWRbqGxacUpunDA9R56MF5Gsiu
         JYgg==
X-Gm-Message-State: ANoB5pk8gtzSs0BW/UBW95oGIwjmy6sFh0KIm02RYYsj6QG7JBfT4geM
        5PtfggLqXIWcsbdm8YfeNnnKxjb80I4NXOmnjEDC/A==
X-Google-Smtp-Source: AA0mqf7ZPWMbkkk6lfGjeu5oKNQRS80DCvE/uccHYTkEB1qertsc5NvLoU3/1+AgN4JSMxw/fMhQj2ZqgBeTB9qifmw=
X-Received: by 2002:a0d:db15:0:b0:3d6:2151:4038 with SMTP id
 d21-20020a0ddb15000000b003d621514038mr18690504ywe.418.1670151794369; Sun, 04
 Dec 2022 03:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 4 Dec 2022 13:03:03 +0200
Message-ID: <CAA8EJppMjnGTV5uezxXA+zFBouF1Db99GGPTZ4xde=44xxS6bw@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sm8450: align MMC node names with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Dec 2022 at 11:44, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The bindings expect "mmc" for MMC/SDHCI nodes:
>
>   qcom/sm8450-sony-xperia-nagara-pdx223.dtb: sdhci@8804000: $nodename:0: 'sdhci@8804000' does not match '^mmc(@.*)?$'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
