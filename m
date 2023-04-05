Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F5F6D748E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbjDEGo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjDEGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:44:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5693A8E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 23:44:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-4fa3ca41384so185349a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 23:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PzMtt/+vqlhPhKEy36o5CActC8iYX52jJaVN8GSnXcQ=;
        b=LfovZoCG2SVqRXzMoF1BOW6WOu641pUE4VOtpxBuEznEagbZ24i0TdaKpsn5OhzW95
         8JqUDJPHnp4MFU4N79WFdH2qGjFH3+bj2EgkDosnGb+hC+NVENzgGI7cE4RzkaWW0UmQ
         1BvKC8+MTTiCDXrRpaF2XuaZqhkfcgRjUirRI0Ps9o9lj2J/9L1GNNUzSn6ufafNJCj8
         +0BRjxSq1yNNaPflfYv9CXvXI9vOT2XDZ1eA/i/WwAB3LQ0Nb1yrYI3kHQTtehA+VA+C
         OsUHrc0/CRyrFn818/QPhCuUsfuPRR0TiAsk/SjhMjeod/gJJGynLlT43WFmUpCt9jCz
         0hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzMtt/+vqlhPhKEy36o5CActC8iYX52jJaVN8GSnXcQ=;
        b=rprICGVW5gkwHtMZwfhcFnZWydrqwDVwCfWV8MIg9O2RqKI/n5jjp8E5Dp1va7oFTh
         z99U7cRaiAKAduBM9+pp35Kfu19O+wO2ThWabrvOGXbqDtYGBrCpp8qlOpSd8BE9Hydc
         U/rIv22r7aNv9nOjTJm9TROoMN11UNvh7LH0AJHSrpnx9RP/PhH1uVgNnVohnW8yddxk
         hIIW4G0hJ/mgrLnMUijIbpiwWZlXAaD+qHMiT3QFBMDuqpzJy1oEnNql14c3wTIsse9h
         QF5GkRQ7CVIYc6FYaQN6O9DldjQC2RQap7Uebx6cUGN77utketXSB+PhDarVvCA2F5g1
         ++Lw==
X-Gm-Message-State: AAQBX9ereaoNyD+2+7B28nBCit2/rQh/leARselQlqXiAmh5XjzOwiEu
        Cx095Tmy+gtYhcqrYRG9PIZt/A==
X-Google-Smtp-Source: AKy350byi1qoH8xnW36dqj5Cus1D3+6KM4I460DlQJAFckUuaVBla6hgAtyHzqnYArOvUhdOQBgFKQ==
X-Received: by 2002:a05:6402:10c3:b0:4ac:bde4:ff14 with SMTP id p3-20020a05640210c300b004acbde4ff14mr870989edu.42.1680677061020;
        Tue, 04 Apr 2023 23:44:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3f:6b2:54cd:498e? ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id z95-20020a509e68000000b004c10b4f9ebesm6829736ede.15.2023.04.04.23.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 23:44:20 -0700 (PDT)
Message-ID: <c674def6-f4b7-c6bc-6688-9f8c65c441b3@linaro.org>
Date:   Wed, 5 Apr 2023 08:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 1/9] dt-bindings: clock: Add PCIe pipe clock
 definitions
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, mani@kernel.org, p.zabel@pengutronix.de,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
References: <20230404164828.8031-1-quic_devipriy@quicinc.com>
 <20230404164828.8031-2-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230404164828.8031-2-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 18:48, Devi Priya wrote:
> Add PCIe pipe clock definitions for IPQ9574 SoC
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V2:


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

