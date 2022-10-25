Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9964B60C15B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiJYBqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiJYBqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:46:18 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D2819024;
        Mon, 24 Oct 2022 18:36:57 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 109958A9;
        Tue, 25 Oct 2022 03:36:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1666661815;
        bh=Tade0L09k/sPug0OkMFsN7+fajl2EID+tt0lEdj2FtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFP+qVjm4/ZvqdCcHR9mVjyuPEks/ZQjv2mu2A2a5nXyb4iN8iSC5s6DsWCepUV7u
         XaeSmpFjoF6o/0tbTVXKW4yNyhS1NAUVCFPAzkdCCKyT5tMGfYxVFhvBXnG890BrNN
         HTQkR25Kcesqb4L24R1bKhDI0YU3Stk0KYJMsvks=
Date:   Tue, 25 Oct 2022 04:36:29 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] media: uvc_driver: fix missing newline after
 declarations
Message-ID: <Y1c9nS04fpoLqPVe@pendragon.ideasonboard.com>
References: <20221025010303.570815-1-pedro.guilherme@espectro.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221025010303.570815-1-pedro.guilherme@espectro.eng.br>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pedro,

Thank you for the patch.

On Mon, Oct 24, 2022 at 10:03:01PM -0300, Pedro Guilherme Siqueira Moreira wrote:

The code change looks good, but the commit message is missing. Same for
the other two patches in the series.

> Signed-off-by: Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 215fb483efb0..b591ad823c66 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -732,6 +732,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
>  	/* Parse the alternate settings to find the maximum bandwidth. */
>  	for (i = 0; i < intf->num_altsetting; ++i) {
>  		struct usb_host_endpoint *ep;
> +
>  		alts = &intf->altsetting[i];
>  		ep = uvc_find_endpoint(alts,
>  				streaming->header.bEndpointAddress);
> @@ -1859,12 +1860,14 @@ static void uvc_delete(struct kref *kref)
>  
>  	list_for_each_safe(p, n, &dev->chains) {
>  		struct uvc_video_chain *chain;
> +
>  		chain = list_entry(p, struct uvc_video_chain, list);
>  		kfree(chain);
>  	}
>  
>  	list_for_each_safe(p, n, &dev->entities) {
>  		struct uvc_entity *entity;
> +
>  		entity = list_entry(p, struct uvc_entity, list);
>  #ifdef CONFIG_MEDIA_CONTROLLER
>  		uvc_mc_cleanup_entity(entity);
> @@ -1874,6 +1877,7 @@ static void uvc_delete(struct kref *kref)
>  
>  	list_for_each_safe(p, n, &dev->streams) {
>  		struct uvc_streaming *streaming;
> +
>  		streaming = list_entry(p, struct uvc_streaming, list);
>  		usb_driver_release_interface(&uvc_driver.driver,
>  			streaming->intf);

-- 
Regards,

Laurent Pinchart
