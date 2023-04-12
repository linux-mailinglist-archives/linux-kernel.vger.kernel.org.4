Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464B76DF998
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjDLPRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjDLPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:17:42 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3EF83C5;
        Wed, 12 Apr 2023 08:17:34 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1842e278605so14151327fac.6;
        Wed, 12 Apr 2023 08:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312653; x=1683904653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptMzYUAUAlcetXb7JvUQM3165vVyy51RyPYBT4pxd1w=;
        b=yJ7fLzA6uC3CFH1TFzvFzJc5kfJHoSzs0w5cHC8NhCo97iGdsl70wDmpV6KWKNDZsZ
         vx2LRJY248GCGyEUkuG1gekUDlj5XsS14cTx4irV35W4yDqvnrCPFB0+7y73AvmUhzc7
         C6hsiFTMnZkQTVlNxgVCfcB6q3boOoRfaI/4xfkQVpaNZ8tb2BJn3+YYRm5j907TnVKT
         Jc455+a5vYCQYexZyGO34N6uQ8PbuR2yb/OAm+OvLrsB1Yxrj4VEoIk4rMDBBZ6DdsM9
         yyVisoH/QqhoKaxM0Q89koZ5S0jifj2DVKHYhcxF9iK7FLN4PvH/Q6w+cybUbq/fAEPO
         +Svg==
X-Gm-Message-State: AAQBX9eisPGMF8MODkFPhzm3wDAbwX0JdvXrpKoA0NLNr3CG5OGwrnpj
        +zgbB8tHAESyIi3GNkTDaw==
X-Google-Smtp-Source: AKy350artlwB2iGbtEr9ycW14iu/TDlmISu558dgryM/E1xHK4GmFNpNLNRwC/TG0Cm2eVOGnfqOJQ==
X-Received: by 2002:a05:6870:d38f:b0:187:85b1:126f with SMTP id k15-20020a056870d38f00b0018785b1126fmr316327oag.17.1681312653205;
        Wed, 12 Apr 2023 08:17:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s32-20020a05687050e000b001729072f759sm6309801oaf.0.2023.04.12.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:17:32 -0700 (PDT)
Received: (nullmailer pid 2451917 invoked by uid 1000);
        Wed, 12 Apr 2023 15:17:32 -0000
Date:   Wed, 12 Apr 2023 10:17:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Adam Skladowski <a_skl39@protonmail.com>,
        Taniya Das <tdas@codeaurora.org>,
        Sireesh Kodali <sireeshkodali@protonmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: qcom,gcc-msm8953: split to separate
 schema
Message-ID: <168131265152.2451857.1491124916018290951.robh@kernel.org>
References: <20230408143729.84097-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408143729.84097-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 08 Apr 2023 16:37:29 +0200, Krzysztof Kozlowski wrote:
> The Qualcomm MSM8953 GCC clock controller has clock inputs, thus
> existing gcc-other.yaml was not describing it fully.  Move the binding
> to its own schema file and document the clocks based on DTS.  Add driver
> contributors as its maintainers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/clock/qcom,gcc-msm8953.yaml      | 73 +++++++++++++++++++
>  .../bindings/clock/qcom,gcc-other.yaml        |  1 -
>  2 files changed, 73 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>

