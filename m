Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2DE6DF786
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDLNmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjDLNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:42:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B167D91
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:41:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso11656891wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681306906; x=1683898906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxkSh9qGiNggOqM0IqW5ttMVYnP04di9hmJMdY7w8ec=;
        b=B9d0pJGJszb/AtvGc1LSVISUvO3gkEB2r6axSkehkm6Wtb3x6EVZv/GnRNDTMvsDYA
         BOiJtsEel1Gj1GBQZdHsQRzA2moZSHwuTofFQnpowXCkNui7+YHgFoFWWwsKgpkD5KnR
         EIlJrioSvTxALhp4/bsKpFuPw6/AEaOIkVoMz2v1Aaehmw81SQM7CsGfQXoAKdYYVoeg
         NeKC6fFqyF7y9uErvCuNqOVcgosikfVSwIZcVm1TriA74ZN7yEBDpIp/ojw0Ogv7wpJg
         WB4ZnnTyjho3a91QqJBYE5I1G5789pzeJhkveCHJ74iimofE1AMERp2XzsRunQ/Wt8Mq
         bkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681306906; x=1683898906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxkSh9qGiNggOqM0IqW5ttMVYnP04di9hmJMdY7w8ec=;
        b=jolLQJve6A4x2U/5Z/KWwkMM4qJpV4XzaZC7ttfJ8SUkg76PGeLqSlDOVv6BVopXHd
         aJJvhdb65KGjQt/TURGaMYyM9q2iJNQxhTRZRFXai2XbTYIUjWbhPs5t5TsV1zSZRxXk
         aNDY+HVhk/tic/JMmToC4E60n32eIbAlw8CcUrnqsairbvRcdwcdPGKhvqPAtGARRSBb
         rtwwNZqFN9mukkL7LFUoVocAbdBfsBHyyctJypRVo8EvfeckVjoBpIpy+JPIdV2Ic+oC
         iD5VYLBc0IY8EEYUWt4DmFZHC48d6ztY/RLINJXBtcIgT77BBmgWW1OUPSoUVfVxwSDM
         HVcw==
X-Gm-Message-State: AAQBX9e+y8ioPrbccMJhOgX1aq2afE65rZibGyPHhsYCsbkCb8NEtF0S
        MNEzp8PfppX5JMZsLg36rxeWfw==
X-Google-Smtp-Source: AKy350Yi7DLY8Lcdq0xFepDVOiGuUCd47//3OO0bGUu9eLXFeO7jdLZnBpmOcGhBfDnlwtlu+bd7Xw==
X-Received: by 2002:a05:600c:22c2:b0:3ed:a82d:dffb with SMTP id 2-20020a05600c22c200b003eda82ddffbmr1949562wmg.40.1681306905383;
        Wed, 12 Apr 2023 06:41:45 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b003f0a007b802sm1434367wmq.12.2023.04.12.06.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 06:41:44 -0700 (PDT)
Message-ID: <6aa48e26-31dd-cd7e-7a1c-f46d05c8e74f@baylibre.com>
Date:   Wed, 12 Apr 2023 15:41:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 6/6] soc: mediatek: pwrap: Add support for MT6795 Helio
 X10
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        flora.fu@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230412131216.198313-1-angelogioacchino.delregno@collabora.com>
 <20230412131216.198313-7-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230412131216.198313-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 15:12, AngeloGioacchino Del Regno wrote:
> Add the necessary bits to support the MT6795 Helio X10 smartphone SoC:
> this is always paired with a MT6331 PMIC, with MT6332 companion.
>
> Signed-off-by: AngeloGioacchino Del Regno<angelogioacchino.delregno@collabora.com>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Regards,
Alexandre

