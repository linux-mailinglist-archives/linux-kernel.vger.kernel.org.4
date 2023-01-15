Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD9266B18E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 15:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjAOOfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 09:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjAOOf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 09:35:29 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FDA65A0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:35:27 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so62621205ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DMuIH5LG2Ixkb3oKpryjATK2iwStMCn/u2ZA+n6gcS8=;
        b=BgwVzXD0n3KGXA0DkPiJuIUd0XhBqL41XcLGLS3BXVxEzzD3IHDUDARxXhrNM34vHx
         OCOk66fh1zUpjlKFSkcvWrUFtpR6uU701TB9mf4MVsp6EwgLWZ5OyQag9yr+lHGaujn1
         aJLSWXFBN7WuDwuNTXvYU1QWRSLrhJrAf3m2ISFcF7knkLlXR5AdvHi+W5ZesxD9MzMj
         CnqVMWLz2lqWPSIFkxoN/JddaCnACYIwgozkw+HFeraVRQqTZ+deoG+8/SX8wJB7jQBL
         aqqOJ8c8yDSoSncz4+38X3E5biDJSlEwjnqjMrY6Z3uah0AtwvOIbh7Q0eG7lGqFuvga
         yXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMuIH5LG2Ixkb3oKpryjATK2iwStMCn/u2ZA+n6gcS8=;
        b=X5W0ZvXiH6YcbN3TxB/bbzJv4o/ZbRux+Ukm5pCnqwH+m/1AyWUvrHUhiHZbV6+hx5
         apXtWwQbLKXlIzk0tuNOE2pgXQGEN5/4A9axG0mCZs69PCCrBM6ZoGLHsfSQfR/du+eE
         0r29uY99xerO97+xO3Qkvg0sxd5AqrXfHVtxgaKxQvZK14kZ+OwvGa4q9ITF8k7oW3Ty
         W09ZVBgaHRTbVm5jKpA5K9rl+IhSStgKZ5LamA3WM+gI0mY6T6x//vae2lMdTagKd4t4
         6KXrt3XKdxrECzllA+7ip7satuN45pBueQ5fQFtaojCSvWFbDJAMbcOxmuZb7F5tBEHh
         K6OQ==
X-Gm-Message-State: AFqh2krtVIQd0NWvFceHGqvTGcptgkaQenqKYz084IXswp3etiBwLoT1
        A8ZYWt4IlPXzJJ3707Wk90dpxQ==
X-Google-Smtp-Source: AMrXdXsKlT6DeiXdPYqVuF4feQTf1Ore6dkf4nNfirTPjsdE3vBPGR0y270Pizq9p+u5Bh0ry55icw==
X-Received: by 2002:a17:907:2c61:b0:86e:fccc:bc19 with SMTP id ib1-20020a1709072c6100b0086efcccbc19mr3609305ejc.43.1673793326201;
        Sun, 15 Jan 2023 06:35:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id wl21-20020a170907311500b0084d37cc06fesm9623940ejb.94.2023.01.15.06.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 06:35:25 -0800 (PST)
Message-ID: <063c5516-417d-7c21-b58f-a6552779a621@linaro.org>
Date:   Sun, 15 Jan 2023 15:35:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: clock: qcom,a53pll: drop operating-points-v2
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230113145859.82868-1-krzysztof.kozlowski@linaro.org>
 <e73ad320fafa1365e3506bbd4cc77d8d.sboyd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e73ad320fafa1365e3506bbd4cc77d8d.sboyd@kernel.org>
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

On 13/01/2023 21:28, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2023-01-13 06:58:59)
>> The CPU PLL clock node does not use OPP tables (neither driver).
> 
> What device is qcom_a53pll_get_freq_tbl() operating on?

On its own, internal table. While of course driver could be converted to
operating-points-v2, no one did it within last 5 years, so why it should
happen now?

Best regards,
Krzysztof

