Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1C86267AA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiKLHdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiKLHdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:33:10 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FA431369
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:33:09 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h12so6833229ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bg6YBGl/EJCtYIdndJrZk08z2YDso/H/J+GwBQ40qAY=;
        b=urNOrd9RK3Rr5hkIX6zQEjsA8SH3ZPUsr3NfaZMmyMmIrId5/eofrpg1uiAYxrPaP1
         GSPD8SnQfe+ALS01K+OJXWfYH5KtKpBCu54ic/zHzWRKN09BgFGhtMsApJKZDY+EWYNF
         xvHhZ/ZOxd0jM+FliULrLaJhVWzWc3xatb+BeZxg6aYtg+2abelMnTZ2K6gnuL/Bn+pd
         xUm1pIZLvmEeH5GEJYpgPHtxMT8SectF0w2OyFbV5wfp8hQlR/x10H/RLNliq5VlamEU
         BKJETg1s+ZkaDfDo5roc2w3npvmJj4LzlU0oWFmGcLA+ofBlgsiP+BkSuF5XS5B8/xPz
         rIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg6YBGl/EJCtYIdndJrZk08z2YDso/H/J+GwBQ40qAY=;
        b=fVfRBYU4udCMojl12EMQdVe7DZISOAXrzdLhYzESKZ8/arHhD5VDhTL08WRzRmuWFr
         1ZmABDk0pTYqc3OXDqFYaMwQ1YfwlL1fFBlPEvzw9DsGlanrkiOETiFgio9awKnafQj3
         PLYKkQhWJC4sCvfSle7KxyakI1VfbO04WrUt5lVhiAOJDUyGWGkgg7IOX4Hgtb8hCFyc
         xMfpT82ZQlET18g2LY2hATMWps4SvUVdfA5CJzqFBu4SA39ayL6M4FWQDPbURK7ae+tT
         vvGnGgDuszhw50izqCW7DDIlhjeavMLCr+liof1Km5MfcFmoSyb9cMwjZzDhV/0/wRzH
         08oQ==
X-Gm-Message-State: ANoB5plJAbQnZHE6OGzfu8Xjzgwf+h0TeFz8jOjIUz+UNU9np8BxvVxL
        tCyhtCGzF/kuVD4BDMTWDRC7KA==
X-Google-Smtp-Source: AA0mqf7mjfElPOP51JDmcGDOKve5lmvK8KwiAOy0IxQCbfzLoON7tXup0+UMt8K0nQ14A8NFYmCdAg==
X-Received: by 2002:a2e:8e3b:0:b0:26b:de20:ba89 with SMTP id r27-20020a2e8e3b000000b0026bde20ba89mr1616751ljk.254.1668238388113;
        Fri, 11 Nov 2022 23:33:08 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p11-20020a2ea4cb000000b002770473d813sm759680ljm.140.2022.11.11.23.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 23:33:07 -0800 (PST)
Message-ID: <4d73a96e-ab12-6b86-ef42-8e99f67c1bab@linaro.org>
Date:   Sat, 12 Nov 2022 10:33:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 15/22] phy: qcom-qmp-combo: rename sc8280xp config
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-16-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-16-johan+linaro@kernel.org>
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

On 11/11/2022 11:56, Johan Hovold wrote:
> In preparation for merging the USB and DP configurations, drop the
> "combo" infix from the SC8280XP combined configuration for consistency
> with the other platforms.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

