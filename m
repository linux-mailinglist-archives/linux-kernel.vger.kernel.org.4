Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F7065B37B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbjABOpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbjABOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:45:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604DB65B2;
        Mon,  2 Jan 2023 06:45:08 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5C790660036F;
        Mon,  2 Jan 2023 14:45:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672670707;
        bh=hZzDubDOfjY5Ga3zYLkOcQaI4beRQ2l9iv6BFoR5yw8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kAj7YMTnwdQw//QfGF2QYf/1/L2CTdOv/9gJz2dXmNs3ucmD9ykQIhSxxzOmhkFEi
         sq55BBELOnhpMgsTUSU0UGK2Q/qwli/K+d3GTBfZocThk8cUPqm5lkttmpoxCLJN9w
         0KT9ru4pYvs/obHc6yTyBgzwUH2Hrbmfc7FCO20EthasGIkFop7QiFSTpG/MwWJQvZ
         9WtenLD3e6vBsHhZgbc1TmO+go009JN3VscX0F9bZshFvZxnrL3JzAmNxGCCGHzW2s
         Q+v7iwSrmepaQue7ELRk/iGBIQdcURp7CDyQl7UiSjLjYlcUQMjEeXfEsVqoDboUwj
         p53UyBAbj0wdw==
Message-ID: <fb003af2-ada4-6608-0f66-4bc929a23c69@collabora.com>
Date:   Mon, 2 Jan 2023 15:45:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [V3] media: jpeg: Fixes multi-hw judgement
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        nicolas.dufresne@collabora.com, kyrie wu <kyrie.wu@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com
References: <20221228070006.11111-1-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221228070006.11111-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/12/22 08:00, Irui Wang ha scritto:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> some chips have multi-hw, but others have only one,
> modify the condition of multi-hw judgement
> 
> Fixes: 934e8bccac95 ("mtk-jpegenc: support jpegenc multi-hardware")
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>

Please clarify the commit title, as "media: jpeg:" is generic, but you're
touching a driver for MediaTek's JPEG HW dec/encoder.

Change it to "media: mtk-jpeg: Fix jpeghw multi-core judgement", after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Regards,
Angelo
