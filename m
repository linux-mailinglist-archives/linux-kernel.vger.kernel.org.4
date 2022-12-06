Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49516643F25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiLFI4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiLFI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:56:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362732652;
        Tue,  6 Dec 2022 00:56:35 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0A7C16602395;
        Tue,  6 Dec 2022 08:56:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670316993;
        bh=nmh+741Te48C4jhFLsKlSBYv13YZbBa8FduTkcMHUUs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LkZDZWMdrTXhKeVBieD/5JS27LGYOtQfzc76kfdntdPkNfe48vn7artKC8e8lijIe
         7IjVFuREBZU+/VgbLMqQSOMyljYh/kPULjwFQaATrYOOJ0EJ7eOVyeO6/aZtKNn9bT
         l1QJ05UGU9bFRD5lEL3UnKOVPcO0qImoVtaDSxu8fXyqL8GsA7kVZdPJAut+F4O5iY
         OwoUhlXTsuaIuFGmy5qexUMJQ3f6ncXRgYYAtcC5jtek/j7Egx0pvCkEodXg0emKN5
         M85hbXe8m3sONkeeFcpNPOPJcFXfGPZKoANq5uPfcRFYbLe8ftqPxyMqgKcrYeE8L+
         7oLW5PEjK+lPQ==
Message-ID: <b41bd5ed-bd95-90f0-1907-cd99a63b402b@collabora.com>
Date:   Tue, 6 Dec 2022 09:56:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5,1/3] media: dt-bindings: media: mediatek: vcodec: adapt
 to the 'clock-names' of different platforms
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221206064536.16592-1-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221206064536.16592-1-yunfei.dong@mediatek.com>
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

Il 06/12/22 07:45, Yunfei Dong ha scritto:
> mt8195 and mt8192 have different clock numbers, separate 'clock-names'
> according to compatible name.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


