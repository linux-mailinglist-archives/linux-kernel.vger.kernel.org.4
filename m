Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411F1661967
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbjAHUhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjAHUho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:37:44 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E041FB7C7
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 12:37:42 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bf43so10050304lfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 12:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2wjZyCiu39kHUTVUWrdgmj76POWhIfcwRPWfaQQRFjg=;
        b=r7U+cjr4XjIRJ9ex/9VUYCK6QbDVM2k6XxYJarY5oqgtych3zMU0OX5lHjddibz04M
         qNApQuNg3HCaTvcp+5ZeDJ79AT5Quf0tsM7GO9marhR3t0bLDVG1TaSHnqamFSFgpYQd
         LuV1w7WKR0aGgUdI/IfD3JHLKs9HxwE154N641TQQ5HdzUeoqu+abHuDiq2k0ViFYyrS
         PFOKnb3Xieu0FeOBgDtn/543Wo0jIhIkEbOrW/NqtJKolWDkeqAUQb4aPQx95C/qLplA
         EGmcov6zshQTAmhSwGALPOmrlBw+WBEALuQcI+BOs/IIz2RE8IQHkzOzl7pPXEf1c/MB
         P1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wjZyCiu39kHUTVUWrdgmj76POWhIfcwRPWfaQQRFjg=;
        b=bFkmV+63sxEWQpTReaN40hsJnI03ctC6NsPITu2yRlR5h3V15KRD0O3YIKVUW05ABO
         mhCTdNfMNoNxX3bEZJgldQe9he+1dZQMi1x7yh3rUlBU/slPNROK0j2Y/KSswKAhEvMO
         A9OEp0cCNsyApHkXsn4LxD2T8QlUU1CfvDyKuj3jvjzJoOl85wzIkBQIJpau7Qb9D2G+
         RN5gzZ1l9I5iL4vPofK+0yv1/75lRfOe5s5vQq24yyf/mXafhelhu5h33EKGfhPHRg8u
         LtE9/YerH6y2RYU5qPKNuo0B6pM+u7Ei6+8jVadQSnQU5rVez3JdOJ+dS6YNY/5e9/0a
         /XbQ==
X-Gm-Message-State: AFqh2kqwUrA71WMAGNSsxBZitjL6GAZkFQz9A5fDN6G/fnCq/F8sIhGN
        O06W1SjbLbn6gtt/dGQ9yhaKNA==
X-Google-Smtp-Source: AMrXdXtgtS0VMjYKAzLIJTHfulWhxtMeF0KdIBMpQ/AdWm6YN0w9H1vHgNvF0Y+GlLFsKuiokwi7Ag==
X-Received: by 2002:a05:6512:1049:b0:4b6:edce:a192 with SMTP id c9-20020a056512104900b004b6edcea192mr19485618lfb.4.1673210261249;
        Sun, 08 Jan 2023 12:37:41 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651220d000b004cc8207741fsm295936lfr.93.2023.01.08.12.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 12:37:40 -0800 (PST)
Message-ID: <2f6ea88f-9b84-3a8b-dacf-41af80f8574d@linaro.org>
Date:   Sun, 8 Jan 2023 22:37:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 04/11] drm/msm/dpu: Add support for SM8350
To:     Robert Foss <robert.foss@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        quic_jesszhan@quicinc.com,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        vkoul@kernel.org, a39.skl@gmail.com, quic_khsieh@quicinc.com,
        quic_vpolimer@quicinc.com, swboyd@chromium.org,
        dianders@chromium.org, liushixin2@huawei.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org
References: <20221230153554.105856-1-robert.foss@linaro.org>
 <20221230153554.105856-5-robert.foss@linaro.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221230153554.105856-5-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 30/12/2022 17:35, Robert Foss wrote:
> Add compatibles string, "qcom,sm8350-dpu", for the display processing unit
> used on Qualcomm SM8350 platform.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

