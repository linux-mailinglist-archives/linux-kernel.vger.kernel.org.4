Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE256DD597
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjDKIbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjDKIba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:31:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E344E6D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:31:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e2so6611375wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681201886; x=1683793886;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=221+rJPVRmTBicTd5002DBEZ4voZcS37Ga3RcOPXh88=;
        b=0uN/cs3jya/FTvzSTyDnjUvs1o+XjEESTIuS+jlgfFdCDnY/fklJET+5dr4RyEtFuY
         /h7g1vfcxcN0ODtKhx+G4eCJOiPNCSNVEJg36G5u83eB+xJ/TCuISpRj0vbqvzzkUTW2
         3mvciNxV5LFTPE0eZnspSgllygfpe0g1dnDiFzKFjxik06T2TxBWf4RpPJo7X5XlFax9
         zeTXmgzWXHRYxpRcOdu4iLRzthG5OoR9ERKNz/TkZRi2RiHIL3A8ecxx+aHDPjw37VPD
         5zOx2Qfln6QpQffTr1Ql0YlMIZLo5RUWrKisGg/PXzt2DVy/1PvczE2xchdaBIcyL96p
         RePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681201886; x=1683793886;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=221+rJPVRmTBicTd5002DBEZ4voZcS37Ga3RcOPXh88=;
        b=1mGklTpYcSx1YNi3qvg4ud4QM6zw1h51a4L7GT28Foyce/2uhjTo3XvvGzOWGBSQJq
         DAWaITmdlvGW59OYDekF0F9XY4xKN0PsoZ6/Mx+ie3mW5s7fDfFCbMEUj1ORyWYOxojX
         /bFCplbzHzdBRqAfhFqR/F09p3tpj2IgcNc8w/tQ4Iv++ZxjY3ywuS6yrpigp9s+7hLy
         Inh1EyVBiMKFxw7DLej6+Vu8OjAj2xWj6HkZAg+SyNk8E0bw9EQHyWnGuQti7UR+OvFv
         RcaBoJKjCsypd/lD66SuBZVjG1Vpml9OmCuY2BCZ8muXD/XtiYOtbah0taJZDXdYYYL3
         EAgw==
X-Gm-Message-State: AAQBX9eX7IbRO79jWvJp24K2d38XEiF1F8/RJIusEtyUyCKLu45EKihy
        E8l3M3kmPvCoeR5uE+nmTScbDw==
X-Google-Smtp-Source: AKy350ZVJglFgq9ztOFGuYcic4YegavmAar2H7r8LrUhlD9XQnlViWEJTMf+UJFFQclfvouAtDmnwg==
X-Received: by 2002:adf:f84f:0:b0:2ef:5066:7bd8 with SMTP id d15-20020adff84f000000b002ef50667bd8mr9648387wrq.43.1681201885845;
        Tue, 11 Apr 2023 01:31:25 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id d9-20020adfef89000000b002d2f0e23acbsm13963408wro.12.2023.04.11.01.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 01:31:25 -0700 (PDT)
Message-ID: <16cdc84a-a78b-0629-6c87-9056755b0dbf@baylibre.com>
Date:   Tue, 11 Apr 2023 10:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/2] i2c: mediatek: add support for MT7981 SoC
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-i2c@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Qii Wang <qii.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sam Shih <sam.shih@mediatek.com>
References: <cover.1680857025.git.daniel@makrotopia.org>
 <7b5c6ba8da51ea6145fb71815a2f65a9e1d341c1.1680857025.git.daniel@makrotopia.org>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <7b5c6ba8da51ea6145fb71815a2f65a9e1d341c1.1680857025.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 18:19, Daniel Golle wrote:
> Add support for the I2C units found in the MediaTek MT7981 and MT7988
> SoCs. Just like other recent MediaTek I2C units that also uses v3
> register offsets (which differ from v2 only by OFFSET_SLAVE_ADDR being
> 0x94 instead of 0x4).

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
