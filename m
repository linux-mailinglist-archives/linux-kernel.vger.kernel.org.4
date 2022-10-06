Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0015F65EA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiJFMZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiJFMY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:24:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71582193C6;
        Thu,  6 Oct 2022 05:24:43 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 36EC166022F9;
        Thu,  6 Oct 2022 13:24:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665059081;
        bh=BuajQsmdky1pSKHSsbY4UXSTa/ucDnsntUDGuRTR5Dw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NW+OCQ/VMKeFUq6aNI6w1YFB06kED9jdPOT2bcWZI9OeL9mUJErbD4BzStCnAkfpu
         idj3em16pahptosz4k448Q+sGqtLTlRwV+k7O8X+jNcQBG9ue2uYlcm9sLgNGgJGFu
         +NGIQGuDpt0CB3hHPothcvaVK4kOB86wPaneekFzqJsIRGoBTulZiMeYMnwo7tyP/V
         TmGwN1mE6Oqkz+ItcP07PSJF04MXaP8B+OAh4HrbtUsKU/Vo8MVmJQlI4YQV6OvDF6
         AYw9ZSMp2APKSfL/C4Hnn3TQbiead9GCci/PJWTtGMui5jeNxTYs2CIL2zrJBj5SzU
         2r9Id2o1y5VIQ==
Message-ID: <ef96bf71-7bce-7874-2e0e-f4ff6ab8f792@collabora.com>
Date:   Thu, 6 Oct 2022 14:24:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/8] arm64: dts: mediatek: mt7986: Fix watchdog compatible
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221006120715.24815-1-allen-kh.cheng@mediatek.com>
 <20221006120715.24815-4-allen-kh.cheng@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221006120715.24815-4-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/10/22 14:07, Allen-KH Cheng ha scritto:
> MT7986's watchdog embeds a reset controller and needs only the
> mediatek,mt7986-wdt compatible string as the MT6589 one is there
> for watchdogs that don't have any reset controller capability.
> 
> Fixes: 50137c150f5f ("arm64: dts: mediatek: add basic mt7986 support")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


