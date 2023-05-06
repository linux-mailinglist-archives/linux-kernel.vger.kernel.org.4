Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12456F91E1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 14:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjEFMIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 08:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjEFMIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 08:08:44 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C6212497
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 05:08:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ac8091351eso30296371fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 05:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683374909; x=1685966909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05Ojx7v+O4druBd3MJnyjAyRFktvCavw9YdDFRv+l5w=;
        b=znoBb5zh9vVJfJ5ya/yi5qdLStdhNIpGVwSrEtQ4WPAsn2uN3ORuLhm6xGCCXFda4V
         5A0kFi02AqQjYXFnPvd+QR/71pZ7lBHe23lTCV/g88yvQYtujhRb6EI5w5ivthIn4WZ3
         6jtkzWKf6X5/8Xfraqawa2o8GBw9DvwOVWsXWNjYaVCdJ4/t2KHm6Rv12M86UJkmMzw7
         bM6qWVRk3AIppNnVYFhmqh/JdNe4QEjg3v+1v8lKB+0JM9FVVxakuDLDzPGcdyJtW18p
         BGv/l6L6srGQe51HgGrPlc6N045DhSl/msTw+m9M3i7nyB+Qd4xrMjRVrA+N3iVVjx10
         z8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683374909; x=1685966909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05Ojx7v+O4druBd3MJnyjAyRFktvCavw9YdDFRv+l5w=;
        b=im3FfFKwX8KmwVfVT89xLZW/ikNpLtU/lxE9brw18N30k/6uFsvJkuBKF46rNvyuIN
         TEN5+JWOd09QOIjQgjlYri7g2hX7SSmlPfYUJbd97Rj5CXAcSREqGB6ICw2jW4Snp4bH
         qKcc8n5qiXx/21kKv5PvUJt39maRl/iEuzckSVHElbme/CV2Yp7dK66tKjT7adINI8iJ
         LxltrQzNsCCyL0ibCJKLa/MqJNVwVC5cxE6OJceN7bPFNED/lGAW4BDfCGpfypJUe9jv
         6uhpKdCLkA5DUiKBVrYEdez5kvyWMv/KPkFEyjVqlXlQ01KEm7AwxxYp0qqORxL/LJvV
         TKZw==
X-Gm-Message-State: AC+VfDywwoyNUwftOLJlAonyUWBwKvb+XRjIk5odTxpzXAvWOdN8eQPm
        Az8oOW+dG1RkaggEEAnwyQTG4g==
X-Google-Smtp-Source: ACHHUZ6+F+g0gkskEBvR04VSH6Npu7ah4E8STeqluLVSlm3hADsdjZjDv80M14CbM2wkap/qZTV2vA==
X-Received: by 2002:a2e:908c:0:b0:2ab:2184:a9cf with SMTP id l12-20020a2e908c000000b002ab2184a9cfmr1330750ljg.53.1683374909076;
        Sat, 06 May 2023 05:08:29 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l7-20020a2e8687000000b002aa42d728d9sm365709lji.36.2023.05.06.05.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 05:08:28 -0700 (PDT)
Message-ID: <2d109075-1fab-a783-364b-778ec62b8468@linaro.org>
Date:   Sat, 6 May 2023 15:08:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6/8] PCI: qcom: Use post init sequence of IP v2.3.2 for
 v2.4.0
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com
References: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
 <20230506073139.8789-7-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230506073139.8789-7-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2023 10:31, Manivannan Sadhasivam wrote:
> The post init sequence of IP v2.4.0 is same as v2.3.2. So let's reuse the
> v2.3.2 sequence which now also disables hotplug capability of the
> controller as it is not at all supported on any SoCs making use of this IP.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 30 +-------------------------
>   1 file changed, 1 insertion(+), 29 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

