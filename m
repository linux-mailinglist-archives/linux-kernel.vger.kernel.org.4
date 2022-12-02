Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2666164003D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 07:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiLBGSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 01:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiLBGS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:18:27 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29479CEFA9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 22:18:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id cf42so162897lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 22:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAVoHCQgXrBFJsGVATQHU16QH0b4cZRi90HUn6wrjZI=;
        b=qf3yVPTn33uUQtgKtkbptzLYAGVYwWMMDke9A+PeIEDqE5NTsloHp+qS++xmmvt2on
         b5ph9P//n36wmI9UCDCugjDgg3eOl+V79FdQj4H1fuVl+x5mS4bzK7AAY7Eoc4DwZTgV
         F5LeE99v/njeVxMj710FS+kwyzvU6VvXU8sg+pnPoTr5fX0j5+8Fbm/wXgoWvmHPZnsq
         bcnhiniKT5pgisQIRYzVtv9eMGDAetie+5b0ZaYIGpCgqD8BxUy6MPsK+AqXPDHuotjD
         9NKBhQHoIY1hFqvkSmPNtIRBLwRnGCh3IWuyMjvwKU3cyzaUIAc5QH5gJHwn+GjffDXO
         L9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAVoHCQgXrBFJsGVATQHU16QH0b4cZRi90HUn6wrjZI=;
        b=1Yj1eHPfVWyAp6NWIRTsexrIWoeybdB3IymizuLVTCBrxTSPVCIMUOjz8gglvGF2fj
         3r0p0ec38SOA6u5gWkRGjMci7HwmN7duNEd5pb4elzI4jywHDwPY+bvdqW0DfHaakVCn
         H+AmK9IPVTv4QiTPeuUFma/dyUhgDkF9UQc4oAxlwcDcCMOrKfZ7Dj3JOgFIsq+5rBdP
         65rh1oyA48BDIlJ9/GdaycFoSVOHySmaTg7bxpoddn5m/Diwo1+cykuFd/EBdVI818lw
         WWQjCU2E6f+CLM+GrlMd4y4HkvluLDS9M2m+X9TfvwMzzRCM+1S4XLkQX7N3Zo+xMOHL
         6UUw==
X-Gm-Message-State: ANoB5pmar7Elc4j0yM2b0v5nQYxyGuJcUdS0jtIWsF2yIpiQLeQQ/gve
        D7265BptGBYSTSwOX2lKAuYeyQzGwcQqk1uVsHI=
X-Google-Smtp-Source: AA0mqf6K7a50TcFw/T4WgLOspYuBc4JsAEMt4ka9AfjGreJAQnxcirNF4ufy92rPF7BT2NtVDjVGnw==
X-Received: by 2002:ac2:46f8:0:b0:4af:5088:8fa3 with SMTP id q24-20020ac246f8000000b004af50888fa3mr24674056lfo.538.1669961903357;
        Thu, 01 Dec 2022 22:18:23 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u14-20020a05651220ce00b00497feee98basm897812lfr.274.2022.12.01.22.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 22:18:22 -0800 (PST)
Message-ID: <8aa37c6f-e545-8d7a-1c34-b9dd7a46c5ad@linaro.org>
Date:   Fri, 2 Dec 2022 08:18:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 0/5] Add data-lanes and link-frequencies to dp_out
 endpoint
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, agross@kernel.org
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Also, please fix the email address list you are using.

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

