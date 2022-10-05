Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66695F5863
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJEQeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiJEQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:34:22 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548E67E83F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:33:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b2so15386172lfp.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fsDytsrXABRiHHLdkomit3W/4SQyAKiKJzv17uaMpSE=;
        b=f79WZ1CmFqHwvH+p6fcw9MAZwCeE4Y0jytRrvpG5oNagbKEN/cGNhxlPfDTgAilmIL
         LRJwD/J5nWGLRSi7njSfd3FVREwQ5CEX8IOzVdF8u0kyJJ57IRIkLXOTvPecNi3A9V9c
         Tz6NWbOT3Cj04sVi1gyeZRh0uso8A2pmY0qHVA+8lFrgZB7eBS4xucXwtn0L7zGYI9fF
         C8gxBR7Zms4ORtGFCduxQONtzzsoZa2j+6tbzxtCyXlvoRLjKxFUjNKeC8uYEs2nSqUA
         WNq3lUsL8gxqYu3m7vVS+ON5miMOz0ikYD84TvhHaFFINKRHkJrfywUbvmNlradLvDPa
         qE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fsDytsrXABRiHHLdkomit3W/4SQyAKiKJzv17uaMpSE=;
        b=zMeciIcKXN5NV7srdogwgYlTm2GAnTCmwdedj4nyRaXzBzG5khd53zNbUO4N5fHQQJ
         ll8WZytYA+Cnk9/TQWgk0TmwUdGlyDRShk5oMCgQlzbz3g+59PHWVmjMZ8hNnHxiWkIk
         9n0Vhr0W3jFeoqB4Muj8dMQn5EWU08o/4aDlCpB40qRTdhJEGpKvL1vyLGLvBpTZevvb
         oPVhcsnnSP1CB8yzP9NoBOHKEQJJIprFznulx/xtkH80AeCo0zXQvmITPKbpHBUYXv7+
         2BPMjMlIA6aSoVwPj0JpUzLeOlSCtITRxw4YJg/b8uDrzBfFbv3MvJWX4jLqKB8wm2oZ
         lFJQ==
X-Gm-Message-State: ACrzQf0EYcmI4gZakFaTMW6y6Z6eQVNRJp/mnYR9+Qx4eLdVUF+GkYOD
        hKuyPl2zfk8n00XXlTg7hqx/lA==
X-Google-Smtp-Source: AMsMyM6R1rJ0EDep0X30zwEZyQnjfv12SmZCyEK74LSEbsUR/NHwNWRbzWm06v352s5lwPYFNRhPig==
X-Received: by 2002:a05:6512:6d4:b0:4a2:5045:db6a with SMTP id u20-20020a05651206d400b004a25045db6amr249061lff.199.1664987630856;
        Wed, 05 Oct 2022 09:33:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651210d000b0048cf43c3a85sm2388561lfg.238.2022.10.05.09.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:33:50 -0700 (PDT)
Message-ID: <1f3ebf6f-117f-62a7-8e02-3e8a3bcf7e9f@linaro.org>
Date:   Wed, 5 Oct 2022 18:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/5] dt-bindings: watchdog: mediatek: Convert mtk-wdt to
 json-schema
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, wim@linux-watchdog.org
Cc:     linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        allen-kh.cheng@mediatek.com, seiya.wang@mediatek.com,
        tinghan.shen@mediatek.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
 <20221005113517.70628-4-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221005113517.70628-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2022 13:35, AngeloGioacchino Del Regno wrote:
> Convert the MediaTek watchdog bindings to schema.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

There is already work in progress:

https://lore.kernel.org/all/20220422121017.23920-3-allen-kh.cheng@mediatek.com/

Best regards,
Krzysztof

