Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C916F9983
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjEGPsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjEGPsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:48:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E0244B7
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 08:48:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f00d41df22so24762646e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683474489; x=1686066489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dvd1wcddDnuI8xDMHy/JBREKoiCmgw2+qPFLe3kD+Sg=;
        b=kPqgPO0uNRT4ln/P6yjXt/YWIChqAu/dBpyVcn9fV1c3TZDmGMfXsJ1G1Y/95+CIkN
         8JaB6Ipky4BWZrsTGvdotbye3LnqrBX0BDzSFMXNl0UEg41EFtkxY65qA4waV8r9YzrN
         ja+NnGW2j1K0OCne9r5fPNqqOBmkfIP4jyz05bW6SV/rGrbagGKuQd/YB5Q7b9DkUrTM
         ICcsEtGBmNIlLIuw5RuOd3+hgmDdBI8gfl8XW5/RrmsEpbdTOS9CBozFpcgXrzhbpOPU
         EquZCNJuBI7kvLafbx5RfZtvgaIVpdn9rj7kNyXUHXs2AUN3MtpKtKHQ28K6pw2unpd5
         I6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683474489; x=1686066489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dvd1wcddDnuI8xDMHy/JBREKoiCmgw2+qPFLe3kD+Sg=;
        b=AIEUx8HoRyp0DlfNOORt70wQ4yNQ0fcL13TcpSI67GbcGys3r05k4I1nZqJ2ORt+iR
         QXj8Zn0impma+QvcLaJj1kNB1Ne17OrSt/Ot8LedT4GYR+LSls6c+I9tj/RSJjOu8RtM
         Eh0EKJ4BXl/IjuDgypXtnmpUgPm2HYN4vzMQ0LwX+AdUzXs/UOgT3/mKvBM7EjBE7XnW
         EQyVivht6BgnoFPiP3b4VT7dOrYL05tnDbaHKi7+OsanZq0/hfSPJ2Zxhq6LFy8EAt6q
         38cI68/U/bAjaNd3rsBohKOMvC25nSy8Q6Wr1j4xsMNREkS/khJe+ouNlzhZ2yxTVsG5
         Lx8A==
X-Gm-Message-State: AC+VfDzINM3ROb0jYadMElsSpLLKwr21x04IrJZtBNbNUuNXOTxp9AtH
        beuPAgAbXADY5lx0heRGA2ezbA==
X-Google-Smtp-Source: ACHHUZ5OQ5tsRZMNgmjb1yUX5x0EN64JfrmwXl9OXuRV+QiEwE1vlP14Rp4K5Z2azPwAMwTiWuLYig==
X-Received: by 2002:ac2:5215:0:b0:4ef:d567:4854 with SMTP id a21-20020ac25215000000b004efd5674854mr1811635lfl.11.1683474488883;
        Sun, 07 May 2023 08:48:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u17-20020ac243d1000000b004b40c1f1c70sm1014163lfl.212.2023.05.07.08.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 08:48:08 -0700 (PDT)
Message-ID: <de242c1a-9717-ad79-2ed5-7b73cf66f5e2@linaro.org>
Date:   Sun, 7 May 2023 18:48:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND v3 4/5] iio: adc: qcom-spmi-adc5: Remove
 unnecessary datasheet_name NULL check
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
 <20230502-iio-adc-propagate-fw-node-label-v3-4-6be5db6e6b5a@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230502-iio-adc-propagate-fw-node-label-v3-4-6be5db6e6b5a@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 02:17, Marijn Suijten wrote:
> datasheet_name is statically filled by a macro for every channel, and is
> nor should ever be set to NULL.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/iio/adc/qcom-spmi-adc5.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

