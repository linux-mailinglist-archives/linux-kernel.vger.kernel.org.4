Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B896A671B82
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjARMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjARMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:07:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73FF366AD;
        Wed, 18 Jan 2023 03:26:24 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F7DC6602E0A;
        Wed, 18 Jan 2023 11:26:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674041183;
        bh=RilHqFPMaWTucBwrDBDlmCahDlfPKMU/BJEodhKEbQI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mM05r1D1Kn8ZwXLxWE5eryt1Z52Jm57sz/fyt7AGTvpMz3r5MwVfjtg2OcU/wsM0N
         jRLo0Nz0hyaUBqPwg5/K2WbCB0GFKEIn8OdtCLnyITHRJg/Me+0evBAy9bzYMawJhw
         wuPm1DY4g0N4OROQPFEknX2pEhN6kUqOmjjlJhsqhckthqQUzwDrVg+k16JnvJf7YI
         n1C3Z9aHb15DXsqjLIDdxnncU6aX131KQt2hmS8/jy+ydd/a9Wiv9SDQ3gCg4CxNvo
         Fd6MAspNPJ7tw6F/wq1D5+uutjT6ss61SHws2v5uKmJ2aR3MI02IAb/TnK9UC1tz3y
         /1Z8mELjN2CaA==
Message-ID: <2662ea23-614f-10d6-124f-44aa5fff2a5b@collabora.com>
Date:   Wed, 18 Jan 2023 12:26:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] pinctrl: mediatek: Initialize variable *buf to zero
Content-Language: en-US
To:     Guodong Liu <Guodong.Liu@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Light Hsieh <light.hsieh@mediatek.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
References: <20230118062036.26258-1-Guodong.Liu@mediatek.com>
 <20230118062036.26258-3-Guodong.Liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230118062036.26258-3-Guodong.Liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/01/23 07:20, Guodong Liu ha scritto:
> Coverity spotted that *buf is not initialized to zero in
> mtk_pctrl_dbg_show. Using uninitialized variable *buf as argument to %s
> when calling seq_printf. Fix this coverity by initializing *buf as zero.
> 
> Fixes: 184d8e13f9b1 ("pinctrl: mediatek: Add support for pin configuration
> dump via debugfs.")
> Signed-off-by: Guodong Liu <Guodong.Liu@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


