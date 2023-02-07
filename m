Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D14268D129
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjBGIAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjBGH75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:59:57 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C2229422
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:59:55 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id g6so4672714wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 23:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9y/P9MXwLNgqQt+C7wIYeiUxLoDHi6tNn49iTJuqSQ=;
        b=WdD2Y/cGjIiqlS31xeZvPPnp2bp9E9bEkfrn+p1aF/sykDUZR0Mn+9UPPgIo4Ss5mR
         X7x5zwE5fV7SDsK7AQzphRSIltCWtrtKKJ5UXe52kK8RkjiP/2OlXEh11Dto5hQGQOUj
         fSXmQwUYRhlcbsJAXZirNibnhegy55SSODE8Zo9noHQiqBLOv8PODBiyjSuuN2UebDhu
         xMniewVsouwDvYuFigf0c1XoVs34BeXfuXAjTuGI+br2hw3KjbeIlUIOd4/EZlktIyX0
         DVTE6nzeYLkEVZogZyQ34rvzldQlKuKNMz9nmTpvilxR1h+W3NhjV9OCXm9W4Qk5vhT6
         LyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9y/P9MXwLNgqQt+C7wIYeiUxLoDHi6tNn49iTJuqSQ=;
        b=kXBX8YE/OVJLAlJlZHXb7aw3robrz2q7f92qebUN5AP1jG2ED5npjiLOdcTmnM4gEO
         Dzj+ukuTWJ6jE5+Ld6G4PBLzBSYw3pqOnsH7bDBFdplTwmbzaIUm7+UErYtRWntWg3TS
         WMKo5Z03JdVYokv0j+blCQ1NjuPbVutbBjSb688aHM87/WFffIZxTl44o86ITWh3r7sY
         UAeg3O7sNod3cphXxVYhNLIvBYt+u8AYG3o/qrjV/tDDrZrY5eCBMQqS0CXsuoNj0ACZ
         TM7sORHvgc/PI8U6Nkv4c+GLEkMOF+RWZG/3+9OE8cqotdQeoiOoMT4FnSuna/BYn50u
         +UjA==
X-Gm-Message-State: AO0yUKUaOZP8GfnGmUYT9/Aeu8Ww3wXAaUw0M0vvPOUzIFYR5BqWztt0
        QgO1m2raAhW+26SjD3+OMDNoMQ==
X-Google-Smtp-Source: AK7set979LY59KDvABkxHfzPCxi00zqtmzn2pfmV76eS0PMM6Bg/n+cN4lqN+Mh65bjJmFGGKeENEA==
X-Received: by 2002:a05:6000:188d:b0:2c3:be89:7c36 with SMTP id a13-20020a056000188d00b002c3be897c36mr14479686wri.25.1675756794196;
        Mon, 06 Feb 2023 23:59:54 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f7-20020a056000128700b002c3df9279f5sm7432290wrx.48.2023.02.06.23.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 23:59:53 -0800 (PST)
Message-ID: <b3b9d515-20b1-62a1-3243-b1bc36c306df@linaro.org>
Date:   Tue, 7 Feb 2023 08:59:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] arm64: dts: Add support for Unisoc's UMS512
Content-Language: en-US
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230118084025.2898404-1-chunyan.zhang@unisoc.com>
 <41fd5c2a-9fc5-8af8-b66e-45bb83b24179@linaro.org>
 <CAAfSe-v3VW_sE4FwjURoOapMXrGavOK0hzeU-84-U_6xfhYbQQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAAfSe-v3VW_sE4FwjURoOapMXrGavOK0hzeU-84-U_6xfhYbQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 03:19, Chunyan Zhang wrote:
> On Thu, 19 Jan 2023 at 19:40, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 18/01/2023 09:40, Chunyan Zhang wrote:
>>> Add basic support for Unisoc's UMS512, with this patch,
>>> the board ums512-1h10 can run into console.
>>>
> 
> [snip]
> 
>>> +             ap-apb {
>>
>> Non-unit-address nodes cannot be mixed with unit address ones. Something
>> is wrong here.
> 
> To make sure I understand correctly, did you mean non-unit-address
> nodes shouldn't be the parent of unit-address nodes?
> 
> Does that mean the bus node should have a unique base address like:
>         ap-apb@70000000 {

No. I mean, run dtbs W=1 or dtbs_check DT_SCHEMA_FILES=simple-bus


Best regards,
Krzysztof

