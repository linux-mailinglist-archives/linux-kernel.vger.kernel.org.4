Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042B570634B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjEQItM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEQItH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:49:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB594688
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:49:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96adcb66f37so83755066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684313343; x=1686905343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MaJ5XUiPawbgSLxazOeekgQ6zrqG2tuKF4ul0ZKbcTE=;
        b=TTmWUVl7QixW+1Jq78EWwxVYh9jVn4dIZDbxF5q8ezdEa7WIA6rDHJunSR5UysIapV
         wKR/0t9Fi64d99Wl9rGtjuu+nZv2YOhpiaawHXy7/jxiiBsQ0/hnDrX6LXRvZ3TzFKey
         zPt1QgFVLLngXs421tZw+GWUld5jmEQJQrxR6pw0Z9iy2V8GDXR2ASsJtRbZSKA4/xKr
         qn/asQ9n6kt8QtgHzyP4hJASRRFKO1D2eEBVyNvO4uyXT62kt25r9udELYIpZsjJMizk
         ziIlWNNX+o5KdQN+tGJNvmufVlCj+3psX1GPTDGZsZ8C3zvt03GKzMBLC8BsceTLSbPe
         7JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313343; x=1686905343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MaJ5XUiPawbgSLxazOeekgQ6zrqG2tuKF4ul0ZKbcTE=;
        b=WF0/R3PjxQU7V0RGUAtjvHP78hIDB/acBaFe7HHAvEDbUiYBTdn1WQTEnasenTsHb5
         EnH56k/GTDXNeU5lj9993qkGxjCB3ss6kNayKdRTTtZGaauINUwh4/gwQDktzir/FvAl
         AOkiskr0Z7My1zyZBKErwmkvkJYDaNh+M8VGPGrqmHRQvHA8vmYs6dfI+/MX8ZlF3i1R
         VpA1lTvONWbxo0PFCMNoENcIq0L2LWzTPbqfO+GahEd0CKQBDhf9tKhaqCnNheQDQzD2
         TG/EJ5hn9GUjiJGYhT8iUZGx92Bpl+nCctae7dpr2WqR2Fr5ElDEUvepE+iVdi9SkVgV
         23Yw==
X-Gm-Message-State: AC+VfDz//m9mUKb6+eBuANAfoxYHs0r1LNeoo2NmvWhYSh1gJxOiKj1e
        yyab3PQt1ZwiFtqOc71gGQLrpg==
X-Google-Smtp-Source: ACHHUZ65OotyaUVps2r09ofoIL7n2B8BaydzF2ggyJTZdoXzbiRnH2Sm4bKfP/VZe+dPTgGvVTjuIg==
X-Received: by 2002:a17:907:31c7:b0:94e:e859:7b07 with SMTP id xf7-20020a17090731c700b0094ee8597b07mr34882125ejb.32.1684313343361;
        Wed, 17 May 2023 01:49:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id kz23-20020a17090777d700b009659fed3612sm11846349ejc.24.2023.05.17.01.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:49:02 -0700 (PDT)
Message-ID: <41001e48-35bb-0aa3-347b-8a25e3dcd8a3@linaro.org>
Date:   Wed, 17 May 2023 10:49:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/7] dt-bindings: iio: adc: Add rockchip,rk3588-saradc
 string
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
References: <20230516230051.14846-1-shreeya.patel@collabora.com>
 <20230516230051.14846-8-shreeya.patel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516230051.14846-8-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 01:00, Shreeya Patel wrote:
> Add rockchip,rk3588-saradc compatible string.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

