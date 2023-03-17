Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B3C6BEDB8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjCQQH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjCQQHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:07:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8F77DF8A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:06:50 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r11so22379864edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679069207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sgtfxiu0i9YSBCZdlpmZ+23ZIgI7eVaV3XtK/FVd+sM=;
        b=eJY1iVeZGOr+E2fTTWDxlkIa3GYuwF1sUF/A/9sluy0tf/50AK1Rxyc0/mPYrXQ1Eh
         Mnz37ayxjUnSoeqTfR5DG3VuCPCIr9wnrhYxUuuLnzv/fRk1MufTWjwmjGcx5DvlbDq4
         jcDWglpm+nfIX1BHdiOiDHZ3nTVw4lmByY6I2EJXrABG3pzPMBzm4Yy4vTTaUjqi92os
         jmW03TcZQJhWuKtX7QIJ/ABI3GVhf9eT+JxhL1svUUJLNwQaoyzPXwJVEr0/fFQmvmsJ
         y2aFTWH9mihmLb1Swoeq0JClf6J2VwIvkUIXFUGVvmbwjR2ac4dmey4DJ8lTCVpt/6Rc
         y/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679069207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sgtfxiu0i9YSBCZdlpmZ+23ZIgI7eVaV3XtK/FVd+sM=;
        b=OIQH5OgnjFFnqtIQhcNArPXN7A/MuRWaHiAJg8OGDSyfv1HDob4K8WRjqjX6iFCfZ4
         upCVfoGiUsiRXj9MZUGCwmwHj6DtMaVw0A08+hLv7CgzOwWBdrWpUp6SrA174eVfDlaV
         SnffMH2C1Tb2W9E29IdnBWK5AKcXRiA9X7DPWZ3CxpOLVGH8MobPzcyRq0Jb/NerkK9r
         8uibTmInW/3zO9Glv5fqEMw9upGLmn/PvJFNDY5kLMjBXM0T2Zkp5BvHmq4mvB8Fj9z0
         JMNMMlBOyWx7rbrGnky41Al26FndPPaQ/Qd8asoruWquK4pXKfGAHLutU2h4BJT/OLXG
         +8OQ==
X-Gm-Message-State: AO0yUKVueV5oYbf39+Fs+Glc1KAlpO45B2LuNevPtJXPXr2ZdCCEbx78
        p4pRCzXniJuf8L9L7GuE5V3PwA==
X-Google-Smtp-Source: AK7set9DXGRx38/0ZQ75JqG5RLB5OpQJI77okOMQ6ZiwDKUDz8YsADPoF+IAPbjepZh+Wr7qLkJgDw==
X-Received: by 2002:a17:906:a450:b0:88d:9cf8:2dbb with SMTP id cb16-20020a170906a45000b0088d9cf82dbbmr15431897ejb.12.1679069207004;
        Fri, 17 Mar 2023 09:06:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d013:3eeb:7658:cec? ([2a02:810d:15c0:828:d013:3eeb:7658:cec])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906348100b0090953b9da51sm1124655ejb.194.2023.03.17.09.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 09:06:46 -0700 (PDT)
Message-ID: <a90fc6f6-df95-3a4f-da5b-ebdafbe7dd34@linaro.org>
Date:   Fri, 17 Mar 2023 17:06:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 00/15] Introduce Nuvoton ma35d1 SoC
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Jacky Huang <ychuang570808@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <f2699aa1-4d8a-48c0-b332-484db0b04252@app.fastmail.com>
 <1a1277ac-4ae5-eaab-01c3-0242c12be76b@gmail.com>
 <6ed7e89f-2d2c-4134-9c6f-a9d18e2fc8a8@app.fastmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6ed7e89f-2d2c-4134-9c6f-a9d18e2fc8a8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 14:21, Arnd Bergmann wrote:
> I only now saw that you had already submitted this several times
> at the beginning of last year, and this is technically 'v5'
> of the series, and it would make sense to add 'v6' to the subject
> next time and link back to the previous [1] and this[2] submission
> on lore.kernel.org.

... and address previous feedback. Or at least make it clear in
changelog that you addressed it, so our review was not ignored.

Best regards,
Krzysztof

