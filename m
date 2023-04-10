Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344596DC87B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjDJP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjDJP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:28:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701F82710
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:28:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50489c9f455so1458333a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681140485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dp13ZHGUFanjepGsifd/KgUECg6uDvRrmxkBGZs93ug=;
        b=VJDgviaMgKA3WIpiIopy0BNdVrW+3/ww0KHaAljUohETxtWQUCSFZb1cHqeaqpKy0z
         Wea0lQhBKouVYM+J6uYUWzWhtHENKj0YR/ocF1/tNlDjJq8yrbXQJevk6wefACZwDVpQ
         n4J6ulXKFAEpz+lHRUNR5s5zqkuNx36KsvGfIJ1zvyPs7/vRN8+Xh/Ewge7GZ6Soootg
         OrrvtUxIZcxoSc3SCxLePkEKXM+E5pFwsyujuj+VXxKo8hBdh1aCsdzhVf05IZYLZohA
         l8HC2qMudBZ+lAhlEgd7dFnyQWbYAFuhQ6IX+oS/V3nDl2RytFZdwVeSRDPKiP1GYMge
         dGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681140485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dp13ZHGUFanjepGsifd/KgUECg6uDvRrmxkBGZs93ug=;
        b=4G76x91kXWQVDTSodLjkq0voHJTc/W7FQ+CZxwUSbebd/+25SVr0wGGrnk6GcssHFF
         6kMLKlKY7nzFXxVCV2GJqZLFRmjJbbUbSyBXp14tHwEXzy050NIs+HyqFX8qXVt/i4mA
         dy1EOt0P8Y/B7SFvtS/GZHhIzTLCMMY/WJMTvN86caFjf9KiP/pJw2rTDRDpbd78uPj/
         qP/pHq/C04MDotA0t1dsEOL1kxBlsN/LOcMEGGm2tYy254SqW4ezd167dQD0hbpBpgbv
         5EA3QSfiTf29b0j3wx8lccCI0lalnBmXsJL3elM8/LjQsPZbxZROk3RzKf99IJfJ/Dks
         gxbg==
X-Gm-Message-State: AAQBX9emYEbGnTq6GEl87kjtEx33pqiA9LMqK6Ubpl3l/kKyKCaWRaxp
        GGWoQqYVxh4of+j76wePCiF5mg==
X-Google-Smtp-Source: AKy350Yzxb3H/nJQGY9DSwrE1vKzTLF7o5ExyyL2MkfT1MrNbQ82m28DtEf2sVPQXfo6WzU/8AQqWg==
X-Received: by 2002:aa7:c510:0:b0:4fa:733f:8abb with SMTP id o16-20020aa7c510000000b004fa733f8abbmr11099308edq.32.1681140484930;
        Mon, 10 Apr 2023 08:28:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:eacd:ffa4:1df7:3870? ([2a02:810d:15c0:828:eacd:ffa4:1df7:3870])
        by smtp.gmail.com with ESMTPSA id z11-20020a05640235cb00b004fa380a14e7sm4805063edc.77.2023.04.10.08.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 08:28:04 -0700 (PDT)
Message-ID: <6af9effe-89c0-7630-9a72-a5a6351e0a95@linaro.org>
Date:   Mon, 10 Apr 2023 17:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Content-Language: en-US
To:     "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Marcin Wierzbicki -X (mawierzb - GLOBALLOGIC INC at Cisco)" 
        <mawierzb@cisco.com>, Rob Herring <robh+dt@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
 <20230407160413.GD1391488@zorba>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230407160413.GD1391488@zorba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 18:04, Daniel Walker (danielwa) wrote:
> On Thu, Apr 06, 2023 at 09:12:34AM +0200, Krzysztof Kozlowski wrote:
>>> @@ -0,0 +1,27 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>
>> Dual license.
>>
> 
> What are my choices here? I see this,
> 
> # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

Yes, the one suggested by the checkpatch. Did you run it?

> 
> Which appears to be what your suggesting. I also see this,
> 
> # SPDX-License-Identifier: GPL-2.0
> 
> I'd rather use the later.

Why? Bindings should be licensed under BSD, so what is the reason to
make here exception?

Best regards,
Krzysztof

