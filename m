Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0AA5B3364
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiIIJTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiIIJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:18:54 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1EF12E18A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:18:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v6so1139994ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kuIhzSkq3fDg9/NxRNM5sLOQILPo0CbgosVBQmELZ3s=;
        b=Q5xo/72AqUs037hXFiKMXBWP9qQ0QCQQ5+liSy7CDb+vWuxmBFg9ZenRUPHYDJ+3LS
         jZpyw2Fta5BxclW0Wr0sNrNL7aBK4EPIICj1rbzZ22Akx+mgm+/mPR31xaIzWWvSuf3y
         gDfn1rzYrs+7VJeFQjypK4x+vyzr8nhRtQrxMZQeu2Ng8GjE3uBZgWOFxRUruFl7kuPc
         Sr15nYY4iSg64vSH6bSSLtMdCU8zDYONnPixDlkpaSPJXabM+vWDe8y83SQaFavRO823
         bHshACNkpvcKdHJ42YyFwZnX/UZQj04vtCy8/cGvMyEuwCOv8l/rR87/x5jwUQ+G6+RX
         8mCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kuIhzSkq3fDg9/NxRNM5sLOQILPo0CbgosVBQmELZ3s=;
        b=X7pPiRDu+5mkaWL+Yk4EY2tIdSuqUEDEA7W3OJd3aNmCiKHGxxkBFG8cNTiPqjiprJ
         A9Hqs/Pk5s+3z5Q9R3Fpy4DaIpszHVouZ7ZGeisax8bnZx1zV0kZD9NrTdfQGcSId4kM
         7D9i4t5KZDiUegx3yOMq5sZFlgSV1pp6hIfUoz06iuWRa26r21yo6RpkSnqONJUDvRi/
         zEH8K5bMy2CWmpNKKzx4Nzxrqf7ZDsjquk7aPWny5RCfiOci7rbcH3ZCK+khGjWonYEc
         drMgi7i9/I+gGIO6UhqI2AumKFy7bijGiqI29uddl/KpmXb4cX0Uqzv1GdZ/d62Hke1J
         B1/g==
X-Gm-Message-State: ACgBeo39lvEJ4wYp5S+AhmsSsyd5K8ojLHe+eE67zyD5KKBU0L8uMAF1
        jl8RWIqSKGJ3AynKvpu1ItdZfg==
X-Google-Smtp-Source: AA6agR4dZ40n+zYZc3ZCFRVBIqM5e2s9DGInqydOWBOPLjVazMP238WR4ZOgRpQsHcPHjYnMs4DiRA==
X-Received: by 2002:a2e:50b:0:b0:26a:b7ec:59ea with SMTP id 11-20020a2e050b000000b0026ab7ec59eamr3860803ljf.312.1662715132031;
        Fri, 09 Sep 2022 02:18:52 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r24-20020ac24d18000000b004949f7cbb6esm6928lfi.79.2022.09.09.02.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 02:18:51 -0700 (PDT)
Message-ID: <9a6c7419-a636-4af3-b4fc-d33b06c89505@linaro.org>
Date:   Fri, 9 Sep 2022 12:18:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/3] phy: qcom-qmp: drop dual-lane comments
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220906074550.4383-1-johan+linaro@kernel.org>
 <20220906074550.4383-4-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220906074550.4383-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 10:45, Johan Hovold wrote:
> Drop the obsolete and misleading dual-lane comments which gave the
> impression that only combo PHYs have a second lane.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 1 -
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c  | 1 -
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c   | 1 -
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c   | 1 -
>   4 files changed, 4 deletions(-)

-- 
With best wishes
Dmitry

