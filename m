Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBE874DA92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjGJPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjGJPyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:54:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3FFE6F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:54:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3094910b150so5122768f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689004473; x=1691596473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wfIkRCUrMKdf07sqvIIvDJRNz8tUinPQv3be3vrXHU=;
        b=ebGQtlRaVJQV2foAwyNUdohAeeUOZLm9EdlJMwuqey5BAYZgIrLM+d8eGE84ZOKPLl
         ozeDEgBtlRgcnH6QlT67S8qGrnmG4yYTzxuzkDL1qmyGNJP0k4A3hdStwMpmNeesEe7I
         B4O3nIgRTdtGnxp7sipzlhwM11x+8xwIMIqNe3c01o/ar3dZzUnTUIPOITqNjMgkDLkW
         XHxDraRYIjYudVmeMXTWZSt+8OEoN8GxWwt/Jc3QA+YQVane91gDqIZoZWqm/lv1/3C3
         ELZNJz9B1pI99Q8g77wYciQSoyPaF3BV5Jwcv2IAHGuCdxNlkhK8RNt+FTkkM1Lew5Xt
         y9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689004473; x=1691596473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wfIkRCUrMKdf07sqvIIvDJRNz8tUinPQv3be3vrXHU=;
        b=EQhqwKbcXyYm5S28eMRBhoHK/kEujlo6DDhFZCWj4rJGq2NZvbLHXwxcol77eDryJw
         tK9NXP9/IGPDTZt5bk5xim9HKJL+ZAUj4iTW+bTKPw+IfEqyYyYLb5pA6teMPtDoQf5m
         UKFDyf8lpx4zW34ZRC1ZBsU9dZf5AURLMpGSH8ifZswI81sXnpAJGJMQagLFE8LgE/ft
         7U2nx+zQxSXyzU48v0NqH9zKmkKgoHlqjRJgq3+WZXwZPV4ASQeL1Xu3Twndr9BFX0ip
         AiDJ7hye3af1Q8ouNZ2kRfMDiGR3kgJNmsiB8g/G95kV0drDWNyqzTOkoihUH6yJqAVd
         h+cw==
X-Gm-Message-State: ABy/qLZws1RZFr0fd8MagG4003fYqGASMziGuhl1HBNAr/bCexy0j3ap
        1mZKJBFrlYatGn5JcmPSN71TCg==
X-Google-Smtp-Source: APBJJlHBZxxgHi7w9AMsNsW/SXZZBvbSaE3V+7jxZPXV+5ePCOXeIZwHtEHIRg47IkRL2mdfvzZqNw==
X-Received: by 2002:a5d:6148:0:b0:314:3ca0:c8c2 with SMTP id y8-20020a5d6148000000b003143ca0c8c2mr12396031wrt.11.1689004472875;
        Mon, 10 Jul 2023 08:54:32 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id r18-20020a5d4e52000000b0031417b0d338sm12065650wrt.87.2023.07.10.08.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 08:54:32 -0700 (PDT)
Message-ID: <a0cfb1d7-2bf8-02c0-054c-181114ebcfbc@baylibre.com>
Date:   Mon, 10 Jul 2023 17:54:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 6/8] soc: mediatek: Add support for WAY_EN operations
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
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
References: <20230627131040.3418538-1-msp@baylibre.com>
 <20230627131040.3418538-7-msp@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230627131040.3418538-7-msp@baylibre.com>
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
> This updates the power domain to support WAY_EN operations. WAY_EN
> operations on mt8365 are using a different component to check for the
> acknowledgment, namely the infracfg-nao component. Also to enable a way
> it the bit needs to be cleared while disabling a way needs a bit to be
> set. To support these two operations two flags are added,
> BUS_PROT_INVERTED and BUS_PROT_STA_COMPONENT_INFRA_NAO. Additionally
> another regmap is created if the INFRA_NAO capability is set.
> 
> This operation is required by the mt8365 for the MM power domain.

-- 
Regards,
Alexandre
