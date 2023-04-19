Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE286E85B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjDSXLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjDSXLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 19:11:40 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65611FC0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:11:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4edbd6cc46bso198539e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681945897; x=1684537897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfygpWcXD82nmdKO3aJpXpI9AXyY7qmWAlk2vCZOvBc=;
        b=sVIl/jhDZe96ic6Ugh+xb5APutIrMj6AJXc/AuoYLbyVZj7KFKWxM10TyW4/cmgiKu
         jaHSrB7skENraSGhUZKApGVXRr2OAK06da9ZtgzbJiuAhq7pJ6OYw4M9kktg3HRx+1qg
         a3F+5+oEJdhWyIWN9mcl9l//Ymgx8+Ic7rhmpVoeTdV4vixGNNnAbwT72QiJOSTa/aia
         KSHQwcYd0prAc3A8jr6M8IU9G+WDehumUWU15wk80w+OYCfWlAmhYuu/126p7bVJrCsd
         jwTvjBNuC6fvdTx+hLZwvjs8qRHe3WMuikSOFSyGi6ssb51mbYUTXHAg/8fuhZd+AZ1n
         zx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945897; x=1684537897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfygpWcXD82nmdKO3aJpXpI9AXyY7qmWAlk2vCZOvBc=;
        b=dQGdX0UlhrjgdTZQSzH5qwVwU5DU+4qOvF4eDgeUoh30w3vNtYrD4ZLj+F+aaGsXBb
         thbEEF17Rx2s4xfkGrnFQNNWFThwfZcq4lB5EOSkDmaD7szc7eJTKMFEZtODcJS2lsOd
         G+EWRU+KkPYgKazS1G6EX/5W5XceYNVLdPNXPcWWGagn0r8hvJzSsRAQL1lZBvE3HGbI
         Df8clms+zeQ1+ZmBuBVDbLCCeBeUEsXLISdEAh1sa50H5L8HeKwKK904sC+MKfxExRN+
         Xm9O+Kr2uJmPnAFMKJuZRatm/9QyDisWer0IYo1uZhMcySbECH1YhnRtDfbmfN928Ox5
         +FFQ==
X-Gm-Message-State: AAQBX9f3Wboa3wXlHDdX+N60Yd4EvXOwsBFqvSm6EWY6BZBy1VQQPk/J
        vt7rUsOkjw+jJPZJTZMl7CYifQ==
X-Google-Smtp-Source: AKy350YqXP13dfiRQ0p8WHKOW0qK7OWHP0+B03Xc11I7kixmjk6LhtlLRu3bwG9cUdLhrVWN8ulzPQ==
X-Received: by 2002:a19:7403:0:b0:4ed:c471:6a7f with SMTP id v3-20020a197403000000b004edc4716a7fmr3462546lfe.17.1681945897054;
        Wed, 19 Apr 2023 16:11:37 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f2-20020ac25082000000b004eed63bc08csm36112lfm.131.2023.04.19.16.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 16:11:36 -0700 (PDT)
Message-ID: <9c0f922e-180a-930c-ac9a-04866b1b7bb1@linaro.org>
Date:   Thu, 20 Apr 2023 02:11:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/11] drm/msm/dpu: fix cursor block register bit offset
 in msm8998 hw catalog
Content-Language: en-GB
To:     Arnaud Vrac <avrac@freebox.fr>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
 <20230419-dpu-tweaks-v1-8-d1bac46db075@freebox.fr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230419-dpu-tweaks-v1-8-d1bac46db075@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 17:41, Arnaud Vrac wrote:
> This matches the value for both fbdev and sde implementations in the
> downstream msm-4.4 repository.
> 
> Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

