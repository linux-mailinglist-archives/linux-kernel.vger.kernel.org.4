Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9461F64EA50
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiLPLYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiLPLYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:24:41 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A076B116F;
        Fri, 16 Dec 2022 03:24:40 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id f18so2175397wrj.5;
        Fri, 16 Dec 2022 03:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4VXbJEHeIKsxV2etXdXC9p74o9+DjjUHAD3709lTso=;
        b=K7M2M+rnek8TsNzxL6ToBmEA11M3fhHINdOlnI8lFu9ZTErErwxUfXbk6k5Ru80qU/
         D1Bjj+o9ySUzVezoLXlPciNiRhHChqvHdsy3ebTncTSyHLabX3D7Z6umY+rUgKpQOOxD
         Ei8ppSoC9lUsLBZzMcNRnEDN5mZiljHqzIf0Ca4KMmSJ6nEzVI4OTZPmqo34JY+OtJvb
         jE3irjg6TltoO32Eh0HzMQ8lJgSlsZuHHkNG5+Ihumc1vXAxBjti52GmDjMktNR5H4AX
         exPGX0JFUGeEkbzhgehWpqzQMVo59nt7TzCx5ycRclXgeHlJyOoyEU5rxiVSu/2TrKZJ
         icNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4VXbJEHeIKsxV2etXdXC9p74o9+DjjUHAD3709lTso=;
        b=XBFvy8Zg7nCeoBDUopaTtaGYFkg4iVWKql66DMt2NfutYpd23JxZKZ3QW69vVQSQUl
         1T+15ejL2/lKMeDOe3cRUeevMtpFff9dekrajSZGpACoURPj7Ttp238zAAx1jWiGKZId
         vFTXxZiiKj1fwvOsNgAgBuHC/XLINC76V6ksoqJWbaLrs9Bbg7GUIT5PeCup78sSI8x3
         CjnaL/AombsttIRBhWz2VUbzaXTx2E3Vj9ezSuzpofdM1vtPFA6/UgrRTTmqM82+3q8/
         6cxbGfqKkTKP+gphL/EUWXHuNlh/VE2Gh0XAQFxsETl1ht2KcYaPFO0qreE8uFmbEk3c
         sIbA==
X-Gm-Message-State: ANoB5pnIjSXTtNPQk4X2YnM4elqIjFnDAE7tEdvajq96IXw42z3S8chX
        i7SHUNgdlWCsaEZKiIvBZqn0AK1MR54=
X-Google-Smtp-Source: AA0mqf4SMH1j0IY24v9NVD4Fb4t/t5rk7U6fmdMg4y7MdplN62WS3Wir4dKDp2SDEt0uAZBmKOwwpA==
X-Received: by 2002:adf:f145:0:b0:242:486:5037 with SMTP id y5-20020adff145000000b0024204865037mr20176287wro.32.1671189879020;
        Fri, 16 Dec 2022 03:24:39 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d5611000000b002424b695f7esm1998289wrv.46.2022.12.16.03.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:24:38 -0800 (PST)
Message-ID: <fb69f5da-1ea8-a0f3-1c3f-8269ad693f4e@gmail.com>
Date:   Fri, 16 Dec 2022 12:24:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 8/9] arm/arm64: dts: mediatek: Fix existing NAND
 controller node name
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221209064317.2828-1-xiangsheng.hou@mediatek.com>
 <20221209064317.2828-9-xiangsheng.hou@mediatek.com>
 <3729df62-8d39-db47-0b57-2bef37cc5830@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <3729df62-8d39-db47-0b57-2bef37cc5830@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/12/2022 10:42, AngeloGioacchino Del Regno wrote:
> Il 09/12/22 07:43, Xiangsheng Hou ha scritto:
>> Change the existing node name in order to match NAND controller DT
>> bindings.
>>
>> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
>> ---
>>   arch/arm/boot/dts/mt2701.dtsi             | 2 +-
>>   arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 2 +-
>>   arch/arm64/boot/dts/mediatek/mt7622.dtsi  | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
> 
> Splitting this in two commits, one for ARM and one for ARM64 would probably
> be better, but since I don't have strong opinions on that...

Yes please split this up.

Thanks!

> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> 
