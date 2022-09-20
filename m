Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CEC5BE797
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiITNvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiITNvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:51:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9E543613
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z6so4457595wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=ie45F/lkLLynh4wGP5XxIIavgNdgbFKnC44CCTp/NRI=;
        b=lrPNrEQr+xNLISBtmLHGMl4sny3vDZKH6tJ73KRXFF/z+OqE65D6MT2Vt6TNTsRyED
         IOUlazvaj2Xo7Hs5cw+aMa+Aj/mgfrLqbrW5Uyq9IDtXLL1TCYINRtzSF04dE2ZHmWAO
         4uzFWz4db3ePQZCkEpEdGsay1RkFqpEmB3TC4V8YvX87thlihx8+4t34+3pYrzoHPHIW
         9lveiAHp/OvMSw29Ez4F+Lf7L76p4fYUGLPtWQQ652Rx+tGSfX3FDHQT6QwEfs5uwtuq
         glcxO3xnQbBTgSYywgvYdfmE+JZTunzw3OrX8z+TohdF0uxXlV1WSFvXS8mpy/WTqM7u
         sKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ie45F/lkLLynh4wGP5XxIIavgNdgbFKnC44CCTp/NRI=;
        b=tYIZFK+GYor4hbqCUKcTIKAD9j9KW36bxzWdcfNIgVFs66ZVfNXwxhvtHfcVVQRlQO
         OXvvw+yOOFb2UqKRVAT7nEDVyjcdtgzlZ4HOnY7JIePpqVKhlt7xi5pLB+NHHir/vNBX
         aE7QDkgRVA/crQHVqvzA1plHne5beJbqwHUWSh4+x+TfOhbnkLRTM0/uhsX3wdMhVdCq
         ukQ16t5+77w/ufu3ux2ExMZtk8oPGAI6v/9JG3kgjNNj0g/LeKmdB/Tx0v/Nkr5GuyUF
         qOtI8Z3eyiwTW0y31wDk+mLoGNew4nPLZ28caMcHjifn87o5ObGlU9Uxx+yZSUPJd1Qu
         7syg==
X-Gm-Message-State: ACrzQf38/8VuThnG8l1Rl8YhSHi8jg4vSZLnwKA/ELQCIGnSLHOMSpkG
        q/KXVOZyVZfNr+Ns5fnyST1wdA==
X-Google-Smtp-Source: AMsMyM5/im8/35tKr1t1+wFKKnt4WVrkH/e+GlT1tr5K6kmneVuOMtgNWUvOuzQ+4lfcAARt5mV+mw==
X-Received: by 2002:a05:6000:78b:b0:22a:da96:8ae6 with SMTP id bu11-20020a056000078b00b0022ada968ae6mr13830191wrb.232.1663681881322;
        Tue, 20 Sep 2022 06:51:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d4b09000000b0022acb7195aesm74782wrq.33.2022.09.20.06.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:51:20 -0700 (PDT)
Message-ID: <ffc992a7-fe2e-fff4-1ee0-efd727103f20@linaro.org>
Date:   Tue, 20 Sep 2022 15:51:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/17] phy: qcom-qmp-pcie: drop init and exit wrappers
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
 <20220920073826.20811-6-johan+linaro@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920073826.20811-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 29 ++++--------------------
>   1 file changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index d25f9215b86f..525097e3b041 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1877,8 +1877,9 @@ static int qmp_pcie_serdes_init(struct qmp_phy *qphy)
>   	return 0;
>   }
>   
> -static int qmp_pcie_com_init(struct qmp_phy *qphy)
> +static int qmp_pcie_init(struct phy *phy)
>   {
> +	struct qmp_phy *qphy = phy_get_drvdata(phy);
>   	struct qcom_qmp *qmp = qphy->qmp;
>   	const struct qmp_phy_cfg *cfg = qphy->cfg;
>   	void __iomem *pcs = qphy->pcs;
> @@ -1925,8 +1926,9 @@ static int qmp_pcie_com_init(struct qmp_phy *qphy)
>   	return ret;
>   }
>   
> -static int qmp_pcie_com_exit(struct qmp_phy *qphy)
> +static int qmp_pcie_exit(struct phy *phy)
>   {
> +	struct qmp_phy *qphy = phy_get_drvdata(phy);
>   	struct qcom_qmp *qmp = qphy->qmp;
>   	const struct qmp_phy_cfg *cfg = qphy->cfg;
>   
> @@ -1939,20 +1941,6 @@ static int qmp_pcie_com_exit(struct qmp_phy *qphy)
>   	return 0;
>   }
>   
> -static int qmp_pcie_init(struct phy *phy)
> -{
> -	struct qmp_phy *qphy = phy_get_drvdata(phy);
> -	struct qcom_qmp *qmp = qphy->qmp;
> -	int ret;
> -	dev_vdbg(qmp->dev, "Initializing QMP phy\n");
> -
> -	ret = qmp_pcie_com_init(qphy);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
>   static int qmp_pcie_power_on(struct phy *phy)
>   {
>   	struct qmp_phy *qphy = phy_get_drvdata(phy);
> @@ -2060,15 +2048,6 @@ static int qmp_pcie_power_off(struct phy *phy)
>   	return 0;
>   }
>   
> -static int qmp_pcie_exit(struct phy *phy)
> -{
> -	struct qmp_phy *qphy = phy_get_drvdata(phy);
> -
> -	qmp_pcie_com_exit(qphy);
> -
> -	return 0;
> -}
> -
>   static int qmp_pcie_enable(struct phy *phy)
>   {
>   	int ret;


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
