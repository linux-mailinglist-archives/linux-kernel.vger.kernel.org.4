Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A336873FA73
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjF0Krd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjF0Kr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:47:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD6910DA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:47:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so1525765e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687862846; x=1690454846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1SHGwGuvf7TJ44kiTcp4e9FkY6Rq97j93XtcOVoz2c=;
        b=r0BPfdJx5aI3GWkMBEcnqTSB9t/Ep96KxepdubMaysDsN0GtPFxft7YIVUb5rClEcb
         RQXqC+dmTq5S8gzToH6s23b9qJ4uE1HdDyp0S+ahrwZNy3kVpOYgr6ooADDLja7fHrE2
         ra8IQWuSQrr7HfhfhvXnwvSECN0IwRsS74Suy+OSJvp+9VPSVWFpnUulvwD1eEunz5jR
         QVwaLzj0etyYnRPaPdeaNydVk/srVN0AkR9GAeUVwhCx4jX+Q5fhbOT9zt2LExEJPO5g
         Ld6W/vsngLqOCITkB/LEzT802uvFBg8vakIwTZIsm7mjtjtgjVwjNZyddxEtYMffk1hM
         lruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687862846; x=1690454846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1SHGwGuvf7TJ44kiTcp4e9FkY6Rq97j93XtcOVoz2c=;
        b=Nfn4qqCLiTFr/Sqybmr/48demUTktocfAWwHN9UKXGhAjL0AEjeqQvkxEh1cY6Cbiv
         5Ze5IBh51MsRyBNWO0g5Gz6mqOeUZNzcDQeCoEjDOA0XMCc6sQL+XGWF5HZSeLPAOWA/
         FxfZPPcLtF+ihvU8gKuvpA2QO/CcK+9uaX4/NuMK09FX2O/vVSgx2Y6tOQJhjjmEHPbw
         xK/5AJPBKYQgaTb6zz3gYaUuTv5Jnd3NgTzrfYECGgwturkFt0X6joNfM57d2P2JCbmy
         Q1JqyrcNPflREC1da+q5OSAODWD/DP9P7i0mNSgppJqcx90UkAP4seXetvgjITYJO+9a
         uTiA==
X-Gm-Message-State: AC+VfDwD9TQGio8OXHabRjdh3iuxpBTQe+mS0GJThW1aaSvyJ3B3zHAZ
        u03MHjEePviZbuVPTOcUFOariA==
X-Google-Smtp-Source: ACHHUZ5XoxbXkZwCIMhIogXDuBuSOaYlBh89UCR5cRagoOQ0u9dTXoQUoK29nPvY4Ig4NxMsxkEHLQ==
X-Received: by 2002:ac2:5105:0:b0:4fb:894f:466a with SMTP id q5-20020ac25105000000b004fb894f466amr415750lfb.7.1687862846077;
        Tue, 27 Jun 2023 03:47:26 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id er13-20020a05651248cd00b004fb788f67dfsm593298lfb.105.2023.06.27.03.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 03:47:25 -0700 (PDT)
Message-ID: <666f7313-f0a2-6a94-f591-eb354df083dd@linaro.org>
Date:   Tue, 27 Jun 2023 12:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 2/2] clk: qcom: gdsc: Add support for set_hwmode_dev
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        avel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
References: <20230627104033.3345659-1-abel.vesa@linaro.org>
 <20230627104033.3345659-2-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230627104033.3345659-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.06.2023 12:40, Abel Vesa wrote:
> Implement the GDSC specific genpd set_hwmode_dev callback in order to
> switch the HW control on or off. For any GDSC that supports HW control
> set this callback in order to allow its consumers to control it.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
Currently all GDSCs with flags & HW_CTRL enable hw ctrl mode implicilty.
I didn't get any cover letter with these patches.. are you planning on
retiring that behavior? Presumably after adding a matching pair of set_hwmode
in venus!

fwiw this patch lgtm

Konrad
>  drivers/clk/qcom/gdsc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 5358e28122ab..9a04bf2e4379 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -314,6 +314,26 @@ static int gdsc_enable(struct generic_pm_domain *domain)
>  	return 0;
>  }
>  
> +static int gdsc_set_hwmode_dev(struct generic_pm_domain *domain,
> +			       struct device *dev, bool enable)
> +{
> +	int ret = gdsc_hwctrl(domain_to_gdsc(domain), enable);
> +
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * Wait for the GDSC to go through a power down and
> +	 * up cycle.  In case there is a status polling going on
> +	 * before the power cycle is completed it might read an
> +	 * wrong status value.
> +	 */
> +	udelay(1);
> +
> +out:
> +	return ret;
> +}
> +
>  static int gdsc_disable(struct generic_pm_domain *domain)
>  {
>  	struct gdsc *sc = domain_to_gdsc(domain);
> @@ -451,6 +471,8 @@ static int gdsc_init(struct gdsc *sc)
>  		sc->pd.power_off = gdsc_disable;
>  	if (!sc->pd.power_on)
>  		sc->pd.power_on = gdsc_enable;
> +	if (sc->flags & HW_CTRL)
> +		sc->pd.set_hwmode_dev = gdsc_set_hwmode_dev;
>  
>  	ret = pm_genpd_init(&sc->pd, NULL, !on);
>  	if (ret)
