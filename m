Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1260663C49A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbiK2QEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbiK2QEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:04:21 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F561BEAB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:02:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g7so22750897lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13+qbJOmWTqxbFOdDOLgCT6uW4S43S5+kJ0NK9uACko=;
        b=eFbk+HGJxPawBYhTluxHbS2J74enMGNbBWPwjZnYQ/CWkejbCh/CQwm7RT79kNoj4V
         26fei0JhV0J1NsodfAftlgIIS7xDdt/QA51zN29aHc/+AnUmU7cYMno6t72DjXbtdjfC
         jonXr6tyqeXSXj17TU1/lroRd1ZFQebUiNEHvRw88JSpFwClmZ/Hrcss3A+3XvsUHTUO
         J5lRk5BZ2JVrGGCH1/ponGmfnIJNNg6pj5xFJtrYtJAunfy/6Fm2Ndp9/XB+m6xXXaix
         z/xG/Ryq0S/NoARPexwy4IvXPc21KD7C+B46voVXGO2VbNQul00ARFNX4nveIjPKCIJb
         L0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13+qbJOmWTqxbFOdDOLgCT6uW4S43S5+kJ0NK9uACko=;
        b=jNHfXINVI+UScNDn2uWdVMdEV1M6FZdV1gtsZVhi8RAyU+cm2/WqRMIJgGtbzjDs+r
         d/aIRwOauC43lTMhOtst6Nq5iIue3vNoPt13MrmmKpaH3XN7TeRCJcUTT0cQMhBj1Y57
         hahOV62WMig1bxELP90lqiMPDbZ2mbEAk9psVflymMSbeG+uvhQ56CluH3HSf8D8WZGr
         yyS2MPigaIARBux7szT9upXqWnP+o7+0no12KNxUNUqE/D60+5WP5qqqnseuOnR0XSu+
         aTzM6Fvah0cri6cHLVpbWi8YsPNUHcuayYbwNIDTUaRY9ze0TV8yEq/ny8evcElwN+Ud
         kS3g==
X-Gm-Message-State: ANoB5plfmDaDqzG/ghQzAP04LpUkGltmAoRJnZWhT2DYqI3hUCXpbEMA
        nkvUeNEUq9RnqCaXfhED9atFCg==
X-Google-Smtp-Source: AA0mqf47BgiluiyNP/9thR/1gKkiA3+Yk8TNqaH4cPXqRpLVYA73Z5o8kzd7SJcWMxMO4FCNHl26ww==
X-Received: by 2002:ac2:4bd0:0:b0:4af:ad36:7a85 with SMTP id o16-20020ac24bd0000000b004afad367a85mr19013323lfq.617.1669737761605;
        Tue, 29 Nov 2022 08:02:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w18-20020a2e9992000000b00278e7800715sm1570514lji.16.2022.11.29.08.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:02:41 -0800 (PST)
Message-ID: <0a8c3ed4-c16a-4014-94f6-cf177630e605@linaro.org>
Date:   Tue, 29 Nov 2022 17:02:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/5] dt-bindings: pinctrl: Add StarFive JH7110 pinctrl
 definitions
Content-Language: en-US
To:     Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20221118011108.70715-1-hal.feng@starfivetech.com>
 <20221118011108.70715-2-hal.feng@starfivetech.com>
 <eb3974a3-f715-f5b0-cac7-551af26bd17b@linaro.org>
 <08db0f3b-5222-9460-26ba-0e6380d16583@linaro.org>
 <0ceba170-f844-e733-a49e-e67746f9f836@starfivetech.com>
 <093ea507-4c42-1af9-4896-64c1a918432e@linaro.org>
 <30c21787-0c48-ff50-1d63-8e69bdcdbe30@starfivetech.com>
 <339be655-aee7-e1a4-51be-28ea20de6792@linaro.org>
 <3db802d6-114f-097a-6c69-e7b40e4d2764@starfivetech.com>
 <f52e31a5-a12a-b95e-b99c-1af8f8b41c3b@linaro.org>
 <8677051a-604a-210c-066c-75db444d6f09@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8677051a-604a-210c-066c-75db444d6f09@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 16:58, Jianlong Huang wrote:
>>>
>>> Drivers rarely reference macros directly, mostly parsing dts and writing them to registers.
>>
>> So drivers do not use macros? Then there is no reason to store them in
>> bindings? What do you "bind" if there is no usage (and we do not talk
>> about DTS...)?
>>
> 
> Where do you suggest to store these macros used in DTS?

Sometimes they do not need storing. If they are worth, then in the DTS
headers. Few platforms (Samsung, All of NXP, Mediatek, Sama5/Atmel) are
doing it already.

Best regards,
Krzysztof

