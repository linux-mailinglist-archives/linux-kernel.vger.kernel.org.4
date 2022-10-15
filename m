Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14925FF8B2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 08:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJOGGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 02:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJOGGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 02:06:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1523C58172;
        Fri, 14 Oct 2022 23:05:59 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 83134499;
        Sat, 15 Oct 2022 08:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665813957;
        bh=D7zqwYn5OXVooeqmH1Oijp5rSVYmevGeQzNTiZZ5RA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RL8osT6iPEOj7/3Al5tOyvuB2p0uFLI7nYt+Mwj09LC5woao3R3xviEHK/mKRBITF
         hP3yQ+G/tO5HQcZ3/+pjjI1nPT3znFY9Uwa2P27zGXe1e7IfQWER0praL8eFX10wwZ
         Kmi9XdUgVxZgUgpj02Dtq9WQ7HTyrNnyqBM8DNZc=
Date:   Sat, 15 Oct 2022 09:05:55 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 3/5] media: i2c: ov5645: Drop empty comment
Message-ID: <Y0pNwy0u0rxRV9XK@pendragon.ideasonboard.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221014183459.181567-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Fri, Oct 14, 2022 at 07:34:57PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Drop empty multiline comment.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v1->v2
> * No change
> ---
>  drivers/media/i2c/ov5645.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> index 1551690a94e0..a0b9d0c43b78 100644
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
