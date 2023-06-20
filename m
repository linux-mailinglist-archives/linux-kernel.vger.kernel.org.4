Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7436D736B06
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjFTLcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjFTLcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:32:06 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01737FE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:32:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b45e347266so54791661fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687260720; x=1689852720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A713VP1miYx4+izRL/fshmdCGqW1R6uuzjTJsyEBlBo=;
        b=jl4pD3kF0tm7QmDvJr2zbmpLqOxfCVocE5kHXW0BC4xP9WCCzZIp1fQe2fwsdQlE69
         zAR7GwYN9TdOoPPeD7aMR/l4JeqIODkNYwQCTifkFKAAySlP1nmti/Q2wzZkXE+X7Lck
         agoHtVPkfeqYK/FrJlVKulpZf2uJcN/RJx5tx21+sqnZU4j1RNkvfM78VxgdeB0+4RCr
         eaw5FPigoI+C+YgSvn5H+lD2jaxNN63OL5PPvkIVhFALzEpMJ1/wC0m3sOyD3pc25Hkv
         /zuOGyCmj5pkVU5vsKLo/iaBfr3BN3yX01OcKhOHS5uPeqrd7PtCbfVqFjvPw/6ZfypV
         KVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687260720; x=1689852720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A713VP1miYx4+izRL/fshmdCGqW1R6uuzjTJsyEBlBo=;
        b=HKetZyDv53AHB5UiAZmKXuNCX7fSUfLrzFy6aq+6iW+wCvijdtF2SH6fH3wGJq2O6L
         cLukR2lrSubZ7VEqKixhiIWZ0KokGsFsx3ILt5VS9MGQxonnebwoz/KOqccNBEesDjCA
         8EpyXNhX7I4HjRRr+m5Xwm9J/7g3QEL5cIoHhY7C0aq8qpV/LDKuQgZ4i386srTVAJcP
         YZbu34l1f5Om1Gx4Z7fdDrG8uMYGLKr1nZ9ZaNzEp/kAZcC7jgaiaCAGfqydBpW4U9/j
         yBy060B+9SEom48SMoZPKfm46nCwsZKefMi3yh22r/OWmB6jmJdBgOx3msGI0EkcCdYs
         LHkw==
X-Gm-Message-State: AC+VfDx7t4dLIVHA8haibyomXvloN156JL/4B1P25b0pLLAKKtsNxSWN
        1Yag4BaFL2sTC95kXGwdpkFgRw==
X-Google-Smtp-Source: ACHHUZ5ZiHncGJDt4FdxRbpjnbkarvrTFJypLWFMX2swHPEiI3dYNbw/zJsdn242Z5m5uxes9LGzow==
X-Received: by 2002:a2e:b0e1:0:b0:2ab:19a0:667b with SMTP id h1-20020a2eb0e1000000b002ab19a0667bmr7270502ljl.0.1687260720414;
        Tue, 20 Jun 2023 04:32:00 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id e3-20020a2e8183000000b002b1a4238c96sm372656ljg.128.2023.06.20.04.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 04:32:00 -0700 (PDT)
Message-ID: <71f30a49-6d21-8ee4-1d35-545f0d7a1c46@linaro.org>
Date:   Tue, 20 Jun 2023 14:31:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] drm/msm/dsi: Use pm_runtime_resume_and_get to prevent
 refcnt leaks
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230620-topic-dsiphy_rpm-v1-0-446a7fd0ce43@linaro.org>
 <20230620-topic-dsiphy_rpm-v1-1-446a7fd0ce43@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230620-topic-dsiphy_rpm-v1-1-446a7fd0ce43@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 14:29, Konrad Dybcio wrote:
> This helper has been introduced to avoid programmer errors when using
> pm_runtime_get, use it.

Please expand to mention the error kind. Also as you are at it, could 
you please add an error check here?

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> index 9d5795c58a98..0a8e1dd4509e 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> @@ -516,7 +516,7 @@ static int dsi_phy_enable_resource(struct msm_dsi_phy *phy)
>   	struct device *dev = &phy->pdev->dev;
>   	int ret;
>   
> -	pm_runtime_get_sync(dev);
> +	pm_runtime_resume_and_get(dev);
>   
>   	ret = clk_prepare_enable(phy->ahb_clk);
>   	if (ret) {
> 

-- 
With best wishes
Dmitry

