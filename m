Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02F6695F87
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjBNJoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjBNJoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:44:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDB9D50A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:44:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bu23so14954946wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1V6X7LS4W1rOsDectubi4KTeJ0veVK4x1Eb4mq8We4o=;
        b=NTGB1A8hi0FI4d0n7r1u647W9aZjL6itDmVIUW6Qef/Ns1oCssg5+T4pgN8GuHwygL
         LfX5rXVF6PFKzetgUtNSE4/bPKphcZNhNKjBIyaHuwSjYlcESXyVbMAqaV9g8LELU0AY
         W8qgSlxQ1N8mw09qsWLJT+MB9dOxyc+mAxPhIqeanAvZmS+EB8PfpLpuxEZIPeGczM7A
         CQl8XppAmLLKLCwBznID10RjyS6VPpE4qRu1Gq6G41V3rlhchMIOapYbUmhI6SZ8t2g4
         ILlb4U+xDvkPk/bCrfwbDmAadV9uIOXEqG7QPbzVPu5D4k8M1YmPkRMnj19Lu8wU6BgS
         rhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1V6X7LS4W1rOsDectubi4KTeJ0veVK4x1Eb4mq8We4o=;
        b=Aw7pOUctoAp5jDQ7w6JYdFg8uwznUSNNBcZ4Fk1y0ZgA4MDcwwr/4bkXG1OCotlstg
         5M0dsKglBxXQCOJm1l307HiZCaoMD5HnYUwndHAEvznJPlDUyxY7bXQbo7s9CmP5pO+e
         KTulUWDnUQbBVkr13mNKue7BqoEfYIlkP62tBZqDCyhgSjhuT0sBY3tDPJgV4B0tRh6l
         CC6rTf6JhT/2lmN+K6KIFIdgydxMSM9Ou1eAtbL+23u+k2m29KEgoaHN3jJ/GD+yTGS8
         kRHd9cF0y/oX6W3+zD/HbceDtTlRdILJmj4aFbKhLg6LCtshg48GL7ENonYdoQYbEsFO
         XqoQ==
X-Gm-Message-State: AO0yUKUDCSNc0+i1PN5NqkJxLJZfrgOtsjMLATNUGFEAyHX5MbCQy+wm
        YdphBNwU6E2iy+kAtCMHqoXZTw==
X-Google-Smtp-Source: AK7set+MeaNJDHWeQ3lmWJpTPfV0TrfI0EEoITSixsaaKVn0LPBKNUaNqT/3OtyQiTgAXMzeQBqd/g==
X-Received: by 2002:adf:f712:0:b0:2c5:50aa:f89d with SMTP id r18-20020adff712000000b002c550aaf89dmr1335007wrp.42.1676367855108;
        Tue, 14 Feb 2023 01:44:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q13-20020adff94d000000b002be099f78c0sm12399605wrr.69.2023.02.14.01.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:44:14 -0800 (PST)
Message-ID: <5c67ecd2-075a-5b0b-feb9-57570f539ee1@linaro.org>
Date:   Tue, 14 Feb 2023 10:44:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 2/5] arm64: dts: qcom: Add support for Crashdump
 collection on IPQ9574
Content-Language: en-US
To:     POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        jassisinghbrar@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        robimarko@gmail.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230208053332.16537-1-quic_poovendh@quicinc.com>
 <20230208053332.16537-3-quic_poovendh@quicinc.com>
 <dbc93125-afd5-9ed9-7b45-0d79f728b4a5@linaro.org>
 <1a9ad881-7753-935a-ce7d-a2a79d34f16c@quicinc.com>
 <e569e7e8-4d7f-1e69-5a4b-ee4c4f83d7ce@linaro.org>
 <86bb95e4-2e07-19a5-7b4f-15f25067d513@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <86bb95e4-2e07-19a5-7b4f-15f25067d513@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 10:35, POOVENDHAN SELVARAJ wrote:
>>>> compatible = "arm,cortex-a73-pmu";
>>>> interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  >>> @@ -95,11 +102,17 @@
>>>> #address-cells = <2>;
>>>> #size-cells = <2>;
>>>> ranges;
> *>>> -*
>  >> I don't think anything improved here - still unrelated change.
>  >>
> 
> Are you referring to the deleted line here?

Yes, the line removal does not seem related nor justified.

Best regards,
Krzysztof

