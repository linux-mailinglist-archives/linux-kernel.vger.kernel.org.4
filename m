Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F81680F26
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbjA3Nh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbjA3NhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:37:24 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D4B38E93
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:37:22 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z11so10975114ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4yRG9AaVUq38HNMdl70eRGL3T15kSDpcRhgcRdpne+Y=;
        b=idhud6rsiGu7vlVGSz2uW1gXAXuvFYZ7rznj2KRlzNvRFcBpCHMpomm8Dsi4ogJNw+
         ryvqq1pw/3+tXOBBSk7LaRtcCIs80l3WLOjd4oOy4fUmpwcaa3Wgtn0MvEOdXtDrv5bw
         Wh/mGAUThaA0fcrxkFsiFhaCSHnBCgAfocfgLpis57hmqFzBL/Gll3/0EWldPeAVTkWj
         viv4rssYI2QzPSQYzrzh7IXI+wnWoQqv9XlB8ziA4v15a+f87MXxCFajJ8namejvVSEs
         gumIec39E4Z+fOw8rCmqSltdRmREjyKXnknEihUyPdj1vLdFhh7MtMAdIvhjUcBGj3Tm
         LFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yRG9AaVUq38HNMdl70eRGL3T15kSDpcRhgcRdpne+Y=;
        b=q2cMFW/LIkeujjE+1oKwy5YwCPVnHXn0dIRugbQU+jYms/VhH+FCHfVDhCV+u/9YOU
         QdPgexoGDfzPRN+goxrGMtG2F9n44jTBBfixll7wd6FAB25aVj7d0tXMAEaiQiev9ieE
         NlVT97ZIddCBYVOVOK7EHbWEloQ8t38tA5oH0lwLjUj/lKo4FbAfJAxxAK59h28Jw9ZD
         vdvU80XvDxilBtHWrBFgJRWYpIX4eDXtwspTW5uasiqFKvqKpMjYHTfz3vXkje8U7LtH
         qazSFvyCanAI2WW1BxWAdFgYPckxgiR3KLUorhV3PXxTVCY4Nbd26JfVPkv9B8p1Ok2y
         8j7A==
X-Gm-Message-State: AO0yUKV1whK5DBGZbW2GxpdmG9fbUIDoM9zaS146zUn4Dz4L45xZbrJW
        1d4wi3FrIud09SAjRWNud/Q6ig==
X-Google-Smtp-Source: AK7set9v89NqoWEUGaRFrm4xkSaf3wFhe/gEDGxpI7o1LheM1Vo5L+jnlSasCgOL1iXfhZ2lQaocew==
X-Received: by 2002:a05:6402:3603:b0:499:bffb:7e58 with SMTP id el3-20020a056402360300b00499bffb7e58mr5903817edb.20.1675085841537;
        Mon, 30 Jan 2023 05:37:21 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id u20-20020a50a414000000b004a08c52a2f0sm6936872edb.76.2023.01.30.05.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 05:37:20 -0800 (PST)
Message-ID: <5dee594f-b05f-1211-7444-c45691455b9c@linaro.org>
Date:   Mon, 30 Jan 2023 14:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] usb: dwc3: qcom: enable vbus override when in OTG
 dr-mode
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123-topic-sm8550-upstream-dwc3-qcom-otg-v2-1-2d400e598463@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230123-topic-sm8550-upstream-dwc3-qcom-otg-v2-1-2d400e598463@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.01.2023 09:31, Neil Armstrong wrote:
> With vbus override enabled when in OTG dr_mode, Host<->Peripheral
> switch now works on SM8550, otherwise the DWC3 seems to be stuck
> in Host mode only.
> 
> Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Required for SM6115P Lenovo Tab P11 to switch to peripheral 
with otg dr_mode as well!

Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Changes in v2:
> - Added Bryan's reviewed-by
> - Added Fixes tag
> - Link to v1: https://lore.kernel.org/r/20230123-topic-sm8550-upstream-dwc3-qcom-otg-v1-1-e287a418aa5f@linaro.org
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index b0a0351d2d8b..959fc925ca7c 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -901,7 +901,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	qcom->mode = usb_get_dr_mode(&qcom->dwc3->dev);
>  
>  	/* enable vbus override for device mode */
> -	if (qcom->mode == USB_DR_MODE_PERIPHERAL)
> +	if (qcom->mode != USB_DR_MODE_HOST)
>  		dwc3_qcom_vbus_override_enable(qcom, true);
>  
>  	/* register extcon to override sw_vbus on Vbus change later */
> 
> ---
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> change-id: 20230123-topic-sm8550-upstream-dwc3-qcom-otg-81795ea148db
> 
> Best regards,
