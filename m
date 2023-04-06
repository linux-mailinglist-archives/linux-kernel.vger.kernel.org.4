Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8856D9F62
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbjDFSAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDFSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:00:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586A746B3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:00:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lj25so3367790ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680804009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Xne4lIPjlc/fTh61AeKasmY2sOq4ClDJX9BFxZXN+E=;
        b=IdmDahkrTwo+nifjZPEpz7e5zvlQ7bHgdpvqJC9bYCw9ZujTt2u0BfYuFV862T4CW5
         SBynKw5uQb5mwQe0JX5lB1Bv6vyWcVzG3OPZf0+yvvKFKDoji1ZM/lN6RIa19QSg3ewj
         dzW8LBa6T7Iyjs/nlCdaj6ZHgXXROs24+T5WIAj3fT7/eKMYauximglQT1KQU0UOpdhI
         9JrpJvflV3H3dqxV7PJGPdxrqdJ4KYW07UqJPo/eY8bNKmxuwplGbIk1ZKqFTtLZW0v5
         wtST7FBCKaUi/KzlCpOItXC2TTAUB1Zq1b24UbxSJ6Udd7Cr0biEWm1xxffjXPwBGubi
         e5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680804009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xne4lIPjlc/fTh61AeKasmY2sOq4ClDJX9BFxZXN+E=;
        b=766JPUazyX1dSAaKo2Emh+BdgLjC/m4IbiGWOfuw/IC69d4FOjQHmdbh7Nh//eIqhN
         GIo1t6VMa0gT9lod/pZg0a3D6ksF/PVNhS9KtAffIRzUxcgUdVCeNNYJCLoq4/wsRocH
         3INajkySsxX4FaLYHyalYW+/VTIwqNX7NSAmHdSUDEYUTGqYsXTzO8Je2T+GFKJYW9aU
         MHduad+5hMWH43IQvX2Wjv8Q4qfFFDg20BrrBeT3fwRv6x2MkF6F3YTdS/UadRmL3iAw
         ZkT8NIyJokedy/aAtcdgk2tH90omgj2P22UMrFgJVvGWwvSdNMlEVaJYZ3PCXuRaUK+e
         pMIQ==
X-Gm-Message-State: AAQBX9fJcYdGZDdl9MbLlfD6b8Fz/BDl1iFX20nrDgYLP6G/9JP+HEIm
        MT57PHwOJ3ckoY9VW5FOpDh7GA==
X-Google-Smtp-Source: AKy350asbxrZB74TExOJyPQOGm7zEWKMo9EeGOdcZrR92f4xLUCHZp4F607ZDh+AjW+gT1VXJSc9rQ==
X-Received: by 2002:a17:907:6d99:b0:926:8f9:735c with SMTP id sb25-20020a1709076d9900b0092608f9735cmr6678777ejc.32.1680804008791;
        Thu, 06 Apr 2023 11:00:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id hg18-20020a1709072cd200b0092a59ee224csm1082209ejc.185.2023.04.06.11.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:00:08 -0700 (PDT)
Message-ID: <f6c8586f-a5d1-875f-b2c0-7871112cf1b1@linaro.org>
Date:   Thu, 6 Apr 2023 20:00:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 3/3] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel <kernel@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230406154900.6423-1-cniedermaier@dh-electronics.com>
 <20230406154900.6423-3-cniedermaier@dh-electronics.com>
 <5478133e-7772-1db9-3473-1ec86fa2aae2@linaro.org>
 <a7fcfe695623491da96639079eb14c8f@dh-electronics.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a7fcfe695623491da96639079eb14c8f@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 19:54, Christoph Niedermaier wrote:

>>> +++ b/arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts
>>> @@ -0,0 +1,361 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>>> +/*
>>> + * Copyright (C) 2023 DH electronics GmbH
>>> + * Copyright (C) 2023 Marantec electronics GmbH
>>> + *
>>> + * DHCOM iMX6ULL variant:
>>> + * DHCR-iMX6ULL-C080-R051-SPI-WBT-I-01LG
>>> + * DHCOR PCB number: 578-200 or newer
>>> + * maveo box PCB number: 525-200 or newer
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "imx6ull-dhcor-som.dtsi"
>>> +
>>> +/ {
>>> +     model = "DH electronics i.MX6ULL DHCOR on maveo box";
>>> +     compatible = "marantec,imx6ull-dhcor-maveo-box", "dh,imx6ull-dhcor-som",
>>> +                  "fsl,imx6ull";
>>> +
>>> +     aliases {
>>> +             /delete-property/ mmc0; /* Avoid double definitions */
>>
>> I don't understand it. What is "double definition" of aliases?
> 
> Otherwise I end up like this:
> mmc0 = &usdhc1;
> mmc1 = &usdhc2;
> mmc2 = &usdhc2;
> 
> Is "Ensure unique allocation" a better comment here?
> 
>>
>>> +             /delete-property/ mmc1;
>>> +             mmc2 = &usdhc2; /* eMMC should be mmc2 */
>>
>> Why? How is this labeled on the board (physically or on schematics)? If
>> you answer here "for booting", then the answer is NAK. Don't add
>> software policies to Devicetree.
> 
> The name in the schematics is "SD2".

Answering also to above - then likely the aliases should be dropped from
SoM. I doubt that Som calls it SD1 and your board SD2...

Best regards,
Krzysztof

