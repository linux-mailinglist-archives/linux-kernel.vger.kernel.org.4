Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9957769C9E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjBTLbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBTLbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:31:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A132414E9B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:31:41 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C919660213E;
        Mon, 20 Feb 2023 11:31:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676892700;
        bh=AL50rqWOybi/12zAdjC8/O/AtkIbRn+Y7Je1otv+de0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Vjf96uhD/PC0Q1o2v23wqoR371kYSKeRxLnvlqcmVBKNpICJlgsTgkWdqrq8ABDrF
         C2OT5Nmq143lN40hzaqXxrKs57SVWcOyyN/g4j31mCnZa73Xw88+xnp9UsZAFTzd1a
         3x1fk1z6QuGGZZGA5vd7B07om0da3CKglDataoA4yOWlykUb4NW3whAbw3vcWcypDW
         gb3/zjvEtYeoEnhm+RdBQ2Fby5XgHCAmf6qh3pkeBE6DRpjMv3JyPRtud94eo14pSy
         qIzhzNT1W/ISHQ3qvvzHoxs09t6cch2jLqnVWQl0XKFrKmfcrG7JtW8gEyHtgEBR5Z
         idatKfLSC3oDw==
Message-ID: <437c0c5c-9a71-253e-eb2d-39e167e35099@collabora.com>
Date:   Mon, 20 Feb 2023 12:31:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] soc: mediatek: cmdq: Remove unused helper funciton
Content-Language: en-US
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230219233439.3157-1-chunkuang.hu@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230219233439.3157-1-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/02/23 00:34, Chun-Kuang Hu ha scritto:
> cmdq_pkt_create(), cmdq_pkt_destroy(), and cmdq_pkt_flush_async()
> are not used by all client drivers (MediaTek drm driver and
> MediaTek mdp3 driver), so remove them.
> 
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

My next cleanup step would be to migrate both the MediaTek DRM driver
and MDP3 to use the common functions present in mtk-cmdq-helper.
Function mtk_drm_cmdq_pkt_create() is (almost) a clone of cmdq_pkt_create().

NACK.

Regards,
Angelo
