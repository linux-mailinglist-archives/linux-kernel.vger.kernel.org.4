Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC4706B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjEQOoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjEQOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:44:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C8359F4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:44:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-965e93f915aso155550066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684334645; x=1686926645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iEhFrj7vz9yOABp0SkbN/pYddQZ33xU58y7pce4fLdo=;
        b=JGjVjH6bHbptB8N6uV4nqUsn5hpfMdmSe5rRrLtgooxNm4omIWiqx90ybtylHqF/iS
         grdgtXyu4J0pJo/MYLvodjvhiqL/pnQ7pgbt+kIQNk/R1+kLsydmRnoyjuWhhtqSdWlJ
         7oU+UpIYLGig3odk8AJaLtnnllljLBC9bFBB3duanaG5TK2rUgzKgA54IzVDQEV7OdQp
         J1aXUISvCfSzF9mU3kHklZJ7klkGLmhUM68QuyM4QbOghum8N/mWkqiTm7HNRxCS5Nov
         EMoLnMqKRfa168gb1lilSET7laE+fgD0Wldj9EGcjV7n2cxdlAKkiEZp3IkdbkBKBIGB
         CIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334645; x=1686926645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEhFrj7vz9yOABp0SkbN/pYddQZ33xU58y7pce4fLdo=;
        b=Kuf9Gy0q0mqAm9Xwi1iRYtzk9UEeuVh+GirOXfxHyMXThB12g7gOK3LO+PyM+qlx6O
         6bj35XCF97XmfWfMkbr3MdJV3JDZSv0KWFxwP68PhN8InB5u6zIEKi+c6jU1pq8+APpi
         qDi6YpXeNk7GbdsrcOTdwmyLiUIHYXEoUdrNfaW7dNThE6HGUn/a7RFVY20MSgIixkOO
         OPO0npOcUbZCoF1Dh41WOJrutxLfuk+f3XqpeJ5rP5+y/PSw8hkxB8uzoqnrckvz4Ekl
         GjJ41bnKpueDcq/326+em7GnHolTLheXZDT0Ftf2ZMQgw2ZmVR9QtSnAOwscqFiQCjfo
         8KWQ==
X-Gm-Message-State: AC+VfDw92kVs38C3c5R8z5tZumvzJr4is7baFkIHVvlosfMQRm2jJpJA
        TI7YlwKSOMvB1dzy2FXNRJsF7A==
X-Google-Smtp-Source: ACHHUZ4dkXnRgNc7bMtacQ5VCgtenN+fiWib2euaz/HKvRvhbvLTDL/znb5ge+1VTYnDjNSAwfsc/g==
X-Received: by 2002:a17:907:72d6:b0:8b1:7de3:cfaa with SMTP id du22-20020a17090772d600b008b17de3cfaamr41028262ejc.3.1684334645199;
        Wed, 17 May 2023 07:44:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id d1-20020a170907272100b0094bb4c75695sm12462099ejl.194.2023.05.17.07.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:44:04 -0700 (PDT)
Message-ID: <cbb32d29-cbbd-7c01-7359-535f6afd701b@linaro.org>
Date:   Wed, 17 May 2023 16:44:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXT] Re: [PATCH v5 0/3] dts: imx8qxp add cdns usb3 port
Content-Language: en-US
To:     Frank Li <frank.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
References: <20230327145523.3121810-1-Frank.Li@nxp.com>
 <20230406014422.GK11367@dragon>
 <AM6PR04MB4838A0B0FABE405800E00741887E9@AM6PR04MB4838.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM6PR04MB4838A0B0FABE405800E00741887E9@AM6PR04MB4838.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 16:25, Frank Li wrote:
>>>
>>> Frank Li (3):
>>>   dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3 glue layer
>>>   arm64: dts: imx8qxp: add cadence usb3 support
>>>   arm64: dts: freescale: imx8qxp-mek: enable cadence usb3
>>
>> Applied two DTS patches, thanks!
> 
> Krzysztof Kozlowski:
> 
> di-bindings missed, Can you pick up this one?

Please send DT bindings to USB maintainer.

Best regards,
Krzysztof

