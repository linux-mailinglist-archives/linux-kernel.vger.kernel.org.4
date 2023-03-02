Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4974D6A8645
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCBQXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjCBQXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:23:49 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28ED43905
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:23:48 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id i6so4092082ybu.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 08:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jAXUc+7igsVtJKU/EXqB4y9E7c4M7owmalEpng7fGGs=;
        b=t6gIv8PG8O2JCb4Pja+OY1bAmy+QfmXrfFtERdyeosrITN34js2EPockt2g180hHYL
         pWe1W6HXqOiwIu3072C5tKjIbRE/MQ1j7xJ4TsJHFq1YK0c/PGV8NNn2Gdb8F/kPyiKB
         DZPNzj0Hy2QWF9GyHk814k/ytH4LbE+co0vOT3J8Aywg0nPGBBqJTU62HPyJmSQbwyGH
         d0IfJXkkx/0sg4YTUmf3FaAYlryUzM+3+GqTUBgISA5CljcZCwHVbDNbJ2/pdkGjb/94
         UVsGjY2qnEbneGUKY/ru2PhJ7HCHT0cbF61rjlWtfTDEbd6FobedpulmtiwrsvBjVhPf
         PcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAXUc+7igsVtJKU/EXqB4y9E7c4M7owmalEpng7fGGs=;
        b=Ro1QdcEVwcnd7GqbFor1w50VcTX1GNgI2ZQh2oPQTcyKNbMp4cRqinQam5ysT682tD
         Foha7M7kqW9q1yIjVGo14giEcQrKqtYC2GQcgUD1c3Y8ckU9QOF1FP+/zOtcST1DuEKP
         571AWdCLE3LogH7llYePB9+zUQxxW13yRKNzo0TWukIi8d56vp7Ta1EgaqtVzaR+a+SB
         BW357pAW2zLLC0Ka+KQ2QAHvVEt1rV6rQIf2VwHlY5aANLrtMBMIsJO+4Lf2ZFWRC/YL
         72HhNImb0QM9tEtne8+cjqgbdCO3HZLYFuYHK0nYuSjyp5LIx7RHQz8MwcpMetB0CDnH
         OupQ==
X-Gm-Message-State: AO0yUKXhLTt7C0OV0WoH1372FG6ubj7h/KshoRQMI9oXMePbWoNNOrYE
        tTAFBJL9pT9JOY6vNNvJTWFv8o5jugHDj980uTv9bg==
X-Google-Smtp-Source: AK7set+RUYz2RLJUmCKAuN80E5C6LRyBdQu+UgKzzLI5prKcrosXVpbyJaqYOEnoLm71zPuAGfkUyepJH8UuFtbQ+Cg=
X-Received: by 2002:a25:9983:0:b0:9f2:a18c:90ed with SMTP id
 p3-20020a259983000000b009f2a18c90edmr4846033ybo.10.1677774227956; Thu, 02 Mar
 2023 08:23:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677749625.git.quic_varada@quicinc.com> <70beab86eb21d1130e61f52753f514cfb433a4f2.1677749625.git.quic_varada@quicinc.com>
In-Reply-To: <70beab86eb21d1130e61f52753f514cfb433a4f2.1677749625.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Mar 2023 18:23:37 +0200
Message-ID: <CAA8EJpq_B_f90W6ULk1q+ot8ACj68U0M8Yc8yXL-BGuF906xGA@mail.gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: phy: qcom,qusb2: Document IPQ9574 compatible
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 2 Mar 2023 at 11:56, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Document the compatible string used for the qusb2 phy in IPQ9574.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> index 7f403e7..c426f78 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> @@ -25,6 +25,7 @@ properties:
>                - qcom,qcm2290-qusb2-phy
>                - qcom,sdm660-qusb2-phy
>                - qcom,ipq6018-qusb2-phy

Please movef ipq6018 to the proper place and then put ipq9574 next to it.

> +              - qcom,ipq9574-qusb2-phy
>                - qcom,sm4250-qusb2-phy
>                - qcom,sm6115-qusb2-phy
>        - items:
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
