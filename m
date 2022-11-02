Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954E3616E73
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKBUTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiKBUTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:19:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08738261A;
        Wed,  2 Nov 2022 13:19:15 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4828E66028C5;
        Wed,  2 Nov 2022 20:19:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667420353;
        bh=IxBxYLkllFHY1VeHaU1jFaJjbbRQUrXzekE6Kx8p+Ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J++q28SWLyuojaBLnULuhR4mDTRp7d8R7KUH94ZcE7ItBoEhHaBYvA6DnCL5kGQuB
         23fdoZhYd6T+aqI0YqxJunwV8/I/hwIDQ/tqafdeUy/uwS2m+73y+iollBOTaZdeZp
         tY6dzEx8XAB+xOe40N+FTjgoYvTK75nupKPRlIStnWf6wRn+nFhN3U102hBzkIP8O6
         rBocZo+F1wVRvEqXl9bx85D5oNMR0blt9nLtRWSA4qGb/geCPYR+/rmntBtyKKbfrZ
         u7S2yyFORUH19nbRkPIg8RASjT8m6/TFh9uxZ+aKmI2yvVTtzpD9XIYeP6mwL7rIjW
         GuCRBu9mHKZiQ==
Date:   Wed, 2 Nov 2022 16:19:09 -0400
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
Subject: Re: [PATCH v3 3/7] arm64: dts: mediatek: mt7986: Fix watchdog
 compatible
Message-ID: <20221102201909.zs66mpoyjjbsp63j@notapiano>
References: <20221101090116.27130-1-allen-kh.cheng@mediatek.com>
 <20221101090116.27130-4-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101090116.27130-4-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 05:01:12PM +0800, Allen-KH Cheng wrote:
> MT7986's watchdog embeds a reset controller and needs only the
> mediatek,mt7986-wdt compatible string as the MT6589 one is there
> for watchdogs that don't have any reset controller capability.
> 
> Fixes: 50137c150f5f ("arm64: dts: mediatek: add basic mt7986 support")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
