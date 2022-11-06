Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A817261E15B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiKFJjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiKFJjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:39:12 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0658B877
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:39:11 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id l8so12092655ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cq1fQFuSXwN8I/qGFtLF6/L6wjrZ39hEli2/d689Kbk=;
        b=o+dgYXBafU/ZQ9dL93R8IJmp1uv+pDOKt9WaWHKZBJmyg+1WAuoxBx4ZfVufe4t97T
         Cjm6U3ekwulqy1TME8K3kJ3mbuk1Ojmg94UkpymO81ZlJywI/BcdhZv1wdGruvLtGY+G
         Eh9NQUlPkQikIsTram8LDtTeuB5TX2SkSaxZ5UhTrr0mEpHOU4utuUZfTY9EYsO+BGkp
         pQ6nmHopUv8IB/jVQwa3Gu3JF0YfqGpvEE5J+2C2BK3Gm97kOfXSFxvD1639gk6T6FkP
         +l3Nxxd95x4m6CEz9bJeIsnh1shsukHdP6uewDyQaLl5dC5UFFvtw5/JwUJFfF5oFnay
         W91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cq1fQFuSXwN8I/qGFtLF6/L6wjrZ39hEli2/d689Kbk=;
        b=r5WVKroocVldK5wi+lxK6FAeYMP2EdmfpsCB1yvA9NgKJpVQyCyxR2J2/lEWHZEDpP
         Lmla+Xy1Gft1KLuxDj6xFbcWtzZ48ojscEDyXP7xau7irKJ1kYBx0vqo8uv1I3w1MgA4
         mPw1m9s4jseBVJBrqVrxzxGHEh3+U27OyBy8MGNAckxFmq0QPmKnVynudwfjp77fA4tg
         bzFioylcjbMfxqNwr8sDa5kY1ixHNiGSj/a5gQ7b9ScjI0en5e8A0Dx4QIdqQhKo4KB8
         a3eAI41mbSwcpjq9RGExA5CvTYIfgl2CF00/5/MYJ+sMabNZdvheLjRmRBKSkyX1Au+l
         jAaw==
X-Gm-Message-State: ACrzQf09sQSJhlfP8x1IQjnREkdUSluraTDBVOSeJt2gl5txvv9fGs/Q
        CVeTHucqDfMHwq3Pb8wR8+RwMQ==
X-Google-Smtp-Source: AMsMyM5nLoppsmo6K3rS6K3VcxNVbW6KU2omoKQbkqEkvZ/mAFNo+iRlqeOsOr/vKkHHaHIf9OQuVQ==
X-Received: by 2002:a05:651c:b29:b0:277:43c4:a864 with SMTP id b41-20020a05651c0b2900b0027743c4a864mr3893482ljr.463.1667727550117;
        Sun, 06 Nov 2022 01:39:10 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id v28-20020ac2593c000000b00499d70c0310sm626240lfi.3.2022.11.06.01.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 01:39:09 -0800 (PST)
Message-ID: <7411fe54-892a-1a12-d323-cf4c508d0a9e@linaro.org>
Date:   Sun, 6 Nov 2022 10:39:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/8] dt-bindings: mfd: syscon: Add nuvoton,wpcm450-shm
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
 <20221105185911.1547847-5-j.neuschaefer@gmx.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221105185911.1547847-5-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2022 19:59, Jonathan Neuschäfer wrote:
> The Shared Memory interface (SHM) is a piece of hardware in Nuvoton BMCs
> that allows a host processor (connected via LPC) to access flash and RAM
> that belong to the BMC. The SHM includes a register block accessible from
> the BMC side.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

