Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771676CC651
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjC1P3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjC1P3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:29:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD15A3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:28:11 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BABD66603150;
        Tue, 28 Mar 2023 16:28:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680017289;
        bh=LmvUlEh5ksKEzZpgWt6GAloNsrYbh3aS1Uuprqn7NrQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OxmJNUxnR44yQjrlJub8pgQJ3zvKv/f1CAfrfoWmoakCxVDJPvYH4FZ180Ga1hUcR
         eDIQ2KeX/G1t0RTjMFLIPS2JLqRS2LCwOshmH78KBTpR0QXsscOPkZQWAs8ok6UW9f
         dlddXKT4RQDFsXqzqTdhg3YnbxCYzZF83cyQStM0g5GSgCTE29pC4laMP1NVuWdwFN
         MAHxodsupYCT/aeAcaV4fw7/H09VP4lBrlFdBPlUMB9cbsSwG6DwqmjYrVUq0WZgbT
         e9VVwip0kksvvBDf2xq3hGwxycmw4ypj31cThe6YFFKK0+g+b1z6rqXbzHya6gp2kU
         J8oXU6DFEpOFg==
Message-ID: <fa638276-81d0-734d-92c1-3b72cd70c1ef@collabora.com>
Date:   Tue, 28 Mar 2023 17:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/mediatek: Add ovl_adaptor get format function
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        singo.chang@mediatek.com, shawn.sung@mediatek.com
References: <20230328025126.30341-1-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230328025126.30341-1-nancy.lin@mediatek.com>
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

Il 28/03/23 04:51, Nancy.Lin ha scritto:
> Add ovl_adaptor get_format and get_num_formats component function.
> The two functions are need for getting the supported format in
> mtk_plane_init().
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Change-Id: Ia8e9f6cabcc71b262155a022b103ae81d1616b8f

The code looks good to me, but please drop that Change-Id tag (which has no
meaning upstream) and resend.

Thanks,
Angelo

