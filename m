Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A35671D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjARNYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjARNXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:23:43 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4554346F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:49:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 18so49457312edw.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djHqBDlScb5lRsRE74FGmmvvX5FCg2DiG/HUABofp+s=;
        b=S3jpbPgP+0E7k7Q/czAPZSiFUwGdraKA/CiRy5bKyvrnH65HGI0UdVVF0Id10XglQt
         lfqC4jpTpojl2k4PcOwJdYourHyO7k4VLjhrtizKYslUoi5DpiE3+y9wtRitKlELjybG
         8KXvMAyiWSJZB+J5lifEkDU9r5PojnhkSJ0JKsX1wMUgiUs9Z+xTWOQN2U/jljPyIe2e
         yMIunlhUW4gUk+ezilPNN8i+NhxxWrdjt06FqsMcWkmQ/WtngAk96P3nyvvwBkdLhZA1
         4JyqIJH0wTHTXhR0sSGC7Ocf3z4qyZq1VnGDRlw3mjOX6z/qd2D8e0nn+bkwRfDqzs1H
         JjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djHqBDlScb5lRsRE74FGmmvvX5FCg2DiG/HUABofp+s=;
        b=32l2UPZqWyo9iWlVPi/KR6LYPTfjpgBNlJiKKs9YmNvLqzNOe8fTeQFe+TlIqj5jMD
         gpUGNunKe4ITrixWiiSjjKWosRif/CzPINSAgX58AendnsmUHzJdLiN7E7Gakmxqykpw
         IQcCNCzuIrXkEA2YgM8Hb10krljLj0qLk2PSrBpTLf+EayTFVY/9uwEz7LIFa293Ersg
         v+DrAQ5C1o7HacaCuPrxrhCYjfU0DSyX13LmUa2zBpJ456FzrzV105TI5cv3Mdol9PDx
         Mp8hbrZF3pRfCLSW/gr9M1nn5a0S9jcC0sKFyQlJJ3cUXo9n7Udkc881DPVLYH5xNkEi
         Mgdg==
X-Gm-Message-State: AFqh2kpvX2HprGkdOggjtef5scquJy0iaij3C+g/ELUb0LXlQ0lcszCU
        YhmRGV7G7xUP0556Itd+4FD3Cw==
X-Google-Smtp-Source: AMrXdXvsUJwb/yAFbMhciMhs5y72gLy9mpb2XpfKAbJT39PGO3tb+WGBE3y6N5X1t0pHWPZdLobXuw==
X-Received: by 2002:aa7:ccd3:0:b0:49d:f44f:7ef1 with SMTP id y19-20020aa7ccd3000000b0049df44f7ef1mr7209879edt.14.1674046173533;
        Wed, 18 Jan 2023 04:49:33 -0800 (PST)
Received: from [192.168.1.101] (abxh252.neoplus.adsl.tpnet.pl. [83.9.1.252])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b00846734faa9asm14468680ejo.164.2023.01.18.04.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 04:49:33 -0800 (PST)
Message-ID: <9850c8a3-5d1e-d379-7994-14c04fc8c653@linaro.org>
Date:   Wed, 18 Jan 2023 13:49:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 8/9] interconnect: qcom: rpm: Add a way to always set
 QoS registers
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230116132152.405535-1-konrad.dybcio@linaro.org>
 <20230116132152.405535-9-konrad.dybcio@linaro.org>
 <6e35de82-e539-35c1-fcb1-10c02af9bb8c@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6e35de82-e539-35c1-fcb1-10c02af9bb8c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.01.2023 14:27, Bryan O'Donoghue wrote:
> On 16/01/2023 13:21, Konrad Dybcio wrote:
>> On newer SoCs (there's no clear boundary, but probably "new enough"
>> means every interconnect provider is either BIMC or QNoC and there
>> are no old-style NoC hosts) we're expected to set QoS registers
>> regardless of the ap_owned param. Add a bool in the qcom_icc_provider
>> and make the logic assume it's okay to set the registers when it's
>> set.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.c | 2 +-
>>   drivers/interconnect/qcom/icc-rpm.h | 2 ++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index 509cadf398e9..343e6021a93a 100644
> 
> On next-20230116,
g fetch linux-next next-20230116
gco FETCH_HEAD
b4 am 20230116132152.405535-1-konrad.dybcio@linaro.org
g am ./v3_20230116_konrad_dybcio_the_great_interconnecification_fixation.mbx

Stosowanie: interconnect: qcom: rpm: make QoS INVALID default, separate out driver data
Stosowanie: interconnect: qcom: rpm: Always set QoS params on QNoC
Stosowanie: interconnect: qcom: rpm: Add support for specifying channel num
Stosowanie: interconnect: qcom: Sort kerneldoc entries
Stosowanie: interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
Stosowanie: interconnect: qcom: rpm: Rename icc provider num_clocks to num_bus_clocks
Stosowanie: interconnect: qcom: rpm: Handle interface clocks
Stosowanie: interconnect: qcom: rpm: Add a way to always set QoS registers
Stosowanie: interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks anymore
(no errors)

Konrad
> 
> git am < ~/Downloads/v3-1-9-interconnect-qcom-rpm-make-QoS-INVALID-default-separate-out-driver-data.patch
> Applying: interconnect: qcom: rpm: make QoS INVALID default, separate out driver data
> Applying: interconnect: qcom: rpm: Add support for specifying channel num
> Applying: interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
> Applying: interconnect: qcom: rpm: Add a way to always set QoS registers
> 
> error: patch failed: drivers/interconnect/qcom/icc-rpm.c:243
> error: drivers/interconnect/qcom/icc-rpm.c: patch does not apply
> error: patch failed: drivers/interconnect/qcom/icc-rpm.h:28
> error: drivers/interconnect/qcom/icc-rpm.h: patch does not apply
> Patch failed at 0004 interconnect: qcom: rpm: Add a way to always set QoS registers
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> 
> Should I pick up another series from elsewhere to apply this ?
> 
> ---
> bod
