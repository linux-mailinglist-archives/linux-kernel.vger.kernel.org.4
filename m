Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76BC72E28E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbjFMMNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbjFMMNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:13:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F151B4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:13:01 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso6772614e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686658380; x=1689250380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6CMlQba2o43/QiP5kbF00C5SMM+pc3bqKwMdZ4o71Wg=;
        b=jM2BdMoNCbF74BgGgRDVYE6LKUcsY3HAYxwagM7IqNQFDHyA50WMO364I8ZuLvp9v2
         qGs2ogbEf4zfjDoEPz0k4SbACIKnBKeIiIbl2KvH80pi+vzd5qOkPP5s4xlkhj+omVsY
         Fda5TdW3CDeMJ1S+ETpk01VHjri3rDZvXPmReSFUWb3CKvBXoQ7CHvP0ADadNSMQvNXq
         GHb7DJ5uGPve8Yb61BMTRIQgCsLJzAsT7XypLTm7vQOIfHTMUGXr8V4TRJHEUupLOi5z
         Sy7JgxGVPqzsucyCgYlz42JPFMkpeynHYwsNMvKT/PqSPAfou+yAxlxlLZKOFub+XpaR
         1eAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686658380; x=1689250380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CMlQba2o43/QiP5kbF00C5SMM+pc3bqKwMdZ4o71Wg=;
        b=ix0QZBc7n4xIRiahtJmL2W2t8t7yxmMyyyDQAzJ9SNM+OZTgTXva9ZiOWzGB1TsPZV
         55c0C5qyNmJk437eZ7a4CaZOACCc76Oqgk/IYgk+Dz7zZp2fBfIORIoIputF+0os9aE4
         +FOKnCOAehLZ0fpq5W8drVPXCmdsRvuxjXEugUJNUVMEYOrF9pF/TQ2ckzP3pVd9DdHw
         OSnCf0qoUx/aisIq5BdUmnJwvyDzxLc5NoQdYCF0VV6pvqNo3wjPkeeR2DDPpSkzWPFl
         X064Ak5+m1au9vXv4Vwxd8RmVEcr/hS22ryaZepACQjgLwXkcYZgXn09ftR/1qi2bxEG
         8/tA==
X-Gm-Message-State: AC+VfDxkuivFH2yqhShWAGt1IzXuUV6KkqGzw56LmB/wGhL/0RSYlKF0
        UTZi7usCJ7sAYtP9yh/9pn7xWw==
X-Google-Smtp-Source: ACHHUZ7v2g+t0UCuMLHeHfZftjO5zEOcIpmanWsJpdQFoH7LGbqE71Kf4m1iAu+cL1lUPxg/TiXWWg==
X-Received: by 2002:ac2:5b83:0:b0:4f7:5a42:6af with SMTP id o3-20020ac25b83000000b004f75a4206afmr1024268lfn.37.1686658379752;
        Tue, 13 Jun 2023 05:12:59 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004f61a57797fsm1759751lfn.60.2023.06.13.05.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 05:12:59 -0700 (PDT)
Message-ID: <a04f8089-0117-7c22-c6cc-97f5bd42a7d8@linaro.org>
Date:   Tue, 13 Jun 2023 14:12:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 07/23] interconnect: qcom: icc-rpm: Allow negative QoS
 offset
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
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
 <20230526-topic-smd_icc-v3-7-5fb7d39b874f@linaro.org>
 <ZId_qIAL8dvJOwai@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZId_qIAL8dvJOwai@gerhold.net>
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



On 12.06.2023 22:27, Stephan Gerhold wrote:
> On Mon, Jun 12, 2023 at 08:24:24PM +0200, Konrad Dybcio wrote:
>> In some very very very very unfortunate cases, the correct offset of
>> the QoS registers will be.. negative. One such case is MSM8998, where
>> The DDR BWMON occupies what-would-be-the-BIMC-base which we usually
>> take into account with the register calculation, making the actual
>> BIMC node start at what-would-be-the-BIMC-base+0x300.
>>
>> In order to keep the calculation code sane, the simplest - however
>> ugly it may be - solution is to allow the offset to be negative.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> I'm a bit confused why this patch is part of this series. It doesn't
> seem to be directly related.
> 
> Can you send it as part of the series that adds the MSM8998 interconnect
> driver?
Ack

Konrad
> 
> Thanks,
> Stephan
> 
>> ---
>>  drivers/interconnect/qcom/icc-rpm.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>> index d2c04c400cad..ba840a436cc0 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.h
>> +++ b/drivers/interconnect/qcom/icc-rpm.h
>> @@ -29,10 +29,10 @@ enum qcom_icc_type {
>>   * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
>>   * @type: the ICC provider type
>>   * @regmap: regmap for QoS registers read/write access
>> - * @qos_offset: offset to QoS registers
>>   * @bus_clk_rate: bus clock rate in Hz
>>   * @bus_clks: the clk_bulk_data table of bus clocks
>>   * @intf_clks: a clk_bulk_data array of interface clocks
>> + * @qos_offset: offset to QoS registers
>>   * @keep_alive: whether to always keep a minimum vote on the bus clocks
>>   * @is_on: whether the bus is powered on
>>   */
>> @@ -42,7 +42,7 @@ struct qcom_icc_provider {
>>  	int num_intf_clks;
>>  	enum qcom_icc_type type;
>>  	struct regmap *regmap;
>> -	unsigned int qos_offset;
>> +	int qos_offset;
>>  	u64 bus_clk_rate[NUM_BUS_CLKS];
>>  	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
>>  	struct clk_bulk_data *intf_clks;
>> @@ -108,7 +108,7 @@ struct qcom_icc_desc {
>>  	bool no_clk_scaling;
>>  	enum qcom_icc_type type;
>>  	const struct regmap_config *regmap_cfg;
>> -	unsigned int qos_offset;
>> +	int qos_offset;
>>  };
>>  
>>  /* Valid for all bus types */
>>
>> -- 
>> 2.41.0
>>
