Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E19472B60E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjFLDXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjFLDXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:23:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1121C9E;
        Sun, 11 Jun 2023 20:23:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30fbf253dc7so477424f8f.0;
        Sun, 11 Jun 2023 20:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686540192; x=1689132192;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4fi82/5hriQh9bwxuMPdwuuiMbrhOT9Zprm0iOwA4ok=;
        b=TrAFQfviPO4XVZogd/3hCmxwRND5zk3Zq6+gdKgycV7Ni9aTaYqbTjyWHQnVyqGEE3
         UiGBxN2H80zpTlUcMSQx5cChMPV5a7nF9KiMJTtuQUn5DgLY3pmqgqAtbrmsrBCOVwZ3
         DwhoONsOqy1anFugY5/ZtCJbrKssqke2+72El5WWKehCb0mBz00b6VE5iIzSNRcvybs7
         nIXGUJQvcErv3yvTAs8oqVnuuXYD/NlGDVP6RNoACSws1fkhXv1CA4T0lmJQ+kQysYpB
         EBlNXjaJNRNKuE/CZNipUZR2f7Bms9JLTLxEuR4YdK/thV+Li86BH9D2+KOc3SFTnBO5
         jQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686540192; x=1689132192;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fi82/5hriQh9bwxuMPdwuuiMbrhOT9Zprm0iOwA4ok=;
        b=V0qLY7V3nkP41nCFoGg+e9hlnA+zbFZeq1PHVHno9I4rx9WksrXAdgsblz7zwYLgvO
         7unKpj+pUyaCz82ZF7BSQ/mHJLttu/Ibj//it189DlYUaxpMMo33lF55H/oc6pTfXhy3
         mxCjvL3l+dypeZ3e/UF6Ufn6tDcoG7IQ5lkus23T04R/mdG0HiuP1GuKNDEK6qd7GmMo
         5Chi/Zjler/jo7Pej6EN8EcmkDuJpjFYi8u75FzsECEgvVgGfE63CywaA362s4IMXuY9
         Os4MJeUTbDrPZvCo9CvgMKXBeK+Tq93Z3XUeCvio+E4T7gKExyVkQWXkM+fVMLNyhGfJ
         mzGw==
X-Gm-Message-State: AC+VfDzHTe7bmqoecbd9Iz42X9FPpRypHzBkhmYh9lknNIbt7kDBFlCn
        AdJmBtULpkFYbO+s19b2aeU=
X-Google-Smtp-Source: ACHHUZ7WdySQeKVjN6moe6hPIOkvIIrCXllx1zfnjYVmrYg8hGDAUfax1zx88uED4kNO12BLmQ+7QQ==
X-Received: by 2002:adf:df09:0:b0:309:599e:ea81 with SMTP id y9-20020adfdf09000000b00309599eea81mr4078724wrl.3.1686540192263;
        Sun, 11 Jun 2023 20:23:12 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v16-20020adfe4d0000000b00307a83ea722sm11118373wrm.58.2023.06.11.20.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 20:23:10 -0700 (PDT)
Message-ID: <786ae93b-b89f-0587-b084-2f93554df479@gmail.com>
Date:   Mon, 12 Jun 2023 05:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: mt7986: increase bl2 partition on NAND of
 Bananapi R3
Content-Language: en-US, ca-ES, es-ES
To:     Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>
References: <ZH9UGF99RgzrHZ88@makrotopia.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <ZH9UGF99RgzrHZ88@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/06/2023 17:43, Daniel Golle wrote:
> The bootrom burned into the MT7986 SoC will try multiple locations on
> the SPI-NAND flash to load bl2 in case the bl2 image located at the the
> previously attempted offset is corrupt.
> 
> Use 0x100000 instead of 0x80000 as partition size for bl2 on SPI-NAND,
> allowing for up to four redundant copies of bl2 (typically sized a
> bit less than 0x40000).
> 
> Fixes: 8e01fb15b8157 ("arm64: dts: mt7986: add Bananapi R3")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Applied, thanks!

> ---
>   .../boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso     | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
> index 15ee8c568f3c3..543c13385d6e3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
> @@ -29,13 +29,13 @@ partitions {
>   
>   					partition@0 {
>   						label = "bl2";
> -						reg = <0x0 0x80000>;
> +						reg = <0x0 0x100000>;
>   						read-only;
>   					};
>   
> -					partition@80000 {
> +					partition@100000 {
>   						label = "reserved";
> -						reg = <0x80000 0x300000>;
> +						reg = <0x100000 0x280000>;
>   					};
>   
>   					partition@380000 {
