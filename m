Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CCB725DBB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjFGLzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240493AbjFGLyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:54:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161401BE8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:54:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9745d99cfccso1016915666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686138884; x=1688730884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMpYnd8K0KUjk943ETGb3pgLuWnp+NjqkKVfYBnfUjc=;
        b=TvREFw8JmP7lNGG8Jt6YNMWuPvV8RkGsW/J3WtZVYPljX9xDYCUe1KvYqrloXDZ5+J
         rsISilWx+sBnTrlQQI7B3UyBlAwoNC0AljGFxfFqge5LFrrLhoqKZlWTvylcV/HJoqZy
         1AtYnLkmzL1jEPoMHO7GNxWepy7jWb+1ChIQPxo0CfxWGavPiD9SsJGgawHgPqsSKFdE
         s+wxuEo5vqLIbBpiVEAfxtsUlsXlcsUqKJG871Jl5HOfZ6Whb/3o9dKKZ/fhrTDce4gZ
         GLQxUtPXsDfC0SgOnEKr7SEs9nigRj5vV6g2xXbxY14S8icYwYvSuoptjzI7E7Vu32B+
         WDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686138884; x=1688730884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMpYnd8K0KUjk943ETGb3pgLuWnp+NjqkKVfYBnfUjc=;
        b=Jh1u/QkylToAjUSH/cOPVzV2Ni5HXZvsypcvn5n/OrhH0XwetRLHW2RIqvhLDJSHjF
         zgT+ZtFGJiB8EI+EF/ux1dIjlw5ZYaXq/wC6wu5eUrnIOGwbpgbe7CS6wyjn/KfXywLq
         mvXkEsvWXPY7ObxXJrADQXwDElBk1fddBKikEo3lsVzo4oEX0VaIEMDY18C8Mb3zIhY1
         0WYzcMQKPVA2xMPwW/Qjk8AZcZRbm4eFY2dRxDfYfbtGuI7AR4nJOwRWumlc9cm9/KSR
         JZWQdDBZ5qJgH9RZKSlqDohtddsjSs96VMxtD+WvyGAyblib5i8L9JSVpUfq7NK96Wdh
         qdFw==
X-Gm-Message-State: AC+VfDxSw/lVzxblMBl+tA93hTGI0eQ/C+tE11uuLIb9ZCJSNSPbtluP
        6lFV+uPqRJ9ZWXUBDNrx4Adedw==
X-Google-Smtp-Source: ACHHUZ4lsNW7UB/AdIJhmQsRv/ujZHWy36LNehPBHbmBvk72viOS7FuDtFy6IDKDYzT1blLCXBb+VA==
X-Received: by 2002:a17:906:6a1c:b0:96f:88a3:3a0e with SMTP id qw28-20020a1709066a1c00b0096f88a33a0emr6274061ejc.0.1686138884458;
        Wed, 07 Jun 2023 04:54:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id oz17-20020a170906cd1100b009745edfb7cbsm6802817ejb.45.2023.06.07.04.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 04:54:44 -0700 (PDT)
Message-ID: <79201bd6-6048-7013-aeb7-34d218139844@linaro.org>
Date:   Wed, 7 Jun 2023 13:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/5] phy: realtek: usb: Add driver for the Realtek SoC
 USB 2.0 PHY
Content-Language: en-US
To:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-2-stanley_chang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607062500.24669-2-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 08:24, Stanley Chang wrote:
> Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
> controller. Added the driver to drive the USB 2.0 PHY transceivers.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v2 to v3 change:
>     1. Broken down into two patches, one for each of USB 2 & 3 PHY.
>     2. Removed parameter v1 support for simplification.
>     3. Use remove_new for driver remove callback.


...

> +	platform_set_drvdata(pdev, rtk_phy);
> +
> +	generic_phy = devm_phy_create(rtk_phy->dev, NULL, &ops);
> +	if (IS_ERR(generic_phy))
> +		return PTR_ERR(generic_phy);
> +
> +	phy_set_drvdata(generic_phy, rtk_phy);
> +
> +	phy_provider = devm_of_phy_provider_register(rtk_phy->dev,
> +				    of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);
> +
> +	ret = usb_add_phy_dev(&rtk_phy->phy);
> +	if (ret)
> +		goto err;
> +
> +	create_debug_files(rtk_phy);
> +
> +err:
> +	dev_dbg(dev, "Probe RTK USB 2.0 PHY (ret=%d)\n", ret);

I commented on your second patch, but everything is applicable here as
well. You have many useless debug messages. Many incorrect or useless
"if() return" which point to broken driver design (e.g. concurrent
access to half initialized structures where you substitute lack of
synchronization with incorrect "if() return"). Undocumented user
interface is one more big trouble.

I doubt you run checkpatch on this (be sure to run it with --strict and
fix almost everything).


Best regards,
Krzysztof

