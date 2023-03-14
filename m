Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211256B93A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjCNMVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjCNMUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:20:30 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5C4A2C0F;
        Tue, 14 Mar 2023 05:16:25 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzbhx1tyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4502:69d6::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4PbXX858jgzyVg;
        Tue, 14 Mar 2023 14:14:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1678796089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vbVChUqgohNuu3MUhbYeYTv1kSNguJaxULVFjd0TUvc=;
        b=YwwNgtcLH15mleWhRiG4BzhBytcawoNiKnyVKDsnarjYVIRwP4l1tCY/rj4gXThc4660Dq
        bpwo1yh3XT8SCFLqW5yRFmLbqta3dDaZAuAitlMD+o/rH/ayInoQUmgWvUP2ShHBB8NX53
        jl8aSb1IIIQ6KtHKgyZzxhx3Mu7eNKM=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1678796089; a=rsa-sha256; cv=none;
        b=XJoCSMISDltEmqLmlWfLRgQiL9Ozv84f5FoGFmfQSQcsceivQHyGOES40LDQCvrlviCaGA
        hGO5diRq8bBEqqOwGTwvUrfnKFNn7VeQoX84OCohKm336w8nshZxBG8Ai33HYvvZQQyc0W
        PoFg32tsuQ5gL0X6SPl/kujZ8rUyd80=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1678796089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vbVChUqgohNuu3MUhbYeYTv1kSNguJaxULVFjd0TUvc=;
        b=obqfv4MuyXCyGOXwPORhCJnwqldB46E5rHFUPWYML68lsm8qr+Oag1uOlAm+NDL9NKAgcL
        n8w1p1Q/vgZwYcBx5mKb91XZnFJsjmqBu5eZ3Tir6EcgobVwdmj7b/cG95cTtdo2os3fnl
        bC9j1ugcWOAcCbka+IldG6Kv0eMfFmo=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 11294634C91;
        Tue, 14 Mar 2023 14:13:47 +0200 (EET)
Date:   Tue, 14 Mar 2023 14:13:46 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: i2c: ov5640: Implement get_mbus_config
Message-ID: <ZBBk+h3EMSsacZ6v@valkosipuli.retiisi.eu>
References: <20230306063649.7387-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306063649.7387-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Mon, Mar 06, 2023 at 07:36:49AM +0100, Marcel Ziswiler wrote:
> From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> 
> Implement the introduced get_mbus_config operation to report the
> config of the MIPI CSI-2, BT.656 and Parallel interface.
> 
> Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Take care of MIPI CSI-2, BT.656 and Parallel interface as
>   pointed out by Jacopo. Thanks!
> 
>  drivers/media/i2c/ov5640.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> index 1536649b9e90..43373416fcba 100644
> --- a/drivers/media/i2c/ov5640.c
> +++ b/drivers/media/i2c/ov5640.c
> @@ -3774,6 +3774,24 @@ static int ov5640_init_cfg(struct v4l2_subdev *sd,
>  	return 0;
>  }
>  
> +static int ov5640_get_mbus_config(struct v4l2_subdev *sd,
> +				   unsigned int pad,
> +				   struct v4l2_mbus_config *cfg)
> +{
> +	struct ov5640_dev *sensor = to_ov5640_dev(sd);
> +
> +	cfg->type = sensor->ep.bus_type;
> +	if (ov5640_is_csi2(sensor)) {
> +		cfg->bus.mipi_csi2.num_data_lanes =
> +			sensor->ep.bus.mipi_csi2.num_data_lanes;
> +		cfg->bus.mipi_csi2.flags = sensor->ep.bus.mipi_csi2.flags;
> +	} else {
> +		cfg->bus.parallel.flags = sensor->ep.bus.parallel.flags;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct v4l2_subdev_core_ops ov5640_core_ops = {
>  	.log_status = v4l2_ctrl_subdev_log_status,
>  	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
> @@ -3794,6 +3812,7 @@ static const struct v4l2_subdev_pad_ops ov5640_pad_ops = {
>  	.get_selection = ov5640_get_selection,
>  	.enum_frame_size = ov5640_enum_frame_size,
>  	.enum_frame_interval = ov5640_enum_frame_interval,
> +	.get_mbus_config = ov5640_get_mbus_config,

What's the reasoning for this patch?

Drivers that don't have e.g. dynamic lane configuration shouldn't need to
implement get_mbus_config.

-- 
Kind regards,

Sakari Ailus
