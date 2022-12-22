Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8C36544AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiLVP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiLVP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:56:32 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CC56595;
        Thu, 22 Dec 2022 07:56:31 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id y4so2312054ljc.9;
        Thu, 22 Dec 2022 07:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F96RJDidpidVjpAMCz7zq3Z+CFLpO9DsBw3nyLpGt2Q=;
        b=B3lncGg4Dzq95xAkmu+C1az6ltl+mDL3a+i60Jh2B+NSMLwvb+eRP22S4QGAzjAXuG
         x+Goml3Jq8yGzrTC9f91NmmeeJwrU/PuCfGOxuAce6GaA9NPhJ/bW0eng0H+zWav4ceC
         qDuUjdKcG4Y4zS/bieYoh85HQP5W7ihYiCePGrKNjcTjCYAeMMrzD8oQYewhhGgn83Jf
         pTjtxGXOLt29oHy9VXoM8y7Y8tH9MqZW+iwZeLS3ZoLxsG9MfQLS+HnhiYqqvge+o7wS
         y90aeqfYXcrK5lvm0jb6p8RGVwalIqpWlDzvykizVNsLhzPQMGeI/QL+Isef9682g2p2
         Wysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F96RJDidpidVjpAMCz7zq3Z+CFLpO9DsBw3nyLpGt2Q=;
        b=YxF1ySqahyzOHjr5bQVTGId+8hykf+GApkrvQyAANmOiT8FhCzYOvkYDORW/bWRZrW
         kGgfuZxQq4jeZGw46Wc5oPcfa4bq5qPq8/rk6heG+ec3HPPyA58IaMGS2kVqU10VhY6Q
         WPrM5RqYqXH71Et92g+NK1fylrIN4WPX0Cn1X/vYimTnWubkwcNb3877icDTo1PakkwF
         q6RtqiJRDDGHlgu/K8D0ddO8uYsqsFsjshtT72YzRehO2RE9HfDj9/R5Hijc6oZupdp/
         VWdbv7fAmp9k3Y4Y5HYTVYp0S96rS3lAnsI+9VBvxFqtdXlIVaijV8dBdNiVMyj1Plbi
         VFaQ==
X-Gm-Message-State: AFqh2krD2YX4kx38igRBBecFvoio7a9XEzbIxvKSm1QMInXWJZBf5JjA
        PljjSyYIRwJPb4dHXw7Hzg/HI9yfcXc=
X-Google-Smtp-Source: AMrXdXvdgoKtg5dMQONAK6q/GptxY+yvMH4riZfYIewdvX0/oOdpo1YTdRkyuS0V/ffonFuPTuBYtw==
X-Received: by 2002:a2e:9588:0:b0:277:413:7da3 with SMTP id w8-20020a2e9588000000b0027704137da3mr2155659ljh.49.1671724589747;
        Thu, 22 Dec 2022 07:56:29 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id z13-20020a2e350d000000b0027eb5903568sm83550ljz.72.2022.12.22.07.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 07:56:29 -0800 (PST)
Message-ID: <791f5e52-6035-2501-7bc2-2795e43ae1c1@gmail.com>
Date:   Thu, 22 Dec 2022 18:56:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 01/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <62fc4a96-bab8-4d43-5278-3375e34431e7@gmail.com>
In-Reply-To: <62fc4a96-bab8-4d43-5278-3375e34431e7@gmail.com>
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

21.12.2022 22:20, Dmitry Osipenko пишет:
> 20.12.2022 19:02, Sumit Gupta пишет:
>> +static int tegra_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
>> +{
>> +	struct tegra186_emc *emc = to_tegra186_emc(dst->provider);
>> +	struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
>> +	struct mrq_bwmgr_int_request bwmgr_req = { 0 };
>> +	struct mrq_bwmgr_int_response bwmgr_resp = { 0 };
>> +	struct tegra_icc_node *tnode = mc->curr_tnode;
>> +	struct tegra_bpmp_message msg;
>> +	int ret = 0;
>> +
>> +	/*
>> +	 * Same Src and Dst node will happen during boot from icc_node_add().
>> +	 * This can be used to pre-initialize and set bandwidth for all clients
>> +	 * before their drivers are loaded. We are skipping this case as for us,
>> +	 * the pre-initialization already happened in Bootloader(MB2) and BPMP-FW.
>> +	 */
>> +	if (src->id == dst->id)
>> +		return 0;
>> +
>> +	if (mc->curr_tnode->type == TEGRA_ICC_NISO)
> 
> The mc->curr_tnode usage looks suspicious, why you can't use src node?
> 

This function sets memory BW for a memory client and not for EMC.
Apparently, you should move the BW setting to tegra234_mc_icc_set() and
then tegra_emc_icc_set_bw() will be a noop.

