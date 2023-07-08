Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090E374BA6F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjGHAH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjGHAHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:07:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A44C1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 17:07:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so4038270e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 17:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688774843; x=1691366843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLt63cNfTOHwnk/8YjxdfGjECIo1obJeTRgBrDNQw4g=;
        b=TsMiWw57CK/WW1zqiQCs0o34jJvhwKzckDpp5bJRVvuXb8/gcLg2g2BuMsMiIS3u8H
         XtsNZvF2SiMjNifAvdpoZI1pAOleYRqddKVHMMzc6MPYaAzbRIsREnEt7ifoMeYld2hH
         nNt7pzmP1rd/P5ovrP7fiVZjBoRDBBgihyjvmCML0ajc+Ve4EgtnR1AEa1J6i0HBWewg
         UwdZF8QrJ8LxP7tXJLlA4mb5kVlx1/q8SIaoDkqJU4LBqqbZyvCWQtdHZw3zdfUtYDtm
         XiOe6xC3gdG1glErYbzWuL9yQ4yOl8kNj+cSR/mmZh0h1xKhzOY0g/Wm1HCCPQSkRPOG
         Q34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688774843; x=1691366843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLt63cNfTOHwnk/8YjxdfGjECIo1obJeTRgBrDNQw4g=;
        b=i94gaug4hkw0FNPQlGNFAAnfXKL9uG1h7o1HZbMks+xwHwHKXLlTBdObgRazB/KAn8
         ce50M4hKRDkDC+ttzImKyFS++sH0a4mH4t+4klNuvc034Mz+JPMC0P+NgX6qnmlwcM/8
         qpIuKvy0qWknbJ9pyFn16Qjj9+CYMszE8cEXGsGqNjH05zytiozZCjm4WyACOo4x3ZR0
         t59vhaTXGUEPFNs5IGPwJtj/2paIo8EF5DiUflyN+xiEQOrRAV9ObBqgEt+NaO/0Nffs
         B0Nrok3Rt6Q1esXtp+j3p8OL6jEQZ35b+PSvi0Tn4cR9n0nKDn1RwbISq9x6Okx28Qvs
         EiLw==
X-Gm-Message-State: ABy/qLYGjx8k7cAeLhn395etRliUPE7u/u9QeMAGibvMCHXfZcRLjGbf
        A7Jvmw/CnhvDx0LophDy6I06rQ==
X-Google-Smtp-Source: APBJJlFiIH+YImiq0+UkzUR5N2zGiuktwPtPxkgVv/DDbfGw9WFNLBhG0plZ3szl2fD8O+goMG8VJQ==
X-Received: by 2002:a05:6512:1310:b0:4f1:3d7d:409e with SMTP id x16-20020a056512131000b004f13d7d409emr5608203lfu.0.1688774842857;
        Fri, 07 Jul 2023 17:07:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id eo25-20020a056512481900b004fb85ffc82csm853085lfb.10.2023.07.07.17.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 17:07:22 -0700 (PDT)
Message-ID: <a9cb7147-613e-8b1a-14c5-bbac6bb24a1a@linaro.org>
Date:   Sat, 8 Jul 2023 03:07:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 3/5] drm/msm/dp: delete EV_HPD_INIT_SETUP
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1688773943-3887-1-git-send-email-quic_khsieh@quicinc.com>
 <1688773943-3887-4-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1688773943-3887-4-git-send-email-quic_khsieh@quicinc.com>
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

On 08/07/2023 02:52, Kuogee Hsieh wrote:
> EV_HPD_INIT_SETUP flag is used to trigger the initialization of external
> DP host controller. Since external DP host controller initialization had
> been incorporated into pm_runtime_resume(), this flag become obsolete.
> Lets get rid of it.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 12 ------------
>   1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 2c5706a..44580c2 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -55,7 +55,6 @@ enum {
>   enum {
>   	EV_NO_EVENT,
>   	/* hpd events */
> -	EV_HPD_INIT_SETUP,
>   	EV_HPD_PLUG_INT,
>   	EV_IRQ_HPD_INT,
>   	EV_HPD_UNPLUG_INT,
> @@ -1119,9 +1118,6 @@ static int hpd_event_thread(void *data)
>   		spin_unlock_irqrestore(&dp_priv->event_lock, flag);
>   
>   		switch (todo->event_id) {
> -		case EV_HPD_INIT_SETUP:
> -			dp_display_host_init(dp_priv);
> -			break;
>   		case EV_HPD_PLUG_INT:
>   			dp_hpd_plug_handle(dp_priv, todo->data);
>   			break;
> @@ -1483,15 +1479,7 @@ void __exit msm_dp_unregister(void)
>   
>   void msm_dp_irq_postinstall(struct msm_dp *dp_display)
>   {
> -	struct dp_display_private *dp;
> -
> -	if (!dp_display)
> -		return;
> -
> -	dp = container_of(dp_display, struct dp_display_private, dp_display);
>   
> -	if (!dp_display->is_edp)
> -		dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 0);
>   }

Why do you keep an empty function?

>   
>   bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)

-- 
With best wishes
Dmitry

