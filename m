Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00702701E48
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjENQo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 12:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjENQo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 12:44:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C713C28
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 09:44:54 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so104500990a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684082693; x=1686674693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rINqlL2c8jKFx65s1S5lPme8A0ex2087xMbzH+6dEqQ=;
        b=G0kkmhtRbuMAFyz5REUm85lg8GVuIkgDeDSSH9vb8lQNxaEYtzlJSwVLr4+WXYi976
         uJLBhOoX/ti6pWc6runOZxS4loOkTJv/vcors1Phcix/U8R1c3xc3Bd5KcL+vRTmIlIU
         bVoAUrjIg1o+wClpXqlON3C21pkWNq7/Sr4+yi/gQIWtlY0nluhHTYPszQZPSZG/GvDN
         YCPce5ULfTeDkg1rp1WWnghJe5dBgpvvdozC3ihlLEGpuEtPVuDh+vNQzu0sqwLCS/ln
         agh4tEw2DxvCi1upnBY2IH43eqt1COezkNJECcVdsoIjsG5rnvh+Zzcq6NOlbN6DR4NC
         U7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684082693; x=1686674693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rINqlL2c8jKFx65s1S5lPme8A0ex2087xMbzH+6dEqQ=;
        b=MoJ1LkL8ZRkEybuAElZ1S2UUj1UKuS69DVjZB2vaiv9cN705xh+kVNzF4UiROiSYvh
         c+HdzUPssOwOlxT/GxGxF/bteNoYKCXwJ3n3VLdw47tmfsWFzO/0TkI38h1Paiote14h
         92JzLWlrd5Vd8MOYQ2UGgenNtWyyJkF9J9ZSelid3IjDcJd4Ly19YzTsdRvdzOaO52Fl
         kgj+QJHn6igerU/bm5bDMAymiNyK/oAmnCdWttU8f6J97N7xKa71UQIpqAC5kETVTeXR
         TavMXyhlZzedrpxndXNnYWXlH8f4Hg+l8YzX9A+lRw2ByQHEnvlNubuM87jXl/a5zuT7
         HQXA==
X-Gm-Message-State: AC+VfDwLdiwrgU4md6Nt3uc40eUXMugTxmMK103hvNr6QAOIgSmNSKh+
        ssX7Uk4+t2d9uHTa62t6MuTk9w==
X-Google-Smtp-Source: ACHHUZ5/WyRf2UuM4SE6FMYjH1YFSP+Bj1lt5YCVb26J/gTV6zGBKP0EE75wnp8npwWVo/oUULu+kQ==
X-Received: by 2002:a17:907:6da5:b0:94a:6229:8fc1 with SMTP id sb37-20020a1709076da500b0094a62298fc1mr28689766ejc.31.1684082693433;
        Sun, 14 May 2023 09:44:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a146:6594:d73a:8280? ([2a02:810d:15c0:828:a146:6594:d73a:8280])
        by smtp.gmail.com with ESMTPSA id hf15-20020a1709072c4f00b008f89953b761sm8311624ejc.3.2023.05.14.09.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 09:44:52 -0700 (PDT)
Message-ID: <4d9944f9-b42b-fc66-8fc6-081f4a689ea1@linaro.org>
Date:   Sun, 14 May 2023 18:44:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 10/10] dt-bindings: Add rt5033 mfd, regulator and
 charger
Content-Language: en-US
To:     Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230514123130.41172-1-jahau@rocketmail.com>
 <20230514123130.41172-11-jahau@rocketmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230514123130.41172-11-jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2023 14:31, Jakob Hauser wrote:
> Add device tree binding documentation for rt5033 multifunction device, voltage
> regulator and battery charger.
> 
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

