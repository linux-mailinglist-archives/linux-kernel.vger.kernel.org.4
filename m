Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419B86F7D77
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjEEHHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjEEHHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:07:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4D5247
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:06:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so24284102a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 00:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683270417; x=1685862417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjfIWaz2gKRzoVKJjzHFLE/kALzLbCnUyuP1dmCYAVI=;
        b=d1VizN4V6/3O4uEpv+S4T5YPBFM2rUIG+XF8rBnvA6F38rl5wpigfZtIuuratw+dyC
         9TPRSlrh4V/QeKsViv8K3lccrvz9jc/b0kkG2s60R8bI3nSvFtNjaOOEJ2Dm26WR+O60
         yVWhgwVnYYcd2u7doDTPZQ6D1MLR3giGkAVWNpO8HhIUlVqgBWw61gjoP3CBAr4k+2w1
         Pwcd7jCz9WvM8k6Nb+F7FBWJLAAZD823hA0pjto4SoBVNIdcql/j3RsmTNcmGW6SFEsQ
         +3ILIkvYYQ1JUz0CPb6kI+eQCBSXTDEFQuZVGMlhd4syd6KnQ40KBpPwF78wfzB7AaBG
         bneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683270417; x=1685862417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjfIWaz2gKRzoVKJjzHFLE/kALzLbCnUyuP1dmCYAVI=;
        b=Gev43BrfhjpXdv4Q7r7vWX7olE6roteZEiyWCMnz5qmhD0LbcfhREEgrZ6lK4HDhQO
         rqY35pFPhe7iioCTnCEzgkn7x3pljNPKV+kuB/khBGwicinrwmkHHzGN5q1o1oPwu1pu
         7A0SRjonOP+nOdzz4+Iw+GOMM3MhgMY81nkKLWz9VUO+Rp5umkPdZkS5jUrXriSj8Cqi
         90ov/f9DIh4UQpiy5w0Q/5HSZpAWEo9DEWqKujoljbfjwjj3hErkYhA0d7DWJ1s9Pt6x
         4TCN2b5dI+na4hNagO6Q/Ybup7mozI9cPBMB7kgZ2h1nIJaiqNmP9uAjvxh9mPSZWxXH
         +L2g==
X-Gm-Message-State: AC+VfDycP6p2rFEm8kTDlf5XPHih1Ub7axL8uk2D6SDKzXU56MdLplY5
        SFfZWVc1hxoFB1d5ny3pHeHVTw==
X-Google-Smtp-Source: ACHHUZ5pADaESc4yUyQqzDmrW8k5y2W5ZEwHwYqa/Hr7jtppAyVLG4ZxOomYMGL8CxmzSVLE6YAXzQ==
X-Received: by 2002:a17:907:3209:b0:94e:4b26:233c with SMTP id xg9-20020a170907320900b0094e4b26233cmr587324ejb.16.1683270417622;
        Fri, 05 May 2023 00:06:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090686cd00b00965bf86c00asm540956ejy.143.2023.05.05.00.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 00:06:57 -0700 (PDT)
Message-ID: <c2cac92c-a71a-7b8d-6697-35fd4f91e462@linaro.org>
Date:   Fri, 5 May 2023 09:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/8] dt-bindings: nvmem: rockchip,otp: Add compatible
 for RK3588
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Vincent Legoll <vincent.legoll@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
 <20230504200648.1119866-3-cristian.ciocaltea@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504200648.1119866-3-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 22:06, Cristian Ciocaltea wrote:
> Document the OTP memory found on Rockchip RK3588 SoC.
> 
> Since RK3588 uses different clocks & resets configurations than PX30 /
> RK3308, provide the required changes in the binding to be able to handle
> both variants.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---

Thanks, nice job!

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

