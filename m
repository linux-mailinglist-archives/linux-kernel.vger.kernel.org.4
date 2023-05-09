Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DB46FC38C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjEIKKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjEIKK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:10:29 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378FA4499
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:10:28 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-55a5a830238so51559747b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683627028; x=1686219028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xFX4OXORNCMFM1k+V44X+v1G8lRpre4V5obhbQUsfME=;
        b=lAbb7gaAtspJI33WC5SDYV15HP//2x1Vp0Jtn7t+fX8QLOnJ/9g3cz3ZrtDu7Pbuk8
         7Kz7JGExkrska4lXRhvEyIpVHszGOroZCeqiYPeiO0mpgM34u7cF6PC5AKgBoRJhtgZn
         akFrGRFQ3KNQZrEKcEh0co4etZyNcQX4iWkCBTEKK9a0BcHF9pcy89dEK3Sw7QtOahC7
         nTyTXDUi376JKVFGq1/iaqoVHkFO2M3xT8fRHsUoLj1pSwSeJLtZfbp3Jk1wOh5wn50k
         r/3/bhQKtn5KZlrQ09Q5RRB1OG0hn5y/HqTCqx5btQdO220HKutPQLGZD9r9xXV9WaAN
         G8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683627028; x=1686219028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFX4OXORNCMFM1k+V44X+v1G8lRpre4V5obhbQUsfME=;
        b=So4AHLI5qcoPD1Poj2Mj8o/zs37eJf07xtjZGgBb1zpzkglhYQIbl0mYu6tPRpZWDv
         zSoQVowpY9LopF4/1FsxQsgplPpRHwu1LZvwnG2hiNHhlze5Nr3wFb6BWPS9wnmjS8u7
         jICNjSCVp9+ENKxmiJ6NnosXQnlr1Fagr0ScRxELsrEpDHx3v0LZ6HILmb9Ht1aN2u4w
         VecZw5UvESaT94B2kmZrogRFSjqjdfc2umZwTGYxatOESTay7D40YdpVJCnweMOUIOOE
         6PPR8uXz5SjPbkmP/LSBO5v0Im8LRE7hB0zh+m4kbn7ZJAVrFzqE9JWoAgZ7VFMVU3bq
         zJ8A==
X-Gm-Message-State: AC+VfDwRXyVLIjvGfj76uDF5jbROvp8EtDFTIaH/NFKlPZU0288Oh+Pq
        Nexm8De5L9mvoHWvupCXPIq1nr25/iWXwBIlldv3DQ==
X-Google-Smtp-Source: ACHHUZ6+Gii22lckyzjd/xIzgrh6OAFuQzx5+2BclyAMT9ff3k1J+DyQFGBoZ1rB4vXHqtyKuXzjqw74KtHZXPT4Jxc=
X-Received: by 2002:a0d:ea55:0:b0:55a:1cd9:153d with SMTP id
 t82-20020a0dea55000000b0055a1cd9153dmr13586766ywe.29.1683627027827; Tue, 09
 May 2023 03:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <1682338412-15420-1-git-send-email-mantas@8devices.com> <1682338412-15420-2-git-send-email-mantas@8devices.com>
In-Reply-To: <1682338412-15420-2-git-send-email-mantas@8devices.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 May 2023 12:09:52 +0200
Message-ID: <CAPDyKFqeahcutHoOMgiaV0eWFX8Aex1HHH-aGRzMbKoQpwC=hA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: mmc: sdhci-msm: add IPQ6018 compatible
To:     Mantas Pucka <mantas@8devices.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Anusha Canchi Ramachandra Rao <anusharao@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 at 14:14, Mantas Pucka <mantas@8devices.com> wrote:
>
> IPQ6018 has a sdhci-msm compatible MMC controller. Add the appropriate
> compatible to the documentation.
>
> Signed-off-by: Mantas Pucka <mantas@8devices.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 4f2d9e8127dd..5ad846b724f3 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -36,6 +36,7 @@ properties:
>            - enum:
>                - qcom,ipq5018-sdhci
>                - qcom,ipq5332-sdhci
> +              - qcom,ipq6018-sdhci
>                - qcom,ipq9574-sdhci
>                - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
> --
> 2.7.4
>
