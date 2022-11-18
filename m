Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F5262F233
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiKRKLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbiKRKKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:10:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A82F91509;
        Fri, 18 Nov 2022 02:10:29 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F1DD36602AA7;
        Fri, 18 Nov 2022 10:10:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668766227;
        bh=36XHqXHW9/4pThD2dF/5JFo7f13qGtp3LHEod+p8KXQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GnB3VAJyaDI54TY0WKGzD12xkMUnqgE1NeVQZNzB0IdnmQfjabbST7saZMjqNShtu
         MAeFO1+tfRr2nchORINd5e1PzClkQgrD4Lusa8NuQszuRWaUGXE7VCbO4CemhgHBoO
         k7AYWhyB8ItQXbeLxUKUSKZ1CgSbUuB3XOcrdD0eG5zRU7imUkb2SGpvwz1OeC+Aku
         AnKR0ZIkTcFRZGTVS9ZiT2Ys5pYHDkKNFe04KFhhnGHHoStCriNNR96BahtyAGaPvp
         +tpsfrT7sWAvd0yIviDiySTotR+RVM5YYFGvdCK8Lu5fbHcnMo8XkuF/YvFsUHGAEz
         XsQ3Br4H2ocWA==
Message-ID: <b09a64fb-262b-6ed3-0399-de0c9f438385@collabora.com>
Date:   Fri, 18 Nov 2022 11:10:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2,4/5] media: mediatek: vcodec: Setting lat buf to
 lat_list when lat decode error
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221117092453.31366-1-yunfei.dong@mediatek.com>
 <20221117092453.31366-5-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221117092453.31366-5-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/11/22 10:24, Yunfei Dong ha scritto:
> Need to set lat buf to lat_list when lat decode error, or lat buffer will lost.
> 
> Fixes: 5d418351ca8f ("media: mediatek: vcodec: support stateless VP9 decoding")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


