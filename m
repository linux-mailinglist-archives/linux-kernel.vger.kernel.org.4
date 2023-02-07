Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D9368DCD1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjBGPVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjBGPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:21:20 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED55137F3B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:21:13 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qw12so44005591ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TY3YqSgtXc7yaW9pPRW8aZSrHCEaGsS7+O63u9ldl3I=;
        b=BDeEn0a7Jk6LqV0BxUk/3hb/Z6Xqj/yV16kXiuoMOSqrXb0v03vNvq2OkZYT24I96+
         D3d6sJ4DVgsTUqaJU6izpGl7ntpCilk3ImM0ij9kj9c5KmNrJtR7ZtjCuZbw20z6a814
         UN4OYx011PWI6uoKNASUOjx8ulf2i2sofMX6LB8jSKn1xLUUeChZSXEecQiR4l3rhS4k
         Z27dYY+BEfiUwt9IqesyXQLQG7dbN+fXPUleEZp4kE3+Ib2IJq3eZAfdYehzVd8XoR4f
         blRkO33oFMGA0D55AxhK1Iw9iypVtaANBYwU73rFQgsgd+VknpjgxHybgmr8cPwL0vUk
         3Q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TY3YqSgtXc7yaW9pPRW8aZSrHCEaGsS7+O63u9ldl3I=;
        b=SexTynTr1WCn/9ujzg7zV+iDibwWByd/iDCBESCMn1NuAdXhXCJruhsAP+BS7mft98
         ObKVGbsGp0EQ5m565Hv9LG1XHs62BhFwXQ8SDvmmg3tJxU40gwGr6LawT3QWHK57EQMK
         BMDAvwzEr+sZlftAra00UAEQCGh7OT+rlZ80N/tkY70kMgUyLt5HgBokmt7bnjHnfTS3
         2cF7fsKUBYuxqZjfyBT9K6j9PwOQBssexU0auL0H1aqqhm5x15n9ixlvrv6t1Zj2SglQ
         vroYwsZEMZYIr0SS5kcXLUu/2n624fLTzxVz/HggFqKaj8VochHzdMfjasTQ1OBDQ1dV
         2fDg==
X-Gm-Message-State: AO0yUKW9wtVhsULdFa7RMSFqUYnmxH00zP7d3UhtDNsE7UkTgWFk9PQ/
        cFIl+deJRws2wMzNOw+m1Fk6Bg==
X-Google-Smtp-Source: AK7set9QmfJciUrF+W1hV1GefjIjPjj85Ne+J1czfDY4PfZoxbZ0XbFaVW/41jlt6Tah5s19gAACJw==
X-Received: by 2002:a17:906:560f:b0:887:6c23:193d with SMTP id f15-20020a170906560f00b008876c23193dmr3840701ejq.7.1675783272577;
        Tue, 07 Feb 2023 07:21:12 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c18-20020a1709060fd200b0088f8abd3214sm7026217ejk.92.2023.02.07.07.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 07:21:12 -0800 (PST)
Message-ID: <fc32fe18-ee54-7ef9-3cc1-e9ead718961d@linaro.org>
Date:   Tue, 7 Feb 2023 17:21:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/4] drm/msm/dpu: add DSPPs into reservation upon a CTM
 request
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com,
        marijn.suijten@somainline.org
References: <1675780196-3076-1-git-send-email-quic_kalyant@quicinc.com>
 <1675780196-3076-3-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1675780196-3076-3-git-send-email-quic_kalyant@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 16:29, Kalyan Thota wrote:
> Add DSPP blocks into the topology for reservation, if there
> is a CTM request for that composition.
> 
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
> Changes in v1:
> - Minor nits (Dmitry)
> 
> Changes in v2:
> - Populate DSPPs into the reservation only if CTM is requested (Dmitry)
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

