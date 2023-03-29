Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B433C6CD2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjC2HNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjC2HNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:13:21 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70E8199
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:13:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id t14so15073437ljd.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680073997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tjz4YY6475MDr5O8cC77sTPGv7vBqMb5/BBOLn/SVfo=;
        b=MRtmY6Sh0Urs9hIQEFX25PAVvlSXcMe+uCuWyT0FSHfRII2WE6jEemrt3H/G97TI8g
         UaO0l6ZMoo4Dw0W8Bu2wDUhT68ebAGzQn5ud84/RJC26Q5aHkW443xy9ifd/mJ22N7Ex
         vkRgCmSLtUp+BKq/Jo78BLRkrH2a77RS4aD/NOWUkBeAQ6RXWQTWqxIoJewmPI8+mjuo
         B07ke0nHNqkz99Lw+Z5uVD2NkIxAH8CgjxW21q3pDMuXgofb9yox5n5IkvSHPTUvqdzO
         T4ypTATDANkBPDFLxe0SzFMnsOOrl/ZEp0Ud0aiJGqas5o3aHapXgjglf5kpIn2/Ex+o
         YI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680073997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjz4YY6475MDr5O8cC77sTPGv7vBqMb5/BBOLn/SVfo=;
        b=aNJX8kZKTmUW/V6oGdvn0LjHvo0FyeGssRad2Lflgs+L8Ua/LxQ6tX91YNeYihhbks
         pD1eVeQQaXEUSZr4CSh1bs6Dlph4gt2dp7W/N8Z6wEPKhACgwxaGKYDAhI3Ylt6Qvhso
         AObaPA09rFVTFkx/gtsPuLevEqKEjFmxtnlz0wu8qI9Cwd2ruVdX9tXBgGErsZ1iNU08
         DzdzyY53Q7ftHd04rQ8n7pKKUsJAGvPJxhyqXL2YEspRBft7ssrGbSeJOKSurQjzZfRs
         NRJG9hViQeIiOHlAbDBSoIf9kjkuST/2gv3VIeHzP4ad0oA/YjcYcs1s9+7v2oDiyZ26
         um6g==
X-Gm-Message-State: AAQBX9dp8sVAt7+9KZbFJ5TGK5TURu5kNaHaxHvH2Wr+p/iPSxN/aJbq
        EjybAXbBjb8S4K12cHch62kdMw==
X-Google-Smtp-Source: AKy350Z3U5ebYnTlRO47AoMVt8i3K/fuetG/Bfiu2U0Js/vspmuVMfQmnKLBM1VvfiYcYbjVFKhcKw==
X-Received: by 2002:a2e:9d0c:0:b0:29e:4fa5:1708 with SMTP id t12-20020a2e9d0c000000b0029e4fa51708mr5731177lji.3.1680073996921;
        Wed, 29 Mar 2023 00:13:16 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x26-20020a2e9dda000000b0029bd4365c95sm4697519ljj.87.2023.03.29.00.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 00:13:16 -0700 (PDT)
Message-ID: <6e1f4885-e8b9-8031-c25f-a9b18c187e56@linaro.org>
Date:   Wed, 29 Mar 2023 09:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/16] spi: mtk-pmif: Drop of_match_ptr for ID table
To:     Stephen Boyd <sboyd@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
 <20230310222857.315629-2-krzysztof.kozlowski@linaro.org>
 <7e58e5c86bd602932b762f9364209e31.sboyd@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7e58e5c86bd602932b762f9364209e31.sboyd@kernel.org>
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

On 29/03/2023 06:17, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2023-03-10 14:28:43)
>> The driver can match only via the DT table so the table should be always
>> used and the of_match_ptr does not have any sense (this also allows ACPI
>> matching via PRP0001, even though it is not relevant here).
>>
>>   drivers/spmi/spmi-mtk-pmif.c:517:34: error: ‘mtk_spmi_match_table’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> 
> I'll fix the subject.
> 
> Applied to spmi-next

Thanks. Apologies for the typo in the subject.

Best regards,
Krzysztof

