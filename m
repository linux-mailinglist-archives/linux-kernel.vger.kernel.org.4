Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3CC62F5A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbiKRNOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241935AbiKRNN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:13:58 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D684B99B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:13:57 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p8so8122304lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mC7g00gLN2qAMlY7fOURh7m2CYVc3PZUkw88havBT0=;
        b=KUfK0birxVBcDUOBbE0GJqnRaBPKLSm+SxEy9mV65Idlfe+gcbMO4qUSlfx9puhdTS
         zhTCV8yeu7coT9jsq8qymHCvanzzFG5KEdDLyrJikxS6fRnjg6KnMM99CGMvBaEylIKl
         OGlOwrAe0du0GT4UWEU+RHH3MPsgp6zBP4QjtzxCm9eLuIPbeMbXT9Ff5qV1Rsq4Dcct
         uxpiiQbyT+bUlRqfLd2JTjkkaL35QovXHguOEIz4KpV4C3vm9+Mdz3C+Ten8ZTRy66vf
         qXiac6ILU5reQZKFFFs6FsCYEKmaabSKzCydfuV73sy0ue0mibGAgR+kZVYIRq4HSTK4
         hDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mC7g00gLN2qAMlY7fOURh7m2CYVc3PZUkw88havBT0=;
        b=De4pTRRrpYo+BQzZHjEGMUDUuh5AZbVuaNL6Db2pUIXQJpuolXvwb/qIcIoygZ0Xnd
         sk1dEr1sBhsonnRxEzeEeBCIiE7W5imhHGwm94CXqirXyQ7QDngLoF2SGVT5pFY0wgNJ
         bZwdNnkEiPMkIPW5puOqfi7mrV3v7UFFYfJWtdLMfIIu+nNH3C2ss8Ee1zMn79/7N/X+
         v+QgJimFGo/+3xKRzeZ1MdUTaNPbPO2dmrhbCziz5ivbxwVFbX5L0rjZdEq+iWvk6vAB
         7//pcwPv/vND2pmS5UI7BJF6ncHt238crRtqLXrUb+qgM62SXBXF0trwiggxkc6JmHBk
         5lYQ==
X-Gm-Message-State: ANoB5plejGffOdkvXifq40btbP8Qr1GNtcUDS62tRGa6SN/Ty1+yDlut
        oE7YHgX1mPqNp//wVJBQBxtHMg==
X-Google-Smtp-Source: AA0mqf78HbKGQTDOE4+BiDimvNgdVBquA9KsjqNs1WBwaWJLdYE6jZKT54YGJ6xe8zDTOOCYp1M5xg==
X-Received: by 2002:a19:4918:0:b0:4b3:a78b:2e7d with SMTP id w24-20020a194918000000b004b3a78b2e7dmr2359952lfa.363.1668777235606;
        Fri, 18 Nov 2022 05:13:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g23-20020a2ea4b7000000b0026dce0a5ca9sm649802ljm.70.2022.11.18.05.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:13:54 -0800 (PST)
Message-ID: <1707d9f6-47bf-c611-7484-7bcabe3c872b@linaro.org>
Date:   Fri, 18 Nov 2022 14:13:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/8] dt-bindings: riscv: Add StarFive JH7110 SoC and
 VisionFive2 board
Content-Language: en-US
To:     Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-2-hal.feng@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118011714.70877-2-hal.feng@starfivetech.com>
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

On 18/11/2022 02:17, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add device tree bindings for the StarFive JH7110 RISC-V SoC [1]
> and the VisionFive2 board [2] equipped with it.
> 
> [1]: https://doc-en.rvspace.org/Doc_Center/jh7110.html

As Conor said, I think Links are preferred. With that:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

