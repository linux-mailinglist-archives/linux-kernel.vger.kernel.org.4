Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC42E6E6E89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjDRVp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjDRVp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:45:56 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5850125B0;
        Tue, 18 Apr 2023 14:45:43 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-187edc01fa3so459737fac.3;
        Tue, 18 Apr 2023 14:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681854342; x=1684446342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWMFayVItsnaFUG5yboqy4Ud2ym9osk5KpeZQhBq5jE=;
        b=Y98hfFe4RNZiHYfsWGLm6cTb6WUYJHAdxsp9XVQwXBMW7wAJoOX5NuCeeml4mUFd20
         5OM5eZYAycRIzrqibY5iQe1p5ALwL1/IQW1VFFTA7Bk0isCWV/phs47bt2LdGjFEW2oR
         wJXmpBdkHJZQURajvwkt40ZgBbtisZZ3qUDpyRXYXk6hTM4ZI1J+DTATT7biXMcOjMfK
         qOZf29mpXVd9U8EIhSsLRNlusUxvzZUUeuCQ4ZMwpDLolaRMDLdFsVHeU4L97NU28CAP
         F4pUO/DT6WfXM4y14jMTvUsj6eGsK1DjfsjQaM2xQtJF+7YwPMJ/AoTAZJcVphbDfuYb
         uLFg==
X-Gm-Message-State: AAQBX9esvFc+xWiNm0xNLi4MC9xrMg3s/b5uksK7B64+gVOW99sOAmvd
        GAiXzdPGSueyjWXxS+KY/w==
X-Google-Smtp-Source: AKy350ZhzwHcWQ0KxgXJQWGnnGXYjahCsSPIlF4jl1CwlV//e0aK5I48m1C2NxxVLOBFzV7IG1kdMw==
X-Received: by 2002:a05:6870:b620:b0:187:92fb:6eb5 with SMTP id cm32-20020a056870b62000b0018792fb6eb5mr2475530oab.5.1681854342640;
        Tue, 18 Apr 2023 14:45:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w14-20020a056830060e00b006a5de6aae9bsm769525oti.3.2023.04.18.14.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:45:42 -0700 (PDT)
Received: (nullmailer pid 2384137 invoked by uid 1000);
        Tue, 18 Apr 2023 21:45:41 -0000
Date:   Tue, 18 Apr 2023 16:45:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: qcom,pdc: document
 qcom,qdu1000-pdc
Message-ID: <168185433626.2384009.17855656492541393973.robh@kernel.org>
References: <20230416102831.105136-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416102831.105136-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 16 Apr 2023 12:28:31 +0200, Krzysztof Kozlowski wrote:
> Add QDU1000 PDC, already used in upstreamed DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

