Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036D063B776
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiK2Bya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiK2By2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:54:28 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CE63135D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:54:27 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e189so9075817iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMM7L0hXLXFUfKlNhgYF7NOBpwKqvN6Tf5K3J+8O/Uc=;
        b=T8k72MxddQdscOHj6Io3D/OAp4GrC7Gna7f3l9dfpJ6TY7SxKZjBjnCJqc6saP9VMU
         o9fOEOkEmUtPkCzVQheZlimTTgpxuynrjQjZ/WFchxU6utIQcVcPv5EavSh8+fipxChU
         JvjBJsC2sff2IFgcv6pyDfv5+1jjnm82hTQzanFFreryRblha3TM/fuIpOoZEOjqn/51
         ppv4YxgtVMD22chsxOYlEvXrW/cJd3qaAdCidEfBTGtI58G+TpL/FAYIiMD40AgAkz7a
         jbeVLFo5yTete2IN/73QDKVOtmQjGdAWsILoddNRc9deAf5K3tYiBwYSuA/X9s0uawea
         dHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMM7L0hXLXFUfKlNhgYF7NOBpwKqvN6Tf5K3J+8O/Uc=;
        b=OFf6kcdFtM+ALGP+OzLWUTJExbFpy6XZzO7JJAHRZwLpLzmVeB0L9bI5kp+fsUUIFp
         OOC3eQj3wRNjUt6rWoCdT2rnXbTv5L0dmIVAaZB5SbQZGJMrvJzysQdXH4J/C4V/e/HK
         Ry0QXPjsQT2r/vkWj5R0w/uUD3wNipEkNbdVqwypjg7hHmJuVqzkLhIcpU0fYbhqRpjI
         ynqg8p7Gc05yFzcoK2JtIeH7t6zfU8+NgSSVzyCcL5tv+TubI6RDGsHfULvq6YMy978A
         9BuqBDgIGkCILkMmmosol1+zKRBF67hmKTH3gpHaZ+XafmtXowjWkYJjjmLuTc425LT2
         iXDg==
X-Gm-Message-State: ANoB5pmIeOdFOuZyQIUkeVyZjj87wmvenTg8cz6zF4zrWJ4/77TZqzgs
        VGim+MWrwgoJ4Y3KYuZMkwFlrA==
X-Google-Smtp-Source: AA0mqf7VzALgwv8RJk4O1iZ4K4Lr22DE+J44rlb52zwohsPukVXTnLtXFcO23Yr0xME2jVNFlMMXtA==
X-Received: by 2002:a05:6638:603:b0:389:ef1f:2ee6 with SMTP id g3-20020a056638060300b00389ef1f2ee6mr323971jar.267.1669686866493;
        Mon, 28 Nov 2022 17:54:26 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id o17-20020a92a811000000b003030d8b3cb7sm1662850ilh.42.2022.11.28.17.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 17:54:25 -0800 (PST)
Message-ID: <35be9c2d-63d4-01cf-b8d7-de3306d50e64@linaro.org>
Date:   Mon, 28 Nov 2022 19:54:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] clk: qcom: rpmh: add support for SM6350 rpmh IPA clock
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, agross@kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221129000047.697089-1-elder@linaro.org>
 <CAA8EJpqcQaamPn=6Z0GRKVDvFu8BGQ190EYJH34dApBcC3nzdA@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <CAA8EJpqcQaamPn=6Z0GRKVDvFu8BGQ190EYJH34dApBcC3nzdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 7:35 PM, Dmitry Baryshkov wrote:
> On Tue, 29 Nov 2022 at 02:00, Alex Elder <elder@linaro.org> wrote:
>>
>> From: Luca Weiss <luca.weiss@fairphone.com>
>>
>> The IPA core clock is required for SM6350.  Define it.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>   drivers/clk/qcom/clk-rpmh.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> index 0471bab824642..6a5887aae21a4 100644
>> --- a/drivers/clk/qcom/clk-rpmh.c
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -603,6 +603,7 @@ static const struct clk_rpmh_desc clk_rpmh_sc7280 = {
>>   DEFINE_CLK_RPMH_VRM(sm6350, ln_bb_clk2, ln_bb_clk2_ao, "lnbclkg2", 4);
>>   DEFINE_CLK_RPMH_VRM(sm6350, ln_bb_clk3, ln_bb_clk3_ao, "lnbclkg3", 4);
>>   DEFINE_CLK_RPMH_ARC(sm6350, qlink, qlink_ao, "qphy.lvl", 0x1, 4);
>> +DEFINE_CLK_RPMH_BCM(sm6350, ipa, "IP0");

So you're saying that the above line is unnecessary...

>>   static struct clk_hw *sm6350_rpmh_clocks[] = {
>>          [RPMH_CXO_CLK]          = &sc7280_bi_tcxo.hw,
>> @@ -613,6 +614,7 @@ static struct clk_hw *sm6350_rpmh_clocks[] = {
>>          [RPMH_LN_BB_CLK3_A]     = &sm6350_ln_bb_clk3_ao.hw,
>>          [RPMH_QLINK_CLK]        = &sm6350_qlink.hw,
>>          [RPMH_QLINK_CLK_A]      = &sm6350_qlink_ao.hw,
>> +       [RPMH_IPA_CLK]          = &sm6350_ipa.hw,

...and that this line (above) can instead look like this:

	[RPMH_IPA_CLK]		= &sdm845_ipa.hw,

Correct?

> This can use sdm845_ipa.hw instead of defining new clocks.

Your statement seems to also be true for the [RPMH_IPA_CLK]
entry in sdx55_rpmh_clocks[].  (For the record, the commit
that added that one was authored by me, and I didn't realize
what you have stated here.)

Please confirm, and I'll update.

I'll also send another patch to remove the definition of
sdx55_ipa if Mani is willing to test it for me...

Thank you Dmitry.

					-Alex

>>   };
>>
>>   static const struct clk_rpmh_desc clk_rpmh_sm6350 = {
>> --
>> 2.34.1
>>
> 
> 

