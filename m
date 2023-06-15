Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0957320E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjFOUXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjFOUXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:23:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F9D2700
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:22:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f122ff663eso11203884e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686860576; x=1689452576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5XF5uBTAtvpA1VpsYCm6GR0NoRPfJg3tqa6HE9KDYc=;
        b=qQeXF0M9mYOpIGCFaQrnDXB6VjUyo5AZ6UnieBJxkirV3cmRJGjiBy5rDQNkwGB3ll
         0EHZfrsRTKeqS8PacfxmGyOzW77SjxLwIWKJetTYltCg+kSB8lDY705/zz3vwM7lYzN9
         WFeXYa9CjORYvg1borCu7hQF8Fb0LXdEndF+b2nRPU0zFEn4LuSVVNOaHKXUTDmlcSFU
         GbMrM2vs6Ys7hPSYXl1uzbecK8XqIqJsDkXEPopL+S4pWh7dQCc344JTSn4cbLF8cjuG
         rIyM75DHZoqJcC0YvX+pnLPwDndEP8XkBaZHu7MyInAJhL0fJo/Njfr8vsQpraPAnFJ3
         7R8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686860576; x=1689452576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5XF5uBTAtvpA1VpsYCm6GR0NoRPfJg3tqa6HE9KDYc=;
        b=TGgkLx8Q8j7ODNs16s75yZrmZtTQ4uVuwucjZX9GWKjBvaj83FSGjViIGKReafT06s
         kndwlp+pNrFT2nuaN4AtCnrvrZKErmoT7k6vRoFrfkuAZ/ekZ8BPJfr54szKWtEKUqVH
         TWmyFmlO6MNG3dpIRr9qA7YxE/ZxbjxV3ptWBOFc3GjSpAHtqRMWG9AO1R919yu87s+1
         llWz4jFUxSmyBMHycJ1UkWVu3p5nbOhAow0ErVhCSqnaUgZvRWy01GJXWETHIkkCIECK
         63YxXyrGjLrIUGY9F/kt8jVbAKVIZgeYeQRmxm8OLhcZxWbSd0Y4ivE5Q/1LDeyTYDSc
         sGlQ==
X-Gm-Message-State: AC+VfDzG6iFEJDZrw3fTuHsAzf4DxxkBUieEzcMLttCcB4IWkXEqXUhW
        xD248s9liKxnQwK6DpBuFgmU3Q==
X-Google-Smtp-Source: ACHHUZ5LK8BVUiva08mB2RInbokbmOiWQwVTxSdEpd/3VaWxCMhhigdcH1ZyVPotOEMA/yQzEu1THQ==
X-Received: by 2002:a05:6512:521:b0:4f3:bbe1:34fc with SMTP id o1-20020a056512052100b004f3bbe134fcmr12330272lfc.38.1686860576556;
        Thu, 15 Jun 2023 13:22:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h22-20020a170906111600b009828bb40444sm1907718eja.51.2023.06.15.13.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 13:22:56 -0700 (PDT)
Message-ID: <e3a83137-d125-4d0f-2eb4-4731159d0c7d@linaro.org>
Date:   Thu, 15 Jun 2023 22:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt: bindings: add bindings for TQMa93xxLA SOM
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc:     Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
References: <20230609132915.634338-1-alexander.stein@ew.tq-group.com>
 <20230609132915.634338-2-alexander.stein@ew.tq-group.com>
 <1bf1890f-d24c-12a1-217d-27579a2464a6@linaro.org>
 <6315067.GXAFRqVoOG@steina-w>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6315067.GXAFRqVoOG@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 16:46, Alexander Stein wrote:
>>> +          TQMa93xxLA and TQMa93xxCA are two series of feature compatible
>>> SOM +          using NXP i.MX93 SOC in 11x11 mm package.
>>> +          TQMa93xxLA is designed to be soldered on different carrier
>>> boards. +          TQMa93xxCA is a compatible variant using board to
>>> board connectors. +          All SOM and CPU variants use the same device
>>> tree hence only one +          compatible is needed. Bootloader disables
>>> all features not present +          in the assembled SOC.
>>> +          MBa93xxCA mainboard can be used as starterkit for the SOM
>>> +          soldered on an adapter board or for the connector variant
>>> +          MBa93xxLA mainboard is a single board computer using the
>>> solderable +          SOM variant
>>> +        items:
>>> +          - enum:
>>> +              - tq,imx93-tqma9352-mba93xxca # TQ-Systems GmbH i.MX93
>>> TQMa93xxCA/LA SOM on MBa93xxCA +              -
>>> tq,imx93-tqma9352-mba93xxla # TQ-Systems GmbH i.MX93 TQMa93xxLA SOM on
>>> MBa93xxLA SBC
>> xx sound like wildcard which you should not use. If you open the product
>> page, it also suggests that.
> 
> xx is a wildcard only for modules TQMa93xx, depending on the soldered SoC, but 
> not for the mainboard MBa93xx.
> You are right that there is the ordering number MBa9352LA-AA, so the 
> compatible would be "tq,imx93-tqma9352-mba9352la". But the actual values for 
> the wildcards is copied from the soldered module. So using a TQMa9351LA would 
> result in MBa9351LA-AA, although the mainboard is identical.

OK

Best regards,
Krzysztof

