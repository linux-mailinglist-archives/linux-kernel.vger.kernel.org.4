Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5FB5F1A94
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiJAHXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiJAHXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:23:35 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6212178A18
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 00:23:33 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 126so7686600ybw.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=auNHv19EqWsut8rW0EBiWQE/MF8sUbWcLsWmXh4cejI=;
        b=xzfPRGuuLep27d2DUXZ8ItZnICcAEbGcpHtOCUZfkiOKlnEFaL9Ly6krmJglhvQK0i
         XZqQChA+6Br7sh1+B2x8sutzGVImgIc5myeioU3fbA+Uf1FZstlOi83c/rYkJS/3zlG8
         ug7LcOvEFH86qVkXywTatX2/n5WA3DOqz4aZUyCZjszNGEjel5eMgb11KvI2up9s8mdk
         ym74fM1Ma0306tGj3/nZippUOBP4vX1O6iXAbjpk4gv+5V/vOA7Ku8f12kmk17ngDESP
         qONSrMvo2yZEyIQa1VhbS/cE+HLJ7v7LqmMha3mp+64Lg0BiIEOR3pogpw0jpdSzafCO
         birw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=auNHv19EqWsut8rW0EBiWQE/MF8sUbWcLsWmXh4cejI=;
        b=3O0pBdLtp0sHBEdvcoBYZ8NcrhZtjsqMyoDNuq58dJ3BwyKmGxEWr3vCNmtzES0Gwi
         H3LeBHH2mdIsOMMM3yRb14zZF+QcuOZBINdzp62o/IMPAk1/bGoGFKgsTr9WuqJOSFPl
         p1z+piB1oDGxi0ODz+bL0b9IL4bOfedL0fOmYjUJiSsmX/cjuUlk4UIeip8ShBgDGsLf
         pw+UqNjqAcrSjIeg1b4Bj7grGEZu8GgzE4f3H5RqlwlqXj7JqkZLvQOcl5ks0KJXSAtg
         KyL51detvGqgYIJYxDLlb3ti1RQiUedctNL844uZPgPKtEtCiWDhgOolhfLS0fNNTpEi
         F3PQ==
X-Gm-Message-State: ACrzQf2JBby01F2oXSFV3+k7+NzigBljOsOIw4/wtc6usINqVJfdCk6J
        +XMZhk6CelI0x3O5EViZUmsv8cQ/RxnTSSmrQDWWzg==
X-Google-Smtp-Source: AMsMyM5erD6AJna8cW0+b8fbUj9/4UIlzR/sKH2vdXGQ4vfDTCKXkOwVpKSGvSlI1bV9hLwxdcARJ3Ie0dKpawWvxQE=
X-Received: by 2002:a25:a502:0:b0:6bc:2835:a88a with SMTP id
 h2-20020a25a502000000b006bc2835a88amr11302688ybi.15.1664609013176; Sat, 01
 Oct 2022 00:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221001030656.29365-1-quic_molvera@quicinc.com> <20221001030656.29365-7-quic_molvera@quicinc.com>
In-Reply-To: <20221001030656.29365-7-quic_molvera@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 1 Oct 2022 10:23:22 +0300
Message-ID: <CAA8EJpqCy=NydMFOFZbQjBFFFhGszMqcjfBvQz1Rh6u60e6yvQ@mail.gmail.com>
Subject: Re: [PATCH 06/19] arm64: dts: qcom: qdru1000: Add smmu nodes
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, 1 Oct 2022 at 06:09, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
> Add smmu nodes for the QDU1000 and QRU1000 SoCs.
>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdru1000.dtsi | 57 ++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qdru1000.dtsi b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
> index 39b9a00d3ad8..8c2af08b8329 100644
> --- a/arch/arm64/boot/dts/qcom/qdru1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
> @@ -396,5 +396,62 @@ arch_timer: timer {
>                                      <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>                         clock-frequency = <19200000>;
>                 };
> +
> +               apps_smmu: apps-smmu@15000000 {

Please insert the node according to its address.

> +                       compatible = "qcom,qdu1000-smmu-500", "qcom,qru1000-smmu-500",
> +                               "arm,mmu-500";



-- 
With best wishes
Dmitry
