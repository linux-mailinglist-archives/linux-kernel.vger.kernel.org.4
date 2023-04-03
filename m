Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ACE6D3D2A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDCGPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDCGP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:15:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED526A56
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 23:15:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t4so22817217wra.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 23:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680502526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OYr1/KuS7kMHwn46ltI5HEmCt5k4aJgWKClGbWF133s=;
        b=NTT03Lm8sZsH76eTG3jdAAaurDzfPUGB/iUpyvrJJCgS/iHAOeP0mrd1UJgq2TUEf4
         PHikextz4mHfKRXGZ4176flEtQA/gWpe9qSMGNQywQtYGkfXzsQxACYuZL2EPyY1WuLH
         zfgdDB7IP0Cq5JaR/05zHCo8WFZZANccGr8a3VV3/ATQhd2bPMp2PGSd3VuyW3TytX/9
         SsoAXEjVr4cLrtTZfufguHJhwRPZxbI4dOyUo11D3Sp2U35r1NGH4GBoT5loZVl4ey+j
         QwbzVdgsaj55u3lJQXWm+Nlm9GErX/1dT51kDE6G5ziC++k4jRAkazihgt5lJheHXYgP
         H1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680502526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYr1/KuS7kMHwn46ltI5HEmCt5k4aJgWKClGbWF133s=;
        b=mbNXfP/x30x2yLFpkf1p9niMsR2/WkaJZFDzFXuVx6tZKSHVmOWpEb7PgOnqhqcjII
         lRL7mFkrYkgl2oJpc2dvM97bqJn+Xsk1DneiBZ1Wnqd7xK5LEn6EnDpVB5oI3BdjaTrH
         ubG8Z+Scyz9luBkUzMAJbAQAlAgub0ZuQLNWIx3PiMhP7Ida6PpOrLb7eg67jgjlSxhf
         R9rGfVIoJX6Yp/BRduQH5MV/Wl8IxPYPxrcQnssUZ0903vWnxOQ0alus/lm0xy7IUV9m
         mNiGEPEuFHF0arx+bqzLsDfOfrcyVYluP7PX92avdP/XjeeTxYe29kC9m/59M+TKjzpA
         82pA==
X-Gm-Message-State: AAQBX9c+6+q4FUUB+gjR45i663hRe4YdDiP/am1l5PGB6yzKGWXiam0w
        O/7faK+jsUdtTWqi9rXgYlH4CeWKVc/lsv0SAL5K6ssCJE+/Fpc+
X-Google-Smtp-Source: AKy350acf1mfzrEPgp1c2mLaWyYaPeg8MW/g55MD0k5rk9VLpt+743GauRSVo2/m6TW4qS0GzGWVj+lSeid5yNUguIM=
X-Received: by 2002:a05:6000:5c1:b0:2d7:9771:fc4b with SMTP id
 bh1-20020a05600005c100b002d79771fc4bmr4955083wrb.5.1680502526512; Sun, 02 Apr
 2023 23:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230402100509.1154220-1-bhupesh.sharma@linaro.org>
 <20230402100509.1154220-6-bhupesh.sharma@linaro.org> <21eaeea4-4f2e-5ce5-c75b-d74ded8e6e4c@linaro.org>
In-Reply-To: <21eaeea4-4f2e-5ce5-c75b-d74ded8e6e4c@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 3 Apr 2023 11:45:05 +0530
Message-ID: <CAH=2NtzKGxzmCq2JTajxWoeRFR+mPnFY3YF5mn0tGt30T7SJoQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] dt-bindings: qcom-qce: Fix compatible
 combinations for SM8150 and IPQ4019 SoCs
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, rfoss@kernel.org,
        neil.armstrong@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 11:06, Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> On 4/2/23 13:05, Bhupesh Sharma wrote:
> > Currently the compatible list available in 'qce' dt-bindings does not
> > support SM8150 and IPQ4019 SoCs directly which may lead to potential
> > 'dtbs_check' error(s).
> >
> > Fix the same.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> > index e375bd981300..90ddf98a6df9 100644
> > --- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> > +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> > @@ -24,6 +24,12 @@ properties:
> >           deprecated: true
> >           description: Kept only for ABI backward compatibility
> >
> > +      - items:
> > +          - enum:
> > +              - qcom,ipq4019-qce
> > +              - qcom,sm8150-qce
> > +          - const: qcom,qce
> > +
> >         - items:
> >             - enum:
> >                 - qcom,ipq6018-qce
>
> Two commit tags given for v2 are missing.

Cannot get your comment. Please be more descriptive.

Thanks,
Bhupesh
