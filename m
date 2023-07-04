Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723E374709F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjGDMNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjGDMNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:13:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7FF10FC;
        Tue,  4 Jul 2023 05:13:03 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4642C6606F8B;
        Tue,  4 Jul 2023 13:12:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688472778;
        bh=CjCDfoY6i3YerAvedNb5hATHIfJzgR2uOpS4TTgZOTM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W4slGW667UPKIThapHffTziQPpnmELSow9332LOXhlPN2RqMl2B2vqziApzo8iDrm
         RaxqAks6khxIix/7LNIh6Pdn/iclPuh+68S+4Rblv5XUbbtodl9wVAs9cGKWLtJJsF
         hBCwBWQgWNTI4SIY2eJV5otAgaLJimQXpPrcHvyZbKv+lujS/F4aTHJjijhG/dvYGh
         i+ngfHnjih5nDLeXQgayIIqQDor9QOHGsPiW6QPq641gCCWyGCIC7pwxpaz3PcxT+t
         3wPUh5Vrhe3K9h2yEa7hZZjlCBfgA3MpL9zBJRJDH2b2B+dyis3mugvp54W7rTNTgE
         9rrWo970Uw4xw==
Message-ID: <421d7e5e-e28c-12ef-90ce-c976efd5b37e@collabora.com>
Date:   Tue, 4 Jul 2023 14:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5,07/11] media: mediatek: vcodec: separate struct
 'mtk_vcodec_ctx'
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230704111327.7140-1-yunfei.dong@mediatek.com>
 <20230704111327.7140-8-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230704111327.7140-8-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/07/23 13:13, Yunfei Dong ha scritto:
> Adding different context struct for encoder and decoder and removing
> struct 'mtk_vcodec_ctx'.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>   .../mediatek/vcodec/mtk_vcodec_com_drv.h      |  76 +++++

Only one remark. "com" may mean "communication" or "common", but if you rename
this to `mtk_vcodec_cmn_drv.h`, then "cmn" can only mean "common", which would
increase the chances to immediately understand what the header is about.

Unless, of course, anyone else has strong opinions against. Besides....

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

