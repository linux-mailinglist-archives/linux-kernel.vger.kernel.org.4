Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2036762FA72
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbiKRQit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiKRQio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:38:44 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DDD62051
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:38:43 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p8so9032842lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=//tIyOnKPA/iZeg3Et4uYN9NmJnJYA0WTAZ1QiP08n8=;
        b=vKdrftphtMtov+8nlbBce6xE5zlGdHxeDTePcVcvufdsz77Yfps0DeXayZrmIOM3CF
         ICuPDaCEsuf9SmG4WLgQm4Hp31jctQPoNDGoyxfsuF/Iq7//1AIYUDlMH6vZBKQ48Gk1
         wYkCI6ul0gXegOxFElSAlFiFP2gGLNwr+lfSXY3BjbQwIJMWI4FzzJOOeSFCAdpidimj
         cWyeTpNSzEcmTnStP9Z0WxldfLqUtw6cuw4M/pAWHiyTGJn6tVKv1bc7ZCaX00tnmUQL
         0z+t1iLuReVzr3+1QxXNmbENNzFmIU82+3jvVUhybQP0ZshXj8OR4UfV8nq3Y/kdTwa0
         FqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//tIyOnKPA/iZeg3Et4uYN9NmJnJYA0WTAZ1QiP08n8=;
        b=1Pz2WTpMoiaSJdpS8F53THN1XuDmus9Zq19lbt3lpHeagQJgekw+DR9trkA6dpeWqs
         1WWinv5eM//WLYic0ZE2bOITLUH8qMWeLPgKWJnpvvVPOspszhkgqt97KLp2NICPUdFO
         kNIUAewXPeyomFmdwe/54UsRV1P/cJg250vdRZ2wsdm73Y19CZyOTsqoxACmZTBSp9b1
         i9vhhZuFnwIfwqJ0sy1RO8fNmLvzuCmbwroUhscnN0aP92ES7kIQJXrP0Cw6mK4lzDvv
         M8Gs97swjaeR3EvBP03vawcrbzQ9byLfJYqZka7jze+Xn6I5v2di5mmufTGGipVV0uTW
         qAwA==
X-Gm-Message-State: ANoB5pn9ScfIBGQRSSBz9dLPsOF643vhuO6UwxefZatnbdLMWOSdIbhf
        Q71TyNZmbKHph8HDd1PiAKPodQ==
X-Google-Smtp-Source: AA0mqf67eaKlAXmxGcQbSZPBKb/PDZ/zIfqG8B4OZOOEkWap6/wMTj9F/yrMbuK1asszhID7j7JRWw==
X-Received: by 2002:ac2:58ee:0:b0:4b4:af5d:1e22 with SMTP id v14-20020ac258ee000000b004b4af5d1e22mr2552908lfo.660.1668789521735;
        Fri, 18 Nov 2022 08:38:41 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id n25-20020a195519000000b004ae394b6a6fsm724080lfe.246.2022.11.18.08.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 08:38:41 -0800 (PST)
Message-ID: <137c685c-f889-e29f-af0f-67c3395fc7f4@linaro.org>
Date:   Fri, 18 Nov 2022 18:38:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 0/2] Add data-lanes and link-frequencies to dp_out
 endpoint
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1668789389-14617-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1668789389-14617-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 18:36, Kuogee Hsieh wrote:
> Add DP both data-lanes and link-frequencies property to dp_out endpoint and support
> functions to DP driver.
> 
> Kuogee Hsieh (2):
>    arm64: dts: qcom: add data-lanes and link-freuencies into dp_out
>      endpoint
>    drm/msm/dp: add support of max dp link rate
> 
>   arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi   |  9 +++++++-
>   arch/arm64/boot/dts/qcom/sc7180.dtsi           |  5 ----
>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 10 +++++++-
>   arch/arm64/boot/dts/qcom/sc7280.dtsi           |  6 +----
>   drivers/gpu/drm/msm/dp/dp_display.c            |  4 ++++
>   drivers/gpu/drm/msm/dp/dp_panel.c              |  7 +++---
>   drivers/gpu/drm/msm/dp/dp_panel.h              |  1 +
>   drivers/gpu/drm/msm/dp/dp_parser.c             | 32 +++++++++++++++++++-------
>   drivers/gpu/drm/msm/dp/dp_parser.h             |  2 ++
>   9 files changed, 53 insertions(+), 23 deletions(-)

NAK. See comments to v3. They all apply to v4, except the removed pr_err.

-- 
With best wishes
Dmitry

