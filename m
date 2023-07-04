Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF9174708E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGDMNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjGDMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:13:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A534E1704;
        Tue,  4 Jul 2023 05:12:46 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 957726606FA5;
        Tue,  4 Jul 2023 13:12:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688472765;
        bh=qmm4z+AweZzjaCuUW7i+I3t7cRwOPbqjo2hSFwzpZS4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dWxhYhKWCprr9x/xEGVJV4brsI52itgfDs5YFNUDx7tUPqa1piBlj0iXIOtt//KbB
         2NtQt8UoCGhHNJsUyURDJ4gHJghuBzQ/9E08OnqfJ9sTWhNMiw+BSInaIJ7MsbawVF
         BfGUC/ujGGOJjPgqkkFLzQdshiC+6shNkFKTrcTCjZQVe0GHZA88riWBC2uM/fwLtl
         m1UhK8WTNtGY4jilmhsSwEz6+Y55yN/SAS+0F43RpqkwjhK7M6/u91r9AeMxuv9/JF
         GLKP19hvWi/NeNGy7eG5RLsQO9O4SzTvLiTEyosQG0xwby/280GdwPItrNe8pWOgE2
         6pXlysC8oeqtg==
Message-ID: <986bb48a-03d5-c59b-b1ec-8cfac1f9bf71@collabora.com>
Date:   Tue, 4 Jul 2023 14:12:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5,09/11] media: mediatek: vcodec: fix unreasonable
 parameter definition and style
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
 <20230704111327.7140-10-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230704111327.7140-10-yunfei.dong@mediatek.com>
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
> Fix unreasonable coding style.
> Fix unreasonable parameter definition.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


