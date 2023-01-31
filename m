Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31AA682CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjAaMs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjAaMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:48:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E17935277
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:48:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x7so11046879edr.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvlJDPmyZkse1KpRICBczG4DN3KDD75qIE0L61Q0oFc=;
        b=Cfc/3ngAO6dfmwbQA5rSsm6nSh72mkIVWEBN9auSqFMhKTjoQU1G1HzmlU9fZmT0OX
         98UDAOEsBRoZoFDn2VMSotWMnXzOXYO35WG7W8fCEcN5+Q4nRZSns+CHoLRauR/qelVY
         nquZ1x9YF6K2W1HxEoSQwDjc1gcfCkTPtAfYJQ2fu6DIXwbMsbbabNj91meNE6QVrIkX
         OxY+w9JOKFr5ykdIGTh1IaNqsVZg3Ov+SrvGzLU3qmesAZfErkWOE/d2cah8L7scwHI9
         04Wm/o00JgvAVNDMXvfrfyyxFC20mYGgw00Ck/z87Lh5RZ/JZB/OfMyYs/8u5cblRhcK
         TAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvlJDPmyZkse1KpRICBczG4DN3KDD75qIE0L61Q0oFc=;
        b=2mYLSWs4nnKjCR67+h9sKzSVKQkv1NOTEZz1QNMU+OIyDgmUMOv0ZrB3vHgjgH+T0C
         NBf5QPyjx4kflZxfbrrsW7BYWIA+2CGb3s6OL3Vqaw8PUIAr062/uXi9VUebssCUU05s
         TzibGe5ds1VtrbLZfyN79ZOcjVSHUKsGLkEVUmCSvy0Lkug4OEfAmFCwuEJcTl27v48S
         qibI8ew03bC+Gxt42LvSl2Cl2gnYysNTGv38B9BfktPo1ud81DLfK1/ULCD2K76cw0ma
         NxuXl42qSssDSch5el31Eel8dL2pQWN3GgfpN4f8cqZDKrbXYWh55+FOHjQP+jt8Ags4
         SPQA==
X-Gm-Message-State: AO0yUKUHbr0T48c56Q51JrdgF/Zem6SMmrbUwsN0c5CWiI6Z22/s8iD0
        V/EWEAl5t0+6707bjZrHhN5DEA==
X-Google-Smtp-Source: AK7set//VQXczvKXDG8kHylj7whbqt4shHHQk5vvtfw+X5QnesrfSqmHthhMT/zpwao7sG/SwmfnMg==
X-Received: by 2002:aa7:c755:0:b0:4a2:2e8a:14c0 with SMTP id c21-20020aa7c755000000b004a22e8a14c0mr14119954eds.9.1675169334447;
        Tue, 31 Jan 2023 04:48:54 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d3-20020a50fe83000000b004a26665b962sm1003272edt.89.2023.01.31.04.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 04:48:54 -0800 (PST)
Message-ID: <670d0a87-a932-6f33-b363-5499dc7ff29f@linaro.org>
Date:   Tue, 31 Jan 2023 14:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v12 09/14] drm/msm/dp: disable self_refresh_aware after
 entering psr
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_abhinavk@quicinc.com
References: <1675091494-13988-1-git-send-email-quic_vpolimer@quicinc.com>
 <1675091494-13988-10-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1675091494-13988-10-git-send-email-quic_vpolimer@quicinc.com>
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

On 30/01/2023 17:11, Vinod Polimera wrote:
> From: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> 
> Updated frames get queued if self_refresh_aware is set when the
> sink is in psr. To support bridge enable and avoid queuing of update
> frames, reset the self_refresh_aware state after entering psr.
> 
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_drm.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)

As I stated in v11's discussion, I do not like the way this change plays 
with the self_refresh_aware. Please find another way to work around the 
timing issue (let's probably continue the discussion back in v11).

-- 
With best wishes
Dmitry

