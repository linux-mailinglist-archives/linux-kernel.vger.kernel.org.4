Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E0A72AD7B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjFJQkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjFJQjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:39:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7713C12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:39:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977c72b116fso424592066b.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686415154; x=1689007154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IYRNaZZWvIO3JyhV4C5ts/iImEde7OfTy8GQTAVDiq0=;
        b=NRTuQOucr9g/g0w9Rn1gblcRZDMbm9wB3TOFDPjKnGQZkpLvFTRd6UnmA4u7x+zRj8
         Kk0DTGui5luvucKTcoMW+Kvq12rbRbcMt/1HQX2T/vJeesfx3WgA7CXw2wJFqsDm9Ovi
         P6+RxlGE5uxW9KVTcFHQW1DDZvldHJbzMxD0/kLRr+Ap2tQCZLrragyrGi0MNg/T9HN+
         8Gw5fbCqDmDyBzAFEBNRwy0tOdpBn15OgvGEZG6NI5sF66Rzb5QZjpKYNv6YpvHIQVvW
         eCFWu84WtrRdSkVLaCy/bKoeBi4OAIR0ChSfgOnnT7G9HzeOVjV3weGnuuD0yla4Ye9A
         U5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686415154; x=1689007154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYRNaZZWvIO3JyhV4C5ts/iImEde7OfTy8GQTAVDiq0=;
        b=CL17PcF0q087nwysftg2PMTuT7pYuRzevnlnxB9N938Nne22oVsEan9nkJCa2EpMdW
         qVjZife+8DzOEMMawGwLE/36UUmHn8K8ricHc5JWIW977x1nxI1FQ97pL0QSmTnIewDC
         y2lvExoRHhOtJgNro8JUvxpw5MwahHnDoOSjNAyeuvVMXdvJYuKfJsGjl0edJowOJzxu
         CLDf7OFIAl8GOc0R5r6iAB+5NlrqaA5ZZDEV3WkEC1s3Xs+DJPxboYERwJkriO+901FV
         g6iiQNFy5AKXtQ+/ucXsfOxriX0Is1fEcjJXwyuhHWMrvmqAws8Od6fcYcZ7jH+IY0ZX
         EOaw==
X-Gm-Message-State: AC+VfDyKMMiCt1H08GrkwW0ey38YNRVZmiL7APdJT/gZZZKtlTFFcOlB
        hVRIR5FQF/2cYKoonV7E55k0Uw==
X-Google-Smtp-Source: ACHHUZ4RlNWgvJaw5Czsbg2CvOrwzUP7dhxbLbAtcji3Fh6iECuh9pfdfKxpju0rExcl1Z8DC50kzA==
X-Received: by 2002:a17:907:7e99:b0:967:5c5f:e45c with SMTP id qb25-20020a1709077e9900b009675c5fe45cmr4491929ejc.0.1686415153969;
        Sat, 10 Jun 2023 09:39:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lr12-20020a170906fb8c00b00959b3c30f2csm2715157ejb.222.2023.06.10.09.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 09:39:13 -0700 (PDT)
Message-ID: <9f0a9234-b453-69a8-859d-84c0d43a303e@linaro.org>
Date:   Sat, 10 Jun 2023 18:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 13/18] dt-bindings: clk: axg-audio-clkc: expose all clock
 ids
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
 <20230607-topic-amlogic-upstream-clkid-public-migration-v1-13-9676afa6b22c@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-13-9676afa6b22c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 12:56, Neil Armstrong wrote:
> Due to a policy change in clock ID bindings handling, expose
> all the "private" clock IDs to the public clock dt-bindings
> to move out of the previous maintenance scheme.
> 
> This refers to a discussion at [1] & [2] with Krzysztof about
> the issue with the current maintenance.
> 
> It was decided to move every axg-audio-clkc ID to the public clock
> dt-bindings headers to be merged in a single tree so we
> can safely add new clocks without having merge issues.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

