Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F245F1A88
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJAHOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiJAHOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:14:10 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA1E2AC59
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 00:14:08 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 207so4415242ybn.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 00:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7ue00wyDQ8ycUSRPgbYo15PRoBs6yC8KtymaqQ2kQws=;
        b=V8S7xMkKB8LxnpjClzNYnqqYUOHVR5IoKwSjTrUKqdMcznu8+8TjbH1IIf44DhJ6nG
         7Dk/yOSlBvcd/XwMgZbDhCqINA8IEhM4ju3RHcwj6Y+YoZVZdMsQ/gPz5y9SuRvPNutb
         jmV8CGdMTLw7fL3H55NCpT5jZhclV89iPtyG83wTNbkc2m5xMMo+qqGwLmXRfoG0LetY
         Y2eXFCOHJttOiFRTseVmiRRH0r3zZ78J+PQ5r5jQ0OakJO6jeLdnApBCuRB+3sd332g5
         oPFicevFdOuBqJtuaYb2X+qz8996tK2bCqibp+tWrz8e/5LzIsrP+TGQcjOYbir8oSfH
         jD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7ue00wyDQ8ycUSRPgbYo15PRoBs6yC8KtymaqQ2kQws=;
        b=b7IcI1LFxahm6e5y9xUd+D+02w6Xz/r4h40ZwpdA9rXUyMLCFLTsWSY9voebGK0n8z
         mr0a4xUxAQviAb2w5LFoq9heNABYkzi5OV/fAm7Y9N0uofGtyGdLZeWQ/VtmsqjelNlN
         +t53NwzI9Yo825Cu47jzkLL9kcWnk/pGSfukYzx3K5IQqNRO/Opg5LdJwjhMXNqt/QfQ
         jpRQwTIT6k0AuMm2kjoKyw7TJPLrInGrMRjOmcxRUqLlMC/WC5ISEqcCwv4H0vkwmQqs
         1cOiGpM9mw5Mty88PcOv7FG7QDzMarS+K6picYzXEY8x48La2zxyEmQtaHerz04R2rqw
         lZyQ==
X-Gm-Message-State: ACrzQf0KcAvvLzjEF0GATjSrpAu+ILsSzB18LJDSYRmMcDaxAPOeMWK8
        0b1AvEzG+rZdtSiqAFK5DFkbycgWOrEPBuDdM6+BnA==
X-Google-Smtp-Source: AMsMyM7oJ0p65XoYBq5LSSqHJKDAIk67BF452YFYa2UMr/VG/BxY67wN0a+Cq8WpTODQqJHR8sfRB0fvpubzUG5Hxdo=
X-Received: by 2002:a25:ba45:0:b0:67a:6298:7bac with SMTP id
 z5-20020a25ba45000000b0067a62987bacmr12061140ybj.194.1664608448066; Sat, 01
 Oct 2022 00:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221001030627.29147-1-quic_molvera@quicinc.com> <20221001030627.29147-2-quic_molvera@quicinc.com>
In-Reply-To: <20221001030627.29147-2-quic_molvera@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 1 Oct 2022 10:13:57 +0300
Message-ID: <CAA8EJpo5x4Wva4thoryvh3_jf9WssbRN=94fNq8Xwvph75G_iQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: qcom: gpi: Add compatible for
 QDU1000 and QRU1000
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022 at 06:08, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
> Add compatible documentation for Qualcomm QDU1000 and QRU1000 SoCs.
>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> index 7d2fc4eb5530..e37cee079c78 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -25,6 +25,8 @@ properties:
>        - qcom,sm8250-gpi-dma
>        - qcom,sm8350-gpi-dma
>        - qcom,sm8450-gpi-dma
> +      - qcom,qdu1000-gpi-dma
> +      - qcom,qru1000-gpi-dma

You know my comment, qdu/qru comes before sm/sc

>
>    reg:
>      maxItems: 1
> --
> 2.37.3
>


-- 
With best wishes
Dmitry
