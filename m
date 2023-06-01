Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEF971F5B1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjFAWLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjFAWLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:11:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCEC197
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 15:11:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f5f728c4aaso1427956e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685657468; x=1688249468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cUjU1QLapAN+UOQb7bMW7gqVswYS7FmmwKe3gGeC7nU=;
        b=NzQu6xWyAFPvysWLbKbjyISj5llZOGjpXFor0IW7wWZYGGutpqSrbRPegCB1UNXbj1
         +Cfo6V6omcyq+wguGbUPSpbmATrIfifLQFztqwQ6zwKuyhp7cYRUceC5BzwBguLzGOG4
         HMh/jBDMKhW7pSVQGRt6iviF3gkVXhuU0fwbSdeSKwt4bDV3R3xrdccEGuie2JFzOwjX
         UYt7JQ3Sw4Wi5FObT3oob6cNsgLye6KZePYWne+7CYZBM+Dw10aZSZSKH5V3xxj2XjZ6
         UOQWGJxst7qfSD7cqJ8yHghKi1KL3dCUrtnmzAhC7eud1LJx/flZqmDAaNHsI/Jwb6FJ
         99Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685657468; x=1688249468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cUjU1QLapAN+UOQb7bMW7gqVswYS7FmmwKe3gGeC7nU=;
        b=KvVmJfkKgQKXgOi7xq4dYVp3qrLuEHSOtiga0G2QdETFNYPfw876Zv2xG9/T0MeQL0
         wEi6hMJom2iblmbdcSi4EvdB0mS6Cc5otwfZElHiS058guBi3QQ63zQ2vyQtBe8Nwuqz
         TNEp1FztRtK2VA2niXqReK2FFJqzTO/UFLFiRt+VqC2SXO6AOIM/+9EPcsTwNpccRvt8
         0KzVIwcWcVUGyJOGps2LLyDCF9hU7P/qGKWVNe/Pdf0qOWQyydaWwON8SwquRnsdEJyQ
         4oyirZXgT/+3CAdoPQNgI4xsv9NNdEOoHn2XIu3P4VlPw4jryb+Nuuo623imEj5j0ZR5
         hATg==
X-Gm-Message-State: AC+VfDwm22RFpf4jvETywrqqJa7ytJQBYnGIaWZnCP1s7vbRNVnGMAx6
        MrNTqAymyRKlFdVb+uFDWdY9rA==
X-Google-Smtp-Source: ACHHUZ4Z1RCAMlDskOyhcoYf/TmzLDNh/sz5WfMVyoGVLrhlKAvsxKhMJilmOZ4JHXoYcwc2vHQpug==
X-Received: by 2002:ac2:560c:0:b0:4f0:13e3:a291 with SMTP id v12-20020ac2560c000000b004f013e3a291mr319581lfd.28.1685657467880;
        Thu, 01 Jun 2023 15:11:07 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id e2-20020ac25462000000b004f38e55ae79sm1205559lfn.278.2023.06.01.15.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 15:11:07 -0700 (PDT)
Message-ID: <22853a86-b327-60db-3c47-cbb2e407c10e@linaro.org>
Date:   Fri, 2 Jun 2023 01:11:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/2] retrieve DSI DSC through DRM bridge
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
References: <1685657331-23280-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1685657331-23280-1-git-send-email-quic_khsieh@quicinc.com>
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

On 02/06/2023 01:08, Kuogee Hsieh wrote:
> move retrieving DSC from setup_display to atomic_check() and delete struct drm_dsc_config
> from struct msm_display_info.

This is obvious from the patches themselves. You should be describing 
_why_ the changes are necessary, not what is changed.


What was changed between v1 and v2?

> 
> Kuogee Hsieh (2):
>    drm/msm/dpu: retrieve DSI DSC struct at atomic_check()
>    drm/msm/dpu: remove struct drm_dsc_config from struct msm_display_info
> 
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 18 +++++++++++++-----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  1 -
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 --
>   3 files changed, 13 insertions(+), 8 deletions(-)
> 

-- 
With best wishes
Dmitry

