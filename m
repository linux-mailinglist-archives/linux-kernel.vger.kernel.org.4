Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE386E9395
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjDTMCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbjDTMCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:02:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EED4EFF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:02:02 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3537E66030CC;
        Thu, 20 Apr 2023 13:01:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681992120;
        bh=LcRVmUKZzFzapPfbEEWSGRzomqHZShG7TMdpFQ+vpIc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GORNTUxT1VHh3euff+j8a13k52+aTqkVMsuz1x1LzNAFAahj0yoL8uOpiQSeqRNXj
         1szidLMLsTiCUsmzl4bSFzO9shZA0zd7dxfHrrtfyj7yQrTZNrIBQZI/CEiDkYCLf+
         6m1W1fgMroNvvcqMYs77NxhI78iIsBKWP6gK3XeO2qNIlcMr2YKIBDS4GDzTzkDUXk
         Y5qf5kpZ/sauS6jc+9L3j6wkyU2CX0Vqd+E+OxgNKlrTeCUfW2vLD8avtzPp917EJ0
         jZTGmIKLgdnMo4xy4+8GUKuVIBl/1q3XQGN0vGS+ECeZqrwxqNlDkpmOAiC97jElhS
         y6yxn4DufQnOg==
Message-ID: <e1619d7a-2ac3-55bf-bcf1-cad3f07d20fe@collabora.com>
Date:   Thu, 20 Apr 2023 14:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/mediatek: fix uninitialized symbol
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        singo.chang@mediatek.com
References: <20230420105115.26838-1-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230420105115.26838-1-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/04/23 12:51, Nancy.Lin ha scritto:
> fix Smatch static checker warning
>    - uninitialized symbol comp_pdev in mtk_ddp_comp_init.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>

I agree with this commit, but please add a Fixes tag.

Thanks,
Angelo
