Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B411D608D57
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 15:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJVNIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 09:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJVNIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 09:08:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05072B7B7B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 06:08:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r14so15419718edc.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 06:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jECDV5SqOSdwhazWcoV6YQuDbZ4vuxgoxkQHZLW/d0g=;
        b=gog/6lwOJlLxETauSPzlW80KFxupVitmXos7FTWhyWiRW3O19zhgcejjE/fj61fobQ
         +5qsIYusegM8pYW28cT3cTdwg2cVWSBAm5StqJGoQtF/ZiTS4r+3feLpT8FPhvJCg7jz
         9A5727kJCxFPeFRycDE2+QFSrICXIKPMloMeOWYa4v1EOPgK3f9uSlADWCRe8VEzlaDl
         X3XLMbOC2bB2HeT0O0+Xd+UzI7FqQG6VtvoJcZKqfdizdT5gx1SW7pPG38jaALBHSDke
         VRxYDIqnxpg/WqQJPEjMh0mmX0On0VRyIjL9VTyRwdaOdDntK6+7QZMQm9E52QazceYJ
         RuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jECDV5SqOSdwhazWcoV6YQuDbZ4vuxgoxkQHZLW/d0g=;
        b=sqXDIkkSAoYNGFc0fM4/t9Kg4n4ozdCuIiD4fuerlgu/NDlgxmt9PagpoYoSFe+Yvj
         qQkSxzkE2GmDBTHgpVMMK4Ee4aAoxKnIYL7svBXmuJbXSmApOYUMzQjazhoQBKiaxMW2
         26P319Fdr5KPWQtfnvJ9KIX7oHPyNpjmYTJB4c6gJ3xvf6L0F+CBhqSoz7lpGuguzjkN
         9yWyCXY/UMMXwV8q8MbUyNy8hHH45P4xWnv+AIj+24g8GOJT1MX7XnyPRCb1Mr9KI08d
         n9ee9Dk5cG98dO/+vpH9XgBFB7voL6k/a9Q8bXGm95LtRoSaDSqpFoRgVKq4MO971N2h
         YMsA==
X-Gm-Message-State: ACrzQf032Gbvi1UJp9zSQ+wjsTrSvBIEMU7KlPA77KyxKrQVOY1997g3
        5UnJcvcPgM+h92KrNm4t3yw1FA==
X-Google-Smtp-Source: AMsMyM4pJJlle/WTj6w/2qTAwH+UF52YWGqi5oyIZCp6k4gzdMQDOZVvztp7Wk7OtpRpnOFttqemqw==
X-Received: by 2002:a17:906:8b81:b0:78e:1cb:e411 with SMTP id nr1-20020a1709068b8100b0078e01cbe411mr19355882ejc.681.1666444128303;
        Sat, 22 Oct 2022 06:08:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:25b:e73e:85eb:ae6e? ([2a05:6e02:1041:c10:25b:e73e:85eb:ae6e])
        by smtp.googlemail.com with ESMTPSA id l10-20020a1709060cca00b0078d21574986sm12880330ejh.203.2022.10.22.06.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 06:08:47 -0700 (PDT)
Message-ID: <591f7038-81ed-1850-b525-d02a4e082903@linaro.org>
Date:   Sat, 22 Oct 2022 15:08:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/3] thermal: qcom: tsens: rework debugfs file
 structure
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221022125657.22530-1-ansuelsmth@gmail.com>
 <20221022125657.22530-4-ansuelsmth@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221022125657.22530-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2022 14:56, Christian Marangi wrote:
> The current tsens debugfs structure is composed by:
> - a tsens dir in debugfs with a version file
> - a directory for each tsens istance with sensors file to dump all the
>    sensors value.

s/istance/instance/

The patch looks good to me, no need to resend, I'll fix the typos

> This works on the assumption that we have the same version for each
> istance but this assumption seems fragile and with more than one tsens
> istance results in the version file not tracking each of them.
> 
> A better approach is to just create a subdirectory for each tsens
> istance and put there version and sensors debugfs file.
> 
> Using this new implementation results in less code since debugfs entry
> are created only on successful tsens probe.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/thermal/qcom/tsens.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 467585c45d34..fc12d7c07de4 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -704,21 +704,14 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
>   static void tsens_debug_init(struct platform_device *pdev)
>   {
>   	struct tsens_priv *priv = platform_get_drvdata(pdev);
> -	struct dentry *root, *file;
>   
> -	root = debugfs_lookup("tsens", NULL);
> -	if (!root)
> +	priv->debug_root = debugfs_lookup("tsens", NULL);
> +	if (!priv->debug_root)
>   		priv->debug_root = debugfs_create_dir("tsens", NULL);
> -	else
> -		priv->debug_root = root;
> -
> -	file = debugfs_lookup("version", priv->debug_root);
> -	if (!file)
> -		debugfs_create_file("version", 0444, priv->debug_root,
> -				    pdev, &dbg_version_fops);
>   
>   	/* A directory for each instance of the TSENS IP */
>   	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
> +	debugfs_create_file("version", 0444, priv->debug, pdev, &dbg_version_fops);
>   	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
>   }
>   #else


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
