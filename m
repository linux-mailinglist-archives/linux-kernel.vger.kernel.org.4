Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6486E4413
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjDQJiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjDQJhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:37:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1CE659D;
        Mon, 17 Apr 2023 02:37:24 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D032F66030BF;
        Mon, 17 Apr 2023 10:35:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681724154;
        bh=2ela0OE3EzNbVcej6d6Wb6FQs6kE2UzvgK4k9tO5HZE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gKKxXKWq2YTjMOxBZqZoQVdZ6AYtfX6HoOa/p48i2UL9jPXOpqrB2mX2F/wq8FWWU
         PsaAK0O1E0SPtQ9kP+NppDYxglNsUgSw1VcIdyfS/BmF/oyifBP39g86P1gNyGMNsF
         Wf17/y0+0sKLIP5ZErZrXgycCe7XKQ+G0lbWEp8G5ykF8kwkIrPy+SV3WZplJ9iHGP
         WW8EeZHPHDRL4fyOb1F8Nh+zmcFtg2R+E5e1CbZIuBJVJXgzcbPopUv+CGEu/tHeZl
         rk53Kqoi2CCPMii78chkcps4iq91BrEYfKV5hep1DJh1dKwTKDsYrq3gw879OoC2fq
         UgH+4Fcj1HCfA==
Message-ID: <4b58c2a9-0861-e79a-c740-954cdc193599@collabora.com>
Date:   Mon, 17 Apr 2023 11:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/6] media: mediatek: vcodec: add one empty lat buffer as
 the last one to decode
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230417054816.17097-1-yunfei.dong@mediatek.com>
 <20230417054816.17097-5-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230417054816.17097-5-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/04/23 07:48, Yunfei Dong ha scritto:
> Adding one empty lat buffer with the parameter 'is_empty_flag = true' used
> to flush core work queue decode.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Since commit [6/6] depends on this one, you should either squash this with [6/6]
or add the same Fixes tag to this.

I think that the most sensible option is to squash it.


Regards,
Angelo
