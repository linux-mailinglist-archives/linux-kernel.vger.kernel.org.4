Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36F364EAA8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiLPLc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiLPLbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:31:49 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B67C1408E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:31:48 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b13so3061122lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OO6jJw/yAEdPz9o4xXjIQOgJbUx/2Cm9X3PBVoUd2KU=;
        b=NfdqW5nlqV/FRVeYEh4ZsOJX3jRu3qAUwUun87NlEKYcTsUAp/YyxnYZnrVGfAtMJm
         7Vyui7n2GZEsagZJaWz2B7S8tiOHNq+7wEJNpQ4Eff8ErZzIDGBSdgASrsOSChqXzroJ
         CiO5VGgd/XErJ7AAKnsHzVxqMNUXTJS8wtdv6sdUA4DflULgbTRxI46WzjGsGoBknBRA
         tOcHQLD+O4hNSOABPkuaNO07jMCcUG3UrpKoKQwk6MjcRp4b1ausheTxMi3VA5BfsMFq
         8DnWTJxmDm0J6tjNSHT074j05a61iivLoC46q78/Hgm8PbSRU8OdNjxdJXsTOnX20h4W
         RbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OO6jJw/yAEdPz9o4xXjIQOgJbUx/2Cm9X3PBVoUd2KU=;
        b=JDosmdwNsZ1FZ1QGL2HrOar6kEXrLAko4yWb3dMlAfxBYgtMle1s/r+n8XD5ID1qem
         vjVsJrePwCsNlkwfYfBCORy92l2iAO0o2pQAD6q78OtY1+h6MqBLmdXuVp/vzMtRQ3V3
         4yw7FRlfNA08Ek3vdBJODalLLkXeagYVWoiKJRVNAKQ6YG/aWUAI5zGJkELcYxQBPd3S
         nb6kLsr1Zkrb4nbkAAjFhAB76Q48fe8V0NWsOno2MrA5/INm3PUlrRHvbidUkNHgN5YP
         Vz0pvCFzh0p25JUfuLbD4DjW7Fn7Qmh0EdUQjO6oMPAfZTaktXtaHt1zjnOgwMiL8MAK
         HHsw==
X-Gm-Message-State: ANoB5plrpLHGas+5Hr+x2PMMu9mElsN27dagdejaIpfd1+PW1y/mxZnD
        hkhxkbk0RLjlO2ZTpYCNs5lsCw==
X-Google-Smtp-Source: AA0mqf40uAdhtuFR2m8/f8fRtCtSwAQ0zUp3UzgeJbOv96oZQhiT2UKUhS0LaFR7wc7GavDpoPAKsg==
X-Received: by 2002:a05:6512:31d2:b0:4b6:e64c:aebf with SMTP id j18-20020a05651231d200b004b6e64caebfmr8236317lfe.51.1671190306451;
        Fri, 16 Dec 2022 03:31:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o22-20020ac24e96000000b004a25468d86asm196865lfr.68.2022.12.16.03.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:31:46 -0800 (PST)
Message-ID: <752fd23f-e366-70d6-3ae5-28f49d56ef15@linaro.org>
Date:   Fri, 16 Dec 2022 12:31:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add Beacon EmbeddedWorks i.MX8M
 Plus kit
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215233719.404581-1-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221215233719.404581-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 00:37, Adam Ford wrote:
> Add DT compatible string for a Beacon EmbeddedWorks development
> kit based on the i.MX8M Plus from NXP.

Subject: missing prefix "fsl:"

> 
> Signed-off-by: Adam Ford <aford173@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

