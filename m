Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804AC63FC94
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiLBAKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiLBAKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:10:41 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B9457B7C;
        Thu,  1 Dec 2022 16:10:40 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id s9-20020a05683004c900b0066e7414466bso2003846otd.12;
        Thu, 01 Dec 2022 16:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwV47pF0x8U7rd7NR79rNEXGsagQJIpvbm5W5UmYny0=;
        b=wnjZ3F9UotquJW9x0A9pHL0fj4I/pTtQknQGGDgTyk21bYJ1kxPSUmu9jL/bGylaRW
         8+q5obZUwOW3q8uTNSPjMfOsIOcrjWRXOLXKQ8iyY+q7TDkm9jSgo5L3cNeCZAIJxcjQ
         JvrKQwhU2MnHw/XwA2DGf4etpjweGaFFN0F2grqE57m0jhnJgj6US/enqtMR/6D9sBuL
         2hKUrfhb/JjsYN+zwyanaGe0mZMRACKCRXLiFoAn6xeg9KB1MqXfuMrUOiafdn1voT3c
         +NPzmJqJX/bgQ7N7tReRLs4kTtGKHX0b67T0H48QI3aKl75caZvLXzY7jYCX3ON2vgiJ
         xwqA==
X-Gm-Message-State: ANoB5pl6j0icd4Cw92Udn/766g4e83+DsZTVIgQygyT1ex/Crf+gOf5Z
        wuI61XB2TJnJZPKrxQc8aA==
X-Google-Smtp-Source: AA0mqf7AEpmA2qWD6lE5NIau1JNEjmDdHQY0KFYIoW3nQGe/ogvO3xevqCCrDzz9W+3Ftf1ypOHr4A==
X-Received: by 2002:a9d:2aa:0:b0:66c:44be:cf1d with SMTP id 39-20020a9d02aa000000b0066c44becf1dmr23953181otl.267.1669939839576;
        Thu, 01 Dec 2022 16:10:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v188-20020a4a7cc5000000b004a066f9a7b4sm2311577ooc.34.2022.12.01.16.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:10:39 -0800 (PST)
Received: (nullmailer pid 1740146 invoked by uid 1000);
        Fri, 02 Dec 2022 00:10:38 -0000
Date:   Thu, 1 Dec 2022 18:10:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: soc: qcom: apr: document generic qcom,apr
 compatible
Message-ID: <166993983796.1740107.16144015318255344818.robh@kernel.org>
References: <20221201133637.46146-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201133637.46146-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 01 Dec 2022 14:36:37 +0100, Krzysztof Kozlowski wrote:
> Document the qcom,apr compatible, used by Qualcomm Asynchronous Packet
> Router driver.  There are no upstream DTSes using this compatible -
> instead we have ones with APRv2 (qcom,apr-v2).  The driver does not make
> distinction between both compatibles, which raises the question whether
> the compatible is really needed.  Document it (as compatible with v2)
> for completeness.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
