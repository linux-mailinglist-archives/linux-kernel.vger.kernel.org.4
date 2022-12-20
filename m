Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7595265260B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiLTSLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiLTSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:11:00 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7292A12D2C;
        Tue, 20 Dec 2022 10:10:58 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f16so13194689ljc.8;
        Tue, 20 Dec 2022 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCgvLxGszpcqBmYL7G26fw2zZ2/wqSpCHLDM+cNyPgI=;
        b=JflZ991nO9+q3StleuPYPYvI/SYtKxCV57+m2ta6t9PMPKDqmD8KqrZGSEjnbhACAf
         f3GTO4rdd6omXL/Lk00wxSUeoACwLmO2Yy/j8LdGpAok4aafVK86coQ1VAXKjn8dmHRz
         YaXg1ebaI5OuDYTEj/Eb2GTL3idtNktkpdlc3hg2uDctk9XGaqLRqLdgZFizmhybwcnT
         jPK1sheetvmtAF3DGG0pxOkyWaY+B/mjmFxnl9w2clkRWPHA59hX3lEJEk1bYUF8yLqS
         hjyUC58RzVyKFQkPejKQGXzdz7fVHeTxLdb9UllXhjsN0hIA189VHR0NQvHWwhDQh3a0
         l8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCgvLxGszpcqBmYL7G26fw2zZ2/wqSpCHLDM+cNyPgI=;
        b=kTXqLvyQHtNOaMadeXQQS0rs92I+vWqbz+/CIHNKTBJ9AI5jwUKq2QkwEhGYP7ojgx
         HGcB79dusGwkU56GQjZsi+V5b/B23TeXEPnJw5Z2kG+Yo+o0na+XzYFLK7ICH8avOwig
         OXYp9GyEk++qBqHOUGkenjkGj8HuKDaDR+a/Vs6gsjso4krC+ECED/W32U0VwpTqHI8y
         EUQBTbsjwqpEVrQm0ONJTqnVu1RiHcJldX1SG1cFKL5LVQBRYp+qN0NiwR8rSdYougJY
         JYYwPpehvMdqA/7z6T3d+Ac3FFFSBxDR9aJ9AXwxa2Yr+fij+pvviKSPecQvwyKQ422m
         GcDA==
X-Gm-Message-State: ANoB5pmeoIFxw2DhzF1Y/+2j+tnKlFLtF4SbetGCZxvrV/jm923dnJ3Y
        hfxSYUW/Ohn9aslvVx/pUfA=
X-Google-Smtp-Source: AA0mqf4aKschK9ygVYnNCcRfkDlSGFMATrw4+unJGjXm+d3l3pObcsb2tfiatDf4kFWqCaNWs4g1Dw==
X-Received: by 2002:a05:651c:198c:b0:279:6514:54e6 with SMTP id bx12-20020a05651c198c00b00279651454e6mr16704634ljb.45.1671559856707;
        Tue, 20 Dec 2022 10:10:56 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id q14-20020a2eb4ae000000b002790fbb5f89sm1088848ljm.44.2022.12.20.10.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 10:10:56 -0800 (PST)
Message-ID: <4d562b75-854d-1997-8969-e7ef222e4e37@gmail.com>
Date:   Tue, 20 Dec 2022 21:10:49 +0300
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
> +static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
> +{
> +	*avg = 0;
> +	*peak = 0;
> +
> +	return 0;
> +}

Looks wrong, you should add ICC support to all the drivers first and
only then enable ICC. I think you added this init_bw() to work around
the fact that ICC isn't supported by T234 drivers.
