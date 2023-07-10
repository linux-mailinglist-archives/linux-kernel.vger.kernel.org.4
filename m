Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0328A74DA7F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjGJPyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjGJPxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:53:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB540E56
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:53:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso48054325e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689004402; x=1691596402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lA9/hHLk5qwfI79k0d3i9t2nQjTbjcWdGuZ0ZnzyAiA=;
        b=CknPydnVGzDk87VkGC0p9ZLzYIAWYt3UF6+0JuxeclEmisO3B+Q/Fs3+6kgUUu83BS
         Cz4kkhx23VD+2sYkUtJXCocFqMCup+qM/Qo9zCNyq6kHJfGO/DPkRyCG4UGNsBjIBTAK
         wbG+mzSqOYNwcYcuvPOrywvjZ9Jj4Fp8YxXFp23vRevfmx/PaCiwCJPHWNFZ/bTfPILF
         9f0yjY8JF2juLF64vT9LGU47yZ2frhb4P9pRTk9Sw4AzViRZ2hb+id406vs0SaNCyGbQ
         SBL5oUojSuFZx1Oi3KVKcKufzonUpwvgDCosKnIpqd731xh32eXwIQIxKrWSzZjQJ+o1
         4h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689004402; x=1691596402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lA9/hHLk5qwfI79k0d3i9t2nQjTbjcWdGuZ0ZnzyAiA=;
        b=lvgB2+sOO8mvLJTAjabYsVW/IeddWmvwB8iUqC5z5SHbSc+99dZgwBi8sTvGSrFnsW
         0Z/V85eGyk7NwEmto/kYf+am7xV2RV5M65VOQs3pbN9fbxICM46J1WwZM+AL1WQx7pW6
         niY1Ts/HnwOpOIOWR6RaXrukDEz7Fj4orqNrltMZjoR0JnU2U1P1UJ9JNRQXdY+Uubsi
         t0HSn+zhDTlumigzp4iWQC2dh3CK31JS3nRiEMS+m/nQq1gkZukQLV0MyUqDq3lNjeA9
         z4rON/HItipMtQVSytTdgi88a6kR7+8TKbJQElTsMG929P/80kl48A1Q0iJQRqJEBgKy
         1vrw==
X-Gm-Message-State: ABy/qLZ/iCDb+lOYeEE0wxCBQ203ff070SmuyImT1onTqSP40CvWsxSG
        tHCVL0zjXhMC70TYsStAZ+7G+Q==
X-Google-Smtp-Source: APBJJlHlL8GgNNdOgjFD+JG/AKxAl7mbQ4NcFkI5galLW268ybjXxtIlMSZdSlwqA8JZaHGxIGaEeg==
X-Received: by 2002:a05:600c:20cb:b0:3fc:f9c:a3e2 with SMTP id y11-20020a05600c20cb00b003fc0f9ca3e2mr4588325wmm.6.1689004402541;
        Mon, 10 Jul 2023 08:53:22 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bcb0a000000b003fb739d27aesm10579102wmj.35.2023.07.10.08.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 08:53:21 -0700 (PDT)
Message-ID: <7bc3499d-15cf-8f19-49a2-cc3fa0ca51fe@baylibre.com>
Date:   Mon, 10 Jul 2023 17:53:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 3/8] soc: mediatek: pm-domains: Split bus_prot_mask
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230627131040.3418538-1-msp@baylibre.com>
 <20230627131040.3418538-4-msp@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230627131040.3418538-4-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>


On 27/06/2023 15:10, Markus Schneider-Pargmann wrote:
> bus_prot_mask is used for all operations, set clear and acknowledge. In
> preparation of m8365 power domain support split this one mask into two,
> one mask for set and clear, another one for acknowledge.

-- 
Regards,
Alexandre
