Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12361261F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 00:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJ2WG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 18:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2WGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 18:06:25 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4167533432
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 15:06:24 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b8so12562671ljf.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 15:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJDjGMm6I8hjAfftqkiQTNt09c2+c9FwSviLe2yp5iw=;
        b=Py3MJJV/HlB9DftTqPNbSYJAxhgyf2Yodm2Sp8+XtgQAUPmeWMGLwXFkFGBayvEG1N
         WWUEfzDXN7t4D3XYRcHB5Sxai/wjj/ZaZrxjmNTPqZTJufO3yFJcgQCWd/1bngDXGXl7
         ylEmWYQdqtsX2sc3HjlCbe4X2luPbz6MtnukExb/n7XnzE0syraNgoiAUBMGZZUEBG/A
         J0//BwTYlxBp8rTvYMms7+KGpNnKycxzTbOYzXZUtsJO9Ezpc1D7LFMdZcTuWyWO70ZE
         Klw7OpX+ln5/+54DVWUEIDm8cXwEolQfUkAW7Vd5i7zKOyVwKaXW6eqSdlRtoMPvOUTh
         jXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJDjGMm6I8hjAfftqkiQTNt09c2+c9FwSviLe2yp5iw=;
        b=llW5WgmjB1JrtF+U2SzkCF7yNOHSA70+S/FmqBP3mkJ7pdy7LkFOEGVKbzqj8Q7ndv
         1WRkdriSVingOAd820DWgDYo6kmT1wV803TDBwVVoRmuqIqXwWLPZIRlNRqOvD/BeSxl
         aK4hCNC82hdhE6j1AdYtjyE2k25m0whBwCKq9Fi+HDtDmVz40FjBLu0rm33QdSYNhVVG
         c4rQd6xvqEBtjd0k/rJVDJy51AEGMNf5bdHQfPrBIroT62ntM+SKBJqH0st9NNAAgBqo
         9yOp7wNeJuTKXC3Y4yxdtfcOA7G5fZaHGIRsZO4s4ESh8dHNDyMVk83E3qflsyKSIJnB
         k+rQ==
X-Gm-Message-State: ACrzQf3rT4w00WRoPtBaHICgc7IUrNnxktztIoA7jVa85u/esl4BnnK6
        eKM18RBWwpKRDKfuGUudKZ+b8g==
X-Google-Smtp-Source: AMsMyM6d9zFikwHgFIh6rMjFnXd95IUDGB9ReOdNF6pduE42CdBpB+h3NUOeN+s9d+Sh4pEsV9GjGQ==
X-Received: by 2002:a05:651c:1a0e:b0:26f:e008:a29c with SMTP id by14-20020a05651c1a0e00b0026fe008a29cmr2417615ljb.365.1667081182585;
        Sat, 29 Oct 2022 15:06:22 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id v14-20020a2ea44e000000b0026e8b82eba6sm442460ljn.34.2022.10.29.15.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 15:06:22 -0700 (PDT)
Message-ID: <9c1ca51d-2202-8279-cecb-12792385b18d@linaro.org>
Date:   Sun, 30 Oct 2022 01:06:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 12/15] scsi: ufs: ufs-qcom: Fix the Qcom register name for
 offset 0xD0
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
 <20221029141633.295650-13-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221029141633.295650-13-manivannan.sadhasivam@linaro.org>
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
> Fix the register name used for offset 0xD0. The correct name is
> REG_UFS_PARAM0.

The vendor kernels starting from 3.10 define this register as 
RETRY_TIMER_REG (but it is unused). I'd suggest adding a comment about 
the older register name.

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/ufs/host/ufs-qcom.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 6cb0776456b3..214ea50acab9 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -33,7 +33,7 @@ enum {
>   	REG_UFS_TX_SYMBOL_CLK_NS_US         = 0xC4,
>   	REG_UFS_LOCAL_PORT_ID_REG           = 0xC8,
>   	REG_UFS_PA_ERR_CODE                 = 0xCC,
> -	REG_UFS_RETRY_TIMER_REG             = 0xD0,
> +	REG_UFS_PARAM0                      = 0xD0,
>   	REG_UFS_PA_LINK_STARTUP_TIMER       = 0xD8,
>   	REG_UFS_CFG1                        = 0xDC,
>   	REG_UFS_CFG2                        = 0xE0,

-- 
With best wishes
Dmitry

