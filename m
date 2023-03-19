Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9076C018F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCSMZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCSMZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:25:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135D112BD0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:25:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er8so25146243edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679228709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2ctBh4ChIBF5WYyxX2AuUgLXf3/Rtr+EA5UEX+4mc0=;
        b=lxoheOqvZMAIGC53kvgTC/HcHCS5pajkH7b5BWNZVtEddXubylKUZHH3Z/OAV7jqNZ
         mWunohAgLAQUzqR16416/oNnLaiyKG2Tejpq9UVgXep+rdap+E/VpH4E9IQ+2e/lppiD
         Jzl4leltTZDImsJQta7griGFVTFSRI0O1ZbpBze0I9zO0+UWSHnizjCGXrK4xUWg+Rhu
         nXDxbH4Bt75oLIAILvDBh5vc/wqXFBbWMkttq/c4yVPN9vz6LyzKlT1BDVTSBAZC/Ykx
         pWKbgIkB32veVjNq0hUkMdgLs4GWbU4Vqd1aRaMl4HBoBmWIKE94K+/rJofVrwo7Hxmn
         Dcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679228709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2ctBh4ChIBF5WYyxX2AuUgLXf3/Rtr+EA5UEX+4mc0=;
        b=XfOk0wsT/3mIVCoZX3/6eUWI9yRW+fCaWLyfxhcWpIIiAoExKEJTk1nNp2kzJT0JMp
         cHkWcl2XWMHXv7UJmxsyo0xX6orrogAiFKFstgsg0G8f2H/8nwgz6Iliva2x0Bx0yx10
         t8BJjl1HtpVW09H1VD0VL67KOX7mpBVRqUxR1Tv1b2MSF29sPEPDvMYK/ZABAiBz/K8M
         kACqVXdg4VsHI47A5ZHih0u9SgdCUSLnB9EVPxstEQcDvpbMDkcrcDVaik2I7SrWIXJh
         IR2qJrnfyVr5CfeebIF4dhqmP2BAKoisWBHRqllRdKWYuewrzjqg+4h9jChQH+3esC7e
         uAtw==
X-Gm-Message-State: AO0yUKXvejkw6sH8kypiQAw4fWIVh/Kzi3tHgMOUeqsVWMRG3gjqJi3e
        lY9h3mhjjM6Y1j6MI1iNfxKpLA==
X-Google-Smtp-Source: AK7set8qgDn3tu70r+zsTJ9r+rEhDtm1GXC//7IxDL8CzckgSnHKYf1kWtKfoQ5k0QYbaLk1eE9ydw==
X-Received: by 2002:a17:906:fca3:b0:92f:43a2:bf7d with SMTP id qw3-20020a170906fca300b0092f43a2bf7dmr5303345ejb.73.1679228709628;
        Sun, 19 Mar 2023 05:25:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id jz15-20020a17090775ef00b009334edaed98sm943147ejc.50.2023.03.19.05.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:25:09 -0700 (PDT)
Message-ID: <95b1f70d-b7ba-370f-12c4-bf7a518ffe3e@linaro.org>
Date:   Sun, 19 Mar 2023 13:25:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: Add StarFive JH7110 PLL clock
 generator
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230316030514.137427-1-xingyu.wu@starfivetech.com>
 <20230316030514.137427-2-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316030514.137427-2-xingyu.wu@starfivetech.com>
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

On 16/03/2023 04:05, Xingyu Wu wrote:
> Add bindings for the PLL clock generator on the JH7110 RISC-V SoC.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>


> +
> +examples:
> +  - |
> +    pllclk: pll-clock-controller {

This should be just "clock-controller" (and drop the label).

With above
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

