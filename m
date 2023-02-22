Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75BF69FE26
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjBVWLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjBVWK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:10:57 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355DF4614F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:10:47 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g8so8226146lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u4mYbzQ9cgwTl+69pCWin73Y2hlI6/ouh6GkkcpHJEs=;
        b=pGRGa8VHaQVYRZl+HXCExMLMBiULJptfRc2lr3kNFPsIf8JUa36WV+Xpf6lZS/l3vx
         yRPqSjVBUE9kMQEYWcpUUkNbys1JXsxmKoLRejio5ACOa5uT5AqMGx/VkSDq29Y0+AsY
         VUu0EN//vB6TBijnhOyeGkkuSbXwkYexekJgnOhf848VpyQR3HtSBsPfrHZqxFH60CP6
         ANq32REb17kzxwK8nS8UW6xxbS3PEiZr4fnJpoP4z9MrdjmkifAl4xHSwQ71dojEpwrJ
         9mmCs5X2cfnd1/LYCEoqMQRWxTICzqrADTrqkAGCBCJU7r/jvX0NxTg5xdKBchPiXv+5
         PjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4mYbzQ9cgwTl+69pCWin73Y2hlI6/ouh6GkkcpHJEs=;
        b=Ckrvhe+PorU7xRdEYlzJx7eyhMI/0aEdLPQkgyDJaHvLKjjT0i2zbT7XSyijPEAPAD
         WiX8IatZw8CfzIDeI+ug7Gjm8f0J2E9y5zyDl9SwOC+rl46Sjbj7c4gZCpLQIgPYikNC
         IduLEs3Ddv+QDjAw4ITFuXhxm2ozDUuWWWmsfME/qRK0om9S4HnI7bNwqxzkJIqiQhzG
         b7wCoLQlhkg6GuMpuClVzntXOKF+hKOXIUlwYjCLa8bBkq/mt8pl4JKucxwxqFnDbRAv
         LkSFaxZfN2qn2yhFrrc8+Z2f6raNOSY+rh9/ZNblFnFg37HeUOyDpYu7/icmBPR4R5uP
         V1oQ==
X-Gm-Message-State: AO0yUKUnlzKYfXDZGfCBQTLjnqyyuM9q/zYd8gk5rCkayMc5Q3fjKK2Z
        JWEYGb/LYAs/jM1zcgRFUulApg==
X-Google-Smtp-Source: AK7set/IjvGyF7xyCv2RYJe+CEGvQ2ntC7MMr1iIO9quNinHmQlwonGSpH/aP8ZV6jHrfpSv8T4MqA==
X-Received: by 2002:a05:6512:7c:b0:4ca:faa4:af15 with SMTP id i28-20020a056512007c00b004cafaa4af15mr3016648lfo.66.1677103845348;
        Wed, 22 Feb 2023 14:10:45 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q3-20020a19a403000000b004d869c1861esm2280873lfc.192.2023.02.22.14.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 14:10:44 -0800 (PST)
Message-ID: <628b480e-caa8-6230-6fe8-4cd582372afa@linaro.org>
Date:   Thu, 23 Feb 2023 00:10:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 3/5] drm/msm/a3xx: Implement .gpu_busy
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230222-konrad-longbois-next-v1-0-01021425781b@linaro.org>
 <20230222-konrad-longbois-next-v1-3-01021425781b@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230222-konrad-longbois-next-v1-3-01021425781b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 23:47, Konrad Dybcio wrote:
> Add support for gpu_busy on a3xx, which is required for devfreq
> support.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #ifc6410
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

