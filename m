Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722FF6C67BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCWMN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCWMNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:13:24 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2AD17CD3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:13:22 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-544b959a971so357201977b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SqdMrjKZcesKvWGpxbhVUZrrqQQyPMex40BfwsH73Mw=;
        b=Rbzcb8b7uVMxju+D5/CxadWh3a4xL7OqSbqLhReppWwhkppJlcfHxcnh9BlnKiZfZW
         kyM+9BiJgNJPNf65xkcxZIBBxRfrM22SrXS9+o6knJMsVn8APlD4Ji1hCIfKZ895Pjzc
         O48YHqN4bBbD+hMvGntKwHwErfp2hsU1Zrn7SaP4mtaiWQufleIR/BjvAbYzOh41KtuB
         YzJjvnJL2i3/SgYs4ewF90MXW+E+DmcMNzE+B/wJ7tnB5hnOxTRIQ5bgN0Nu2GwMbgH6
         +5MsVhZmDm172Ij1nsdyzZg8yezeQOnRc/vNBVk8G/9D3KUED7wtPMHiYMI+JyJ/tyvN
         gRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqdMrjKZcesKvWGpxbhVUZrrqQQyPMex40BfwsH73Mw=;
        b=YNY0hERLB36fJ3xfQILr873mZx7gM8d4GezZrcAuaKGN9gz8FwNcwpnyxhDygHTgMe
         cfOT3Xvk0lFrvBwLJvKwBjEFrGF088I5BNoM4N/Csb1G5RXI8zQeeTJDWuMUDSwVvYcW
         11NkqxtqOudFkdoBfxN2TkrNT17NzXGWCQz4qf+4gu5+Syr5x61AB+koLoPI0tfEaJtu
         FpVL0CANPYU/FxeoJrVaGQK10yIu/PPHtvoxIJ6N8DrPaJzPHWTaqVnHwQ3SNz08g+kI
         t/A7w3dCK6uepmetH6YBYH/gjIauZ/OGX26uD7CDWL+VPM+H4YpIupbnTffSvvXQuUhD
         cVBA==
X-Gm-Message-State: AAQBX9efDBiERd+NcXCDDh3IHPkRnRH2feokduii/wv2ZiRRYZ1xy8JJ
        nIEVuROT+M8BB5vSgnEMATHmNIUx2MFUR4SQTjGhEA==
X-Google-Smtp-Source: AKy350ZLDXTgQmOwqbA0MAoLnKfUlTQWcUqEZLD9LuaUs8JbjfgJ8cUjE7ItSFrSS/I/z3l5JjKrz5bLJY0UbOHEDsI=
X-Received: by 2002:a81:b342:0:b0:52b:fd10:4809 with SMTP id
 r63-20020a81b342000000b0052bfd104809mr1792507ywh.0.1679573601803; Thu, 23 Mar
 2023 05:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org> <20230314-topic-2290_compats-v1-4-47e26c3c0365@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-4-47e26c3c0365@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:12:45 +0100
Message-ID: <CAPDyKFrW_bENzuAWqt+aTBHBV1gNOycNoPUHWM32C_U5Pz22zw@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: mmc: sdhci-msm: Document QCM2290 SDHCI
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 at 13:53, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Document the SDHCI on QCM2290.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 64df6919abaf..7d4c5ca25e0d 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -36,6 +36,7 @@ properties:
>            - enum:
>                - qcom,ipq5332-sdhci
>                - qcom,ipq9574-sdhci
> +              - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
>                - qcom,sc7180-sdhci
>                - qcom,sc7280-sdhci
>
> --
> 2.39.2
>
