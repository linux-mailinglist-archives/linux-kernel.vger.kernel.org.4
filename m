Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0730695AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjBNHub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjBNHuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:50:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1351E29E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:50:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso5482526wmo.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djdHAVln+AB2xhAhADB7258N4a54s6i/NOfx5xKCAa0=;
        b=lm1v8G+kaRGHJL1jn1yjFpUJLkhhaJyo45U/hf4zhAr2yisAWhCbUhrHkbqa/x2WJU
         5FPl0jvF659R+HbsBtqWgjgXCz8UUGpUhEbVexSCCNqGspS52NCg0qM+ocr9Yfvuocir
         lUP4OujwvK7JB04WEhjvAwIMETbB7F452KcQKcE//CT6Q3+OqrlBt2/S0ryKMY9xB6Fh
         VUpBhHfXoZIAx7v//iyHGoVl6Yhr3ZXuglptV6ZdGpRZm4u7hd5ARPG/zLV164z3ynr6
         8bVK/PxSzhnuJ1I4cpWnZyL3nEv3l2f2czCWTIyuQSgL2eXCFFp7N0gkUzZO0gzieWDK
         38Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djdHAVln+AB2xhAhADB7258N4a54s6i/NOfx5xKCAa0=;
        b=ts9JOPTnznkH8PWmK/y8i0YnDHBVhGKVMV6tUZsosk/oSOfiCZ7PMiaUTXhQsb2A0D
         tc5/u6O5gxkoaKunodSHjg9Bj+DOYqD/EVsa6pjUXg6qGoZE+QWh1WEI4Hfa2fq2cR7U
         ZIDDOcK5XJyBTL0ef3YSnEQm6FsIxVtWHmMPusneEVgJEHNW3lYBOl6cxB9X3Mdim1kH
         7Y780dVgbtKRU1jCBnAvvd3GCw/9VOTsqO4qPSHJZywUfuAP9tv7sSKp1uOA9mMdxZ7Q
         4CJTtMvgpcdEmpY85sPKhsbhT1OmRd+4sbCiup2d6+Ew0E2Lz+0UfHFX0Ou7odNOGNbZ
         y9Rw==
X-Gm-Message-State: AO0yUKVI+xb73zxXffux4F1BE9UOg4VG82UKFJWMAwrmcTfFirNaP6SW
        LsBu39F7UZWaslcdoSj7V0Q77w==
X-Google-Smtp-Source: AK7set/cuDzzDpUt3VCNgzvRaDkw3gqxacuqi/RcH7fwRcbpfHBoaTriqDu+KDhMGHNgjnVsznfL7Q==
X-Received: by 2002:a05:600c:a293:b0:3df:ee64:4814 with SMTP id hu19-20020a05600ca29300b003dfee644814mr1350022wmb.20.1676361014082;
        Mon, 13 Feb 2023 23:50:14 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003daf7721bb3sm20933827wms.12.2023.02.13.23.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:50:13 -0800 (PST)
Message-ID: <5ff55f1c-8f02-abec-2320-c2e0b7db8904@linaro.org>
Date:   Tue, 14 Feb 2023 08:50:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 01/17] dt-bindings: power: apple,pmgr-pwrstate: Add t8112
 compatible
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-1-cb5442d1c229@jannau.net>
 <3287867a-456c-ddc3-adbf-90001950c926@linaro.org>
 <0a33fa04-039f-9a7e-f2a3-2a1a6abc98d4@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0a33fa04-039f-9a7e-f2a3-2a1a6abc98d4@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 03:24, Hector Martin wrote:
> On 13/02/2023 20.09, Krzysztof Kozlowski wrote:
>> On 12/02/2023 16:41, Janne Grunau wrote:
>>> From: Hector Martin <marcan@marcan.st>
>>>
>>> Add the apple,t8112-pmgr-pwrstate compatible for the Apple M2 SoC.
>>>
>>> This goes after t8103. The sort order logic here is having SoC numeric
>>> code families in release order, and SoCs within each family in release
>>> order:
>>>
>>> - t8xxx (Apple HxxP/G series, "phone"/"tablet" chips)
>>>   - t8103 (Apple H13G/M1)
>>>   - t8112 (Apple H14G/M2)
>>> - t6xxx (Apple HxxJ series, "desktop" chips)
>>>   - t6000 (Apple H13J(S)/M1 Pro)
>>>   - t6001 (Apple H13J(C)/M1 Max)
>>>   - t6002 (Apple H13J(D)/M1 Ultra)
>>>
>>> Note that t600[0-2] share the t6000 compatible where the hardware is
>>> 100% compatible, which is usually the case in this highly related set
>>> of SoCs.
>>>
>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>>
>>
>> Missing SoB.
>>
> 
> I'd rather get an r-b, since this is going back into my tree ;)

Please follow Linux process which requires SoB chain.

Best regards,
Krzysztof

