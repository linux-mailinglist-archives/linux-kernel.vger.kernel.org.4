Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2E5719884
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjFAKKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjFAKKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:10:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF1B13E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:08:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4b80bf93aso723710e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614127; x=1688206127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYo8BRl5LkkQXi3mYOgwIwVJRno87626SaL9vwHSxWM=;
        b=LYa5l9f+Co4mqxLciHYmPqSTu0vn9mtS7s3xt2p4yR/EvZmDTHHVjN9r8koGe/yfBs
         BaLczKu0EPtcUXAjTsHitxB/7fAR0Lhveg8+Cr3YdioC8SQqCpUxgX0jdKtzkHK6s9OG
         T+8qtMgIQCJjSon5oofyMR3UMs4h2SxAeVzbCp3RPCVeipl+aYJyfmO/NTxuhdtP2Fj5
         3ROO0jiH+i1mR0thj6g56VxHcA/P05/+t+AOp3NfD+UIWFHUUXRo1yB0DqgU4J7KkN97
         +L0PrClNEpqxUezuWyzgFiPcI4kv92P8DT4JKRut7s5hHb+/LR2f6PACYuhUpLzOtAcD
         fA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614127; x=1688206127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYo8BRl5LkkQXi3mYOgwIwVJRno87626SaL9vwHSxWM=;
        b=Czpxd0h/Lpf3IBuxYvLyokjt2U053NRbWNQr/3uqJqpC9RlfE5iOx+Rr0uPZP3rUKX
         09tbw9vBsIuCDgYMtadTEoMZD2T5tKMhcj6xCtn+m/DkWlyu7/NkKclOZBcZCR801v5Y
         wU2XMsMHAEQOAmaHkYmL2S4Lrg3qtXVJ7fpH3ljRhyUB4c86dDjle7pykkyDJx66oppL
         oGqgr2EerBHcPgh69Le0yuLTwKhq3hut/kN0zrqv7rzXu2AsYsYbTUCG/JSL5t5es5fC
         rQna3QGtqV2qAM79hp4Y5MWyul/j+cxmiJ7XXc3dO4JVlliHxu4Q7RyZQAn/01aZ1T1b
         KwrA==
X-Gm-Message-State: AC+VfDx6+YD723CRq9u+Zo6L2K9YhFjDvCl6ATPQGFLD0PJKx+g5mkEG
        jspW4iez2TnGZq75A7chu+L92A==
X-Google-Smtp-Source: ACHHUZ67/smOf8ihbVtI+96ZqJH8SqDguoqxhAr6nWP7ZgonkmQvW270cRUoj0abDxlenEg3q9kV2Q==
X-Received: by 2002:ac2:518f:0:b0:4f4:d45d:1616 with SMTP id u15-20020ac2518f000000b004f4d45d1616mr1015233lfi.67.1685614127627;
        Thu, 01 Jun 2023 03:08:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l3-20020ac24a83000000b004db3900da02sm1037672lfp.73.2023.06.01.03.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:08:47 -0700 (PDT)
Message-ID: <327d8f65-f6e8-fbb6-a159-2db424b29b0d@linaro.org>
Date:   Thu, 1 Jun 2023 13:08:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 11/20] interconnect: qcom: sdm660: Hook up RPM bus clk
 definitions
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
 <20230526-topic-smd_icc-v1-11-1bf8e6663c4e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-11-1bf8e6663c4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 13:20, Konrad Dybcio wrote:
> Assign the necessary definitions to migrate to the new bus clock
> handling mechanism.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/sdm660.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

