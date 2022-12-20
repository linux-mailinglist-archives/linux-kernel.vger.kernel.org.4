Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0416651D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLTJdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiLTJdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:33:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EB214D02;
        Tue, 20 Dec 2022 01:33:06 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CCBEC6602CA9;
        Tue, 20 Dec 2022 09:33:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671528784;
        bh=cPmHanQZhpaMeloA4YuqbX9hWdKVZC+OMPtTvkU5JYE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AFerUAX+nsqY0zpCFJNHABUhd7thRzGQsaJ1e3iksqpNA7q2ECsP/OOV48yMMOXgy
         vlubnvMt9E3wx83w6nq66qCrpySpeHwTCHVQ2jm+rLfoJUqE2KPCZaj7rogHZqYPsx
         IJujvCFNJBWVtVQehIQbo8NJk63GCvSgkORu07Pb4xXrOHzsC/urU30gi5ze+uZsbJ
         QcU8iXGOAi7Ssmo+18xTj6iYCcl9raHWhfG4MJVCnTxCgfdRESdP8m96+FcrYpFeC6
         6cqAfbDDasb3QKZYM4QD4JJT8a/68k6FwGyOuu4jts82ExsRCONZBGPv9WwHXZJPzR
         SmU6VGYJfL+lw==
Message-ID: <aac93a83-11d5-bb4e-f79b-cf706323f47b@collabora.com>
Date:   Tue, 20 Dec 2022 10:33:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2,1/7] media: mediatek: vcodec: add params to record lat
 and core lat_buf count
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221219064332.2124-1-yunfei.dong@mediatek.com>
 <20221219064332.2124-2-yunfei.dong@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221219064332.2124-2-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/12/22 07:43, Yunfei Dong ha scritto:
> Using lat_buf to share decoder information between lat and core work
> queue, adding params to record the buf count.
> 
> Fixes: 365e4ba01df4 ("media: mtk-vcodec: Add work queue for core hardware decode")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


