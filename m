Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA73668838E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjBBP6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjBBP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:57:47 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28067375A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:56:55 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so4041421wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4npoJYuDLbg/8G76jYSERaIIDgSDtlVPwyq1/jDUJeE=;
        b=aAwJTe/xnwPcc9cLsimMNF5XRP3Cc8n9AngyXxPDM4ApBV4Q+20Djh5aPxp/6GSw0X
         ik2oEUCSHc+LcBh0070TvDtI7gNTmpxFz7HpK6G86+IExRsvv7v1Z3w3PFADFYPPhKHh
         ZYfpBK4eVRcBAOox8VwBIZ4hlOwBBa49fMvvR4rW1Cx54YuWhX5KpcUIJrDFnR1Ax3fR
         w6PbtiuW/oFo2iCvy+ZKTl5i2wpAOkVuXmr6z57fLgwegMtOFvOJgE1wmxlB8Mxh/9qC
         LqEx5H52m569p6WmBbhH5/J8STfYGwSOU6x2VSeXM5vwrjETCMLmTSdMpxbR6NCeKLqc
         20VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4npoJYuDLbg/8G76jYSERaIIDgSDtlVPwyq1/jDUJeE=;
        b=VmiT8mhGC3BUgmiHKF49FTO5gkgVMeWGG9hUhpdAp5F/V1xCIA0NbSPGBNR/Ie5J14
         jxguoUfLrQ2X+AmOUw4hP2CVFrKFclDf8+An5iJI2H9PcJXrlCn3Xl0VdJclm2yIy4K+
         6r2V9THoe8nmhbqO0E/qFPQubjdLLvmodhU51ExAokDmCBeVetfugoGPA3gRU07MaW48
         mnzRzNhqaraPqLCKLp5EMD5xlf1mn2MdRXNHuigLMzdMo0Qx4651G+FPueTBXVUEpwZM
         E5jaBKbMLRz9AERTJucx4kx8IOeoRHHSlegGdTSB+PUflg616h5BLlKVL5Cg2KqWvvKm
         ATHQ==
X-Gm-Message-State: AO0yUKWl7AXoqwDRZdZyImv9Pezw6ATvfl3CoJ82QsFdCi+cb2CBDs2g
        8WZzvrdQQ5xFweweI2J5vHM/bQ==
X-Google-Smtp-Source: AK7set/iRPkgqNynaIBwPLb5dsGVPcJZitXkLFMH3/+s7hFpY0rtdaKz+1jm+FcCb1gW52MJJSNZGA==
X-Received: by 2002:a05:600c:3d8e:b0:3dc:43cf:7302 with SMTP id bi14-20020a05600c3d8e00b003dc43cf7302mr2259614wmb.3.1675353371176;
        Thu, 02 Feb 2023 07:56:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b003dee8c5d814sm5271856wmo.24.2023.02.02.07.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 07:56:10 -0800 (PST)
Message-ID: <1f5b6fa2-718e-3af4-2c79-caf906f9ba90@linaro.org>
Date:   Thu, 2 Feb 2023 16:56:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/6] mailbox: qcom-apcs-ipc: add IPQ5332 APSS clock
 support
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
 <20230202145208.2328032-6-quic_kathirav@quicinc.com>
 <2433c2c7-664d-0d1f-12ae-374cbd093dc0@linaro.org>
 <1b75ab1a-44c9-c4a8-7fa4-d601fc710d2a@linaro.org>
In-Reply-To: <1b75ab1a-44c9-c4a8-7fa4-d601fc710d2a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 16:30, Krzysztof Kozlowski wrote:
> On 02/02/2023 16:16, Konrad Dybcio wrote:
>>
>>
>> On 2.02.2023 15:52, Kathiravan T wrote:
>>> IPQ5332 has the APSS clock controller utilizing the same register space
>>> as the APCS, so provide access to the APSS utilizing a child device like
>>> other IPQ chipsets.
>>>
>>> Like IPQ6018, the same controller and driver is used, so utilize IPQ6018
>>> match data for IPQ5332.
>>>
>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>> ---
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> While this is not the fault of this patch, but we keep adding
> compatibles with same driver data. I think this should start using
> fallbacks at some point...

I'll work on this.

Best regards,
Krzysztof

