Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A6661A7B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 23:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjAHWk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 17:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjAHWk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 17:40:57 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E8CF01F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 14:40:55 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bq39so10418075lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 14:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04VPxodDj8VYqfXc+AO5iDAa0bDV0HeRkmLR4Sxbnw8=;
        b=JGxoURkoihHFPGzdeL7AT0d0bJ+n0BJwTiUFG0q0xP758klKGYT7KZFxCbvFd5XxC9
         Tsqd97ZaxIgAMko3zqiKWZx8kAMEtpURZEkYGavS6nNFcuHa8zLOAZAj96aO2FIDpKu4
         PyBpgW1+YDBtkPtuDb02rPqv0LO4QIeaXA+m76hD1Tdp2VhE6uqU0YzhBxAJH9Des4Wg
         romWKqe6fyeLJYY6nLRCnaosA/P5eteRiRZvjYOMAL0X0cuXVlu5+jR3tcHZ2+iYt43W
         RyTMm14xjqSGaHgDUuq5L1nC/vPe+Ql4AFuFe0DtHfvxLdpE8KKb/FcKoRAX6Xf438vZ
         uSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04VPxodDj8VYqfXc+AO5iDAa0bDV0HeRkmLR4Sxbnw8=;
        b=yv8UOxi+w68YkBzXFYuKgbOn7i/LvuC2QXC3JttjRMSMYX32wOhG27toVihY2v1u8b
         sa1VD2NRRq7QSvr2GweJJY7u/9Tdhu9NdTZ5TfuDAKBB02XUtlQ4r08eDd7ekXVTZIAV
         a4WCoYM5AgCQA2tm06+j4CAMelxkMS64xwk4S2/c6biaICclK/AdQTtEW40LALhTDvcQ
         O+fMdQJlIUAdZhdIqQCiBHMdYTta7em++q/Bd2n+HazwIol2yob+qKHOCpdlmLpAOW/0
         C5T8bxgWDzbJlL1/caRu00ChjmiM2GzCaEgIcATDxY3IbWy/r53mnbieKPsT21vqv6ng
         MIiw==
X-Gm-Message-State: AFqh2kpFzE8AuKwGJ4RJ37fsShk8TwWx235b3e7c6rcJmfbVgUAjkd/L
        EmnFwKuN3LCS9yvUJgjMooDVpg==
X-Google-Smtp-Source: AMrXdXsYBiFkCm6HkGiZyLtZo4tZyRsq3YwGKIk3T/55haEfYPzQzsx4FvI2H0FaYtQAIQfOSd/7dQ==
X-Received: by 2002:ac2:5318:0:b0:4b5:7720:5fe4 with SMTP id c24-20020ac25318000000b004b577205fe4mr17346875lfh.67.1673217654007;
        Sun, 08 Jan 2023 14:40:54 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id 1-20020ac25f41000000b004b590b0c084sm1253296lfz.3.2023.01.08.14.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 14:40:53 -0800 (PST)
Message-ID: <698a7082-84a5-b805-3e7b-9c72810580f3@linaro.org>
Date:   Mon, 9 Jan 2023 00:40:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/msm/hdmi: Add missing check for
 alloc_ordered_workqueue
Content-Language: en-GB
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, swboyd@chromium.org, quic_khsieh@quicinc.com,
        johan+linaro@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230106023011.3985-1-jiasheng@iscas.ac.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230106023011.3985-1-jiasheng@iscas.ac.cn>
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

On 06/01/2023 04:30, Jiasheng Jiang wrote:
> Add check for the return value of alloc_ordered_workqueue as it may return
> NULL pointer and cause NULL pointer dereference in `hdmi_hdcp.c` and
> `hdmi_hpd.c`.
> 
> Fixes: c6a57a50ad56 ("drm/msm/hdmi: add hdmi hdcp support (V3)")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/gpu/drm/msm/hdmi/hdmi.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

