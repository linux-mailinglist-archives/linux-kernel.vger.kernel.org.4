Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7046E85BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjDSXPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDSXPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 19:15:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A998F191
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:15:07 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4edcc885d8fso196212e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681946105; x=1684538105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YZ6tzDhBHoxqn9D7YfaUk4sImwK4WUPTagbGMWR7JY=;
        b=u6gmlUMkLm1+0ml06EFobhtQeztdP4pBSEKIWMHppFiUrtS6VBuSy9UMKHFXBUqRRA
         37QWmxbh2Ze7KJolHfky0xbMgf+/LQBCASFqOonSslugWvOICjLOYNTXpbziWDX57OeQ
         mPT/wD6i/W5YqvMh0c38AGQ47Wx3w28LxEUi1cj0o830LfW/OSIkpWxEjZoA48axMsVk
         vybQHuC+9TU8nF48+tFmh7kQlvtRFxI4Z4wfiuKU95lMGuZfrbc/sp22j2B6PPXCbVK0
         v8iSk1IOXgg9mz5R8Mc6CKCh3UZ2YX+HtTFdLX4QSQseEJvVBOn3rOTSPMhgXBJX4yFN
         6flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681946105; x=1684538105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YZ6tzDhBHoxqn9D7YfaUk4sImwK4WUPTagbGMWR7JY=;
        b=FM0f1SNJrQxfcKq6xJTKF3+KFFTs/J83GJMmC82AlQAkpC5nFyWsOjpJMKohlOuHvv
         ChXsHow52MgtzUA6Um90UCJNf6pKyWzKX5i0jFIz9YPDd5h7yjBGMyjSfj9YV0wfWTC7
         RpjbDybARz5JeY6+Dg3Shk2F8GbQAWgU3yfjx2XMfAM6FsbkP+iiiUfXIW/VG/YV0JYT
         ZR+lJDwg+A2dXsq82OEM8P64xahKqPL4yc9jG2yYEP10z3GAdaBH1jbFyXIZr6i7SIfm
         fBliYTjXtHCgH7zoXvoQB96JbujCfO38HTNfanmz76cydkmnmE05T7SuGKekFF2Ea5XY
         pT1A==
X-Gm-Message-State: AAQBX9fjHes9EbKpaPU6o9pDaIvfDc+aeQHBx3dIKRyqqe8EsCE/WxLs
        owQDvTB32S5EiT6/QnKU0BviEjjEX/0RmJFJSXg=
X-Google-Smtp-Source: AKy350a003Xu5N/bKavKb0DBJWKDAKeS8K5taKhyLqOwxeqco69VHxlF/BnliKq4FwNQnA5bIVsoBg==
X-Received: by 2002:ac2:4acb:0:b0:4ec:363a:5f17 with SMTP id m11-20020ac24acb000000b004ec363a5f17mr4233644lfp.21.1681946105653;
        Wed, 19 Apr 2023 16:15:05 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t14-20020ac2548e000000b004cb14fa604csm33888lfk.262.2023.04.19.16.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 16:15:05 -0700 (PDT)
Message-ID: <9fccde38-273d-faec-7a5f-b521d4daf559@linaro.org>
Date:   Thu, 20 Apr 2023 02:15:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/11] drm/msm/dpu: tweak lm pairings in msm8998 hw
 catalog
Content-Language: en-GB
To:     Arnaud Vrac <avrac@freebox.fr>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
 <20230419-dpu-tweaks-v1-10-d1bac46db075@freebox.fr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230419-dpu-tweaks-v1-10-d1bac46db075@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 17:41, Arnaud Vrac wrote:
> Change lm blocks pairs so that lm blocks with the same features are
> paired together:
> 
> LM_0 and LM_1 with PP and DSPP
> LM_2 and LM_5 with PP
> LM_3 and LM_4
> 
> This matches the sdm845 configuration and allows using pp or dspp when 2
> lm blocks are needed in the topology. In the previous config the
> reservation code could never find an lm pair without a matching feature
> set.

And this matches the hardcoded configuration in msm-4.4

Fixes: 94391a14fc27 ("drm/msm/dpu1: Add MSM8998 to hw catalog")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)


-- 
With best wishes
Dmitry

