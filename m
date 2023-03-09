Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058DA6B18AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCIBXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCIBXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:23:02 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3DB6183
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 17:22:58 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id t11so373720lfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 17:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678324977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPRocYM1lXMgoBs+nHaf6HlBtp3KWoifJ5sUnyZ81Hw=;
        b=jogjfs43N3sZRwK7MfCLKHMYaBLHFNfoxxrhJYtLq4BKt5CvG+2mURzCcCTsvx6Um/
         KmsChOuRnUxonsTjZ8qf0COFGJkxkiDak5/MM6ce1G4OJM+1ZKFFgRV+ofJTq3n25Vdb
         0vDVGtZfrW9yUmOhQOAGFY1F3YhGCSVRBTDRXf0hUAtYkPIQrP+HR2XLoAhosv4/Q8e+
         NiEl6T4DQca/XbuaDtoVzQTQnISWRqruaRUNUs7ZIYEq6S08r6Db5TiWSaPHt5L0rUUD
         e5TBnM8Brw5zmYTN1na975j5PmSrZt/C4aDT24b5qtDUYnLnTsAVyhYmKgGLJkEZhfSJ
         1DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678324977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPRocYM1lXMgoBs+nHaf6HlBtp3KWoifJ5sUnyZ81Hw=;
        b=ii+6RXTwEHUgC0wKQbZgdSauoHgVAxQlwUkdjSObIgCPWsngkbaDxG9CQwpW+JHb1p
         eVe6o9m1y5+IjwjQvK7QCVpXRDO9cSgnJWJ8f4htp/hfamW+BxEg0REO3UZFHAE7CzLr
         tNcD/yzTPlw9eM2Aa+KgpYJpQSFfxOYiC951b4Hm/R8MqbU7V5YOyRsnUu8M49HbNzBg
         F7jg1xg42RMZNp/UJ9WAI32RKnUgeRTvc5q4SBWrgUl759ajn+ErWZQOhYm1DHRPqBbe
         wfb66CG7IYhMm8DqfuRtZOmoj7MAiJlf6DBAj7R61vaN9AchTABljWKUAqPHkyTDcRst
         28hQ==
X-Gm-Message-State: AO0yUKWmrCZDjl0pngD7eqAY5InexMBMbeYrB8jDhDxN9TL4kVtxLFqF
        8epwM8JdaTTjA6wW7FKyoqkYqQ==
X-Google-Smtp-Source: AK7set8Yv8OxCxGQfg+QVnEMXpToxHXoUvgfz8Zyc3BBhy3EqJ5I+RQZgpMiNadTVu6FoN1x2fR7HQ==
X-Received: by 2002:a19:7002:0:b0:4b4:e4a1:2fc6 with SMTP id h2-20020a197002000000b004b4e4a12fc6mr4911001lfc.68.1678324977147;
        Wed, 08 Mar 2023 17:22:57 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e9c56000000b00295da33c42dsm2785231ljj.15.2023.03.08.17.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 17:22:56 -0800 (PST)
Message-ID: <30403337-7001-47a8-63c1-6e41d8f2738d@linaro.org>
Date:   Thu, 9 Mar 2023 02:22:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFT v2 09/14] clk: qcom: smd-rpm: Add support for
 keepalive votes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-9-ae80a325fe94@linaro.org>
 <091c0851-6f07-c7bc-0a40-b6910c33ab4f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <091c0851-6f07-c7bc-0a40-b6910c33ab4f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.03.2023 01:54, Dmitry Baryshkov wrote:
> On 08/03/2023 23:35, Konrad Dybcio wrote:
>> Some bus clock should always have a minimum (19.2 MHz) vote cast on
>> them, otherwise the platform will fall apart, hang and reboot.
>>
>> Add support for specifying which clocks should be kept alive and
>> always keep a vote on XO_A to make sure the clock tree doesn't
>> collapse. This removes the need to keep a maximum vote that was
>> previously guaranteed by clk_smd_rpm_handoff.
>>
>> This commit is a combination of existing (not-exactly-upstream) work
>> by Taniya Das, Shawn Guo and myself.
>>
>> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
>> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/clk/qcom/clk-smd-rpm.c | 29 +++++++++++++++++++++++++++--
>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
>> index eb7781e5c8c1..d89918f9ae60 100644
>> --- a/drivers/clk/qcom/clk-smd-rpm.c
>> +++ b/drivers/clk/qcom/clk-smd-rpm.c
>> @@ -45,15 +45,17 @@
>>           },                                  \
>>       };                                      \
>>       __DEFINE_CLK_SMD_RPM_AO_PREFIX(_prefix, _name, _active, type,          \
>> -                       r_id, key, ao_flags)
>> +                       r_id, key, ao_flags, false)
>>     #define __DEFINE_CLK_SMD_RPM_AO_PREFIX(_prefix, _name, _active,              \
>> -                       type, r_id, key, ao_flags)          \
>> +                       type, r_id, key, ao_flags,          \
>> +                       _keep_alive)                  \
>>       static struct clk_smd_rpm clk_smd_rpm_##_prefix##_active = {          \
>>           .rpm_res_type = (type),                          \
>>           .rpm_clk_id = (r_id),                          \
>>           .active_only = true,                          \
>>           .rpm_key = (key),                          \
>> +        .keep_alive = (_keep_alive),                      \
>>           .peer = &clk_smd_rpm_##_prefix##_name,                  \
>>           .rate = INT_MAX,                          \
>>           .hw.init = &(struct clk_init_data){                  \
>> @@ -170,6 +172,7 @@ struct clk_smd_rpm {
>>       const bool active_only;
>>       bool enabled;
>>       bool branch;
>> +    bool keep_alive;
>>       struct clk_smd_rpm *peer;
>>       struct clk_hw hw;
>>       unsigned long rate;
>> @@ -198,11 +201,16 @@ static int clk_smd_rpm_handoff(struct clk_smd_rpm *r)
>>           .value = cpu_to_le32(r->branch ? 1 : INT_MAX),
>>       };
>>   +    /* Set up keepalive clocks with a minimum bus rate */
>> +    if (r->keep_alive)
>> +        req.value = cpu_to_le32(19200); /* 19.2 MHz */
> 
> 
> Should this be set to cpu_to_le32(max(19200, ...)) ?
I was debating this. Downstream explicitly sets 19.2 Mhz here and
the only regression I can think of is that we'd throttle a bus that
was left on by the bootloader and is (ab)used by us..

But then, it's only an active vote, and we're voting INT_MAX on the
non-active-only one, so that's a non-issue.

So I think 19.2 here is okay as the bare minimum, whatever stupidity
the eventual interconnect driver may entail..

Konrad
> 
>> +
>>       ret = qcom_rpm_smd_write(r->rpm, QCOM_SMD_RPM_ACTIVE_STATE,
>>                    r->rpm_res_type, r->rpm_clk_id, &req,
>>                    sizeof(req));
>>       if (ret)
>>           return ret;
>> +
>>       ret = qcom_rpm_smd_write(r->rpm, QCOM_SMD_RPM_SLEEP_STATE,
>>                    r->rpm_res_type, r->rpm_clk_id, &req,
>>                    sizeof(req));
>> @@ -438,12 +446,29 @@ static int clk_smd_rpm_is_enabled(struct clk_hw *hw)
>>       return r->enabled;
>>   }
>>   +static int clk_smd_rpm_determine_rate(struct clk_hw *hw,
>> +                      struct clk_rate_request *req)
>> +{
>> +    struct clk_smd_rpm *r = to_clk_smd_rpm(hw);
>> +
>> +    /*
>> +     * RPM resolves the rates internally. All we have to do on the kernel
>> +     * side is ensure that we don't accidentally put down the keepalive
>> +     * clocks, which could happen if they received a vote below 19.2 MHz.
>> +     */
>> +    if (r->keep_alive)
>> +        req->rate = max(req->rate, 19200000UL);
>> +
>> +    return 0;
>> +}
>> +
>>   static const struct clk_ops clk_smd_rpm_ops = {
>>       .prepare    = clk_smd_rpm_prepare,
>>       .unprepare    = clk_smd_rpm_unprepare,
>>       .set_rate    = clk_smd_rpm_set_rate,
>>       .round_rate    = clk_smd_rpm_round_rate,
>>       .recalc_rate    = clk_smd_rpm_recalc_rate,
>> +    .determine_rate = clk_smd_rpm_determine_rate,
>>       .is_enabled    = clk_smd_rpm_is_enabled,
>>       .is_prepared    = clk_smd_rpm_is_enabled,
>>   };
>>
> 
