Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD14274DA7B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjGJPxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjGJPx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:53:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834D819A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:53:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-314417861b9so4723232f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689004386; x=1691596386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdKrsajVjo/xr86zMfcWuNX46q5dSrbFvouEd5MKVhM=;
        b=TLZ//gR7t6mLNcmnE7ROIxsTiKnkjbFRvBVbhJTximPrdpJ0BSh2Ea6ZvOT6Uy8D+e
         DIVVcH5Xh4hGYNnp0vZir4NWamp1NTqHb+S1YFHH0AQPz20nDnj5dX/Jd2iq8TUuGXEN
         +pdnHr+DhstmSgWNBWzuDhSVzIL6P91lRD5myVEPNcGOBnwWlE6w6BwJUwUUB3zvS7nt
         2loEsLdfkz7pQcA+gR2vz5cI47r4cxaDNldsj6Ot8PoVBlod/2fSc9+vEyrwF9ge0ZsK
         9OYZFVz0kDTP9TjocKrLcaZTRH4POqm4H2aCflof2GinpmhN9S0T2dHoXU+hI85ePl8S
         hGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689004386; x=1691596386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdKrsajVjo/xr86zMfcWuNX46q5dSrbFvouEd5MKVhM=;
        b=CFjEHfI9MzXvEz1wDSwz7q8+3G6wpWdHle8OlwgehjTsAayQxNDj6UTfLAwqbWnrOb
         xNOL6rQKOsz7ZSPIuYKuKeeyLpizk5KR4ayiGnhmH2v5HNWjP5Aoc1FqLNF+bBDyj9Rq
         3MD57/aVSKj9j3DqMwixkaP0lLo5GP/porg7Vj4YNCy6U7/trc/+o6NqMxkpilu09TOO
         TLRE0+p3tP9aZLx4zMbTTPzsk0ynSW2vnulTu8RayI2THdzu2oFX0+GXst40RYsjbYl4
         t3KkFVXVqoQpxAgVvroLnxf6gEI5a7QJ3jHJc1o9zM4/z1MIR86GSibJJozpHB/0ydbF
         aZaQ==
X-Gm-Message-State: ABy/qLb5/F6tRNf7M8th1VnPg2r60IcRFwr3NX8LloCv6xoG96ApW0Ic
        Lmbs2yTW/bxTlkSgdZ4YhUltxg==
X-Google-Smtp-Source: APBJJlFKC+MrjlBKB0FNvPot8NUcDH+VTlvf4Fkur8znn+3cOPWDO++w16oLgmvffnjrZtmeMAaE8g==
X-Received: by 2002:a5d:4c8f:0:b0:315:89c5:9d2f with SMTP id z15-20020a5d4c8f000000b0031589c59d2fmr9552701wrs.53.1689004385926;
        Mon, 10 Jul 2023 08:53:05 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0031424f4ef1dsm12044766wru.19.2023.07.10.08.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 08:53:05 -0700 (PDT)
Message-ID: <7dd9399c-3806-b202-53b2-863690b14ab9@baylibre.com>
Date:   Mon, 10 Jul 2023 17:53:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 2/8] soc: mediatek: pm-domains: Move bools to a flags
 field
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
 <20230627131040.3418538-3-msp@baylibre.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230627131040.3418538-3-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>


On 27/06/2023 15:10, Markus Schneider-Pargmann wrote:
> To simplify the macros, use a flags field for simple bools. This is in
> preparation for more flags.

-- 
Regards,
Alexandre
