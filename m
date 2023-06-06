Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA25723FF2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjFFKoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjFFKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:43:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B538B10D1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:42:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-977cf86aae5so389313766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686048128; x=1688640128;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hztYX3lCCszrQN2sLS6OQQbXo0IrqmI3DHUIMhxyE4=;
        b=xt5rNJ5A92ysQqwhJJhYw0coJTIrKX4DgtbH5fGHfhu5LpDsAZHObPbCnwNHtaMZJq
         G1rbDd7KajXMFc+VlKEkb1tJTOGEcY7/xrhIrYpkQ6NAxSb06EhGap3os+1IPzumdbTF
         wbOv9kZC+/oWDrZJALtqTUYOSS/Mu1JkbYw8DDRMZ0b/QllhL3Mr/xv73KHFNAIlRoLT
         N353oc5ZG3FbdvSogTOYrSGcWRHNGgeZbzsm8NPlkfj4bGhDSe3Z3M8OgaaNxvm36rbO
         3HEAplByMqOIHmg9Atam/7BlRPW9QgKS8pJNMJM0zuw+kF8TNi4FSLN+vtrxaXlrXIfT
         LzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686048128; x=1688640128;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hztYX3lCCszrQN2sLS6OQQbXo0IrqmI3DHUIMhxyE4=;
        b=MLEhEPishZTgGZT08ZwS+L786/mHGjaWfoypwK/gb+dpxaCLdAf7p7AOcq9eprbR6n
         yNU2PKRpwJrWb85pl/HshNax/nn4/q2C6KKWelcm/66g7L/40KW3tfYFzNy32iGLiKV7
         PzqscPvOE469UGUjL38rHD9cBXl3JIUPI0fSFopPuaNL8HsB8HNDzE3dJLZdmXDhaR8n
         GcOaf68P9FUYatYJM+XAfnMPI6N3muvueXb1c3xNaxKc/GgRR1H41k7tvN+JbUSmCq8n
         GKvdj8dUszIueMSaED6/T0ZBi1ZwNmmQ1KUwSbzydw03EU1oknm1EqHOobYDcwOiWcy+
         HheA==
X-Gm-Message-State: AC+VfDwjl+nRFBdq3ZkG/3FOA9YULSccDoWu+P/eZVJF2p77+52qZY04
        e5O7gX5iMdisjJmxQ3Vt3Elqdg==
X-Google-Smtp-Source: ACHHUZ4AfaeSpVY/ckQkqL5x95HhvZI47BGZCIoqkV64ZUEXQa8B+xm4b1XkP3o7H2cESv0dYCWcVw==
X-Received: by 2002:a17:907:7f10:b0:974:4f34:b04c with SMTP id qf16-20020a1709077f1000b009744f34b04cmr2114952ejc.41.1686048128277;
        Tue, 06 Jun 2023 03:42:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id fx4-20020a170906b74400b00977d0f1c5bcsm3115801ejb.69.2023.06.06.03.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 03:42:07 -0700 (PDT)
Message-ID: <636526b0-b5b3-aa80-49f7-fa805ebbac5c@linaro.org>
Date:   Tue, 6 Jun 2023 12:42:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v5 1/5] dt-bindings: pwm: Add bindings for aspeed pwm controller
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        lee@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        patrick@stwcx.xyz
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-2-billy_tsai@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606094535.5388-2-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 11:45, Billy Tsai wrote:
> Add the aspeed pwm device which should be the child-node of pwm-tach mfd.
> 

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof

