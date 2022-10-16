Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493276000B1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJPPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJPPcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:32:46 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9704F371A6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:32:43 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i9so6210338qvo.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+glJUn1rJ1Nz2wNZdUlNIAxnWRCwagr6ACf9glezJI=;
        b=klwSuUnkKoO0zTw1B5PLbnJhRCSHfBdQcpM3QHpPA0GC9UJTrQM0GTlzH0kQesQNZC
         IE1R2q7MFkYvpxl8yQEX/HzuVlt76Q7ot4aCoVcHlX0VMfHbhHba2+NjR/mZMLktBKwg
         +i4sirbI4oLqGOcYYZddBvMmMplvr8m3qOYDN60Zo7xyqHtoFzUuURvtd24O7bIw4gSv
         yupvoo5bHeeTm87Xy8a+tcFQAFhCQT8yB6gLaf5/KfznzQHR0nJnPl5u/yQ+PCcJaewS
         4vvOxWL5sleolma7WrGZZqPB1Rlv5NuHo+XFmaF9GA9wYbbffAdB/zX2fxeECcvM8/lL
         9NxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+glJUn1rJ1Nz2wNZdUlNIAxnWRCwagr6ACf9glezJI=;
        b=0z8/jb1Bfm7ikfRMRrSfMPI+3HQ5e6L9kkoTS9rqt9SKLBOxYA8Rk/Ow2lmCyhAH0M
         CKfUhV6CyKfpEIA0qFn1hNECWQO3BZch/3+qtnnEoTWS1uYa8f1C4ZElaIZxpXOK2Zr0
         R0iyhDEoICv+p/uRi6CsXT7OjQzkeFBV6pri0ZANuLB4Hnbfslehwm6u+jiVlleITnoa
         lIdaMGVSeMIT54madOKET/+J8kU08RZw0L1R08Vk8avXVUYSikaGHAS5mTBneUOl5uFc
         JK6u8CqyrW0BBtMnXLbJ3G7R5WpiAo2Bupu1CrKaeT/fqn59glgQWDf6ihkFt6wH/ej7
         o6/Q==
X-Gm-Message-State: ACrzQf3u/JxJlHHPF72MHkcwnO7UJLz5hiV9fskMBFGERPNCTdPEbNIx
        94D17i0GxcDWoRM3Rut9kEuCEA==
X-Google-Smtp-Source: AMsMyM6+xL+9BLXbh6JLTiiPjwMnLmR5mvBjXAqAvfz2PnC4/uaWBmYX29THEJDsXVqG/xZab/whEA==
X-Received: by 2002:ad4:5aee:0:b0:4b4:595:fb54 with SMTP id c14-20020ad45aee000000b004b40595fb54mr5383329qvh.5.1665934362813;
        Sun, 16 Oct 2022 08:32:42 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9b13:d679:7b5b:6921? ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id i20-20020ac860d4000000b00399d5d564b7sm5892803qtm.56.2022.10.16.08.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 08:32:41 -0700 (PDT)
Message-ID: <c2accc8b-f4eb-47ca-333f-eeb98da6a363@linaro.org>
Date:   Sun, 16 Oct 2022 11:32:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 3/4] dt-bindings: clock: Add Ingenic JZ4755 CGU header
Content-Language: en-US
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
References: <20221016150110.3020451-1-lis8215@gmail.com>
 <20221016150110.3020451-4-lis8215@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221016150110.3020451-4-lis8215@gmail.com>
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

On 16/10/2022 11:01, Siarhei Volkau wrote:
> This will be used from the devicetree bindings to specify the clocks
> that should be obtained from the jz4755-cgu driver.
> 
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  .../dt-bindings/clock/ingenic,jz4755-cgu.h    | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 include/dt-bindings/clock/ingenic,jz4755-cgu.h
> 
> diff --git a/include/dt-bindings/clock/ingenic,jz4755-cgu.h b/include/dt-bindings/clock/ingenic,jz4755-cgu.h
> new file mode 100644
> index 000000000..1ac13d61b
> --- /dev/null
> +++ b/include/dt-bindings/clock/ingenic,jz4755-cgu.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause) */

Why did you choose 2.0+?

Best regards,
Krzysztof

