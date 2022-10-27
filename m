Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5660F7B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbiJ0Mnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiJ0Mne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:43:34 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8F4855AA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:43:32 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u11so2293059ljk.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=atHpyVeDvRSxK97x6ncdrfXkT0/3Udk1X2L2iSDbRWI=;
        b=mfT4BdhP9SUoj/74Ss/1RbrT+saz3w/uYz94FzaYqv9/gI9t3NG8VIyQpLAJEy/jRw
         UzwB5xV7gaNkqmjKZvkTJcXnu4zrztTKJBvDTCJT9PzS2emX3wRl9jaNGzh1oKNe4fI5
         OPO0bCr+2kZRbuNN9K0KbpbCXnycHiXff9Wwl2spQKkUWt9//l7yzUS6aCR9vUlLRKMH
         nuf5+BmldZxhwr48LCN460/Kp4F+MFS2IXn/Bpd29IWPJmqNoW5jBsbaUkWO3XmvUZ6Y
         /C/Ew6CeotdbDC0QThlsPM6MGVeHIv0DFFymvQ3M0anjq/6LF76yxrNxh2IINMgX+JRw
         2BKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atHpyVeDvRSxK97x6ncdrfXkT0/3Udk1X2L2iSDbRWI=;
        b=WJfRUUN3XBqSS0Ez3PhqGKULXs8uTdBX+rpcFtAVwas+VTHkFyTGnwJmDkDMY3Ycuk
         Oc2wgGuglnGQRhMsdoPScQoZo9/Y0wLHc3WxKVHrh8yJDcsd62YN0JLB5ozdJjxwV04B
         xJYYiRftkJ9veQoemLzabTcYWj2fJo2G8YCu82XLPTQq2xjqmjpx7uEO2KscG2TCXvPz
         OaZE832Kz7PLr0JTeT9vAZN7NP6hR62W6AlFhmopp4+ZjbFEG2TK9Rs9eSNeDmgrvqn5
         m/AiIUjc67WGZH81jmNf03TR8pGGrPsQ2ypcOA5UekOeSIDpvT01eFN+w/xk1p1iHwHK
         WsYg==
X-Gm-Message-State: ACrzQf1KVOQDD4ZF/AMRNtDFayy3qwu2suD8tT2S8Mb347/14nto6WwF
        PYilOG/8/o0PRelycJY6+U/ecg==
X-Google-Smtp-Source: AMsMyM6zRp9lukIKib2/jvNiSe8l+sxzPJvD16MdorWgPwYLJK8JlqoB7SJqTxLRPQXghF6b12xGJA==
X-Received: by 2002:a2e:be10:0:b0:26f:b35e:c29e with SMTP id z16-20020a2ebe10000000b0026fb35ec29emr19198877ljq.488.1666874610470;
        Thu, 27 Oct 2022 05:43:30 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id p18-20020a056512313200b004979ec19387sm167821lfd.305.2022.10.27.05.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 05:43:30 -0700 (PDT)
Message-ID: <cd5a049d-0ff4-bd61-1e0e-81b9ed5911fb@linaro.org>
Date:   Thu, 27 Oct 2022 15:43:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v1 2/5] clk: qcom: dispcc-sm8250: Add RETAIN_FF_ENABLE
 flag for mdss_gdsc
Content-Language: en-GB
To:     Robert Foss <robert.foss@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>
References: <20221027123432.1818530-1-robert.foss@linaro.org>
 <20221027123432.1818530-2-robert.foss@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221027123432.1818530-2-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 15:34, Robert Foss wrote:
> All SoC supported by this driver supports the RETAIN_FF_ENABLE flag,
> so it should be enabled here.
> 
> This feature enables registers to maintain their state after
> dis/re-enabling the GDSC.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>   drivers/clk/qcom/dispcc-sm8250.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

