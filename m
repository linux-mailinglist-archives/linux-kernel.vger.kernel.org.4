Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A607283C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbjFHPam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjFHPaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:30:39 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43B941FE6;
        Thu,  8 Jun 2023 08:30:30 -0700 (PDT)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 0AAB3A419;
        Thu,  8 Jun 2023 17:30:19 +0200 (CEST)
Message-ID: <c34db414-159a-313f-90eb-2bfc0f4496fa@gpxsee.org>
Date:   Thu, 8 Jun 2023 17:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v6 1/1] Added Digiteq Automotive MGB4 driver
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Martin_T=c5=afma?= <martin.tuma@digiteqautomotive.com>
References: <20230524112126.2242-1-tumic@gpxsee.org>
 <20230524112126.2242-2-tumic@gpxsee.org>
 <3a7da3cd-8d03-a2c4-0534-a75565aefc13@xs4all.nl>
 <7072a8f3-5c9e-1170-e480-6fb57b95110f@gpxsee.org>
 <6b792de3-bb2c-d2b5-a652-eca6d20dad20@xs4all.nl>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <6b792de3-bb2c-d2b5-a652-eca6d20dad20@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 06. 23 12:23, Hans Verkuil wrote:

> Can you make a list of which sysfs properties correspond to existing V4L2
> format or timing fields and which are 'new'?
> 

On the left all the current mgb4 sysfs properties (see the admin-guide 
doc from the patch for description), on the right v4l2 structures where 
they could be mapped (may not be true for all of them in the patch, I 
will check it and update the code in v7)


--- PCIE CARD ---

module_type		-
module_version		-
fw_type			-
fw_version		-
serial_number		-
temperature		hwmon

--- INPUTS ---

input_id		-
oldi_lane_width		-
color_mapping		-
link_status		v4l2_input.status (V4L2_IN_ST_NO_SYNC)
stream_status		v4l2_input.status (V4L2_IN_ST_NO_SIGNAL)
video_width		v4l2_bt_timings.width
video_height		v4l2_bt_timings.height
vsync_status		v4l2_bt_timings.polarities
hsync_status		v4l2_bt_timings.polarities
vsync_gap_length	-
hsync_gap_length	-
pclk_frequency		v4l2_bt_timings.pixelclock
hsync_width		v4l2_bt_timings.hsync
vsync_width		v4l2_bt_timings.vsync
hback_porch		v4l2_bt_timings.hbackporch
hfront_porch		v4l2_bt_timings.hfrontporch
vback_porch		v4l2_bt_timings.vbackporch
vfront_porch		v4l2_bt_timings.vfrontporch
frequency_range		-
alignment		v4l2_pix_format.bytesperline
fpdl3_input_width	-
gmsl_mode		-
gmsl_stream_id		-
gmsl_fec		-

--- OUTPUTS ---

output_id		-
video_source		-
display_width		v4l2_bt_timings.width
display_height		v4l2_bt_timings.height
frame_rate		v4l2_frmivalenum
hsync_polarity		v4l2_bt_timings.polarities
vsync_polarity		v4l2_bt_timings.polarities
de_polarity		-
pclk_frequency		v4l2_bt_timings.pixelclock
hsync_width		v4l2_bt_timings.hsync
vsync_width		v4l2_bt_timings.vsync
vsync_width		v4l2_bt_timings.vsync
hback_porch		v4l2_bt_timings.hbackporch
hfront_porch		v4l2_bt_timings.hfrontporch
vback_porch		v4l2_bt_timings.vbackporch
vfront_porch		v4l2_bt_timings.vfrontporch
alignment		v4l2_pix_format.bytesperline
fpdl3_output_width	-


M.
