Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD7A73BAFE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjFWPEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjFWPEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:04:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DF010F6;
        Fri, 23 Jun 2023 08:04:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 202E0838;
        Fri, 23 Jun 2023 17:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687532624;
        bh=nnn3dttM0EmRsUW9dmWfGhqshG0TP5/h0YR9x1tnh7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YoDVayLlqviOTiLWT330yGnLW0k7iTia1yZEOxdt343ykRjwB5hmHN8ep1LTknXQZ
         mdQEBm7Hf+/ep3+K7D6BjU7GEjPT66tekWDveWtm87vWaFYrJoZZUTjWJcbvmLqeLO
         K0HH8RFSopGo7lFcO5u+ZcQoO8ki4gFYSq4fv6kk=
Date:   Fri, 23 Jun 2023 18:04:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/39] drm: renesas: shmobile: Restore indentation of
 shmob_drm_setup_clocks()
Message-ID: <20230623150419.GI2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <3739c76fca025e6b5d901ff29676146a45a545c2.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3739c76fca025e6b5d901ff29676146a45a545c2.1687423204.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thu, Jun 22, 2023 at 11:21:19AM +0200, Geert Uytterhoeven wrote:
> Commit 56550d94cbaeaa19 ("Drivers: gpu: remove __dev* attributes.")
> forgot to realign the continuation of the parameter section of
> shmob_drm_setup_clocks().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> index 4f01caa119637032..d272e6273c782178 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> @@ -67,7 +67,7 @@ static int shmob_drm_init_interface(struct shmob_drm_device *sdev)
>  }
>  
>  static int shmob_drm_setup_clocks(struct shmob_drm_device *sdev,
> -					    enum shmob_drm_clk_source clksrc)
> +				  enum shmob_drm_clk_source clksrc)
>  {
>  	struct clk *clk;
>  	char *clkname;

-- 
Regards,

Laurent Pinchart
