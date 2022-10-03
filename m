Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB225F3226
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJCOtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJCOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:49:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438812D1CD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 07:49:20 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 412806601B15;
        Mon,  3 Oct 2022 15:49:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664808558;
        bh=HMJJedZ83ECC+x6hsoS3IT6zUsXmxODD6JoL9d+MOk4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bKKmwqDiGUX8P7pi5iudzEBAHgo6QPgSQSaIRUA8VwQpOxYylMbvKiHLiE6HzVVLQ
         59Aa/HOk9w5lsVMA2bNPbAnljVVMn3LkXvDqp0rsMgq31zGaoDEdyN/WEomf+mRbe8
         ogitZ/cxP8mimOjgwPiYNamq7gBCX5eYnzIi1C858ejw9268gHs7cjMdPpzkEKq9xj
         DqrB5q8HLxnwSvpF+VImR8Q2rysNRvGxM926j5m4rkrTCOwos5Htb5vua7WZ9953RE
         yscljx1g+U4KCT/zWwGqBZnqOSHZovEBSznkA+BNBW+ZgCEX0bBox/Vbt7qhdjS6O+
         yGNRGPK72oXyA==
Message-ID: <6812059d-fb1f-f594-7f9e-eb62defadd09@collabora.com>
Date:   Mon, 3 Oct 2022 16:49:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v8, 2/4] mailbox: mtk-cmdq: instead magic number with
 GCE_CTRL_BY_SW
Content-Language: en-US
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20220930160638.7588-1-yongqiang.niu@mediatek.com>
 <20220930160638.7588-3-yongqiang.niu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220930160638.7588-3-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/09/22 18:06, Yongqiang Niu ha scritto:
> instead magic number with GCE_CTRL_BY_SW
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>

Please fix the commit title and description... an idea:

mailbox: mtk-cmdq: Use GCE_CTRL_BY_SW definition instead of number

P.S.: I agree with CK, please send this as a separate commit.

Regards,
Angelo


