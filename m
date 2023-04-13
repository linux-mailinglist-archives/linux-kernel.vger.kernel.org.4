Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CA26E084D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDMHzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjDMHzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:55:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604F926A5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:55:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qb20so34799760ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681372507; x=1683964507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dDPTo7pAbw38LoN+sVNvkK7XTKAxdrh79eGZjH2+lY=;
        b=Ejrj4R/7xT2a4RYe1Y5T3Rn5KiIwqcfdkD9P5InRpKjPemJx6sQLujgw+qPNi3G70W
         7XUu2f7xAgln3LNKY1dqSmJ0KqJKJbC3KIimV5WiO7DMdnEqfmkMWiAUy54XEtg+/qgs
         9QhWihYI1B4LlFadoA4BVAkmwgIxchPvHsLvktExzF9YwiAxfnEGcWBrCrkhqgEA1qSh
         W7B8HlC6bwb6Ih39FJMODjSVaNwsxPI5CwCyWvcmXmQFdAaSleuPyywY0X7HiMv2PpIh
         0kUGBrv5ZJ49p/UiX6ChfmcATbGl7boAb8dElXFBITzgP7oZWMkC1Ymh/RfgcvWijP2z
         PnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681372507; x=1683964507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dDPTo7pAbw38LoN+sVNvkK7XTKAxdrh79eGZjH2+lY=;
        b=UV3N6Yitjqklqsm+h2U+oopewnmGndKswUdgcnzJWLHxrXvpYZP9/SWY7SLMVDaoKT
         SgE/wRnWXgus6lerAEuJxXRZQVoWXl9+RXPquheGqWTelF0V7OYYY8YwSSmo9RElzu5Z
         dc8G+ZNd3rJ6X5PoimcBa8es8KFHJOwCVia0pDZqTAWZ6H5grdfS9mBV7Mmb2QC3GVHt
         ENBOm37O1WxEM+tFtuOR4FYDfI8FWNcr1HITe3mB8YgJl+2HldZvPf27cWp/i72TwBP7
         DoGwocKJl5lqxZl97+VtrqK9U9v1xAxBmmOmiMWn/m9Ahs7PjaT1vnlSr8MhWE6QrNgN
         YoDQ==
X-Gm-Message-State: AAQBX9dDBGyN1SU4FHIO9URUHBSD8vUWgzpZFGjtVbpsTOPutAFESeWO
        Vw3QWZrd5cyEOvhwbJYWtdHtcw==
X-Google-Smtp-Source: AKy350ae1oc34Oyo141xL/55tTpu3GLXnkGlh4IkaGPDqJ6dAQ+jgJtHGhDS5ZdMRwOG6ZGU7zZGNQ==
X-Received: by 2002:a17:907:d306:b0:94d:7e31:e338 with SMTP id vg6-20020a170907d30600b0094d7e31e338mr1730607ejc.52.1681372506860;
        Thu, 13 Apr 2023 00:55:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7? ([2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7])
        by smtp.gmail.com with ESMTPSA id dn19-20020a17090794d300b0094a6a7a56c0sm602189ejc.18.2023.04.13.00.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 00:55:06 -0700 (PDT)
Message-ID: <003e1ff0-591f-3959-ccf9-9fa84cbcc4c4@linaro.org>
Date:   Thu, 13 Apr 2023 09:55:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] dt-bindings: display: mediatek: dp: Add compatible
 for MediaTek MT8188
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1681358785-6930-1-git-send-email-xinlei.lee@mediatek.com>
 <1681358785-6930-2-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1681358785-6930-2-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 06:06, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of dp-tx for MediaTek MT8188 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

