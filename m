Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFB86DA077
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDFTAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240027AbjDFTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:00:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E352735
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:00:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-4fa3c1a7a5aso1333748a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680807645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bum/yWGbHMLt1EOFHvTWnBxq9eD7t+qsjTNeqkn9sM=;
        b=CaFz4Ll9HSjfp9WnbEfCJKng1D3GwpCX+2GMTfWMCanvgwMkGmhKqx5zCQZi2RbeVQ
         PUMEyb/sY3anAc1WS81l0nuGAEfUD5O5FievJS1stvUVJWI9e0CdYWaExKN0j5hoxc75
         M4wgqR60SES71Pbaa2Skjxn7n/bJkRelRp81p+H/NYrJQFYxi+ocQSqOHnm+f9pnNsli
         SM31YE2ySEoKy5AystZv3bXJUio/O/of9wyckuwfzMxwyXgh6lDWkzdtA15JSM2SwjA1
         PctiWbldVGJ4Xad6V7SbdPdCxu5A4aKA2xtjL3NnSlm0LqADLY/sYvMVr60fVJXtAnd+
         Gjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bum/yWGbHMLt1EOFHvTWnBxq9eD7t+qsjTNeqkn9sM=;
        b=ltugP0Ol1FEqTHsUn9EVBRebNPiqqfLbWbfYpBtdt/gHNr7QJQVZRarZeozsc961P2
         hnlMERUAx1CwepXvP611i6XF2gJYh/DnwmW1kzxpnnF4DS6P3n/jKx+9g2tNJVnP/ac8
         RPHOeUx28qdCzrKQ87YNe0VP6aBPMdgNuZJnhxhe8wfjHCcpsxmUG4Nz6xGX2ykSMfWB
         kKMjOloLUausg73VLn0hyE9W453ynpvZRFZGFEhIV4OnRJ0BAbm+QUAoN+MYXxULfoQF
         nyjl5E3RiMYRljFu5rSk+o1o9wCrHB461Ge9BzrwzYKiWQf+vyajIid1dq0/GosfMp5O
         XGuA==
X-Gm-Message-State: AAQBX9cnt0huhFoHneQrRkyTF8ViIf7bffbY7Q4saEfj2mnhvEdNRJaD
        QWi0i2+3H4h1tPOe2zMKkFOzjw==
X-Google-Smtp-Source: AKy350Z8stGIoN0clalRjlcrw4YuEeDel7GzxJhI8mHMUqprxubCAqKxoonftbqeyBRB5AZPNECy6A==
X-Received: by 2002:a50:ef17:0:b0:502:a6b3:6e2 with SMTP id m23-20020a50ef17000000b00502a6b306e2mr561489eds.3.1680807645684;
        Thu, 06 Apr 2023 12:00:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id e14-20020a50a68e000000b004bb810e0b87sm1071884edc.39.2023.04.06.12.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:00:45 -0700 (PDT)
Message-ID: <678d5752-b5c8-dd21-9e43-68f4d4e674ee@linaro.org>
Date:   Thu, 6 Apr 2023 21:00:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/7] dt-bindings: net: dsa: mediatek,mt7530: correct brand
 name
Content-Language: en-US
To:     arinc9.unal@gmail.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230406080141.22924-1-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406080141.22924-1-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 10:01, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The brand name is MediaTek, change it to that.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml | 2 +-


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

although maybe this would be a lot of churn if done per-file.

Best regards,
Krzysztof

