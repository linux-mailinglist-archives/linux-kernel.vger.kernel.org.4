Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73070671011
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjARBcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjARBcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:32:11 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9B14863C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:32:08 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kt14so20807620ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmuAGUEJgzr87EeXDQbFh57PgRhQGPH3NOHcW4zPvxY=;
        b=UexVHvSB6XQAhPAWIJ0nYTTqeXSJILVIecAUvV/QIXmQXyxnIaYUpT5VDv9iSoqDP0
         mje+pWNsM4Z34wVsqveK0S/QVYZYeappJ/qdLBsv2qMFI9HwZiGvxcK+F+fFddFa+2/T
         VsvlKILzGCFp/gabOfKM/YxTypADk6DognnFQjOS1EkykLl3pR+nynCuZjix9VEseBIq
         hEEc/hbMMPkeEEfycet8wQ22pDUxqIbvbTIWVSMISny0FRycs5Gx8sg4xulaAKPoPOI0
         Cvola1mE7+BQtSzYSIXUlsLoRz87731JJ61Pq1AApkeeUUR1RJ4cKP20mn616JpJ/GEb
         emsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmuAGUEJgzr87EeXDQbFh57PgRhQGPH3NOHcW4zPvxY=;
        b=Df7xxok6e9GkFP1EIPE31NxiqAhMn8ZnIfz95xWUeWAn/UT6Uq6UHyTHc3AxiO/nzU
         ks3qdjbEMmQQfiIulDFF18yenEmaPOeTPqrjB9YXNkG3lmlr65Oh0W8QmMK1PFpW9VBs
         voD6Nrrhjp38K9VL3IU1D1DBv6kpkuBRxldtu7wCXu/nBnbqDaAjaFtjoGryOFeyDWER
         8f3mKPjNihqz92QMjswBEbCeuwOGAvnYpyroy5Ecg4hzSZoBj73iNnG3G1DsrwzwbKY/
         0HxrwLqiSu+ic1dtYz/53Xg8gtCLg6MshcAlLMG5v8FoJGsvFNrisQEVAcBD5D2yX0Z5
         wFrA==
X-Gm-Message-State: AFqh2kqtXw2OULRHINRWhSza/EwFCXcdm/fDBb2AgHkiXUIxFBOMZ2Tz
        GbvdDaMrpuGx4CuMBrXcI1pbMw==
X-Google-Smtp-Source: AMrXdXsriPBC/u2WzPrwGYBCsosA0BsYTypVYoyxIusZ78gIkGgTQzrVWOsu/jmesepNcjchR4QWeQ==
X-Received: by 2002:a17:907:6f18:b0:7c1:98d:a8a3 with SMTP id sy24-20020a1709076f1800b007c1098da8a3mr5058276ejc.7.1674005527000;
        Tue, 17 Jan 2023 17:32:07 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906311200b0084b89c66eb5sm13799464ejx.4.2023.01.17.17.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 17:32:06 -0800 (PST)
Message-ID: <40261e85-f501-7326-76b0-b19ca3aceae9@linaro.org>
Date:   Wed, 18 Jan 2023 03:32:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] drm/msm/dsi: Drop the redundant fail label
Content-Language: en-GB
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, dianders@chromium.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, marijn.suijten@somainline.org,
        vkoul@kernel.org, marex@denx.de, vladimir.lypak@gmail.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230111011006.6238-1-jiasheng@iscas.ac.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230111011006.6238-1-jiasheng@iscas.ac.cn>
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

On 11/01/2023 03:10, Jiasheng Jiang wrote:
> Drop the redundant fail label and change the "goto fail" into "return ret"
> since they are the same.
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. No change of the error handling of the irq_of_parse_and_map.
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

