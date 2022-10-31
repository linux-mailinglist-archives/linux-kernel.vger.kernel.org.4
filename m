Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82588613B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiJaQgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiJaQgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:36:07 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3005FE9E;
        Mon, 31 Oct 2022 09:36:07 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13ba9a4430cso14007676fac.11;
        Mon, 31 Oct 2022 09:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymI1vmBT2MnlFNqGlcBBBZ1pNS4+xStnQ5PfMv/yMgE=;
        b=L/JpSp6um3Jg8+SeVNjncD8x+pWO0Aqk5woIg6KgheJas1htgXuK/sl6neqkGjQITC
         xLKhXDa0fRcarGimVOuztxGymt7qIAs1pmDxgCMCXxJ9CxTK/8S8jiPCA3gWIqEV7VrM
         Hj7GnMiX5no5dmfUWAMeMP1Vr3CYzlrYW18mi2oOW4pIR1UiolvyyIMbCx8RlsxqOdmO
         HRW593LR2xvccPw+WWu6kOpg404jZo5qtuaiZaC/zULr6/E+Gasrh8qv50wZ9Mz5Psr1
         Kyozt0y+dLYGc3xCg2Fptx9w1H0/z4+P4YAdehtpLwhoHy6oAnq9zzCJoCF+BMCxtkIB
         bXiQ==
X-Gm-Message-State: ACrzQf2132Nxxe09tp+uoMui6ttCpCPZcmAuq9PObS0S8UapEWXF/flx
        tCcEWzL5Td/LOw+iv0gDeA==
X-Google-Smtp-Source: AMsMyM6EpFjo7w2BKG22LVg62WqSBh2eLZpehFCoLtwNeFo8OQ+tNTwQWD1I4/ZnbQjpoHQhb6gECQ==
X-Received: by 2002:a05:6870:960c:b0:13b:f4f1:7c51 with SMTP id d12-20020a056870960c00b0013bf4f17c51mr7713756oaq.232.1667234166390;
        Mon, 31 Oct 2022 09:36:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m17-20020a056870031100b0011d02a3fa63sm3236271oaf.14.2022.10.31.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:36:05 -0700 (PDT)
Received: (nullmailer pid 2981643 invoked by uid 1000);
        Mon, 31 Oct 2022 16:36:06 -0000
Date:   Mon, 31 Oct 2022 11:36:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: qcom,spmi-vadc: extend example
Message-ID: <166723416617.2981587.18007410708976816549.robh@kernel.org>
References: <20221027143411.277980-1-krzysztof.kozlowski@linaro.org>
 <20221027143411.277980-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027143411.277980-2-krzysztof.kozlowski@linaro.org>
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


On Thu, 27 Oct 2022 10:34:11 -0400, Krzysztof Kozlowski wrote:
> Cleanup existing example (generic node name for spmi, use 4-space
> indentation) and add example for ADCv7 copied from
> Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 94 ++++++++++++-------
>  1 file changed, 62 insertions(+), 32 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
