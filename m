Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F3C5FCD02
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJLVVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiJLVVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:21:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C7232D8A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:20:59 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a25so115118ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFaY0bTV2pNdJEMhntNT8kQbE1jsf4XB01gxcWojyUA=;
        b=BcGce7H7B5+yg7pRFZ+/9Pveo80w+oxNQJBlcOUyCegyYAq3bat37anbhDUv/sOWFb
         0m7b95xDw9b8HfqZ4RRXlqIYi8BIPgm6Lcy7X39xugVID5+J9m75uQ/o6FbJ5pyfHw4w
         1qYhbTGLCJXjHXUEBNmdcHfDKkPfVwlelLwPQJu9zkJ4d4MpKvo11dynjItyWKwfw5F8
         ClXFa4tmJ+IEKMDezHPn9aofQXh8xyAbgVBPsWUoMROCo/L4YoHsykkIDed5BDlkhEin
         /YvjyEyddvj06EMlDo1ftaDK64KV+BS2x4xxvo/84z4FlmpK6kOhBW9+XMg9e2uARrxj
         J13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFaY0bTV2pNdJEMhntNT8kQbE1jsf4XB01gxcWojyUA=;
        b=WfkbooSzfNZbOIskcQzMkEftFLNshyJEh++89gVJmkq67hZL1LgRGHNwu1xSqHnsPJ
         rZfp0w4UYhT9OXFFesokSw0IaKHl0yHgJrBJJMFUkoO0z+rJIqdW4kAn+0XsDe3tqDFa
         IV/phAMUNgAJjhmKLLI0+140p/ujYiFp+0NZe8Y7CxMMIgbA3JB/jfgHSWT5+ta8cpv4
         X7vHqjv1lfp7anTt0hryY3YM1GaZn2zEGHRXHktpNL9riN1akWE/TZw5/0Zob2COFThO
         0uI2ZRZ49wD3OksgB0q6ni+JQonLYscbgn+MYHjIoZVC9lDvokzk+bzzTi24F5FVUNGu
         a1sg==
X-Gm-Message-State: ACrzQf2BT6KlF3O4q0PvxuziWB8Ir2t/Oz6muwWHI/EcjBBoBMcicVKM
        8qxMTrWPIoB73VdALTmfGj864w==
X-Google-Smtp-Source: AMsMyM7fJ4ngcKmn2XRftNx9QXJd+rZIJi/OCB4vYqsSmgbl+5SqWAxAfQAFOWF2+FjQOc2INOrbog==
X-Received: by 2002:a2e:bd84:0:b0:261:e43c:bac3 with SMTP id o4-20020a2ebd84000000b00261e43cbac3mr11989739ljq.198.1665609657350;
        Wed, 12 Oct 2022 14:20:57 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r8-20020a2eb888000000b0026de0c8098csm126859ljp.26.2022.10.12.14.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 14:20:57 -0700 (PDT)
Message-ID: <cd6986b7-c053-7838-1120-86684d6dc2ee@linaro.org>
Date:   Thu, 13 Oct 2022 00:20:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 19/20] phy: qcom-qmp-ufs: drop start and pwrdn-ctrl
 abstraction
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221012084846.24003-1-johan+linaro@kernel.org>
 <20221012085002.24099-1-johan+linaro@kernel.org>
 <20221012085002.24099-19-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221012085002.24099-19-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 11:50, Johan Hovold wrote:
> Drop the start and pwrdn-ctrl abstractions which are no longer needed
> since the QMP driver split.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 35 +++++--------------------
>   1 file changed, 7 insertions(+), 28 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

