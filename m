Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053E25BFA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiIUJPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIUJPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:15:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06AE1839B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:15:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f9so8154644lfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZDOlhHr3CpyZ2qYeSUIo/gRV2aRZgWeXlIQcoobfNQM=;
        b=i0aItSSsVMnElEYzPKXQkQsl2Qr7naJv22ttYfKNsluMkCFQS9UEmT3ZMQJhZTwf02
         +iXgHvlhbgLIovhP3RKnfsiiNiLVRcYt03YKXEX2VYOIuOsLdP6TWBAhI5dBubRqIzwl
         qOHww4BmNWxvZxL8omojKu3HVEmhFG0WogK3rWygVZzgJGFbm8k2mkhX0R+iONGV94iP
         NtspqlxWdpBnXZwm4xuc93eWEtZFuTK1tzsnsELv+tFKN0qXFefn6gZwAJGksAsZ1QDU
         x2LrZcL/trV3MV6ytAATiDkEJhf/Dlwf3NQ3qJY7z4Tat7pBMpu11VIKlY8ZuPA0LhBE
         T2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZDOlhHr3CpyZ2qYeSUIo/gRV2aRZgWeXlIQcoobfNQM=;
        b=12yvbdS5c2O+V9pgzSmnsDNogju2i0ZUWRhMtA5LOMvV0k9j5wHtRkz26Ehz5JKMRK
         1mtKkkiADa/4NfpgLjvb/1xGVOZzGATf8NuwklVbLud1anra1lZxXE/VQZFiUhD6z7Z+
         0+aFVasQTZ27Cvb1gJh3qyzbkcR4NLNe+UXpD5W5MvWa3shLIX21lJt75UXP1QQZmUrA
         3umUYLXIC4lzH49mA9susf07k8U25SgXOiBkmqo3MrK7xFaEnUvKkdvOG9Ed+pZjW5eg
         an+QPhZTfob5ge6NgXWOw2NE8umftjSQL+SAjz4O8CzsKDwhnQ6tLEwLnlGmcxJlDtWh
         Lu4w==
X-Gm-Message-State: ACrzQf1DJHX5zqAfeIdPrAvjwCVJwvchxEoUXl68/N8pL6RZfY7ncdET
        FVmKbSqR/4+oTDtsDg8crUb7Vw==
X-Google-Smtp-Source: AMsMyM7vaVYVA7DykTmq9bMP55OIaRAgXmLS2YrX2IfoVP6I0GSSt+T+tZKjft49SwaeZGwMBetjng==
X-Received: by 2002:a05:6512:159e:b0:498:f1eb:f7a with SMTP id bp30-20020a056512159e00b00498f1eb0f7amr9203437lfb.425.1663751707178;
        Wed, 21 Sep 2022 02:15:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 8-20020a2eb948000000b0026bf27c7056sm343705ljs.67.2022.09.21.02.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:15:06 -0700 (PDT)
Message-ID: <76814ecd-faac-0d5a-fe72-99d02a2e37f8@linaro.org>
Date:   Wed, 21 Sep 2022 11:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] dt-bindings: mailbox: Convert mtk-gce to DT schema
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220921090006.37642-1-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921090006.37642-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 11:00, AngeloGioacchino Del Regno wrote:
> Convert the mtk-gce mailbox binding to DT schema format.
> 
> During the conversion, the examples for client device/mutex nodes
> were removed, as these are found in their respective bindings:
> arm/mediatek/mediatek,mmsys.yaml for "mediatek,mt8173-mmsys"
> soc/mediatek/mediatek,mutex.yaml for "mediatek,mt8173-disp-mutex"

The change against conversion is making clock-names optional for some
variants.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

