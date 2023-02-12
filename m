Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606C169383C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBLPvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBLPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:51:19 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6D3EC74
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:51:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so9641052wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=depQKzst3+MJxJVV7OWIsiQvvnYmRLKn2JF0wQ+kH/4=;
        b=qtNux9N6w2LqJiPD83XiWXnyeeF8f3mGCFgxTlELTgluOfDoeUSFEp3CFWhLBrBPDc
         h0yn54rmAh+eBIeRhKaTthywmCpTdNqoAGSCI2F+/AsaDR34JsThiPb31Da5uuFKBDA3
         wjhmzh3RhMtrVKx86szqKtkF4O9QIlwLEtt/hTLpUXhL6BR2KWV8OLTsa13KDJr2oHmL
         tTUoZCGtBX/FQeZO5Gb459VJSQjs3s57GIp2UVwnoYE6i+YUh9HQsSfda5KFRhK83mJT
         Ng6obVVTzHWLo8MPb1+SZfkzttcqm2/4XClkqf8FCxNjbXIUWeIF0d7MJUKZcZr3GMbk
         gM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=depQKzst3+MJxJVV7OWIsiQvvnYmRLKn2JF0wQ+kH/4=;
        b=2zlkxwm+mrooTyovykE6uYb6E3G4CxQTO9Qp8lTZ17aJ04hJpMu7WvBdNRyC+FAz+z
         8mvh6n2Bvl4Dm+2blpSk72LwmXHPXmMfL32221c4YWY4j/vO+xVk4vXxwIG+jRs8PvNI
         sLjcu9/1dWKWgjjPahEt2Kv4sX23lpoeTThYlq+Fh2f6cAPPyCCh6S2FB7MPxQGiR0jA
         bKyZJs+pNs2rmtFUnLqS4zHfNKqPilqiqQqWATMV7S+8667RCuN02hMHn20b8m45SoZX
         XAlG/7+oEB1yDsFo2V5Y2iz8p/HioqBNP7OMm7KDAhErLh+4KEpNbowETcAWXJyT7VgH
         SJuA==
X-Gm-Message-State: AO0yUKVD1f7gWlFeKnvQBHV0h/y8YG9wBBdz1WaoZM5t0iexJFF48Fk+
        /YM7z7iFiLCNsBzUEvlXFFNfwg==
X-Google-Smtp-Source: AK7set86nf562K051uxw7Z5vAZ0oyhgJUCpL2KjCAR+YWTzD5lVhg+njfOSb76saoddca+ZqY/r4jQ==
X-Received: by 2002:a05:600c:4da5:b0:3df:de28:f819 with SMTP id v37-20020a05600c4da500b003dfde28f819mr17248559wmp.15.1676217076063;
        Sun, 12 Feb 2023 07:51:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c170a00b003df241f52e8sm10616623wmn.42.2023.02.12.07.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 07:51:15 -0800 (PST)
Message-ID: <0d1f5d23-7a91-eee9-c7fe-044db8869735@linaro.org>
Date:   Sun, 12 Feb 2023 16:51:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] get_maintainer: add email addresses from dts files
To:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20230211121441.64359-1-krzysztof.kozlowski@linaro.org>
 <6b9347bc16febf724ca33fe99597eb163b4254ff.camel@perches.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6b9347bc16febf724ca33fe99597eb163b4254ff.camel@perches.com>
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

On 11/02/2023 17:27, Joe Perches wrote:
> On Sat, 2023-02-11 at 13:14 +0100, Krzysztof Kozlowski wrote:
>> The DTS/DTSI files represent hardware description for Linux kernel,
>> which is necessary to properly recognize and configure hardware by
>> Linux.  DTS is usually created by people having the actual hardware and
>> having interest in keeping it in good shape.  Such people can provide
>> review (they might have board schematics) and testing.  Unfortunately
>> they mostly do not appear in MAINTAINERS file.  Adding per-DTS entries
>> to MAINTAINERS would quickly make it bloated (hundreds of new per-DTS
>> entries).
>>
>> On the other hand there is no point in CC-ing every Copyright email
>> appearing in files, because it might be outdated.  Add new in-file
>> pattern for storing maintainers dedicated to specific boards:
>>
>>   Maintainer: John Smith <email>
>>
>> Suggested-by: Joe Perches <joe@perches.com>
>> Suggested-by: Shawn Guo <shawnguo@kernel.org>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> This is rework of earlier approach:
>> Link: https://lore.kernel.org/r/20210809080204.8381-1-shawnguo@kernel.org
> 
> Why the rework?  I think the older one is much simpler.
> 
> I believe I forwarded the older one to Andrew Morton awhile back.
> I'll check to see what happened to it.

It was never merged, thus I assumed some changes are needed, e.g. to
ignore emails in copyrights.

Best regards,
Krzysztof

