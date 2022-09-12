Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2205B62E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiILVlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiILVlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:41:18 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993604C628;
        Mon, 12 Sep 2022 14:41:17 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso6808051otv.1;
        Mon, 12 Sep 2022 14:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=hHCbztoz711aErDzurhGsImrPO3YU1Pl3k1mCXJj9tE=;
        b=h0IfeZTayGMYUA0CtVA5zlZxs1ngjtLShu/sJoAF/oysgBdp1MABcxuNfSoSz7NmjD
         arvdDK4A246wTeT5pTRS0oytJ74JDkbWSIXZ5M7ooqbkcGttZPCuIFfsvj9LQXfAjRGF
         hnET5YxVnQ06gKtqvp6ePVtQUCS0W985uuJE4Y+/sjww1SwS2W02GaLmb5XZrPttDq/a
         7j9nsHBgNsW4YNCyPIEz+sbKLn1kYPxq5gPioS1R8ccRyv1PnRNMLdxMwVCfWccpiLYr
         yiTNjjgDy+F2Yf7FnsPIRg+TYPIO4/2Oy9dv4Rz9RMv/gJkfTsQy3kM4oQZtkIqMIVQ+
         BbKg==
X-Gm-Message-State: ACgBeo3mVuiMk/c1RFyF9/rTr9XYpAER2rN9R4uc5gcxBClTg+P+WPWg
        xCqbt4YVJHmeIuzVPzU4gvZwIYDOSQ==
X-Google-Smtp-Source: AA6agR7cipcL6S/IPEpmMHPQYyfjpwZjscKDUjn5cFCgFd+7bYQSPpU9BaEkDDSC5PqhYhzfru4smA==
X-Received: by 2002:a9d:6255:0:b0:639:4cc1:4bd5 with SMTP id i21-20020a9d6255000000b006394cc14bd5mr11073055otk.212.1663018876871;
        Mon, 12 Sep 2022 14:41:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f11-20020a9d7b4b000000b006394136eae0sm5154986oto.57.2022.09.12.14.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 14:41:16 -0700 (PDT)
Received: (nullmailer pid 1948319 invoked by uid 1000);
        Mon, 12 Sep 2022 21:41:15 -0000
Date:   Mon, 12 Sep 2022 16:41:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 3/3] dt-bindings: mfd: qcom,spmi-pmic: use generic node
 name "gpio"
Message-ID: <20220912214115.GA1948286-robh@kernel.org>
References: <20220908080938.29199-1-krzysztof.kozlowski@linaro.org>
 <20220908080938.29199-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908080938.29199-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Sep 2022 10:09:38 +0200, Krzysztof Kozlowski wrote:
> GPIO controller nodes are named by convention just "gpio", not "gpios".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
