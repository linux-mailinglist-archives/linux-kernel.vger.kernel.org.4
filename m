Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA4B681A32
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbjA3TSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbjA3TSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:18:34 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E874B38655
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:18:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id dr8so13231913ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fIRqqOqpVqRjVUN22YESgyUqHwFPSL4VZRIDcAALzk0=;
        b=O33jMYK/mxbkswTrZQ7pPS/UbI0ctBeRZ4BWZvTBeNGOsc74pcU7NvUBh43XgbnKUN
         Y5/NatnpgtWUw9JVFNU12SYDn6XsGOqYgNEXkkhNPvoGM4Z6aqkGCQ7MGzucTnXaT0yM
         qDavtW7yENHt56XYymY+kDGnUu7g9GBBZyzeOzzezP7ZSsPXc9mm/XH8nvFpnBhfeCzr
         Zi5Ox5Fty4/ds5rrUP1lHhLKVxcEaRMVrDx7DwXsLLWinSqT2rN+PWXMLJmoB9TSPw5y
         fpXVd7D74ObUHVptgyY704nRKuHTXC4UtcTNEmjY0EdpmWHvPCBdZrKFNv4vhjYY3G/+
         wPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fIRqqOqpVqRjVUN22YESgyUqHwFPSL4VZRIDcAALzk0=;
        b=7m47qNEuy60bjMQEDxqKFmOonKDLp/0ZBcLpGoORKddma2850DhJiEA7Ve2Rfm0T9y
         HT3ih5ojpamQ8OzFo8WA8qr1jooJDkJV/iAYYuJYFD4KniYsUNKTlmw8ZlTqL+TMvsfa
         1QjtW46aUArs2sUZ8PKwop4uch0gZhunweHSjqW1dRm3e+XX8fV5h2BuQlJQ8WguhZDM
         WSkG+tUVbbkpkeURStWzsVNfvJvifB72WwxSk81q6pwJ5VV9Ahd7j85yN0tlC1BAh0fK
         Ifak5AmlE0/Et+GJ5nrCJU/8j6bS3akjxlq1J6UTdX4NeMZZlIzC9sIlNC9H/jmZrkw1
         CwxA==
X-Gm-Message-State: AO0yUKXQv39V0/5r2r4DJb8Qw9Cip3LinpLISdMQbea4VvyyHex1DcD+
        q2FsqGJ3zaZaUf5I+/PPX3IqTw==
X-Google-Smtp-Source: AK7set+6wv6rUoXBVutS7MvyjITK2qUIduGwzP07FHLaad0soJT8wioRedVLbLcyIxSJ5fP7a3wcUw==
X-Received: by 2002:a17:907:868a:b0:879:767f:6e45 with SMTP id qa10-20020a170907868a00b00879767f6e45mr18114656ejc.17.1675106311525;
        Mon, 30 Jan 2023 11:18:31 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id z9-20020a170906814900b0088091cca1besm4725741ejw.134.2023.01.30.11.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 11:18:31 -0800 (PST)
Message-ID: <31661b18-8519-cadb-0c56-6a1fa34633b2@linaro.org>
Date:   Mon, 30 Jan 2023 21:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/3] Reserve dspps based on user request
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com,
        marijn.suijten@somainline.org
References: <1675092092-26412-1-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1675092092-26412-1-git-send-email-quic_kalyant@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 17:21, Kalyan Thota wrote:
> This series will enable color features on sc7280 target which has primary panel as eDP
> 
> The series removes dspp allocation based on encoder type and allows the dspp reservation
> based on user request via ctm.
> 
> The series will release/reserve the dpu resources when ever there is a topology change
> to suit the new requirements.

Nit: the subject of the cover letter should include the version, if you 
are including one into the individual patches Subject.

> 
> Kalyan Thota (3):
>    drm/msm/disp/dpu1: clear dspp reservations in rm release
>    drm/msm/disp/dpu1: add dspps into reservation if there is a ctm
>      request
>    drm/msm/disp/dpu1: reserve the resources on topology change
> 
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h    |  1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 54 +++++++++++++++++++++++------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  4 ++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  6 ++--
>   5 files changed, 50 insertions(+), 17 deletions(-)
> 

-- 
With best wishes
Dmitry

