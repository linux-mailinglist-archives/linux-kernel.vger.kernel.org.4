Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5607677A07
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjAWLUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjAWLUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:20:16 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B950193DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:20:14 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so10346061wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3tBuJd9Y4+8y0v8GkFBdXamRmaTAdqpX1uQiUvGgms=;
        b=Ez/L1ezlqPfh1JRYpJ1MKw21/5qS7cgMFueGUdoJnnOdJOUL1y1zMQvAYUEi2S2E0X
         Dy7dreIHECU7XCd3GL6RwvSvc90EPg9VLKbgzgmrBmk7quo20QF3OXAskZYM2aOwPgQk
         SDT3WcqpG/7Vbqq7a4WrkzfsG3ej8lCvGWVJktUMKvYf3NSsMlvjMfF17i/gkSHJcfha
         k1Ms5mAzlMemzlZrWZvp0lP+fDDhHLarHz6JQFOfBMII1FIoaJ7grD91v+Tm3RWv2yC5
         jRFDVrsj/xIPD8g7Uj5ve08Ljcn66LHZZakb76bHUlScXEDmXPPaM6wZvkggJCOmI1mW
         DLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3tBuJd9Y4+8y0v8GkFBdXamRmaTAdqpX1uQiUvGgms=;
        b=IqZdH599K2t/PwvCNE0dId3V1SKs3nlOQaAcRA4CIpCXgSHNxKnxnA+dLoETc5gSQ4
         OKX4XyGs8uxtF1KdV7+XSMJnzX95DJ9FQTYEdvYVVmp/f3iQzAC/emwxO23XATmY201d
         MIXBgeqU6ib1IvsuzPf840qop+EK/QQmHz3HeW9OVlZvEfCmM83XosgDSWOzQkk5FwZv
         bSslJp5ELvqP6kaFy4AUaK1FMYRTFB1FonHTUSQzfKxuRMfhEYO4sharmDWTMLODCwlT
         XgCpVnyWI0cz2fFujAittXgg2jvgv/zj3vdW6SM8yNjecrkPQJkPlKWbgjvfU2xdUVdS
         R/qw==
X-Gm-Message-State: AFqh2krOsHMQdFhCwyli3kiA7jijE/RmvLeoy2iH0WhbxGJmefF9SsBz
        TRqDww8Oo1wyQPkP1ukSwudBbA==
X-Google-Smtp-Source: AMrXdXsknrPbUg8k76V2RV4kaiUIVMIOoWVJJS0evjlVk0aCXWrNXRqkuChPeEG89Jpef04kGBVrVw==
X-Received: by 2002:a05:600c:2d05:b0:3d0:85b5:33d3 with SMTP id x5-20020a05600c2d0500b003d085b533d3mr22561277wmf.16.1674472813464;
        Mon, 23 Jan 2023 03:20:13 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b003db0647645fsm11042492wmq.48.2023.01.23.03.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 03:20:13 -0800 (PST)
Message-ID: <9fdeecf9-8723-5305-ae68-f525c7115456@linaro.org>
Date:   Mon, 23 Jan 2023 11:20:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] usb: dwc3: qcom: enable vbus override when in OTG dr-mode
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123-topic-sm8550-upstream-dwc3-qcom-otg-v1-1-e287a418aa5f@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230123-topic-sm8550-upstream-dwc3-qcom-otg-v1-1-e287a418aa5f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 09:01, Neil Armstrong wrote:
> With vbus override enabled when in OTG dr_mode, Host<->Peripheral
> switch now works on SM8550, otherwise the DWC3 seems to be stuck
> in Host mode only.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/usb/dwc3/dwc3-qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index b0a0351d2d8b..959fc925ca7c 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -901,7 +901,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>   	qcom->mode = usb_get_dr_mode(&qcom->dwc3->dev);
>   
>   	/* enable vbus override for device mode */
> -	if (qcom->mode == USB_DR_MODE_PERIPHERAL)
> +	if (qcom->mode != USB_DR_MODE_HOST)
>   		dwc3_qcom_vbus_override_enable(qcom, true);
>   
>   	/* register extcon to override sw_vbus on Vbus change later */
> 
> ---
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> change-id: 20230123-topic-sm8550-upstream-dwc3-qcom-otg-81795ea148db
> 
> Best regards,

This makes logical sense => only over-ride VBUS when !Host

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
