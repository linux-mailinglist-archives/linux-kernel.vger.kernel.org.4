Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E70728B96
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbjFHXKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjFHXKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:10:50 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4297D30C2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:10:49 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bad142be0ebso1204279276.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686265848; x=1688857848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tSEQet0GKrnr4pMn8FjH5AOgQ3B0lsZ20KBmXO0sWPo=;
        b=pnntPWqoyFjiGEPsSDDJOsjSPKnhtAxqJr8hxCAp1oOStZsydaau/YdYtp2YxnXEin
         57IbGlgMrR8BCsBFwlbsOj8UiQdZ5WVAJmACsn25rKAdFNjJ3M4bhztM5jRZRLT1XAfu
         KRTbCPky2JTZamkrOJ3D2WqGwSK/KRWCMXW34pFLYPE9fUdCaX4gQy7Mx1IuusYwvv2p
         W2+ZgfB5K4aaLt4DHAnIDEkx8zFIl2iB99zEqAq9t5AeQ4ErDwdAp2hvTstLNkXQXTiF
         XWZi1ZF6VC4ezSwoOUZ+ptMGUeRGo0GrcqU+CHeMyceq096STKNZOKeAVdeMLEARWvNf
         Yj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686265848; x=1688857848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSEQet0GKrnr4pMn8FjH5AOgQ3B0lsZ20KBmXO0sWPo=;
        b=csKLh3YPc5PZcWQx99pSHx9PPpVyUhQIVqHd2jrgycLfE8rGMZ9KC1kvO3hHmEp/gF
         DiIP7cU8PmAcsECBI0c8X0K+rg2x7Rixf1BC+91GfCv75DAjHePbhu5gS33/yTTcTLOX
         dMoRRnd/MW6IdZsvJP5jweJXvzI6DjRT9WtLMvYLUlbn/vO4pcrKcOkfYYvWYmGZ1llr
         4MIrDXqYxJdQD+glJqjqMR2LsTzVaG8moolMPJ6+X3P1kUYcvdAS6PFaqUgqmT2G+79F
         z1RNk4zicG+WyAtVSfI0rs1cs1InKJT5c1u3uM/FFEc9cNSOoyLhGBl9L3DJw+CfVGXT
         VgjA==
X-Gm-Message-State: AC+VfDzh2TTDpZ8w9PLVZ/wwypnVxYOvVMbpAdYFID5d0GjGEY4bxhR5
        PyqyTkBfuR62XRA+6HemWzruHllu1noKMAYMB2a7pg==
X-Google-Smtp-Source: ACHHUZ5ieHiWUe0+jCkKqPgwkmhjEiQMZfXdZn7EsyrfeetzBu0F5vssZk1uzJeDBX3CkFb7uI2m4RiqK+KMbMEwKbs=
X-Received: by 2002:a25:b44:0:b0:bac:5d73:7f04 with SMTP id
 65-20020a250b44000000b00bac5d737f04mr1078129ybl.10.1686265848459; Thu, 08 Jun
 2023 16:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230601111128.19562-1-quic_kbajaj@quicinc.com> <20230601111128.19562-2-quic_kbajaj@quicinc.com>
In-Reply-To: <20230601111128.19562-2-quic_kbajaj@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jun 2023 01:10:12 +0200
Message-ID: <CAPDyKFpDKgdZtxtsuRSR7rfQwpXZO9LAL_AtcQ6BuRaA_-S2HQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: mmc: sdhci-msm: Document the
 QDU1000/QRU1000 compatible
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 at 13:11, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Document the compatible for SDHCI on QDU1000 and QRU1000 SoCs.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 4f2d9e8127dd..af29d60ff0d6 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -39,6 +39,7 @@ properties:
>                - qcom,ipq9574-sdhci
>                - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
> +              - qcom,qdu1000-sdhci
>                - qcom,sc7180-sdhci
>                - qcom,sc7280-sdhci
>                - qcom,sdm630-sdhci
> --
> 2.17.1
>
