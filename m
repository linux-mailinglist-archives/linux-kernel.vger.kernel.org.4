Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455B46ADF1F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCGMu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCGMu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:50:57 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D557BA05
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:50:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ec29so20936379edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 04:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678193451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9UY5iuEzddJy7Jsu/1PTiy8KE7WoMJiAayKTBsEV99c=;
        b=b+bXytXwVgLrHVTUhYHA/o+BOCnksL/g7Qxp00rpVB1PeDBaCfpzd08Bu1xy8G7A1F
         A5tQULIHCYSWRP7w/6qrYje6Xt2oJE9VzIoHyqJsd5YmRUS2x6BJijVkcrPT/ZCsQ5xt
         kcb4VD2uNVgef8W8eEvXtjno/rfagdBix+CDNWXYsx9JtTOazq6Of2kulJgHHCbwyoA3
         Bcj1FWl3oWamfjtxLohEkZ6rw1/97UX4I1qwPL2jHqVguB8cYuQ+PHKlkSX6oD+nBuqx
         TDVp5xOKCwaC/6gFNglgJgO7efCGio1+ldQ3NvUYPfeyJ+z+0hsMwyUpKXOnSTQWVF6S
         mQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678193451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UY5iuEzddJy7Jsu/1PTiy8KE7WoMJiAayKTBsEV99c=;
        b=QM4Y9U6OT7rzqDyR7ripYjt4DEYelQ7QGBTf9XJckFXBbGcgQIA9S03UGmg0nkeKuu
         Am1A6QiAJOqwHp9tKFI3ZCCNcNyGvl0GNJRdIiOXX6R+t+L3nU3dklDRvW5TtHJ8zedJ
         MUBPLXGdXXJa/QZWfNdlJPnqRr4pC/uQHKTXwcCafuKynODbwgyZCqUtDoB+wP+liJB1
         mMkHHoHuvPDiDLfgCSZykLedcAdiP2Y/cQeu8JsEk2FnWtHtJOViLdEXvu7xIXz0N3CW
         rK16smoZZFFWc8vOEx2XqipkuGm1Jb8nLUri7pzr0pE7WmeN4RAQnaKAgh5vkcYnSX+H
         u/hQ==
X-Gm-Message-State: AO0yUKXVL0jVpQiafpSK6Nj6MjYuZ5eOJPmSdjqn5fGrME4dvswxjGDI
        C2VYMxriTt/mtAl3YFiatcBSjQ==
X-Google-Smtp-Source: AK7set+pdgHLGptuoirUA/qeW3eypJ8kze1cqV+VkXp/vY5g9ijFcb6atsoRCHygwl7vA0Nuj441XA==
X-Received: by 2002:aa7:c1c4:0:b0:4c5:bc48:d422 with SMTP id d4-20020aa7c1c4000000b004c5bc48d422mr11627825edp.7.1678193450993;
        Tue, 07 Mar 2023 04:50:50 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:a60f:e604:c252:1f3d? ([2a02:810d:15c0:828:a60f:e604:c252:1f3d])
        by smtp.gmail.com with ESMTPSA id n24-20020a509358000000b004af5001c7ecsm6666266eda.12.2023.03.07.04.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 04:50:50 -0800 (PST)
Message-ID: <caf54c57-f9a0-b434-8973-6734851153ff@linaro.org>
Date:   Tue, 7 Mar 2023 13:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] dt-bindings: display: mediatek: clean unnecessary item
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230306-ccorr-binding-fix-v4-0-117daea88efb@baylibre.com>
 <25019fb1-87f7-b863-48e8-a164d0e08265@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <25019fb1-87f7-b863-48e8-a164d0e08265@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 11:17, AngeloGioacchino Del Regno wrote:
> Il 07/03/23 11:07, Alexandre Mergnat ha scritto:
>> The item which have the mediatek,mt8192-disp-ccorr as const compatible
>> already exist above. Merge all compatibles which have the same fallback
>> under the same item.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> 
> Alexandre, the Acked-by tag from Krzysztof goes *after* your S-o-b :-)

b4 puts them like this and there is even rationale from Konstantin about
it. Anyway, it's not submitters job to correct b4. Our tools should
implement the process, not us (the users), thus if the result is
incorrect, then the tool should be fixed. Not the user.

Best regards,
Krzysztof

