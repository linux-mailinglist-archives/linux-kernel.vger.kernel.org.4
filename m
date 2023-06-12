Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D3F72BB32
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjFLIv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjFLIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:51:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15EFE73;
        Mon, 12 Jun 2023 01:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 210EE61D55;
        Mon, 12 Jun 2023 08:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F6BC433EF;
        Mon, 12 Jun 2023 08:51:06 +0000 (UTC)
Message-ID: <089e728b-0596-d3e3-39a1-651a3ac73e33@xs4all.nl>
Date:   Mon, 12 Jun 2023 10:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v6 1/1] Added Digiteq Automotive MGB4 driver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Martin_T=c5=afma?= <martin.tuma@digiteqautomotive.com>
References: <20230524112126.2242-1-tumic@gpxsee.org>
 <20230524112126.2242-2-tumic@gpxsee.org>
 <3a7da3cd-8d03-a2c4-0534-a75565aefc13@xs4all.nl>
 <7072a8f3-5c9e-1170-e480-6fb57b95110f@gpxsee.org>
 <6b792de3-bb2c-d2b5-a652-eca6d20dad20@xs4all.nl>
 <c34db414-159a-313f-90eb-2bfc0f4496fa@gpxsee.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <c34db414-159a-313f-90eb-2bfc0f4496fa@gpxsee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 17:30, Martin Tůma wrote:
> On 08. 06. 23 12:23, Hans Verkuil wrote:
> 
>> Can you make a list of which sysfs properties correspond to existing V4L2
>> format or timing fields and which are 'new'?
>>
> 
> On the left all the current mgb4 sysfs properties (see the admin-guide doc from the patch for description), on the right v4l2 structures where they could be mapped (may not be true for all of them in
> the patch, I will check it and update the code in v7)
> 
> 
> --- PCIE CARD ---
> 
> module_type        -
> module_version        -
> fw_type            -
> fw_version        -
> serial_number        -
> temperature        hwmon
> 
> --- INPUTS ---
> 
> input_id        -
> oldi_lane_width        -
> color_mapping        -
> link_status        v4l2_input.status (V4L2_IN_ST_NO_SYNC)
> stream_status        v4l2_input.status (V4L2_IN_ST_NO_SIGNAL)
> video_width        v4l2_bt_timings.width
> video_height        v4l2_bt_timings.height
> vsync_status        v4l2_bt_timings.polarities
> hsync_status        v4l2_bt_timings.polarities
> vsync_gap_length    -
> hsync_gap_length    -
> pclk_frequency        v4l2_bt_timings.pixelclock
> hsync_width        v4l2_bt_timings.hsync
> vsync_width        v4l2_bt_timings.vsync
> hback_porch        v4l2_bt_timings.hbackporch
> hfront_porch        v4l2_bt_timings.hfrontporch
> vback_porch        v4l2_bt_timings.vbackporch
> vfront_porch        v4l2_bt_timings.vfrontporch
> frequency_range        -
> alignment        v4l2_pix_format.bytesperline
> fpdl3_input_width    -
> gmsl_mode        -
> gmsl_stream_id        -
> gmsl_fec        -
> 
> --- OUTPUTS ---
> 
> output_id        -
> video_source        -
> display_width        v4l2_bt_timings.width
> display_height        v4l2_bt_timings.height
> frame_rate        v4l2_frmivalenum

The frame rate is a property of the width/height+blanking and the
pixel clock frequency. IMHO it does not make sense to have this as
a writable property. Read-only is OK.

> hsync_polarity        v4l2_bt_timings.polarities
> vsync_polarity        v4l2_bt_timings.polarities
> de_polarity        -
> pclk_frequency        v4l2_bt_timings.pixelclock
> hsync_width        v4l2_bt_timings.hsync
> vsync_width        v4l2_bt_timings.vsync
> vsync_width        v4l2_bt_timings.vsync
> hback_porch        v4l2_bt_timings.hbackporch
> hfront_porch        v4l2_bt_timings.hfrontporch
> vback_porch        v4l2_bt_timings.vbackporch
> vfront_porch        v4l2_bt_timings.vfrontporch
> alignment        v4l2_pix_format.bytesperline
> fpdl3_output_width    -
> 
> 
> M.

The property I am most concerned with is alignment (both for input and output).
But it is not clear to me what the use-case is.

Regards,

	Hans
