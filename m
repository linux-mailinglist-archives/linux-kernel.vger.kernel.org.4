Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663BA5E9CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiIZJCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiIZJCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:02:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393073ED49
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:02:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2A5BD6602250;
        Mon, 26 Sep 2022 10:02:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664182924;
        bh=O7yTnbCSwacpaQ7u5yBgx5B/jmbp1mTfJETSiq+UOYI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ATTN9DAsyeHNWcZnAVzis6nDAa02EMavwqvugwQL+yZVmbWzTvxZJwWLJVPkUi7B9
         HT81YB0fUYlbhWhi1gMeYYBXA6wT6U154/FzXaqTKgRxPg9HwPOZ8a2yFPFRIj84O5
         JMryFlUHa5tXN1j1WAKR2Q/lesgQlNhrgZHB5lHx8HM0ozsKS+YUqjbl0PqyM3pcNr
         1HvqYx1f91T/nZRBXh0K6nzCQgt1E/anQibrn1Cf2pC8NSmjOOz1Xu1djdtTr9Mc9N
         4+j2mIcuDggl8g3OV9bF7PvepZ0XwAW6tmbfHugyB+oogNo/Y8Mz6YNqKYt+KUMDY3
         BidlPkPi9PtUw==
Message-ID: <11a141b8-510f-57cb-01aa-6508e58fa5ef@collabora.com>
Date:   Mon, 26 Sep 2022 11:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v10,2/3] drm: mediatek: Adjust the dpi output format to
 MT8186
Content-Language: en-US
To:     xinlei.lee@mediatek.com, matthias.bgg@gmail.com,
        jason-jh.lin@mediatek.com, rex-bc.chen@mediatek.com,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
References: <1663927104-15506-1-git-send-email-xinlei.lee@mediatek.com>
 <1663927104-15506-3-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1663927104-15506-3-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/22 11:58, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Dpi output needs to adjust the output format to dual edge for MT8186.
> 
> Co-developed-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


