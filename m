Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3754A5BEAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiITQBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiITQAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:00:49 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868E640BE9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:00:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h3so3594283lja.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+ipAueGYq20ud/XafDtc9lpH1wkNgmf60dZIXYXJn7M=;
        b=zo6YEvwbQt03IwL1smspUYWhyyZznPGHE0FrtQkTg42FKGHlwf+cjm3rI5kLvms4BI
         mHFYKVOPRFfu1fSSTAnODSWJD8UCm0khtBaRtYVMbjoIdKIdi8lZ1compQ6h9doiwpmJ
         IWePJ3qc1dKkV0GFFz0gMQ7HlFh9xhY7XD1U+wx7raigu0p7clSAGHQmLADz4qO7TPu9
         Qy/TlALCNQVUjW0Pjvp7XGVrFWRjGDWO/jcFwnRvYnT1d+IJUC8OQORtjf/Ql5H0tdTZ
         lYjIhMgmI7/hUMPfGFWVahyp9Xf4SXzs0w0ciT+R83IEc3Iwk+fEHPrjXlyha9EbaV8X
         /gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+ipAueGYq20ud/XafDtc9lpH1wkNgmf60dZIXYXJn7M=;
        b=KRf4RSm2mxeIQoYSUaFTd7s+9Rv/LA4329zZXoWRkhJmOLDuEZipGjuArFtFnJrXaF
         EydceTKFflCax6/5M8wrq2BA3SPIQC+/7ORL2O7oSWLMM7kfpQlmy67AqoLuZynlp/l+
         +1gGxqSrcxAoBrRt3FmpiskVcLVxx4kmdJaS5WAkavEXgO3ElrBU5FTWrr2vAtuyb33x
         9pXadYOGzdDhCdYyzpdL3Pqt6AL4e1gjtzgrbe41Tn1yQwdN5zbXx9ULXqODGmLc22Ip
         uoWyNdSIuZufmQSiokwR3miBXnre897A8S8Rfcgedob9frOdZDehMw3rkeiwajuPvScr
         /lYA==
X-Gm-Message-State: ACrzQf1sFzs7BXsRJnol0DNSD4ETVambZqeuLT/Wz1P88BRLmErq4Huc
        kQ2DF5T04LlDwslpkJ35zPW5Tg==
X-Google-Smtp-Source: AMsMyM5SWWn2dqLZUyBtlV83s4L7GxK5sCbJPht6qd5fTmr+bTRUwrJbINsFVbiagjEn0Lwm5Z02fg==
X-Received: by 2002:a2e:9606:0:b0:26c:442a:40c2 with SMTP id v6-20020a2e9606000000b0026c442a40c2mr5265118ljh.458.1663689645880;
        Tue, 20 Sep 2022 09:00:45 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j7-20020a2e8507000000b0026c36023a9asm10840lji.131.2022.09.20.09.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 09:00:45 -0700 (PDT)
Message-ID: <558e9b2e-36cb-f09d-2c39-c98248b185d9@linaro.org>
Date:   Tue, 20 Sep 2022 18:00:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 2/3] arm64: tegra: Add PWM controllers on Tegra234
Content-Language: en-US
To:     Sandipan Patra <spatra@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bbasu@nvidia.com, kyarlagadda@nvidia.com
References: <20220919141455.31084-1-spatra@nvidia.com>
 <20220919141455.31084-2-spatra@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919141455.31084-2-spatra@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 16:14, Sandipan Patra wrote:
> Tegra234 has eight single-channel PWM controllers, one of them in the
> AON block.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
