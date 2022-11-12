Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5386267D6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiKLHwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiKLHwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:52:08 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15558268
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:52:08 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d6so11435654lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDQX/PjKkRG4x6Pkdzn6ObFIUuJQnbWONq3jUFUhLhE=;
        b=yCpjYZKAveVBN9///jLj1/M9776TpdzcK/O4D1N8JKjjaMFlLpHfIVKMDXukTnE9oW
         DWossp+MKzO/1db0Eq1vVvQhRXsqMjyyk5Rzf4dAwXTnG7VrhC0BRBthcuAaEpPBuDyU
         uBSlI5XtRchngQ0xBcJPzMb0Rd2gPwIkHBu7qcZLjbidPWcjMzayEBcObuTPfgE4Ipp/
         OdG9/l6ClIQqg36Gth5/50iVkDAYPZzj2awkpMN361q1DQvcYmx3wV0aNg/sJ+YnQyJE
         qZ+grcR7EsJGk6a09Vvdv7DRi5ROXo1CcEyzSeA+M2yXy2jfwqFCCsgHWYFSP4naZN6O
         B9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDQX/PjKkRG4x6Pkdzn6ObFIUuJQnbWONq3jUFUhLhE=;
        b=5q0ehmHg9oLeIX1kwRw/e3Abdk1EHK9M4C1UYRo4m5NcfvAywmbfgVrJHMngOTmc08
         pv7YJJYt43eO0OWmyrnqX9DNbsQxAYOw/XQEThX6kJlR0xKfrnj3TEcUTrUzHNEHc58E
         hb+1L09rZAa8u6HfVc6pg7i1YRYsJMGlVacW22ZOBM8HmXE9J6F9ebOiJF915o85De59
         EldyiJ6wP1OR5lWbmz1e/DwVkpGQtuugCN1LVQbQbYiyNBW5XjQ6rFFpPPezRUS3k/r6
         FcGD/u5KgbdeVlmbDwDwQ4RfH1yzQmNtge8ULdKn0jXDSEKnUtjf2bDVtRIem39xf/m1
         PvLQ==
X-Gm-Message-State: ANoB5pl0+8HzHRE6tYGjNmO27CcQR8kBhm2Y/2cLvcwe2W4sGpsqEJzR
        gmrLveqIiDTHDGvKgSPQCd42eA==
X-Google-Smtp-Source: AA0mqf5owtBxZMBfsAnkOV666BH20Pfu/hTIUNJqkmqDRrHYUbraQDsTZPJEXRGziCjIrYTXwNZaKw==
X-Received: by 2002:a05:6512:370a:b0:4ac:52cf:559b with SMTP id z10-20020a056512370a00b004ac52cf559bmr1847901lfr.476.1668239526494;
        Fri, 11 Nov 2022 23:52:06 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id du11-20020a056512298b00b0049f9c732858sm742166lfb.254.2022.11.11.23.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 23:52:06 -0800 (PST)
Message-ID: <df8f21f6-4282-993b-fb17-b8bc94db887e@linaro.org>
Date:   Sat, 12 Nov 2022 10:52:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/3] phy: qcom-qmp: drop unused type header
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111094239.11547-1-johan+linaro@kernel.org>
 <20221111094239.11547-2-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111094239.11547-2-johan+linaro@kernel.org>
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

On 11/11/2022 12:42, Johan Hovold wrote:
> The PHY type defines are no longer used in the PCIe, UFS and USB QMP
> drivers so drop the corresponding include.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 2 --
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c         | 2 --
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c          | 2 --
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c          | 2 --
>   4 files changed, 8 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

