Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232CC6F3D77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjEBGbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjEBGbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:31:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17885273F
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:31:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94a34a14a54so677845666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 23:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683009071; x=1685601071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aq3WwE51aD4Fqe/+1vl6PvG/lCHBeN+HW7nLfaOHSd0=;
        b=U9eP7tYQOcSpsVZHUsazY2ho7zcbyVUSrCMykSnixhtgdleHFsUGhpavnBqieXBh6w
         4QHlDV1MUEMB0MQ9funL986uyMeNiGEdOTJKvJqBA4Pnird6IRtB9B5ifYjcZpFiuUlw
         rYh0QI6so376tg5E2M/7jTKMSbW5mPVbSUuSzQvJs4rDvBr0HsjDK+XYDDcoZxfjE6oy
         W3mptimR4I7GR3g9dglGSyU4RlZPa9BRwS6e6UfCOWuSMuOSjKIfBv/3tyq7skTpARlN
         hKTT8lmRW3Fg8Jf4oFGsgvQA0coMqPDO3lk/UCjyTqdUL6hqrHwvPW8E89ixrNx27d+A
         w8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683009071; x=1685601071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq3WwE51aD4Fqe/+1vl6PvG/lCHBeN+HW7nLfaOHSd0=;
        b=PWDaTaJRwFZpI/rq+4N/dwKKhLZM6xmw06PWTGXHgvgdsnmT5hy4O0f24flYU7QFZS
         cMyjlvCEBvFR7QHd4rZ7j8zmHdcmV83Pih+9MnWx4/0wTDBE0Q1BokgV1syZcCZ8h7yF
         jZESFl0+euEiW1XWvmnl0ixHB7A22BAMf8x3QZo7HbRjsZmaBHcJlCNhsL0BKJ82jWPt
         oUBeZvxvzXnIb+66Kz209+Shd3pE8dxLfyZIKzaNuIKcMohRcKANMdPdHuIbtbZ8tr2d
         pRQqFP5en+h3ZWpwaBiFqkXbn5R5OHrGTzoSVZ8RkdM+ejb7bxxBzGo+sqBCy2cF4pAg
         1E/A==
X-Gm-Message-State: AC+VfDyyGMvbrGdghOfPw2gBINGYP1OH068ep4KHgOZydVUKd18KLpB+
        OQzSKndmUjX59JkPkfUvxBtxjA==
X-Google-Smtp-Source: ACHHUZ4baDQK37C+Ez0SWCX/yXtXPHPzWV57b2UMhkju31JcZzt6SfSP7RPxpwRVvxkuJthLU3rrHA==
X-Received: by 2002:a17:906:5d0b:b0:95e:d468:c35f with SMTP id g11-20020a1709065d0b00b0095ed468c35fmr13692567ejt.57.1683009071427;
        Mon, 01 May 2023 23:31:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b009571293d6acsm14527373ejc.59.2023.05.01.23.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 23:31:09 -0700 (PDT)
Message-ID: <34d70271-ff07-aea8-bcb7-81d39a55167c@linaro.org>
Date:   Tue, 2 May 2023 08:31:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v8 05/11] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tmaimon77@gmail.com, catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230425102418.185783-1-ychuang570808@gmail.com>
 <20230425102418.185783-6-ychuang570808@gmail.com>
 <2b79021d-3793-5f2d-8659-5d0d8fc78017@linaro.org>
 <ded0c68a-e0b3-b106-e24d-7d9087c6ca4c@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ded0c68a-e0b3-b106-e24d-7d9087c6ca4c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 03:31, Jacky Huang wrote:
> Dear Krzysztof,
> 
> 
> On 2023/5/1 下午 05:50, Krzysztof Kozlowski wrote:
>> On 25/04/2023 12:24, Jacky Huang wrote:
>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>
>>> Move 'nuvoton,npcm-gcr.yaml' from 'arm/npcm' to 'soc/nuvoton'.
>>> Rename the '/arm/npcm' directory to 'arm/nuvoton'. Additionally, add
>>> bindings for ARMv8-based Nuvoton SoCs and platform boards, and include
>>> the initial bindings for ma35d1 series development boards.
>>>
>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>> ---
>>>   .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>>>   .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>>>   .../nuvoton/nuvoton,npcm-gcr.yaml}            |  2 +-
>>>   3 files changed, 32 insertions(+), 2 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
>> I don't see any improvements here. Path in maintainers is still broken.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Does this line cover 
> 'Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml'?
> ==>  F:    Documentation/devicetree/bindings/*/*/*ma35*
> 
> I ran 'get_maintainer.pl' on this patch, and it was able to find 
> maintainers and looked good.
> I also ran 'make htmldocs' and did not see any warnings or errors 
> related to the .yaml files
> in this patch. However, I am still unsure where the problem lies. Can 
> you suggest any
> tools I can use to check for errors? I would greatly appreciate any 
> guidance you can provide.

Apply the patches 1 to 5 and then check if all paths from maintainers
are correct. I believe the path
Documentation/devicetree/bindings/arm/npcm/ is not.

I think I told the same last time with explanation that this patch must
correct path.

Best regards,
Krzysztof

