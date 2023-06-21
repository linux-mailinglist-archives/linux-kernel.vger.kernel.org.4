Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A90738073
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjFUKMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjFUKLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:11:47 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327F51FDF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:11:02 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f766777605so7574253e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687341957; x=1689933957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pksCYSKSrUw959LX6eQrI6QTHRyxobqR3+3tR4T6QsY=;
        b=HxtKccS8RJbfFltppK+lao89MD5mbUlOnGUB3wU94Lbk12nijhYFO8yzyRD0gFMXKc
         47ZVNkQuTdJTwRBXXfX4EWbKf/p67W5lu0qaS4rUpPt4XepdOnBDx64bPb3Hc2UnNSSK
         jY0c9t66KDde3h7uicuu26TUo7Xret5V6rms1HY6u1OakmTevNL+A1ZDhwDT7TXpypg5
         WDuTqHvIxN2YavpPb7K+VDs8hPpYpYeQKJgsjs1NOIpyMknTFG0rLLNZ3rTmKUe/H2nI
         n4d+vC54Cx+iqu9Wc7kqd+6BT3DgAkw1+b3RnUrR7+YhovyjIfa5EC/+obPHf/TJCRQc
         eMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341957; x=1689933957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pksCYSKSrUw959LX6eQrI6QTHRyxobqR3+3tR4T6QsY=;
        b=dant+JWgr2KAVyEB3WZ1cADtiEMOnQyvjUZ0H2zcBwOeSnhYE8xTpIBolmRq1pn0C8
         5bmhl9GRLD13TxO5OxxswpY2H9rBJg65GUwSEpWPosYS+JXs4LREpUQfCuOgVifY7A1N
         JU3f0X0zuP1KWaOpI69lej1Q27PGzMs0n+9twUhxGcGtFIhPwqlwGUnfb2JTWV+qoeQ/
         GEJDVTipR7HUFmATaYWnYXNZAd/O5bx/KR5qJlxnUGPF8+s3wjF7VvXFDLTj14sGB8CT
         OP3+EbJgtkV4Pu6ceKi2cHr2tKHkMqiYuRnARJ2OutpbsVEvIQ0z8LMgUQtITqLpnPat
         5ywA==
X-Gm-Message-State: AC+VfDzje4WoXYrp+FaVT2Qri77Lxjs20Ia5cLXBKa1MMsVx25G/HTny
        bNHxPCijrEJo4zExvUWO1V2SjA==
X-Google-Smtp-Source: ACHHUZ5QiiQtUk4JbcmnjEQdDbclg/kzrtbPZxS/pLfnjRuPS/9CAQscff3Ta9mnLU0++IilXDxIIw==
X-Received: by 2002:a19:6555:0:b0:4f8:5f32:b1da with SMTP id c21-20020a196555000000b004f85f32b1damr6833037lfj.24.1687341957210;
        Wed, 21 Jun 2023 03:05:57 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id l11-20020ac24a8b000000b004f87487db79sm718117lfp.222.2023.06.21.03.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 03:05:56 -0700 (PDT)
Message-ID: <03371bd0-12a5-3109-ebf7-33feeef31bac@linaro.org>
Date:   Wed, 21 Jun 2023 12:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 06/10] usb: dwc3: qcom: Add support to read IRQ's
 related to multiport
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230621043628.21485-7-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.2023 06:36, Krishna Kurapati wrote:
> Add support to read Multiport IRQ's related to quad port controller
> of SA8295 Device.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 108 +++++++++++++++++++++++++++++------
>  1 file changed, 91 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 3de43df6bbe8..3ab48a6925fe 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -74,9 +74,9 @@ struct dwc3_qcom {
>  	struct reset_control	*resets;
>  
>  	int			hs_phy_irq;
> -	int			dp_hs_phy_irq;
> -	int			dm_hs_phy_irq;
> -	int			ss_phy_irq;
> +	int			dp_hs_phy_irq[4];
> +	int			dm_hs_phy_irq[4];
> +	int			ss_phy_irq[2];
Not sure if that's been raised previously, but having raw numbers here
is not very descriptive.. MAX_NUM_MP_HSPHY or something would be helpful
for readability..

Konrad
>  	enum usb_device_speed	usb2_speed;
>  
>  	struct extcon_dev	*edev;
> @@ -375,16 +375,16 @@ static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
>  	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
>  
>  	if (qcom->usb2_speed == USB_SPEED_LOW) {
> -		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
> +		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq[0]);
>  	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
>  			(qcom->usb2_speed == USB_SPEED_FULL)) {
> -		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
> +		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq[0]);
>  	} else {
> -		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
> -		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
> +		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq[0]);
> +		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq[0]);
>  	}
>  
> -	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
> +	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq[0]);
>  }
>  
>  static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
> @@ -401,20 +401,20 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
>  	 */
>  
>  	if (qcom->usb2_speed == USB_SPEED_LOW) {
> -		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
> +		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq[0],
>  						IRQ_TYPE_EDGE_FALLING);
>  	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
>  			(qcom->usb2_speed == USB_SPEED_FULL)) {
> -		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
> +		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq[0],
>  						IRQ_TYPE_EDGE_FALLING);
>  	} else {
> -		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
> +		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq[0],
>  						IRQ_TYPE_EDGE_RISING);
> -		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
> +		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq[0],
>  						IRQ_TYPE_EDGE_RISING);
>  	}
>  
> -	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq, 0);
> +	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq[0], 0);
>  }
>  
>  static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
> @@ -535,6 +535,80 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int dwc3_qcom_setup_mp_irq(struct platform_device *pdev)
> +{
> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> +	char irq_name[15];
> +	int irq;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < 4; i++) {
> +		if (qcom->dp_hs_phy_irq[i])
> +			continue;
> +
> +		sprintf(irq_name, "dp%d_hs_phy_irq", i+1);
> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
> +		if (irq > 0) {
> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> +					qcom_dwc3_resume_irq,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					irq_name, qcom);
> +			if (ret) {
> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
> +				return ret;
> +			}
> +		}
> +
> +		qcom->dp_hs_phy_irq[i] = irq;
> +	}
> +
> +	for (i = 0; i < 4; i++) {
> +		if (qcom->dm_hs_phy_irq[i])
> +			continue;
> +
> +		sprintf(irq_name, "dm%d_hs_phy_irq", i+1);
> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
> +		if (irq > 0) {
> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> +					qcom_dwc3_resume_irq,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					irq_name, qcom);
> +			if (ret) {
> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
> +				return ret;
> +			}
> +		}
> +
> +		qcom->dm_hs_phy_irq[i] = irq;
> +	}
> +
> +	for (i = 0; i < 2; i++) {
> +		if (qcom->ss_phy_irq[i])
> +			continue;
> +
> +		sprintf(irq_name, "ss%d_phy_irq", i+1);
> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
> +		if (irq > 0) {
> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> +					qcom_dwc3_resume_irq,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					irq_name, qcom);
> +			if (ret) {
> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
> +				return ret;
> +			}
> +		}
> +
> +		qcom->ss_phy_irq[i] = irq;
> +	}
> +
> +	return 0;
> +}
> +
>  static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  {
>  	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> @@ -570,7 +644,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
>  			return ret;
>  		}
> -		qcom->dp_hs_phy_irq = irq;
> +		qcom->dp_hs_phy_irq[0] = irq;
>  	}
>  
>  	irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
> @@ -585,7 +659,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
>  			return ret;
>  		}
> -		qcom->dm_hs_phy_irq = irq;
> +		qcom->dm_hs_phy_irq[0] = irq;
>  	}
>  
>  	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
> @@ -600,10 +674,10 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
>  			return ret;
>  		}
> -		qcom->ss_phy_irq = irq;
> +		qcom->ss_phy_irq[0] = irq;
>  	}
>  
> -	return 0;
> +	return dwc3_qcom_setup_mp_irq(pdev);;
>  }
>  
>  static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
