Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7246A92E5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCCIpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCCIpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:45:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984002FCFE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:45:14 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s11so7304146edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 00:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677833113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9G7Z10AVSdONw3W6JnRiZwf/5AZNd564GjDhjPetl9Q=;
        b=eMRZYIKnxHa7KknCda+qvFF+rbs9+GerKJa5roZyQWI7l++xtp7XwmSJHrZoG0nm/O
         oonI6nR+agkx6a/r7zdpe6kOvnF6E5pu/MwZrmLxR0tpUo3otGReoGraJ5V6SD0Vtrh0
         om2PPjbG7UYi/lwsOmhZn5s6N/t0kaPnJ4dblJnb0wrUfjcagXRP2JKkas0Nazsyb2Cx
         /gGQZiOloWRa4SDAs/6lEWyoDk07bVwt8IWZxck7hjwQEnWXNsyHcxYz0WJWdxB4LdHp
         +3vyqB7AAJUa/L4yMXDZb5GWe4sS5cPKUIEOl1XYJfmpFhLfNYotanmvc+b57Jhw2O9w
         KvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677833113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9G7Z10AVSdONw3W6JnRiZwf/5AZNd564GjDhjPetl9Q=;
        b=SwoGe7qu6Co3071T99BkOwmPWMQ1MWBvRMchGqyB9DoHCi1KEh1HNnzRXXsrBrQ0jq
         KaqWWAY0lZ6+yM08i+3zKSr2yH37Ws4nBJ+j5puOjahWCg91oKSZ8gsbk25t/PrFJHMK
         0sunRvs1+D5NG0JCJSNaRTWbqbB/zmvtYVeRtdvHYW3ijUKMylyGVFLhCWlAX2zp5fyr
         Y0BC9PVOM4ocN/1mwwG6YHV2ncYI69XZ8b6WKR+hoosOT9E65r5NZHEpdQOk7CKXBTP0
         P2IY3fVVIpX1FXbYqsRGyNmNnR+C1d3XE8AXd9Cfs40wOYoxcCqTzyDQSwRsyslBxpWK
         ms0A==
X-Gm-Message-State: AO0yUKUyXlQXnb4okS21T/zDq6SrdVo1GrLFz26MCo4v66DTuanKYD+c
        +8J5gBTXgo/9i1FGjQG4H/1h/A==
X-Google-Smtp-Source: AK7set9Xtslyryl4d2AZCVz2DjPMqIt1s08GiaLzSrhjOFUZ6vfN7ScH1ZzXIqGUiB8eYliLBuWRnQ==
X-Received: by 2002:a17:907:6f18:b0:8f8:5779:f1af with SMTP id sy24-20020a1709076f1800b008f85779f1afmr1062212ejc.15.1677833113089;
        Fri, 03 Mar 2023 00:45:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d25-20020a1709064c5900b008b17de96f00sm695872ejw.151.2023.03.03.00.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 00:45:12 -0800 (PST)
Message-ID: <1270c1a6-9e12-3f0b-c90b-f1715ea07f80@linaro.org>
Date:   Fri, 3 Mar 2023 09:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 06/11] media: starfive: add ISP driver files
Content-Language: en-US
To:     "jack.zhu" <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230302091921.43309-1-jack.zhu@starfivetech.com>
 <20230302091921.43309-7-jack.zhu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230302091921.43309-7-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 10:19, jack.zhu wrote:
> Add base driver for Starfive Image Signal Processing Unit which
> handles the data streams from the CSI2 receiver.
> 
> Signed-off-by: jack.zhu <jack.zhu@starfivetech.com>
> ---
>  drivers/media/platform/starfive/stf_isp.c     | 1079 ++++++++++++++
>  drivers/media/platform/starfive/stf_isp.h     |  183 +++
>  .../media/platform/starfive/stf_isp_hw_ops.c  | 1286 +++++++++++++++++
>  3 files changed, 2548 insertions(+)
>  create mode 100644 drivers/media/platform/starfive/stf_isp.c
>  create mode 100644 drivers/media/platform/starfive/stf_isp.h
>  create mode 100644 drivers/media/platform/starfive/stf_isp_hw_ops.c


> +}
> +
> +static int stf_isp_reg_read(struct stf_isp_dev *isp_dev, void *arg)
> +{
> +	void __iomem *ispbase = stf_isp_get_ispbase(isp_dev);
> +	struct isp_reg_param *reg_param = arg;


Didn't you add now code which does not even build and is not bisectable?


Best regards,
Krzysztof

