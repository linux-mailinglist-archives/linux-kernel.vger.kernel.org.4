Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9882F65B6C5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjABS4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjABSzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:55:54 -0500
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:404::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0754DD64
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=eok7KdVmRroYLcj11WsR1BUweIYjrGfaYUVRrkhjEh0=;
        b=E24yelP6YAbfdNiY9s5kUu+HP1wnvioknVmEUehrINnAlkig+baXf+p+PVVxSb9lQOzJU27HJ3gGP
         CCAdFlg1uWRbxYgdAZADG/HBQXzrPBDRkfTbY7JogD8eJLJzhGToX5/fnOcJFxm8PK7lVLNsYvuJLX
         OmHETXsmHJkj3bhFC7UW3kbZeG95iAo770M6NPV3t1yi89AQLRz8Cw9DrCfl3MnEhRiGMm1nBowqqe
         Ztt4htoyPII9eiXecer9bs/M0lXlRLkNDhsaVQw7YICXu3RZtIWnUq02/9dDZjM4wUDw++c838rq/i
         BIeCkGR5MTfsnV7dnDsUXixmEa2agwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=eok7KdVmRroYLcj11WsR1BUweIYjrGfaYUVRrkhjEh0=;
        b=FB0tdbVcETaDgu93IzVwW3j1EmxsDe0optb4Y9yxtgwAWwgY3usnS2BvW5m+Eu8q2ILnTr7lp6nod
         6oWZWTHAw==
X-HalOne-ID: 1268be43-8acf-11ed-820b-7703b0afff57
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id 1268be43-8acf-11ed-820b-7703b0afff57;
        Mon, 02 Jan 2023 18:55:51 +0000 (UTC)
Date:   Mon, 2 Jan 2023 19:55:49 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 07/14] drm/panel-novatek-nt35950: Drop custom DSI write
 macro
Message-ID: <Y7Motc++yaYLLned@ravnborg.org>
References: <20221228014757.3170486-1-javierm@redhat.com>
 <20221228014757.3170486-8-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228014757.3170486-8-javierm@redhat.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 02:47:50AM +0100, Javier Martinez Canillas wrote:
> There is a macro for this already in the <drm/drm_mipi_dsi.h> header, use
> that instead and delete the custom DSI write macro defined in the driver.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
>  drivers/gpu/drm/panel/panel-novatek-nt35950.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> index 3a844917da07..abf752b36a52 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> @@ -89,14 +89,6 @@ static inline struct nt35950 *to_nt35950(struct drm_panel *panel)
>  	return container_of(panel, struct nt35950, panel);
>  }
>  
> -#define dsi_dcs_write_seq(dsi, seq...) do {				\
> -		static const u8 d[] = { seq };				\
> -		int ret;						\
> -		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
> -		if (ret < 0)						\
> -			return ret;					\
> -	} while (0)
> -
>  static void nt35950_reset(struct nt35950 *nt)
>  {
>  	gpiod_set_value_cansleep(nt->reset_gpio, 1);
> @@ -338,7 +330,7 @@ static int nt35950_on(struct nt35950 *nt)
>  		return ret;
>  
>  	/* Unknown command */
> -	dsi_dcs_write_seq(dsi, 0xd4, 0x88, 0x88);
> +	mipi_dsi_dcs_write_seq(dsi, 0xd4, 0x88, 0x88);
>  
>  	/* CMD2 Page 7 */
>  	ret = nt35950_set_cmd2_page(nt, 7);
> @@ -346,10 +338,10 @@ static int nt35950_on(struct nt35950 *nt)
>  		return ret;
>  
>  	/* Enable SubPixel Rendering */
> -	dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_EN, 0x01);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_EN, 0x01);
>  
>  	/* SPR Mode: YYG Rainbow-RGB */
> -	dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_MODE, MCS_SPR_MODE_YYG_RAINBOW_RGB);
> +	mipi_dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_MODE, MCS_SPR_MODE_YYG_RAINBOW_RGB);
>  
>  	/* CMD3 */
>  	ret = nt35950_inject_black_image(nt);
> -- 
> 2.38.1
