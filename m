Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C28725CBE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbjFGLJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbjFGLJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:09:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA7A10F9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:08:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f6148f9679so6662978e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 04:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686136131; x=1688728131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KFnEHxnHsY5ORT5+vCk7re0Z/SbzSvLlr7u70HouNM=;
        b=mYSSEIwoK0ohHCQN7sWH+G63YxZ9c6gvfwTapMO8sZ5t1PhYpZ34LUwboM+lXoTPNJ
         2HDuiMgM9IJmHaJRIOLGTWptYTCvfmdu843n9KwZBw9c+I3/VMhw4IAebsUbcWSH6fvH
         fvO/9WdCXHv1/8g5vMrtpDdATQYClGKY2aWnHF5XzH9CftipP6lHV4zhniHJ/X395IFp
         1/g3cfeJtkZb73uu/9Jr75T/UyEEgjZDdkuu2PW1egQuLDCstB7DmKqSg82EIAAK4+sq
         4EDXk6EEpVVkMKazN8ZJupHFTNCistQDm9XYXmrTW1gPcA9Z9d8WNTpC5C2VDt6CxC89
         zjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686136131; x=1688728131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KFnEHxnHsY5ORT5+vCk7re0Z/SbzSvLlr7u70HouNM=;
        b=XZZlOvMS0yI87dga+4MnV02EuFIcZVfbJ1cmIQrCVCtFnbt8xmycXdETwfm6jF0/mv
         4mQX8HbmmAEoTwPlbhg6k8kjA9AfJDlU5F9kThhk3SsoovAqEQUu6CQl5TVN4ug7XYRC
         euCsLdNf90Xq3cpjzTjhjC09OfNPuKXNbaP3O7Dj9PEuQDaHKe18q/Y+cUy6SlDnNLun
         i78kl/7JPu3Zyyp3eP+jZu23kEex/SOp80hXhEYhg/6Yhnv5oRbDhHWU4FnUWyxBdMFB
         VA1c/22dmN5GhICtHE9r8UMxDYV424zpYa564j9YKmJrdu0wwAwaBse5rklqAvVY9Xcf
         TRXw==
X-Gm-Message-State: AC+VfDzZi0jDcLcuUDG9xPV2pi/ASYVleUIv/ElUCg3jmT2tiY++tyvz
        XlLai/DAyqJiRkICcdHDeN+Low==
X-Google-Smtp-Source: ACHHUZ5FU7gfJqgR6Bbf9okouulqzQ/fg4hH+NUBnT1B9xe4An7hHPqqYOoHE38MR8eh9M7iMp8TFw==
X-Received: by 2002:ac2:52b4:0:b0:4f2:5d38:2c37 with SMTP id r20-20020ac252b4000000b004f25d382c37mr2204352lfm.15.1686136130920;
        Wed, 07 Jun 2023 04:08:50 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id b17-20020ac247f1000000b004f139712835sm1778576lfp.293.2023.06.07.04.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 04:08:50 -0700 (PDT)
Message-ID: <8e5e7bc4-1767-8179-b6ac-f09ac0b5361d@linaro.org>
Date:   Wed, 7 Jun 2023 14:08:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/6] thermal: qcom: tsens: Drop unused legacy structs
Content-Language: en-GB
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230508-msm8909-tsens-v5-0-5eb632235ba7@kernkonzept.com>
 <20230508-msm8909-tsens-v5-1-5eb632235ba7@kernkonzept.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230508-msm8909-tsens-v5-1-5eb632235ba7@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 13:47, Stephan Gerhold wrote:
> The old single-cell parsing code was removed for MSM8939, MDM9607 and
> MSM8976 but for some reason the structs defining the bit positions etc
> were kept around (unused). Drop them now.
> 
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 51d78b8b1beb ("thermal/drivers/tsens: Drop single-cell code for mdm9607")
> Fixes: dfadb4599ab0 ("thermal/drivers/tsens: Drop single-cell code for msm8939")
> Fixes: 3a908971f7cb ("thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>   drivers/thermal/qcom/tsens-v0_1.c | 36 ------------------------------------
>   drivers/thermal/qcom/tsens-v1.c   | 22 ----------------------
>   2 files changed, 58 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

