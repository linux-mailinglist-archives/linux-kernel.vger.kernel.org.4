Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA906C1E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjCTRde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjCTRdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:33:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B65F778
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:28:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eh3so49738756edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679333304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9pX5fliZvB4+kznLyF5jnrxrGLHA6LLF6Cnxe9MC48=;
        b=GqJCTFrChfHB40oOYHyfWTI/8mjA/jlE/zJv2f4TVg7YNZfwnzvv5+OqQlEKWGD2dH
         MFsws0t6KPJdr6RDzJ8AgcfM1R9XRK6Hf7sTl4kal7IsFXQrXNYuBeuWJ2m+i9I0d9ir
         IqFKZ7596/Si3uZPOn+jNthM8/5ZiHUUoFRX099OjJpaDMrlUni/vytjBE3Z1mxM7ysQ
         hr0JggP6feSGi461CvyGRSJNaHyoyL1J1e7+LXL25/kqZCLLC0L+BWlHjH0QO+8k9K7y
         A0pA+wQT3ZckDIvpTVRc//WVjUNS9KolF2G+fqR2Y8K6FEmXOXdThdx20VUeJsetNxjs
         0Zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9pX5fliZvB4+kznLyF5jnrxrGLHA6LLF6Cnxe9MC48=;
        b=gk2LyM/8501Pi7++OnJL7t688lMrozwhQruXggGcF51Omwd+I5Uf9YZqqRbEe2uqnh
         KujjR8ANkknWeMvUY9RC2Hqz3yf9DiDeqenJEbuCeLS6OCAzyWiClgiHYV6xYTpbn/3O
         CriRSx0ipP0o2OOlIlxfunsuH+lJCCO7OdI7VdgsusaOWGlLjAyDsNv1DcfwL8jP9Y4m
         TJsci9buGCj1K1JQ8H3bTnJp2/dtSSY10mJrTfFKG4Iw50p78vZIDFTZX9eqwOplkh+u
         FyIX6NADsdChHxl2NlQplE1DjghWY579kwHubO5vRM+UZ6uDOYZ1cAfcUjIYAyV184pb
         elyQ==
X-Gm-Message-State: AO0yUKUxwwkQejd1gRMFVpzQ8MYJyk7dJuBI2uHmaceAcswfAow4PUiJ
        3EKWWVx1qq2xmo8dxY2MeKw4KA==
X-Google-Smtp-Source: AK7set9Ezk9dD+DlISj3bqFA+1PKg/UVKPzOLXXBLPYlp40gPSrFOOXoVyZ40Z991PUXBtmjKSq4Uw==
X-Received: by 2002:a17:906:2853:b0:922:2ba3:2348 with SMTP id s19-20020a170906285300b009222ba32348mr9468015ejc.7.1679333304157;
        Mon, 20 Mar 2023 10:28:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906191500b009339e2e36e4sm2141676eje.81.2023.03.20.10.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:28:23 -0700 (PDT)
Message-ID: <614fa099-e666-03da-1b11-29cc804bf847@linaro.org>
Date:   Mon, 20 Mar 2023 18:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Content-Language: en-US
To:     Frank Li <frank.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
References: <20230316212712.2426542-1-Frank.Li@nxp.com>
 <20230316212712.2426542-2-Frank.Li@nxp.com>
 <e6935c0c-375e-b763-ea91-3b8bbc906ebc@linaro.org>
 <AM6PR04MB4838D1958A029701E1601BA588BD9@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <1fd1fe42-3da6-1598-a04d-cb99a9b4b145@linaro.org>
 <AM6PR04MB483800D7CDCC7AF48F88BF9688809@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <b8801c83-f2dc-f144-de58-03e5c24436fd@linaro.org>
 <AM6PR04MB4838F5C9EF13A588E799D5C488809@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <fc5c76d1-51cd-5992-9bfa-06f57874fc03@linaro.org>
 <AM6PR04MB4838C6B05F46AD94153DDC8388809@AM6PR04MB4838.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM6PR04MB4838C6B05F46AD94153DDC8388809@AM6PR04MB4838.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 18:02, Frank Li wrote:

>>> Although frequency is fixed, clock name may change for difference
>> platform.
>>>
>>>                 assigned-clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_PER>,
>>>                                            <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MISC>,
>>>                                            <&clk IMX_SC_R_USB_2
>> IMX_SC_PM_CLK_MST_BUS>;
>>>                assigned-clock-rates = <125000000>, <12000000>, <250000000>;
>>>
>>> some platform use IMX_SC_R_USB_2, other platform may use
>> IMX_SC_R_USB_3.
>>
>> This I understand, you wrote it above, so nothing new and my concerns
>> are still there.
> 
> I think Fixed value is not good reason. All reg base address, irq number are all for fixed number. The same

No, because one device - IP block - could have different addresses,
depending how it is wired/implemented in given SoC. Also our
representation of devices in the kernel requires regs/interrupts coming
from DTS, thus DTS is also answer to entire design of kernel and other SW.

That's not the case here at all.

> Logic can be applied to irq-provider driver. But why still be descript in dts? It is hardware property.    
> 
> https://elixir.bootlin.com/linux/v4.8/source/Documentation/devicetree/bindings/clock/clock-bindings.txt
> have not said that can't set to fixed clock frequency. 

I don't understand this.

> 
> This is quick common case for network, USB, SATA, PCIE,  which protocol defined
> Frequency.  

And they do not define fixed values in the bindings, so? There are
exceptions, but it's usually not argument, right?

> 
> https://elixir.bootlin.com/linux/v6.3-rc3/source/Documentation/devicetree/bindings/ata/qcom-sata.txt
> https://elixir.bootlin.com/linux/v6.3-rc3/source/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml

The second is a good example - as you can see, there is a choice of
values, so they are not exactly fixed.

> 
> Such frequency information is necessary.  We can put to dts or clock drivers.  The clock driver

If this is the argument, then the answer is NAK. Sorry, but DTS is not
for offloading fixed stuff just because you do not want to work on
drivers. The same for discoverable stuff.

> Become bigger, or dts become bigger.  I think the key point is if property to descript hardware information.  

You have to understand that with your binding you are not allowing to
any changes of these frequencies.

Best regards,
Krzysztof

