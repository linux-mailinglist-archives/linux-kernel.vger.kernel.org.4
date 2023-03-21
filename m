Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6056C2AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCUGuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCUGt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:49:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B633D901
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:49:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eh3so55670468edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679381378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d46q7mbE7eGvKOHkcknhDyVqT7e0qJyrZrZoT1VlZtM=;
        b=UW24cX+tDjHgGuES0CzY/aQ8qiV8T3Ex/HHylIOxDDw900b8rT1cCQkqFkoJpCLobN
         6wPjxlQE0+CXx4K7hxDTFHd/3OxkV5mzCgC5aqFPHg6y2MEc25fUG5HC+8EecJi5FT1J
         3N89Apuqtpm4jg3EDkLYv39zQ84Th5tIDu3GPPRma1IQdZbn07m8nq6BxZ4pUpQHQgMg
         85BF2WSoo/GYBxYxtLe8utyZaahlZftzxd/rGQ3Aik1i1dZeHkb0Q7gGBPpNUBzdv1n7
         C2q5Q22wQzpziRjZwOviaEq2ZsYFMC9d3zDNTqSXwBZ2lcHNRAYg75TxoEU2XSKvMnjJ
         SZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679381378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d46q7mbE7eGvKOHkcknhDyVqT7e0qJyrZrZoT1VlZtM=;
        b=6GO32mTX6IKNSzx0zblGmmSsRSisiqLSUAtF1CVfeubA+HgyPbNnXKiHV5pVnGZzUn
         cLE2FKhmdvqCYqbQebW3NvZOlPK8KCcQQJua8tdnv5OBKegiesqgxz2JMZ6kZffwqUwk
         bQRE8DTbgGkPTXIxwL3ihbbB/ab+RPWW/V7U1xf4PuT8RS39+VT0bvIVtRI92dxpWV23
         z4BZ3e7inrMxo3r//WZzXXLqopFxf8RWGfQOhFdSSFa2I6DCsxaKtcISnOUMXTxd1w+A
         fUH/NP+2y716xvCNQit/ai5PIhbRlQWQ/Bjr8JEQvuNgmme4yrynGwkyJht7TuXsJzOa
         Q6Rw==
X-Gm-Message-State: AO0yUKUYr4+oDNCxf7JFPmb6+X5fzlRTySE2vCeGE5uRyOZaE6xKulKv
        4QEVO6b09WiboEQlfuO9iAI0Zw==
X-Google-Smtp-Source: AK7set/KgeAkYLPx+137qJunN79pE3HjZQV5l2dycZzDA885FimWjCNPMtRRZWh/FHVwjsX9GBYuEg==
X-Received: by 2002:a17:906:b14b:b0:929:dc63:3b9c with SMTP id bt11-20020a170906b14b00b00929dc633b9cmr1797674ejb.32.1679381378748;
        Mon, 20 Mar 2023 23:49:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b00914001c91fcsm5345866ejc.86.2023.03.20.23.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 23:49:38 -0700 (PDT)
Message-ID: <d2889882-e44f-c0ca-9b46-65d2af1bc9f4@linaro.org>
Date:   Tue, 21 Mar 2023 07:49:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-riscv@lists.infradead.org
References: <20230320233928.2920693-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320233928.2920693-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 00:39, Rob Herring wrote:
> Signed-off-by: Rob Herring <robh@kernel.org>

You miss here commit msg. With this fixed:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

