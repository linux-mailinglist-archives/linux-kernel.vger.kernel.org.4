Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106996DBA4A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjDHKzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjDHKzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:55:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7493C12846
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 03:53:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb34so2312508ejc.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 03:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680951198;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqEfLeDXZNOIU0Ym8bLPBaklfZZR/EMALqbAbDn4K1g=;
        b=WzYeUnbZwSkVfgT2CrnkVh+JL6KeZdv25ETiV6O+Q1ZOP2JwbGQKHj4lRVB9FrKgld
         6iYBbfEQQMNZcL92outmM+jeMSH9MTpetxtQ2qv0JW5Ykp9jIsYssDPm0w43ULD3qY4Q
         jhyLF6pVX0CCBUcKtsd147Vik2Molw86PSXZS6SWh3X0P+Z7ZVwbR6A8NlY2BCfTZSB7
         YTDgp7oMCDh8z9j7z+o2C78w99Aine5uAZHkmoJ6vhmUeRcLFYM/80ZVSkFZ/HXL18W3
         schAw2TCPgzOIY+Na/y6LXOlTRQudy0CHi4OTXu+1Sgft/hrW86ysoSGjZYSbHkCd7pz
         0pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680951198;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqEfLeDXZNOIU0Ym8bLPBaklfZZR/EMALqbAbDn4K1g=;
        b=AhDVNZhkHCD1u1iEl08woCnlW88oG+77l/BIUC2xd5/LkGqfYziZPE+owJJKLp/9qa
         0LJHgMdLIJofxJCYUeJZS3WviVMK6G7tr2pfncmZ7doXRjGxfRnJwav5MwOiuf0VdDkq
         LmvPiapL5yAsWEGqZJyB1mhpTjxj0Ns6TD5/4E3SaOW/RV7RSREw5oVZZX6Wh/BvTiDU
         TBzZmbXXOdG+YtGQ67TTzURy75N4zP1Qwh1TvUsNiuYm4MobtBGy9YLPj5jn38SeAhzm
         5sqj2Sjv6Eq7hGEAz7l6kssaXAi4AjPSsHHzY0/pztjPYhAoQ5m39/xQmCPYH+RM+xnD
         Kexg==
X-Gm-Message-State: AAQBX9cjGUKnoZe6aAco8jmEAXSqPSVvYp8r+owgjSII2bp15r9gr8KH
        2zAQ5DajYEU3ZN4icR6eoOhrog==
X-Google-Smtp-Source: AKy350brwvKRr2XJm8Le8NxR7+udN3B/U5Z43qJ5QMgbow+5WBEqJRT9bM4w8LY3WAk0+kSZvPtoDQ==
X-Received: by 2002:a17:907:1116:b0:886:7eae:26c4 with SMTP id qu22-20020a170907111600b008867eae26c4mr2223627ejb.5.1680951198156;
        Sat, 08 Apr 2023 03:53:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4c06:aac9:100f:9d7f? ([2a02:810d:15c0:828:4c06:aac9:100f:9d7f])
        by smtp.gmail.com with ESMTPSA id fy8-20020a170906b7c800b0093e23d03d72sm3058439ejb.177.2023.04.08.03.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 03:53:17 -0700 (PDT)
Message-ID: <4fa9fe5d-d7a8-e372-154f-a685e162af0f@linaro.org>
Date:   Sat, 8 Apr 2023 12:53:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] dt-bindings: mailbox: sti-mailbox: convert to DT
 schema
Content-Language: en-US
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230214204945.4215-1-avolmat@me.com>
 <9f2debc1-6040-3182-5945-36e668eac171@linaro.org> <ZDBruk2t+gB0lSEL@imac101>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZDBruk2t+gB0lSEL@imac101>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 21:15, Alain Volmat wrote:
> Gentle reminder, could someone take this patch into his branch ?

You addressed the email to me, but I am not the maintainer to take this
patch.

Best regards,
Krzysztof

