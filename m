Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219DB6B983C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCNOpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCNOpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:45:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B921CAF1;
        Tue, 14 Mar 2023 07:44:48 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA110660308F;
        Tue, 14 Mar 2023 14:44:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678805086;
        bh=UG2OkNBbSF+wQBZljJ8E2hbynswHMi4dtAl8X7QmMMo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UkWg9ZhpGfrDK5x28toXH9fK3gLLu7hecBavFbuE4lg9jVvTYM7DUC0J6jcDFfm9A
         1mvPaNTsT6Pyj0qaXtEaDJ8rXLqlVUb9Q8LOB0cFjg3aixJK8pSgeLH9iFdGYvTma5
         yIyAjP2hPA0KsMRy/bniIZcA9AfGDWVLpfUH+VZXwxcr8t4L+pIfOVD9/GulBOWtLG
         OMmiH4Szv0c9bt/2QQ1wzkxZGgT34o9k57h2k6WPE6xUBtRGTVUgerDr3ocU2ErpMJ
         i5arARUG47yVv608mCaI2hh84TP0N/mx5N1cNyAYx0GPR87PMp7s9my22S/i3we96f
         dUd4NRG+b86RA==
Message-ID: <70340bf5-d52c-3b72-b8ad-dd08d299ce12@collabora.com>
Date:   Tue, 14 Mar 2023 15:44:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] media: mediatek: vcodec: Use 4K frame size when
 supported by stateful decoder
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20230314102241.1971120-1-treapking@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230314102241.1971120-1-treapking@chromium.org>
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

Il 14/03/23 11:22, Pin-yen Lin ha scritto:
> After commit b018be06f3c7 ("media: mediatek: vcodec: Read max resolution
> from dec_capability"), the stateful video decoder driver never really
> sets its output frame size to 4K.
> 
> Parse the decoder capability reported by the firmware, and update the
> output frame size in mtk_init_vdec_params to enable 4K frame size when
> available.
> 
> Fixes: b018be06f3c7 ("media: mediatek: vcodec: Read max resolution from dec_capability")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

