Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE77A5B345C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiIIJqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiIIJq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:46:27 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4DCC0BC4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:46:25 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id p5so1140268ljc.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UpwM45QweeVpg1vOTa/xFjHfKv4CPOt5gbzLBrB0rlo=;
        b=tyaDPn47LAyLt173aiZUvC5l7ujviCOgGtucIlFnfMUNp8h/OcH804wyr++79j4me2
         +NvZ/U5bbPOPU+cTE3y6JJYJ3TXaZ1HoLpebSa271p4XLdOwuR5hRHU9mjoX3lbtxSCv
         DMVacV03hCtKEjdpvTs7tE0LTsJWqKzVz8v5SaWM/zEhoE53rR3mfqvdCFoE3exqdHW6
         oKBY1caQOTaCpuB1zXpxtN53nBSI5M1f92Y3PIKcZqIhWOnAbJQLFLf/+jOC5I64NxNK
         ViwV/C7k1YBFJJ5naPibM+IsF1xAUAoVsNP/FcloN8QBQmrX0QfoY2epPAXLcxhVQUMg
         tDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UpwM45QweeVpg1vOTa/xFjHfKv4CPOt5gbzLBrB0rlo=;
        b=DYDOM3FDbxPs+WHnmEypz1riKEVbkMIfPqS2mZxfGtrxIHF6y1pR4t94GYtbZF9k4v
         dbjyTF+btbZRYnmTFtvgRdQIuOOYzS/LnrZWlbNKymCjG8azAWJPcZRwCOvN0z3S2+d3
         nD4rNi+/1ckzcwHyhf8vzsxVMkf49S8tA2J6CuOUk5pL2LdvMSLXsYxAEhrsiEKbLZ9l
         xTj5s45IGUGJ2htxltoxxP+VOM248fnvNEaS2BMjwkFzYbHW7iq6djaXpwUUbP+6BYEe
         xyD2+4N3KRkSzBDKT45/5I/oWVxxVMmGedIaYcZzsBIXam+2/kT3jALqPIDN2SCQ3S0f
         XClw==
X-Gm-Message-State: ACgBeo3JH6tU6VLEhW84pA1QcbKcl4MMoRbp+vAzQygsgtc4Th1y98TE
        Sh2fLbhHcrWNqYrIEuZJqy/JiQ==
X-Google-Smtp-Source: AA6agR6VEZRDyqpyaWDaEDb+EKKg1XiXDBOBCCOhO5iuDsNEut96Cz1/1uR25KQhETBbxAdSronBLw==
X-Received: by 2002:a05:651c:511:b0:266:c941:67ca with SMTP id o17-20020a05651c051100b00266c94167camr3520066ljp.28.1662716784282;
        Fri, 09 Sep 2022 02:46:24 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g29-20020a19e05d000000b00492eb7205b0sm8436lfj.210.2022.09.09.02.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 02:46:23 -0700 (PDT)
Message-ID: <e886f62d-51eb-545d-7ade-1c72509b4204@linaro.org>
Date:   Fri, 9 Sep 2022 12:46:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 11/16] phy: qcom-qmp: silence noisy probe
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220907110728.19092-1-johan+linaro@kernel.org>
 <20220907110728.19092-12-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220907110728.19092-12-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 14:07, Johan Hovold wrote:
> Drivers should in general not log anything during unless there are
> errors.
> 
> Drop the pointless registration info message from the QMP drivers.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c        | 2 --
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 2 --
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c         | 2 --
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c          | 2 --
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c          | 2 --
>   5 files changed, 10 deletions(-)-- 
With best wishes
Dmitry

