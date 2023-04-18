Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB56E6F09
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjDRWCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjDRWCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:02:52 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30BC189;
        Tue, 18 Apr 2023 15:02:51 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1878f1ebf46so603023fac.1;
        Tue, 18 Apr 2023 15:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681855371; x=1684447371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QI7D87InjhbBs5EZ8THYXnMAUWuofN84rJTqz1HIfe0=;
        b=bo//+H4YNLIQCSS4iySrltBSQU0nchBKUaE2gANgavPsBqQEr24Vt4Ml/35igNu9s3
         4yBhcmg8ANj2DAsKs/U1m0UfZxnI+BfcFYd0K6bzFo6xhzGJ0GoNzTRWCfT1ng2OY5Ai
         q6+ZNih2PntH3j3rudGospW17dGUvSQDSPHxlknZ5G62KIIdrwEpF80ZRqciWJNkxOw0
         1kLhKOSNlENMniOAHIH6tLYXzEwI/NXMcrOcou+4z3uTJXVMYlmTu6nV2iDhByfktJ0E
         3+ctTHtc0dWWAhEfQ4wk+iPUGAql6EIRACR9mtLwSgwaLuYce+XMidqc/2KHNxoSVw3A
         7mtQ==
X-Gm-Message-State: AAQBX9cIp6m9LAM9ASkavio7mo/UUJPUTe24HqprSQVRG4yAtl06dQ1o
        0lH4yZdFIkSHACoHhIT+CQ==
X-Google-Smtp-Source: AKy350adrkwoDBM/BxR6mRY2zD33IZaIewcPncoeCx+VQU/atsuFvdm7h8sMt7+MTUZiPvNZONir+g==
X-Received: by 2002:a05:6870:8928:b0:177:a4d0:e389 with SMTP id i40-20020a056870892800b00177a4d0e389mr2034044oao.28.1681855371247;
        Tue, 18 Apr 2023 15:02:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u5-20020a056870b0c500b00172ac40356csm6011756oag.50.2023.04.18.15.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:02:50 -0700 (PDT)
Received: (nullmailer pid 2408753 invoked by uid 1000);
        Tue, 18 Apr 2023 22:02:49 -0000
Date:   Tue, 18 Apr 2023 17:02:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: qcom,edp-phy: allow power-domains
Message-ID: <168185536811.2408674.3978903723829554887.robh@kernel.org>
References: <20230416151233.346336-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416151233.346336-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 16 Apr 2023 17:12:33 +0200, Krzysztof Kozlowski wrote:
> At least on SC8280XP the eDP PHY is part of power domain:
> 
>   sc8280xp-crd.dtb: phy@220c2a00: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

