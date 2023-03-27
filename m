Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D06C9D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjC0ISP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjC0ISH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:18:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FC61BDC;
        Mon, 27 Mar 2023 01:18:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C6ACC660308B;
        Mon, 27 Mar 2023 09:18:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679905085;
        bh=jDooTS8qcLct5Vl54ilGPR8FOgm20tKt9IJyKUjAlAc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=COO8VnsXpRhoBOB/ZHWW8XLJu/+nUL2ZpUPlhZ+0128fZeZGqAYa1i8mA/s22py6M
         4bjBXmM4IKVLsIECwrkRS93Pj7PAteOCDRcKrMytdnlnjiizBU3+t9Xi+JOzhsusbx
         dp2oXA8YjCUyg9HrpqY8yu39IhhaBar3bMY1VApMu3GeYaVcEYAJj0x9jQorfszgME
         o1TeR3GHN0Lbdj9dIzXxnS+N9PxEDiSmU2pkxpXYB8BC4760oEYtZzRWkAuZZkNJwN
         oDshXCyLunrXHcQRHPXqYDrWQtPI2/nbK/nLuHCtNhmoPj8vEeWINk5E8RD4P0hAbh
         zA0XECuTb3eCg==
Message-ID: <5c90ab9c-b5f7-d3a4-682c-7d27910242d8@collabora.com>
Date:   Mon, 27 Mar 2023 10:18:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3,2/7] media: mediatek: vcodec: Add debug params to
 control different log level
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
References: <20230327055315.13936-1-yunfei.dong@mediatek.com>
 <20230327055315.13936-3-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230327055315.13936-3-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/03/23 07:53, Yunfei Dong ha scritto:
> Add parameter mtk_vcodec_dbg to open each codec log.
> Add parameter mtk_v4l2_dbg_level to open each instance log according to
> the parameter value.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


