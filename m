Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31276427DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLELy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiLELxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:53:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E14F00F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:52:59 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3DBF8660036C;
        Mon,  5 Dec 2022 11:52:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670241177;
        bh=S/XvQmPdf7xMwJPdBoXrFet0+92expZQ8DEbjSPs9BE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=LQX47Qe0z7znEVhDoNSSdUh7pP3jMhJr8d35xJi2Xgs2Fabwnz5f9Z96mZxbEaM6T
         hPxZ2gsDs2bFxn1rloMJ7hWJ8qwjBWHe6KPKXIaewVeLSZYBw+sPG1f8OY8joB5KcR
         WKQQyA2K5Dn5Z+/H9SB9IGQjHRjDIvZYIkZyhgBZZeq5SKRfIoa8igNYvw/knHvpnr
         rwN83h15Xh+tcMkIjfJ92lX2kFRpVBotJc5ngmVkBCeWGvqMyRB5oFRfJUeWoBrEfm
         NPTE8LjIJW/fmtedA8lZce4N03YZgpcH2mzaAvPNegkM3HQu1NTkjyfjv+oab77wQJ
         kB3cipqSoiB+A==
Message-ID: <378232f4-5c2e-ad56-c4ec-4d9f72f08755@collabora.com>
Date:   Mon, 5 Dec 2022 12:52:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/mediatek: mtk_drm_crtc: Add checks for devm_kcalloc
Content-Language: en-US
To:     ruanjinjie <ruanjinjie@huawei.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, seanpaul@chromium.org, ck.hu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221205095115.2905090-1-ruanjinjie@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221205095115.2905090-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/12/22 10:51, ruanjinjie ha scritto:
> As the devm_kcalloc may return NULL, the return value needs to be checked
> to avoid NULL poineter dereference.
> 
> Fixes: 31c5558dae05 ("drm/mediatek: Refactor plane init")
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

