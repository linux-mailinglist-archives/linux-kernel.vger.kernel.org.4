Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6E6616E70
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiKBUTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiKBUS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:18:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986BFDAD;
        Wed,  2 Nov 2022 13:18:56 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CA43966028C5;
        Wed,  2 Nov 2022 20:18:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667420335;
        bh=QXG2UGbCO/Vb7bB+f3sbN5iLPV4XgVhI69ZzWdISI7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPvlPgQgmMNdTTg6Zpdc0LL+iDtc8f2gN2Ruk5YkBEZYEJWXF9O57sTUj15ToTgwX
         TsXflnStGLaDQs6xO9RYaDzXzvH3KsJFpdHuflJqUUohLFQ685aK0ptSZ6A193NGPY
         Zx9eaF5Vg4Y4tiJ30re2dBlVWbj1V3Lgdjrx/DMZOW2a3Nfuql1aahzYOA7OvqoNzR
         4GZvJzAGm69eyQdvLQRodTkiZlW3ABlR9uYSKNc+X6Mn3gsH4T7c2zvuZO/AG3txQN
         ONX9hROW/rNm00B9wB0lftp4f1soNZRWZWetuEau7zXUWRwdzGeshza9Uwsv2B9LWV
         9PK5Q71bMT2hg==
Date:   Wed, 2 Nov 2022 16:18:50 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 2/7] arm64: dts: mediatek: mt8195: Fix watchdog
 compatible
Message-ID: <20221102201850.67gi3fyvhxu6hhzs@notapiano>
References: <20221101090116.27130-1-allen-kh.cheng@mediatek.com>
 <20221101090116.27130-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101090116.27130-3-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 05:01:11PM +0800, Allen-KH Cheng wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> MT8195's watchdog embeds a reset controller and needs only the
> mediatek,mt8195-wdt compatible string as the MT6589 one is there
> for watchdogs that don't have any reset controller capability.
> 
> Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Co-developed-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
