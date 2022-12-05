Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A13643661
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiLEVFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiLEVFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:05:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D926AFD;
        Mon,  5 Dec 2022 13:04:43 -0800 (PST)
Received: from notapiano (unknown [IPv6:2804:14c:1a9:3b3c::1000])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 79DE966015B4;
        Mon,  5 Dec 2022 21:04:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670274282;
        bh=VCvV+LMWWL4oBnWh4lUZLZS7cPQfDQuW5q3xLG4rh/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQxJ4Aef20sUdkPWsixd3p2LtvnReiXvBv3FA36F7VAOh8X94UCzLl4ld1LhNd1EI
         7eBqvzGcNSENej3qUCEeB4yWb/7Xk5pIZxuD3v6gcp9Pr0BK2D5LcP3ze4Ii/P4EH+
         pdT1uhTa533bfrxjQ3D6P0u6eug+tJAYzH6thBpJBRYt1LdnsykscXM1m28K95hnt8
         T5LLyKyQjBETdRUOxNDKn0CK77k0Oq9V4jRslRUmb4gZqtuCIw3n3gFRjyctAUmC1I
         aZPK2CCvJZt1QY8YNsiDO5mTRKesVCGhSFkEXCrSyPp61aT0Ofsvbuv+zUPsaPw/AH
         uZDzm5HVDGwTA==
Date:   Mon, 5 Dec 2022 18:04:33 -0300
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yunfei.dong@mediatek.com
Subject: Re: [PATCH v5 3/3] arm64: dts: mt8192: Add video-codec nodes
Message-ID: <20221205210433.w3nbwmegcnvsyesc@notapiano>
References: <20221128143832.25584-1-allen-kh.cheng@mediatek.com>
 <20221128143832.25584-4-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221128143832.25584-4-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:38:32PM +0800, Allen-KH Cheng wrote:
> Add video-codec lat and core nodes for mt8192 SoC.

Even though the rule is to use generic names in the DT, here in the commit
message and title I would have called them "video decoder nodes", to be more
specific and differentiate from the encoder nodes. But the way you wrote is not
wrong, so feel free to ignore this comment and leave it as it is.

> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
