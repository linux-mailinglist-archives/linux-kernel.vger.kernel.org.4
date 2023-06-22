Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9173A873
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjFVSnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjFVSnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:43:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4512100
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:43:47 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b4826ba943so67545911fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687459426; x=1690051426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dRnycaB3AP334Fb6uAomoGnhJ7vG39LTkLzaBIFk44=;
        b=AlfRZXwK8UxUZA6aJ02mwY1OmVaJiGFBflSjyu/XPlQ3tSSjleflUNnUAgXb22I/IU
         C7T67D41AHU4Zz9ofK8EVkojsWer5VJ7fHQ/mQzzLg0d666CgBfhTC7tjvoydkbzmlZe
         Yf4FdRXN39IBgkehQiqY0ZTEbhvgZ5RPwOeNe5BEGzsqcN7wvjrGSiyt7yApwN4sC6iF
         uqyuIQuT7xNlSuxUp1r8nKsApy9pMq8hqlcCgKWoL+F9ne7YHPE9eR+NYiUr7lhRDTlQ
         9flJqKZUp5eB6NFsIoQEGWkE/WDgWp0rdT8nJeKMcKtjvTgw/SLpWOquMtKwxuOV597k
         Etbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687459426; x=1690051426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dRnycaB3AP334Fb6uAomoGnhJ7vG39LTkLzaBIFk44=;
        b=IbQVh+Cp80tkKyaDxEmWz4DW8sX1ZsWbhn/je8JIJRFdCTSIwGx+2+aiS8TnhEDw3i
         z2VsACvA6da4XiN8EX+0DN+JX3wcVtyECWGlrIoE46H5eh85ti/U18j7KVmqnYQ6McTc
         hcfkG2U0T3BPo2oDl/akQZu+njrO7LUPnP1KIkWmxoi3UGQIuzOoHDbO2YPxpORTAulM
         hykSR6vaNSZ/1x1U6LBuXUlwHXG9+Bvbv17NcrlwETF81vN5hJu8xNuPK9TTJDn5ANDA
         98uIMcwrG1ijoeeB55b1cMIFg/+OM/Lkg/Vxu+3OafoRyQCDag6jht/pIOk65k9yTgJ1
         RXnQ==
X-Gm-Message-State: AC+VfDwTIo/ajQfRJ4DOXQuaE2/5BNB3j4Hwrbzc8TrAJMao40mmEM5X
        U+CUQ+bj3m8deF7mWR43UW2IZw==
X-Google-Smtp-Source: ACHHUZ67cCLc2mNUuPFSD/Jh8swXlxU7En9u7t8+O8lyPR7iCOmc1Fqhssh8nplz/Zr/zvQ9+slolA==
X-Received: by 2002:a2e:a175:0:b0:2a8:a9f7:205b with SMTP id u21-20020a2ea175000000b002a8a9f7205bmr12168056ljl.36.1687459426140;
        Thu, 22 Jun 2023 11:43:46 -0700 (PDT)
Received: from [10.2.145.31] ([193.65.47.217])
        by smtp.gmail.com with ESMTPSA id h4-20020a2e3a04000000b002ad9a1bfa8esm1414772lja.1.2023.06.22.11.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 11:43:45 -0700 (PDT)
Message-ID: <1f259e13-0a49-f06e-9578-8de533115f92@linaro.org>
Date:   Thu, 22 Jun 2023 21:43:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] drm/msm/dsi: Use pm_runtime_resume_and_get to
 prevent refcnt leaks
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230620-topic-dsiphy_rpm-v2-0-a11a751f34f0@linaro.org>
 <20230620-topic-dsiphy_rpm-v2-1-a11a751f34f0@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230620-topic-dsiphy_rpm-v2-1-a11a751f34f0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 14:43, Konrad Dybcio wrote:
> This helper has been introduced to avoid programmer errors (missing
> _put calls leading to dangling refcnt) when using pm_runtime_get, use it.
> 
> While at it, start checking the return value.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

What about also adding the following tag?

Fixes: 5c8290284402 ("drm/msm/dsi: Split PHY drivers to separate files")


-- 
With best wishes
Dmitry

