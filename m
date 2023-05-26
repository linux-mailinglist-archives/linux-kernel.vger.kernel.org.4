Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C0A71263D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbjEZMFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbjEZMFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:05:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D66E4F;
        Fri, 26 May 2023 05:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D53B61527;
        Fri, 26 May 2023 12:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F23CC433D2;
        Fri, 26 May 2023 12:04:55 +0000 (UTC)
Message-ID: <bdee7988-3551-4011-f93e-c4dd1e4ee76b@xs4all.nl>
Date:   Fri, 26 May 2023 14:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [v10] media: mediatek: vcodec: support stateless AV1 decoder
To:     Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230414083020.22219-1-xiaoyong.lu@mediatek.com>
Content-Language: en-US
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230414083020.22219-1-xiaoyong.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 10:30, Xiaoyong Lu wrote:
> Add mediatek av1 decoder linux driver which use the stateless API in
> MT8195.
> 
> Signed-off-by: Xiaoyong Lu<xiaoyong.lu@mediatek.com>
> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

After rebasing on top of our media staging tree I get these compile errors:

  CC [M]  drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.o
drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c: In function ‘vdec_av1_slice_lat_decode’:
drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c:2075:46: error: ‘struct mtk_vcodec_dev’ has no member named ‘msg_queue_core_ctx’
 2075 |                 vdec_msg_queue_qbuf(&ctx->dev->msg_queue_core_ctx, lat_buf);
      |                                              ^~
drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c:2114:46: error: ‘struct mtk_vcodec_dev’ has no member named ‘msg_queue_core_ctx’
 2114 |                 vdec_msg_queue_qbuf(&ctx->dev->msg_queue_core_ctx, lat_buf);
      |                                              ^~

That's due to the patch "media: mediatek: vcodec: move core context from device
to each instance" that has now been merged and that drops that queue.

Can you rebase v10? This is now the only remaining blocked for the av1 series
to be merged.

Regards,

	Hans
