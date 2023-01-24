Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E267931D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjAXI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjAXI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:29:31 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559C82CFE2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:29:30 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l8so10798186wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jjg3PTNaG9TA/YJFBk0aScsN783nundzyslnoyMX9ms=;
        b=xPNk+ci70HKbMpoZal0Dkj6tQXIQ0jE5vSgfDCwEta//iXbXR82RbEcN176J2r9e8S
         DzHLDMbej+BleQD0ucICiU+N5KlTvdDkgsnLWVvbB3/tErpHW2As10kx+tHLsJ0ZXONz
         CXLoZ12xA+8qf/G4c4LmClcNNVokfbkoGD4rAN3lmbajf5rE+KQAlLomE1G7cwNEx2w9
         3a6abMDI5vj9Xi9KU6IC1A59mFs2tFdM+OL+7NwDhYghT6yvrocfgbiYbIua9cqzfVuS
         wp4q6fMPdvetnNqi45K1YrNBrVfxwlp7yyGF953xcRJxSpy7sM+mSt3F1y8BSIxEP/Sg
         KlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jjg3PTNaG9TA/YJFBk0aScsN783nundzyslnoyMX9ms=;
        b=6qFHWUWxk/jTAtaxzuf/Jx4WXyRjTB48Uo+VcyfXSTKD+6/1uENzqqatpKGc7zOlxD
         PmkoZu6Vr28K3HbkS2xjCq2KeqEOn/i9JlCYxu4mfnXGnwqaSzbOlTR3PFzdSjHBnW98
         GDwOWQosA2nt4SxPJKdlKJsC7rZkyEfffw0DU3ENA/EIeu78QPh7DbuzA5TUwkgeknsZ
         OGXCVQNH4aI4nVnAdOuWVFnzXL0dVIqrtrOHzjvuETY1tTGN1nFbt+L5bXOyMhPIzkNK
         5z6lf7aK2j43nq1bR0S2DTNKv1luKmYOa2CEU4BYInn6KF/YVraEcqITG9LDscoYs9sI
         BxMg==
X-Gm-Message-State: AFqh2kovQjOzQwTPiR+cKW2Y+cIBsx3Ed+skihTnzhrMk7WpeodLBAgN
        JLR9yEDV3I9gva0F16DSypAj1A==
X-Google-Smtp-Source: AMrXdXs0f4oNu7/SovheNXe2SEzsmHZxUroUQiV1dTGiqV5VhJJGJmH5pC6cGvjH2Xq4s4V64hYF1w==
X-Received: by 2002:a05:600c:540c:b0:3da:fa18:a535 with SMTP id he12-20020a05600c540c00b003dafa18a535mr27222258wmb.29.1674548968857;
        Tue, 24 Jan 2023 00:29:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ebd2:15b:f444:7985? ([2a01:e0a:982:cbb0:ebd2:15b:f444:7985])
        by smtp.gmail.com with ESMTPSA id e18-20020a05600c449200b003da105437besm1282237wmo.29.2023.01.24.00.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 00:29:28 -0800 (PST)
Message-ID: <5d3d9ae3-4ff7-070e-24fb-3d808560f853@linaro.org>
Date:   Tue, 24 Jan 2023 09:29:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] usb: dwc3: qcom: enable vbus override when in OTG dr-mode
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123-topic-sm8550-upstream-dwc3-qcom-otg-v1-1-e287a418aa5f@linaro.org>
 <Y85U9HSD6TIXFkg0@kroah.com>
Organization: Linaro Developer Services
In-Reply-To: <Y85U9HSD6TIXFkg0@kroah.com>
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

On 23/01/2023 10:35, Greg Kroah-Hartman wrote:
> On Mon, Jan 23, 2023 at 10:01:25AM +0100, Neil Armstrong wrote:
>> With vbus override enabled when in OTG dr_mode, Host<->Peripheral
>> switch now works on SM8550, otherwise the DWC3 seems to be stuck
>> in Host mode only.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> index b0a0351d2d8b..959fc925ca7c 100644
>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>> @@ -901,7 +901,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>   	qcom->mode = usb_get_dr_mode(&qcom->dwc3->dev);
>>   
>>   	/* enable vbus override for device mode */
>> -	if (qcom->mode == USB_DR_MODE_PERIPHERAL)
>> +	if (qcom->mode != USB_DR_MODE_HOST)
>>   		dwc3_qcom_vbus_override_enable(qcom, true);
>>   
>>   	/* register extcon to override sw_vbus on Vbus change later */
>>
>> ---
> 
> What commit does this fix?  Should it go to stable kernels?

a4333c3a6ba9 usb: dwc3: Add Qualcomm DWC3 glue driver

Will resend with Fixes tag,

Neil

> 
> thanks,
> 
> greg k-h

