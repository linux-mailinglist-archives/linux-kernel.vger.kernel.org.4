Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8909A6EBDFB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 10:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDWIZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 04:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDWIZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 04:25:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6539C1BD5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 01:25:46 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-506b20efd4cso5541792a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682238345; x=1684830345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qETio9rQ+I+ApbmjseQZz+b4a2GrMopfzyspvxvfmDI=;
        b=CNlnud9ixhpA7rN5EkdFypqZA/9EHtbHo0dnoloz/zm9AmQu9Q7dFAPSj4qpSWmA20
         LojHlppqQf6E2hQUooLbrCEqRzfDtZLvo/byw7QN4ujUSkjLnpmj3Ejl9UP4EoVVkVJJ
         5js84TxfRY5fzJBR9v7M6CZkkJz11L7tpmtrEsbML+0/W5NrrY2NHnQV0Y86EoVyi4tG
         dFteiFaIqHvaV4yAmni+nFeReHPTtKmlzPNBhQyj4eEC6dYOPxKpOgh7Fesd9EpWlnIp
         bB7P6hgsKucCZU2KN3vOd2+7LnBC+WlY/jANPYX1BQ0wf8f8O0Bm1xBwgY0eYj70aW5E
         hD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682238345; x=1684830345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qETio9rQ+I+ApbmjseQZz+b4a2GrMopfzyspvxvfmDI=;
        b=Id5mkFsTRh1XEAJOO+BamnrSg0f149/vOXIuRhI6HqYCfJaDVf/kTuLYhBJgi//QQi
         UZTUciNtwILiWoFfJsHgprF6dCbO5iaZkbdwCiFKmb7LUC9gHaY65qmWJzo5VI479iBX
         9jrBBytWPhrP6azesLkcEJTOdR/OubuAYjus8GAjMverNQy/r6QkC8knaLxN1crwt2eC
         Tr6QUywKK5rXcSJy6MVRLK/LXSZ/pLUyg+PYtU18xd1g4hcwYLKOe2T8h6b8VveyQQBn
         Pr4gwQyZWBtzMeSh87Cw09DUH7K/8QrTcUaXMl9kcQQApI1mhb3FXvXA1XID1QNH18/Q
         o6WQ==
X-Gm-Message-State: AAQBX9fM0nCME0Ryr3ZCSBW3s5m+KQv3UM2qZk8kCcseIGwsq6kPjVzQ
        Dgi/Ot6H1flQbSwt2tshGGqZ0w==
X-Google-Smtp-Source: AKy350a52plHENuAAwWUdq2bp/DaP8sNnY6cqie/09b6KCgt6I5FlFz697CL/6UK2AIp1gEeHdBZUg==
X-Received: by 2002:a05:6402:74c:b0:506:976e:5242 with SMTP id p12-20020a056402074c00b00506976e5242mr8618775edy.25.1682238344819;
        Sun, 23 Apr 2023 01:25:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5d52:d466:d57f:118c? ([2a02:810d:15c0:828:5d52:d466:d57f:118c])
        by smtp.gmail.com with ESMTPSA id p21-20020a056402075500b0050684020babsm3464665edy.27.2023.04.23.01.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Apr 2023 01:25:44 -0700 (PDT)
Message-ID: <80c6cfbd-5661-ba39-2193-c6ae8eba3648@linaro.org>
Date:   Sun, 23 Apr 2023 10:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 12/12] ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0
 boards
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
 <20230416133422.1949-13-aweber.kernel@gmail.com>
 <9aba4c1d-93f3-7613-6fb5-0591a281ec0a@linaro.org>
 <5818b5be-f9cc-8009-e2a4-1049d84a944d@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5818b5be-f9cc-8009-e2a4-1049d84a944d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2023 15:50, Artur Weber wrote:
> Hi,
> 
> thank you for the review.
> 
> On 16/04/2023 20:26, Krzysztof Kozlowski wrote:
>> On 16/04/2023 15:34, Artur Weber wrote:
>> [...]
>>> +
>>> +		backlight: backlight@2c {
>>> +			compatible = "ti,lp8556";
>>
>> You need to convert bindings to DT schema first. I don't accept any new
>> usages of TXT bindings anymore, sorry.
>>
> 
> I'll be taking a look at the conversion (will likely submit it as a
> separate patchset, since I've been looking into some minor driver-side
> changes there as well...), although I have one question - who should I
> list as the bindings maintainer ("maintainers" field in YAML format)? Is

Anyone who has interest in the device/driver, like driver maintainer,
device developers, you erc.

> this someone specific for that subsystem, or the author of the driver,
> or someone else? (It's worth noting that there isn't a maintainer listed
> for the lp855x driver in the MAINTAINERS file.)
> Documentation/devicetree/bindings/writing-schema.rst doesn't really
> mention anything about this.
> 
>>> +&bus_acp {
>>
>> Order label/phandle overrides by name, so acp before dmc.
>>
> 
> Out of curiosity - should I order the children of the / node 

Yes.

> or the
> pinctrl nodes by name as well?

These are usually by pin name.


Best regards,
Krzysztof

