Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB436B5B32
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCKLax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCKLa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:30:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CD51F5D9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:27:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s11so30801464edy.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678534067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hY4Hys0PLC8Fp+eaQDoxQKvTBpvuzKMcoEiAcnO+9IQ=;
        b=I348AZRCBFTgkoW/CNUunkv7UCLakm2Bf1pXeEFjdvQ6h882ENx+16YGDts+6eGvM8
         vaK2oLBSiqsj4BXp4GhdLC1+YLubqK+6fPa46us2MuVojQ5xMt8ATGhhW5IIf9OobDvn
         0+ePJ1NR90iNwliuMs4aRvM/o86YztlUOoFlI28brOT69Lp4UpMIM6S5hC7odSlNwzvs
         Gu15oxUgNl/9lDfl5D1bM0Ep2M3YcAAyN3nVP00QBI+B/kpoXKN76wyIS9mGDaMm7Luo
         hqrTmCDbRWXxxE2hwzJTUtmUHRURkAFOim8qGpLaovdrAKByEHAGBD8oqTpcleln6OLf
         hCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678534067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hY4Hys0PLC8Fp+eaQDoxQKvTBpvuzKMcoEiAcnO+9IQ=;
        b=PKlHKR/Ms6fIi8WfWLajIJ8ehTztWgFzOmj9qDxvFM/Fbs4W9/uUvQgJdWRkve8Tqg
         qw+JTd3uqcH/DlerI38CsfCResgVN7tLxW7UkgC95/s6V9SZ8y3wQUXlKD03LjGkMrpm
         5IqxtdmUtCI33Z1L9CX2jEj7tw4Ty18KUmYMhUxfil++BTJPIjyqrrfNMN81O/cPpMRy
         CVXFx4PVCAWkQV215dbPJmHD5G7faZ4JJ3o5N6eQTN9exZhjlycRLzvAXbnT+ih0D7ib
         l9TdJn6TFQrgJ0G+hGD96vK9KxMGBWOdE5AqUeqhjNu9U1edj418qgHacf1dgDMbmrB1
         vJXQ==
X-Gm-Message-State: AO0yUKUKe4pP5jDXj7a54yMYCRtxTHMouFpDhK2pV+q/DEtvMmJKXa0e
        XRfR76uB/gMi5Vv0zvsdpmdZ1Q==
X-Google-Smtp-Source: AK7set/F7WYIVByuwghQfqPBvx4tXtULvRSGgJK2/C0DnWI6fyepiXqKt7MqE3bfLYO3WpN4g5BY4A==
X-Received: by 2002:a05:6402:1608:b0:4c6:9132:65 with SMTP id f8-20020a056402160800b004c691320065mr25977211edv.20.1678534066887;
        Sat, 11 Mar 2023 03:27:46 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b? ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id s7-20020a508d07000000b004af6c5f1805sm1073615eds.52.2023.03.11.03.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 03:27:46 -0800 (PST)
Message-ID: <1f88b410-e48f-969a-8bdb-9cdb304ecd6c@linaro.org>
Date:   Sat, 11 Mar 2023 12:27:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/9] ASoC: codecs: lpass-rx-macro: add support for SM8550
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230310132201.322148-1-krzysztof.kozlowski@linaro.org>
 <20230310132201.322148-4-krzysztof.kozlowski@linaro.org>
 <5b923d49-c151-0ed7-3db1-a7caf85109f3@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5b923d49-c151-0ed7-3db1-a7caf85109f3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2023 12:23, Srinivas Kandagatla wrote:
> Thanks Krzysztof for adding this support.
> Few minor nits,
> 
> On 10/03/2023 13:21, Krzysztof Kozlowski wrote:
>> Add support for the RX macro codec on Qualcomm SM8550.  SM8550 does not
>> use NPL clock, thus add flags allowing to skip it.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   sound/soc/codecs/lpass-rx-macro.c | 39 ++++++++++++++++++++++++-------
>>   1 file changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
>> index a73a7d7a1c0a..e322d918db36 100644
>> --- a/sound/soc/codecs/lpass-rx-macro.c
>> +++ b/sound/soc/codecs/lpass-rx-macro.c
>> @@ -395,6 +395,9 @@
>>   #define COMP_MAX_COEFF 25
>>   #define RX_NUM_CLKS_MAX	5
>>   
>> +/* NPL clock is expected */
>> +#define RX_MACRO_FLAG_HAS_NPL_CLOCK		BIT(0)
> 
> We could probably rename it and move it to 
> sound/soc/codecs/lpass-macro-common.h as this equally applies to all the 
> codec macros.
> 
> 
> Once done,
> 
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Sure, I'll move it there.

Best regards,
Krzysztof

