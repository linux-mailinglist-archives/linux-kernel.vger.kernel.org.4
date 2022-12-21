Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA97652AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiLUAzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiLUAzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:55:12 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2091E1D674;
        Tue, 20 Dec 2022 16:55:11 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p36so21142755lfa.12;
        Tue, 20 Dec 2022 16:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=icuNmbOQEcEju3olzJkHaa9PEaxwgAWvjH8njEvfihY=;
        b=ZFBPm6lJ3tsBQUPRXB3f0P+DBAmFNVufbu5wxwlKeKEJqbppQjbOZKFAg5uLLXzTEY
         K76Fq6EAVlx4iQ/rcQqts3GtYbvKdG3v+NHl8OOBJLRwMvgLMcIQEdUE3vFUOTIFRPkB
         kldRWbXcqSMYjCc1AEA2YGVWJrrKLJKcygePkKFPSsrKJuv8AFmhuHDf0Xae4Cv6UPlh
         sR4DO8a/Un8TwJIsuyUiD2jLHkI4Ie/KTe7M8ydws2tC01cr+A/SJgcj985RoCwgV5f0
         pd6gRJ0MhHE+oNZf6nFlhKcgG+TjACyG0IbqCr8I8RL4GiG1QJL2AcJ3ilJNMyAQmRK9
         CnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icuNmbOQEcEju3olzJkHaa9PEaxwgAWvjH8njEvfihY=;
        b=AfEkB1zLkPgxG9msZ/iGyBLChaIba4uzuvxILr2RZNF23onJ2h1ui7nqB6g6klC42n
         CBEz59m/GVyPyt4qEYp9HpUB6bbWZ261xZPS/ss28k20TPPJroJ0IvFDBhRvFIXM65V+
         KInG6CojgQxeCRWdA1cxKhWk9ECaACcKf9el1/Gop5NcgqyRZWvkNBX+7YHHMev92UXz
         X7D/32SQt+dPSl6XCijiPDY5eT7rWvGC9l0akeCe5vCXK6U+UqNN18ur9HV4/xibM0Yg
         FwrhPjAkFu+6+c4xutsUgogZQp/4XbevMNzm+xQrOlwGPcrYApBzxy0lmJVqllMIRe3/
         /wlQ==
X-Gm-Message-State: AFqh2konJp9YZMVqzB7lODsvIRFkn1lkWER1xjmwd3F+Fp8Gys5eREKP
        l0lCqnccZOEkxl/B66jPIhyu52Wo84Y=
X-Google-Smtp-Source: AMrXdXs+kPJH1dzn+Ceh0GTObDrnXwFJR17iWf2HYTst51ayKoBNREF3K0CIRkgtd70abjNZ6AsSSw==
X-Received: by 2002:ac2:4bd3:0:b0:4b4:a460:c995 with SMTP id o19-20020ac24bd3000000b004b4a460c995mr55748lfq.5.1671584109361;
        Tue, 20 Dec 2022 16:55:09 -0800 (PST)
Received: from [192.168.2.145] ([109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id s17-20020a056512315100b004b4b0a68f67sm1632770lfi.185.2022.12.20.16.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 16:55:08 -0800 (PST)
Message-ID: <0fe5ac44-9467-1dbb-3a69-5ab5839d251e@gmail.com>
Date:   Wed, 21 Dec 2022 03:55:01 +0300
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
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.12.2022 19:02, Sumit Gupta пишет:
> +static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct tegra_mc *mc = icc_provider_to_tegra_mc(dst->provider);
> +	struct tegra_icc_node *tnode = src->data;
> +
> +	/*
> +	 * Same Src and Dst node will happen during boot from icc_node_add().
> +	 * This can be used to pre-initialize and set bandwidth for all clients
> +	 * before their drivers are loaded. We are skipping this case as for us,
> +	 * the pre-initialization already happened in Bootloader(MB2) and BPMP-FW.
> +	 */
> +	if (src->id == dst->id)
> +		return 0;
> +
> +	if (tnode->node)
> +		mc->curr_tnode = tnode;
> +	else
> +		pr_err("%s, tegra_icc_node is null\n", __func__);

The tnode->node can't be NULL.
