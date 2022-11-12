Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79684626778
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 07:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiKLGVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 01:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbiKLGVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 01:21:20 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDF62BB0B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:21:19 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id k19so6738268lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFeNrqQl5J9ANlETlekblWE28Ck3TgYP7FWq4RbjmOc=;
        b=z8xbufEHC7dDTyTo7nCI0VL7+cOzUpISCkTg9g6nfclTGY/rLMlVCyUpVjNufzxA2n
         AufmxD/mli5tFB8qL10hL5Pz5NhnvlIKhY55JEeVa+3lbz2YmI1RJAC1pe5ru+XWosFF
         9myCMg1FzgLsBMJW4WA3r1RX61oDiCJaNIdqW+GB+gi8WnQWZuyOeuqRnBARykFSBmFF
         PJhcu12+pz/wIRQ8Lqgd7vPSpawX4/5VUeq+Mnc8ii7anvye3PCpJwrkryJTj3bK5cf2
         gTQqDpZL6MyiVzWOuDIfg+j52DI1aT6/nbHWkynRr0SJwzpOyNDtF00d41VW/7RoDMx3
         6ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFeNrqQl5J9ANlETlekblWE28Ck3TgYP7FWq4RbjmOc=;
        b=aZ8Sh7XYU9YoKiSJMrdq+unvS1ox+V/bXoJ+Cmd7LCGal0U5bPTEeXtur5vJ9Ph2k9
         GF+XrzlhSuRpxjUyZQHEEHYAN8B26ua6XaocAlHijVZoNa91lyICkYElEsw/wAB+FP/D
         MmVYb2CtRoPEjUXvLu56oWcrH1g06kDLWEuZHKSkSuRYjNGVb5AreQQhvzhm7Q+cOFE2
         ulWUF/1F4mnkUvsQn7DNJM/YhCJvluFGLEevDhYSG1yc8wfMi7bXtyq639nmwk2aF7Ff
         CK+mhF0w7n30E63qkTnbJflh7J6fNLhVLG/n4ksuCBTtBVfebW9+nQ424S4MV5t2iaB+
         nUzg==
X-Gm-Message-State: ANoB5pnoaQP8tCI+MStJKLFoojI3f1f+GX4Z61AS43N2Xd9IojgTAzgh
        1mECu8UjDA+P7Juw6vkBWBq7RQ==
X-Google-Smtp-Source: AA0mqf74UZa+MPXgy2g8PwliOetw0zLHzqxSEB/7IKKUAz9HX8DzXoKU97uy/uj8aISeES2W6JuU2A==
X-Received: by 2002:a2e:9dd1:0:b0:26a:c77f:57f8 with SMTP id x17-20020a2e9dd1000000b0026ac77f57f8mr1438016ljj.465.1668234077746;
        Fri, 11 Nov 2022 22:21:17 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b004acb2adfa1fsm703312lfb.307.2022.11.11.22.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 22:21:17 -0800 (PST)
Message-ID: <a980d73d-b6ce-53b4-e9aa-c9be558afb37@linaro.org>
Date:   Sat, 12 Nov 2022 09:21:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 08/22] phy: qcom-qmp-combo: separate USB and DP init ops
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-9-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-9-johan+linaro@kernel.org>
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

On 11/11/2022 11:56, Johan Hovold wrote:
> Separate the USB and DP init and exit operations by calling the common
> initialisation code directly from the USB operation and adding a "dp"
> infix to the DP callbacks.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 36 ++++++++++++-----------
>   1 file changed, 19 insertions(+), 17 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

