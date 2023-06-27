Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59EF740547
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjF0Uvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjF0Uvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:51:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BADD2727
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:51:33 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6985de215so52125351fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687899092; x=1690491092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCzDt5CROKYWDohsq+V3lFQ9c+DIuiELGjjW1xUO8b4=;
        b=qAyW46DhS3+TOPwxuOExnMpdtCBEUamMGarvJg9AcKe+yAemmVGXuJDBhKSC2Wvt09
         +JylKWvPIxN+Cm0K5vEBsJiLTJSL3vk881EyySiYp2NkDp6Blw6EIDY6QgiGw8ZysSP3
         Vs7wSppcZM80nNFx+UI3K2c87rc7afx3SqmAAqBdzvHouiows1haUY8tFPt6Anfs78zv
         xgEzx3oa7bWgJxYUSFbAf4tz55mRNvdYUuP7sC/350TTrUvZoAe66xhict4TnURHScPq
         LKcHgBd1dWr9ee2Xzs69iTaWv69vMAANoio4PO+9gqQwEzoNTJrFVAQyB2AIGcVdakI4
         DUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687899092; x=1690491092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCzDt5CROKYWDohsq+V3lFQ9c+DIuiELGjjW1xUO8b4=;
        b=C8AFIDxv9/YYENNsD+po+tE5hhG94UYhoaIhjyK3ImTcdHoikHd8nwRocJQtjRUY1x
         yVDy69gwT51yej/wWlaA7WoVYLWlQ6eYbc0TeergWv1xCa69XjNIidyegFrQ0vRhId3O
         YegAP/p/xmgn+5y+ZFSF4Wt9hVUPw52/6eaVeijcyMFskt4x9G7NhrH6xwk5WzMcwvSw
         YJTfxm1Bd05D7WJNdKE7SRK+yOwJubqXWaIvhd70/d8gbMopDJ1g2DkfaR7aoxSqmAPj
         9u9o9KH4MGRwhqvXx+K9XzKOkcz4B526nOUYZgjLF+CbEbuV9nsRZGnBLSDgkXP9O9f9
         S3IA==
X-Gm-Message-State: AC+VfDyMIONK8pwnAGqZ9HmcWPsQTbXTjZI0W5MQbzaxtayTk4HH2ouZ
        ll4qUly5UQ/rTzrKRNR55n90/A==
X-Google-Smtp-Source: ACHHUZ5ZPUTrUE7nD8aIZbN7Xlww2DznNh1NZ2SSDhF7luRrOhP1OuGQ77OUjfsUyGqY8U50Ifyk9g==
X-Received: by 2002:a2e:95d7:0:b0:2b4:65bf:d7b with SMTP id y23-20020a2e95d7000000b002b465bf0d7bmr18474072ljh.2.1687899091991;
        Tue, 27 Jun 2023 13:51:31 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id y20-20020a2e95d4000000b002b6b928a6d8sm161413ljh.33.2023.06.27.13.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 13:51:31 -0700 (PDT)
Message-ID: <8656ec99-82fc-3570-701d-df4266712348@linaro.org>
Date:   Tue, 27 Jun 2023 22:51:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v11 6/9] soc: qcom: cpr: Use u64 for frequency
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
 <20230217-topic-cpr3h-v11-6-ba22b4daa5d6@linaro.org>
 <2e11a98a-3e44-7164-84cc-7bbd519b608a@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2e11a98a-3e44-7164-84cc-7bbd519b608a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.06.2023 22:15, Jeffrey Hugo wrote:
> On 6/27/2023 12:30 PM, Konrad Dybcio wrote:
>> 32 bits is not enough for over-2.changeGHz frequencies. Move all variables
>> that operate on Hz to u64 to avoid overflows.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> 
> I get the following warning when building this -
Ugh. Either didn't notice or clang wasn't unhappy with it.

Thanks for noticing.

Konrad
> 
>   CC      drivers/soc/qcom/cpr-common.o
> In file included from ./include/linux/device.h:15:0,
>                  from ./include/linux/platform_device.h:13,
>                  from ./include/linux/of_device.h:5,
>                  from drivers/soc/qcom/cpr.c:18:
> drivers/soc/qcom/cpr.c: In function ‘cpr_corner_init’:
> drivers/soc/qcom/cpr.c:870:21: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘u64 {aka long long unsigned int}’ [-Wformat=]
>    dev_dbg(drv->dev, "freq: %lu level: %u fuse level: %u\n",
>                      ^
> ./include/linux/dev_printk.h:129:27: note: in definition of macro ‘dev_printk’
>    _dev_printk(level, dev, fmt, ##__VA_ARGS__);  \
>                            ^~~
> ./include/linux/dev_printk.h:163:31: note: in expansion of macro ‘dev_fmt’
>    dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>                                ^~~~~~~
> drivers/soc/qcom/cpr.c:870:3: note: in expansion of macro ‘dev_dbg’
>    dev_dbg(drv->dev, "freq: %lu level: %u fuse level: %u\n",
>    ^~~~~~~
