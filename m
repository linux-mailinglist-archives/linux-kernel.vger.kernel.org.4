Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAFE653467
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiLUQzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbiLUQzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:55:09 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD542240B8;
        Wed, 21 Dec 2022 08:55:07 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 1so24385890lfz.4;
        Wed, 21 Dec 2022 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKpFopFM+2p/s1rCGdP6Z1nsO+BxLqf3LvQx/9wlFY0=;
        b=ChA+yVv3lB6Fzz5kJ1UE+vuKF2qz6h08hFftpVh0TotNethlWSKylrQR5xIP+QxAk6
         sSzxD+z9NTp84P+QTcNTScu5QrEzHEDr9pcDPoxlVTX9bm0guls39R0GyjTkcK/ymMFs
         aL1oFCKZymTRxAjCchuiA9b5LvonHJDYrjfYaTjZD0gqs6cEmyC2Erna5KxDaKkEB1Ek
         RLJ8QXCE7ovCElVoHQcBtcSCxeiY70Z3RUxDa/uA8BLvsyQ2BlcFthcUsEF0eDpqrXeF
         58zYI9hq2x7FvMhGJ0ojI89z7iu/ysDBQZOjKuobznqo36Wo6QGSdkA5SAn0HYjAGwjI
         ecpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKpFopFM+2p/s1rCGdP6Z1nsO+BxLqf3LvQx/9wlFY0=;
        b=S1aYCp5x6ejABxDsnGGvswv78vbV+7sK/snLO7UPmqWgGOI/Wwv+pqd8VrzLT51oxC
         681NJI+cdYbmeF6EBrucfwFThsv916tgFx0Ee09CnQ2fstgJoHQX9VyjjBiyipdRRffp
         M/htQvw11F0ZV7bx2TINuE08FON5CyTOET189glVauLApN5uCW1DEbG61M39jt8CGfHJ
         10tt36QeHAfLJ6aWdheNaVM85L5y4Fw3ne765AJA8gQ5Wqajkw9y6jHm0wDgmtPNRQvR
         rcnIH1hHBcrG/4r+hqWfGBr9wAImnYOEescizvnB0DBtF4BAKhreFBoPZuKdTCvT7/C+
         Dd7w==
X-Gm-Message-State: AFqh2kptMjmtjaOn8bgDAThsoJytyoWHCZ+nCwJcidVlsPjUGYadnIE1
        Z1HkW4nVBqGOnCIhZ7nP7dE=
X-Google-Smtp-Source: AMrXdXsE0hc14q00/Ji4tJF2zXxYjgrpZbqAN7yU8tEF5zJcQPgy7AKxaPcyNetQ1YqvfdfczeZc2Q==
X-Received: by 2002:ac2:5b12:0:b0:4b5:6fa3:5d63 with SMTP id v18-20020ac25b12000000b004b56fa35d63mr2192589lfn.13.1671641706009;
        Wed, 21 Dec 2022 08:55:06 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id bi26-20020a05651c231a00b0027a2a26a655sm1395056ljb.8.2022.12.21.08.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 08:55:05 -0800 (PST)
Message-ID: <8641fad2-7170-4c0c-fbd6-6e2e784b3106@gmail.com>
Date:   Wed, 21 Dec 2022 19:54:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 01/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        krzysztof.kozlowski@linaro.org, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, rafael@kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20221220160240.27494-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.12.2022 19:02, Sumit Gupta пишет:
>  static int tegra186_emc_probe(struct platform_device *pdev)
>  {
>  	struct mrq_emc_dvfs_latency_response response;
>  	struct tegra_bpmp_message msg;
>  	struct tegra186_emc *emc;
> +	struct tegra_mc *mc;
>  	unsigned int i;
>  	int err;
>  
> @@ -158,6 +307,9 @@ static int tegra186_emc_probe(struct platform_device *pdev)
>  	if (!emc)
>  		return -ENOMEM;
>  
> +	platform_set_drvdata(pdev, emc);
> +	emc->dev = &pdev->dev;
> +
>  	emc->bpmp = tegra_bpmp_get(&pdev->dev);
>  	if (IS_ERR(emc->bpmp))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(emc->bpmp), "failed to get BPMP\n");
> @@ -236,6 +388,19 @@ static int tegra186_emc_probe(struct platform_device *pdev)
>  	debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
>  			    emc, &tegra186_emc_debug_max_rate_fops);
>  
> +	mc = dev_get_drvdata(emc->dev->parent);
> +	if (mc && mc->soc->icc_ops) {
> +		if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
> +			err = tegra_emc_interconnect_init(emc);
> +			if (!err)
> +				return err;
> +			dev_err(&pdev->dev, "tegra_emc_interconnect_init failed:%d\n", err);
> +			goto put_bpmp;
> +		} else {
> +			dev_info(&pdev->dev, "MRQ_BWMGR_INT not present\n");
> +		}

If there is no MRQ_BWMGR_INT, then device drivers using ICC won't probe.
This is either a error condition, or ICC should inited and then ICC
changes should be skipped.

