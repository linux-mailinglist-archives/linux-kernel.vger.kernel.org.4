Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191486C5FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCWGvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCWGvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:51:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3842F07E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 23:51:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id o12so82296978edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 23:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679554271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tIZjWm9sKRagEPKjK84TsBRf7m9t25oj2pBtFrP5+ZQ=;
        b=zyFOBBXWmTNAEnFt6lrv2U9OHERun2E94vudb2+b6UJUe5OfM2X1sb8K+ro9NS2xNn
         ZW7Ue+MBY9mtc3oQ5YGOWUpOhM0Brr84KtXQD55vhr4rBPERlg2hVoTjOGkzH9NOC3aL
         a/t5cgKEHxZXo/08j/ODUR+veSYFz1rG0yFbuOldfAMryQkkQ6sxIA5nd7kK1NbfmJsh
         H+yOGL2QyvTGycQLSoVkQ8tXt+MqPnOIzMAxmYpZy39GOUV+jh6BXXOb9qV3fgwhccB+
         CmXnfLjm9j7Vc4xLfqcoldO8C2cDXCzZVlCQtupV5I0aGppoLItge918mTj4NEDH2lSf
         f3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679554271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIZjWm9sKRagEPKjK84TsBRf7m9t25oj2pBtFrP5+ZQ=;
        b=YNByFL+06vDT6pCn1nKXy8nxaZlLh2Imfa2QiqLk4phSSvW0SJaKWXt0fYtzTpglFs
         7SAC9s1tcf3c1qxtaMzLaQHfJ4VWsFD8jfEs5UGye0fcXJzf7MOIW4Gj6WpcPR6cgQcu
         j5YYEu0qZB+P+t4helrdj/rDvZRi3zEzRRXBHj7uUUXf3xvVqo7uyMZVQwG7YTsVJ9mO
         vx3cJXZ31cJr3w7GNi/EjeMXV1ouHtz6xGFIUKVUou/C4W8dF3F9GzenKFg3S+ihdpJw
         pcwa+ERzPJ3PeVltyHLK55KouJYqbmqOqVqNUmb7ET0HjYFTx18pb1rcxuwqicvsN9eZ
         eWiQ==
X-Gm-Message-State: AO0yUKUpJW/yJy0mO8PdhQhxFWJA/ArAMZAgJHeAndUgHnLCjNCLowJi
        Vpl7YdqL1RZU+YKhrICKoB62iw==
X-Google-Smtp-Source: AK7set9w6izJxDoWCAVzZyrLwnzk5zslYjDoRXmdNYTDOiT7pp9ccrmpDycIQek1EUAI2X+WxjZZPw==
X-Received: by 2002:a17:906:9453:b0:931:7350:a4f3 with SMTP id z19-20020a170906945300b009317350a4f3mr10038240ejx.10.1679554270777;
        Wed, 22 Mar 2023 23:51:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906c00800b008e1509dde19sm8139088ejz.205.2023.03.22.23.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 23:51:10 -0700 (PDT)
Message-ID: <149329da-e104-c0b0-0c26-ab01d6b2c25b@linaro.org>
Date:   Thu, 23 Mar 2023 07:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: bq256xx: Add
 ti,no-thermistor property
Content-Language: en-US
To:     Hermes Zhang <chenhuiz@axis.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>
Cc:     kernel@axis.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230323033012.416953-1-chenhuiz@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323033012.416953-1-chenhuiz@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 04:30, Hermes Zhang wrote:
> Add a new property ti,no-thermistor to indicate that no thermistor is
> connected to the TS pin of the chip.
> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
> 
> Notes:
>     v2: change property name to ti,no-thermistor
> 
>  .../bindings/power/supply/bq256xx.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> index 82f382a7ffb3..ab9ae6ca7700 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> @@ -68,11 +68,30 @@ properties:
>        Interrupt sends an active low, 256 μs pulse to host to report the charger
>        device status and faults.
>  
> +  ti,no-thermistor:
> +    type: boolean
> +    description: |

You can drop '|'.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

