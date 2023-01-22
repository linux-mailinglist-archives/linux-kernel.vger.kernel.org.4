Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81729676BE9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 10:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjAVJhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 04:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjAVJg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 04:36:58 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D864414497
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 01:36:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so6535025wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 01:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpxZop004lAiKqyB5tDsS8TgVaCDtVZHtlMKxmTjC0g=;
        b=ECgPRWWCsy9NToHICzR2kX6HSwQWLtqjk0hUPwSUnXp7BbMafWTGTbDh4bWHQX5+HK
         5NCXN0o+5LrU1+yn6VoBH6eLxLdefhX0uQhbbghH/hxBv4i3PHrtMuVlx0D5Ww+vfWcN
         tGLlKwRQlCRJB0xtgLUilAKp6pRbrcbSEEbOa57RQvfjuHbf6GQ+V2uFGwlhapFDj8fl
         Oin1rIuEMVzaPPWAuMzujhb6hNCwgfBguKuQQoq58KOzr1bzruv0OyUSDWTlNYEskN7o
         9COOOvQWLvDU+RgGhHr2QQz57uZztka0mqwwr6vs9R8ZAhT9W7qada8ZSCYmkRAAgyht
         /fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpxZop004lAiKqyB5tDsS8TgVaCDtVZHtlMKxmTjC0g=;
        b=UI0M/IJFSZsNJ8s0AnBqoj2pEf9AbofDQMSgz5gHg/8MW6BavDO/zPQb6oR9+jz1AZ
         hJO1luoWCcsLzB472eghvfBMQp7/1pcYgggQlJ0lFWS/Cys6Anx7v6syT36noRno0GX+
         N+knaSEmZyRotqeLjfKOYOtFu0vv334qEkIsLq1uUmQmmYMllybezGdvHSpxQ4QDVDTi
         OiiQI5c49GbMr3iYHRu6S9A7wX4QYy3OdvZKNdZMZHAmNpZEh72FRQSiCi3Lco99g8wJ
         VHSVnaBER6rfz4/thJ2xv/jbp6GR+e9a1nkJI7qNGir2C5WCw1/qLOGVx0PHjrQi8o9g
         1+Ew==
X-Gm-Message-State: AFqh2kqtJbLUBKwcIQjZV2+5Xs74M96ujH1u/ad0LDKgsY895+zvKFuL
        fVex3sjdQ0pNsN3Y7QvT5RCpJA==
X-Google-Smtp-Source: AMrXdXuzS6IDyC+K25N0DkOt4MKy8IOR4GrMzqYb0s85tX7fURVExIEukvDBl8Jd5pVgK92NWlbYlw==
X-Received: by 2002:a05:600c:35d6:b0:3db:2ad:e344 with SMTP id r22-20020a05600c35d600b003db02ade344mr16706207wmq.13.1674380210417;
        Sun, 22 Jan 2023 01:36:50 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003daff80f16esm10367065wmg.27.2023.01.22.01.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 01:36:50 -0800 (PST)
Message-ID: <07ce1655-d84b-e4f1-02d4-b69568830175@linaro.org>
Date:   Sun, 22 Jan 2023 10:36:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 5/9] vendor-prefixes: Add VIA Labs, Inc.
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230121175639.12818-1-linux.amoon@gmail.com>
 <20230121175639.12818-6-linux.amoon@gmail.com>
 <d0bdc8f9-5ea8-5c77-3193-a2932c87156a@linaro.org>
 <CANAwSgT4P544a2MeybV_hXkDfc_HXiO4Rnxt4qG3RM1-X-KCEQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CANAwSgT4P544a2MeybV_hXkDfc_HXiO4Rnxt4qG3RM1-X-KCEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2023 08:04, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Sun, 22 Jan 2023 at 00:21, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 21/01/2023 18:56, Anand Moon wrote:
>>> Add the vendor prefix for VIA Labs, Inc. (VLI) is a supplier
>>> of USB and USB Power Delivery controllers for multi-functional devices
>>> and platforms.
>>>
>>> Website: https://www.via-labs.com/
>>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>> v3: - None
>>> V2: - drop Drop marketing, so without "leading".
>>
>> Wasn't this merged? Didn't you get email?
>>
> 
> Yes, it was merged into USB testing branch.
> I have rebased it on Linux master 6.2-rc5,
> I hope this series picks up again.

No, that's not how it works. If patch was picked up, you must drop it.
Otherwise you might mislead maintainers (e.g. other maintainer) to pick
it up again.


Best regards,
Krzysztof

