Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD1F6C018C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCSMXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCSMXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:23:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29FC2313F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:22:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so36867955edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679228569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLR4LWH/SEibOh12DRO8823NjnhehlvqpaFntdr6IBc=;
        b=BaGvJopYVCk3/1Du8VDyB/7EahUfkn1u+obdgIYhAAWCKZn0LmJ/2MInNnGoxareva
         gUhRIOUieweGthkw/zFsYwrRWhaTFnrhC9VfbNJSB9+KdA+J7ckEXiS0CizThCeVUrYM
         yTH7MyjbD4sdgTBrwB+59WeDFpwXtQI/bY16nCx8PLwIt+dmeRuKbFW0MRPpBvce3rZb
         0qyOVzTJMkDeixrev/LD5f+SQIaCDNyGpZ+g6NjSnKXW9gVBQMwlDyYkHUCGZ8PY3Yyb
         k2odni7UtBuFEL46+y9LfWbDwm5Nw6MAEgknawZXjEms0rWB1IPlamqbRfg+yt8SutEQ
         uwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679228569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLR4LWH/SEibOh12DRO8823NjnhehlvqpaFntdr6IBc=;
        b=yUF5kWdqtKXAT/sWdXncEdVjZGchjgR9eEvvfyWfyU2HdiMaLouwwxCELAyuq6L/Pz
         +63PaFmnyUowLZdtXpvyQQ6uk3WnyWULTAr6TU4r0kmjgou9b0b+M5dfWmEyYik0EcE0
         ujsxG0XDDNIBIoHpK+TA+p3V42nUUAQyTF7KfE2y5ZIjwS+DnGjt/E70I1LdcFDnkjbq
         /GXYjk9g2GIUtu5o0yXnX1LjOJouaDuggcP4FnMzjqcqqpvZWMvWiR+6pH2PtNVoyEtK
         fdCWf7EcOWhG8thF64v7y62AjWN+Z5w9aTN/Cp4Fwxpgb8O1Bo5YPoF7U0QX8dGColNf
         AWsg==
X-Gm-Message-State: AO0yUKVoVbZR3EffckSZDESYrtxDPynz+k/Ah7olUN89etrzS8X5Tcmh
        msmAojg4Ra+4Rd3TTmgHXGnhNA==
X-Google-Smtp-Source: AK7set/cKJxZGrZkBkAa3PIs+HYiS8gzKrsBzUIceteb1K7qEumRotlLR1CNftiwjvWSmddBXxXJjA==
X-Received: by 2002:a17:906:e08c:b0:931:d36f:8965 with SMTP id gh12-20020a170906e08c00b00931d36f8965mr6158222ejb.13.1679228569443;
        Sun, 19 Mar 2023 05:22:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id x93-20020a50bae6000000b004fbf6b35a56sm3459266ede.76.2023.03.19.05.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:22:49 -0700 (PDT)
Message-ID: <5a42e212-f03b-70ce-898e-ca0402565a44@linaro.org>
Date:   Sun, 19 Mar 2023 13:22:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: Add Loongson-1 clock
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20230316104707.236034-1-keguang.zhang@gmail.com>
 <20230316104707.236034-2-keguang.zhang@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316104707.236034-2-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 11:47, Keguang Zhang wrote:
> Add devicetree binding document and related header file
> for the Loongson-1 clock.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

