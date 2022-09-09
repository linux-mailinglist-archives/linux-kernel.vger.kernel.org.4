Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E2B5B3AAA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiIIO1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiIIO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:27:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830BCA723F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:27:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z23so2065390ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=vS8NN1SUQ8F9Jl53WhEY2WMgjKxug+uunu0jICrTAKg=;
        b=zIjjPPvlnmTPc5FDPSTG76Jj0rMCNlhgUXnpXbjwcXqBaxSlDUyCfJScNSYw1ZD3V7
         woXRSwbu0kkmv3Skst2LiD8JVV062pJcqxDBj0Y+3x2EswdW4oBXIkM7oxV9NLpog0Mt
         zecjn/zT53zPFk6WY/PZp9IlOUKULakNRWOPN8X7uABLIwWIQJJTx9S9eruSkT9iIJi+
         ZOa2jG3Ij04wkNN7pg2x6LuaN9p/buix/KIsGDMZPS45KKkqbT8VQPjvywkIgzHmS1Ew
         TUa8TqwAqxF3vkdB6WQJd/Z38/2NVmhVJGDyZK/9X1phGhHpWH25oLuWQ/rELwxeP4/F
         xCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vS8NN1SUQ8F9Jl53WhEY2WMgjKxug+uunu0jICrTAKg=;
        b=iZBRLVsyOrhCIzg6Nvl/adVzC8w11VqsvH1CPhmFJf8RO23QATZhijj3pczZkpshSV
         Tdf9j56LAHAwybYc3c/t6S0sPg4kp0z+ewo0TLBmwCLX380BF/Qn0xQEi60p04wrratd
         4PrbR/M/uM24+QjvgTtnBRWydCowNU18XNKV29in0yvqMP9tqlOqVKROpTNdtgixU9Ww
         xJtIyMDIN5F3FZIgvAxDl5LKruU6kZPSNc+KwphQS0RHbwRfBQ17UF5NQho91fi1BfDX
         Z7AdMDiVXzjK2DkwH6hk9+QQJa1nsPUm4U17LmHE6BtNKAgcpYyyG37FQ3oLkCS5wgYR
         O9SA==
X-Gm-Message-State: ACgBeo3KTpWVhc9iKlpm1bXLJEeyfUQ3ux0sI03cKsCqgisPeJpS+8bP
        C+6a1zzRhgSmf+6Y3sxoANE5BA==
X-Google-Smtp-Source: AA6agR5SrbyuPO9DPBYrEoAYClWpli+q1NtHHUxrB83JUOSWw2oldd5yNGgndvxVOleE6MiDCp1K8A==
X-Received: by 2002:a2e:1f01:0:b0:25f:ea3a:4ef0 with SMTP id f1-20020a2e1f01000000b0025fea3a4ef0mr3888377ljf.330.1662733628873;
        Fri, 09 Sep 2022 07:27:08 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t2-20020a2e9c42000000b0025e4ab170e0sm108849ljj.3.2022.09.09.07.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 07:27:08 -0700 (PDT)
Message-ID: <d2fcb546-16b6-6a7a-9a42-e602421baa1e@linaro.org>
Date:   Fri, 9 Sep 2022 17:27:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 02/16] phy: qcom-qmp-combo: drop unused defines
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220907110728.19092-1-johan+linaro@kernel.org>
 <20220907110728.19092-3-johan+linaro@kernel.org>
 <7370ba1d-472c-b036-4155-f86ca13f9824@linaro.org>
 <Yxs9rCf/JTL5BA1S@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Yxs9rCf/JTL5BA1S@hovoldconsulting.com>
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

On 09/09/2022 16:20, Johan Hovold wrote:
> On Fri, Sep 09, 2022 at 12:21:12PM +0300, Dmitry Baryshkov wrote:
>> On 07/09/2022 14:07, Johan Hovold wrote:
>>> Drop defines and enums that are unused since the QMP driver split.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>    drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 15 ---------------
>>>    1 file changed, 15 deletions(-)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> index 9ce2ab56be4c..838f7e328b55 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> @@ -28,16 +28,11 @@
>>>    #define SW_RESET				BIT(0)
>>>    /* QPHY_POWER_DOWN_CONTROL */
>>>    #define SW_PWRDN				BIT(0)
>>> -#define REFCLK_DRV_DSBL				BIT(1)
>>>    /* QPHY_START_CONTROL bits */
>>>    #define SERDES_START				BIT(0)
>>>    #define PCS_START				BIT(1)
>>> -#define PLL_READY_GATE_EN			BIT(3)
>>>    /* QPHY_PCS_STATUS bit */
>>>    #define PHYSTATUS				BIT(6)
>>> -#define PHYSTATUS_4_20				BIT(7)
>>> -/* QPHY_PCS_READY_STATUS & QPHY_COM_PCS_READY_STATUS bit */
>>> -#define PCS_READY				BIT(0)
>>
>> I think these defines, describing registers and bits, can go to the
>> common header instead.
> 
> Adding those to a common header can be done later if needed at all (and
> would include adding a proper prefix etc).

Ack, let's sort them out later, if Vinod agrees with this.

> 
>> For the rest of the patch:
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Johan

-- 
With best wishes
Dmitry

