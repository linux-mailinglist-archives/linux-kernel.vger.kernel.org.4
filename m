Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E848163F116
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiLANB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiLANBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:01:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7735456EF7;
        Thu,  1 Dec 2022 05:01:42 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 759A26602B93;
        Thu,  1 Dec 2022 13:01:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669899699;
        bh=mKssGEdRVxdgNBcaWn5E3+Wr/jY93+xbVPtKJORxOHo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E/KgNEGySjqQPh736Eu5ZL5R3DQnyiK6wL3L57Obg3C2I+tbpXPWLw49VErHbP5CY
         nzpHzX3yHZwCFjwQM3q6slz4yZeDArt6XoZTvl6wqVevz66XvGm5XAahY8ECdDRBcO
         YcMHIKvZJBGg7LC7DsjG8WhfcLZPLasnejSgcrtdaYc6xuHKyosG1IhwScasC+9MCn
         bh2b1oHI5VLs0v+XtP/Y2MWEjL+2PBThJRy+a2NU/RXMDLTSE0JoskGcHbzBHpasha
         CDPo6X6gRdUy81rJrfMBIbnSZm0YDutNPZe+EGsw8tteOcK7t+sxwxTWPYGI8WldNs
         CNNaMBliAmMlw==
Message-ID: <e8ab56e4-0148-cb1c-78c8-c6700aa9720c@collabora.com>
Date:   Thu, 1 Dec 2022 14:01:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3,2/3] media: dt-bindings: media: mediatek: vcodec:
 Change the max reg value to 2
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221201121525.30777-1-yunfei.dong@mediatek.com>
 <20221201121525.30777-2-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221201121525.30777-2-yunfei.dong@mediatek.com>
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

Il 01/12/22 13:15, Yunfei Dong ha scritto:
> From: Yunfei Dong <yunfei.dong@mediatek.corp-partner.google.com>
> 
> Need to add racing control register base in device node for mt8195 support
> inner racing mode. Changing the max reg value from 1 to 2.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

You forgot to mention in the commit message that you're also adding a description
for the VDEC_MISC register space.

Please add that, after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


