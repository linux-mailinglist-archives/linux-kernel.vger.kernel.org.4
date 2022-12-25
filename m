Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA3655CFA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 12:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiLYL40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 06:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiLYL4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 06:56:19 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888912709
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:56:18 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so12838515lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oy3KTZRmmZDj4xApOU3vUmfi37HfOOVtyQiknilDRLI=;
        b=LI0JS6O1PtxtpBxePGHS4r6jgnZl71En4y256Wu3TVvgxjzMwXI0C8q2lHfYp/Rb+7
         7UjAyaNjpvTcUATGPx2HAIUFuYYHL/uYmalg1C9iKi3otRfxNtz9LGtOVtfw2E0zCkk4
         aZsuhvtcPphI8U4Os3SLQ/Y12+BOpOwMqtg8NzuVY23HcZWCVeLSBRywbP1szGKTD0md
         PFlbn7VhaG6sWzlYSON/g40zoO05CbLFw3GTLS/zLc2pM7gSS4h7JdHt0h7i7/eeFQcM
         jwZQUem0Z1iQpyCYf7MuXfAjmFL5JC9se/p9Fdf4tIOmhmOwp42lcVwSFMbW+nIaxq/s
         mbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy3KTZRmmZDj4xApOU3vUmfi37HfOOVtyQiknilDRLI=;
        b=U2meQuBFe4Hre29CtuzPj+Z43uO7sh8vjvCUcqhLiJeWTOmbWmss2Z4IqM20AdkuKo
         EC80UlhaWxNfsjvVKYSEdaS9/NQHR1hLwpVHsWgpFIR9LqiXDLhxfQSUAO41JE32/tij
         YpCAxNs0z+5OTdLebelnC7ceQCrA/NmgO0yh3lqZNBtZhPbguHYcRJ3VGnRB/xU1p83j
         NpWxs7dM9tUgESqFY0oXSoPPfRjj8hkR2IfMgxghBVRDlrvaP4RGYoKkDpkWHcduUfbw
         UcChWwFR4TfRYlgkRLVlDDEWaiCskze8TYq008WsDz9RKAM/tWXhl8wXpQq7kRYmmTXG
         CZ0A==
X-Gm-Message-State: AFqh2kpfyA0XXHTS0SKfwM9fZHaVcgGr7vkrzaB+T0muih8lJLMBQ4iT
        0VXdrtY8CTNU5pEi6aG6XUpzBQ==
X-Google-Smtp-Source: AMrXdXvTXZf26KCY23tgUobrWG3maSx8EH/B5TUzagwUnCZOjBtanKaIlIcDa7OhNzmX/KtNu046pQ==
X-Received: by 2002:a05:6512:1513:b0:4a4:a7d7:4769 with SMTP id bq19-20020a056512151300b004a4a7d74769mr4839924lfb.8.1671969376886;
        Sun, 25 Dec 2022 03:56:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bq8-20020a056512150800b00492e5d31201sm1322404lfb.7.2022.12.25.03.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 03:56:16 -0800 (PST)
Message-ID: <a65632b8-3303-c45a-8877-85fdf5527db0@linaro.org>
Date:   Sun, 25 Dec 2022 12:56:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
To:     Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-7-hal.feng@starfivetech.com>
 <ebb27bb2-158c-8207-7184-0d5b5ca0ce14@linaro.org>
 <d81cabc8-0229-1acf-03da-9a988a53a890@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d81cabc8-0229-1acf-03da-9a988a53a890@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/12/2022 11:31, Hal Feng wrote:

> 
> 	gmac0_rmii_refin: clock {
> 		...
> 	};
> 
> 	gmac0_rgmii_rxin: clock {
> 		...
> 	};
> 	...
> 
>> nothing. It looks like you avoid to define proper clock controller.
>> What's the point for all these clocks? These are no-op.
> 
> These are all external fixed rate clocks inputted to the SoC. They are the root

If they are all external, then it is fine.

> 
>>
>>> +		compatible = "fixed-clock";
>>> +		#clock-cells = <0>;
>>> +	};

Best regards,
Krzysztof

