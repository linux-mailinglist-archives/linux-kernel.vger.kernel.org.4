Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2343F6D65A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjDDOnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjDDOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:43:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35734481
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:43:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v1so33085486wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680619388;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ad6h00Bx8GcKvck9bd01LkivTMFfzeKAoZr2DuRzZuA=;
        b=YeDuuIfA00m/SVTJZt2sK031PCR9Cqj0FtcGK4nbxlIe3o3QA9GFmxs/v/H0Ac988T
         2F2mIHDrEEy4B+S+TJ46ZVZIDMOUfekOcTI+vhfhF9hM3r54E0WUhyghB0Ji7VR0W1LJ
         wU0t6+WVfS+2kzdcdCxytjoUNKCA+ijsWzkRVExLs9Vv6+YCHH9LpaZt1BxOvcBZWdgZ
         N9BkFzq1CAGRBE101KY9uf0jywL5fYp4LHcMo7Op+yhLlkkyldgQSw6v46szCeKyJx3F
         +jUua4LZ728+8/bW+ZIKBvip3PcN8/Uq4lvAWvWwToQYMD13rwGfK+uoZUBWQ/KZZNM6
         xu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680619388;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ad6h00Bx8GcKvck9bd01LkivTMFfzeKAoZr2DuRzZuA=;
        b=tpNVZaBT9f58wORPT0N3usxAHqqwySXMW3GJ73qQb/oHtB3k0kDTctZNknpafwUYz4
         7alyQ8szN4B/PiU6ItQW5bjMlU4m6dKOko9lGmTDNoTwNfpuGJOeNFeH/AKiwrp9jyVn
         JwPxi+c+L6EDzPp6qYKk5l1Q035ODZjnicsmwxntr/4iQbzI7bLG7PZPWgelTNyYI4/p
         zRjERparIwQK2xWdm2QiHRGHicMr1A4d5mtPlJC3/mt1PM3nMhh+grdGlofy3k8HdXaW
         8nvqlFq/aE+BNGGoj5qVh3eP2Ur/2Eva/iuC6CPt0Mbz81jJtk5WvrC8/cVuC8EDNs82
         4JnA==
X-Gm-Message-State: AAQBX9dwuDq6CFghfeeX79hbXLpDDfBms2tU5np+ieChEAoHcLuqIX1b
        R8QoRRXnfXs3Ko5dNLxI+vdJhw==
X-Google-Smtp-Source: AKy350YBdvNgOC8F8gqfsSh8GXu4M4HZH2CymaXshNdroBrqtynflWna7ZvGWLovVOxyHFO0u4kGHA==
X-Received: by 2002:adf:f18e:0:b0:2d3:b1fa:3031 with SMTP id h14-20020adff18e000000b002d3b1fa3031mr1712262wro.16.1680619388666;
        Tue, 04 Apr 2023 07:43:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5136:bca8:1616:ba77? ([2a01:e0a:982:cbb0:5136:bca8:1616:ba77])
        by smtp.gmail.com with ESMTPSA id y6-20020adff6c6000000b002ceac2ccc4asm12489979wrp.23.2023.04.04.07.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 07:43:08 -0700 (PDT)
Message-ID: <f221954d-66f2-8dac-8e2b-5769c18d9aca@linaro.org>
Date:   Tue, 4 Apr 2023 16:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC v2 0/4] ARM: oxnas support removal
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
 <86d63038-e3f5-4c03-b904-a26761b0578d@app.fastmail.com>
Organization: Linaro Developer Services
In-Reply-To: <86d63038-e3f5-4c03-b904-a26761b0578d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 16:37, Arnd Bergmann wrote:
> On Mon, Apr 3, 2023, at 09:42, Neil Armstrong wrote:
>> With [1] removing MPCore SMP support, this makes the OX820 barely usable,
>> associated with a clear lack of maintainance, development and migration to
>> dt-schema it's clear that Linux support for OX810 and OX820 should be removed.
>>
>> In addition, the OX810 hasn't been booted for years and isn't even present
>> in an ARM config file.
>>
>> For the OX820, lack of USB and SATA support makes the platform not usable
>> in the current Linux support and relies on off-tree drivers hacked from the
>> vendor (defunct for years) sources.
>>
>> The last users are in the OpenWRT distribution, and today's removal means
>> support will still be in stable 6.1 LTS kernel until end of 2026.
>>
>> If someone wants to take over the development even with lack of SMP, I'll
>> be happy to hand off maintainance.
>>
>> The plan is to apply the first 4 patches first, then the drivers
>> followed by bindings. Finally the MAINTAINANCE entry can be removed.
>>
> 
> I merged all four into the soc tree now, thanks!

Thanks for handling this !

Neil

> 
>       Arnd

