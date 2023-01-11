Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F192766591A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbjAKKd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbjAKKdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:33:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68982BC3E;
        Wed, 11 Jan 2023 02:33:11 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 94F3C6602CEE;
        Wed, 11 Jan 2023 10:33:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673433190;
        bh=z0alAcgpsjuZ6FSnlukQxbr8agvXedqnsuBGs1OOt00=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ltwb/l4wtwYWGmW+T1ERBSBW79WB2NHe48Z06JQlUdmkpJYpseqO4PnPodJsdJPbn
         sX+2rIBj/ugmWyqW0zdpi9dfdTrIo4nuHou8L+oUjHz8e6N5aUPrCvnGAWVSHeaIfN
         8jPpnpvuvWuExBHi5YsU6u+Z6WQbB2p3ygtfhtBSfSMkzrlhJa3PNjL8/uqH3jDHrA
         QgCs7dhcQ8rppXYWBKD4HtPs01x5rsm1kQNBJYXgPbS7sUWcSRsLaeouNdNdqLlh0w
         BzXcnUy2oKLILVhOpqE2FNcnzidQ/pcrp9cwQ7hfCBQwdJpTPyU0WWLmyABxcmDYG4
         o72psyLAayyOQ==
Message-ID: <350cbdd5-55bc-96b1-387e-ba9abeb26470@collabora.com>
Date:   Wed, 11 Jan 2023 11:33:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH RFC 2/3] media: uvcvideo: remove entity privacy control in
 the uvc video node
To:     Yunke Cao <yunkec@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
 <20230111-uvc_privacy_subdev-v1-2-f859ac9a01e3@chromium.org>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230111-uvc_privacy_subdev-v1-2-f859ac9a01e3@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

W dniu 11.01.2023 o 09:52, Yunke Cao pisze:
> For privacy_gpio, do not expose V4L2_CID_PRIVACY to userspace as a control
> of the video node.
> 

I know it is an RFC, so maybe you distribute the changes into 3 patches
on purpose. But, after applying this patch V4L2_CID_PRIVACY is lost
until it is re-implemented later, isn't it? Because of that It seems to me
patches 2/3 and 3/3 should be combined into one.

Regards,

Andrzej

> Signed-off-by: Yunke Cao <yunkec@chromium.org>
> ---
>   drivers/media/usb/uvc/uvc_ctrl.c | 17 -----------------
>   1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index c95a2229f4fa..77c5ff19add8 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -348,14 +348,6 @@ static const struct uvc_control_info uvc_ctrls[] = {
>   				| UVC_CTRL_FLAG_RESTORE
>   				| UVC_CTRL_FLAG_AUTO_UPDATE,
>   	},
> -	{
> -		.entity		= UVC_GUID_EXT_GPIO_CONTROLLER,
> -		.selector	= UVC_CT_PRIVACY_CONTROL,
> -		.index		= 0,
> -		.size		= 1,
> -		.flags		= UVC_CTRL_FLAG_GET_CUR
> -				| UVC_CTRL_FLAG_AUTO_UPDATE,
> -	},
>   };
>   
>   static const u32 uvc_control_classes[] = {
> @@ -710,15 +702,6 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>   		.v4l2_type	= V4L2_CTRL_TYPE_BOOLEAN,
>   		.data_type	= UVC_CTRL_DATA_TYPE_BOOLEAN,
>   	},
> -	{
> -		.id		= V4L2_CID_PRIVACY,
> -		.entity		= UVC_GUID_EXT_GPIO_CONTROLLER,
> -		.selector	= UVC_CT_PRIVACY_CONTROL,
> -		.size		= 1,
> -		.offset		= 0,
> -		.v4l2_type	= V4L2_CTRL_TYPE_BOOLEAN,
> -		.data_type	= UVC_CTRL_DATA_TYPE_BOOLEAN,
> -	},
>   };
>   
>   static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
> 

