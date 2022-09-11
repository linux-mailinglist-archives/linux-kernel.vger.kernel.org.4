Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE39C5B4EE4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 14:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiIKM7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 08:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiIKM7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 08:59:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F3B22B26;
        Sun, 11 Sep 2022 05:59:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y3so14412316ejc.1;
        Sun, 11 Sep 2022 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Uz9r2eWONtKsHEc45nuRwjLQaSEnYaSN+H3yaDixtHo=;
        b=FWXsQHN4mwLVy85E12S3bLPp8EehpaI85PYbm2LZeoQ4eGX75liYzcKKzfUu3r2qei
         /nMfOP2DUosUvMpAKL2cDgdCB0JyLl60X/TyLGtXSTzry6jl1xxc/9lf/svsjCGxmbvo
         1mwV8pvcwo/DWehZQbTIdFE2Qug3gStUh6LmYHbT4VC0/lzVKGnD5UotKWtHtR1+YF8O
         J17vAO25LAQu0ZidWMfX9cDR3H24GG+JNwdHd6RwqD2L+miAqttY0KJ1kXZSLi+s3Em3
         TGvjsv9SUawq05eKt+NKnUOi6zhX+UQT6wAgibZxdX2W98YKic1m52yKal8JmbhvN5Ib
         WV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Uz9r2eWONtKsHEc45nuRwjLQaSEnYaSN+H3yaDixtHo=;
        b=VpyAxiP5bRlkEfv3nCy1w2C88DzUlwvHAL/03MV9AzOvyydbpimg+0r4I399AN+KPn
         8jKPZWiJX6uxKSuZixgvFHS7m8+/tED2ieyJDAiWhbEthPLCsoMjNlNIwe4PL7ex/Aen
         975P90O+IGwYEDsFvWYQQ8ZCqMmtiZ8H1Y5A1YSfvBGlb25t/9mr7par2njeA6/Eda35
         tN6zOeVNpqaPgBzP16Eh512G2nSm+MInDI9RpxUh8lh6iPm8OIWRJqDambGIF5FXg0M0
         49hjBnNg/ffiln4VI14gW667FvV3wl/HtJhz+hLXEcNE3P/QNpwa9NB4CdJl6bMV8Drx
         rwGQ==
X-Gm-Message-State: ACgBeo1QhU0rbQg9zqD/QjA8LOyDDnGNmD72cmIpQXWhrywZDc3/bwsi
        UfoUxa5Gj4j8DUmMuzEgbwnQ/mTFaSb0rg==
X-Google-Smtp-Source: AA6agR4h4Z2Y0RuzAcGEjuZl8NowapDiXMwJCUwCFppZAVfEhPFCdS1JDkkeYBLIDKghQspPRM7y6w==
X-Received: by 2002:a17:906:ef8b:b0:730:d348:61b9 with SMTP id ze11-20020a170906ef8b00b00730d34861b9mr15609215ejb.350.1662901138723;
        Sun, 11 Sep 2022 05:58:58 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id fd2-20020a056402388200b0044ed4d02483sm3867048edb.67.2022.09.11.05.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 05:58:58 -0700 (PDT)
Message-ID: <732d13e0-07a6-3b22-23e3-32f20cf7f750@gmail.com>
Date:   Sun, 11 Sep 2022 15:59:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 01/40] dt-bindings: pinctrl: qcom,sm6115-pinctrl: fix
 matching pin config
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
 <20220911111200.199182-2-krzysztof.kozlowski@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <20220911111200.199182-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 9/11/22 14:11, Krzysztof Kozlowski wrote:
> Matching PMIC GPIOs config nodes within a '-state' node by '.*' pattern
> does not work as expected because of linux,phandle in the DTB:
>
>     'pins' is a required property
>     'function' is a required property
>     'rx', 'tx' do not match any of the regexes: 'pinctrl-[0-9]+'
>     [[59]] is not of type 'object'
>
> Make the schema stricter and expect such nodes to be either named
> 'pinconfig' or followed with '-pins' prefix.

Well, now you don't allow pinconfig, so maybe tweak the commit message.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Iskren Chernev <iskren.chernev@gmail.com>
