Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B34D720ECF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbjFCItc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 04:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjFCIt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 04:49:29 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C743B1B5
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 01:49:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso570875e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jun 2023 01:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685782165; x=1688374165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKrgDt9/GDQniYKD6QzC2hOE29gA71xWg9JcNbitrVs=;
        b=xspzxuweEXr360zEIkQk3pb36jOCLa4PMZsZpqsUfDT+BHERo8Gg+miaSpRZUPM89/
         avNBwxVQaR2iSZuFDmMq67veES1/U+3fjXVpcz6oPRsq24bL6zDJ68g+RVKXNoGmOp5n
         o83Eocdh7C0zru50ZfQnh0kikUb0UT4eETqn13398mJyRRyrmNRIX3n0GpshXvziDUN7
         s9bekbmYw6PTjbzsKeQfjijV2HkQeFvVpnRKeRbQZnmYuwenwI9954MGZ7M84MqwlV4c
         sWVnVtouSkH19M+0QYh00vgU+v4M4OuURvUBQ87WD2Y32fkkUm/N4av6JaNfg/QmsWKz
         2Dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685782165; x=1688374165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKrgDt9/GDQniYKD6QzC2hOE29gA71xWg9JcNbitrVs=;
        b=iEmZMihMmAZkUJHjpJqzELYgfeEeHX4VToomWymv8Po8dHV6CmBpB0wMLQGcwA+nJN
         UctWetldrL1DbqGZhnAxpntQb4KkmC2UODfpvYWcGmnIy6QxWSBxcTy1dNuocvB3KBj+
         TEpx4ntyO1bSULy1NFE3R+RNCyq67hpAPLquoF+vddEpi7zAeGbYhiSmtLZIyEyi5Yen
         V5b/K/R6Yo/ba7E9oTR243XYU/C+D8JS2T4yEitdGxzC7yqHSUgI0/yslwZ3AkUrUNmP
         sUBQi8bN6Y0cQaq2hyHvMSqNZNcBkdCkx2X7mOerFOKp81nbtDDRKt2sPZmefUhZYbvz
         SBHQ==
X-Gm-Message-State: AC+VfDz/2xCtmC9nCPUOTEpTGNaU6WPnMaePN9MpRGI/owU/7k/UpvjI
        tBh/dtgRKm1ciR6KJd9vL7WOJO0WdkP+4FNpXwc=
X-Google-Smtp-Source: ACHHUZ49DSBJnUzcyPQah/mTMDEfiKsMTCTDB9hncMEFrbjT6C1kTda30Y74YDNoLZb4NX97Jdu19Q==
X-Received: by 2002:ac2:4253:0:b0:4ed:bdac:7a49 with SMTP id m19-20020ac24253000000b004edbdac7a49mr2635062lfl.54.1685782165002;
        Sat, 03 Jun 2023 01:49:25 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c7-20020a197607000000b004f38411f148sm424698lff.84.2023.06.03.01.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jun 2023 01:49:24 -0700 (PDT)
Message-ID: <dc78e4b3-975b-6fc8-3906-8fa935bde625@linaro.org>
Date:   Sat, 3 Jun 2023 10:49:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v10 4/6] soc: qcom: cpr: Move common functions to new file
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
        Mark Brown <broonie@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
 <20230217-topic-cpr3h-v10-4-67aed8fdfa61@linaro.org>
 <94c18cc3-4b1a-440b-3bd8-3c81ddffc148@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <94c18cc3-4b1a-440b-3bd8-3c81ddffc148@linaro.org>
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



On 27.02.2023 04:09, Dmitry Baryshkov wrote:
> On 17/02/2023 13:08, Konrad Dybcio wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>
>> In preparation for implementing a new driver that will be handling
>> CPRv3, CPRv4 and CPR-Hardened, format out common functions to a new
>> file.
>>
>> Update cpr_get_fuses in preparation for CPR3 implementation, change
>> parameters where necessary to not take cpr.c private data structures.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> [Konrad: rebase, apply review comments, don't break backwards compat, improve msg]
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/soc/qcom/Makefile     |   2 +-
>>   drivers/soc/qcom/cpr-common.c | 363 +++++++++++++++++++++++++++++++++++++++
>>   drivers/soc/qcom/cpr-common.h | 108 ++++++++++++
>>   drivers/soc/qcom/cpr.c        | 386 +++---------------------------------------
>>   4 files changed, 494 insertions(+), 365 deletions(-)
>>
> 
> [skipped]
> 
>> diff --git a/drivers/soc/qcom/cpr-common.h b/drivers/soc/qcom/cpr-common.h
>> new file mode 100644
>> index 000000000000..2cd15f7eac90
>> --- /dev/null
>> +++ b/drivers/soc/qcom/cpr-common.h
>> @@ -0,0 +1,108 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_opp.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +enum voltage_change_dir {
>> +    NO_CHANGE,
>> +    DOWN,
>> +    UP,
>> +};
>> +
>> +struct fuse_corner_data {
>> +    int ref_uV;
>> +    int max_uV;
>> +    int min_uV;
>> +    int range_uV;
>> +    /* fuse volt: closed/open loop */
>> +    int volt_cloop_adjust;
>> +    int volt_oloop_adjust;
> 
> For CPR3 these values are per-fusing-rev.
> (for 8996 tables list per-fusing-rev values for min_uV, volt_cloop_adjust and volt_oloop_adjust)
Yes they are per-fuse-rev on other SoCs as well.. Angelo didn't implement
this in the original revision of the driver and I think it'd be good to
add it incrementally since we already consume the necessary fuse..
Otherwise -ETOOFAT!


> 
> Another option, of course, might be to have a per-SoC code that uses fusing_rev to update the fuse_corner_data, but it would mean making it non-const.
Hm.. a const array sounds better to me..

> 
>> +    int max_volt_scale;
>> +    int max_quot_scale;
> 
> Any reason for these limitations?
I'd assume that's a safety feature Qualcomm implemented to avoid
burning chips if cosmic rays poke at DRAM or some chips are fused
incorrectly.. Preferably, I'd keep it!

> 
>> +    /* fuse quot */
>> +    int quot_offset;
>> +    int quot_scale;
>> +    int quot_adjust;
> 
> I see that quot_offset/quot_scale/quot_adjust are set to 0/1/0 for all the platforms I can assess at this moment (8996/8998/sdm660). Can we drop them? If we need them later, we can readd them later.
I was about to do it, but noticed 8956 sets scaling to 10..
Guess we can leave it since it's already there!

Konrad
> 
>> +    /* fuse quot_offset */
>> +    int quot_offset_scale;
>> +    int quot_offset_adjust;
>> +};
>> +
>> +struct cpr_fuse {
>> +    char *ring_osc;
>> +    char *init_voltage;
>> +    char *quotient;
>> +    char *quotient_offset;
>> +};
>> +
>> +struct fuse_corner {
>> +    int min_uV;
>> +    int max_uV;
>> +    int uV;
>> +    int quot;
>> +    int step_quot;
>> +    const struct reg_sequence *accs;
>> +    int num_accs;
>> +    unsigned long max_freq;
>> +    u8 ring_osc_idx;
>> +};
>> +
>> +struct corner {
>> +    int min_uV;
>> +    int max_uV;
>> +    int uV;
>> +    int last_uV;
>> +    int quot_adjust;
>> +    u32 save_ctl;
>> +    u32 save_irq;
>> +    unsigned long freq;
>> +    bool is_open_loop;
>> +    struct fuse_corner *fuse_corner;
>> +};
>> +
>> +struct corner_data {
>> +    unsigned int fuse_corner;
>> +    unsigned long freq;
>> +};
>> +
>> +struct acc_desc {
>> +    unsigned int    enable_reg;
>> +    u32        enable_mask;
>> +
>> +    struct reg_sequence    *config;
>> +    struct reg_sequence    *settings;
>> +    int            num_regs_per_fuse;
>> +};
>> +
>> +struct cpr_acc_desc {
>> +    const struct cpr_desc *cpr_desc;
>> +    const struct acc_desc *acc_desc;
>> +};
>> +
> 
> [skipped the rest]
> 
