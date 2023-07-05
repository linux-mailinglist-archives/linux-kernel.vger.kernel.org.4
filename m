Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5676274883B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjGEPoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGEPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:44:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABBB171D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:44:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992ace062f3so822192566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688571849; x=1691163849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5vEBUpWUCuta5/1f5gRl1+M0EKGhW3V1lB7XJ3EF+k=;
        b=JJg1F2R5URna+tIeK/iAeHiE5c2/AnVVR9CvDFLHMfAACxZxxH3XQzanyZzj63Ie+4
         b4Gj5hAI8e0b2pjlN7HI6jCbouVG80J8xS5tknPM4A8KVdhmSwJKlnYD1he7+41fGOlM
         bF4kquCu6KT6Hx0m3HDeK42XXB0nhmcFqyFiKXB1pNspKZFRAzzzaYkSNgQR9khwa+8M
         dq53vVWo0zn5GifDOnmi0uy0U+Y3QczMogd1HiAtU7zek8c9PKNU2k8U/guKpL3DoiAI
         b1W64eX7QIgK50xbvt7Xtkbx2p66rLW2oA51CE9RJFFzoMsgPyIfgClza1DCOYLHEdiK
         ehqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688571849; x=1691163849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5vEBUpWUCuta5/1f5gRl1+M0EKGhW3V1lB7XJ3EF+k=;
        b=Ey2tEzxCAHC/qwhTSxksm+dYlZIvibi/2zXgym08KU/G58J+k6urZq72zGcB+hv50u
         3Ik87E/mnTIIbX7r7CI3aVq5Ye4w5TjfvuzPo5J756oEhlT9CfKGUrrXj8BpUxPJKGy1
         SYQf8vED4rEUYoMfp1Y4Irv5/L+hIoNNgSWn4hOve7bRvt0TmGVhUYgK3mY9DUWsAe6y
         n213ozRl+6VNJPFFPA3cB7f0AHypmnNgjn9KMZKOo/Jeg7owswXaYPJeCi4mJT/hibQS
         PRXvAXNUFw6vPQxaAKZpIL6MpMeqY2edHBP6wH94RX7Kzej7O76HnWm4TeoXhAQ96Fql
         ZMkg==
X-Gm-Message-State: ABy/qLaRq8pWc/uj9O7FZyLf+5iBMwwd3LWLDXJI647n/kxDgTWTe460
        OTE5Tbh5u48N2PE1PgVt3/Jqxg==
X-Google-Smtp-Source: APBJJlGZEp0uGn6WBqqOc8heqRqV+lHFEryGyCTLeKlzIPOvYy0QwVnrtSmwgt2MSW7TKPFhPMDHkg==
X-Received: by 2002:a17:906:3bd3:b0:991:e961:a5f4 with SMTP id v19-20020a1709063bd300b00991e961a5f4mr12527613ejf.20.1688571848728;
        Wed, 05 Jul 2023 08:44:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ck11-20020a170906c44b00b009933eccf46fsm5599442ejb.6.2023.07.05.08.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 08:44:08 -0700 (PDT)
Message-ID: <45545984-ef00-f653-91db-cb6c1cb0a3a4@linaro.org>
Date:   Wed, 5 Jul 2023 17:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Nate Drude <Nate.D@variscite.com>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230704150240.2022020-1-hugo@hugovil.com>
 <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com>
 <20230704164140.824f6890dae5c87fc92531b4@hugovil.com>
 <CAOMZO5BNaQVMKbxU9rc5zOBwv9c+HayLnkjqrSgPKgMGzQ585A@mail.gmail.com>
 <20230704172801.f11422b3f947c625f53af871@hugovil.com>
 <CAOMZO5CWh0-5eMTBwjvNUrY-yOHE=daj6n-jAAfjWoV-H4rt0Q@mail.gmail.com>
 <CAOMZO5AZiuEAh6nJB8Oub83At6bsvLhzOhsT_yOniZSucrAUMQ@mail.gmail.com>
 <20230705093507.7458eada3ae05e0e1740a10e@hugovil.com>
 <AS2PR08MB88082608DB46EC1287C6E54B852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
 <CAOMZO5D-a4sUEqqsppjpgkCRFfeetY32+QP0CvrGw6v5q=J+KA@mail.gmail.com>
 <20230705102502.d8c9fa894bd271a5526d81f7@hugovil.com>
 <AS2PR08MB88085D6B7338AD6D4D3C9956852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
 <20230705104837.e620da576f22f28244daacb1@hugovil.com>
 <CAOMZO5D_p3hf+HVHNAijEevJRpzwmyGPcoHjiapsOx_ddsoksg@mail.gmail.com>
 <20230705113419.183f686f47252abf3532fc9e@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705113419.183f686f47252abf3532fc9e@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 17:34, Hugo Villeneuve wrote:
> On Wed, 5 Jul 2023 12:22:55 -0300
> Fabio Estevam <festevam@gmail.com> wrote:
> 
>> Hi Hugo,
>>
>> On Wed, Jul 5, 2023 at 11:48 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
>>
>>> Fabio: do we need to support both configurations in the Linux kernel
>>> tree, and if yes how do you propose we do it?
>>
>> I would suggest supporting the new revision only.
> 
> Ok, no problem.
> 
> If we go back to my original patch, the changes in it, apart from the
> interrupt, are still required to make USB OTG work (at least in host
> mode, so that we can plug a USB key for example). Also looking at the
> latest varigit changes, I have removed the "typec1_con:
> connector" node (tested ok in host mode). I also added comments in the
> DTS about the particular PTN5150 interrupt pin configurations.
> 
> Let me know if I can resubmit it, and if so can I leave the interrupt
> property type to IRQ_TYPE_NONE?

As I wrote, interrupt type cannot be none. What does it even mean "none"
for your case?

Best regards,
Krzysztof

