Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A076167D8D5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjAZWv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAZWv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:51:58 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C447485AF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:51:56 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id u8so1418254ilq.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uo4DJ1lMHTQjHl0PyGseokoZraJeV8jwhzCuVW5LRgY=;
        b=BzaQCkIizxh8plvJG7iydcbwTBB2KmS90zskK8PMkXY+40JZpDWrHFSmX1FvFS8AQq
         gZW5s9WXuFdHxOnB7dPDwIFBKJpKWAFpm/WPOK1/u4buJPzzYAJK6PNfV6Sw31SOTnwC
         4F5j8ycoLc2Z7lQo4j0wZgglXF8dtgjNYd99AGLhkPmuFKo3cA4rhOulWrt6Nz+ZO1CH
         iXlBrWfIY+zg1YY8FeHxA6GeUTvN1pLO082IlYYkVHq2DHK952C8rlvndAlJ4yqgS1Hk
         dMpRiz3xn0LyB+zCzCv2KAJMq5X9SqND0HLPyhZNUHiP+iqayXPuDYbAdpZJzo1J0ISF
         0y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uo4DJ1lMHTQjHl0PyGseokoZraJeV8jwhzCuVW5LRgY=;
        b=sqLnvqB4NMvqe9Mk4310T0ezmRlm8g17Sq6Rj27L0VqfVlB1GejoWvezFBXN63+Q2j
         etEtPWuV1Q05of62M6q2FMizPwSV7rDL5nKvAL+eDutBQUOhSNbdQXhQCJxFQSg8Of8u
         Kalg4hc0L8UXt5AHh3sbBBVPTBwOxtR5S5vkmO7T4ajlWpdAVgE56CkmGKu4utDb41jL
         Jfgc7XJZyAJWzKQdm5NmHylfNFOgKua3ixGiYphGAWr/Vh7u31+E6zXc9N+8IOXtow4l
         yFsFshz2+yuRX/+mOa1e0R6/Iv94Amk3QPkEexCmkY/+viVMmbpeq7hnlEP4H7uTJdaa
         1/AQ==
X-Gm-Message-State: AFqh2kqrOZbNayb2q54+HXqKNQmqn9NOGO4fIzCcS7uNFaLwQzMxwVcM
        koLvsgDnjEqZ0NCb/3OUYNYFpg==
X-Google-Smtp-Source: AMrXdXtchiQCUB3Dd3Ffougvu41joys5qhOIRIUqMHGgA5iHVseRT58AFLQqOicQNrt5nO3h2n27Tg==
X-Received: by 2002:a92:bd12:0:b0:30f:36d8:e4ca with SMTP id c18-20020a92bd12000000b0030f36d8e4camr21487379ile.21.1674773515927;
        Thu, 26 Jan 2023 14:51:55 -0800 (PST)
Received: from [192.168.2.31] ([194.204.33.9])
        by smtp.gmail.com with ESMTPSA id e5-20020a022105000000b003755aa71fffsm869305jaa.105.2023.01.26.14.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 14:51:55 -0800 (PST)
Message-ID: <7d0582ac-e5c1-7dbf-8063-f6ea8cb59862@linaro.org>
Date:   Fri, 27 Jan 2023 00:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 7/7] clk: qcom: add the driver for the MSM8996 APCS
 clocks
Content-Language: en-GB
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org>
 <20230118132254.2356209-8-dmitry.baryshkov@linaro.org>
 <7055af43f4a8894ac34e53c5847fb3de.sboyd@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <7055af43f4a8894ac34e53c5847fb3de.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 23:38, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2023-01-18 05:22:54)
>> diff --git a/drivers/clk/qcom/apcs-msm8996.c b/drivers/clk/qcom/apcs-msm8996.c
>> new file mode 100644
>> index 000000000000..7e46ea8ed444
>> --- /dev/null
>> +++ b/drivers/clk/qcom/apcs-msm8996.c
>> @@ -0,0 +1,76 @@
> [...]
>> +
>> +static int qcom_apcs_msm8996_clk_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct device *parent = dev->parent;
>> +       struct regmap *regmap;
>> +       struct clk_hw *hw;
>> +       unsigned int val;
>> +       int ret = -ENODEV;
>> +
>> +       regmap = dev_get_regmap(parent, NULL);
>> +       if (!regmap) {
>> +               dev_err(dev, "failed to get regmap: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       regmap_read(regmap, APCS_AUX_OFFSET, &val);
>> +       regmap_update_bits(regmap, APCS_AUX_OFFSET, APCS_AUX_DIV_MASK,
>> +                          FIELD_PREP(APCS_AUX_DIV_MASK, APCS_AUX_DIV_2));
>> +
>> +       /* Hardware mandated delay */
> 
> Delay for what? Setting the divider? What if the register value didn't
> change at all? Can you skip the delay in that case?

Ack, I'll expand the comment.

> 
>> +       udelay(5);
>> +
>> +       /*
>> +        * Register the clock as fixed rate instead of being a child of gpll0
>> +        * to let the driver register probe as early as possible.
> 
> The function doesn't block or return EPROBE_DEFER if the clk is orphaned
> when registered. Why is this necessary? Are you getting defered by the
> fw_devlink logic thinking it needs to defer probe of this driver until
> gpll0 provider probes? We should fix fw_devlink to not do that. Maybe if
> the node is a clk provider (#clock-cells exists) then we don't wait for
> clocks property to be provided, because the clk core already handles
> that itself.

Letting clock-controllers probe was my idea for the patch, but it was 
delayed again by Saravana, see [1], [2]

[1] 
https://lore.kernel.org/all/20230118091122.2205452-1-dmitry.baryshkov@linaro.org/

[2] 
https://lore.kernel.org/all/CAGETcx8Xy5OzsbW3123esxsbQJq-SqDkP1S5g2mmwzoCz4shtQ@mail.gmail.com/

> 
>> +        */
>> +       hw = devm_clk_hw_register_fixed_rate(dev, "sys_apcs_aux", NULL, 0, 300000000);

-- 
With best wishes
Dmitry

