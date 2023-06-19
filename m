Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0DC735ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjFSPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjFSPLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:11:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C99DE;
        Mon, 19 Jun 2023 08:11:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31129591288so1942990f8f.1;
        Mon, 19 Jun 2023 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687187463; x=1689779463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9POIqCEBq0vaZjmAI/TAoIioiW6L0FUvl3hWhodvNk=;
        b=W7azIsHFSwHwjq6qGftuOgSCwZBt45jUiFAC7cxCmQdG/WlWEIaWpV5JOvzulnmfXI
         /0lvcscMBRPV1NeL37xyifEvB1iw6G17iKfPkrz5jcWIyRVEbU/bgdb1tcwYIuGbWBYi
         HJQJWY6Zv/03Z/W/We+E4QDZS71zpQuQONBUkuwaaYAiKm3bMh1L5rq2bPP4sqSkfXcE
         3V+mAjaPR6dxsJ3UEvE8pi3CmZfKq4NXuByoOf51N3I478Tlc2kaUTLDitW+G8Gz8cXD
         WbMxCoMrzUE4qyc2U8nrKSMQiDad8krYpwvd6u+alAXdbsWVyYOHZ4ukrlT96bFCcvrW
         CAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187463; x=1689779463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9POIqCEBq0vaZjmAI/TAoIioiW6L0FUvl3hWhodvNk=;
        b=JfySPECId71i7vTDUPU+ZcfTd/UlqZKYWyniwiOrifiIz1/lUlD0hXJx0mOupSFTUk
         m2QQEw+k0o307kibTHtVuqVzIhoqcrQYXbsc/VVDMhFTtunjMo6BMPZwhrL1Vt0NZXRP
         +efZ2sCuGssRe5EiftjUT+t8JSzrEQJFXEipyBV9o8lafrY+eeA/GL+DxMERarhEljk3
         ZQ/7iLWR99YdJvbBS29I3gIC5UXqlpawdQi3iX6tCz04bv+3IOONQyrrmZVBPXdPURvx
         rCjqcnZSzRwjAeNstGrTH136CdfuTpMubMj/ZnnyQMP0TtD1w0DRbmLGuZW30CTFQnyo
         s+jA==
X-Gm-Message-State: AC+VfDwNR4r9UnjrP/AqRLF7bhjDd1XHuLr7CpFHCH+fwexDYE+7rWIj
        mApYQ/Wb2jJO5ggiKW3Hdp5YWdZUA3Q=
X-Google-Smtp-Source: ACHHUZ7C1lu3Bj8TxLBbK3PSpWrHnOnO98bfFdWMSxyL0al9U76SzMZRT/L7iSiRwpVjGCw+VxjbgQ==
X-Received: by 2002:adf:f5c8:0:b0:30f:c42d:da4f with SMTP id k8-20020adff5c8000000b0030fc42dda4fmr5716366wrp.46.1687187463280;
        Mon, 19 Jun 2023 08:11:03 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i1-20020adff301000000b002f28de9f73bsm31803071wro.55.2023.06.19.08.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 08:11:01 -0700 (PDT)
Message-ID: <67c4c526-4a1d-ab3a-c0d9-fec9a6711250@gmail.com>
Date:   Mon, 19 Jun 2023 17:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH net v6 6/6] MAINTAINERS: add me as maintainer of MEDIATEK
 SWITCH DRIVER
Content-Language: en-US, ca-ES, es-ES
To:     arinc9.unal@gmail.com,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230617062649.28444-1-arinc.unal@arinc9.com>
 <20230617062649.28444-7-arinc.unal@arinc9.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230617062649.28444-7-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/06/2023 08:26, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Add me as a maintainer of the MediaTek MT7530 DSA subdriver.
> 
> List maintainers in alphabetical order by first name.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   MAINTAINERS | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a73e5a98503a..c58d7fbb40ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13259,10 +13259,11 @@ F:	drivers/memory/mtk-smi.c
>   F:	include/soc/mediatek/smi.h
>   
>   MEDIATEK SWITCH DRIVER
> -M:	Sean Wang <sean.wang@mediatek.com>
> +M:	Arınç ÜNAL <arinc.unal@arinc9.com>
> +M:	Daniel Golle <daniel@makrotopia.org>
>   M:	Landen Chao <Landen.Chao@mediatek.com>
>   M:	DENG Qingfang <dqfext@gmail.com>
> -M:	Daniel Golle <daniel@makrotopia.org>
> +M:	Sean Wang <sean.wang@mediatek.com>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
>   F:	drivers/net/dsa/mt7530-mdio.c
