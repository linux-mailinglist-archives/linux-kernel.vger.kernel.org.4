Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21BF747EF6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjGEIFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjGEIFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:05:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964F4123;
        Wed,  5 Jul 2023 01:05:11 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 942A86606FAA;
        Wed,  5 Jul 2023 09:05:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688544310;
        bh=12ymBKZuS/CqDJF1sxy54hGb5fCQHfQJmXELi+Q8iHQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V9jKSGUf71gSX6E543luyL/EgENHci9yi9XHkWYbcu6iwhua1NdlCFWrPPCDuP7nG
         gZWoXVmSbrGGriFnHQrH9CY8kuKmzcVrXgsfyWTb+3RuNx8TYcuw4PAv6XaikZKXXl
         Ar1RVfD4BH4OYC5tflOpU2cx7557J9/xSRszg4oz4FKHcXWGpuKrequhI0eXJyTIzt
         GwZpNohXcEXeiDW9F6xA0boVF+pCOy3yqlRsSpaXJPiIlsbDCURCPwZDl6pqUEc3Mc
         nBrABBthAx+UbxBgPg51bCYiDbLu+u3Dee9h9SEb89yS0C/RLS4a0xdHQWCTcO80DQ
         Gwbss2qR8yCZA==
Message-ID: <82bdb2cb-e31d-1265-47ea-56fad4fc2d40@collabora.com>
Date:   Wed, 5 Jul 2023 10:05:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] media: mediatek: vcodec: Return NULL if no vdec_fb is
 found
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230703035905.28247-1-irui.wang@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230703035905.28247-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/07/23 05:59, Irui Wang ha scritto:
> "fb_use_list" is used to store used or referenced frame buffers for
> vp9 stateful decoder. "NULL" should be returned when getting target
> frame buffer failed from "fb_use_list", not a random unexpected one.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>

This commit needs a Fixes tag. Please add the relevant one and resend.

Regards,
Angelo

> ---
> changed with v1:
> - remove the added flag variable.
> - update commit message.
> ---
>   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> index 70b8383f7c8e..a27a109d8d14 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> @@ -226,10 +226,11 @@ static struct vdec_fb *vp9_rm_from_fb_use_list(struct vdec_vp9_inst
>   		if (fb->base_y.va == addr) {
>   			list_move_tail(&node->list,
>   				       &inst->available_fb_node_list);
> -			break;
> +			return fb;
>   		}
>   	}
> -	return fb;
> +
> +	return NULL;
>   }
>   
>   static void vp9_add_to_fb_free_list(struct vdec_vp9_inst *inst,
> 

