Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A7771986D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjFAKJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjFAKJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:09:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316D9E78
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:07:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so273102e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614037; x=1688206037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlJOSvTxFqzu1vsBnWmNhHSpMwuNc6ynDx6kXiqQq/s=;
        b=nbT1m2mtrTLzOU9m6eAg8yofW8n66e5RRkLFWVa0QPNp3fwVSxjFrNVQzaD0NOJ1LZ
         vyVuUF3mUyvKVJFVRWGCeCLhEsj9ocIHGD1o7VXLLsU7cQPqERVbI8V/705Xuc1BETxt
         UNIqAWPVFcOx/EwiiGWM9bokeAcPsLKw4pBVbuzwrFJsAkRIRDYtvSIUryT2sUbb2922
         VZLhshEme/tUlCyCzNELf6Pp+EupBwxGNI/T37SZX7PuRbNVj654fNE6p4Gl/L737wlP
         9Fwg7wv5xqKYCu+6vkpE+TdLyPXntqFrhHs67z8I8zhGGhFEz2/EyCug7fS4IghA0AvQ
         Nf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614037; x=1688206037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlJOSvTxFqzu1vsBnWmNhHSpMwuNc6ynDx6kXiqQq/s=;
        b=VK08enSDLDFP3ZWP+MAhmg2ov27ep3kw3hCp5O1wCvtZ64EMvQ3sBuyH3UVAqlzGQ3
         X782eoRqPlIaRI5or+X7TomOVqcrxc7lwmEuIkqjkbUWnH1a/FSNn8Fp1DpDd4+VT9oE
         +Vgn3/lO8VC/at/JozfTbx/T3IMofaf19V0x71atK/EVDEPIy8ioWU/aSZ3LQ2eo8lQw
         9oUC0StkvvC1ldTMYm9/yXuYRsXbSOE2vGnvJaApI9DDnyCmxruMCdj1cBk20Ix7LabR
         j9y6ANv166JlUc84vPz+WQt+es1zmDurB6HKc3I+j/+UO0JAq/IzK7GUOljXTYhrR7bI
         BAXg==
X-Gm-Message-State: AC+VfDxTDbraCOigaQkApAdWRmGNOGbvBfBBc0xCbh1OOSCqwxCdTPu0
        9ZppzIpPrEsTPpHtT+doqwGBYA==
X-Google-Smtp-Source: ACHHUZ6vrphQJG8VEMbFrXbIFxbypPJ2w6EZDqBQ8tTjg3Dbl3MS3eNa0c3nwi3DZ6i270/KWqfKGQ==
X-Received: by 2002:ac2:548c:0:b0:4f4:ca61:82ba with SMTP id t12-20020ac2548c000000b004f4ca6182bamr914748lfk.67.1685614037444;
        Thu, 01 Jun 2023 03:07:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id t20-20020ac243b4000000b004eb0c18efc2sm1030578lfl.221.2023.06.01.03.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:07:17 -0700 (PDT)
Message-ID: <a361aa49-49a7-d26b-d417-e7ebcf2eae37@linaro.org>
Date:   Thu, 1 Jun 2023 12:07:15 +0200
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
 <4de7d05a-91da-501c-2889-4eee8e3bd34f@linaro.org>
 <21f6b17b-366b-1233-e8f8-c9ac8503eeab@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <21f6b17b-366b-1233-e8f8-c9ac8503eeab@linaro.org>
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



On 1.06.2023 12:04, Dmitry Baryshkov wrote:
> On 01/06/2023 13:00, Konrad Dybcio wrote:
>>
>>
>> On 1.06.2023 11:57, Dmitry Baryshkov wrote:
>>> On 30/05/2023 13:20, Konrad Dybcio wrote:
>>>> smd-rpm.h is not very useful as-is and both files are always included
>>>> anyway.. Combine them.
>>>
>>> If we ever add interconnect driver for non-SMD RPM platforms (like MSM8960/APQ8064), we can just ignore the smd part.
>> icc-rpm sends requests via smd so that doesn't sound unifiable
> 
> Ack. Should we rename it to icc-smd-rpm.c while doing the merge?
I'd stay it's fine if it stays as-is for now, until (if) somebody
tackles "old" RPM.

Konrad
> 
>>
>> Konrad
>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>    drivers/interconnect/qcom/icc-rpm.c |  1 -
>>>>    drivers/interconnect/qcom/icc-rpm.h |  5 +++++
>>>>    drivers/interconnect/qcom/msm8916.c |  1 -
>>>>    drivers/interconnect/qcom/msm8939.c |  1 -
>>>>    drivers/interconnect/qcom/msm8974.c |  2 +-
>>>>    drivers/interconnect/qcom/msm8996.c |  1 -
>>>>    drivers/interconnect/qcom/qcm2290.c |  1 -
>>>>    drivers/interconnect/qcom/qcs404.c  |  1 -
>>>>    drivers/interconnect/qcom/sdm660.c  |  1 -
>>>>    drivers/interconnect/qcom/smd-rpm.c |  2 +-
>>>>    drivers/interconnect/qcom/smd-rpm.h | 15 ---------------
>>>>    11 files changed, 7 insertions(+), 24 deletions(-)
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>
> 
