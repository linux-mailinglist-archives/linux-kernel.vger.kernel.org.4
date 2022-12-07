Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469C9646541
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiLGXk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiLGXkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:40:13 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6768AAED
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:40:12 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f20so9479396lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 15:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRIjdXMU+hROafjnkjje/sfB4GvhGqvX1pIwmIMOYUk=;
        b=dPjPWHoCRIzQn0lG6TQAzVpxAbwzqRKkircLaLGcGR3KSwbVfY+ncjEM5MjE1khSwC
         FUV+pA/AIVQrxDZhzfOqHsiDQo0IASpAFwtIbINKn3aukCKlXj8XZhVuAMQWdE0jMPDX
         dL3PM56uyqi+iPYCNNgerbwg955OPX3IV4hsSTR9PZwuFuZvtaBktFXDZZ9BYWz53SMr
         tkhUB6LYG/btRHDH+pOvMPyHQGhq834CJRQBBU/Cid0AujIVPstRVYP0GLTKehMrml8d
         Fq5TshjJ8MsBjAB3lZm+cfzLPl0kjo2jh9P+R3ozjdXM7byXWbbcbtpP4u6RgHCrFTr0
         MQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRIjdXMU+hROafjnkjje/sfB4GvhGqvX1pIwmIMOYUk=;
        b=LTKSi+K8pR5ufOBSVZkanAPhyaxRYSPN/MbrtllwJUUffClcT+7x0GWuTfmX6QGhlt
         R3EqCaE/2EQ5/WU0+VkCBZjmh3pxy/LUd3aJNMBSAzC/8dcm3bwBtsBhQVraswZR/2ev
         JH9Dya8y/D0DwI9gMplAfVK3i/ZFgMaWZeGnbfldmNwGeWW+GTrlGyxxVEU/qpQqkaST
         +jMV2qutzpxYo7wBcGl9CnIFTErtO8ZiQcdejlW+SkWjWi/J2hVaSVy2roWyCDKAdm82
         kcgJBhtZERwCQrTJQ0m0DOSu21yQ6/FKOQpwpbAuBaVJVMO/L5NoapWxfPBpGpygR4Jn
         l23A==
X-Gm-Message-State: ANoB5pljv4DG+UZ4XiEqwmeOTNmhg2O3EWgP+SziktpV7xa3NLO36J1R
        w+ZW+aW3vXVxgkAmQtuzgHkxrA==
X-Google-Smtp-Source: AA0mqf5iKdnHu+jtm6Nr4bgVmFnKseN07NPJyrAwVWJGzXVOiMrlJzGxcHf1l6Gy4PZqkTPotl6qFg==
X-Received: by 2002:a05:651c:b26:b0:277:9847:286a with SMTP id b38-20020a05651c0b2600b002779847286amr22932017ljr.309.1670456410638;
        Wed, 07 Dec 2022 15:40:10 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id j21-20020ac253b5000000b0049c29292250sm3030149lfh.149.2022.12.07.15.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 15:40:10 -0800 (PST)
Message-ID: <bf820a39-2c04-67b1-1275-71b465e53055@linaro.org>
Date:   Thu, 8 Dec 2022 01:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 04/11] drm/msm/dpu: Add support for SM8350
Content-Language: en-GB
To:     Robert Foss <robert.foss@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org
References: <20221205163754.221139-1-robert.foss@linaro.org>
 <20221205163754.221139-5-robert.foss@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221205163754.221139-5-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 18:37, Robert Foss wrote:
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

