Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA28E648F93
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 16:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLJP5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 10:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLJP5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 10:57:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D741658B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 07:57:20 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id c1so11663868lfi.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 07:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PE0en2UU/eeKZFa7xUSQ62ylm6WHJ3y69mFi7KN0EPg=;
        b=uADzHDM5DR03XMujeQymI1c+BzzsLzihX/0biqeI8AMQkzREic0BvffY0NsTAPS3Bq
         zvQuVR6YaJhUbAQdCTB5MraQFRJ3sy5Zuw0IsRUgeOLu+H33msDjfaAdiWaC7Z2XTDH4
         f2Zd10zqwcQ3plPFSAStKQqzFp0YN2hvvI4s2TbTVFHRvCJ3g1OkpTPRWUUADLiHTElQ
         BjpyPWQ9ZmGQJEO4P/+INZHykcoy+RUH5uVnf8wCfyoHB0bpEreovFGqNO+06Gc6UdJV
         SU27pU5iqOmX+Buk7IGl5xVcJdTKW5Ji/OlFHsXgFZkQer96i1Flm33oflLlu6J2NyQm
         KCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PE0en2UU/eeKZFa7xUSQ62ylm6WHJ3y69mFi7KN0EPg=;
        b=Wjy0qwMVML6b2pNmnRAbXyhTbBx1bnmyyvEkxNZmF5nQyPN7Q2Ha9niNsSTmlJl1G8
         ytTlTlsvaHa5c6dwb4KuFNUJ+JYrjfIrT1xKsXmVqsnJfO010KkRN9MTB/Kov9yInZuE
         whZhjDi0Ka2e/j+899OC+1G4mQ4XhRHMT7gNM3Y7KednoGyxPyuLCD/Sv4S3nRNOE7SX
         /mDI3zXinRrPS07Sh0j8Ebuvw1dQ+WmCQBnVytkidgnHa8DPWHmi8Zewm8hYrDVPd0K3
         2Jymn6+hgrii6Cew3F961nTLsFYfDftdP2dyN/tt7yoc1hqa0qldPqg2yvne76Conv64
         Cgmg==
X-Gm-Message-State: ANoB5pmLqLdaCgPyO7XWo70fMIgZEpedVZZwxCW1Zrn0HAYdHU5sp5UM
        DrsPsftLj/8RsbhMz4PSPasLbEuzzAIxG6PJjzBepQ==
X-Google-Smtp-Source: AA0mqf77QesybuE18xXTPg3wskSZ2lQyQwKjS6zkTW/qBKF6LV649yNe5WB5DZIBCDzwFDDgIkrLoLS1ItFPXqyVwLg=
X-Received: by 2002:a05:6512:693:b0:4b5:5384:aa3c with SMTP id
 t19-20020a056512069300b004b55384aa3cmr8929723lfe.150.1670687838196; Sat, 10
 Dec 2022 07:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20221208201401.530555-1-konrad.dybcio@linaro.org> <20221208201401.530555-4-konrad.dybcio@linaro.org>
In-Reply-To: <20221208201401.530555-4-konrad.dybcio@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sat, 10 Dec 2022 21:27:06 +0530
Message-ID: <CAH=2NtxYBbdR-rb6ZrqK+hW9gLuv_o80aOFUoEp7dqouON3x7A@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: arm: qcom: Add SM6115(P) and Lenovo Tab P11
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        patches@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>, devicetree@vger.kernel.org,
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

On Fri, 9 Dec 2022 at 01:44, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Document SM6115P, an APQ version of SM6115, which in turn is more or
> less a beefier version of SM4250.

Let's drop the 2nd part of the above statement. As we discussed on
irc, It suffices to say that SM6115P is the APQ version of SM6115.

I don't think that would require a respin. Maybe the commit message
can be fixed while applying this.

> Document Lenovo Tab P11 (J606F) as a SM6115P device.
>
> Add SM6115 to the msm-id list of shame.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 27063a045bd0..0c7ad00586fa 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -62,6 +62,7 @@ description: |
>          sdx65
>          sm4250
>          sm6115
> +        sm6115p
>          sm6125
>          sm6350
>          sm6375
> @@ -790,6 +791,12 @@ properties:
>                - oneplus,billie2
>            - const: qcom,sm4250
>
> +      - items:
> +          - enum:
> +              - lenovo,j606f
> +          - const: qcom,sm6115p
> +          - const: qcom,sm6115
> +
>        - items:
>            - enum:
>                - sony,pdx201
> @@ -931,6 +938,7 @@ allOf:
>                - qcom,sdm845
>                - qcom,sdx55
>                - qcom,sdx65
> +              - qcom,sm6115
>                - qcom,sm6125
>                - qcom,sm6350
>                - qcom,sm7225
> --
> 2.38.1

Otherwise:
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
