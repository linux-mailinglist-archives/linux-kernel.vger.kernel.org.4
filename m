Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2EE662203
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbjAIJru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjAIJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:47:01 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B272665FC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:46:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso3144726wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4d8EU52tZaN8G55CHlelx4PLWRYfjxDBelNszuGiEiw=;
        b=KUmkgF4xkeZQoHP9ibXijiP/e/GILo50shdSk89ikoT8/BA8BO2EGXIvIF2WFNTV+1
         JPFX5FIf486s8sSAAiZSDGqsmCE5fYyglloPO16ZWLgLcz+wygyNVbmsAl5nK/aTi7Q3
         kM48oiHgk7u8v8Iq6hzvG97Fn9n2uhoUR0tdX8yl543nHBEmgsI/XZhLMyren44H9vVJ
         cTymjKh5W2UmRTbiGF/TtGYayVDUVOyqHIkMH/agAZ5eQGiWh37YXp7BUQTPjyG6n5nF
         FexF16UWSg8cyJqZbcwXTj2gjMtZ0nimcXGeqQqIFv6ZMg/oyC6j9ncT8qPzoyysDPdc
         XuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4d8EU52tZaN8G55CHlelx4PLWRYfjxDBelNszuGiEiw=;
        b=rWgifaoGOHb9ygFGFX/XVTwcZg6NMQR4ZEyX6gvMbLRrrens04+cLy8/BOhoBHW/En
         xad9tHXJCm/M+1h+dXhhmCzK+zWuOCAeuae59O/aC6+6TG1FBrPjGCrSqqNEFZ8lU4wy
         LdiRxx+H/lW6PtuC4HJLZcPD2DSMI/yjbipDtvC2k6mKbD4fToowGhOmH69/bzo+zpN/
         iWoatBzjXv6nqHThL494eV9HpYv8EzALzSsxvLeGnfiP8Alvp38b1N94sZPsF4Smy84V
         cA8vXGSIwRauD4SCU6hkOGSb7Uwsplhvh5UBBcrmIRH7KyHi41YOt3zKy2T75eGhqpVh
         BYyw==
X-Gm-Message-State: AFqh2koWl3C7H7JOgzc0+hYLG9l4HhMrkQz2dnsfKyaQoM+ZVinqCKGw
        jWwvPMCdbJuKTqMFoQaINYH4AA==
X-Google-Smtp-Source: AMrXdXsst/5w9cMBLN5E3W/1t7/92DmGAnG7/U8umolo0ZIPW0BiFLAxDkZ52kTSEB1g43ZxaWdssA==
X-Received: by 2002:a05:600c:1d20:b0:3d2:2aaf:316 with SMTP id l32-20020a05600c1d2000b003d22aaf0316mr46167223wms.36.1673257571331;
        Mon, 09 Jan 2023 01:46:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d5186000000b002bbddb89c71sm4219198wrv.67.2023.01.09.01.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 01:46:10 -0800 (PST)
Message-ID: <fae25e1c-c485-af1c-ae13-1a9e443d932b@linaro.org>
Date:   Mon, 9 Jan 2023 10:46:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/7] dt-bindings: display/msm: document DPU on SM8550
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
 <20230103-topic-sm8550-upstream-mdss-dsi-v2-2-87f1c16d7635@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v2-2-87f1c16d7635@linaro.org>
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
> Document the DPU hardware found on the Qualcomm SM8550 platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm8550-dpu.yaml      | 134 +++++++++++++++++++++
>  1 file changed, 134 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

