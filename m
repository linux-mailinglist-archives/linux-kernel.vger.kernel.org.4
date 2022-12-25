Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D578655D79
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 16:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiLYPWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 10:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiLYPWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 10:22:31 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC80EB4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 07:22:30 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id i186so9785137ybc.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 07:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8WmDuyEin4ScYnmC+lNB1owHSAbWHBebERHlafOd3xc=;
        b=yBq+7CPxfDo2NtI3KWiXL4qcbBBT7Ov9ctnWG1nX+G8awtDuUrGDgsH8k2mdlDGBU3
         +V0jrU6KU1TNJPeI9/pXqy1Y//RTRtfm2jRr6c7VnjqEj/3kNpC6PFpRhyG0PEtFveW5
         FCUPYKE2bkaJ/1nbINvVtu2DkiJnx9UmGCwb/jKZmDkTo3WlKqYRcTQhh5AarMS2OAdF
         o757v0BHWx7bmgT37YGloaCbLqh/Q5HzE2b3Kmtig/dk4DhbSKgUnYcOBzG72kJPgljV
         xX20xU1Nj3UsKHFrJzAdDTKdVS0z6nP3vujfpyoh7omzfHYu3E9YuXT90s6QphNFZBQw
         l6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WmDuyEin4ScYnmC+lNB1owHSAbWHBebERHlafOd3xc=;
        b=Ehf16t9sm2O1+1oFg9HD2pPv+mk14f4Pn4OiNaSRN+YuwCOB1O0H7T3Af3oCcwu54J
         jlqACZnkAmFXMU9rAddnYaK5efUdZUWh8c/8mS8ijAfl+92qQNlrSwMwX5W7lnT1CPJA
         rLRXi0MTU0IKRx74k8cTFpwlgxyo7f6LKmAc5dGRoopz0jCNv97lZmJAI9zcq4H9F0nH
         fvBvQwK4/Zx4w6uVRHS+Qz/QMLiYS1dMC3xIVTbms41iJimk1hG+i2FmNiC5bkv1ZKij
         3dpgWagqPxjWePtY/lwPahCIp8JjmMatmBiIVQ/m2dBiBRJFYJIgva9sBKQX/8aGKdf7
         USdg==
X-Gm-Message-State: AFqh2kprWq4uPwy3oZ3SRC4MMO5RapeQkidSJVPeKfBr+DX4B+Xo12FO
        GBedKy7FVFyegjdjGqwXIZXGmISzm2MA4PhFO6ZlWA==
X-Google-Smtp-Source: AMrXdXvQfc2UCtoj2Y57s+xggmdVLu/spxAmnSAHgcPCsIoMPW01vEb0Wxbtnd3Y8srrNDrARaOF5EWjyRxxl5/OaIA=
X-Received: by 2002:a25:c404:0:b0:757:591e:cee3 with SMTP id
 u4-20020a25c404000000b00757591ecee3mr1779065ybf.15.1671981749308; Sun, 25 Dec
 2022 07:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20221225040821.8395-1-steev@kali.org>
In-Reply-To: <20221225040821.8395-1-steev@kali.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 25 Dec 2022 17:22:18 +0200
Message-ID: <CAA8EJpqD6pvZjXa4_cQ=02o_Ns94LAJ3n-S2Q8LjfqOySgHHfA@mail.gmail.com>
Subject: Re: [PATCH 26/26] arm64: dts: qcom: c630: set venus firmware name
To:     Steev Klimaszewski <steev@kali.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Dec 2022 at 06:08, Steev Klimaszewski <steev@kali.org> wrote:
>
> The Lenovo Yoga C630 can't use the generic venus firmware that is in the
> linux-firmware repository, and needs a signed one.  This file is
> qcvss850.mbn from the Windows partition and needs to be copied manually.
>
> Signed-off-by: Steev Klimaszewski <steev@kali.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index 7e80e2950f8d..78a14f899df9 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -801,6 +801,7 @@ &usb_2_qmpphy {
>  };
>
>  &venus {
> +       firmware-name = "qcom/venus-5.2/qcvss850.mbn";

Please follow the established convention (see e.g. the x13s laptop firmware).
It should be "qcom/sdm850/LENOVO/81JL/qcvss850.mbn" (or
qcom/sdm845/LENOVO/....).

>         status = "okay";
>  };
>
> --
> 2.35.1
>


-- 
With best wishes
Dmitry
