Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E18E5F97F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiJJFw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiJJFw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:52:56 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D65E4DB4E
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 22:52:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 129so9494597pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 22:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFQ5Qewhfj7s3H/Pg05G2j611iY4Qp2AA5uqr+jk0Rs=;
        b=Q1WSdmE7Jyp6+AxPtxwJmnP1ejKyblyI7ciwzPvR8toAHfdhcuV0EOjm47MgAchc1A
         XginBauRKrRVvlW8r5lt0vN9uxEw77FIkb7r2XgIl6GXI8mXTE6OanlWZqwP0lH9G+RY
         iyAMDZf4C8MeHSce7L8c+HbqsmPJTaQKsj2cTchHJSxGczEBUNdVl2E+2v5d4O7oFZfg
         4dD0xE2WAL59Cb0mN0+kZyzZp8nykt+it6e1yBjV7wM7vyykAuxcJWeUCqoQTVlNTnr7
         T45OhUmjhUaFwEFOolSzkSe8WH3lckn4sk8u2lHyUK8eELCk+gBLDCreMK1gWFKcZ+0F
         QTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFQ5Qewhfj7s3H/Pg05G2j611iY4Qp2AA5uqr+jk0Rs=;
        b=5jxUPGxuTQEs8+HXjH4m6VbTJxhHuZHGAQy6BJQm9/H4kUwsrKr6fKPPvKMu8AtJWk
         713VmmrbJK3vXZZJAQCe5UDhzy77/48OHd4CN+8Wnw/Ein/QOFjMC3cR6rlSmextiWmX
         7duOpOmW9pgBzb4NUKr5zuzZin83qkZFiVkIPsVW8ZgvwBJGUWrCzNunnnZSQQqJ0OXy
         67PjjIaT8eQxhXKRPzvGzPJRwma/LGd/5KodqVAXXPybZTnQtzBf48VaqQrr+VpVRpNL
         ZYBS3Rn9WLseqo1nDBup/OxvXiG/aRvrb6aRMd0R+keWwnVcbs1laxTO4NhYvyWB8Hl4
         IwnQ==
X-Gm-Message-State: ACrzQf1OSmE/uq7Xbq1fZ2ouH31u5/Wp+XDfvzagch1v/J6R303yryyF
        EEIXH43uiHep/CFFJI5qj0Jvig==
X-Google-Smtp-Source: AMsMyM68Zii/bMh6/0kCWrERbUYsb613NTUF+zksx7uEAg7+GW1CK53hSAKAfI835TAJrzHp3YuqeA==
X-Received: by 2002:a63:81c8:0:b0:462:953a:8534 with SMTP id t191-20020a6381c8000000b00462953a8534mr2866641pgd.69.1665381174839;
        Sun, 09 Oct 2022 22:52:54 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id x13-20020aa79acd000000b00561c3ec5346sm5890990pfp.129.2022.10.09.22.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:52:53 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:22:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Fabien Parent <fabien.parent@linaro.org>
Cc:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq: qcom: pass pvs_name size along with its
 buffer
Message-ID: <20221010055251.ulgevsdqudors3t3@vireshk-i7>
References: <20221001171027.2101923-1-fabien.parent@linaro.org>
 <20221001171027.2101923-2-fabien.parent@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001171027.2101923-2-fabien.parent@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-10-22, 19:10, Fabien Parent wrote:
> @@ -265,7 +269,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
>  	struct device *cpu_dev;
> -	char *pvs_name = "speedXX-pvsXX-vXX";
> +	char *pvs_name = PVS_NAME_TEMPLATE;
>  	unsigned cpu;
>  	const struct of_device_id *match;
>  	int ret;
> @@ -306,8 +310,8 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  			goto free_drv;
>  		}
>  
> -		ret = drv->data->get_version(cpu_dev,
> -							speedbin_nvmem, &pvs_name, drv);
> +		ret = drv->data->get_version(cpu_dev, speedbin_nvmem, &pvs_name,
> +					     sizeof(PVS_NAME_TEMPLATE), drv);

Since the pvs name is always PVS_NAME_TEMPLATE, why are we even
passing it and size here ? Why not directly use it in those
get_version() implementations directly ?

>  		if (ret) {
>  			nvmem_cell_put(speedbin_nvmem);
>  			goto free_drv;
> -- 
> 2.37.2

-- 
viresh
