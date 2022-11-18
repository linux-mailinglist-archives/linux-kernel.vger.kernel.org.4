Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF0E62F7E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbiKROl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242379AbiKROlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:41:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4794A4A047
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:39:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso4194584wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Y6Bg6qnbLbnNqXzsBHD84qTsLn1wOxnG7yqT2bB3ME=;
        b=xSL2im09i1KIxS2mPzcxkjNvslnj6eMdv8/l3GIPKfG4be2IiNiuLJKAnl/n0kQ83D
         ueBerELi5Z3NTPZ5fCLCgxXA9mPk70SfB35/gvlN67FuwH8rVgp5XUzjExACyecyM9Fz
         Bkddcbdt9EhS9KqskfTAiQrXQm/eiyBeOSFvvh6CDUf3WGEwkfQRlk/6Ubkm+GT1RmFI
         C2IvUn0oR1rLBUL/vfGd8WNtVWqEkiLuQOCCReOxeitCBqEicha3OmECgacodS862KHa
         J54lBd7ktsG79azccKkmJMW3U3Y7Ip3DR5hGWToCbbb9QUxCThvX++tJIBsp0IDMLsuz
         Jfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Y6Bg6qnbLbnNqXzsBHD84qTsLn1wOxnG7yqT2bB3ME=;
        b=Yxl2YhwkMQMg5P/QIAsiH91nmzBZrMxvScg9SR8i1jEu8r6fAVdRTQz+/QhKqzJEyU
         FJPX7pvVTDO0OSIt0zcZ1iwwIthbpe/MW4ayOGxWbsU83CxLBW9AFyO76/8RyX0wvd5V
         NJny1Cl6wmy0IKacp7VJKRhFSZWQTeNP+9aL+bu2v1MCSujrY3cdMccBKXrGhV1qFbrX
         k0ChFxu0h37M/fiMcQfzCwUOHW8MDWen22SQ7mGFm66JO1NuX1UYseuxpa6orr/O5JbE
         KP43aNcKa1U4fJUyYFd23gmdJLGrlF42qoYdxM7Aw9CYJYo8uNf+kDJACu93PV9/RJSP
         79XA==
X-Gm-Message-State: ANoB5pnymRP/7OsE7Zbwk8EMxY9i3qMG75FRoVs/GC5J2BuPNEfsEf0A
        0Md0fg1dCJcCKui4vOMLcozYDw==
X-Google-Smtp-Source: AA0mqf6+xja8YwiiyJEjzyuPpa/nrBlOVNTSsYyM8az4DVr4K6oearAVW2j9Gpgbp5j0npawgfzhtw==
X-Received: by 2002:a05:600c:4e12:b0:3cf:d4f7:e70d with SMTP id b18-20020a05600c4e1200b003cfd4f7e70dmr5140565wmq.187.1668782381730;
        Fri, 18 Nov 2022 06:39:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f7cc:460c:56ae:45a? ([2a01:e0a:982:cbb0:f7cc:460c:56ae:45a])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm10164756wmq.1.2022.11.18.06.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:39:41 -0800 (PST)
Message-ID: <7c722431-a866-7d19-d7b2-83535719aed0@linaro.org>
Date:   Fri, 18 Nov 2022 15:39:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] dt-bindings: pinctrl: convert semtech,sx150xq bindings
 to dt-schema
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org
References: <20221005-mdm9615-sx1509q-yaml-v3-0-e8b349eb1900@linaro.org>
 <CACRpkdYCUTb6-RdT0LPbmesxabUR1yMs5-YKCxxNcg+MC8Gf8A@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CACRpkdYCUTb6-RdT0LPbmesxabUR1yMs5-YKCxxNcg+MC8Gf8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 09:56, Linus Walleij wrote:
> On Tue, Nov 15, 2022 at 11:06 AM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
> 
>> This converts the Semtech SX150Xq bindings to dt-schemas, add necessary
>> bindings documentation to cover all differences between HW variants
>> and current bindings usage.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> The binding is a piece of art. Excellent work!

Thanks ! Actually it was fun to write !

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

