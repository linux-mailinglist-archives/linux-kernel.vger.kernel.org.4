Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B8766007A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjAFMpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjAFMpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:45:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9E769B2D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 04:45:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t15so1161466wro.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 04:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khPmDzOyxE/W50Ody7PwHzpUcoSlWvXrUU0o2jFfLxk=;
        b=Fvsz5yRrcMX4nxoWRAXgOW27XaqYBWwY/JJP4Fojd5awfjCnzaOBcg5ufYCfqbDjGo
         uriwH7YQ+Go5EIRB9pOhU0M16q5ShJ8HZjF/BzJUMEtBy4eXSbsBrrUtBU9MWxQgAMcD
         TLc8uuMvd3SHIb7wl7LZZ8wT4KB8+CYXOMoGVRveeuBbnImDlUWpVINhGAu24isKgTr6
         cz6bN4U1vkJnY0d9ngCJaMj3QKWdru2dGZtObkMcm7WNXRfDxA/4EAbQTmoVy2Vr+iE4
         hBMHq9xY5COTWPBPdhY+agc7wN2vYeD3HdG7AqGDTRx82Totq6x1B0PEHhPuYONTVnMt
         C6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khPmDzOyxE/W50Ody7PwHzpUcoSlWvXrUU0o2jFfLxk=;
        b=bdUG3b+ZbVwdmxVaTIUuyeBUBi6SShh60XRoDgj+gxGTqZU7Iil/2QUfhhiI65b+NY
         kosPhJpfag2OKONrOVQjM5uFKNrNaaEBUSxOOcoYeR2qwMHt+MG0BPxiUK3JEaV65gPq
         npUTS6+vrizQKy1QJZNc3uWnlAHJcukbUmFpQ12Xxdz1JXHlNVVuSA7X4/AlbiX87RcE
         tB+emt266l7LToqBZsysEtrGon0bpxsrW3Qv4Kc28F9ifvBKBqCQjefzfopoXSccm+og
         apMHS+jmOL1WmZS289e10aeytWFHASUE2Rxem0MbvutYMH9w4IuDKxv7Qqjlis0OoEEr
         smGw==
X-Gm-Message-State: AFqh2kqrYytIRdrXPOg11onB4sSDxcFqOlgyHVBsVSvDVBM8aKJ0/w0u
        r8CmiXcnP1jkJReK17a/PDQ5MQ==
X-Google-Smtp-Source: AMrXdXuoIOO5FVUdypctPo2dsGnGrRrAcBI04oxEbt1bBMpKVgLXEnDGKxUhk1TmLa3v1vFVO23y7w==
X-Received: by 2002:a5d:4249:0:b0:276:d612:4bbe with SMTP id s9-20020a5d4249000000b00276d6124bbemr33577771wrr.38.1673009150157;
        Fri, 06 Jan 2023 04:45:50 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f8-20020a0560001b0800b002423edd7e50sm1100348wrz.32.2023.01.06.04.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 04:45:48 -0800 (PST)
Message-ID: <c114239e-2dae-3962-24f3-8277ff173582@linaro.org>
Date:   Fri, 6 Jan 2023 13:45:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 4/7] dt-bindings: net: Add support StarFive dwmac
Content-Language: en-US
To:     Yanhong Wang <yanhong.wang@starfivetech.com>,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
References: <20230106030001.1952-1-yanhong.wang@starfivetech.com>
 <20230106030001.1952-5-yanhong.wang@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106030001.1952-5-yanhong.wang@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 03:59, Yanhong Wang wrote:
> Add documentation to describe StarFive dwmac driver(GMAC).
> 
> Signed-off-by: Yanhong Wang <yanhong.wang@starfivetech.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 113 ++++++++++++++++++
>  MAINTAINERS                                   |   5 +

Order the patches correctly. Why this binding patch is split from previous?

Best regards,
Krzysztof

