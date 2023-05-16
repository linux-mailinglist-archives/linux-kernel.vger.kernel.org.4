Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97DF704A13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjEPKID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjEPKH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:07:57 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587A0E7A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:07:55 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-44ffef66dabso8004091e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684231674; x=1686823674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf1n0pD+n5MYVam+kfSL7HSK5MrACb9JW8pF1eQ2LGo=;
        b=aR3e0MslIm56+9BVhw/O42CM0v7nBYlMQn8YxDa+8IHb2GwMiTb2FzShi9VDKR9w3I
         H8DV4w4Q723mYdY9W7YICfhfwPjPgAx0v/pNEPJuQmltD2Pben9lDerEL2xu0AU5QHSR
         Cuzo5gVD8RPDLQZoRuNI8EIEmwPZfkAgkDQMOy471NIAmeL/QIoo9Wuesfy7XNpGuPBf
         EAmVLdEN1/oKPwbeXczcJ9/ukGbQ2U6oM9mVBad40pV7HcFTwj8Ks+yvetHaxqYDaIX2
         qsenxZPdXT1wbjs0sae9HaBcwOljRmrOJTyd8xckw3ycdzx/eIjGfGa07uQ+DIe1k3/a
         KYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684231674; x=1686823674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pf1n0pD+n5MYVam+kfSL7HSK5MrACb9JW8pF1eQ2LGo=;
        b=fDOKD3hpVxnw0IxL4IhPlY9JI7lHUOj+e7/SnkT3h0K4JbFJ+K7eII2IIfk/nqfp5E
         hCEHas0Pm4Z32EEy25INBUZZFqwRZHadE+6w6VBKGRZLezqW2NI7Y3RlilfsX1KV3Mk6
         vjXi14qjCIX1muaPpvYo7Bi5DzTK4WBaCB5sIcrbKcWiYxEGHbXqiIUzUjQZ4mCwySWV
         zor3cxWfxAJiBw5QRvFVgxl73cbJDM8THtZ8pxEP572EmLJjTglTWFoDZPJKslyyj42s
         CESUIQECkstGVhELY2winhL9ovnAJ+72PhkCxhYoWh5yjr7BJCBqEOe74FUmedPuz0wQ
         jQ6g==
X-Gm-Message-State: AC+VfDyvWsrGjRgDDzlE+lIC6iC+ySwc64Q3H+KihJU8866JmF8Byd1W
        b2wJWirkutaKPtPMNFAlJPQHRe7Adb92ZfMl94jPwA==
X-Google-Smtp-Source: ACHHUZ62QV9pMpzCO0AROQEprP4TH6H8ax3OjCq3ta/uh7Pbk1SUR74lHaEb7zlSIjedrPSgk33a48qsw/2iZaC/zaM=
X-Received: by 2002:a1f:e601:0:b0:44f:d211:2df3 with SMTP id
 d1-20020a1fe601000000b0044fd2112df3mr13694504vkh.13.1684231674434; Tue, 16
 May 2023 03:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230417125844.400782-1-brgl@bgdev.pl> <20230417125844.400782-5-brgl@bgdev.pl>
In-Reply-To: <20230417125844.400782-5-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 16 May 2023 12:07:43 +0200
Message-ID: <CAMRc=MeWEs7AoZSNWS9bZO=_12U5944VBq0ixrY2rx2h2=OOfw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p Adreno SMMU
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 2:58=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The GPU SMMU will require the clocks property to be set so put the
> relevant compatible into the adreno if-then block.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Docu=
mentation/devicetree/bindings/iommu/arm,smmu.yaml
> index ba677d401e24..53bed0160be8 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -79,6 +79,7 @@ properties:
>        - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "=
arm,mmu-500"
>          items:
>            - enum:
> +              - qcom,sa8775p-smmu-500
>                - qcom,sc7280-smmu-500
>                - qcom,sm6115-smmu-500
>                - qcom,sm6125-smmu-500
> @@ -331,7 +332,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: qcom,sc7280-smmu-500
> +            enum:
> +              - qcom,sa8775p-smmu-500
> +              - qcom,sc7280-smmu-500
>      then:
>        properties:
>          clock-names:
> @@ -413,7 +416,6 @@ allOf:
>                - nvidia,smmu-500
>                - qcom,qcm2290-smmu-500
>                - qcom,qdu1000-smmu-500
> -              - qcom,sa8775p-smmu-500
>                - qcom,sc7180-smmu-500
>                - qcom,sc8180x-smmu-500
>                - qcom,sc8280xp-smmu-500
> --
> 2.37.2
>

Gentle ping for a review and a pick up. The DT patches that use this
schema are in next now so check_dtbs will now fail.

Bart
