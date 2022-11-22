Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4846E633178
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiKVAkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiKVAks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:40:48 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C600D1403E;
        Mon, 21 Nov 2022 16:40:46 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F3A3088F;
        Tue, 22 Nov 2022 01:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669077645;
        bh=cBu5PsC4QF32tAa51YBQ5Oii1wluumr0yXuHd3dCBwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WG7KBw7r559HNnccifJkyXn/L0aMIObmRhbJ/3Xx3dTZdTXsHRqsaCkV72PPTqnHf
         F95P9fHRDqIoBHfS3SNsSySsKvsDS8mIh5toNcgyPGmE0iY0/juKb/RpeTEqw3pqZo
         9NirTIfgYHuFd8CioxuBGxDCy1QpAM6NkWFVKhwM=
Date:   Tue, 22 Nov 2022 02:40:30 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] media: i2c: ov5645: Drop empty comment
Message-ID: <Y3wafrHUryQQKNAA@pendragon.ideasonboard.com>
References: <20220927202005.750621-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220927202005.750621-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thank you for the patch.

On Tue, Sep 27, 2022 at 09:20:05PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Drop empty multiline comment.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/ov5645.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> index 3c3b30338328..754abc979adb 100644
> --- a/drivers/media/i2c/ov5645.c
> +++ b/drivers/media/i2c/ov5645.c
> @@ -14,9 +14,6 @@
>   *   https://www.mail-archive.com/linux-media%40vger.kernel.org/msg92671.html
>   */
>  
> -/*
> - */
> -
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>

-- 
Regards,

Laurent Pinchart
