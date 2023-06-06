Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF1F723F81
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbjFFKbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbjFFKbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098EDE55;
        Tue,  6 Jun 2023 03:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C1B261E17;
        Tue,  6 Jun 2023 10:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61810C4339C;
        Tue,  6 Jun 2023 10:31:05 +0000 (UTC)
Message-ID: <e5c99990-7cb7-279b-3e84-3591b134c014@xs4all.nl>
Date:   Tue, 6 Jun 2023 12:31:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v2 1/6] media: v4l2-ctrls: fix documentation of
 V4L2_CID_FOCUS_ABSOLUTE unit
Content-Language: en-US
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     libcamera-devel@lists.libcamera.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
 <20230406-feature-controls-lens-v2-1-faa8ad2bc404@wolfvision.net>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230406-feature-controls-lens-v2-1-faa8ad2bc404@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 11:45, Michael Riesch wrote:
> The current unit description of the V4L2_CID_FOCUS_ABSOLUTE does not
> make sense and was probably copy-pasted from V4L2_CID_FOCUS_RELATIVE.
> Fix the unit description in the documentation.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> index daa4f40869f8..df29150dce7b 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> @@ -140,8 +140,8 @@ enum v4l2_exposure_metering -
>  
>  ``V4L2_CID_FOCUS_ABSOLUTE (integer)``
>      This control sets the focal point of the camera to the specified
> -    position. The unit is undefined. Positive values set the focus
> -    closer to the camera, negative values towards infinity.
> +    position. The unit is undefined. Larger values move the focus closer to
> +    the camera, smaller values move the focus to infinity.
>  
>  ``V4L2_CID_FOCUS_RELATIVE (integer)``
>      This control moves the focal point of the camera by the specified
> 

Can you repost patches 1 and 2 separately (i.e. without the RFC tag)? This
seems reasonable to apply, so let's split this off from the remainder of
this series.

Regards,

	Hans
