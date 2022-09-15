Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B729D5B9EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiIOPZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIOPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:25:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A841A45F53
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:25:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id cc5so21585273wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=BHcfoRSqhikD1hOYg44uSOWlY3aFvjAHe7q8Qax5QmY=;
        b=QtgpMJ5u5NKyPnVF5sV8RMe62k5Pq1GkPk+H7kZxWT2atc1Zns1MUPWnp8WWEEAUXN
         2f+2bevcxW+hU2Zs1ZJ2Pn6G6DkC6HfXsJmkFIYeEQsiMfPaPMTfM1WBCzkT5Ebcrv6O
         G7pSJhoK0ymrDBryJIIvmR0SS9k8XgHB6vYFxlNmRzZoyKUvclDPnlfs4V0OWcaf8Zgz
         L1PMFH2hnOVB1E/DrkSu8jlhVDAYSXtZXk1fYbFe1yx0+BQfv7epwdHQO53c/gku3R96
         4dJgBHea6ALP8/wLjGgQPEvmbXEpcMM81Bh4nVWjyIk9tMm+Vp6pOl8U74N2skEreA85
         nkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BHcfoRSqhikD1hOYg44uSOWlY3aFvjAHe7q8Qax5QmY=;
        b=esEPBAXpWoFKxrWZ58Bx2QLLEGz/rk6D+ga7zeS0qBj0660bUX5zZ1OlDz3rxvOIlN
         /J8EUQDSqNNirt/1oPfMPWfOAMGGh4m6QD85rsRyJZhhFh3Ol0hj4pEBO8suRKoL2NOU
         TyJAzsnvTNNCpcQRK5EAby6bHTdFi+UYoLIKjkIjbqo2dSwwWNB1OY6PwbQ7xxiDUh3F
         sB31+QDMrGjkpXCG4FGfY9ip+CMU7nl+ukxl0SRigntwBXll/MmbKZmFzt35oxPJmXie
         EwBpsC7bOKmbcz9RAuSljoC1ZqPjBXtPbI58JLsybu/hb3pJoag4zgfdlr1kvhqvAg7c
         U0mQ==
X-Gm-Message-State: ACrzQf06eyMIdYfy1gwQ1089QnfOmxlIa1k80MxnoCf9IEkFrFhkXX8I
        qjf13GU9Z5opY1xU6Qn9szr2+THCe637dqTG
X-Google-Smtp-Source: AMsMyM6jbHiu69sUiE2afsrEB9VDk+2EF3IxK7ozsl+xHorAt3Mj1j34+HcOi0Wy/USm0LikBipx9g==
X-Received: by 2002:a05:6000:178c:b0:222:f8ec:9977 with SMTP id e12-20020a056000178c00b00222f8ec9977mr111630wrg.509.1663255547251;
        Thu, 15 Sep 2022 08:25:47 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.72])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm3834952wmq.23.2022.09.15.08.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 08:25:46 -0700 (PDT)
Message-ID: <bb932677-d7b5-a39f-ebb9-4a64812591a1@linaro.org>
Date:   Thu, 15 Sep 2022 16:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] dt-bindings: mfd: mt6370: fix the indentation in the
 example
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        cy_huang@richtek.com, linux-mediatek@lists.infradead.org,
        alice_chen@richtek.com, robh+dt@kernel.org, lee@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, chiaen_wu@richtek.com
References: <1663157936-5010-1-git-send-email-u0084500@gmail.com>
 <20220915134353.GA1168381-robh@kernel.org>
 <CADiBU3_6dXf1TUv9f7HbFfrqsfMUmT1Ejve6+O6OGnmTtxzpEQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CADiBU3_6dXf1TUv9f7HbFfrqsfMUmT1Ejve6+O6OGnmTtxzpEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 14:56, ChiYuan Huang wrote:
>>
>> Please add Acked-by/Reviewed-by tags when posting new versions. However,
>> there's no need to repost patches *only* to add the tags. The upstream
>> maintainer will do that for acks received on the version they apply.
>>
>> If a tag was not added on purpose, please state why and what changed.
>>
> I'm not sure about the rule.
> AngeloGioacchino said I need to add the 'Fixes' tag.
> I think it might be important.
> And I immediately submit the v2 patch and add the 'fixes' tag.
> So patch v3 and add 'Acked-by' tag?

https://lore.kernel.org/all/20220914150620.GA2221443-robh@kernel.org/

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540


Best regards,
Krzysztof
