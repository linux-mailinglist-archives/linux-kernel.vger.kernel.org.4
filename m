Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D1874D2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjGJKGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjGJKGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:06:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A18F272E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:02:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3143b88faebso4926039f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688983369; x=1691575369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20KbYQWdhkCDzpQr4voFHT+n6tNbr1oLovVT0vSfkS8=;
        b=Q9MX9V1veRONICxs4YWCbJDkemA1Xyiu1ECMidNKt8VxjryhAv9XBj3RZC2NpqvKXz
         Fj5NXgT9Wojo5d14wMdLjvnciDlvRjQoLO1Xymep01VH5s9oAhliqOaDeRNg7c0wSCvj
         BmdpYJHHbn4UgOJswPUk0JkKTPKTGRCjaaj1qioI+3AkRv+apvLhIMRlhivPiaBasAM5
         JWtFDt2/DI3ePZeoffQ0rYLt4R7HSVeJ+7VFYKHYTdkZaLw3uh+Z4xiLq58uTnveU00U
         6z8MJkMOUQ+N4K0jG2q6qIkYhZl9IVl7GvdAwEqh6sywfS5EfDxwse95EsYOMXDWGk/s
         IzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688983369; x=1691575369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20KbYQWdhkCDzpQr4voFHT+n6tNbr1oLovVT0vSfkS8=;
        b=cFgXwDyzmfa0/0fwyj0tYHPFP/D1V8ohKEwY6KiEo01E+jjokPdF0VdvrCpe+enQ+A
         tmj2CAkg4HlowRE8/zH0BRJPyIjhnJSa5B2mCGiW1GgSEcSBdmOIIvpt4mQldysEsN8m
         QMFc91cMctCtc0Ox960tjHE0fMN7a6+2SejmYaxNShykzOjrNtC3s482k36A0UUz4Gxm
         Bc4AzA90Hgy9QuGX4o+m1906JdIb6qkkopS+DSb5J7nMC42plxOCZgm2XJ5aqKDgGmdo
         x9QZM9E8PGn9FX0eKK9OeQmTxhus46cHnYLky5ThoL0YR3/Ed6W7bp46OHA8o7RBEOl7
         7wGw==
X-Gm-Message-State: ABy/qLYyZcpp6nrjhfFlJzg8en9qPvcL+vfKQr1uY20Q7RNIUpMVh5UQ
        Kc3dckFwbLjAMjMtyNoaFZT7sQ==
X-Google-Smtp-Source: APBJJlHfKN4tuztVgNNB8KDAcIN7UWR5lLjZWIL4doUISwx2JaHs9R9cllzBwgQUuZ9iBq0CNGd/FQ==
X-Received: by 2002:a5d:504e:0:b0:314:53b6:7f84 with SMTP id h14-20020a5d504e000000b0031453b67f84mr11792304wrt.54.1688983369656;
        Mon, 10 Jul 2023 03:02:49 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d420f000000b00314145e6d61sm11304152wrq.6.2023.07.10.03.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 03:02:49 -0700 (PDT)
Message-ID: <0408a6f6-356e-af6a-3e32-1781aec2854f@linaro.org>
Date:   Mon, 10 Jul 2023 11:02:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] usb: typec: qcom-pmic-typec: register drm_bridge
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
References: <20230709201309.274306-1-dmitry.baryshkov@linaro.org>
 <20230709201309.274306-3-dmitry.baryshkov@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230709201309.274306-3-dmitry.baryshkov@linaro.org>
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

On 09/07/2023 21:13, Dmitry Baryshkov wrote:
> The current approach to handling DP on bridge-enabled platforms requires
> a chain of DP bridges up to the USB-C connector. Register a last DRM
> bridge for such chain.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/usb/typec/tcpm/Kconfig                |  1 +
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 39 +++++++++++++++++++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index 5d393f520fc2..0b2993fef564 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -79,6 +79,7 @@ config TYPEC_WCOVE
>   config TYPEC_QCOM_PMIC
>   	tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
>   	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on DRM || DRM=n
>   	help
>   	  A Type-C port and Power Delivery driver which aggregates two
>   	  discrete pieces of silicon in the PM8150b PMIC block: the
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> index a905160dd860..0722fb8d75c4 100644
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
> @@ -33,6 +36,9 @@ struct pmic_typec {
>   	struct pmic_typec_port	*pmic_typec_port;
>   	bool			vbus_enabled;
>   	struct mutex		lock;		/* VBUS state serialization */
> +#ifdef CONFIG_DRM
> +	struct drm_bridge	bridge;
> +#endif

IMO there's no reason to ifdef the structure. Its up to you if you want 
to change it nor not, I have no strong feelings about it.

Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod
