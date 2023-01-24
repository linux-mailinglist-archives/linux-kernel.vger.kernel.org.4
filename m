Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E26678CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjAXA1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjAXA1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:27:00 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0B23757F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:26:53 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hw16so34895502ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwGmEa06omOhettp+Z0U9Hx95U15RGfyvNHOg11/HaU=;
        b=BxgM0uL92DiH8vBmFVQX5YRizpa0FSpTigSVNf68cvSGiLSmrrd+HL0LU8nGEtgI9U
         47PNKMUWousS1hlKa3LGIf5eaPSy6GV8c0rTXUT33Vqu+/GfXC2nLqKj9dLUQ+iog9um
         iygD4KYwtU1nQI9dq2rPz0mCQcd4poIfQNdwV4V+gtPR9sjCPWKmnYOJyHAzLZ3T5isy
         Y2JrFY9lKIOtWqRXEKKtWEf0qeGdt1Ig0yCQCkXZMok04YiPsPqom50vJZtHp67j6MVD
         wJ6r9WJq2B1Hdwyo4gUHBvjOz4YJdoqWYSne4c+jU22HEhLALYJjlC4F5pxW2wiOJRtq
         C5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwGmEa06omOhettp+Z0U9Hx95U15RGfyvNHOg11/HaU=;
        b=aBRK+uCR4vevtPl0SC/5W0XFYDIB5B9HsYwQla7xGKKFkNauhw/rnH5GIJhrS9ytmC
         r3Oqhoy4xrsTkjtWg+OJsOBnRRvCNTAFyZAlnxCykuHu3xwBa+u4/NElbrc1lMIdf5mI
         6IRH6E2DVcHDQzflFiHtd+c9uEHsTGbIoPqeB7DLHmwbZynihZdlAQMAhLzolqgZftC9
         450szP4DY7YpGwhlrMQr7CCE1s+CuQG+JlMQ7Ddu78CVhstkd9x7CW95CXkc6zXhhK2f
         0MtvWTqM1JT5BYsaaNCdjoGikymcXclzlRfg901u5pipI57HOzFPMYJnnH/fg+fLgjzl
         vyeQ==
X-Gm-Message-State: AFqh2ko8I847SXA0sX9alKogJJcnhDhmmF1kmOJkgex/Tp1nHONhbkRq
        wTUL8NvkIwX9aUEmRf1wu47LiA==
X-Google-Smtp-Source: AMrXdXts2d88Uk+7HdLIKXrZYxU82+pFx+YRlzrEXNldi8ylu63Erwb2h8tt2KYbCBT6aJShQ/Ijfg==
X-Received: by 2002:a17:907:9b06:b0:872:f259:a7ea with SMTP id kn6-20020a1709079b0600b00872f259a7eamr28628465ejc.53.1674520012237;
        Mon, 23 Jan 2023 16:26:52 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id jl20-20020a17090775d400b0082535e2da13sm142641ejc.6.2023.01.23.16.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 16:26:51 -0800 (PST)
Message-ID: <b86bf5b7-2b73-0955-8a12-d997f7715067@linaro.org>
Date:   Tue, 24 Jan 2023 02:26:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH Resend v11 13/15] drm/msm/disp/dpu: reset the datapath
 after timing engine disable
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
References: <1674138393-475-1-git-send-email-quic_vpolimer@quicinc.com>
 <1674138393-475-14-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1674138393-475-14-git-send-email-quic_vpolimer@quicinc.com>
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

On 19/01/2023 16:26, Vinod Polimera wrote:
> Reset the datapath after disabling the timing gen, such that
> it can start on a clean slate when the intf is enabled back.
> This was a recommended sequence from the DPU HW programming guide.
> 
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

