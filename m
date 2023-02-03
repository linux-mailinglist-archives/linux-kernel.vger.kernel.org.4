Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360706894D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjBCKNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjBCKNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:13:51 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450AF8E68D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:13:50 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o18so4185981wrj.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 02:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJ04MCttDfZJyvWfMTXvBLaMw4c/LHLqATbSxP5hNWU=;
        b=IKUMGCGHmzLhiOWTDujUR0e9kqL4rNY/EZDl0RJ2vF5wH0sc0SVWaXapFJs+w1OnN2
         2Rp1BU5CH+PgrOiJ3+TnE3KG4Yy8Msq6le8m1gBQVXssbKRcpTUZ6ah8BBXqmZyvdTJQ
         cy6xwHPm0+htYV3nof7uxG9tqV06eK7IjHVKV/NiPl44lvTQxwN2/CWatehrwAF43PC0
         HtCDL9on6esnrIX1s42YeAXQuw2ZXhuPWOqu3Ur0kzuetcTrs+4vEeIl8S3EM37YkMic
         pebre9dgx9CC8LF0IxRl62B7WJXvdqOE1lXoJi8gvcJUn02XWmwoHX4ZLJRaIltdTMVq
         cUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJ04MCttDfZJyvWfMTXvBLaMw4c/LHLqATbSxP5hNWU=;
        b=PhLoLKSLCqL/u4tKYWGY1kEiR/8Go0TW4C4OX8uJe3rlmmJBCYKZbfKTNJ96oeSHY1
         frWV7LQA4pwEFQUGzlj7fdrxj97MUbkJIN8QEj7YwS2dwdvho8WCntQ28BWUfaef5IwN
         RIk7nMs+YlWX43tNeHMmfTOBSZx2WvMEvog1EIdd8268G+kZsEWeqM2Dt2u898sfqif0
         xK+/PwlTKr6v/nvSNF77i4hLA47COBIARnkNoD7i3Q0HlH/Ebme8vvHTlwyqS8lvBy1n
         dTD/j5hs3If2kbB18HLlGCVx/kGF6T0AVbRyQsOsBooRa8V/NDP1PrG2aakCL74lQ6H+
         arig==
X-Gm-Message-State: AO0yUKUbHH9UMmpaT8Q6GFfrrcuBcObfU9ZNYgDHNOjaHDSKnHNgt5U4
        qj6yyroJ29d47Ar4O6ow+4x54g==
X-Google-Smtp-Source: AK7set+DqCMkB4MchgXpJWJp60gl/APaBlnfmCG8rEEslPdnyDcp2NNrdI3hGHA2LJwdlzZYrz/VGQ==
X-Received: by 2002:adf:fb82:0:b0:2c2:ad22:40ba with SMTP id a2-20020adffb82000000b002c2ad2240bamr7541698wrr.68.1675419228838;
        Fri, 03 Feb 2023 02:13:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d6845000000b002bdff778d87sm1597196wrw.34.2023.02.03.02.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 02:13:48 -0800 (PST)
Message-ID: <b3a5899f-05b7-c14c-b9de-a48fe0747646@linaro.org>
Date:   Fri, 3 Feb 2023 11:13:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] dt-bindings: media: rc: add rc-dreambox binding
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Emanuel Strobel <emanuel.strobel@yahoo.com>
References: <20230203093405.1616564-1-christianshewitt@gmail.com>
 <20230203093405.1616564-2-christianshewitt@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203093405.1616564-2-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 10:34, Christian Hewitt wrote:
> Add a binding for the rc-dreambox remote keymap
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

If there is going to be resend:

Subject: drop second/last, redundant "bindins". The "dt-bindings" prefix
is already stating that these are bindings.

> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

