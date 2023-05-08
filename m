Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EFE6FA31A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjEHJR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjEHJR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:17:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAFA21558
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:17:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc075d6b2so8192358a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683537437; x=1686129437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aT/uFog44v7hpe9khQhwWHiG/nU5zZuhtL/MLZy+P0w=;
        b=KFBWvKtd8EkCKNFrYmQPvtrs8JoO+F4vhM5jslgPgiFIxcsG6/OTdhe8GQkrEqjM72
         Q5Wbd7d1G+mf1VwHBuNK+wW0c1XRSvB7Nt565PeJ4bdiJwZFMhMIseHbTZ8rfsTqzJgq
         rs79IL8R2r6o0XPY39KZ95lVZTgU7pjdM42/TLnlqV6F6cn7Ih1jyOm7kMD0WbGFp1HR
         2SOpbS6RVms+lWJI5U3dxbK4Lx3C7uIcWfJ9cOKYqlP/Kf2z3KQjVe4jWHauMSgPZPXK
         MuRiVC+aZTUlIDJnkLnn/SLZHjFSQObUfRPhkpx7rtk0zG3ApLY3K9K6uxgPKVhE/4bw
         sPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683537437; x=1686129437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aT/uFog44v7hpe9khQhwWHiG/nU5zZuhtL/MLZy+P0w=;
        b=kgjkPkwf3Fgc21BAsnu2PpDhn27MU+WaexZK9fvV0l6FW0b9g77BoHsc8h8sTiIXJ5
         QIbVqGq5L6tTMRkzWgQ51tge5BrzKUPn1jWwu3on/cdqZDpcyrFKz8IuEp/XFd24kr8v
         Wzq8buoMBXgxaEEyVGnSBxNP6vIoT1ZR01zg9PTFskB2nHEup2kn1pHXJ7zgFaAgxJuK
         i4c867Da2fJN1xfHU26RBqwGsku/AvV+YKwOfQpXJ5HToCVppA9jvxkL3Olr7G5tK6pv
         N4X6CMxVDk+YhEPQeXRymqErOu+ioH4fAcCfXkXOph49cacijnSB2SrdNw3JL56Gy5M0
         RL9A==
X-Gm-Message-State: AC+VfDyuSIQbM6YnLNmzkIP1v3tg6ZxLBFkLNlh9vXIGMjGSoMkwHjeg
        RroWxC3pW+/0bCa4fF+Ombzctw==
X-Google-Smtp-Source: ACHHUZ5w7QnqTgHovRPNxpPaDJe6uCeFRlRxrvq/cwBsXBwk1T2v4ljWDc/la/6PD4AxiWyiwYXCzA==
X-Received: by 2002:a17:907:6e93:b0:962:582d:89bf with SMTP id sh19-20020a1709076e9300b00962582d89bfmr9026804ejc.55.1683537436956;
        Mon, 08 May 2023 02:17:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b00965ec1faf27sm4341570ejb.74.2023.05.08.02.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 02:17:16 -0700 (PDT)
Message-ID: <4375d93e-a21b-3dff-9d1e-44aa9637eefb@linaro.org>
Date:   Mon, 8 May 2023 11:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/5] irqchip/sifive-plic: Support T-HEAD's C910 PLIC
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-2-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230507182304.2934-2-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2023 20:23, Jisheng Zhang wrote:
> The T-HEAD's C910 PLIC still needs the delegation bit settingto allow
> access from S-mode, but it doesn't need the edge quirk.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 4 ++++
>  drivers/irqchip/irq-sifive-plic.c                             | 1 +

Bindings are always separate patches.

Please run scripts/checkpatch.pl and fix reported warnings.

Best regards,
Krzysztof

