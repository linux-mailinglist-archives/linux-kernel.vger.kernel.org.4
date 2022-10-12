Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF235FC8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJLQOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJLQOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:14:46 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1EABC1A;
        Wed, 12 Oct 2022 09:14:44 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so19948014fac.11;
        Wed, 12 Oct 2022 09:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fO0PpGdOVvPpij/NXGuyWGNOEjG4oK2xZeS4yIzf9J4=;
        b=4SrGnPa4+NDqmNxNSPXb2Jo4ICUv51zxMiil2e5oiwt0r3o1fBgo3ENq2s6DQNbodb
         KR9d73JBphKR/63wSAiLmWLAqeop77qkygJM28KK7culpn7gTZ4tQyMBQoLRMOcm0JkB
         tkmkkY0+35pHFzEJWvuF8dY2+ulj+8t3/dgxNbq8+4QAn3H8Fv5NhivcuGO50SiI7XQQ
         pR86ayR+MuEBdZ8I/dsFeWKDkksk2faRjoW7KHZgcHj4M04P+EWrYwBtS1IHJgk+8j//
         GIHPNF968auRTxBLBrG5xPpFERtS+xGO40XK4JlcIL3RXYRZuZj2tWyJef8ZIR+poSxh
         cAkw==
X-Gm-Message-State: ACrzQf0J3OXptZXuNP5cFK7uk1JPCpDnhYYsI2aRsK3nhhQI/mFdAsXm
        vhlOkP84Qbk/FUd+5DLCMA==
X-Google-Smtp-Source: AMsMyM6yAD0owmN5GAuYeIUjCw5q1buKdw+7TnS/U5p7z0BsjaAGZsqW07muqSIV4LFv2mhUPCiI4w==
X-Received: by 2002:a05:6870:42d1:b0:136:3b49:cc26 with SMTP id z17-20020a05687042d100b001363b49cc26mr2861625oah.238.1665591284209;
        Wed, 12 Oct 2022 09:14:44 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cm21-20020a056830651500b00660d73c8bdesm7646591otb.50.2022.10.12.09.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:14:43 -0700 (PDT)
Received: (nullmailer pid 2274735 invoked by uid 1000);
        Wed, 12 Oct 2022 16:14:45 -0000
Date:   Wed, 12 Oct 2022 11:14:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: pinctrl: qcom,msm8998: convert to
 dtschema
Message-ID: <166559128462.2274700.1712884947445787957.robh@kernel.org>
References: <20221011213145.122879-1-krzysztof.kozlowski@linaro.org>
 <20221011213145.122879-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011213145.122879-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2022 17:31:45 -0400, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8998 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,msm8998-pinctrl.txt | 202 ------------------
>  .../pinctrl/qcom,msm8998-pinctrl.yaml         | 176 +++++++++++++++
>  2 files changed, 176 insertions(+), 202 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
