Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF54D5EEF16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiI2Hcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbiI2Hck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:32:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150BA137E66
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:32:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d42so1020331lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=W2fjpWPBdHvD2Cwc+rAoirjTMcAP6sfAcXFgOpE7B4Q=;
        b=zFfE8XF/VEKI+2X34AQoRskkZQRelUDSPSV/CU2iP/t1u5/k8ZtYcgi8zvo1J8VACV
         F175V6oT4y3jGPvsdH9jz9cXda/Uvg7fnpUBjpY3Lc+wc+VOqQ7vruhbvwAy0AdQBvlm
         LI3KpRIIGhAYPchK1dl81/mnhEM2UrhOFLEJf3QfVnIHT0i5rf+kVZ/0VvamtnTq2dF8
         Du82GP3hpz8fXpvl8duQCLSFbvZolAr6ZJENEOvCA21hus6gaGrnY9c/2DrbT28eMM11
         FyUfka3KDcSZZuhqTdHTH9l3LXBIKQ8rvkxFgvEClpdDcZdzE0wXrazNket0e0Xs+uUm
         c/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=W2fjpWPBdHvD2Cwc+rAoirjTMcAP6sfAcXFgOpE7B4Q=;
        b=MqLh9ODRfIKwjTsHlO0WGtMagaoR4lKiBHTZtTKyjknuZSGwpN7qT3lMPtH2q3Jww0
         D0Ixdf0qsyRsGQbMCZEoNpxs1qfrSPEVNxK2EuVHiG/Tt/IMBHulwS0Trv8aqbmgmOkM
         LGKEaN3+ANUeH9MfgN1rtvhE3L4ckhs+w9qwbwE7AjhbC5gNfroso8pJiOnQRzxzsOOw
         K4/ZBS0SD4UuSsIy+kzwocFd1R8WdeEFNgoYRniit+XOktMXzSfu/IpZx/oYArTwCiUq
         YJ+ob4kau0ZKcCgQ7bMHnAG3dfFyBl/Q7M0iJ8jCoAq7bbnjSDCChICyQVaSg9azqgzD
         Qwdw==
X-Gm-Message-State: ACrzQf2eItWfRkhPMiR8grQ9f0q8G7CuybqHTwD2zksqsNKY24eIYdcK
        OFcWxYhgcG1aK8YHQTPWlILuug==
X-Google-Smtp-Source: AMsMyM5IZD7SiBd3W+DhxzoDka965KOnWTmcNIgiYNo4v6886/2xDzjTli0TxRVlpR/KgN68vVwnYQ==
X-Received: by 2002:a05:6512:3da9:b0:49f:1742:c692 with SMTP id k41-20020a0565123da900b0049f1742c692mr873659lfv.313.1664436757473;
        Thu, 29 Sep 2022 00:32:37 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u13-20020a05651220cd00b0049fbf5facf4sm706661lfr.75.2022.09.29.00.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:32:37 -0700 (PDT)
Message-ID: <a1a78c72-2067-1ea8-a50e-0dcf4ae4bb83@linaro.org>
Date:   Thu, 29 Sep 2022 09:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v10 1/7] dt-bindings: remoteproc: qcom: Add SC7280 ADSP
 support
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
References: <1664368073-13659-1-git-send-email-quic_srivasam@quicinc.com>
 <1664368073-13659-2-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1664368073-13659-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 14:27, Srinivasa Rao Mandadapu wrote:
> Add ADSP PIL loading support for SC7280 SoCs.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes since V9:
> 	-- Add missing unevaluatedProperties in glink-edge.
> Changes since V8:
> 	-- Add glink-edge reference.
> 	-- Remove redundant glinke-edge properties.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

