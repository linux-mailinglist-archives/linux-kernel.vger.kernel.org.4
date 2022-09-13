Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62A25B75C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiIMPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbiIMPyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:54:11 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32374E613;
        Tue, 13 Sep 2022 07:55:04 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id c39-20020a05683034a700b006540d515722so8256467otu.5;
        Tue, 13 Sep 2022 07:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Lsd77rlgCpAEMWqUkzrpyisg9ITe2s4xl/Nuh6eYp+I=;
        b=HUnDIIwKW0xJCusnpAHJt+wlKaoqDvq3bcd8lLRK9cgXzGKGa3159362nelUkJF8rR
         8rBZcykYcc5Dg8STiR5x4Z0Hdr6h8yPOYSoUNEutyuCNChP2vK2vgk1pKzG+OKeBMuBa
         e0WY5hzSB2ZdkYntpBt1WyhUQ+Q8jhDLygewodNeojC//uwy4aIows/wqvrQg7khJWfL
         UpBTNiXTSiGBPlxzJ25M22s4JPuZ2/ENKxuRPP6PJpND6//ueeoioKeyJmTD9lnYFRmR
         ZGYDeDiqAHS25fWVZZArcF1RzO2F5MS3CW5jZc3262/0dHCw3wsuFV5lRsQD5PlZ1EQ+
         dNpg==
X-Gm-Message-State: ACgBeo1+Uk2aM1V7K2qM3m4fwhP/qtVvyKUFxEdCGubp/XXCBApfJ5/0
        uimZRh16mCiLDUPbtl9Rpw==
X-Google-Smtp-Source: AA6agR5gQ/TBzv/n/7VNj/jVDgqjLFWls25AXNbU27adRVVFAcpluZhdpOZ8BU3KM4FYbL6a0w+ARA==
X-Received: by 2002:a9d:7a8e:0:b0:655:e0a9:b3c6 with SMTP id l14-20020a9d7a8e000000b00655e0a9b3c6mr4691535otn.367.1663080795021;
        Tue, 13 Sep 2022 07:53:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f11-20020a056830056b00b00636eeba9209sm6109338otc.52.2022.09.13.07.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:53:14 -0700 (PDT)
Received: (nullmailer pid 3657155 invoked by uid 1000);
        Tue, 13 Sep 2022 14:53:13 -0000
Date:   Tue, 13 Sep 2022 09:53:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Banajit Goswami <bgoswami@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 12/15] ASoC: dt-bindings: qcom,q6dsp-lpass-ports:
 cleanup example
Message-ID: <20220913145313.GA3657111-robh@kernel.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
 <20220910091428.50418-13-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910091428.50418-13-krzysztof.kozlowski@linaro.org>
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

On Sat, 10 Sep 2022 11:14:25 +0200, Krzysztof Kozlowski wrote:
> Cleanup the example DTS by adding APR and service compatibles, adding
> typical properties, using proper device node names for services and
> fixing indentation to 4-spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Add few more properties.
> 2. Adjust indentation (better).
> ---
>  .../sound/qcom,q6dsp-lpass-ports.yaml         | 48 +++++++++++--------
>  1 file changed, 27 insertions(+), 21 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
