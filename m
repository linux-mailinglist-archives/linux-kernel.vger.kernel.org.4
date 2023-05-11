Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371A36FEAFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjEKE5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 00:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbjEKE5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 00:57:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6182830EB
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 21:57:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f13c577e36so9002496e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 21:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683781049; x=1686373049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itZRHsCZE2zcyCX1vzhKeuooNDyGZUe67cjcA1Mm4CU=;
        b=e5KqmbVorVMOJBVVnUMiEUeI+rUfsaL74dacIVfp6mAXTQbID3h3LyvwpZglOIZ5yz
         DhIN3X6Wd2ReW6YuIQkMERthlsc/V2q5SV19RgnGketJ5D+2hVcTuKKaPGJM6cxLQMUU
         JNy+VphjHA1x7g3w3/x/iV/yDC6+5urluSynaR9xeCkAPghATCxflHyw5Vebanz9DtRJ
         +3heLAGU1m8woS+CQjFACnOoMvpR1JuwPcNBnnGjvzqZYFzGPJuckFZIMRCoMswU+ezL
         Y/D2TtfHC7TILC4JQ8zVbck5ajK7qBoJ+AQqnXQBn1CCgLWYWoroq0MsHrNoA3qp0jYj
         QJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683781049; x=1686373049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itZRHsCZE2zcyCX1vzhKeuooNDyGZUe67cjcA1Mm4CU=;
        b=VCMbsrvHK21pDfJ9QgPAgoOwOa+Q0hLpmGHV1rh3bImH1yM8fjk/nUxAWZzcbUq3Vo
         B4xXJMKnnf8pLRONsKZSK/UCKR7GKkwsKoZz+8n5WLNzvDmPAlqWwu8mNzoNMNkC/GNU
         dk6fAWB9OyVytlvFEzzF50M4On3l56jDhO7JzR/UjpMnrzaDaWA2gW7t9pfXaC0m2f9d
         7YvS6PaesJaOSl38YCdzeqA0l2QO4z4jACzx0Tzloub51CWD4fxxzd603bovDRf4mlPm
         q91RTeqmJ854y9AMGea++gqxVm4gTv3oN4fCCqL9RTDcBoIrOtNyTMW8z6LnhwJl7Yb3
         W6Kw==
X-Gm-Message-State: AC+VfDw3ewK862mZsk6TbXK+YP/bZY/wHB1VGWUv8GQTzxstw+9LYRSA
        2s2h8AOG3q/ku1kyg3lRMVziRA==
X-Google-Smtp-Source: ACHHUZ5THrVgIUtCaqiWGbdVsUTiNoc2umxTKKO79kDZuUT7R5l68KrbGKwtK9zO17eNJxwyjqeOvg==
X-Received: by 2002:ac2:51bc:0:b0:4f2:6ddf:2011 with SMTP id f28-20020ac251bc000000b004f26ddf2011mr108174lfk.19.1683781049635;
        Wed, 10 May 2023 21:57:29 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id j8-20020ac253a8000000b004db3e330dcesm962693lfh.178.2023.05.10.21.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 21:57:29 -0700 (PDT)
Message-ID: <72ae1bbd-e4c4-3b15-aa35-c6693f2ab677@linaro.org>
Date:   Thu, 11 May 2023 07:57:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 8/8] drm/msm/dpu: tear down DSC data path when DSC
 disabled
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1683756453-22050-1-git-send-email-quic_khsieh@quicinc.com>
 <1683756453-22050-9-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1683756453-22050-9-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 01:07, Kuogee Hsieh wrote:
> Unset DSC_ACTIVE bit at dpu_hw_ctl_reset_intf_cfg_v1(),
> dpu_encoder_unprep_dsc() and dpu_encoder_dsc_pipe_clr() functions
> to tear down DSC data path if DSC data path was setup previous.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 44 +++++++++++++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c  |  7 +++++
>   2 files changed, 51 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

