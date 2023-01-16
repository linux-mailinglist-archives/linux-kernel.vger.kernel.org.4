Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8786A66CF76
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjAPTUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjAPTUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:20:13 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FBF2BEC6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:20:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vw16so7139368ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDJhl2JrEfjVRzKQvqBIMz7y/1765blM/Rj+5k8sN3A=;
        b=dMuefG64FEW3xgijUTbpxZl/QVCMjI4rPW55P+7ETbewC1Lq0kcKsAZR8IcIKfPkli
         4HZQtF2DVAtRd6m/3w/i19ZQ49JQ4noTpmGnd7qEcuFXb9sDZEBIWy/r4H/jqTm8/EuO
         e3/t7Aqkbxsw73YuTRkYMm0kM4AwWH+kV4JxkUakKQ3H/7FiNlzT7jyo/sxL2DtZuxSj
         VVGchKDFTn+gv3I7hYjvCVP3nlnvf/TbNrPoN1PoxzAd7/HVIk34vNFE19ZS+GsqLw02
         4tdb3jDAVtNlF7juhkj0CquFde30fTi13j5rRzlgoGTXZEoS3npMQmmREoS+uTpHEPew
         6V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDJhl2JrEfjVRzKQvqBIMz7y/1765blM/Rj+5k8sN3A=;
        b=hNiKfxh5eDVSTeIp4cNz6xxfydG133WEBQiFPvhok/FxnZufrYZsCyPC6BZlyQwu0G
         QUkIyZxR3CVVgTMk5VwMC4v4Tbo6yvoRzqdWsZQjmyrsI85qanvW9T5e8CxcwKKfM1TE
         HFb+xQADkpyxt6CUqLxRmeKFGy2RjAhXU2lBSODjB6ubXERxUNiDNpHxsfNU1slS+2X4
         9wVwZHsRHd1+GkibwLEvBUva98xfZnjr6vT7arfoyp3VCzv7cFY4taNkV42cr1GOKDW5
         uIG+5Atjw/0m0KHXxuw0sRQxzvfIVZdhtg5mXFf4jvQjBWfn0nIHKa3tJ7cJahOMttPT
         hckQ==
X-Gm-Message-State: AFqh2kopfI33Ifzbz1thf6GRLlDKtI1Xtn21jZXlXbqKf38M7i95C+Bx
        TT4xjPJT//xT8LxR173S9fBNJQ==
X-Google-Smtp-Source: AMrXdXvRp1jhXQmTSRUs0FqepxPK0fgrpXAf5m/8kczSCQMkAwnBPCYakTyiXOPRvyGSw0x4I9lc8Q==
X-Received: by 2002:a17:906:4950:b0:870:5ed6:74af with SMTP id f16-20020a170906495000b008705ed674afmr4624045ejt.77.1673896810745;
        Mon, 16 Jan 2023 11:20:10 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906c31800b0086dee4e5555sm2891358ejz.87.2023.01.16.11.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 11:20:10 -0800 (PST)
Message-ID: <ed199baf-a4e2-cbb5-d399-2387e538c466@linaro.org>
Date:   Mon, 16 Jan 2023 20:20:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: display/msm: Add SM6375 DSI PHY
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230116114059.346327-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230116114059.346327-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 12:40, Konrad Dybcio wrote:
> SM6375 has a single 7nm DSI PHY. Document it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

