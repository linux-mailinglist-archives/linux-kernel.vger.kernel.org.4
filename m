Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35EC68B117
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 18:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBERUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 12:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBERUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 12:20:22 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346CF199D6;
        Sun,  5 Feb 2023 09:20:21 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id mc11so28131709ejb.10;
        Sun, 05 Feb 2023 09:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHKHtHmdBvu9gCl5Uypjbx8NwWDCD3db/bpuwxrPVv4=;
        b=GHMCUB6xoF6V29LH64z7vIPbEOj4/sYrr0E0HBhRBIfxFIa2/ba09BUwMP2pBnVFHs
         alfQLoKysiFg3FZbOn3+yEoDydxHxbZFwfNPdpP4di9i71aw9cgkctY0CCufjCD7TkWr
         Y+7nZY/di4GF5hUBMGkakkC2QuchUcUKfeU/GgjsxcU4MbgYXLn0+vo5nOqdzq8J2YB2
         In1jIn9fjrye6rxJ5YzSYuYkFNAU5u8a8avkukntCS3OI4huWm485L04sgJuuFSOohpj
         D4CRo20juU2z+PKBb+A/sb5gzm0jmtfQ5jlYiJLisUd3UxF5UtNFZc5bzc06HfC5+edh
         Sl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHKHtHmdBvu9gCl5Uypjbx8NwWDCD3db/bpuwxrPVv4=;
        b=oOxuuuVvwMjxuBpudfKwcBh2uz1bacRB2X0Gt8N4oU1InTxI69gzCFiy/6FkjrfOgw
         U+t7TUEVwSqBoEAY7JFYU9I3Mwk87e5XuWt/d91wrsqRSP6CQ7k+01J+hRVG777EnnER
         Ba1D3haem4LsB9AV2mvEqtRVBP6ayEOVGzfj4MoWXRMTyJZuSRRh4CXmLNPawOrFfo3U
         KMLgkL4qB7STu4PxYU+4BrspfqZl42nmX9aBOCR0+X3m/l7bhZ715AA5jzgytX+vx1kb
         5f0biiyASX+Kd/CxyvlhK4TdEcP6q5gxq4ZLdRog43QuO6GgO+5FncSTefLeSO/MpBbq
         wwhg==
X-Gm-Message-State: AO0yUKXUwCLGy68acxvOBYIIVKXAX2CQRtbY1cE3y+aGXCatJBYMcYWI
        bqiGUXUn9BLeorkXQH/WVMU=
X-Google-Smtp-Source: AK7set/17iI3CDHKuvSWSXOBFIuJXIdIz2dQjNgoERzWWImV2UhbkRts9m9wGr/M5ENsi2QXfdG1Aw==
X-Received: by 2002:a17:906:d7a7:b0:87b:d3e3:c23 with SMTP id pk7-20020a170906d7a700b0087bd3e30c23mr19288755ejb.54.1675617619672;
        Sun, 05 Feb 2023 09:20:19 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090611cd00b0088bd62b1cbbsm4302321eja.192.2023.02.05.09.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 09:20:19 -0800 (PST)
Message-ID: <0de7b28e-1c12-2546-2747-d8932678f9dd@gmail.com>
Date:   Sun, 5 Feb 2023 18:20:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/8] dt-bindings: pinctrl: rockchip,pinctrl: mark gpio
 sub nodes of pinctrl as deprecated
To:     heiko@sntech.de
Cc:     Linus Walleij <linus.walleij@linaro.org>, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, john@metanate.com,
        quentin.schulz@theobroma-systems.com
References: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
 <137b56f0-8e86-f705-4ba7-d5dfe3c0b477@gmail.com>
 <CACRpkdYYB4-qhgbN3D8-Yjs9QVcj1oCZZHTVJXsyXgC=p-e=NA@mail.gmail.com>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <CACRpkdYYB4-qhgbN3D8-Yjs9QVcj1oCZZHTVJXsyXgC=p-e=NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/23 14:45, Linus Walleij wrote:
> On Sat, Jan 21, 2023 at 12:08 PM Johan Jonker <jbx6244@gmail.com> wrote:
> 
>> Mark gpio sub nodes of pinctrl as deprecated.
>> Gpio nodes are now placed in the root of the device tree.
>> The relation to pinctrl is now described with the
>> "gpio-ranges" property.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 

> Do you want me to simply merge this patch to the pinctrl tree?

Hi Heiko,

Any last minute feedback possible?
If this patch suits then maybe give a ack for Linus?

Johan 

> 
> Yours,
> Linus Walleij
