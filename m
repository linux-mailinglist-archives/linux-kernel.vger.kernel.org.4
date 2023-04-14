Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016C56E1EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDNIpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjDNIpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:45:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724D59759
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:45:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id xd13so9912177ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681461915; x=1684053915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OQi24hZ8qM1oW3SIEmbO3Vbi77+YdvqxsA6f0CmI3ZQ=;
        b=QkSjGapm2yICXR8TRzydwyFQoK1DQjUHDthBi1uSy4S3BJDAzE6gZvKmxVVRA0EOgX
         IOQE5Z+2j0dfTH1ViDxtyNr3NXw8cfyhZ7DNVbrnn4UeDhuaWgmjyJvdbxV4pUJ9F6QN
         GWklXLRqFwRq6sZYAzVmZkO3/nmeLEvwDOEcH+CTyxKQSA0XwuTuFZv8ENQ1ryaH0Zbw
         gu+zvc4nTo6Z6Ot9GBp6KzYHD2WS0nSeUH+w8ppB75fHbCQcw3WRKxUPLpBsgZgLveV/
         puptndWFp5Y0Y6JpQp/jqoi/xsd3D22rMdALcbF+TPM7MekbdiXqjvUdPzOVwmNoCYZT
         V60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681461915; x=1684053915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQi24hZ8qM1oW3SIEmbO3Vbi77+YdvqxsA6f0CmI3ZQ=;
        b=DjHckVYrPQ+pkzfnAB8fGmzZoHeMc2uiyPa9zsjrjuoJv63ZSSLZ5yneqGbRk/EAQf
         hVtoueJFThk3KbOwuex3kHC8usiH5H89UPGoVhdlD/QodNoKFwZ4wza9alWjYiNe1cJl
         VFjeE286XQvmiL11Lzx1LolTp8bNG1gaRGhmAOgO6gLHjIL7RO6sGXbfo2DpdAIWSY6/
         ZVnYCEblBYPfPgBTN0XcMaVXf6sj3/VGnmTdOeRXgTsm+3JSkftd/LspOe6ypv8ZJqLE
         LLgyXtEK5o9a0YTESwU6ccxfKUU4AiKvTBc6VluVqjRVfBO8mftxzHVIgJ5ejJ4mZtc7
         lhMQ==
X-Gm-Message-State: AAQBX9dmYfWAngzil1xRZfa/qoCLXpUlg9CImkTs8uxEjBRaGV0ajYye
        JiUqiFfmUUqK3meEaNX2pqG9LQ==
X-Google-Smtp-Source: AKy350aTjtwNIDMwN8ZlXb38r4s/wrVWtQuLY6J9Mtd85Z3UUSRWT2tyfVutkOUFmvCkD+hAfLERwA==
X-Received: by 2002:a17:906:140f:b0:94e:2db:533e with SMTP id p15-20020a170906140f00b0094e02db533emr5322939ejc.49.1681461914929;
        Fri, 14 Apr 2023 01:45:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7df15000000b00505060e4280sm1862013edy.94.2023.04.14.01.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:45:14 -0700 (PDT)
Message-ID: <05d0ae30-1f1f-0bbd-c98f-70d50924afdc@linaro.org>
Date:   Fri, 14 Apr 2023 10:45:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 14/27] dt-bindings: display: mediatek: od: Add compatible
 for MediaTek MT6795
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-15-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412112739.160376-15-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's OverDrive (OD)
> block: this is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

