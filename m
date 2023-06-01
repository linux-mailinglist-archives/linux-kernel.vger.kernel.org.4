Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBF87198C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjFAKOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjFAKOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:14:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644481FC3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:12:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3a9ad31dbso728073e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614318; x=1688206318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xkcs4FBY2IH4uDP0ChTAwfANhMPVoHA+mIZMX2WPYU0=;
        b=IzxMTmMNDL6QqmBHuED+qJBF1pSH7Q6PLscxabaALjBfya+Vc9NN5QeY4e8hhICVqm
         g0+XhtDk2Jm/xvZ8qSbhITYzsd6klovst3Nz2zN1rkN+PAyxWz/mJ889UMqMeX5Yb3RK
         uW7RT9actilECmUo71JKqoMV0zVYvZhAGUzs2b4q7WQzf7Zeov+lTjsewCi33cW9tHBm
         gVNRD3P0IRKWdyFm6qCTeXhluUkZ/HF16a6VNI7Fxqb+oaJoPLJj3Drg0ziJ2c5Vp3vW
         f8nSGsqLCGsHZypoDXGIcYrvfu6TzDpUzyeBMoAmsXgEPeOKIVTV3G+vV6SbH2lgyNLe
         kKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614318; x=1688206318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkcs4FBY2IH4uDP0ChTAwfANhMPVoHA+mIZMX2WPYU0=;
        b=EkgbF9hgDVjv8uxaf0U08rkDQ5jWHusV1TeuzW/sx6sCPx15GzAAF0SLD2C8ZZA3AH
         hf1vESZUqD44qqJdhJAA3GWrhJXb5NCtKSzwsGAP/wwNWfVLbx+6NdDQaHoMWOcc1ujr
         PjT1Z7LvIIyWN6BGVSSXMUYrTSH2XexsvwYw8K8Ba3taS+aQxRPzro3Y+pSpO2O5OqiO
         ZCmoor4VpmRaZSysWYFyZYHY36biTGHMg4YIAbJ6sgzuo5z3rl9VBiH4A/91h3c4GsPi
         667A4L/CXsaquiGsC+ltACnQybeSR/7E+C7ctBJgElOWweLhlqDVGnZwHgFwgRB+Apa4
         u7Yw==
X-Gm-Message-State: AC+VfDzmDfbfMfZAranGYVD5c2VwSoDYlQB+h2FxO5HGyzBpvnsIVW1X
        io2yVf9u2vFdUffFSj9tPLcMBA==
X-Google-Smtp-Source: ACHHUZ6Ic/CkeTNZPuoG7vOwnAK6JXh0WZ+dJWmz/uVZxjVVZtvkZjOnrfA9b50EB2MfZkjsIt0Vmg==
X-Received: by 2002:a19:f00e:0:b0:4eb:2d47:602 with SMTP id p14-20020a19f00e000000b004eb2d470602mr1000358lfc.59.1685614318618;
        Thu, 01 Jun 2023 03:11:58 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id 3-20020ac24843000000b004f58c69c583sm224848lfy.64.2023.06.01.03.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:11:58 -0700 (PDT)
Message-ID: <c5e63138-ed8b-ac35-c8a3-3a6649df7477@linaro.org>
Date:   Thu, 1 Jun 2023 13:11:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 16/20] interconnect: qcom: qcm2290: Hook up RPM bus clk
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
 <20230526-topic-smd_icc-v1-16-1bf8e6663c4e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-16-1bf8e6663c4e@linaro.org>
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
>   drivers/interconnect/qcom/qcm2290.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

