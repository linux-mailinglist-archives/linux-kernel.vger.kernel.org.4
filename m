Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64514651D66
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiLTJdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiLTJdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:33:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E9B17584;
        Tue, 20 Dec 2022 01:33:03 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 25D6D6602C51;
        Tue, 20 Dec 2022 09:33:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671528782;
        bh=YS2viIDnDvMhgbQ5uguPkcplI2ttQaOGwYVyJrHzsl0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NLbQf878uirRW7vi/Xi4bL9+wJE7nFdV494eQQySnKzfu1AUL+V+wGaekQl/Z6W0F
         2EsKaoHDOiSiuHnR4PcO3fFwzEbbTqizPUfsiGCl5B+vnBBpzHKVupqLUcbW+GPuyB
         xk4dlmoQiI710hhEqsGgoOKsxcVEW5LKB6LLQ53S+QXvHtnLDiCtdaI7rtWbl/KWY8
         9+JuZ/cmZJpVHaHyhPq8uIeGc0IV64j7/Hi+QMwEyKzpuqjL8Xy0g9ijOTDUMPyDEs
         BElif6t4TShKqTpxr8YvSnmWKXN9edfOpBkw6T4lzydaDy/oji9fCw2tg0VYQel4Ad
         qPNGkQ23SzZtw==
Message-ID: <74530fb2-d7c0-c9dc-7ccc-2f1483b57f92@collabora.com>
Date:   Tue, 20 Dec 2022 10:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2,7/7] media: mediatek: vcodec: change lat thread decode
 error condition
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221219064332.2124-1-yunfei.dong@mediatek.com>
 <20221219064332.2124-8-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221219064332.2124-8-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/12/22 07:43, Yunfei Dong ha scritto:
> If lat thread can't get lat buffer, it should be that current instance
> don't be schedulded, the driver can't free the src buffer directly.
> 
> Fixes: 7b182b8d9c85 ("media: mediatek: vcodec: Refactor get and put capture buffer flow")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


