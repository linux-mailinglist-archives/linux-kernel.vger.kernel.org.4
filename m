Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A3E620E53
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiKHLNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiKHLNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:13:32 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAAA7640
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:13:29 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s24so20560344ljs.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6jOxeuiN/P01zuIfksPvOeqYmxHvoXJTsaDxoCzoKc=;
        b=AJWW7q3rfm8uJ5TAPfZceGmBAUYtgGRyVzRsBn9NKAmQkl07a0ZA9Z0sebEgvC4Qqj
         h++Y2PeOi5je4QMztSNvVfQyfBHESw54AWECOf06LfbR0Zq/phtWTUjZVK2wpABXlI0p
         8jStsY+gWu3bdmXhjNh8WSf0a8ez4apalpQ887SIIQ6PcSzSYaAhDR4Y2/MS7K7dcYtW
         vIRu1DvBEnt3t7la1J980coDN+bggzpB3VblRVqxWuRoNsdaZYNqTIfsMj2pG6YfWMbb
         zwrwTs5MN2EzDFL6J7s0l7VtIiC5e0YLVOKcI6+LTDRgAWU2x4YPpCJ85vu+RNfmgDMi
         BfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6jOxeuiN/P01zuIfksPvOeqYmxHvoXJTsaDxoCzoKc=;
        b=ktkIfzOFNgHKvLd1iL8MjYcOiNRxfkFsidN+TCe5pQ48GUxJLqAcHJbRKEWIpef+7i
         38mTEfsSl7rQkeemQ0DXKB/vCnabG+s7LC5RzA5b0AWNRsICxiZPM4sm9Sk01kjyeX3l
         +S2eC8s/kqNJOTT+4mbt6yoTnk/wXI9wtpQORMsdjQiMHbJCvx4nf3vtc7U78x/IzdSW
         nZO9YhpLqDO7Nxyfc32t3Xdq+FYjbp4fdS5L2gkEvuZZIVKFYMmhkW5aW6ZQr3hl2raE
         df8duWrW81WMlv9CAliJ7GtAXZWTSq7eXx8oleot/+bmRgXj0pYpV1OVse4ooNj/T8A5
         MYEA==
X-Gm-Message-State: ACrzQf1rpPRpqBopMeiOqSagrX9VCHzR3Zr2z4qWvFL/ETdGo1Zr1Gc0
        n8//+ZhmhJ5vufqzH0549x5Pyssa1urxmA==
X-Google-Smtp-Source: AMsMyM4BamTVwnVRVEzHMxTSWzVqGEy7NnZV4CojHp0kgr4RUINHxdiS3OTFIT2molBMkjMfY86rKg==
X-Received: by 2002:a2e:9545:0:b0:277:8a06:fda2 with SMTP id t5-20020a2e9545000000b002778a06fda2mr5368558ljh.32.1667906007777;
        Tue, 08 Nov 2022 03:13:27 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id p16-20020ac246d0000000b004acd6e441cesm1735642lfo.205.2022.11.08.03.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 03:13:27 -0800 (PST)
Message-ID: <f8f83839-2e76-e500-a16e-5fd2985a278d@linaro.org>
Date:   Tue, 8 Nov 2022 12:13:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 5/5] arm64: dts: uniphier: Add NX1 SoC and boards
 support
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221107103410.3443-1-hayashi.kunihiko@socionext.com>
 <20221107103410.3443-6-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107103410.3443-6-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 11:34, Kunihiko Hayashi wrote:
> Initial version of devicetree sources for NX1 SoC and boards.
> 
> NX1 SoC belongs to the UniPhier armv8 architecture platform, and is
> designed for IoT and AI/ML application fields.
> 

> +
> +		soc_glue: syscon@1f800000 {
> +			compatible = "socionext,uniphier-nx1-soc-glue",
> +				     "simple-mfd", "syscon";
> +			reg = <0x1f800000 0x2000>;
> +
> +			pinctrl: pinctrl {
> +				compatible = "socionext,uniphier-nx1-pinctrl";

So instead of documenting the hardware precisily, you have one big bag
for everything under simple-mfd. This is not how the SoC should be
described in DTS.

> +			};
> +		};
> +
> +		soc-glue@1f900000 {
> +			compatible = "simple-mfd";

No, it is not allowed on its own. You need a specific compatible and
bindings describing its children.


Best regards,
Krzysztof

