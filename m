Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848DF604627
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiJSNAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiJSM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:58:50 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF6B2A953
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:42:18 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b25so10547378qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APY6XkBoiH+8MYx94R2gCE5tsyBBjocoJUqhpNcG1uo=;
        b=t0jva4wVew3s5XSwsmG9/vKT92stEy73Mz1sWf3wiZStx2UYRLlL+2Ue1tYnQID5Qm
         FB272FCC/NGWhCI7C4XfeKTRYdFEaVGCI7MtWoYoacYNprbMXX0MTZNpbzEAn2j2Nha0
         jCz+tqfS6oNV1e1ELhtj/YUlwJ03+DjRsJakr2AirJJHw93lXnKErJh0nQodWQwP0kB9
         gVH4UJsXrMmeAVaX89fRORuta/K3zrt+niaVSaDqY7KOl9wH9CJADKSNSU78yNRzsk9t
         sg9gG2NNMfC4oCxff1qbWIGj1imxFQf129rR5HfMwuhlb3wBihKWdrIGbDSa6d++OrvO
         c/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APY6XkBoiH+8MYx94R2gCE5tsyBBjocoJUqhpNcG1uo=;
        b=hx2elPTkfZm4IQjBcs9KpDEgo4O11eRXa20nK8aAMX72W1GwobNBTroLJmTN9xXSKZ
         xZbcxhf8HXB47bGbMFwP91+Al9J0cPEVwDwJzB8/BSR605tQzgGVIacqNv5MAHnWRPiU
         QA5/85UQumxEKUCQZrN8AOaLu64ZP59+UTYyXweSB65N4Tru0Q60S4qECEpg3H01vlxH
         56dYDosfNdAVyZ80A/e4hzkdf3xyRRVadRFR/MVtOefKYEi9XCoTF3r4vIPE+9vbh4bT
         rNf2jtvCtgA8Y3QJvUCuH05WR7/NeGWrhayCSfWSMlV7QeYLmi37zNH3EQtMnY3qHje5
         b1dA==
X-Gm-Message-State: ACrzQf1aGnyv5dCCgrOlwh1qNWW/Xd2YUDM4VY7oA4wUM0b3O9D78jR6
        eZAtuTl2MWkQyKeKzA0IlP7X8w==
X-Google-Smtp-Source: AMsMyM4mg+k/dzvcqomBH9qc5f5xm21maADpMizbJY1M4DfSbN0jD6paa3IvF7n7dlHO8kOeeH6YfA==
X-Received: by 2002:a05:620a:2809:b0:6bc:5e0d:d7b1 with SMTP id f9-20020a05620a280900b006bc5e0dd7b1mr5230359qkp.545.1666183277044;
        Wed, 19 Oct 2022 05:41:17 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id y2-20020a05620a0e0200b006ee8874f5d8sm4708919qkm.28.2022.10.19.05.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:41:16 -0700 (PDT)
Message-ID: <1847fa0b-7b1b-13f2-6667-0b9003ae58ac@linaro.org>
Date:   Wed, 19 Oct 2022 08:41:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 10/15] dt-bindings: phy: qcom,qmp-pcie: add sc8280xp
 bindings
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-11-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019113552.22353-11-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 07:35, Johan Hovold wrote:
> Add bindings for the PCIe QMP PHYs found on SC8280XP.
> 
> The PCIe2 and PCIe3 controllers and PHYs on SC8280XP can be used in
> 4-lane mode or as separate controllers and PHYs in 2-lane mode (e.g. as
> PCIe2A and PCIe2B).
> 
> The configuration for a specific system can be read from a TCSR register.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

But please wait with applying this patch for Rob's bot:
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221019113552.22353-11-johan+linaro@kernel.org/

Best regards,
Krzysztof

