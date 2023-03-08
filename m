Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C0B6B02A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjCHJQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCHJPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:15:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA98521CE;
        Wed,  8 Mar 2023 01:15:23 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E39F6602FE7;
        Wed,  8 Mar 2023 09:15:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678266922;
        bh=fPTLQFHujY/oHUC/I3K9qqyVNGNAzjDCKWvze41sJ3g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jf92UZEG/n2ScLk5Mzh1jykzYmXKZkEEJvFdfcrvXio2hJZm6Dlf/QZlZez6hXdRs
         KCi3EdmDhdutGmLzHpchyCy/9eE3HkELdBpG6q7eh9TD/MA3JkCh634pN6aZvvaFhu
         9PN07W87fFVKaQFc78Zup2w7H3JoilbpB/yVi9CbQ7l+woBOOy87Oyc9+2osDvCIC9
         LIFflngramEmJTtqdP/YNJIfsjgDFyhALX/wh53yrH5j4rRa18Vo9YMDj2lpKOZwtN
         nrzS7jzAahEq0fw23m/JnnASHQpmSydI9MYO8iH4gbfhzfN3RsOWbtIwXM/47xyd7J
         aUoz507p4jKnA==
Message-ID: <6b1e9d19-b176-280d-0277-492120e3a1fa@collabora.com>
Date:   Wed, 8 Mar 2023 10:15:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] thermal/drivers/mediatek/lvts_thermal: Add AP domain
 for mt8195
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230307154524.118541-1-bchihi@baylibre.com>
 <20230307154524.118541-3-bchihi@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230307154524.118541-3-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/03/23 16:45, bchihi@baylibre.com ha scritto:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add MT8195 AP Domain support to LVTS Driver.

Please mention the documentation changes in the commit description.

Regards,
Angelo


