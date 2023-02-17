Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E164069B367
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBQTxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBQTxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:53:22 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311925CF38
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:53:21 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p19so2876708lfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7sIAulZhUgPygW6MnTOAgMlvOTOg8Ujr1oDEU2lJx8=;
        b=Wi6Cu7J4a//BgKEfeIJE17gxmy2M2bGyUHp7ZrhXTxzFYPfrDqrK8esYknWbKRXXPH
         yB5Vz7KB74iwov1/YLACMIMNPa7zbUrVIFjNnUicSaD0t7lQx3uHIzo8PeMbDXQsPUQ5
         4PCttj1LHQ3WUWY3SbFoupxTmyyLiu24rneOrIGg9s8wD8/ERmPF4AFg4t/1MQ6up5tP
         kCoOJBQBZc8uwqA9DjnC+lPJ8rLCuaULG9tcHw1FDpXNjRmLzd7CVcqgV8OrsEmu9iPu
         x6JFXDLDVhsLISPJ4hHJQD4o7A6pEWQTH68EeF02tQk6BpZMcz/UYI2rc3g2AyJhYZh0
         Nefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7sIAulZhUgPygW6MnTOAgMlvOTOg8Ujr1oDEU2lJx8=;
        b=EwsrQxLFR1B/yUnCijocjsu+UfMAtN3FHl8GY7HqVIKUf0AeQ404SO/lCIjjMhdQ0j
         EJy3T0qDrppvCZIl9AampAo5ke0ToF9r9cuoOas8swckCLOtg1O4qURgMVuSZgD3mQ4J
         BigaLUl5aEHCc9MM714KHi2eEUANTogQcKZoLfgltg5lojOsAX3Q6B8N11xSiWwa1SfU
         AIpzfGvvTBGYJ62xfDy+92qLtPzTHNTcuJh90Ra02ZDIaZfhOpv4Y0E8cdNWBgvcW1RW
         rv6xfN/KMe5LnG+GnbsbDI8SqzsQu73ZxPd/bFZf3TMm6novIuEyWmLl5Ld5gyoQOZ3t
         mj1g==
X-Gm-Message-State: AO0yUKV5rsVjc5Wz7z9Th1wz+d7/PgEyqXBV9KuyXpJPeI/ZI05AQUso
        uDkPqyUxp2425rS8er14b9yMpg==
X-Google-Smtp-Source: AK7set89ZDd3alQ67YDXx9kFoGlmkpHk7qLdQ/FCvCnnXKG4zCMrjHkau5cwTHHDBPyNeDFeoKb3EA==
X-Received: by 2002:ac2:5e9d:0:b0:4b5:b06d:4300 with SMTP id b29-20020ac25e9d000000b004b5b06d4300mr33287lfq.29.1676663599425;
        Fri, 17 Feb 2023 11:53:19 -0800 (PST)
Received: from [192.168.1.101] (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id d2-20020ac24c82000000b004db44dfd888sm772137lfl.30.2023.02.17.11.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 11:53:18 -0800 (PST)
Message-ID: <3c205131-632a-6592-5dc0-82313b26e5f6@linaro.org>
Date:   Fri, 17 Feb 2023 20:53:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v5 08/10] interconnect: qcom: msm8996: Specify no bus
 clock scaling on A0NoC
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
 <20230217-topic-icc-fixes-v5-v5-8-c9a550f9fdb9@linaro.org>
 <8c4f1cc8-c1f8-06b6-53fe-7507d74ca958@linaro.org>
In-Reply-To: <8c4f1cc8-c1f8-06b6-53fe-7507d74ca958@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 17.02.2023 20:27, Konrad Dybcio wrote:
> 
> 
> On 17.02.2023 11:46, Konrad Dybcio wrote:
>> A0NoC only does bus scaling through RPM votes and does not have any
>> ICC clocks. Describe this.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
> This is bad, as devm_clk_get_bulk{"", _optional} doesn't
> check if num_clocks makes sense and passes "-1" down the
> devres alloc chain..
> 
> I'll rework this for the next revision by simply assigning
> the common "bus", "bus_a" set everywhere instead of relying
> on it being there by default..
Or maybe I shouldn't, as that will require redefining the array
over and over again.. Perhaps just passing <&xo_board>, <&xo_board>
to a0noc's "bus", "bus_a", similar to what's been done on SDM630's
GNoC would be less messy?

Konrad
> 
> Konrad
>>  drivers/interconnect/qcom/msm8996.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
>> index 1a5e0ad36cc4..45eb8675fb11 100644
>> --- a/drivers/interconnect/qcom/msm8996.c
>> +++ b/drivers/interconnect/qcom/msm8996.c
>> @@ -1817,6 +1817,7 @@ static const struct qcom_icc_desc msm8996_a0noc = {
>>  	.type = QCOM_ICC_NOC,
>>  	.nodes = a0noc_nodes,
>>  	.num_nodes = ARRAY_SIZE(a0noc_nodes),
>> +	.num_bus_clocks = -1, /* No bus clock scaling */
>>  	.intf_clocks = a0noc_intf_clocks,
>>  	.num_intf_clocks = ARRAY_SIZE(a0noc_intf_clocks),
>>  	.has_bus_pd = true,
>>
