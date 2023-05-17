Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2737069C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjEQNZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjEQNZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:25:21 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B73F186
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:25:20 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba878d5e75fso409494276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684329919; x=1686921919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=56WYJd+UeeU7i62VxA/IS8NmNCK4vEs9qF6l/gJW2W0=;
        b=u5FUEWzjeugV7v6tHEPQYTfndWOxc39ugSX+Zm9nHrYWJDhqP2vynJLBeSXGI9uilT
         +DzKFZ0YNSFqFMMv1bjuFRYCZK41rL0ikhKVYmX2lPC0X7ySmQ0DsynYPWMcd8u8pY/b
         06rm91EwNWSBug4evR39ErPQR4psvDdu3oRTIxT3i2yOiWbLJzheSku1G5Bf5O6+e3pi
         PYVs2luUIKS7U5tTEu4578GUfuir7HuuTqwO7ca05yQgXC1Qy6gsF1HRa8xZ9nbptulx
         l1swE1J15TKosVSRjjY65zyMkcn+lJNhvq4YarKzIqO9nHkDwz0LQY1bRgv0yioBJhsP
         RTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684329919; x=1686921919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56WYJd+UeeU7i62VxA/IS8NmNCK4vEs9qF6l/gJW2W0=;
        b=YNwtq7tT4YzBsZnPltOeOeHXiTAxqoLzwAps1xKSWzKgbK7+1agUwbr26Vrcs8aD2g
         HGBkBJRXE+1Amyzlqd4JwO0FzeDwIGztRNnWuP36J5vOhZayZI+XS8GCKO7/chsUbsKQ
         Cf9x824BiXb8t7s79jJN96EkL6ybpjYfKsPlafur39B5J/19Qm+J9+m20Izym8qU3gTy
         UX02/dn6fUlOnO3GmJE0UJhwgj/YkIsgazaGVP9vDTpKQp9mc2OzHLPlRlYfAUE5dSMZ
         SM+dZPSB8dNSaRZd3MXwXs0aW7j+TtzomMC8POzeGbDTI5PRUnH2oDJFrjC8niIQMvm4
         tUpg==
X-Gm-Message-State: AC+VfDz+7w6bLWcsHDBeLjutPMlIG4Bp4e+Jd9TiQ7mBIAhNKUBvBn4e
        YLtOqMtsZ865nl9NDKTzup2Q/Vhl840HEhjIj0yoEQ==
X-Google-Smtp-Source: ACHHUZ4K0ZuvOKahfJsmfrC1f7f2t3iU5bXvHcn/huKaqBjiMU4xctXDaiZH+dqpjY0LIKaiLNYwdOCIct7qnRZDq9o=
X-Received: by 2002:a25:e743:0:b0:ba8:15a3:f2e4 with SMTP id
 e64-20020a25e743000000b00ba815a3f2e4mr5001987ybh.0.1684329919315; Wed, 17 May
 2023 06:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230517-topic-kailua-rpmhpd-v1-0-cd3013d051a6@linaro.org> <20230517-topic-kailua-rpmhpd-v1-3-cd3013d051a6@linaro.org>
In-Reply-To: <20230517-topic-kailua-rpmhpd-v1-3-cd3013d051a6@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 17 May 2023 16:25:07 +0300
Message-ID: <CAA8EJppaZSXeRP661g65WtadZAuJo1T8=Yk8AfX6n4Jg04BvZA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8550: Add missing RPMhPD OPP levels
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, 17 May 2023 at 16:20, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> We need more granularity for things like the GPU. Add the missing levels.
>
> This unfortunately requires some re-indexing, resulting in an ugly diff.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 6e9bad8f6f33..0c987dd4e4e5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -3616,35 +3616,55 @@ rpmhpd_opp_min_svs: opp2 {
>                                                 opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
>                                         };
>
> -                                       rpmhpd_opp_low_svs: opp3 {
> +                                       rpmhpd_opp_lov_svs_d2: opp3 {
> +                                               opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
> +                                       };
>

Maybe we should stop using the indices for OPP entries and switch to
encoding levels instead?

-- 
With best wishes
Dmitry
