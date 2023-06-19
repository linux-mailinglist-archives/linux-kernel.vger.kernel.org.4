Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5646735ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjFSPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjFSPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:11:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE8B10CE;
        Mon, 19 Jun 2023 08:11:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31110aea814so3660699f8f.2;
        Mon, 19 Jun 2023 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687187476; x=1689779476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q6Zn/PaFNXzltSIfFpMCOwfGanrm3MXr72lBnBT1Y4k=;
        b=AI+IayoTXZMtC9QFxzWgs9IKx2y7UxaIi+QTWkgDMdAegIBxFteRPNNPH+ewbuiJiN
         LVU9q31+Ev1E1ivGGPpbOt3LSosjhUgu1b954tM8T2dOBFMUnqZTH5hTEIcku6mOn39s
         EP34seY/NLurRriifF4+8DcnNg4YLXLiHdLDyDEvIkX3ueZQCMjOOkD7ev2GEOI9MKQc
         H0AViLioLEggVFefApINbJW+tJQVAMJJHGY4zU95Hkv9I2/klSgoRauVY7ziwHDUm+op
         hREgxgexnulMYlyjrc/VPAohPxnSnjOV/ci6bGx/On25HaCpR0XtYUzctUTXM2LAjcKi
         UgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187476; x=1689779476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6Zn/PaFNXzltSIfFpMCOwfGanrm3MXr72lBnBT1Y4k=;
        b=V1nIZ0F4akMxgf38dZrx09VS/XA3NpNoH2lGtG1rbKErQxDgcv5Y7Suew53r1Ug/2b
         LkOyLJJSTDiqobHnbTc/Zj4hvuXG9PPtQz0zaNHFiRAvD6w8FA8bGwd+zrmGyg8p76g4
         72niMwIcTWBIDVQuintpo9hyNWcd5x4iEnehegXK3aECkK3S/TrDy6ZzTqrI6biIuH0+
         8FVzAOoGa3MhA8shrbw/+H0hm3YIhquQnVhq8+S159cHcc8TQ3MdOOCl0PuFtDLTKT/1
         D4NXWmcPmCU89p99rGv53d2wGcqimXo22JhPpkKhvHazTLFSCYkmK+jtDFT4ys7+98/n
         ctyw==
X-Gm-Message-State: AC+VfDwUDT1G4MTyNiPE2I+XuFueDLyuddtEZw6g9W6EM8r1u/ZonjSy
        8W7Zn6SjAMd3xuSOYes/icM=
X-Google-Smtp-Source: ACHHUZ5rIA+6PlGsGKspeT0zwzwp4DAhcd6wrIATBgZD/GJ7z5aXB2HefcznBjrysDsgd22SopbfWg==
X-Received: by 2002:a05:6000:137b:b0:30e:58a8:d3f1 with SMTP id q27-20020a056000137b00b0030e58a8d3f1mr10140025wrz.58.1687187475941;
        Mon, 19 Jun 2023 08:11:15 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d43d2000000b0030ae93bd196sm31699144wrr.21.2023.06.19.08.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 08:11:14 -0700 (PDT)
Message-ID: <aca48c66-7def-4da8-9921-315695d515ed@gmail.com>
Date:   Mon, 19 Jun 2023 17:11:13 +0200
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

Thanks for all the work you are doing!

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
