Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E85465372C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiLUToF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLUToC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:44:02 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC08726483;
        Wed, 21 Dec 2022 11:43:59 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x11so1222176lfn.0;
        Wed, 21 Dec 2022 11:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5yhX4t62CgBOAzk9oajDp2zi20+XuGUD+OQN8cgrarE=;
        b=e3soypW6T1YaXIhKWFqwwC6bg4Hmx4hukwse2r3jzMy1L6/a6JBaRI6r1veTli4qCR
         y0oBGu+fot/if3at3qL6Vba9iXiohMlcK2qrOC47F1Q0tri0Ub1XbcwX4mgqQq3iMrto
         6GATAFPwSzcmqCvWgT0W0ZdmXjzjHoKgeqPOkpRwy5sPANabM8nXejBNkaM80Fx9xojE
         xLks/yg9WPDYXNdXS81dpk0cpu15BtGfAL/KwzPURNjS1DH68+TxcdsoN8Ln7t9IE8SH
         e62/anQTdKfAwaHUFJYT/Uzb0SeENFKLoBo8Mpe2YlHfp/TtqtN+tYs9Swlw7fJ7KbFP
         2+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yhX4t62CgBOAzk9oajDp2zi20+XuGUD+OQN8cgrarE=;
        b=sVJrYmoPDjAGzSOZUU9d0Mn84II0Mxwdq+aXAblTfxx+807gTWbtZhnmAB0MCavJMQ
         SRf3mza6gVaCp9osswmq6flLWGeWK1ZoHTJPK1tAx9i9LBD2jlDZxusDhtEKkMAZ+yDN
         oyYt/NdpiJTGfQ44w4EkSNFSr8gK7eANYqrdMEr1BE74Hju7ceSVaK9FtzAodbT0sEzr
         mEtVov1UAX1EET3E/1xiG9TrVnHAEPdWgSKmAQGAWAvyoZkKb59+vFxEvUTGcqzqnKvp
         EZQXsqJZR/HsOPL6S9nyBPnrp285UxaCfXDneae0LI6TtK5Z7qwueWD6rYHqRpzYseq5
         3euQ==
X-Gm-Message-State: AFqh2kpIhFCzmO7XZt+N+tNWFJwkTwrEW85bIuaJfmM3zGvd9sRaJ9Bc
        EhWhYJ5ybFTkWGo2QRReBX4=
X-Google-Smtp-Source: AMrXdXsV/ij7KNcpK3vKFU9CRNwV/i+T2IsbPudEraBj3KtTY7B4owbjphjmrJMlkjb/mwunYc1QQw==
X-Received: by 2002:a05:6512:2527:b0:4b5:8504:7072 with SMTP id be39-20020a056512252700b004b585047072mr893881lfb.14.1671651838124;
        Wed, 21 Dec 2022 11:43:58 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id a12-20020a056512200c00b004b580a526c3sm1935467lfb.295.2022.12.21.11.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 11:43:57 -0800 (PST)
Message-ID: <a1c8c353-3f27-ddb2-6058-d6bea57480d1@gmail.com>
Date:   Wed, 21 Dec 2022 22:43:50 +0300
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
>  static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>  {
> +	struct tegra_icc_node *tnode;
>  	struct icc_node *node;
>  	unsigned int i;
>  	int err;
> @@ -792,7 +794,11 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>  	mc->provider.data = &mc->provider;
>  	mc->provider.set = mc->soc->icc_ops->set;
>  	mc->provider.aggregate = mc->soc->icc_ops->aggregate;
> -	mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
> +	mc->provider.get_bw = mc->soc->icc_ops->get_bw;
> +	if (mc->soc->icc_ops->xlate)
> +		mc->provider.xlate = mc->soc->icc_ops->xlate;
> +	if (mc->soc->icc_ops->xlate_extended)
> +		mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
>  
>  	err = icc_provider_add(&mc->provider);
>  	if (err)
> @@ -814,6 +820,10 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>  		goto remove_nodes;
>  
>  	for (i = 0; i < mc->soc->num_clients; i++) {
> +		tnode = kzalloc(sizeof(*tnode), GFP_KERNEL);

devm_kzalloc

On the other hand, the tnode is unnecessary at all. Use struct
tegra_mc_client for sw clients.

