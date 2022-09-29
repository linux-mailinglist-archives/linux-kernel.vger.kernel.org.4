Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03045EF062
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiI2I0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiI2I0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:26:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972013913B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:26:08 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC8416601EB5;
        Thu, 29 Sep 2022 09:26:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664439967;
        bh=HogPUZ/giLHXBSPe+MlBIcmRqc9tQiDI153axcWswEo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SGsFpAY6lpiUsr5JRzHwAcF8aNyZsruYizjLN8cBrPnOrWRocpIWeiePjAwKJiOP0
         tkDMhahsn4ibrQe6seKv4O4dRlLHNMpnu8C3mpgtPQCTliRRoDPvjEbndH5QRbRBgH
         agRDQdQ+zqzEbHrHHUZ8b/QsB8/z0ZPKP2oOgwAMnBqoSoFj5ETl2CZiN+mtfSRZGB
         kcUGkt0RIibBdRLBaagE8qWgYz4Z1G52qRnAN2eHMDmuWKw5gaG19lVckfPcTlm4sN
         8Ju8DkqLARsR8ZK3ZpeSfFvQBpn8G80B7DLE5EUF37cn1ki/JYpMzRArYoh//NYfMw
         MHmHLEEsBWkZg==
Message-ID: <ecfdbb09-b54e-9877-a2a5-76dec14d2f80@collabora.com>
Date:   Thu, 29 Sep 2022 10:26:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 6/8] soc: mtk-svs: mt8183: Move thermal parsing in new
 function
Content-Language: en-US
To:     matthias.bgg@kernel.org, roger.lu@mediatek.com,
        jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
 <20220928155519.31977-7-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220928155519.31977-7-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/09/22 17:55, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> We jumpt to lable remove_mt8183_svsb_mon_mode from different error path
> in the code. Move the thermal parsing in a new function will allow us to
> refactor the code in a subsequent patch. No behavioural changes from
> this commit.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

