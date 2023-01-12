Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891B3667F83
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjALTpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjALToe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:44:34 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB73E13D7D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:36:30 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g13so29929018lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QP7ZDXy/vz6h2E8Aw8jzhMKk5b2tVMVMs8kkY7DjRxg=;
        b=VRa1lYmLZwBt9u8EhEFY9jOztdyhUc0rbhIsKErJjegBmGKvqae+ioHuWXiDv8ojQs
         VlENQvWkzosriREEEtozgXWWfl2TYj+fITtabr02X4YmTjsxazE8spp0ZSVPe17AF+0X
         Kf++ghoP05TZk5uCbVqQ4pz8Ihs3X6acl8/V2BC9zwxAM7bcjHXKeSHrYOXCD3wmXeZX
         L4vzc9sup3I3A+2RRNz29LyV3BXZWW9cdvn1IgEczE5Hsv/XyXDC0rNvAl0kQsgdRV8O
         2fpL+QlmoVN5qFyfEgD9on8glRvlVvMVbwnRpaFg9M06xeZiV+rObea1NNJzF+hKYPgZ
         n4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QP7ZDXy/vz6h2E8Aw8jzhMKk5b2tVMVMs8kkY7DjRxg=;
        b=PFpW9SXpWNuS87SnmQaj7h/MTVCyx5XhuXA0l09TL3Q7NZBpGbfB07S+kb51eLt+to
         QLJhiEjXTeElYUHdHVU5oTxxctZ3Rar0W5ajuuvXJ808P1LWc3yyk5b7z9RwAlN5rnzU
         wqfo/UNL7UJOFU9lkOn7ISJmuzYkeDGnBdi1tHOo4P9lVKGSYi3oy+swnQywFFgjsQY4
         M2/ibgD2efBpd9ts7h+mqfjnDLXqwt806LHwaeNmWt44+7LscI5m1erRxTd8h4pJIytt
         jQtU/FwvPSYdm6ahUT1cYH09Tew0lqMORa2OrcF3KM9D89zTJl7hWQTjFWIHCbhkaRZ6
         aqFg==
X-Gm-Message-State: AFqh2krgBsSHhmi6KWSkh9LGkfs66jnzLcC2597mLf5PjrfQRvim1w9I
        tOTbK2Va1PYHtXU82019I7kFNA==
X-Google-Smtp-Source: AMrXdXuCP2iZ9ad22QlH8IWK4c8i8Rc8dMqOQZuciPiR9xdgK9SnFECFIPl7JvZMmqyyu5q35RCHjw==
X-Received: by 2002:a05:6512:33c4:b0:4cc:53e2:5387 with SMTP id d4-20020a05651233c400b004cc53e25387mr10413221lfg.50.1673552189189;
        Thu, 12 Jan 2023 11:36:29 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id k17-20020a05651210d100b004ab2cb8deb5sm3403247lfg.18.2023.01.12.11.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 11:36:28 -0800 (PST)
Message-ID: <790207ad-9184-577a-ed0f-55e04b26aa09@linaro.org>
Date:   Thu, 12 Jan 2023 21:36:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 0/3] add color management support for the crtc
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <1669021695-4397-1-git-send-email-quic_kalyant@quicinc.com>
 <167330408778.609993.9217470869804308069.b4-ty@linaro.org>
In-Reply-To: <167330408778.609993.9217470869804308069.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 01:43, Dmitry Baryshkov wrote:
> 
> On Mon, 21 Nov 2022 01:08:12 -0800, Kalyan Thota wrote:
>> Add color management support for the crtc provided there are
>> enough dspps that can be allocated from the catalog
>>
>> Kalyan Thota (3):
>>    drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
>>    drm/msm/disp/dpu1: add helper to know if display is builtin
>>    drm/msm/disp/dpu1: add color management support for the crtc
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/3] drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
>        https://gitlab.freedesktop.org/lumag/msm/-/commit/a4d6f8253645
> [2/3] drm/msm/disp/dpu1: add helper to know if display is builtin
>        https://gitlab.freedesktop.org/lumag/msm/-/commit/4cb6b1eebb92
> [3/3] drm/msm/disp/dpu1: add color management support for the crtc
>        https://gitlab.freedesktop.org/lumag/msm/-/commit/c48c475bd75a

These patches break sc7180 in a bad way, as the SoC is short on SSPP 
units. I'm going to carve these patches out and wait for better solution 
for the color management issue.

> 
> Best regards,

-- 
With best wishes
Dmitry

