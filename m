Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465BA719819
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjFAKBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjFAKAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:00:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78E618B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:00:27 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af1ae3a21fso8504831fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613626; x=1688205626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1J6cSNjkU1PSmW5vvUQuR8bOMv9ZvpvC+yJyx0cAHY=;
        b=KcmXUuoNS63f0AdaHzH9QXTRPgBV5P7YMqNgLn6wnIVMtdqF+6lMpsJpLmYVyvJ+bQ
         xKuYYCBADICQxT11gJEFkAcDXqFkR4MT/akgfSqENZFa25C4dWaBKcvt9xeWcrEeaAa/
         Dz6qt1AyJMhKgCMBy1diAPxovV9jBppTb/cJAoXcA0uPRYolLGDFxYH6vfbLmkgur958
         eMfWrLAjw+8XW2uJXTINFSQm1nfbvKFoAEs8A2nCRy7JhwqrJGpGM5uCCB/eSVRpSM/A
         xQTHkJfI3Cwh3fDVGnIZdQp8VKXt8d2m5XOKOWlOcO7BEI2QmB6r46Ybq1Vttq3mgoEp
         NcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613626; x=1688205626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1J6cSNjkU1PSmW5vvUQuR8bOMv9ZvpvC+yJyx0cAHY=;
        b=jNxQG3x/fbOje2m3RDWfKQJ7bR5zfInpEaX2YZ0i3pmLPYuocgeMdEfdsQPs9imUpO
         XwXe0hbU2rxx14PQbhwUQ/6hl65ZPWfPvhVfnrEAy80k7QdWKEN5I/nHZEi6I3rJxn5v
         +oqOegVOkELIDNxJtOxF94bk1zkJoUCLOEmTvnGtHw7ectzwE3UzPkDUgRlcadeTrMht
         fYIJgd9VAOrs5XRE9Pa/aMfhVeIFH6cVgQf7M3WFjObBWv1ER22VhDFa7/UaAOe3BV0p
         zL9v0x9bw2VHP19Q92nCiwhrDk91ZgyI77BDg1Qnq4Ee1T2ah4aJMfm6nFxNCDnLt9ai
         CeSA==
X-Gm-Message-State: AC+VfDx17/vVpYbDoO72hIKL6NGlX8s0fWlPfbggzeasexPDU8Eo/n8f
        z/Nb9MVPIwzQOvk5EvkalMo7xQ==
X-Google-Smtp-Source: ACHHUZ5CJPaPVSQKeTr9nKO3KvVbKe+1gyc1FlbV8V0wrvCSJ7xknGpEQ3aqVlYfXK1+DlLZwmmm8Q==
X-Received: by 2002:a2e:9f02:0:b0:2a7:653d:166c with SMTP id u2-20020a2e9f02000000b002a7653d166cmr4650500ljk.3.1685613626188;
        Thu, 01 Jun 2023 03:00:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id n10-20020a2e878a000000b002afd30401b0sm3714860lji.138.2023.06.01.03.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:00:25 -0700 (PDT)
Message-ID: <4de7d05a-91da-501c-2889-4eee8e3bd34f@linaro.org>
Date:   Thu, 1 Jun 2023 12:00:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 07/20] interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-7-1bf8e6663c4e@linaro.org>
 <ea21f29f-482e-1dd3-12d7-b9f685b1d5dd@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ea21f29f-482e-1dd3-12d7-b9f685b1d5dd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 11:57, Dmitry Baryshkov wrote:
> On 30/05/2023 13:20, Konrad Dybcio wrote:
>> smd-rpm.h is not very useful as-is and both files are always included
>> anyway.. Combine them.
> 
> If we ever add interconnect driver for non-SMD RPM platforms (like MSM8960/APQ8064), we can just ignore the smd part.
icc-rpm sends requests via smd so that doesn't sound unifiable

Konrad
> 
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.c |  1 -
>>   drivers/interconnect/qcom/icc-rpm.h |  5 +++++
>>   drivers/interconnect/qcom/msm8916.c |  1 -
>>   drivers/interconnect/qcom/msm8939.c |  1 -
>>   drivers/interconnect/qcom/msm8974.c |  2 +-
>>   drivers/interconnect/qcom/msm8996.c |  1 -
>>   drivers/interconnect/qcom/qcm2290.c |  1 -
>>   drivers/interconnect/qcom/qcs404.c  |  1 -
>>   drivers/interconnect/qcom/sdm660.c  |  1 -
>>   drivers/interconnect/qcom/smd-rpm.c |  2 +-
>>   drivers/interconnect/qcom/smd-rpm.h | 15 ---------------
>>   11 files changed, 7 insertions(+), 24 deletions(-)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
