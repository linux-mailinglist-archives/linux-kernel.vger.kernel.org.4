Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E115BE798
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiITNvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiITNvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:51:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0474BD1C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l8so1993039wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=ABm12BDGRAnyJPzIGGGbSYECJSn3pbDMsi+x9qRRmN4=;
        b=cHjrXAzpUNgV+TPGOtLwhtVBLSt5XYrN3V+cVIV/aUsbYmPURGwC/Ml7Azs4pulCN5
         svIKFwuvSTZ44KLS8pse2Ek8Gyju2+N+lXfQ/VCIh1rQjp4rF55HoC3/9sohJYhgnW3V
         kFQbv3QzgbED6Yd3TXT9QIcdNWnG/Lv9l/3yQOMoCqEHRfh2ID8V+9Hdv2p6LMI/1oCL
         iCnGAOLyqBFdKpyf1EQSbb19naNjXR7wWuHbtC2a7abDWo+5mEshKeKy+b0IAMH+West
         02hZZZVGVacBEXuX6eEaYcWFIVSM0oyCTiMkKPqelSeY2hWN/u8R1EFYxU4eSM08nXYu
         cj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ABm12BDGRAnyJPzIGGGbSYECJSn3pbDMsi+x9qRRmN4=;
        b=kENE912BhPq9os8CJ/Y7/I4uVOApq6zNUO6tT96iRjiKs71gyIS9c5hYJN2Qo9TKbp
         jzyqNItUo+71NXXnUaG9jG1/tp8ZGVUqLEvpSgPApuAxWsqiUrAY3edrH1v9OkvBo/SD
         eLJkKoamsfMpoUNZ6OOKFYt1r9fbicWv5rRmLTTWDvCpqoC+iCUy90fN1PdOgZbTLGQu
         e4d0iq0ljQe4QO9tlpooDMHAt48cVOCppVza7kRJP9uu+/Gx1CZf265o0q9WaUk6DzAh
         oVTcvbs7DSidi/u+1JPoGU0kEsmc6lXJ/DoGyAPMCKwOh7nhpj75VM08vA7yk8bNyRpa
         ecgg==
X-Gm-Message-State: ACrzQf3vrDWRuc2sWnTNlX+O732r76l+rWijANR1j60RNSl/ouJRnYZe
        GL6WTeeA+oFCzU2xAUfHe/q2fQ==
X-Google-Smtp-Source: AMsMyM5Y8yPCq4NXVv/7bJETm/WzHnyyBpKYqEi+DmdPjZrsYxNcVrECJlzwzFfDWukJW2Hk4ZT/ww==
X-Received: by 2002:a7b:c01a:0:b0:3b4:a61c:52d1 with SMTP id c26-20020a7bc01a000000b003b4a61c52d1mr2597913wmb.146.1663681885940;
        Tue, 20 Sep 2022 06:51:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c08a600b003b4924493bfsm183360wmp.9.2022.09.20.06.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:51:25 -0700 (PDT)
Message-ID: <34c9c189-b51b-8b36-c10a-72bbefd63502@linaro.org>
Date:   Tue, 20 Sep 2022 15:51:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 06/17] phy: qcom-qmp-usb: drop init and exit wrappers
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220920073826.20811-1-johan+linaro@kernel.org>
 <20220920073826.20811-7-johan+linaro@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920073826.20811-7-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 09:38, Johan Hovold wrote:
> Drop the unnecessary PHY init and exit callback wrappers.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 29 ++++---------------------
>   1 file changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index 03481b6f1c35..a42e13905c15 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -2125,8 +2125,9 @@ static int qmp_usb_serdes_init(struct qmp_phy *qphy)
>   	return 0;
>   }
>   
> -static int qmp_usb_com_init(struct qmp_phy *qphy)
> +static int qmp_usb_init(struct phy *phy)
>   {
> +	struct qmp_phy *qphy = phy_get_drvdata(phy);
>   	struct qcom_qmp *qmp = qphy->qmp;
>   	const struct qmp_phy_cfg *cfg = qphy->cfg;
>   	void __iomem *pcs = qphy->pcs;
> @@ -2197,8 +2198,9 @@ static int qmp_usb_com_init(struct qmp_phy *qphy)
>   	return ret;
>   }
>   
> -static int qmp_usb_com_exit(struct qmp_phy *qphy)
> +static int qmp_usb_exit(struct phy *phy)
>   {
> +	struct qmp_phy *qphy = phy_get_drvdata(phy);
>   	struct qcom_qmp *qmp = qphy->qmp;
>   	const struct qmp_phy_cfg *cfg = qphy->cfg;
>   
> @@ -2211,20 +2213,6 @@ static int qmp_usb_com_exit(struct qmp_phy *qphy)
>   	return 0;
>   }
>   
> -static int qmp_usb_init(struct phy *phy)
> -{
> -	struct qmp_phy *qphy = phy_get_drvdata(phy);
> -	struct qcom_qmp *qmp = qphy->qmp;
> -	int ret;
> -	dev_vdbg(qmp->dev, "Initializing QMP phy\n");
> -
> -	ret = qmp_usb_com_init(qphy);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
>   static int qmp_usb_power_on(struct phy *phy)
>   {
>   	struct qmp_phy *qphy = phy_get_drvdata(phy);
> @@ -2316,15 +2304,6 @@ static int qmp_usb_power_off(struct phy *phy)
>   	return 0;
>   }
>   
> -static int qmp_usb_exit(struct phy *phy)
> -{
> -	struct qmp_phy *qphy = phy_get_drvdata(phy);
> -
> -	qmp_usb_com_exit(qphy);
> -
> -	return 0;
> -}
> -
>   static int qmp_usb_enable(struct phy *phy)
>   {
>   	int ret;


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
