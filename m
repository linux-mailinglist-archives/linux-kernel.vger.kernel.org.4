Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4CA72EB31
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbjFMSoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjFMSoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:44:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D501BDA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:43:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-978863fb00fso1024327766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686681837; x=1689273837;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQ8iVB7gobTZ8BQruGLcdSEO5h1oBHrdRGDjmhAOvCM=;
        b=zU3Xo3HozTeKE1o40JuVJuq9vYtZ4EkEKet/l8SVVT5g1OrQjBJkUebse3tG6s7SDX
         PLVlkEXNkN/CNLyi4Ty9X4SUF4GA5pcxpmgzLJWPad7r/CpidbwM8AX4rCcNr09m863o
         oSgb7VCFnE1cOOrUF37Awdfwk25oNyxuHUMdacnLvA6BfA7s4Ww/xyuApzMqvorZgcvH
         hIh0pZFMFb4Ls8TW744q8m/gwrEdxVgwYkF7T1kE26OKfKxrEYxm5mmyoNVXFJaBvgY1
         uWHTzuNVeKISJjBaYC492ykbUs6NvEupl8oglBsB4R7/maa1ohnGu/sjDIyqBeJGLzk+
         A3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686681837; x=1689273837;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ8iVB7gobTZ8BQruGLcdSEO5h1oBHrdRGDjmhAOvCM=;
        b=eFTot/cAuWP4MJo5edaSySP5kIEw3FRVlIB0X6YGPYnH4Tj6bAymTKXYU5D3rF4ZEc
         Sv9e4/EuEQ//JYxekljL9Aw+h6414AcPffPV/w+WjuOyWg6rIDx62MaBZCrhIAGjhNg+
         YJ3vlkAzouCz2v0TMO0JnnRMuANrmlVzeQaTEXbfRqczKdnwyJevz9DbACHrRQgKNa5I
         IaNk3Ry8YVM6Rl1k9Rek87EF3m1vtC6uUsSnyxKRLYkq+4ip8ym+MgswLQ3UbqdbnfvJ
         IoRV89ojzSrayXtFKfelZHEz0MRM2IjWgM4biYTFHVEdWE3q76J0aaM878tFU9w12/pe
         uhkQ==
X-Gm-Message-State: AC+VfDyu5bvGdRqxgxwophmtMeQ7uP7aZvwNZ/ZEy20rADPA8xcRO5ye
        nr4m+n5TiLHfBSPWBpAFvH7YaA==
X-Google-Smtp-Source: ACHHUZ5TllWLsWtFnI+oG6zhMaKQWMv660yQOdw0v+qvTp4pkYq7CNN5Dieh3DdpBDIUsqEoNo8X+g==
X-Received: by 2002:a17:907:7f1e:b0:974:76:dcdd with SMTP id qf30-20020a1709077f1e00b009740076dcddmr16204308ejc.55.1686681837374;
        Tue, 13 Jun 2023 11:43:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n24-20020a170906379800b0096a6bf89259sm6962660ejc.167.2023.06.13.11.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:43:56 -0700 (PDT)
Message-ID: <37ef78ee-b290-ecfb-504d-cef5653d23f2@linaro.org>
Date:   Tue, 13 Jun 2023 20:43:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 0/2] dt-bindings: omap: Convert omap.txt to yaml
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tony@atomide.com, afd@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20230515074512.66226-1-andreas@kemnade.info>
 <20230613193257.267ad763@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230613193257.267ad763@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 19:32, Andreas Kemnade wrote:
> Hi,
> 
> any action still expected from my side?
> people gave R-bys...
> So looks like it is ready for the dt-folks to pick it up.
> 

It's SoC file, isn't it? Then goes via SoC tree.

Best regards,
Krzysztof

