Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A0D6E6933
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjDRQRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjDRQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:17:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB15BBA6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:17:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kt6so36464838ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681834653; x=1684426653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42KJEhE8WliDXadlwGw31IE1RyZkhHqOOOmNpPRT+PM=;
        b=KCkD5CmQO+t1OWUIJ85aTWtdR5nQVPCXThrtU2ULddBE8e55fIcm8G/6X+Q4FKMe4y
         /Cbj5yfUWNiLTjsezRegm89xel2eo/Qp9prVAL9S6+iXiFCaiqaq23dK2zI3CAS/uVMN
         AbwJZVGYLN/41maNVhvHPyCHNstzksL12POramTmvIP1zGhW/86guIamUiGrprf3oKkC
         ywDIGZPVlnxcR1rHVbAmK1NmHdSWmUn/ENLvc6QRp1m+rKoEBlxYhr4O5adG2m+0oe9c
         fu641DM9rWcBHmsO+KaQxGyZuw21UKh/O/ihKVt2jSoD0/7Ff4nvgtSZeyCEz8av1dMi
         zstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681834653; x=1684426653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42KJEhE8WliDXadlwGw31IE1RyZkhHqOOOmNpPRT+PM=;
        b=F3dBGNhwk58tXbpQcdXCj2GIEln027cQypzHiLT/VaVmzsjyihR6qk2dZW1j35wJrN
         Cm+MjPcN5V46/vLbVvuxRhT207Uir1kLhUxLs0iMhdHmZxAyTTe6CIVDr/AXlBZEJ4i0
         7OUKYM80V1mRDZUJSwSlBjfLtuw9RSK2GIe66GGi5NGqA1jC8vKvZ7XHp4EpyjrKFs6F
         zY9CQ41Au3pWMNoi3vb9g6lfaDf6fmdBG3f+E15jERuSnTr62HwqvwoO+YGytLhuR8tb
         lMMFOfYzxfOHFCfUpt7h8vu8BtDmvd72GY4S/xPojBiPSN+QOTaDNeaHhWa3Aj72660R
         WcVw==
X-Gm-Message-State: AAQBX9dxp7W5mzvzBZCLzh6O+VPtSp+Ms+6Zmwv2nAoPKxRRiIw0SZp/
        4n+CqO638wp6+Uo/oN+iF6WqAA==
X-Google-Smtp-Source: AKy350aBHyNXgj+nK+6tmXt0ir6hXeImF1Efi4IRwoEL7JHqQ/WlQDxsQIHb363ensKzw8OJfVFgWA==
X-Received: by 2002:a17:906:f14f:b0:94a:171:83b1 with SMTP id gw15-20020a170906f14f00b0094a017183b1mr11331041ejb.2.1681834653685;
        Tue, 18 Apr 2023 09:17:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7dbda000000b00506b0b80786sm2020992edt.36.2023.04.18.09.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:17:33 -0700 (PDT)
Message-ID: <742f546b-3952-32f4-9f20-3a355785d162@linaro.org>
Date:   Tue, 18 Apr 2023 18:17:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add binding for max6639
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230418113217.781524-1-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418113217.781524-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 13:32, Naresh Solanki wrote:
> Add Devicetree binding documentation for Maxim MAX6639 temperature
> monitor with PWM fan-speed controller.

Subject: drop second/last, redundant "binding for". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../bindings/hwmon/maxim,max6639.yaml         | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> new file mode 100644
> index 000000000000..20b28cd36555
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +

Drop blank line

This is v9. Where is the changelog? Where is previous authorship? At
least some parts of it? Why this has less properties than old one? Why
this has more mistakes than the old one? Go to previous patch... or fix
everything which was already fixed.

Best regards,
Krzysztof

