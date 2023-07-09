Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F6174C2E5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 13:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjGILZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 07:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjGILZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 07:25:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB5A186
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 04:25:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313fb7f0f80so3470448f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 04:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688901946; x=1691493946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOqnqJdkSFGBCWs+9HUmBl/cO9Hejno7qkUg53lGCn8=;
        b=iHihJXDpC3F6WeknN3Zg+Q2tbcDktSNd7223JDuwqkpTry99rZlJaAoM8s2xtpeS9O
         WxwXVSqqJoGHZmoRMNz8YPLZ8CChmY4pwkZW2tfSeVSQzeCBHmltBYErGw+HR/VUO20b
         BrWd7K+0BW0fpJiyYS4aHMWCy19UGOyS8blj7geV60AFYHF+b8rGuBXyl5gh58WO6/JV
         BTxz2YCrQpp9P03uPhbfxGWmUsFbMklN/UAp7QW0Vy1FCiupAFS2VRKW5aGSEpxF2UAZ
         gQv7Grf8w3Fc3lJc9oNYBrDw/MNwqQkfPV5HITOfMrW019nISMRVGcLPZhNQVi54QstP
         wNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688901946; x=1691493946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOqnqJdkSFGBCWs+9HUmBl/cO9Hejno7qkUg53lGCn8=;
        b=iCXksXQ3E9uaAIGvdhz/RuuPaoMfoqJBMAmbELJHEkfWPZfwWBz68VwBjdjKYrSWuz
         kLrCmKOcQcrezMAKjbyXHPgmIBB0dE7C52uJWvmUQffqhzxw3H5LHEIOv/5n/U7Io3Bc
         B3HbF/0DKxHSTLB9UZz79LZnx7Ldy+VT0XGA9XrZ2XMfPZpL7BlO0l+M/thkm8Wc1oIe
         xMS7KKuymLQZYbdiuCEMgKHaCkWN8SSxPURMsj5QiS83L980MGSYZKZPsn1DcWB08igN
         zlzgLtRYE6DJ7u4jSJY0JYU0M0cxcXVGX3zNc4L1MtHFKR86KETQf9zecK8cpTnkELPm
         t53w==
X-Gm-Message-State: ABy/qLYm9CsdJQeZzcEby/QdFPSR88XvQZwZYgI6pvnfwkVK+90KTkSE
        gsNJ/Z83+RJkFsDXL3bbhY9mMA==
X-Google-Smtp-Source: APBJJlGar7krCBHgcD8bHGwUsLIfMuy2lxzK3SA/CO8NdwEhuz7n6VV24cKbuGMmB+FnFcgz/08h/Q==
X-Received: by 2002:a5d:44c7:0:b0:313:f33c:24c4 with SMTP id z7-20020a5d44c7000000b00313f33c24c4mr6024068wrr.39.1688901945587;
        Sun, 09 Jul 2023 04:25:45 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id bl1-20020adfe241000000b003143c9beeaesm8971297wrb.44.2023.07.09.04.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 04:25:45 -0700 (PDT)
Message-ID: <d86f33ab-fc41-1a09-f358-c8917625c282@linaro.org>
Date:   Sun, 9 Jul 2023 12:25:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] usb: typec: qcom-pmic-typec: register drm_bridge
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230709034808.4049383-1-dmitry.baryshkov@linaro.org>
 <20230709034808.4049383-3-dmitry.baryshkov@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230709034808.4049383-3-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2023 04:48, Dmitry Baryshkov wrote:
> The current approach to handling DP on bridge-enabled platforms requires
> a chain of DP bridges up to the USB-C connector. Register a last DRM
> bridge for such chain.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> index a905160dd860..ca832a28176e 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> @@ -17,6 +17,9 @@
>   #include <linux/usb/role.h>
>   #include <linux/usb/tcpm.h>
>   #include <linux/usb/typec_mux.h>
> +
> +#include <drm/drm_bridge.h>
> +
>   #include "qcom_pmic_typec_pdphy.h"
>   #include "qcom_pmic_typec_port.h"
>   
> @@ -33,6 +36,7 @@ struct pmic_typec {
>   	struct pmic_typec_port	*pmic_typec_port;
>   	bool			vbus_enabled;
>   	struct mutex		lock;		/* VBUS state serialization */
> +	struct drm_bridge	bridge;
>   };
>   
>   #define tcpc_to_tcpm(_tcpc_) container_of(_tcpc_, struct pmic_typec, tcpc)
> @@ -146,6 +150,16 @@ static int qcom_pmic_typec_init(struct tcpc_dev *tcpc)
>   	return 0;
>   }
>   
> +static int qcom_pmic_typec_attach(struct drm_bridge *bridge,
> +				     enum drm_bridge_attach_flags flags)
> +{
> +	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
> +}

Should that be -ENODEV instead ?

> +
> +static const struct drm_bridge_funcs qcom_pmic_typec_bridge_funcs = {
> +	.attach = qcom_pmic_typec_attach,
> +};
> +
>   static int qcom_pmic_typec_probe(struct platform_device *pdev)
>   {
>   	struct pmic_typec *tcpm;
> @@ -208,6 +222,17 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>   	mutex_init(&tcpm->lock);
>   	platform_set_drvdata(pdev, tcpm);
>   
> +	tcpm->bridge.funcs = &qcom_pmic_typec_bridge_funcs;
> +#if CONFIG_OF
> +	tcpm->bridge.of_node = of_get_child_by_name(dev->of_node, "connector");
> +#endif
> +	tcpm->bridge.ops = DRM_BRIDGE_OP_HPD;
> +	tcpm->bridge.type = DRM_MODE_CONNECTOR_USB;
> +
> +	ret = devm_drm_bridge_add(dev, &tcpm->bridge);

I think you need to either

Kconfig + depends on DRM

or

#if CONFIG_DRM

https://www.spinics.net/lists/kernel/msg4773470.html

Kconfig for preference

---
bod
