Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A036125B3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 23:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJ2Vzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 17:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJ2Vzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 17:55:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59D21C12B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:55:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id be13so13697041lfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Le96TyoqyO71hKPmwsgdDPSUks7KkDNO+FXyFgbR+3g=;
        b=sbHJ36rFVY4oQZCenM07QFyh3SZOEdZEzvFWTjW2Mjr1Hcnc4TEFY8rB9sRSvlkVKi
         2lQsHeXZTZTwGHiiMW+YPJ6r8L3yPF4e2O06nR1dh7tNzgyaIV9dTEzs2iE+uT2dQhxQ
         F062b7WDs9eWWmPBOiW1cgS6M1hVrnzJXfaH0UPQwkcrQHXPpfIr5po/VF+5kXOrk5NR
         DdLd24xG1l+eRxbOjBdELvUEZrVVS03/WQ6xnPuCqZ9fWX3eevZKzOJUl7LcYuMZnmTN
         /Z8vTKN2tGs4AplKatysFqKksTPJyFKyVtL6xhCjUBOi2+oGNx4qf6HQJkzUkGg1UBLI
         Ow8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Le96TyoqyO71hKPmwsgdDPSUks7KkDNO+FXyFgbR+3g=;
        b=eUQHt8j0mkTUzU5pcJMhiqUfhlWB6m7ee5zCZ0clD8cuc+Hd/utPN8CrK5xYmigTJr
         bdES+P5AKwM60IDyjy6YTlQL0V953iWuTYAiwG3mbAfsevXCvuYt4PO13YhHEQRYIUTX
         CXpYgQdcQ0XnphpwabYXpGtu75iALi94oci/loDfkQ6W0wc69wWzr4tQ5c66lq2tQ2Rd
         0+9Tm7M75Bp9+4Q5Z725OWJ1ZOASYBDzakHnYeOqTzh7/PWwJASIHNNhIRpIafxROw5a
         x1YAQHvpJHLr9KQ1tX75YFDYqUejIUAE0MbHRFU97gGBMDu5ktMNDH6daD7Sr0Uz/NuF
         bajw==
X-Gm-Message-State: ACrzQf0b+7G9/1K1YGwmGT0z/ZUkwU6I5x2tf1Qdf4zQbxCNXHmS3OVy
        jUf0D+SV5MOyY8jXZH/ZOu2chw==
X-Google-Smtp-Source: AMsMyM5n2PVpu+QWVVH0p9VTTSfKpEiBaC5qyqqiq1snd0Dd0+9gKSYHIrqHWQ2AjBmXYNxgqW1jcA==
X-Received: by 2002:a05:6512:10d0:b0:4a2:ad92:2990 with SMTP id k16-20020a05651210d000b004a2ad922990mr2450129lfg.276.1667080524206;
        Sat, 29 Oct 2022 14:55:24 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id e17-20020a05651236d100b0048af3c090f8sm459554lfs.13.2022.10.29.14.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 14:55:23 -0700 (PDT)
Message-ID: <e02498ab-f4f4-d7ec-dcd8-9340d301f572@linaro.org>
Date:   Sun, 30 Oct 2022 00:55:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 04/15] phy: qcom-qmp-ufs: Add HS G4 mode support to SM8250
 SoC
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
 <20221029141633.295650-5-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221029141633.295650-5-manivannan.sadhasivam@linaro.org>
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

On 29/10/2022 17:16, Manivannan Sadhasivam wrote:
> UFS PHY in SM8250 SoC is capable of operating at HS G4 mode. Hence, add the
> required register settings using the tables_hs_g4 struct instance. This
> also requires a separate qmp_phy_cfg for SM8250 instead of SM8150.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 68 ++++++++++++++++++++++++-
>   1 file changed, 67 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

