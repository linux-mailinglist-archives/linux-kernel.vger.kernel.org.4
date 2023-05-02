Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE4E6F4BF4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEBVSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEBVR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:17:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8761B10EF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 14:17:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f00d3f98deso287955e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683062276; x=1685654276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwytHTjfZACxdHSL3LETW68YNRwzhMqZLENGdJTXawc=;
        b=uWWWOF4InCVUC8xXQ2dx/Fx7CqnKt1RywdYpOfgCCgnlbC4FP9IMebuPEXyfRfJD1L
         F1nfiY2IoswC/vc9Ucs+ijR/0kBG8abJmp7hUf9iDcJGrSf2VVeOCrJ2LdqgOFfeH8ZW
         hz/a5xSUAttmGKoAMb3EOuv8dI1Ks3HFXcjC9lzHkEVVQrrjFheBOgjZXxxJXIbn33/y
         taunr9MGGjfTS4jS7GQpNnrwW66S9URtMqK5fmPgu83QUSTsoIVvtMWYXmdZHmplS1HZ
         rz2v43DpNjfw6RMEJkbmNPo9E8YgKoaGiaQV5ZCQHNzXL8wtmofM24Co0JAyNoKosswg
         Cszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062276; x=1685654276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwytHTjfZACxdHSL3LETW68YNRwzhMqZLENGdJTXawc=;
        b=Z/7DmO0QR8LKewO8HnliidcXFbu1PlZrhGG1rLj8HorElqTwu0bI8uHczU1tqAMDEq
         TEQ1qkdbEMPlj6L0mkrQtecpT0tq8Y43iP4rvhi+lQ9LU0wz1QSCRjNwaoIYIE6uuEpw
         rdqlqoMrQWeMXK+aG9FxhPJtheL9EwZf0gChoc+rdb4++uiidAL2X1tWIG2XN7XByifP
         oHb8K1MwGO2k+Aw4hra3tJqW+V8oMBpAE+Y96iY1FthsZIpqTDvirY8mZmScmyuUo628
         r0O32XhBldJLUB5R4KQsrFSrAJsIFaEsuUMTlJQLt2ndbah8UOU77+LSqOyguSMebeZo
         HDhg==
X-Gm-Message-State: AC+VfDzX7/AiLwAmWYFHu6AqNFG467kvdQ5nZTXnE5qe0IwZiz3IAa4f
        0DbDR5L1BZmbWmPg/ZTYY3k+3Q==
X-Google-Smtp-Source: ACHHUZ4NYrs2cp8G6oi0T4mSukhces7XxuwjRNl8ge+lY9H62LfBjLMzHsqPfLBoArQP7fHDVomd9A==
X-Received: by 2002:a05:6512:4008:b0:4e2:7ab6:15cd with SMTP id br8-20020a056512400800b004e27ab615cdmr288532lfb.30.1683062275812;
        Tue, 02 May 2023 14:17:55 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id w22-20020ac24436000000b004f012ac4aedsm2668700lfl.81.2023.05.02.14.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 14:17:55 -0700 (PDT)
Message-ID: <bb1412f9-9dac-7e6b-efe0-424a898b46e9@linaro.org>
Date:   Wed, 3 May 2023 00:17:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/7] drm/msm/dpu: add dsc blocks for remaining chipsets
 in catalog
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1683061382-32651-1-git-send-email-quic_khsieh@quicinc.com>
 <1683061382-32651-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1683061382-32651-2-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 00:02, Kuogee Hsieh wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> There are some platforms has DSC blocks but it is not declared at catalog.
> For completeness, this patch adds DSC blocks for platforms which missed
> them.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h |  7 +++++++
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 11 +++++++++++
>   2 files changed, 18 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

