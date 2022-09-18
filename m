Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BFB5BBD3A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiIRJ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiIRJ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:58:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71E72A40A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:56:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f9so41583702lfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yUemC1MXPL/JaIYDmlst3JLErWijJgIj3ok6l2ll1PU=;
        b=UZSdW8AZrZp6PBEjJjex53RP39Z2oiGownHfjQzCDL7fk7BReKrN3r+HMO2yuScvxH
         XbSsXkzA4aKSFDx+W7W8ZQjUP0ka/7zXAQAiONCaOKbJE4aBu8BzOZP7UZ+B6YKRQjMr
         Oo/FX3FU9A1XTKpwwq3tAVqdShSVzeYCQFW2z8FffBs01Y8lu3IHRHSiAeVurTugDx9Y
         Oj0dGl3cUBe3QD6dXLTBta1kqWS8gIb9yJc+sllwoGr1ghdWsGe1I470Gb7a6OJ5EkG7
         OYVCUhojlGkqTGkBsc2ImBSiJDTGWeJ9QnpYhN/5OJ8giqkte4LlimEhthcxPcHjPixc
         yj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yUemC1MXPL/JaIYDmlst3JLErWijJgIj3ok6l2ll1PU=;
        b=pHtF8Hj0hUFtV2O3EDTTDaIGHzrOwdeZ4Jh5IRTYsE+FpeJz6/AEM+RwwexucU09QJ
         H0IDSfQy+/rtJoMmPL4si2MPKv4RwHhQccz4cZo5Lq1yK4k3V5psTkG/mzWlf2vFIJ9c
         dKPNMCC5HU0CeH80Xp/3y3abBPVWfmhWXYmKpMmo9rsryibO66iNKJAEJ8LI9aZu0bG9
         fljXPKwAWY5+5DhW0/1VIJxBLgzFLnTNWupIOJGFZkAKky6W4UaouV0I9RHVmokPaEcJ
         UdHByfgCt7VzXEgn7ryZr8beWgdGQRA5BX+14SA3JXEytAiskAAf+4iTisu9BlW0wRVh
         i09A==
X-Gm-Message-State: ACrzQf3O6E77PXXYzc4n0ilYHkNr1VDaPhW0KvdsZ4EWh80Cdu9+nn2R
        XZExTgfs+bKWNwwaXh6pHAKiQA==
X-Google-Smtp-Source: AMsMyM7/EmyPdwCkxqsT81Z6iMAYE9zZw+b1gy8ishOWnnVcX90rMlLf0CUDpbGWHokoKce94U4E7A==
X-Received: by 2002:a05:6512:3047:b0:497:ab72:97f1 with SMTP id b7-20020a056512304700b00497ab7297f1mr3971683lfb.624.1663494960057;
        Sun, 18 Sep 2022 02:56:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id dt6-20020a0565122a8600b004976809d6a7sm4578812lfb.283.2022.09.18.02.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:55:59 -0700 (PDT)
Message-ID: <de3ea9cc-e8e3-71ea-707b-c9bce7166d0f@linaro.org>
Date:   Sun, 18 Sep 2022 10:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 6/7] dt-bindings: leds: leds-mt6323: Document mt6332
 compatible
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, sean.wang@mediatek.com
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220915091214.59673-1-angelogioacchino.delregno@collabora.com>
 <20220915091214.59673-7-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220915091214.59673-7-angelogioacchino.delregno@collabora.com>
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

On 15/09/2022 10:12, AngeloGioacchino Del Regno wrote:
> Add support for MT6332 LEDs/WLEDs with compatible "mediatek,mt6332-led".
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
