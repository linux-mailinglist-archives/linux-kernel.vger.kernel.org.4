Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD9B6E6A48
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjDRQ5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDRQ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:57:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93011FC6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:57:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ud9so74738638ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681837064; x=1684429064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VI0WMlO2xYNMQAKdCpEGsXw436pR5EG2FkuvNGMrydw=;
        b=UJjL8vFXWaybu1wf1K0meao8ghuuQ1ZGHqLOXb9dpyheefxJ4a+d/o+XveBngVzX9O
         VzIuhMg7ZmfwD+7HWvdrmJAb4uZhSPHf4ISEpooCp2vmeWjk2Q6/wqLpOsO81q9nzq2k
         8eWTj3Fz/uGigYii5L8Bx2od2e7O0+mfsqceGlR/FfpH8kmVOTjRm1q1S7EfmiqgTY5b
         i6quge6mJmE/TFZyD9ae7k1uuoII86YiGZSVXd0W+vcramXD4DBEZo3Y8iThXKEi650s
         LSzkxrMRu5fkWWSk3VcKE66stuguBa+cJxpJzm9NjbdyDZZZMZoGERLxzPVVNBKdW1kX
         hSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837064; x=1684429064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VI0WMlO2xYNMQAKdCpEGsXw436pR5EG2FkuvNGMrydw=;
        b=BOEyv6mHYqGGqFu/sxjyP61IIQO6ZbEN3mguO86I8ouKZuDBZ2q+BPDuiQjtRHZM9j
         M+pSr3p753vbrGDllazl3vifX7p7PaplODJm94RmQx+4D7t8N9q+wLUP5fmhrEucm2m3
         uThEHZGI4eYV4YWCRaxdNZQ5oD0Z+m9BM3/pXwQGn2NyHzvvRBGctm7+SOLIUiPv7R/q
         kCeG9dKlKSJuSWMp6q3FEkP2QdDmhMR22rQmJA16xuTZC+SJjJ/DukA6cTqainjCDEnB
         9vfXgrK82DvTCIdQM7HqyZstRadblq4apEUiDoR1lzReSqVdXIBgXfx4U6LQshh9cvVV
         8AHg==
X-Gm-Message-State: AAQBX9fYGcHTBGeyosVEeG9sAhQNL92qaSYrFEYCN/M6sgUVmxLuZ70A
        eiUzBqiRPhw8vff/O8zS3i71+Q==
X-Google-Smtp-Source: AKy350Z6dsl71qLw+dcmIFRyIikpLSU3KXm+0CmK9N2WGmSJKkD0/6fetY+gBZP6o5HFeA8OXcJzHg==
X-Received: by 2002:a17:906:6d15:b0:94e:5708:a1f9 with SMTP id m21-20020a1709066d1500b0094e5708a1f9mr13795757ejr.39.1681837064334;
        Tue, 18 Apr 2023 09:57:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090665cf00b0094f54279f13sm3999483ejn.157.2023.04.18.09.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:57:43 -0700 (PDT)
Message-ID: <c71923b0-4c50-38c0-2cf5-4c3decac2367@linaro.org>
Date:   Tue, 18 Apr 2023 18:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/5] arm64: dts: ti: Drop bootargs
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>
References: <20230418165212.1456415-1-nm@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418165212.1456415-1-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 18:52, Nishanth Menon wrote:
> Hi,
> 
> This has come up multiple times, so cleaning it all up.
> See [1] for context. AM64 is covered in [2].
> 
> Nishanth Menon (5):
>   arm64: dts: ti: k3-am62x-sk-common: Drop bootargs
>   arm64: dts: ti: k3-am65*: Drop bootargs
>   arm64: dts: ti: k3-j721e-*: Drop bootargs
>   arm64: dts: ti: k3-j7200-common-proc-board: Drop bootargs
>   arm64: dts: ti: k3-j721s2-common-proc-board: Drop bootargs
> 
>  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi         | 1 -
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi     | 1 -
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts         | 1 -
>  arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts  | 1 -
>  arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts  | 1 -
>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts                 | 1 -

For the series:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

