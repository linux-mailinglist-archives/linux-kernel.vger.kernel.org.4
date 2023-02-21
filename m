Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECE269DECE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjBUL1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjBUL1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:27:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43814274AE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:27:13 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f13so15259575edz.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ETq34b+8/4BiKKBj54uxKBTL+zouxa+WZyrIv2vhc4=;
        b=d7lROgunoVvoE0v+39bzYr3dX2eNRLypRPfua5vQqf0uyVkgiCHdKSgSwmSjjfST/f
         ne4omh5LS9UUUR4zoZdD7GtghFwntlo9r4ZRdXIihSRm1kwSb204j8gVsL9hDoS19hDx
         QqJ/d95Uqho7+SfE6n45R8/acVE5V409dNsYTV5GsEklz89eSbcP9oxprDB3uPpFOskd
         inLd4wP2b8jZybpFN3OHXbuyYgmM8PU1s2tXuRRVCIrWN3QWLbl1lWV3lO533/SkroGK
         kQSLyhXqNVUvYhOcF6kqSY4zlLss5ck/8lwRRDTwXlt9DU9fKcnvWDfdQ6qv0xhA7JBj
         ruxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ETq34b+8/4BiKKBj54uxKBTL+zouxa+WZyrIv2vhc4=;
        b=CwPnjGWo4pZG0GZK9HmAo1NemTKVOG+SPiymMidY3UE3GMAHAlRJsGX5cpe1jcbYQw
         8hjzyaIsNkqUrtM8QUWGzkCLwPuSZZ4pi9gWaYSY+YtjNU54CLm7BQK1oNoEN90szhoT
         oWriaptRzJ5eh6hK++P9TuDoYF8L5yeErjcc0NV/vpAIIJqbqChFFO1WbgRfS39FvyZ8
         UGyK5GGBhBJVOnSL4mHae9eVg3B8aN75LpArexXlkrpVbTaanwBIzVT6OTpSH8BMt5Lz
         g9vgBXQ9OZCBDOEBisq5rnqEvvUtI3V53+Xgk/wYLgJjVwS+vLpavhJ6HrhXjkbpLNwo
         6FYg==
X-Gm-Message-State: AO0yUKWXBPc5fwo83KAlDmWBj22q1mjyeOjiBnGeY/SMUoezBguUIimu
        YRMfiGRLcjXMo1Ik3pyq+4eyMw==
X-Google-Smtp-Source: AK7set9Zkid+Zm3lzIDo8TDy9R/cdO+SwqsnhDqTyk4yhEQW4BIqgECPIrajKiHdtjkWj+oSarHJgA==
X-Received: by 2002:a17:907:7288:b0:8bd:dc0:3834 with SMTP id dt8-20020a170907728800b008bd0dc03834mr13639700ejc.34.1676978829402;
        Tue, 21 Feb 2023 03:27:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709066bce00b008cff300cf47sm2818085ejs.72.2023.02.21.03.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 03:27:09 -0800 (PST)
Message-ID: <ef4437e4-6f88-2f4a-6af2-7cee0b402fea@linaro.org>
Date:   Tue, 21 Feb 2023 12:27:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 07/11] dt-bindings: clock: Add StarFive JH7110
 Video-Output clock and reset generator
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
 <20230221083323.302471-8-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221083323.302471-8-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 09:33, Xingyu Wu wrote:
> Add bindings for the Video-Output clock and reset generator (VOUTCRG)
> on the JH7110 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-voutcrg.yaml        | 96 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 22 +++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 16 ++++
>  3 files changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

