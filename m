Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAB3619A2A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiKDOgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiKDOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:35:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F6B2E9DE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:32:59 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id j6so3273433qvn.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OeOrHPnEU5cox0eqwYtdlY9TT4wnzhynjogUJRsWZ7o=;
        b=w/ARTFunLSDiyxRHSOzo6qwqLgD9x6KwLjikPcCosCa1wU2ELA2NXqsHWDw6OAZX0+
         1ZKqC91ImfY/cR+gQfcLhCT4yk1E6H5yMfDLHXp0KBUN00cqK8Vm59sAB8zGcpGH4968
         pglQtaGcq0d9DfTmU/YvyVTTbfEN0fWnSu3/q+utycA/AQI+Wc6pS7ocGeNQoU0jNcXJ
         kwJ2KB2Z6oz2+Oat5Q2+iQJ8mOU9XnJihaRX5cXfR+quWHBN9W9H+eCPt242Bld2ODGw
         YtkNJJWbjzormwNWmg/NtR250tXkhy+1cQgjWltaSPuHrt6fliBziGlezFBe8VOS17TC
         5TCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OeOrHPnEU5cox0eqwYtdlY9TT4wnzhynjogUJRsWZ7o=;
        b=hnvYdBfLgvdelQPdcXqF7XpI6f/agnH8US4RU9n0bM79DZkKSyk6ueAYDIVX6yDPIn
         qr3SYlS4kH0kCru+T1hRNugmL+4DS2gZ3UjcsVmgGnAi+IwPnIGxYQR3KzyHgLheOAFh
         z+JB5I39CA89EUQeYzd4NRqW7qFfNIAIj9V8BAC40FUFP8h3kDUO5hs+plORQBG6ISZC
         8tPXf8twb93ZkvWzsGqUPPMU0UIZFizJfaZE6Vw+sf78vs+6UDwhVm/yUpb7UEQbO2MT
         9iU0XOXRXvwoyUVhg4axDEsURMVKM70wKeObVHud3GR1Ntkmpn1pzwmBTMwTpP1g8BeD
         8b9Q==
X-Gm-Message-State: ACrzQf0R2Dqyx+JqJ7biDpFfjw4XGbBmfKE/taMSTSk/F3PnsCjfLnxf
        pW02umNQ5bmM6YgvGjhnilTjcQ==
X-Google-Smtp-Source: AMsMyM5Mv0wIYbec9tqLkuKXmCDe7J07JAYbB3fGL2UWnMWOFRvwdpyTKWWwHbksWKnADQkPdEmnQA==
X-Received: by 2002:a0c:f391:0:b0:4bb:7482:526a with SMTP id i17-20020a0cf391000000b004bb7482526amr32859051qvk.20.1667572378718;
        Fri, 04 Nov 2022 07:32:58 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id y7-20020ac87087000000b0039bfe8acff6sm2499020qto.58.2022.11.04.07.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 07:32:58 -0700 (PDT)
Message-ID: <6cdd193e-8a7a-c781-320a-8bf18f9c5c68@linaro.org>
Date:   Fri, 4 Nov 2022 10:32:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm
 Ramp Controller
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com
References: <20221104142204.156333-1-angelogioacchino.delregno@collabora.com>
 <20221104142204.156333-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104142204.156333-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 10:22, AngeloGioacchino Del Regno wrote:
> Document bindings for the Qualcomm Ramp Controller, found on various
> legacy Qualcomm SoCs.

Subject: drop second "bindings" word. One in prefix (dt-bindings) is enough.

> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

With above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

