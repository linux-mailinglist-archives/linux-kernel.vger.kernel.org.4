Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE9B72EF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbjFMWlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239322AbjFMWlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:41:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8816C129
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:41:07 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f629ccb8ebso7582707e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686696066; x=1689288066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mM2+93Chwu7bwUwshRRZL1JMaegUn5yKzga2WzqyZzI=;
        b=rtI5EpOAy3camCvRJE8ovAjNX2hMd20MLGU+rC8tbMqtbmb7qlZ9uunnMKzmAjWzP9
         n3UzZyEDBBv4lS5vJi2cXN2JDzL4Cb1eh+IJZKn8EWWEEuNiO3a3ywaR6GUTt/Cu3lmY
         gvlqHFd/RgXYdu0HpQE0KPUYVp7atrtx8VHl/uWSdz9oT8zEH0TnCzwEnU7wIUrHm/77
         e38RU2H2qPVe41PYtLJ/QMkCzGt8Zuf/wwtCdoATm2IF/1HF3ztDGEoEgY91Xmqk7Plh
         XeSQ2gjRox/flrYotHz6esVkP4rwgIVCFzKMfmT36NnG/8o2Cr/QtiRzrre+uNk55ykF
         2xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686696066; x=1689288066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mM2+93Chwu7bwUwshRRZL1JMaegUn5yKzga2WzqyZzI=;
        b=cQzNl+RhsA/EoyRinCi3hMLwF72qqhY99DHTSvC4OzunMvxjo2dcRmUIsz1jNIMsHy
         X7atqffqZtdctQJJox8XV2ehHN7c+Ciaq1Z0xNt589i7ZvVUJSgNjw0rnC1GN2i44ww9
         V4z4rBrsORpZWTcg4KE3Mens4+BC/TAHG/Yq62xaueI+Y4tGvxDfp4xwPnE9QNEDf8sa
         eLus30kckQ/Apjpu84ipWbVfB3TyGTB5rNjDB0uJIyim/mgYR4NVh9GqjgbanvBA16tm
         syg6QBUDkJw796gphxAaygwe3nEXw7JQUbBRnyd9lbOJYrEvNy8ArfYbLd/1D6XUl1vi
         g75A==
X-Gm-Message-State: AC+VfDxN4L8P5On5Gcd9M7B0sp0vo61D4oeufUxLSYaxZcRyexDIJJA/
        rHOQjY+r87111wS0vaXlGsvgrg==
X-Google-Smtp-Source: ACHHUZ43oO1BCBYbrneX5Pa5lN5HOMz0cCRafq3HWi4SGTpLsQJ08prrNngm4wYYitPJEJ+jgI/8Og==
X-Received: by 2002:a05:6512:539:b0:4f6:1462:9985 with SMTP id o25-20020a056512053900b004f614629985mr6327871lfc.21.1686696065284;
        Tue, 13 Jun 2023 15:41:05 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id w13-20020a05651204cd00b004eefdd8b37fsm1885609lfq.194.2023.06.13.15.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 15:41:04 -0700 (PDT)
Message-ID: <ad3b3233-b1d6-781e-16e5-9faaaf14fc7a@linaro.org>
Date:   Wed, 14 Jun 2023 00:41:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 08/22] interconnect: qcom: smd-rpm: Add rpmcc handling
 skeleton code
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
 <20230526-topic-smd_icc-v4-8-5ba82b6fbba2@linaro.org>
 <ZIjNLJQwYQGj3piA@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZIjNLJQwYQGj3piA@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.06.2023 22:10, Stephan Gerhold wrote:
> On Tue, Jun 13, 2023 at 04:03:08PM +0200, Konrad Dybcio wrote:
>> Introduce qcom_icc_rpm_set_bus_rate() in preparation for handling RPM
>> clock resources within the interconnect framework. This lets us greatly
>> simplify all of the code handling, as setting the rate comes down to:
>>
>> u32 rate_khz = max(clk.sleep_rate, clk.active_rate, clk_a.active_rate)
>> write_to_rpm(clock.description, rate_khz);
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/interconnect/qcom/icc-rpm.h | 15 +++++++++++++++
>>  drivers/interconnect/qcom/smd-rpm.c | 22 ++++++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>> index 9ec90e13bfbd..13ca0818ffbd 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.h
>> +++ b/drivers/interconnect/qcom/icc-rpm.h
>> @@ -22,6 +22,18 @@ enum qcom_icc_type {
>>  	QCOM_ICC_QNOC,
>>  };
>>  
>> +/**
>> + * struct rpm_clk_resource - RPM bus clock resource
>> + * @resource_type: RPM resource type of the clock resource
>> + * @clock_id: index of the clock resource of a specific resource type
>> + * @branch: whether the resource represents a branch clock
>> +*/
>> +struct rpm_clk_resource {
>> +	u32 resource_type;
>> +	u32 clock_id;
>> +	bool branch;
>> +};
>> +
>>  #define NUM_BUS_CLKS	2
>>  
>>  /**
>> @@ -47,6 +59,7 @@ struct qcom_icc_provider {
>>  	unsigned int qos_offset;
>>  	u64 bus_clk_rate[NUM_BUS_CLKS];
>>  	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
>> +	const struct rpm_clk_resource *bus_clk_desc;
>>  	struct clk_bulk_data *intf_clks;
>>  	bool keep_alive;
>>  	bool is_on;
>> @@ -104,6 +117,7 @@ struct qcom_icc_desc {
>>  	struct qcom_icc_node * const *nodes;
>>  	size_t num_nodes;
>>  	const char * const *bus_clocks;
>> +	const struct rpm_clk_resource *bus_clk_desc;
>>  	const char * const *intf_clocks;
>>  	size_t num_intf_clocks;
>>  	bool keep_alive;
>> @@ -125,5 +139,6 @@ int qnoc_remove(struct platform_device *pdev);
>>  
>>  bool qcom_icc_rpm_smd_available(void);
>>  int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
>> +int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, u32 rate, bool set_active);
>>  
>>  #endif
>> diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
>> index b0183262ba66..c5ab00051447 100644
>> --- a/drivers/interconnect/qcom/smd-rpm.c
>> +++ b/drivers/interconnect/qcom/smd-rpm.c
>> @@ -16,6 +16,7 @@
>>  #include "icc-rpm.h"
>>  
>>  #define RPM_KEY_BW		0x00007762
>> +#define QCOM_RPM_SMD_KEY_RATE	0x007a484b
>>  
>>  static struct qcom_smd_rpm *icc_smd_rpm;
>>  
>> @@ -44,6 +45,27 @@ int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
>>  }
>>  EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
>>  
>> +int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, u32 rate, bool set_active)
>> +{
>> +	int state = set_active ? QCOM_SMD_RPM_ACTIVE_STATE : QCOM_SMD_RPM_SLEEP_STATE;
> 
> Why not just pass in the ctx/state directly as parameter instead of this
> boolean? That's what the function directly above does.
Ooohh.. obviously...

Konrad
> 
> Thanks,
> Stephan
