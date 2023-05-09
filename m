Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E47E6FC399
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjEIKLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbjEIKLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:11:01 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27C4E73F
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:10:49 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so29550127276.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 03:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683627049; x=1686219049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GmF5E4GwcpLNkAgFsD7lRny9B93aWleCGkhGsdB1ego=;
        b=yg5TJ6sB8ZbVrIIpZQw1kHwwdFrnazcBTppzqdhqfJ7F2Oz0aXRfzg2X9bl+tNV+gg
         xSU0UUUIdbmvDYp8Un944/jabV4hkov7zKEcI2AmRkfcUjfx/fdQsUa3E57D9TqHyhcJ
         dWUqBsQ6FkfFyM1CHqhfWvRl3s3d0pAT6Ihvj8OmkVBp5m5/H9DXAKCGtu01CWvBye9g
         /2r3+/dtqJKs1FOxC9CPlZmxu3CjRWdhsF6ON5+Zzf3s2c6Z+jpNWuDQb62NU7fEi8nN
         Pa1ZdlWeYE11/Oym6MXW78a0ztgIJOa0lMfQoGTbLkre04Va1B7RtrYZm02oeP7zs+d6
         XH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683627049; x=1686219049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmF5E4GwcpLNkAgFsD7lRny9B93aWleCGkhGsdB1ego=;
        b=KWtejb3jYANGNAHy5iFEjBgdhWLsZ9pK6SNQLQ20q9A3dyr5uJ98mXnVXfXig84Edp
         3RghXmjkjlr6DgyJ5NUjEq+ekv9C4feXb/Qy1YnF0PH1VyJxLB+BrGBm8HtpjAFOZs+C
         uOwlRS3SjkJBQqMDIsAdMnjcHdJQCNfyfSFyy45e4ODb0w37YQCwokdO+DwrwtJobRXY
         s3GVicG1SWXqfgsr62BbCvGn5ooy+5xeP5F4jGrgAes6fDiZCdHM1RKGRfB3RrjOWGA6
         FCqjf3FgxZjZ3bhOrnSCA/M7h+zVmMS5T4rInHdZtTg9T1P47BYhPruNyeel9SEJEFQ+
         YF5w==
X-Gm-Message-State: AC+VfDzbhjvfr3wMMvFg3HL0g6IeQVtfni/QJT00rUscMYCxcjr+MHNa
        APPfklEBE1Jw+bHrc3SuHQw256Et1BZ2w1IG+UNbqQ==
X-Google-Smtp-Source: ACHHUZ4e8hYq/oZyt0twtsz8waBTWW5anwKtRtrOOkfZgkVQ16iIHKeOMHTrrO8K3irIVzouT3FtQ9ngGu89UoRjhZ8=
X-Received: by 2002:a81:4949:0:b0:55d:811f:6003 with SMTP id
 w70-20020a814949000000b0055d811f6003mr13268809ywa.14.1683627048063; Tue, 09
 May 2023 03:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030136.1524860-1-quic_bjorande@quicinc.com>
In-Reply-To: <20230509030136.1524860-1-quic_bjorande@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 May 2023 12:10:07 +0200
Message-ID: <CAPDyKFpRg-qLfLcqq73+CeaA4VVfZEgq2z7iCa6Vj0k+ZwgV+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Document SC8280XP SDHCI
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 at 05:01, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> Add compatible for the SDHCI block found in SC8280XP.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 4f2d9e8127dd..9a87c03937c7 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -41,6 +41,7 @@ properties:
>                - qcom,qcs404-sdhci
>                - qcom,sc7180-sdhci
>                - qcom,sc7280-sdhci
> +              - qcom,sc8280xp-sdhci
>                - qcom,sdm630-sdhci
>                - qcom,sdm670-sdhci
>                - qcom,sdm845-sdhci
> --
> 2.25.1
>
