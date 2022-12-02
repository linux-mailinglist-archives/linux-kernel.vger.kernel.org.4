Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B679764002A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 07:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiLBGPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 01:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiLBGPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:15:39 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76E3A8969
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 22:15:37 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j4so5981120lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 22:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VN8FP/RUaV+zUxP2MmDTHFuGbxLaXmlrobBE54QvUGU=;
        b=B94KH7/+MPgOOldQUJtFKXLx5k5rPJMWPagVyNJqTBYAPrKqi/XKTfF6WLkdJvWgta
         dmpuqYq45laZOgEl1c1kLoYYvcSLvmc4H2Zd76TW3xYfFn91QQs6ehRu/cluqsWhEch/
         X0WM0mKItuypItMrH9UpXMBrOlAc5KgZPb+cyoHmDZ128enPn2/eg8Ptb4CfkhUs60oy
         21zxBARtPO+jHwnKOSPKHns9UBkn72Dd2V6tG3Ne++lM4+FCnJaEgUhWAGfD3Xv0Qs0W
         na8wgzCJYIKNryoFVJnZnVaN6KPhqYq5quC5ih1NKbov6bceCxZhuUspXkbHbYY+9kz9
         iBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VN8FP/RUaV+zUxP2MmDTHFuGbxLaXmlrobBE54QvUGU=;
        b=lQARxhgHZIgrSx3QBMhG6KvN9DYBvJZ1fQyuRJ7+D4b9CDBEr8WqPCBFEw0dmrQXUw
         bvqXzMwHYWQGTNdII47l/6AVVv6gyIuGYIgh5BD52g5N4Xi8GbKaNvprHe1F8k/Ij1Ll
         YRB67CN16oAc0rxIX2xGIo20VTk3mAB9BRsQyx4Zna3U1gAWo7d4UrzjV4zr99EfdG4z
         BgmjR4XA3Ui+0MfpdTUzg9OiwxOfJwo/cu+C6ollqX7x4bvnBfRXIsTfp0M9o/ZHFPNA
         HOoKb8gY6rSpMSlLw2J+yajLSkLaeUVd0we1OoczAsxVRW6XbxY3+ep0ghNs4qPLkSY1
         3veg==
X-Gm-Message-State: ANoB5plJ8ZAMZmjDbrN3yaJ+1QL3XS+5/0Nebq8d7rli3UcAErKM7fUO
        n4LDkmHDsgfIkKHSxZkoEcJ9Lg==
X-Google-Smtp-Source: AA0mqf7H3gdqVppExL9ZynWx8Zj/mUNe7AYQKRTJ1LKfkyvfhfWKsGnBzHLDWHjb/V05OjYT9/3snQ==
X-Received: by 2002:ac2:58d7:0:b0:4b4:fbce:606b with SMTP id u23-20020ac258d7000000b004b4fbce606bmr11712982lfo.27.1669961736149;
        Thu, 01 Dec 2022 22:15:36 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id i14-20020a2e940e000000b0026dcf81d804sm521425ljh.31.2022.12.01.22.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 22:15:35 -0800 (PST)
Message-ID: <37ab278b-7f32-b162-c62d-79e695ff82ed@linaro.org>
Date:   Fri, 2 Dec 2022 08:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 0/5] Add data-lanes and link-frequencies to dp_out
 endpoint
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1669933049-13106-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1669933049-13106-1-git-send-email-quic_khsieh@quicinc.com>
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

On 02/12/2022 00:17, Kuogee Hsieh wrote:
> Add DP both data-lanes and link-frequencies property to dp_out endpoint and support
> functions to DP driver.
> 
> Kuogee Hsieh (5):
>    arm64: dts: qcom: add data-lanes and link-freuencies into dp_out
>      endpoint
>    dt-bindings: msm/dp: add data-lanes and link-frequencies property
>    drm/msm/dp: parser data-lanes as property of dp_out endpoint
>    drm/msm/dp: parser link-frequencies as property of dp_out endpoint
>    drm/msm/dp: add support of max dp link rate

Patches 1-3 are missing, patches 4 and 5 don't have proper threading. 
Please resend the whole series using a single git send-email command.

> 
>   .../bindings/display/msm/dp-controller.yaml        | 22 +++++++++----
>   arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |  6 +++-
>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi     |  6 +++-
>   drivers/gpu/drm/msm/dp/dp_display.c                |  4 +++
>   drivers/gpu/drm/msm/dp/dp_panel.c                  |  7 ++--
>   drivers/gpu/drm/msm/dp/dp_panel.h                  |  1 +
>   drivers/gpu/drm/msm/dp/dp_parser.c                 | 38 ++++++++++++++++++----
>   drivers/gpu/drm/msm/dp/dp_parser.h                 |  2 ++
>   8 files changed, 68 insertions(+), 18 deletions(-)
> 

-- 
With best wishes
Dmitry

