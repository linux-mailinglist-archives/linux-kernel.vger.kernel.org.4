Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D4C742996
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjF2P0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjF2PZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:25:57 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0D04209;
        Thu, 29 Jun 2023 08:25:25 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7837329a00aso33640239f.2;
        Thu, 29 Jun 2023 08:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688052325; x=1690644325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnHuzw7CkVANTcF7RhSjmBYBRcPIhT7jREWwRFoM0uo=;
        b=Q2Ax8WJAQebUa48iyEP+HUitMSPUQHK716f03TCFiK8Teoy4v3Nr3azxfqjtvZfRJO
         RHQR664Xr3WpiQZlUeD6Pb0XDejzl3WOfhqhQhPBDJvgyIBmsZu3I6tCXhV3r59Jf/sp
         /+nUbCOCeJN1ZUjE070Gl71Is2y5VQhYIEQauhUQJeycTpkuJ4VwT92kfxyNzlQfXEse
         xUMV5iftClOHFV8RFSPd/QK9MmtpmPfeEci2XmofLqHVRg6JgvTIa/s3OvIEgalfvUtO
         tCtKfPWdeHCbgwyLq3gO7rNJU1khlW7kU2gLvmWchzp0ug+AxVamsT7aVXzkjgpEVc0O
         KGtA==
X-Gm-Message-State: AC+VfDyDrvc/8daMCo9XmnGhYQ6A5Zx+JroL1EJ7LVIJ1bRhm67tQ5FJ
        vnpKhddzm+iI8p3r0HUJeQ==
X-Google-Smtp-Source: ACHHUZ4lZ0RzUIUB6cZqLxkPbdh8s9wacVYy2WiA/MADygWgpIkifl94VHt3S/snbZZ2XsWJonb1qw==
X-Received: by 2002:a5e:8712:0:b0:785:d5d4:9f1c with SMTP id y18-20020a5e8712000000b00785d5d49f1cmr5593084ioj.18.1688052324947;
        Thu, 29 Jun 2023 08:25:24 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h3-20020a02cd23000000b0042acbd3a791sm2764234jaq.9.2023.06.29.08.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:25:24 -0700 (PDT)
Received: (nullmailer pid 3063357 invoked by uid 1000);
        Thu, 29 Jun 2023 15:25:22 -0000
Date:   Thu, 29 Jun 2023 09:25:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        bjorn.andersson@linaro.org, robh+dt@kernel.org, agross@kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom: Update my email address
Message-ID: <168805232244.3063305.12279148321293876626.robh@kernel.org>
References: <20230627173123.9221-1-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627173123.9221-1-quic_tdas@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Jun 2023 23:01:23 +0530, Taniya Das wrote:
> Update my email address from the defunct codeaurora.org domain to the
> current quicinc.com domain.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml   | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml   | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml   | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml   | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml   | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml   | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml     | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml    | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml    | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml    | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml    | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml    | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml    | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gcc.yaml           | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml         | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,mmcc.yaml          | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml        | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml  | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml | 2 +-
>  .../devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml      | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml    | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml  | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml | 2 +-
>  .../devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml          | 2 +-
>  .../devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml      | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,videocc.yaml       | 2 +-
>  28 files changed, 28 insertions(+), 28 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

