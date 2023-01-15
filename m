Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F9966B277
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 17:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjAOQLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 11:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjAOQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 11:11:35 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9679CC12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 08:11:34 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ss4so55627825ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 08:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCTiFIBsz+mA+RBLRcWdYu9eMO+UAxD9uKThfcsKYDE=;
        b=wOtk3RHpHDrvp/2ct7en+pwljKn3TTcFH82jnoLSdNZM3YyjU1N2dRgZwu0CK7doUk
         OSATfYtZpKvdaiIEJkKSitxg2gVKReYxyHgnAQpq4psLuM5tXqVWwV1Be9PntztXwSi1
         pHNZt0UXLa7y9tCP+BTUjqJ4Q+BQaUjVnN608IdfC/wgRJDBBISlmEZLv4CF65Z1JDog
         vIl51CjSKsz4KZCnjc0GeuuW5/9LF4rYu6HFV5ck007JBpyP1qPOgkJaoiCELPSJqG9m
         N1nTorQ5Gy3Rbky/ct2yRGQDh+YuWMMRyw25Wvl1Qq1BsBg/g7k19g02qp+Rk2JBQGK4
         +DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCTiFIBsz+mA+RBLRcWdYu9eMO+UAxD9uKThfcsKYDE=;
        b=Hrh/xAYumM7/pbkU63/Uc/U8zgLIis3Mx3BT6YQAf83QDapFrcRnOa9vkYbe9ltFnj
         LoP6RYfRIKHGD9eZaTxKjhxBMwqwZuiLMWeL/U79vedQ7nMJpQhxjV0SKmKRMrAJkUIN
         yUAxrG9uhDrNwSO5HssfJCjfKsWVQebJ9XSmGiXwRgGPXcNrbXgyZPt+Ldl9KcFUQkR7
         zH2pTaU/qDqZdSA/hev/ntMAxZT9Ezbts6s5m8AwjXO54ch/XwlR00r687wAhuswmy/6
         0m9oTbRKPn0IAtxPsrWB42qU2JFBmqQNsUhpw48PvOiaTVHW6a5Rn47ZpzHbC1JoDsa5
         KSMA==
X-Gm-Message-State: AFqh2kqcosahX4regDfO+WK9jUadRD6MV4dt8LNzcdqbdNiEz64d8ZKy
        zCurgokNphh+g4mmRtI5cgcjEQ==
X-Google-Smtp-Source: AMrXdXupc2CzIStk6SHRrwiCJtsdSVrSUOx57XyaG3i3NMYkNDzLELTLZfW6IYtG/Y50W8tMZQAoYA==
X-Received: by 2002:a17:907:6026:b0:84d:445b:8aa6 with SMTP id fs38-20020a170907602600b0084d445b8aa6mr19617790ejc.70.1673799093344;
        Sun, 15 Jan 2023 08:11:33 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906318b00b0078d3f96d293sm10825646ejy.30.2023.01.15.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 08:11:32 -0800 (PST)
Date:   Sun, 15 Jan 2023 18:11:31 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: Remove need for clk_ignore_unused on sc8280xp
Message-ID: <Y8Qls7iBCT4bWY24@linaro.org>
References: <20230113041038.4188995-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113041038.4188995-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-12 20:10:38, Bjorn Andersson wrote:
> With the transition of disabling unused clocks at sync_state, rather
> than late_initcall() it's now possible to drop clk_ignore_unused and
> unused clock disabled once client drivers have probed. Do this on
> SC8280XP.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/qcom/dispcc-sc8280xp.c | 1 +
>  drivers/clk/qcom/gcc-sc8280xp.c    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
> index 167470beb369..c84a6481b879 100644
> --- a/drivers/clk/qcom/dispcc-sc8280xp.c
> +++ b/drivers/clk/qcom/dispcc-sc8280xp.c
> @@ -3199,6 +3199,7 @@ static struct platform_driver disp_cc_sc8280xp_driver = {
>  	.driver = {
>  		.name = "disp_cc-sc8280xp",
>  		.of_match_table = disp_cc_sc8280xp_match_table,
> +		.sync_state = clk_sync_state_disable_unused,
>  	},
>  };
>  
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index b3198784e1c3..f4fdc5b9663c 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -7441,6 +7441,7 @@ static struct platform_driver gcc_sc8280xp_driver = {
>  	.driver = {
>  		.name = "gcc-sc8280xp",
>  		.of_match_table = gcc_sc8280xp_match_table,
> +		.sync_state = clk_sync_state_disable_unused,
>  	},
>  };
>  
> -- 
> 2.37.3
> 
