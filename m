Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B8C6E866F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjDTA13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjDTA1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:27:25 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6074159E8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:27:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r9so898047ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681950441; x=1684542441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJiK/C1Bp7VUIfdmCaPfsFY4/Z95o9zQhrrUL3cgcwM=;
        b=FuDE91Glj+OEtbz8Ziz6K/mV9+nm9O9GJONoNRwe8JWNyjcaUX7irgXJ+eEQuE+hbQ
         VvhjthMBolr5E7n7U4pQZCyYPZT9kZpWH8At/9Gs8bDyQPbj3SUfKA3xBHjJp92CChex
         IzwkqYU3kxHV4c+ka1pQxC0mPnBmPkI2+ER012BebZUedO6XLgnemQHjUY2bBoEKtyfI
         vhhVh+IvZ+pRD1Spb/+iWDkJTm9Rstdg6vUUgOu1yiPkT+zNckMXLHr2TFIvwdGT2Ma5
         Ns7uj9NW4T2Vn/wxeuz8CQG2+QxPPD7sGw8MpSN9FzxXBJdHmm4kTc+Iioj52QclVTFH
         Ph5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681950441; x=1684542441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJiK/C1Bp7VUIfdmCaPfsFY4/Z95o9zQhrrUL3cgcwM=;
        b=eU63eZ/IoVhmp0iOqJJtJ6ngEQlxOxq/jhw4OWGxnEenChS1BQH1ViZWCGors6vCK9
         Le0gqN5YK9mEyI41iUkBiGr/5TScZbt10VP/q+OnwaXq3QMIkY1tZPCmPZ6rb5m/Ho+f
         /Kr0bp528Y2VSDb7I1hPQE1DLNPS0SxnQxYXgJV/HXljw6kv5s1cNdlGbVQRWfEwiUIo
         VBvcjjNhPyRoda6NAlu0wtmaZ8+T6mb2s23kPfcUPqOAcimBC+T0lkh3q+r7PDyH+2jw
         NBQnp672m3nvsWAI0UH2R/JiRAJFJp9M57TOjmgzsmxJULYO62c0787DDKEMUIpFLleT
         yCUA==
X-Gm-Message-State: AAQBX9eeEzFxl/xYxTjOXY6mx1EkEJBgZhHX9ppx4mvIvM+a4M3COCrw
        QqF0ALxHnpOtkFGE6HTISngJ7Q==
X-Google-Smtp-Source: AKy350Z5iHH9rCjCwK6eiqlfzdtPwfCU6JEJtPtp6nI1ZchktQR8QqKq0BXI06ZgSNaOMbsiOJAJ9w==
X-Received: by 2002:a2e:9652:0:b0:2a8:b129:f735 with SMTP id z18-20020a2e9652000000b002a8b129f735mr2281704ljh.28.1681950441623;
        Wed, 19 Apr 2023 17:27:21 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e17-20020a2e9851000000b002a8c2a4fe99sm10765ljj.28.2023.04.19.17.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 17:27:21 -0700 (PDT)
Message-ID: <11b3bd19-fe23-439b-3f76-5bacfca83aa0@linaro.org>
Date:   Thu, 20 Apr 2023 03:27:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/5] drm/msm/dpu1: Rename path references to mdp_path
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230417-topic-dpu_regbus-v1-0-06fbdc1643c0@linaro.org>
 <20230417-topic-dpu_regbus-v1-2-06fbdc1643c0@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230417-topic-dpu_regbus-v1-2-06fbdc1643c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 18:30, Konrad Dybcio wrote:
> The DPU1 driver needs to handle all MDPn<->DDR paths, as well as
> CPU<->SLAVE_DISPLAY_CFG. The former ones share how their values are
> calculated, but the latter one has static predefines spanning all SoCs.
> 
> In preparation for supporting the CPU<->SLAVE_DISPLAY_CFG path, rename
> the path-related struct members to include "mdp_".
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 10 +++++-----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       | 12 ++++++------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |  4 ++--
>   3 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

