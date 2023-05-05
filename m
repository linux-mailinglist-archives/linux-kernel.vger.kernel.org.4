Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE96F7FF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjEEJ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjEEJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:27:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80BB19927;
        Fri,  5 May 2023 02:27:37 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 855492CF;
        Fri,  5 May 2023 11:27:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683278852;
        bh=l6Dk0qKAGVGoSGHz4cAKtiNPF4yQeJEI5Z3o5yq+cYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6c3Se50/Nru0XMugYouJQXnSCajW5VV+UMf9R6Sff9yTkOrvUCh+MGo+3G6kqwR1
         /cNII49dLm/t7vXM8Qgfq2hmplLiG8SUtf3FE4OSq5M+952yQoIw2+qqCoDt53nxvw
         4nfasa/QSgvzOOE02trJRLZ04HNc4khBej9OA0Zs=
Date:   Fri, 5 May 2023 12:27:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] media: nxp: remove unneeded semicolon
Message-ID: <20230505092747.GU4551@pendragon.ideasonboard.com>
References: <20230505060617.5327-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505060617.5327-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng,

Thank you for the patch.

On Fri, May 05, 2023 at 02:06:17PM +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> ./drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c:226:2-3: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4868
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

I'll update the subject line to

media: nxp: imx8-isi: Remove unneeded semicolon

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> index b5ffde46f31b..f7447b2f4d77 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> @@ -223,7 +223,7 @@ static int mxc_isi_crossbar_init_cfg(struct v4l2_subdev *sd,
>  		route->sink_pad = i;
>  		route->source_pad = i + xbar->num_sinks;
>  		route->flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE;
> -	};
> +	}
>  
>  	routing.num_routes = xbar->num_sources;
>  	routing.routes = routes;

-- 
Regards,

Laurent Pinchart
