Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E0C690229
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBII3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBII3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:29:38 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC804345A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:29:36 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r18so861225wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 00:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziWX5p/72UywAdxKA7LNDVxrSwnr4vdR8atBrdNzFXI=;
        b=CWJOky25KIedq/9uyGXCkMRtXy/cA1pMTAhHgYHIbvrIoxGsi1FYT4UeeW7wd4J5t8
         ve+Poz9HImIfylmFcNA00hITJie2JN6iHHg7qd6cvj2bWXbmrYEZmiltvKz/vj9twXMR
         Tzak8SVDvXXxTCc6leh1xvgcJvpzll1xS82s6QKgn4GuITzx+hF4cdfH7TgCcSkdwtZG
         V0PQJwCjBi2AwrvXvSc9dx0hyqW0+p4C7zuXnKPuM5Q+/HOnUiNgnABR3k2mUIV9Tvik
         HugXpzoXqc4AObyGiKyqSyEgfQCxQdldHxkTwHfP40qV6/TnMr8r5vvllLhKh63kNMAX
         rAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziWX5p/72UywAdxKA7LNDVxrSwnr4vdR8atBrdNzFXI=;
        b=cYzNta/V2nglZ8IY83dTCwYuYZASQ8tVD79MRK3/kYywtIiR0OZw+t+tK12LZojKH1
         pJW0/iriSSN5SvcJG/ca1iqmEExTfN1kRUP/NBGFsiYGGpsBMIen8kW1tpVBUm2TKBUx
         CbVAWgIAva43WVNzUNuP7+ZbU8iSUilA/nSf+hw256x1Hk7m7VUTpVbkYTJPuPNyfXeE
         CzJwQXzixFasPH5MuZmZJfqhAcyUtlkTRrq+G1iKF00euHqwVaEDKq8+inMjf/DzWuov
         GRAEFxgMYIA9thXJOyHkd5KtxeU3u4T2u1akPxFgzcqoLP9RElaCrUtt9o9tAU0hSZ0A
         BDEQ==
X-Gm-Message-State: AO0yUKVzW6+Exsgq88m4McmVdpqpxkOZEeuAKvXS934hYqQPSxnc9bvM
        IFbTmzdDhrQRL0kgy/VXkarY5Q==
X-Google-Smtp-Source: AK7set80Xla51urku0oSo1PvVBBpHyge+nEKhUAH8UQFTzY+CAHZdNTYGErugAkfMC3jB4y9zo3Tfg==
X-Received: by 2002:a05:600c:1d17:b0:3dd:1c45:fe3a with SMTP id l23-20020a05600c1d1700b003dd1c45fe3amr3586584wms.16.1675931374990;
        Thu, 09 Feb 2023 00:29:34 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c3b1800b003dc41a9836esm1190012wms.43.2023.02.09.00.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 00:29:34 -0800 (PST)
Message-ID: <59efb87b-5f97-a409-46ae-095ab03d01b9@linaro.org>
Date:   Thu, 9 Feb 2023 09:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] dt-bindings: gpio: nxp,pcf8575: add gpio-line-names
To:     Trevor Woerner <twoerner@gmail.com>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
References: <20230209041752.35380-1-twoerner@gmail.com>
 <20230209043100.1508-1-twoerner@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230209043100.1508-1-twoerner@gmail.com>
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

On 09/02/2023 05:31, Trevor Woerner wrote:
> The family of PCF857x-compatible chips describe 8-bit i2c i/o expanders.
> Allow the user to specify names for the 8 gpio lines.

PCA9675 is 16-bit and has 16 outputs/

Best regards,
Krzysztof

