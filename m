Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9E874E951
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGKIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjGKIp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:45:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E55AD;
        Tue, 11 Jul 2023 01:45:26 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 17CEF660700A;
        Tue, 11 Jul 2023 09:45:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689065125;
        bh=6DEYd15MttBbh1X726uK3mCyLE6btpkMXJHDkuDOM7M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MIZttZTRS6brVyCd9tt/IvWW6aPhi0+7UrniYZMZsY55P7kbljqpNvkRHTg4wUSCW
         Wu5Oq+W3+iO6MBxTU8BXYgWVU2oQRnJFNoF/3id56f/GIQQ4KrzaIAXYqZb30fyLKu
         XMpgQMh7XPg9/Haomgxmt+w2l6keWpk+QFkLjM7hcoekl/cJSwQlBayaqxnxrXYvlb
         CKWyGWs6deR+HmvFI3GGVBTBlLivkK3Sdspsj7xWnlm5v4JDSqE9HSn6lkDozhXjCN
         vxtsLzWW6GmuWSxj3skq8nkvs459gOx+5gFZQaCMvm8MLlXgkotadisQmwgZKj7BfH
         kn+RvIZpcENiQ==
Message-ID: <ab8c87c2-6a25-1639-911a-4bc8240514a3@collabora.com>
Date:   Tue, 11 Jul 2023 10:45:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/4] arm64: dts: Add MediaTek MT8188 dts and evaluation
 board and Makefile
Content-Language: en-US
To:     Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230711023929.14381-1-jason-ch.chen@mediatek.com>
 <20230711023929.14381-5-jason-ch.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230711023929.14381-5-jason-ch.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/07/23 04:39, Jason-ch Chen ha scritto:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
> 
> MT8188 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
> and 2 CA78 cores. MT8188 share many HW IP with MT65xx series.
> 
> We add basic chip support for MediaTek MT8188 on evaluation board.
> 
> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8188-evb.dts | 401 +++++++++
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi    | 951 ++++++++++++++++++++
>   3 files changed, 1353 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index c99c3372a4b5..9bd2324259a3 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-evb.dts b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
> new file mode 100644
> index 000000000000..6c1e829f7df6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 MediaTek Inc.
> + */
> +/dts-v1/;
> +#include "mt8188.dtsi"
> +#include "mt6359.dtsi"
> +
> +/ {

..snip..

> +
> +&u3phy0 {
> +	status="okay";

You missed the spaces around '=' here.

	status = "okay";

> +};
> +
> +&u3phy1 {
> +	status="okay";
> +};
> +
> +&u3phy2 {
> +	status="okay";
> +};
> +

After fixing that,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

