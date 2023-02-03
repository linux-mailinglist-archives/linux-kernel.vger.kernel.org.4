Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E392D689101
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjBCHgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjBCHgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:36:31 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9912493AE0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 23:36:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so5385689wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 23:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TD/Y1Z4kQCwtHaIXKA9HLPOTgnBZyyqnprCD/yaXHA=;
        b=uiwZkzp5xVFNVdm8EAf5D+spaU9OwcjU7b4ygg4U69H1x/6oG/7g+4q4xw4FXiKyaC
         Xkmd9hfbtLFOjf0279AgKuqm8etCU9AcTnJ6mn94Bgzc5uWnaEmLYTMImrgszX/RIHyO
         06PeaQoS1ZASXm87EjTPpUaVg5pJalyz/Pl4PHs7TZpKBx02vcVr+30a+OA1BcNzcO8F
         92eaqO7YZeQvk+Jo4AGRF09qND7lQq9TXsm39nmhtlvpouQKw2lXcfTb9jguhjKr+ptP
         qFjHLpOxe8JrtPMQbajZiFHnHV1TcPq4nZriQxAnoJ0TE6Q20OFK+WYo/+xULH4R/v8e
         oRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TD/Y1Z4kQCwtHaIXKA9HLPOTgnBZyyqnprCD/yaXHA=;
        b=zi6LXZBsYGPOf6qndPsJ1trTWMhYrZ2ZLdzDRhTwctoozdOBFdS9pKrk5gp2RrXnFf
         moTXHEXDc9aWRYjA6nEH3t0eMnHEhxWYJ/OtAgLDhHsOMgd4VvBq2BnFpIXa4k6oxKHv
         mPgb47D3+37w6bQ1ovOMvWXKDMejIjdeLBfUgVqFlWyToEuz2rlXn61k9rW2PEKtscqC
         ZluKQ+pY2bnvuk88S4AE3MH2NtEnBrzJ+fcdxBchobcxoVafrBlEoaVvKEP2s/FQBxUm
         d+MC1vsWAH3ewbbbvTgV0llFpzNGTJCQAt60eFZ+Y+yvTAjJ6XsGqqJbtHkj4hAae2Ua
         ZMtQ==
X-Gm-Message-State: AO0yUKUdqZcjM97144srpm1leMkm9MiRAxO1Anzdp76fHJ1CXjW72cMJ
        WiIB+1qUAnt3yusxuRQ9uECIHQ==
X-Google-Smtp-Source: AK7set+RACG0nVav8h/xTUVinpm1e32UZqGS9HumhnkoNb+yg7MXeGZzYZvZLGWh3xNNSy5OcpswXQ==
X-Received: by 2002:a05:600c:3d92:b0:3df:e468:17dc with SMTP id bi18-20020a05600c3d9200b003dfe46817dcmr2717883wmb.40.1675409789177;
        Thu, 02 Feb 2023 23:36:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b003d9aa76dc6asm7598116wms.0.2023.02.02.23.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 23:36:28 -0800 (PST)
Message-ID: <8f356b9c-7e85-3e33-4f2d-d27ce52de13d@linaro.org>
Date:   Fri, 3 Feb 2023 08:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5] ASoC: dt-bindings: Add tas2781 amplifier
Content-Language: en-US
To:     Shenghao Ding <13916275206@139.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        lgirdwood@gmail.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230203040115.27321-1-13916275206@139.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203040115.27321-1-13916275206@139.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 05:01, Shenghao Ding wrote:
> Create tas2781.yaml for tas2781 driver.
> 
> Signed-off-by: Shenghao Ding <13916275206@139.com>

You got four times my comment that your threading is wrong. You never
replied to that comment that something is not clear. Threading is still
wrong - there is no user of this binding here.

Best regards,
Krzysztof

