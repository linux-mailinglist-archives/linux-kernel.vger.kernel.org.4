Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA4746EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjGDKba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjGDKb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:31:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32058139;
        Tue,  4 Jul 2023 03:31:28 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 406596606FA2;
        Tue,  4 Jul 2023 11:31:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688466686;
        bh=Mai929iZ41GcGRysmlxemjrjq50/MXj16H+6IYgJcRw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hcWpx0XM5qWmyjcj+qQe1zQiXqiwfJUzWdAkNHKVqwLQeJT0NdMqlPHiMPDg4G1UK
         K/oFTC5LsPZpp2P5wS/22k0VlAr+2RgDAcVNERXPj+s79uxehRB5tLKbkP3CbDJuuC
         S5UodAbBffIY0ajXMSD1XOyq17E0qZa4fKQGAcA0mMUV/3T2MPEJXWWqtBb8YHZTEz
         tmICOF2axJuCgrq0kodW2m/VM9YgToa7TDK9515vvucIF68dW1rr4FkC1s78ffHmy8
         NQkxOBKCZ4iX8enKEInOykgd6PEc3fbuBdPau22u3e34lRk7UiLy2V0GshpHwaEalg
         COgAwMxE+R/AA==
Message-ID: <85ce05db-5392-79e0-1183-b40db641f3ae@collabora.com>
Date:   Tue, 4 Jul 2023 12:31:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 8/8] soc: mediatek: pm-domains: Add support for MT8365
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
References: <20230627131040.3418538-1-msp@baylibre.com>
 <20230627131040.3418538-9-msp@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230627131040.3418538-9-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/06/23 15:10, Markus Schneider-Pargmann ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add the needed board data to support MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>



..snip..


> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> index 07f67b3d8e97..f853397697b5 100644
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ b/include/linux/soc/mediatek/infracfg.h
> @@ -2,6 +2,47 @@
>   #ifndef __SOC_MEDIATEK_INFRACFG_H
>   #define __SOC_MEDIATEK_INFRACFG_H
>   
> +#define MT8365_INFRA_TOPAXI_PROTECTEN_STA1				0x228
> +#define MT8365_INFRA_TOPAXI_PROTECTEN_SET				0x2a0
> +#define MT8365_INFRA_TOPAXI_PROTECTEN_CLR				0x2a4
> +# define MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0				BIT(1)

Personally, I like this kind of indentation, but more like

#define REGADDRESS
  #define REGMASK

instead of

#define REGADDRESS
# define REGMASK

...but this doesn't count, because this header doesn't follow *either* formats,
not my preferred, nor yours: this means that, for consistency, you have to follow
what's in there already, so you have to change that to

#define REGADDRESS
#define REGMASK

...so please change that to retain consistency across the infracfg.h header,
after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

P.S.: I'm sorry for not noticing this in v5.

Cheers,
Angelo


