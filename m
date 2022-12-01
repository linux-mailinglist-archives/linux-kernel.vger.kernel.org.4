Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F17E63ECCF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiLAJqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiLAJpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:45:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5997454471;
        Thu,  1 Dec 2022 01:45:46 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E06E66025DF;
        Thu,  1 Dec 2022 09:45:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669887944;
        bh=ixKFlrVfNS4fpOwIDLlWnkerVHrbNdjy7rjzgp4awDY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SudtHIjjYXPGbOHedokplY8hoZRNXCcgfBFG5mLc/pwBNA90G1y9VIzmYeGd7JKvw
         o6KAq5ICx7zvv8/huZDOH3L0QtACqkd2YPb7sUAUqY1LSjklbSZuBoezDKFqNT6tDK
         9K4X4s8vZb6yb3BePKBtc6iVFklqAysbjHbM3K5FrHGo+72h3xVIGN3g55de6rki8q
         II+sZvfE1TPWdd5sdW0cw1HbbezbE2JbAd+kHn4uVkqaQsWJ4ZOeEIvyBsSi49Vg4L
         d8Gi+d+4dcEfZ5L/ZydMSpTsbdr/hmaGGNkaFuZcEx5Z3ULuH4Rq5aoi+daDclIL9k
         Lh4om4F0tsp1g==
Message-ID: <3e8aa2d9-6cd9-b155-c7b3-551fb574ac90@collabora.com>
Date:   Thu, 1 Dec 2022 10:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] media: platform: mtk-mdp3: Fix return value check in
 mdp_probe()
Content-Language: en-US
To:     Qiheng Lin <linqiheng@huawei.com>, mchehab@kernel.org,
        matthias.bgg@gmail.com
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221201023505.48015-1-linqiheng@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221201023505.48015-1-linqiheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/12/22 03:35, Qiheng Lin ha scritto:
> In case of error, the function mtk_mutex_get()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().
> And also fix the err_return case.
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>

Thanks!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


