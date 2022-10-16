Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD445FFF47
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJPMr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJPMr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:47:56 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8263DBEF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 05:47:54 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id o65so7217532iof.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9XmLyyTmf4X7HoL/z+TJG+pHrpmv/0YTKYU2U+M3/I=;
        b=rrBehKH/4qq81g0meoJXpOdvkEYZr4ibBDA+Egi35y8JBz0EwfFxiIP0Y+nsdDMT2c
         76Bhn/Q9JI5jpk35/xu7MWMzp0BfkJH/LgiQ5+xVedNbtQckjutq+UcrBHeJEZWt1aAY
         6AzYrB8i7zf4OPTh8V2Z1ootH8pncWs68osVT6h88uqAqi5/EkqsgQJOclDBWAgs+JCT
         GgMG7b94IjNas8/rXXo3Tdlf2RI4NjAlVeAzpzo1dAU/XX11QRMObjQYmJiWIMAG/Yr8
         hp/H4Zej2rffviAw1m4gJDXYq8cZtKqA5r7G1J+Bnlcw2pggEryF7YZWoB4W1Ltz8bpN
         Sw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9XmLyyTmf4X7HoL/z+TJG+pHrpmv/0YTKYU2U+M3/I=;
        b=S7SfwBTaZD27foubkkOjJ3srJ/n8zvP/YsvcUAw/yu2N9xtZgE9/DV6KzJEYLpIkJT
         wTJZBbLMGtIzEjHMsB/sUbsJYXUFOAJK3uCyraz95VwP81XEBsN34nbN2pytbC2P8cXB
         F2Qcj0ZCBNgJamGUxkKNl5ZV6akvP4Sqi27qaGxgw7hYcwntzuWzKoEXkuTNW332vWQ1
         Ob+ItPMOBB0uLzBpTcssBv9UranddQeWillUqm/eXAww7eGvahUPDWrFxayUDzxDDJSf
         D2sPSUqydoE6obPJ6URiYOL3QdIQykDKLtOeuN2qYLWBmtosSPeEUG6PQIQbLuMNPhOs
         tKyg==
X-Gm-Message-State: ACrzQf2rHvU1I5WxoeXOST4U5q/awqf4pUZfH0UzX3kfWjYNUiILs37k
        4ZVADRZSaxnHp+E/oDvOVzcpcA==
X-Google-Smtp-Source: AMsMyM7CNajkShuH3uv9CfNiOpocRNtK9NZNK0NbARF877QL4nwKKE9B85Y6nJVfkn2L8xXncqP7uA==
X-Received: by 2002:a05:6638:3044:b0:35b:ac10:53be with SMTP id u4-20020a056638304400b0035bac1053bemr3148891jak.17.1665924473632;
        Sun, 16 Oct 2022 05:47:53 -0700 (PDT)
Received: from [172.22.22.26] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id t8-20020a056602140800b006bbfb3856d6sm3122759iov.5.2022.10.16.05.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 05:47:52 -0700 (PDT)
Message-ID: <3a85899c-522c-1a0e-14db-ddc02a985e2c@linaro.org>
Date:   Sun, 16 Oct 2022 07:47:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5.10] arm64: dts: qcom: sc7180-trogdor: Fixup modem memory
 region
To:     Stephen Boyd <swboyd@chromium.org>, stable@vger.kernel.org
Cc:     Sibi Sankar <sibis@codeaurora.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20221014215302.3905135-1-swboyd@chromium.org>
Content-Language: en-US
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20221014215302.3905135-1-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 4:53 PM, Stephen Boyd wrote:
> From: Sibi Sankar <sibis@codeaurora.org>
> 
> commit ef9a5d188d663753e73a3c8e8910ceab8e9305c4 upstream.

When you re-send you can add this if you like:

Acked-by: Alex Elder <elder@linaro.org>

> The modem firmware memory requirements vary between 32M/140M on
> no-lte/lte skus respectively, so fixup the modem memory region
> to reflect the requirements.
> 
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Link: https://lore.kernel.org/r/1602786476-27833-1-git-send-email-sibis@codeaurora.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> This fixes boot of the modem on trogdor boards with the DTS from 5.10.y
> stable tree. Without this patch I run into memory assignment errors and
> then the modem fails to boot.
> 
>   arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi | 4 ++++
>   arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi         | 2 +-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> index 44956e3165a1..469aad4e5948 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> @@ -9,6 +9,10 @@ &ap_sar_sensor {
>   	label = "proximity-wifi-lte";
>   };
>   
> +&mpss_mem {
> +	reg = <0x0 0x86000000 0x0 0x8c00000>;
> +};
> +
>   &remoteproc_mpss {
>   	firmware-name = "qcom/sc7180-trogdor/modem/mba.mbn",
>   			"qcom/sc7180-trogdor/modem/qdsp6sw.mbn";
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 5b2a616c6257..cb2c47f13a8a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -39,7 +39,7 @@ atf_mem: memory@80b00000 {
>   		};
>   
>   		mpss_mem: memory@86000000 {
> -			reg = <0x0 0x86000000 0x0 0x8c00000>;
> +			reg = <0x0 0x86000000 0x0 0x2000000>;
>   			no-map;
>   		};
>   
> 
> base-commit: 014862eecf03f58066a957027dde73cbecdf4395

