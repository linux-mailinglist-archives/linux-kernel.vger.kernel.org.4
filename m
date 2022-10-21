Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA8D607E54
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJUSdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJUSdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:33:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F9328864C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 11:33:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w8so6795956edc.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MNS/Xzv51DcFaEv1wkxo1BDU5sd5eff+DnDRv83bAU0=;
        b=CjYUP4coYcJAzuKjAxRNbwUiy0V10PtLSTDPWERzTCg4RLHC7C2t0GzfY01PHrhR0f
         KaHA8YyzXdWb88g6sdklQBcLbYerh1CZ/3LGjPHxrTjKBMPFwLcc9aibqdH+UWqesAzf
         JwDJz7K1Tx8TlGmrCvOnQ4QlFho7Is/NN2Y51jnCXf0TH3DXXeAXa9VQ8Nk5Jw3m3xle
         tk7/bguOt+6oTsNWWsunLJnuQn5iml9zwJ40fMiYp4wLAYHBeg08V2SQo5T4zV1ibhaW
         IOftKei6a2JnCsjweCJL4vThiLn3TNS1vL3ezwDCcyQ0cEz6Fo2O1HND+z6C3/IkccAw
         Zz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNS/Xzv51DcFaEv1wkxo1BDU5sd5eff+DnDRv83bAU0=;
        b=KEyx+npUFgvhFppEvkylWEElndXQw1fCJUz/L/qI6uraPM+MiLNvc+nLIS1mDZDKYB
         KNRzM4J9u3z1NjShmlDVQwxsVY3788NUap5elz6y6vrmTxDSziO3fSbRoWnPU7uFSHel
         cQu5o+nrcCyxTZvzU7TYLzd47fobEpNlUBVNHMiJg7UUkFB7kIklXbrGqSoOq2CVrHnO
         /cEEJqEG8e9Rpmmfzh2JDVO9QIPl5rcZK29lW25+jCT7VguAAknmSs+qp1Josi6EsxLW
         WjI/BwGea+5cAB1U6NPV/osiHnhKbquG5rFqrupCMqrHlHHMJDiBk8kJNmOL36UG0hM3
         rozw==
X-Gm-Message-State: ACrzQf1NvZxAuWOIfB2QIo6BKqSKK5Te1WhhoIleNCN+FC0dl628tW33
        M/KGz5J9SYIe6HAijmzKDdKfZQ==
X-Google-Smtp-Source: AMsMyM7lsIaiLnPNZ8zDmOJFv/eV1ZwypvFv0lN3TApj6rpYOoUmigqvWZaVyzAvkUhD5ZQ+xFqpkA==
X-Received: by 2002:a05:6402:220b:b0:460:f0a1:c4ed with SMTP id cq11-20020a056402220b00b00460f0a1c4edmr8140121edb.318.1666377223707;
        Fri, 21 Oct 2022 11:33:43 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:25b:e73e:85eb:ae6e? ([2a05:6e02:1041:c10:25b:e73e:85eb:ae6e])
        by smtp.googlemail.com with ESMTPSA id n9-20020a05640206c900b0045bd257b307sm13978605edy.22.2022.10.21.11.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 11:33:43 -0700 (PDT)
Message-ID: <f1e9b309-ba98-bba2-8d12-9f13ac34587d@linaro.org>
Date:   Fri, 21 Oct 2022 20:33:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH 2/2] thermal: qcom: tsens: simplify debugfs init
 function
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
References: <20221021181906.16647-1-ansuelsmth@gmail.com>
 <20221021181906.16647-2-ansuelsmth@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221021181906.16647-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 20:19, Christian Marangi wrote:
> Simplify debugfs init function.
> - Add check for existing dev directory.
> - Fix wrong version in dbg_version_show (with version 0.0.0, 0.1.0 was
>    incorrectly reported)
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>   drivers/thermal/qcom/tsens.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index cc2965b8d409..ff82626cecef 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -692,7 +692,7 @@ static int dbg_version_show(struct seq_file *s, void *data)
>   			return ret;
>   		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
>   	} else {
> -		seq_puts(s, "0.1.0\n");
> +		seq_printf(s, "0.%d.0\n", priv->feat->ver_major);
>   	}
>   
>   	return 0;
> @@ -704,21 +704,17 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
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
>   
> -	file = debugfs_lookup("version", priv->debug_root);
> -	if (!file)
> +	if (!debugfs_lookup("version", priv->debug_root))
>   		debugfs_create_file("version", 0444, priv->debug_root,
>   				    pdev, &dbg_version_fops);
>   
>   	/* A directory for each instance of the TSENS IP */
> -	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
> +	priv->debug = debugfs_lookup(dev_name(&pdev->dev), priv->debug_root);

Why the directory creation is replaced by the lookup ?

>   	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
>   }
>   #else


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
