Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D54E74CE57
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGJH2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjGJH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:28:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7716EB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:28:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e34ad47eeso5267996a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688974081; x=1691566081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HdJvjKJBbsh1HxsxaN3iCI0Hz1J0EQEyrw1IwKvkYvI=;
        b=wYIr4Xp/S8RZiqXTmmHbgsBDXWBeFPUWieipGETIBzguDkVwfyAI++rh+Ek7hiP4hi
         QMqdKylzB09w40F/n+VWHExC9/1Mw9nR7LquSS/BRnXkBoeLxuYBmspFosAXTp2/6wk+
         2/+PEkOkg386pGU9qNX60Nme4erLLuWbzKDRK6dTlxwxasLNxb/5Lqb7Jwd2FouJj1vU
         fbQvJMj2088DK6NqzWlGXjtqsQ4Sf9xjF5ZFdoDga+AvuIkL5O2zrDg1c+K3Q+UHxa46
         /NAmzg/0fJ5mmtFEynBSjAEMOoucnb3ZBjPl+sjns4uLgAH6sR4O3wbbMMc26MnEdfvs
         rOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974081; x=1691566081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdJvjKJBbsh1HxsxaN3iCI0Hz1J0EQEyrw1IwKvkYvI=;
        b=gibPFgYVNblUSqeSK1Lss77EQ1WYIAcf/GBohoaTkrVOxge4SX20UQbYrMuL0fFAXo
         ZnEIgtUclG+xs/lDW4fLybnFDz5kQmQA+mdrRltM5dq4MCxztr5vsuNrwh4N/A8BnBRZ
         7Pt5pqe3vGfcTHXCO1y0Aha9YSXU/UYlCJA0U0xz1cOdnLczsoNjkUYE3vaU80FbEvXu
         XcSkpenxJP2aR5r2fWOGm80ag6QumSwPZpj52K037H60A2ao70T/guh0we/xOYjeKzvI
         aILv5vXlQckzrF6N0es2Dg7VGxNhdzWwRIyq58Eh1RQa3ZOBRA4NpPnESSXSBckhggw+
         NScA==
X-Gm-Message-State: ABy/qLY16+8jR9HwTuVw6iBJ49vViefTaKLEtpjw9DBbZxSafC+elSKx
        G9ktjuCa5G4sto1otx4iJ7PSPA==
X-Google-Smtp-Source: APBJJlHBUYW+OHB9J9ExRZcWis9YtPk/ammlfZZomv8Sl4Wf9yS1hFLJ2HO2jk2Wh+aC+WCW5wcNqg==
X-Received: by 2002:aa7:d457:0:b0:51e:24fd:d34d with SMTP id q23-20020aa7d457000000b0051e24fdd34dmr4271933edr.20.1688974081255;
        Mon, 10 Jul 2023 00:28:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b9-20020aa7d489000000b0051ded17b30bsm5327573edr.40.2023.07.10.00.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 00:28:00 -0700 (PDT)
Message-ID: <4c1b27ce-7c63-ab5b-5992-51607b7826bc@linaro.org>
Date:   Mon, 10 Jul 2023 09:27:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/2] Add compatible support for RT5733
Content-Language: en-US
To:     ChiYuan Huang <cy_huang@richtek.com>
Cc:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1688048996-25606-1-git-send-email-cy_huang@richtek.com>
 <20230710014725.GA12147@linuxcarl2.richtek.com>
 <224afbe7-f0d5-ced2-a300-9e05789f08e8@linaro.org>
 <20230710070956.GA31191@linuxcarl2.richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230710070956.GA31191@linuxcarl2.richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 09:09, ChiYuan Huang wrote:
> On Mon, Jul 10, 2023 at 08:55:17AM +0200, Krzysztof Kozlowski wrote:
>> On 10/07/2023 03:47, ChiYuan Huang wrote:
>>> On Thu, Jun 29, 2023 at 10:29:54PM +0800, cy_huang@richtek.com wrote:
>>> Hi,
>>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>>
>>>> This series is to add the compatible support for rt5733 based on rt5739.
>>>>
>>> Sorry, not intend to ping, just want to check the current review status.
>>>
>>> Any comment about this patch series?
>>
>> You sent it during merge window, so what do you expect? What should
>> happen during the merge window?
>>
> Since I do not know it's merge windows period, sorry to bother you guys.
> 

Release of Linux kernel (so v6.4) is the opening of merge window. You
can also check here:
https://phb-crystal-ball.sipsolutions.net/

Best regards,
Krzysztof

