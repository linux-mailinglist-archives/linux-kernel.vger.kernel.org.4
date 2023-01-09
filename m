Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37026621FF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbjAIJrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbjAIJqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:46:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1BD14D23
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:45:14 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so8539401wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLhH0B+uL7u8FwbJcnA84uIuHyq/9Ih7+fgHG/d+w/g=;
        b=U/h+91bn+r91+v1YTW1nvU4AvAAw8s6Tk2cgo4doYUseV/Bpu0rMpft+Vd9LPM0gxz
         5ohKV0lwD8VU3mmrlDRbttFGt47lR55lUefIlsgAxmIy/NigXmj1CIvn9C1LKYlMlW/C
         TYv3fERgIl3xTwlbQ7vsBaUo0CJGtENI9dO5SDFVQL1+zWVxSpz7ffyOEiC0kmfEgjKL
         pSr4f23TMg0SyxkZ+ZxkISWFKNv/HC4Hf7dPQi0gi2DM6an9hE9XLyCHsrAnx+EhoAmv
         25MNiWxPhnLAKDCH+7hgOqOnoToUXta71Ewav8+oV+s8pzy10kQ7KO9Xq9tzlz08xuak
         0KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLhH0B+uL7u8FwbJcnA84uIuHyq/9Ih7+fgHG/d+w/g=;
        b=6KMFlolA++rkIeIljK81BWdikQ1ezuwj95NrMf4m/LgayGdQsDLv5VNgTr45bwT86z
         cPx7AGoJLJta2spzGk+Z32q/P1cMVDQ5H1jUZbr+KqmODj1Ir1t1Xf0fPy1SjntCskXO
         lYY4+XjsBS38SSLhTS0pocNiufx9IwmGClNNa61p0suiWQHaG1FhaiVfxWN9XpfpPIE5
         6AzSfcX/Psz8mqHf/3Z+qNWQehn5znRYNI/PM9ioTr3uGt1wDLSTCiUjGQi7N3ticwDR
         aX1s2TqkOvSF9fo7y6tG04dIRXVC5OhcBBGoLeB6BdryXK9SlYY68UJ/XZ0095B78ypx
         xKCw==
X-Gm-Message-State: AFqh2kqEns5A4J4LoUrfMuvvkuyAzaOrZg+fyUtiN+grzY5VYI6hzsLW
        D5bR1Du4qAQ6yKuq4BaKs24M1w==
X-Google-Smtp-Source: AMrXdXsNwwIJlURsNnzcw8mgN/L8ukGjkVQPEV1pXW7YTj9pGd9SrJeJnJMo3fMmM8r37up3DG8GMg==
X-Received: by 2002:a05:600c:687:b0:3cf:e7c8:494 with SMTP id a7-20020a05600c068700b003cfe7c80494mr45806546wmn.29.1673257512932;
        Mon, 09 Jan 2023 01:45:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c444800b003c21ba7d7d6sm11313513wmn.44.2023.01.09.01.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 01:45:12 -0800 (PST)
Message-ID: <e706b0b9-6b2f-7b0d-fdd1-e66bd3d6c736@linaro.org>
Date:   Mon, 9 Jan 2023 10:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/7] dt-bindings: display/msm: document the SM8550 DSI
 PHY
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-mdss-dsi-v2-0-87f1c16d7635@linaro.org>
 <20230103-topic-sm8550-upstream-mdss-dsi-v2-1-87f1c16d7635@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v2-1-87f1c16d7635@linaro.org>
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

On 09/01/2023 10:26, Neil Armstrong wrote:
> Document the SM8550 DSI PHY which is very close from the 7nm
> and 5nm DSI PHYs found in earlier platforms.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

