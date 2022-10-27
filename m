Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D560F7FE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiJ0Mun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiJ0Muj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:50:39 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260EA48CB5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:50:37 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g11so994513qts.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybgHkyPF+h7dJ20qYdKfKJv6J92DUAxMTSyFP2z5UJQ=;
        b=p2QnzXhclEA1PPVQOaTd00ydj0ppMq36WsuzwzleJlv1hDxYCc2YUUj61cmyodPgFR
         /WOHBYv5NUDLqM+RiQ7r6e+go6BSrrTYbFYADycuCbsbzp7Y+tfqN5UqG5WMPX194zC5
         2cg3B6OHPmkJsAfI/2DxmVEcOSY390ZthE1I47MvPQHDR7JPA9TVqCcMY09DqzyzrCWm
         iOwiwCdkmWkszLJ4MFIJkA85Q+nhaMmYChvC8DFdW2vZlUy/uAe+aNX7RNc0AUduuZ7y
         5aez2rY4+uRci600k1OkhWBxCTIoMMArPI1HfE7WEo5QD6giN/1E/8q9pNy55bjkEOSa
         l6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybgHkyPF+h7dJ20qYdKfKJv6J92DUAxMTSyFP2z5UJQ=;
        b=y7MovT99kRjZrqonCAewoJ//Os/ZXBpB3LlDmwHZYYhQqGu0lzLzRp5eCevXSKN5FI
         KR1ecfX/qE1Z3ewWIxrCVoYN8JaWTC+PKLpMXMIzj+/IZqZzKnuLs/DcrAztjHpn//Vh
         vDpUBcLWXfIS2p4EUKC8m9uhgPuPSBvM9ngAiaAkSF+HJYxmsdUtZ5wj63iuDml6HQhd
         5cd3CfaFx6vqLNJx1vRk6LKLdiPMImQTSOcfs4DPc/pFHg1SS7w1AfVlCkpslgp+f17i
         rTxPMXw6b0MxmQTqHsqBfVHF460y0+kfWeKb5JLIK7+g6shzpJqqvp4J9wD3ALxaNC6V
         hroA==
X-Gm-Message-State: ACrzQf2zW7pmaBZhVpxeSVpPza/XpINvulz0clSkM0LLSN3cA8YqImPw
        pp5LIwSlGlRnDVBztR98KzhfM50J4XArUg==
X-Google-Smtp-Source: AMsMyM43k6BYP8KnvoNas5bRzwItpSUpFoE8MGkV6xELRyB+O4EgiMZLav4IFjTOal7En6y1teBwqQ==
X-Received: by 2002:ac8:7d55:0:b0:39b:ef52:a79e with SMTP id h21-20020ac87d55000000b0039bef52a79emr41084801qtb.658.1666875036305;
        Thu, 27 Oct 2022 05:50:36 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id q11-20020a37f70b000000b006bb0f9b89cfsm895839qkj.87.2022.10.27.05.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 05:50:35 -0700 (PDT)
Message-ID: <bfeefd8a-4ffa-70a3-b0df-48bfb8cd7124@linaro.org>
Date:   Thu, 27 Oct 2022 08:50:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver
 support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20221024014209.5327-1-zhuyinbo@loongson.cn>
 <a5a5c18f-476c-2f45-8cd0-3c88b3aa509d@linaro.org>
 <841bad76-e19c-e400-e46a-2a83986c29eb@loongson.cn>
 <9dfb7434-dd62-64e8-7831-b797687827e7@linaro.org>
 <542e661c-5aa3-a855-889f-6deb8a74584f@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <542e661c-5aa3-a855-889f-6deb8a74584f@loongson.cn>
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

On 27/10/2022 04:20, Yinbo Zhu wrote:
> You can find these code has a change in this code conext.  I have a 
> feedback on this code.  but I mistakenly thought helper is dev_err_probe.
>          res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>          pctrl->reg_base = devm_ioremap_resource(dev, res);
>          if (IS_ERR(pctrl->reg_base))
> -               return PTR_ERR(pctrl->reg_base);
> +               return dev_err_probe(pctrl->dev, PTR_ERR(pctrl->reg_base),
> +                               "unable to map I/O memory");
> 
>          raw_spin_lock_init(&pctrl->lock);
> 
>>
>> There is a helper combining two calls into one. Grep for it in headers
>> and use it.
>>
> You said is that use "devm_platform_get_and_ioremap_resource" as a 
> helper? sorry, I will do it.

I believe the helper is devm_platform_ioremap_resource(), but I never
remember the names so just check in the sources.

Best regards,
Krzysztof

