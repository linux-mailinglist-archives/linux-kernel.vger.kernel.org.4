Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF400730631
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbjFNRkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbjFNRkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:40:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AD51BF0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:40:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f7deee339dso299687e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686764410; x=1689356410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7ewiUSnCS3rNCPsoJCYT5f68i4M3iIUicklGo7JmxE=;
        b=cxKWNJzbvcvHplxwGHO9tu2JAcUmf8AMQCehGwFdhHLi0QYmM951++Im7lizzvQoXR
         lvJgfLkVO6Y1LfS4dVQotxYgdCoXpx8YFRSZCN+tCLdjjK5gMQSXZ113Yh0Lx3Pgf9jh
         bFGM01yBa3oisci3WDjbkrJKIzh0dQquhEg2tv0SaIC6jTsFR3BjWSwTWCqr1YKozVIm
         V2DjrHSn/p/IeW9yWsGjfgRnoWvNmwE6Q0hvWpWJ1S7CoP7Jw2a4Kzbw+bxQimGiDD0M
         MGzTqC5GcO3PwY4xbNLLRf8NLAvjzGLCXEzZD9Y0aTZIh1YRt8ZioqGq8SdldALq9ofP
         ubfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764410; x=1689356410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7ewiUSnCS3rNCPsoJCYT5f68i4M3iIUicklGo7JmxE=;
        b=b8lIzDa+/r26Z9XCt54V4ODtkVZ4+OG8tOsDug4IA6JxgCD8ROzNLCYzd5OFmRX6co
         jiNyu18z6Fd5TDa5A4H0wGgiQ1S/00/S+J/CGJoDEbe3d1SIj4KphUp/G6HBDlvHQ+il
         EXA2QwPgOz8MBg98I0UMC9hsbZ5tjRhNt7EhOlMwUh9o2FiPtVA1fbxAbqkhpb5elKfp
         0Q7y1uUV30LDNsVfRWKUBucJhzWmBr7O8At3NL7gAr3RbDquo7WtON10FIE7RxxsevE0
         Mg1S2aeFw3Cfcz0Iwczqb4jWCjadc62xUrormPnSSmiMDi18qOCLxrxQVzcOJo/LRtJE
         tI3g==
X-Gm-Message-State: AC+VfDz4i/vCEtJ4lJwZm1zokkcS7twmXvDu1UHQXcsjVdgrxy0O/sDd
        xhqy8Jz2Y0lFVZ4sLBuuTFrWZw==
X-Google-Smtp-Source: ACHHUZ42uaXU6+8DZVhsw4tg5ChgANQZ7OV1TTRlzA7XRCTwEtkTBTBAp0iTmvbHQcrQ5C1tdujs/g==
X-Received: by 2002:a19:9113:0:b0:4f7:68c6:e352 with SMTP id t19-20020a199113000000b004f768c6e352mr1218978lfd.38.1686764409711;
        Wed, 14 Jun 2023 10:40:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004f14ecc03f1sm2205264lff.100.2023.06.14.10.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 10:40:09 -0700 (PDT)
Message-ID: <eb39cef0-7e1c-f0dc-12fa-6a5a746d17d1@linaro.org>
Date:   Wed, 14 Jun 2023 19:40:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 08/22] interconnect: qcom: smd-rpm: Add rpmcc handling
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
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
 <20230526-topic-smd_icc-v5-8-eeaa09d0082e@linaro.org>
 <ZInS7WZ_-02iZiKp@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZInS7WZ_-02iZiKp@gerhold.net>
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

On 14.06.2023 16:47, Stephan Gerhold wrote:
> On Wed, Jun 14, 2023 at 12:22:19PM +0200, Konrad Dybcio wrote:
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
>>  drivers/interconnect/qcom/smd-rpm.c | 21 +++++++++++++++++++++
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>> index 9ec90e13bfbd..d857fb1efb75 100644
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
>> +int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, int rsc_type, u32 rate);
>>  
>>  #endif
>> diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
>> index b0183262ba66..b06374340eeb 100644
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
>> @@ -44,6 +45,26 @@ int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
>>  }
>>  EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
>>  
>> +int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, int rsc_type, u32 rate)
>> +{
>> +	struct clk_smd_rpm_req req = {
>> +		.key = cpu_to_le32(QCOM_RPM_SMD_KEY_RATE),
>> +		.nbytes = cpu_to_le32(sizeof(u32)),
>> +	};
>> +
>> +	/* Branch clocks are only on/off */
>> +	if (clk->branch)
>> +		rate = !!rate;
>> +
>> +	req.value = cpu_to_le32(rate);
>> +	return qcom_rpm_smd_write(icc_smd_rpm,
>> +				  rsc_type,
>> +				  clk->resource_type,
> 
> Sorry to have more minor comments but as you can see here the resource
> type is taken from the rpm_clk_resource. The parameter that you are
> describing as "rsc_type" is actually the "ctx" in the other function. :')
Meh I fixed it too fast.. thanks

Konrad
> 
> If you fix this feel free to add my:
> 
> Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
> 
> Thanks,
> Stephan
