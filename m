Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B8364FF16
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 15:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiLROWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 09:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiLROW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 09:22:29 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BBAB4AB;
        Sun, 18 Dec 2022 06:22:28 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D1DFA825;
        Sun, 18 Dec 2022 15:22:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671373345;
        bh=ppRkx8NX81Iax8XhduigBhx7ERatLWEuJYkQIDeocnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgpP2PFslBNHKRIDW2irnDUtTGMEIMa3i6b+oBY94rCArCV7AT1s/KdnbUJGTwU68
         ci2tkR4geLOIvUaN/DltNBVFj+yCri7fQcDAQ32IVQKzs2sfEFWG0wClxuufHFWHwn
         WzH5Epw0EfDGUXCLbkXfpfGUgCWuvubnaOD67Q4Y=
Date:   Sun, 18 Dec 2022 16:22:21 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: mc: entity: Fix doc for media_graph_walk_init
Message-ID: <Y58iHWVAUIwmH/4b@pendragon.ideasonboard.com>
References: <20221217143113.3219104-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221217143113.3219104-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

Thank you for the patch.

On Sat, Dec 17, 2022 at 06:31:13PM +0400, Miaoqian Lin wrote:
> There is no media_graph_walk_free(). media_graph_walk_cleanup() is used
> to release the resources.
> 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/media/mc/mc-entity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
> index b8bcbc734eaf..de25de328fbe 100644
> --- a/drivers/media/mc/mc-entity.c
> +++ b/drivers/media/mc/mc-entity.c
> @@ -295,7 +295,7 @@ static struct media_entity *stack_pop(struct media_graph *graph)
>   *
>   * Reserve resources for graph walk in media device's current
>   * state. The memory must be released using
> - * media_graph_walk_free().
> + * media_graph_walk_cleanup().
>   *
>   * Returns error on failure, zero on success.
>   */

-- 
Regards,

Laurent Pinchart
