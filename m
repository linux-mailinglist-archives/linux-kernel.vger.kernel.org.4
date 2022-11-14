Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D31627C13
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiKNLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiKNLRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:17:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392A9384;
        Mon, 14 Nov 2022 03:15:34 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EFB4B660231A;
        Mon, 14 Nov 2022 11:15:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668424532;
        bh=yY/YRATm0Q3oV5sdHDnUziPQTMU6rAOaaPCbRF/cZoU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eVNxyhrj+kwldNcRgpie15yV/5vTkKIkqlAsDbdWFCo4+LxeobgaKyCpcakevSO8a
         akqx/S3ViUV+h7YKq/sBdg9dHiextX/Pee2JXDmLLabEx2R9jQT1XfCHLP7Lu0S1mY
         V+0+gxRiuD7djrLH0caMoGvOdKZh7kcSXldgUsNVPHezsDf50qJVJR7LUDbh1I3mx7
         E7EUZiBqKVBUWIRMcYpqRFlcIK2OG4YCrGnMQIIxYN9kFqwkmFd2Ti8EHkst03EclX
         JcDcvw0oLGfoTU7XFnpMoDgmG26UsKgqk2jlf4XKxxJP8GykG/q/Gz+uZqB8+h5E56
         1MygFgxgzgy1g==
Message-ID: <f8b13cd9-c018-e52a-7c93-a8776f5f9ce6@collabora.com>
Date:   Mon, 14 Nov 2022 12:15:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/5] media: mediatek: vcodec: Fix getting NULL pointer for
 dst buffer
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
References: <20221112094144.4256-1-yunfei.dong@mediatek.com>
 <20221112094144.4256-2-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221112094144.4256-2-yunfei.dong@mediatek.com>
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

Il 12/11/22 10:41, Yunfei Dong ha scritto:
> The driver may can't get v4l2 buffer when lat or core decode timeout,
> will lead to crash when call v4l2_m2m_buf_done to set dst buffer
> (NULL pointer) done.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

This commit needs a Fixes tag.

Regards,
Angelo


