Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C846B66E9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCLNpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjCLNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:45:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1E44E5CC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:44:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x3so38612469edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678628689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbMZJnirmlCKS4zMh68O2ig0pYgKhtCGTM1+G1KObrg=;
        b=DXgHIAoSCsCuHyVLIkbS6zSi5sWkNBLlFp2PIqt/AT9osywqWWeTfWYAEW8npGZjyG
         WZ9TEqCqJEg3hhVuPiTJ2+K25lDEgQc12SvaOgiGKTksJtu/cCV5H0P4ruOFM7zZ2iv4
         MGbdUGf/f6F77bntbmobCBcgoAUrfKrBBOqEYVJ9nkvsH9c212Msw+Ckj8rm1sxs3vD+
         EQpkxDWdH2Doc5YvD85RU7C8wDsyzIy/TxxJTh9sqW/ba5fZ1Md+skA2N7tsirlgAmeo
         7+tZHku8CJDdXh2+5+t3W7J6kQWnzHdOYGaFnha9dfsecm3BFAh9XaFPnEqdIxbjoYNj
         zRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678628689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbMZJnirmlCKS4zMh68O2ig0pYgKhtCGTM1+G1KObrg=;
        b=OPKIf2lebO6sGaK62cpW24izQ7ZrsXLLa17czHlorRqA92f6uoCFMk1MHtdy0CblUz
         1lIZ55FXO3bwZxhp+tgmZSWo/YkLPwqsorwQpWwc8phNb3Sw3k3S9G4eVEEOR4Xq/eMx
         bC7lIspqJAV7HZuTXUG6n16dt7uLvp89MUuf7ZIxLExfTbYtg26mg+p92YCdwJn1DB0Z
         fprHZpkWPGbxjbOWaV3pBC0flgN7DbcpjZ3/BPMrmxFE9m8ZQcVCICIbOOmTPDjQGprk
         biZktv9XvrZvYezBrGvVWF3P/fqvHL+J/1X5mLxM0Qgsi1GDsrawwrNE0PdLFYQwGVvO
         2hDg==
X-Gm-Message-State: AO0yUKVBJVrAe9WSm3MOEvy+P3xb8FFJDItsTrkGxhaq9ObRvL2QxZMr
        GefgdNWioLIa9rjBwQNBwNwhZQ==
X-Google-Smtp-Source: AK7set+dmT1UNk8s4QIA5xdiGzs2ee3MFK8ZRRn8Dx1L8PUc3w+S94rzWwTf+3LP/3gEjgHBc/p6Fw==
X-Received: by 2002:a17:906:4783:b0:8f6:dc49:337f with SMTP id cw3-20020a170906478300b008f6dc49337fmr41183414ejc.43.1678628689144;
        Sun, 12 Mar 2023 06:44:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id wu5-20020a170906eec500b00927b85e48b0sm397962ejb.111.2023.03.12.06.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 06:44:48 -0700 (PDT)
Message-ID: <e83ccb7d-cc08-181b-e354-af6b1de34ff3@linaro.org>
Date:   Sun, 12 Mar 2023 14:44:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] i2c: mpc: Use the i2c-scl-clk-low-timeout-ms property
Content-Language: en-US
To:     Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Ryan Chen <ryan_chen@aspeedtech.com>
References: <20230312131933.248715-1-andi.shyti@kernel.org>
 <20230312131933.248715-3-andi.shyti@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312131933.248715-3-andi.shyti@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 14:19, Andi Shyti wrote:
> Now we have the i2c-scl-clk-low-timeout-ms property defined in
> the binding. Use it and remove the previous "fsl,timeout".
> 
> Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mpc.yaml | 12 ++++++------

Ah, and I forgot: bindings are always separate patches from driver
changes. Cannot be mixed.

Best regards,
Krzysztof

