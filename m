Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE996D7D47
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbjDENDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbjDENDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:03:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9AE196;
        Wed,  5 Apr 2023 06:03:29 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C6456603187;
        Wed,  5 Apr 2023 14:03:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680699808;
        bh=6sDDJG3Wyb9fV/04iwo5RqumN7KepPjmsLUQacDBkk4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cGo9VoYEm4PuTrXVh5c4xqqenDZH+sGlUefOYdUCBblBW9aCN580bUxhnbwXOGSdw
         AQV8Ab9cGrHHrydj3LdUuNxqQWX9Pmg/o/rFto15TtHnG0rBOZnIDSE0xOwPYML7Tq
         vKNWACsnLZSgaS84Po8VUSe6i4/1Nf90D4JPEqtvw5ZOSv80hxZQr63e/c/Dt5lJUW
         wOIXzhUgMZ/FWkURqKE4i7q6lp92sNOnT2CyD19w3LgevChKUyYU0J7BhvnZpPrdhW
         6kdLat9wDmTcjZHz/IHYIQlqXXbQ4dqVOl/G+w+KydV7wqA76G7fXeIPGcdGnrGl/O
         RuBJONBATxPRQ==
Message-ID: <c8a335d4-b621-8b65-ee77-87870425411c@collabora.com>
Date:   Wed, 5 Apr 2023 15:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH v8] media: mediatek: vcodec: support stateless AV1
 decoder
To:     Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230130123816.16568-1-xiaoyong.lu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230130123816.16568-1-xiaoyong.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/01/23 13:38, Xiaoyong Lu ha scritto:
> Add mediatek av1 decoder linux driver which use the stateless API in
> MT8195.
> 
> Signed-off-by: Xiaoyong Lu<xiaoyong.lu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

On MT8195 Tomato
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

