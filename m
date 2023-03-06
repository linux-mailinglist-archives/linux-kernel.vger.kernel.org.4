Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0700F6ABE22
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCFL2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFL2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:28:07 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA8720559
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:28:04 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id t14so9241116ljd.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678102083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=205oYFe4/B3UC/X3qLrV4lWCFSwtZFx9u6zXNGXzdZg=;
        b=tYxvsHkYitctMbDyn+0brKMs7h03vuc34++qTOgQCEXY0QOltjVFzavue7XOjwIBXz
         LMKRO0A1xwNSzXZFnd0JnvqMD9VThgr+5mGucoUg14TXX2erPQBCSmP5U3Zv5gOQ65YF
         aJr59vehRqEcPD2OJICJnlRAOPRS0o8Th0I/W50leAD4actrR0r66yCMpHZfK2W4QnVb
         y2JpLiJKGSxhNvSnCXnVuO2CI3HaHH25c1zAjGpMDB/IfbeJY8iHeylBZssZHVRrvh0U
         ZoIK374BF80gQZHCo+SjoxWz2s+K8KggfaBJCFuzAeZ4KmG3/3vlBTh6k7gY99yBx6HI
         HjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678102083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=205oYFe4/B3UC/X3qLrV4lWCFSwtZFx9u6zXNGXzdZg=;
        b=7T34aTUCal5LcZ6+jtaFX6IpNqc8clWeaTKipj6BbhTiJ6WyMpJegGxLTofpyNNmHH
         BIxWc93RT1BrJPFqAe1ZQ7YQMG7W7UwXYhEuH7G1+45hQSyPXo2rGs26aYK6zmmNJ1Fs
         j9lZk5zOFpeQUwSXkfzvO6LDt9wvtYmjIk2kwdLi6ZwrPMbZ99fQJ0Rx7DU5xltI6t26
         G/GbLBDcFXEF4YFeXqisaFEv9/zw/roZ+ZpE4eRLZh3vWZ0hFr7mkyB2LZzRTSw5O6X3
         +X+NoDlobJ6/UEFSnEmUVHYClhNtsM6HxaTkKGHZwJbyXOjXmELkA4/atd1zpa/cOAId
         2OJQ==
X-Gm-Message-State: AO0yUKUA7dK9NChh7meRFQf04UfiD5W7REHp7kYC9G4NzhaCltyT2KNa
        Gvunki/5dUghrro3MfcKQT7tFQ==
X-Google-Smtp-Source: AK7set8aBql9IKQglXdI+C9VtpQK0WdlDEU+pVafNQuJJSo71a5RDLIA3RP28ZVtY1ImqHSRtfjaDw==
X-Received: by 2002:a2e:86d5:0:b0:295:a932:8e40 with SMTP id n21-20020a2e86d5000000b00295a9328e40mr2943634ljj.17.1678102082812;
        Mon, 06 Mar 2023 03:28:02 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id c14-20020ac2530e000000b004db51387ad6sm1588681lfh.129.2023.03.06.03.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 03:28:02 -0800 (PST)
Message-ID: <afa95a2d-dbf3-621e-a1ed-fa484d288432@linaro.org>
Date:   Mon, 6 Mar 2023 12:28:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFT 03/20] clk: qcom: smd-rpm: Add support for keepalive
 votes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
References: <20230303-topic-rpmcc_sleep-v1-0-d9cfaf9b27a7@linaro.org>
 <20230303-topic-rpmcc_sleep-v1-3-d9cfaf9b27a7@linaro.org>
 <CAA8EJpp6cxY5+L28qsTeXCmA31e4dv21u1Tz9SquAugaV+EqfQ@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpp6cxY5+L28qsTeXCmA31e4dv21u1Tz9SquAugaV+EqfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.03.2023 02:21, Dmitry Baryshkov wrote:
> On Sat, 4 Mar 2023 at 15:27, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
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
>>  drivers/clk/qcom/clk-smd-rpm.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
>> index cce7daa97c1e..8e017c575361 100644
>> --- a/drivers/clk/qcom/clk-smd-rpm.c
>> +++ b/drivers/clk/qcom/clk-smd-rpm.c
>> @@ -4,6 +4,7 @@
>>   * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>>   */
>>
>> +#include <linux/clk.h>
>>  #include <linux/clk-provider.h>
>>  #include <linux/err.h>
>>  #include <linux/export.h>
>> @@ -178,6 +179,8 @@ struct clk_smd_rpm_req {
>>  struct rpm_smd_clk_desc {
>>         struct clk_smd_rpm **clks;
>>         size_t num_clks;
>> +       struct clk_hw **keepalive_clks;
>> +       size_t num_keepalive_clks;
>>  };
>>
>>  static DEFINE_MUTEX(rpm_smd_clk_lock);
>> @@ -1278,6 +1281,7 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
>>         struct qcom_smd_rpm *rpm;
>>         struct clk_smd_rpm **rpm_smd_clks;
>>         const struct rpm_smd_clk_desc *desc;
>> +       struct clk_hw **keepalive_clks;
>>
>>         rpm = dev_get_drvdata(pdev->dev.parent);
>>         if (!rpm) {
>> @@ -1291,6 +1295,7 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
>>
>>         rpm_smd_clks = desc->clks;
>>         num_clks = desc->num_clks;
>> +       keepalive_clks = desc->keepalive_clks;
>>
>>         for (i = 0; i < num_clks; i++) {
>>                 if (!rpm_smd_clks[i])
>> @@ -1321,6 +1326,24 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
>>         if (ret)
>>                 goto err;
>>
>> +       /* Leave a permanent active vote on clocks that require it. */
>> +       for (i = 0; i < desc->num_keepalive_clks; i++) {
>> +               if (WARN_ON(!keepalive_clks[i]))
>> +                       continue;
>> +
>> +               ret = clk_prepare_enable(keepalive_clks[i]->clk);
>> +               if (ret)
>> +                       return ret;
> 
> Would it be better to use CLK_IS_CRITICAL instead? Using the existing
> API has a bonus that it is more visible compared to the ad-hoc
> solutions.
Yeah, I think that makes sense.

> 
>> +
>> +               ret = clk_set_rate(keepalive_clks[i]->clk, 19200000);
> 
> Don't we also need to provide a determine_rate() that will not allow
> one to set clock frequency below 19.2 MHz?
Hm, sounds like a good idea..

> 
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       /* Keep an active vote on CXO in case no other driver votes for it. */
>> +       if (rpm_smd_clks[RPM_SMD_XO_A_CLK_SRC])
>> +               return clk_prepare_enable(rpm_smd_clks[RPM_SMD_XO_A_CLK_SRC]->hw.clk);
>> +
>>         return 0;
>>  err:
>>         dev_err(&pdev->dev, "Error registering SMD clock driver (%d)\n", ret);
> 
> 
> I have mixed feelings towards this patch (and the rest of the
> patchset). It looks to me like we are trying to patch an issue of the
> interconnect drivers (or in kernel configuration).
Well, as you noticed, this patch tries to address a situation where a
critical clock could be disabled. The interconnect driver (as per my
other recent patchset) also has a concept of "keepalive", but:

1. not very many SoCs already have a functional icc driver
2. devices with an existing interconnect driver should also be
   testable without one (through painful ripping out everything-icc
   from the dts) for regression tracking

Konrad

> 
> 
> --
> With best wishes
> Dmitry
