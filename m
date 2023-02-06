Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA1A68C770
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjBFURp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBFURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:17:41 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2619C2A14B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:17:13 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hr39so8023103ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Neg/HUC+OyQfjuXkDcdzWDWD5XnWtjRtXlCuK6vz5EY=;
        b=yKtRMYnlGSahsxzylkeLXojQhS6rIafAzEIgyLuj91zy1A3Q+2SMScznAfjNNvOK4R
         VCQef4gK89WX017/EcdGNH+3KR5frBQuEaJZCzW8kq+TS9Y87R5aW273lSjIuEftJUIu
         WRAxPrtV+i8XRVxKFCH14Rx2lmzpndWDCdIE0scsUKi81K7G/ujsFX+xY3hb0iEbRwkY
         cC6nitFA/C3zN2xTUtrm0vFW0pImcaAoGwn0egQ9GYqOuSr9fM/3A/BOS4QXpruTnvl/
         cPeCy8UYI72JDkCm3CIkygrntHCkJycYo6VQaYQeIjn4f7DObOcfcnKg2nA5hMWOa9KK
         SY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Neg/HUC+OyQfjuXkDcdzWDWD5XnWtjRtXlCuK6vz5EY=;
        b=t97nH+EcGSY/+ZIVP2en6/0dsIec7DmmuVAieoc9/jv3K0xhMqcPOIJMo7bYw4TvX2
         AkciMPmA8pxFztbnYXOeHaJoPIfo1iSN1ThNl61ap5MV38irEyV7fAac9zcXeLZcNP0q
         n8brPe96T0IDzQPUJgjagu96/Xez0uXG3u5QQQEpnwfgiW1wCBKXKLs07+HeeC6J9JB8
         XgyOF5EWAp1yR2WTA0DG5ECqNkb+qR1BjVAepZ/zj07zYHpRR2w6+gu2kUSJMqXkD+D8
         0IrxIe1tCmfYIDdZ3M4AEQHsIQEtx3GWqwLFLono3qU6X+oOLmnmItTuzb5jIPyKtjyt
         nWaQ==
X-Gm-Message-State: AO0yUKWGTXqawPAO9ozvawdo44e3xUFEZup9zZ31t6/BAQsQuWycUC5B
        hNwyxRXLW6LJYfDD4Cc36cw/cw==
X-Google-Smtp-Source: AK7set9ZrvV3yEWosfVP26cnBgot2KQjvTmHQZ6myuCZmIq4wr7AGP3uK0/QPLFtje9kfHATn51Q3A==
X-Received: by 2002:a17:906:69c6:b0:881:f614:44ed with SMTP id g6-20020a17090669c600b00881f61444edmr628929ejs.30.1675714631314;
        Mon, 06 Feb 2023 12:17:11 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id lx21-20020a170906af1500b0084f7d38713esm5868777ejb.108.2023.02.06.12.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 12:17:10 -0800 (PST)
Message-ID: <1760bfde-38b0-15e4-5cbf-ee60a15f2d7d@linaro.org>
Date:   Mon, 6 Feb 2023 21:17:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] soc: qcom: pmic_glink: add CONFIG_NET/CONFIG_OF
 dependencies
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230206193804.191343-1-arnd@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230206193804.191343-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.02.2023 20:37, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> QMI is a network protocol, so anything using requires CONFIG_NET
> to be enabled as well:
> 
> WARNING: unmet direct dependencies detected for QCOM_QMI_HELPERS
>   Depends on [n]: NET [=n]
>   Selected by [m]:
>   - QCOM_PDR_HELPERS [=m]
> arm-linux-gnueabi-ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_send_new_lookup':
> qmi_interface.c:(.text+0xf0): undefined reference to `kernel_sendmsg'
> 
> Add the dependency to both QCOM_PDR_HELPERS and QCOM_PMIC_GLINK to make
> it clearly what the dependency is when another PDR user is added.
> 
> pmic_glink also needs CONFIG_OF:
> 
> drivers/soc/qcom/pmic_glink_altmode.c: In function 'pmic_glink_altmode_probe':
> drivers/soc/qcom/pmic_glink_altmode.c:418:33: error: 'struct drm_bridge' has no member named 'of_node'
> 
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Missing sender s-o-b, but I think it's widely known that you're
the same Arnd.. :D

> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 348fde2a8aae..a8f283086a21 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -91,12 +91,15 @@ config QCOM_OCMEM
>  config QCOM_PDR_HELPERS
>  	tristate
>  	select QCOM_QMI_HELPERS
> +	depends on NET
>  
>  config QCOM_PMIC_GLINK
>  	tristate "Qualcomm PMIC GLINK driver"
>  	depends on RPMSG
>  	depends on TYPEC
>  	depends on DRM
> +	depends on NET
> +	depends on OF
>  	select AUXILIARY_BUS
>  	select QCOM_PDR_HELPERS
>  	help
