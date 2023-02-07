Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB54D68DCD6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjBGPVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjBGPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:21:45 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E7329420
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:21:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m2so43984178ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTPYfaNfHTlgzHYyV9+fBlSvLMoaCZHX7hD5pX806Bw=;
        b=yM2LjNDtT8Di21u7MkpL8aEYysXvyagUm5aFbBZ47I6Hp8/h+0a6HUX7mqE/WMGGQM
         WnHyppQiTUdXfcPULg81UxftTgArLfn0DrEOlvPmqv0GuN4frYzktmX7+3FTAtBE5TZB
         3I1Gol6P/42HRIH+oV61kzOydHpL1TAaxE+RUOLmFhuc9Aq/M64FlW9VdvsSKLjzZDmj
         XCNiFpFySOrnA/GcbDMlWlzg1Q8NDk557SxUE4x4dZK6FAUPZfvfjd8J9EFLbhMEbkDm
         v6+t8B2cMGUkBTM/WBn5ksA8GWz1UBv6/tKz8nkVe6mUM3e1Qb+L2TVtzPB6LPeRR4j6
         Pt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTPYfaNfHTlgzHYyV9+fBlSvLMoaCZHX7hD5pX806Bw=;
        b=X+AbI2v/EUDswO7fvfYGbSo8nHfVW3pXr80ZV5euiG/k4P7aLov3Lwbb3WVMAR4MNZ
         KVKJLZls9RdFqW/ZjpukFPFiEfzVBShW5ETdFE3zR7dN41yQFR25o8hnV+ldC2TbJKtw
         SsIUR3Q35ARg4ywBABkQCcaVstBIVXQuOqnNW8a9x/ISv2HuLqXyppEq6ygaYAWKODmB
         XNpjB0xh+xiVDPwC81BQDy/WckjyPLh+GVVa7bDdMUQoRPH7uWgPhZ89jzIJ7IB8viXj
         ymECNAQFtRHAIdrsZ0+7NaSoUyrxae/gl/IR5b651QbHNxFU4LExnxMnZyxxvwWbAhGM
         LFyA==
X-Gm-Message-State: AO0yUKUU7JUfQo1sLZURpoDpxGzARYBViw9lR0M6xC4cewAzYH4aJhuA
        r1Di4HWRS9grZ62y5j0I7MDs8g==
X-Google-Smtp-Source: AK7set8584YuXOspFQeCKZnkVa3k+0F5o6MK5ItC2rBbYRItlVp13BBNRpy1PcI/NjxZgLO++QQCdg==
X-Received: by 2002:a17:906:604d:b0:878:7b5c:3811 with SMTP id p13-20020a170906604d00b008787b5c3811mr4171364ejj.42.1675783295577;
        Tue, 07 Feb 2023 07:21:35 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id bl11-20020a170906c24b00b0088d0b51f056sm6921120ejb.40.2023.02.07.07.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 07:21:35 -0800 (PST)
Message-ID: <f57c7137-0470-ca04-68fa-f0a2f5fabb4f@linaro.org>
Date:   Tue, 7 Feb 2023 17:21:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/4] drm/msm/dpu: avoid unnecessary check in DPU
 reservations
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com,
        marijn.suijten@somainline.org
References: <1675780196-3076-1-git-send-email-quic_kalyant@quicinc.com>
 <1675780196-3076-4-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1675780196-3076-4-git-send-email-quic_kalyant@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 16:29, Kalyan Thota wrote:
> Return immediately on failure, this will make dpu reservations
> part look cleaner.
> 
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

