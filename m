Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3289163373C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiKVIfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiKVIfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:35:17 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C332AC56
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:35:17 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id h189-20020a1c21c6000000b003d0283bf132so272269wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y2T6ZqILdZ5MYZPi+h6sgVRIvcGTKp6wSXo9ljWxKyk=;
        b=MSiG80M2llfCeWOktKzlHuNXFQ06AB58P9aLesVQR8M5tcynb4f6by+c4ff4BNntdB
         a0dfPzsa5xYaRJ6qgwqyasRXsF+Tk4sdlsSg1vxfvU2KQs3FaxOusCBcpHA5J/kiNkL+
         UibaGT7Bjx2uIohkFnsrVKk6PetSwzKMD+DmpmY62rlTZ61LMBkOT/RPQin/PKgRWW0b
         P+jftlXjK0YZZPhdy0N9Fh3j/j8tyB7AXdSIqjYWlzOyXdrdG/DURUKQ0y6FabdUtplb
         cRpLgumZwf80CUaer6BvJ0BqKIL1GRgE+EaUmOfaZ2omdJzeuOCRC855YLbOFd5fgfO+
         u4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2T6ZqILdZ5MYZPi+h6sgVRIvcGTKp6wSXo9ljWxKyk=;
        b=W5QJNt6MSD6b4NuyZlVUJvPhYW5vFdxya/ZfMmDhnntCPY6zsN8B1woRdDvKX3nfse
         EsykKv7912JtgcqNLks0RhJCwxUUvXoBdLFA1NyjpoRBm0GuN0ojjjSsIaB+jn8h4J58
         s/SbSK/Bap37W4uG/wGQJq8UQjp/WvVaSJtMu+hQ5ppTjSSMveWJP0CIbtmLypCpon+2
         /NRQ/GyyTuj2DhLJbwACT9Crt1HG54urDTG6fzxFLpfBn4plbC3ztkrzBnrJSLDmbYfb
         wDJ5+Xohmsuwd4dvZySg5RHjoNpfMiUzRbICIbgVLvaYW//CDCuFtxIFsaVdiKnL2R+Z
         aeOg==
X-Gm-Message-State: ANoB5pln7n+0rmP++G/2/TQUu2R+qOIWB9rgAZh8y/ca9cA0v8rojbhf
        1LxqpJ6QIj5dv2qyItjSJUnbdQ==
X-Google-Smtp-Source: AA0mqf4RrcJAMC7gMR3GiQG55GMMtRofOJUZb6IKVD4Hvsvc0IpGFrFmV0J4wgtx/7CGEzUf6kjtyA==
X-Received: by 2002:a05:600c:3583:b0:3b4:6c36:3f59 with SMTP id p3-20020a05600c358300b003b46c363f59mr6267560wmq.100.1669106115491;
        Tue, 22 Nov 2022 00:35:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:6969:11a1:a2af:e8c0? ([2a01:e0a:982:cbb0:6969:11a1:a2af:e8c0])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c311100b003a2f2bb72d5sm26105945wmo.45.2022.11.22.00.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:35:14 -0800 (PST)
Message-ID: <8038935f-4ca4-ee13-2088-009a57b88baf@linaro.org>
Date:   Tue, 22 Nov 2022 09:35:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] perf/amlogic: Fix build error for x86_64 allmodconfig
Content-Language: en-US
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <cphealy@gmail.com>,
        Chris Healy <healych@amazon.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221122075002.4052972-1-jiucheng.xu@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <20221122075002.4052972-1-jiucheng.xu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 08:50, Jiucheng Xu wrote:
> The driver misses including <linux/io.h>. It causes
> compiling error "implicit declaration of function
> 'readl' and 'writel'" when make X86_64 allmodconfig.
> 
> Fixs: '2016e2113d35b ("perf/amlogic: Add support for
> Amlogic meson G12 SoC DDR PMU driver")'
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
>   drivers/perf/amlogic/meson_g12_ddr_pmu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/amlogic/meson_g12_ddr_pmu.c b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> index c07c34f03cce..932802abd18c 100644
> --- a/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> +++ b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <linux/err.h>
> +#include <linux/io.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/of.h>


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
