Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA816F91A7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 13:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjEFLoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 07:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjEFLob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 07:44:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011FC9033
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 04:44:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4eff055d4d3so3097008e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 04:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683373468; x=1685965468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6f9jWuVoP7kwY2he96mdyxDyH5d3ajIgODBTomeVrc=;
        b=QucCjkxwG5l9GY3Sm7/wlKyr8IB+QCy04jzf2BGU1hNHdd7b4DzG6wh+Tdsyxp7ZF8
         N2kGx0Rq7izVIjn0ZmywEDY4XEE684fRzFezT1deehhopCHEDb2hFgPfQOYpwR6uY9IR
         dadqrDOX81amu0ok8BZZfOEQ27Vxa2X705lzFSyJgh8212JXSB/CuUxyqK/0On71QXQ2
         0bNViAFOGNMvwwjdVYZloZt86VNP/xTwvPA4ajnX0Wf1vD5WHz15qdxV2DHrjigjdFMk
         TCC+Pfv7PUakj2sDknqFtm7kIRyNxWFcFw56h4eK+MHGHOgpYMGISSbEAe0bkJFpw7ak
         lfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683373468; x=1685965468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6f9jWuVoP7kwY2he96mdyxDyH5d3ajIgODBTomeVrc=;
        b=dC6qJNjqawqSOoT8yEG9qSChWzQMKj79HWC2ss14NwJHVXv7dlgw9huu7Tm5mRGEvr
         PR35WpVeDjWwTH8EfsGdbmYhZ1gjTKH4kFJEsH2CDqO1yUM+ah0L6DNoUx6ioqGIdcwv
         6f0veLFBjkSnK1NL4IvKJeP7vk2wa7cwj926FN9pSiha/aoYA0JfNGd9br8F4HaV2Z5p
         YvtGkGrbeI6pkdN16cDM5qDfDDUtwZo9b4eDOholoGcoOinJ42bl3CxoLxOmbXk34CyI
         3IX502Yzv9tUcUdXBy00U/ZbL45kPorfbhDv+CWjHlMpDvMs80XfvZHr4lCDD4ArOGGb
         LlrA==
X-Gm-Message-State: AC+VfDyZ+DIfz0PoHHxrTqfirHm8lEqXNQLQaLeCEj54Y1OIhFh8o//I
        +/aDfF/6CjT5t+EiZWb/c2Nfqw==
X-Google-Smtp-Source: ACHHUZ4y43e5Mp+2TdKqczlOvmvm6e1/OEUZwFlv1bfcE5KHKPAIRxJg/k3J54ruSR5apgxmASlCwQ==
X-Received: by 2002:ac2:4209:0:b0:4f1:430d:ca5c with SMTP id y9-20020ac24209000000b004f1430dca5cmr1350582lfh.56.1683373468256;
        Sat, 06 May 2023 04:44:28 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id c10-20020ac2530a000000b004f00189e1dasm634622lfh.143.2023.05.06.04.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 04:44:27 -0700 (PDT)
Message-ID: <56da1bb2-86ea-e31e-15f3-5eb50e3000e1@linaro.org>
Date:   Sat, 6 May 2023 14:44:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/8] PCI: qcom: Disable write access to read only
 registers for IP v2.9.0
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com
References: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
 <20230506073139.8789-3-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230506073139.8789-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2023 10:31, Manivannan Sadhasivam wrote:
> In the post init sequence of v2.9.0, write access to read only registers
> are not disabled after updating the registers. Fix it by disabling the
> access after register update.
> 
> Fixes: 0cf7c2efe8ac ("PCI: qcom: Add IPQ60xx support")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@gmail.com>

-- 
With best wishes
Dmitry

