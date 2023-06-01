Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E895C719885
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjFAKLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjFAKKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:10:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B198E64
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:09:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f3b9c88af8so708382e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614156; x=1688206156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcROsYGCvL4cPhmPgnaUS/6tnSAuXadrUH4tf9CN9vE=;
        b=aCr0g+PADblTLNTh8WEIX0i/zUy1R/dUgo8paCQmz0LslRfDfdHMFAuDdkfWZ6FZGO
         wgyiN1N6+vXZZ0nzJm4nFqLgrBpuKol2pQJF2wbjYwaZLo6mNeda4o66LXa93drtQWNp
         2JJfpdGIsIJwMuTU62gu9gtJG+1nR0Ke9Q9kXjR6Ngb01rRiKFZEjEfBwYagpwQRzrj2
         qA343NStpshSpT0ZeTci+9zJM/onp1t6cLJg9uNZjMRxfDYCpzdXzvmz/sSkNlP+Rg6n
         Wjpn+NPAylMew5GQyCaRPcXIKpP43vMc1uM1fRY/S4J4u17XXe3Nw4kiqoMOJMrx8iot
         1VyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614156; x=1688206156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcROsYGCvL4cPhmPgnaUS/6tnSAuXadrUH4tf9CN9vE=;
        b=N/fvfTM47wBfnCW9NPH5x6Pwh9IFE/UazxX7GpkTsEq/6oDMoaOcw5JnKKeNw21rOZ
         +Imjw2QLoqnVaiRwJj4uIWdPPLlWblrQkhseHt49RIdGeRb1IMpZbo8N/jxo5jkeHibM
         3c4wVvV85sXbeyYmbz5VxWb7u270Dv1PIBV61Qvgl83eyYLWhvA8GWbt09sq8vrbEjNz
         eGFTjWxIMOFlUgoDt2dOcjA8lKb7LDoOA8RDhGwR2Q1+fwxnmceuETpJPAUJ+bFtPPSa
         yIpGuhmClzi/Eh5DNucHuxXxhgEZpXyw/x/mARcs6TCYiTNf//6Vk3pZRbcrRzj1BO4Z
         fZEA==
X-Gm-Message-State: AC+VfDw2GxEdx2irJ6rwOC6WHWvYH04YcGv2d8LGM136BvGfoA6YXCIP
        +nH7zvSDK16lS97YZ3S9l8Lfkw==
X-Google-Smtp-Source: ACHHUZ7qeTXvJrIew7wf/YFnvrJeuM7SkU+Q0fxhy4cNo6hdFp2SHjE+IE8fnxHr2TUQ9DWQdJQEmQ==
X-Received: by 2002:ac2:5d6c:0:b0:4eb:1527:e2a7 with SMTP id h12-20020ac25d6c000000b004eb1527e2a7mr875115lft.45.1685614156497;
        Thu, 01 Jun 2023 03:09:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f15-20020ac251af000000b004efd3c2b746sm1025139lfk.162.2023.06.01.03.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:09:16 -0700 (PDT)
Message-ID: <bacdac67-b08d-781b-b72b-0bc6715e7583@linaro.org>
Date:   Thu, 1 Jun 2023 13:09:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 13/20] interconnect: qcom: qcs404: Hook up RPM bus clk
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
 <20230526-topic-smd_icc-v1-13-1bf8e6663c4e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-13-1bf8e6663c4e@linaro.org>
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
>   drivers/interconnect/qcom/qcs404.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

