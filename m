Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A425A62C3E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiKPQSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiKPQSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:18:16 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8333A56EEC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:18:15 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 4so16912109pli.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lor3rulwbXv5cvKmMp9W8Gkpke6RAbR94pio1OJ5+w=;
        b=Ztv59t+sdJ8FDfj0AqsB1lXlLXAtn8P7awrZ7yCvTLOkTg0lsq+Ek2oma5rc554bNg
         x4GrCoZdi3HhPQW5u0gbcggxJlB65GP2LPJZHAA7oFXHE5BIkss6BlVwRC/ryCuAeITY
         FIxSccjwIKCeOW139gY1Yc4PKCVA5mHIYwlDDxDnVcvxnnQcPR5kjt4JyvXQ2MXhOlAV
         ZOsI6d/v8BOukvO/Hgoy6ZyoCTjzjW9ATKpea4JcPTxtX+rFYWpliefucNAzuuALx5yM
         a4czvMF88oyT5jpfc7hjmjNAlYhYnPFMUOf+JrdVsfgfzInYGG40QKA5iFrEq/MmzBD+
         ftiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lor3rulwbXv5cvKmMp9W8Gkpke6RAbR94pio1OJ5+w=;
        b=iUj7tIUrme+1+wnokTMg4VZfzvEWt08DZBFan4ezyB56E7Hx0fu1QiZuf8Huyz04I7
         Kdm6YkmbbqC6OSZruauis1e5OZzqWVpBq2ELbsWLEREdsJYDHO8fJmBL2YnC9VzOagxH
         XCePFiJaTYKsPRdWO1T7K+qyHAyUbAAWR00MZIKciamhGE6Zav3KD8qp0E8ETCshrgqW
         GvflhTMmkUkErGXQTWEeZh6PLUOpJDb0ffyWUmRsA7zKPU0w+kCi2jv9Nuo/UdfQy8cg
         MIIFDz32XkGkBcD9ewjngVW3htXf3ZKJ94G5XXG7diwjtGShOWYHbtbnoxW0yqYelCea
         sC0Q==
X-Gm-Message-State: ANoB5pmutJmCCcp9mfGMPnF9KE1hopf8X9mu58pbmtRgjvx5xw3zGEfV
        50tqPbxEFZlQquuD1aw6hQmVQVFIkIEH6dduCnDrFw==
X-Google-Smtp-Source: AA0mqf6BBuCK/2Uwy7g0M6z08aNUdokEWMht3+/108Ulon6FcDnZllT4TN9FRoe6hk47Scp5HBb3W1Myuqkmr4XZKnM=
X-Received: by 2002:a17:902:d386:b0:188:cca8:df29 with SMTP id
 e6-20020a170902d38600b00188cca8df29mr9787748pld.148.1668615495048; Wed, 16
 Nov 2022 08:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20221114-narmstrong-sm8550-upstream-sdhci-v1-0-797864a30e71@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-sdhci-v1-0-797864a30e71@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 17:17:37 +0100
Message-ID: <CAPDyKFqKvpMYBqySP=jo_5ZFmcqh6mNQbXTXxjz9fDkfC966cw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: Document the SM8550 compatible
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
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

On Wed, 16 Nov 2022 at 11:15, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> From: Abel Vesa <abel.vesa@linaro.org>
>
> Document the compatible for SDHCI on SM8550.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> To: Ulf Hansson <ulf.hansson@linaro.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index fc8a6b345d97..f0b7e6d0ecbf 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -49,6 +49,7 @@ properties:
>                - qcom,sm8150-sdhci
>                - qcom,sm8250-sdhci
>                - qcom,sm8450-sdhci
> +              - qcom,sm8550-sdhci
>            - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
>
>    reg:
>
> ---
> base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
> change-id: 20221114-narmstrong-sm8550-upstream-sdhci-1ae5ac4924e5
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
