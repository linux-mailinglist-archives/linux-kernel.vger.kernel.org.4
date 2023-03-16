Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665526BC779
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjCPHlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCPHlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:41:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4DC61533
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:41:33 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so4015294edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678952492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCV529IEFhOmH3m3tRLWovg4tOpr2dMEgtJqbgkXqcs=;
        b=Zh18Vhp9rRhuMnAdTRrIcDIIzYh75ZfoWJsOngYCj42MDqfyGGnjV7lukJCgbQXyZq
         HGwfRYbGtUyUOaf+1UwoFbSweza4SF75Ef9589dBDRu1svt33CbziVQzAFDdPCbxfB/B
         ZYJPq+Tq8IwEveRf4e+XaxEUVCaHOEGwlomdED4uLsJO9MCXEyb8TUHO5LJ/1b2cCwrW
         AL/3dq/4CKtelS5gLvQpTQgGYJZR3Z+6CHqStv3HD1prdbsmeEU9bVeaY6fR0hP027uv
         pyoy1D2gzjz8VGuhP2oaDT2UndxD0TaMK5rG7F4j4URU8AZNaGj9//K1PCOMNGnJMabC
         hQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCV529IEFhOmH3m3tRLWovg4tOpr2dMEgtJqbgkXqcs=;
        b=IaK8CZ4IjdfUPfhvZD6QFRtYUgwZ/Uk7fYMTwSvzjWeSPD8gr6C8IXQUvE8HMOwQij
         s8GdGrDwmeyUrPw4T69pa4Qze9zsfSGoiFNDsCrPVgTUmSp4axkS24Y1eWfK1wrkX5hE
         ueDrN5i8RN7m5nNCz39UPS/wrfXFEoEFGUBCPb70EM/Nny374oXpi5KI3CWX8vTxm3BT
         Cy0C6L3SqmjxP6Y8KD+DXEpCETynPYGAmlcNQmWJnr7SbVzN3SnAlj9KR5MCvbc+Hhec
         C93BgtAJ/JrRSsXPIZCGhvu8d4kt+4hG6NVQOMwkcHzLX8HyIB7DPfaAXhbe/X4hkiOe
         dcdw==
X-Gm-Message-State: AO0yUKXyURJ5L0cUpw9oucEIur4OOUOhXOVzdX6SVSZMIncJLZJGvZi9
        6I7mDNEitXoXzJGFxNZUdZDEPw==
X-Google-Smtp-Source: AK7set8f+C9O7FsbN4HnAGvrgGlK53j0Xbu6YDpcKfnAWsMyEJ9QMgkFyAalrVsK/WcThwVpGGydiw==
X-Received: by 2002:a17:906:ca02:b0:88a:2e57:9813 with SMTP id jt2-20020a170906ca0200b0088a2e579813mr8861398ejb.33.1678952492093;
        Thu, 16 Mar 2023 00:41:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id u14-20020a50a40e000000b004bbb691a334sm3482118edb.2.2023.03.16.00.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:41:31 -0700 (PDT)
Message-ID: <162c92f9-cf57-678e-1331-fe32d87c38d0@linaro.org>
Date:   Thu, 16 Mar 2023 08:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/15] Introduce Nuvoton ma35d1 SoC
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315072902.9298-1-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This patchset adds initial support for the Nuvoton ma35d1 SoC, including
> initial device tree, clock driver, reset driver, and serial driver.
> 
> This patchset cover letter is based from the initial support for Nuvoton
> ma35d1 to keep tracking the version history.
> 

To maintainers: patches should not be applied independently because it
will start failing tests...

Best regards,
Krzysztof

