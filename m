Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D520361A4E5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiKDWw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiKDWvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:51:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAA83F073;
        Fri,  4 Nov 2022 15:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6ED7DB83015;
        Fri,  4 Nov 2022 22:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC92C433C1;
        Fri,  4 Nov 2022 22:47:58 +0000 (UTC)
Message-ID: <3ce335f6-7ba1-a139-86da-b0d68bfeb744@xs4all.nl>
Date:   Fri, 4 Nov 2022 23:47:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/3] media: sunxi: Add H6 deinterlace driver
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        mchehab@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, samuel@sholland.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221101123201.3021129-1-jernej.skrabec@gmail.com>
 <71e8ea95-8c3a-cc85-1638-5ce421a60e99@xs4all.nl>
 <2652146.mvXUDI8C0e@jernej-laptop>
Content-Language: en-US
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <2652146.mvXUDI8C0e@jernej-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 18:36, Jernej Škrabec wrote:
> Hi Hans,
> 
> Dne petek, 04. november 2022 ob 12:33:50 CET je Hans Verkuil napisal(a):
>> Hi Jernej,
>>
>> Can you add a patch updating the MAINTAINERS file? Just post a 4/3 patch :-)
> 
> It's already part of patch 2. I didn't see the reason to split it to separate 
> patch.

I totally missed that. Apologies for the noise!

Regards,

	Hans

> 
> Best regards,
> Jernej
> 
>>
>> Regards,
>>
>> 	Hans
>>
>> On 01/11/2022 13:31, Jernej Skrabec wrote:
>>> This series implements driver for H6 deinterlace core, which is
>>> newer version of core, covered by sun8i-di (v2.3). Contrary to
>>> older one, it doesn't support scaling, but it supports iommu,
>>> has additional motion compensated deinterlacing algorithm and
>>> supports different pixel formats.
>>>
>>> v4l2-compliance 1.23.0-4961, 64 bits, 64-bit time_t
>>> v4l2-compliance SHA: f86484524f32 2022-10-21 10:08:58
>>>
>>> Compliance test for sun50i-di device /dev/video0:
>>>
>>> Driver Info:
>>>         Driver name      : sun50i-di
>>>         Card type        : sun50i-di
>>>         Bus info         : platform:sun50i-di
>>>         Driver version   : 6.1.0
>>>         Capabilities     : 0x84208000
>>>         
>>>                 Video Memory-to-Memory
>>>                 Streaming
>>>                 Extended Pix Format
>>>                 Device Capabilities
>>>         
>>>         Device Caps      : 0x04208000
>>>         
>>>                 Video Memory-to-Memory
>>>                 Streaming
>>>                 Extended Pix Format
>>>
>>> Required ioctls:
>>>         test VIDIOC_QUERYCAP: OK
>>>         test invalid ioctls: OK
>>>
>>> Allow for multiple opens:
>>>         test second /dev/video0 open: OK
>>>         test VIDIOC_QUERYCAP: OK
>>>         test VIDIOC_G/S_PRIORITY: OK
>>>         test for unlimited opens: OK
>>>
>>> Debug ioctls:
>>>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>>>         test VIDIOC_LOG_STATUS: OK (Not Supported)
>>>
>>> Input ioctls:
>>>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>>>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>>>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>>>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>>>         test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>>>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>>>         Inputs: 0 Audio Inputs: 0 Tuners: 0
>>>
>>> Output ioctls:
>>>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>>>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>>>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>>>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>>>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>>>         Outputs: 0 Audio Outputs: 0 Modulators: 0
>>>
>>> Input/Output configuration ioctls:
>>>         test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>>>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>>>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>>>         test VIDIOC_G/S_EDID: OK (Not Supported)
>>>
>>> Control ioctls:
>>>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
>>>         test VIDIOC_QUERYCTRL: OK (Not Supported)
>>>         test VIDIOC_G/S_CTRL: OK (Not Supported)
>>>         test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
>>>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
>>>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>>>         Standard Controls: 0 Private Controls: 0
>>>
>>> Format ioctls:
>>>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>>>         test VIDIOC_G/S_PARM: OK (Not Supported)
>>>         test VIDIOC_G_FBUF: OK (Not Supported)
>>>         test VIDIOC_G_FMT: OK
>>>         test VIDIOC_TRY_FMT: OK
>>>         test VIDIOC_S_FMT: OK
>>>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>>>         test Cropping: OK (Not Supported)
>>>         test Composing: OK (Not Supported)
>>>         test Scaling: OK (Not Supported)
>>>
>>> Codec ioctls:
>>>         test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>>>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>>>         test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
>>>
>>> Buffer ioctls:
>>>         test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>>>         test VIDIOC_EXPBUF: OK
>>>         test Requests: OK (Not Supported)
>>>
>>> Total for sun50i-di device /dev/video0: 45, Succeeded: 45, Failed: 0,
>>> Warnings: 0
>>>
>>> Best regards,
>>> Jernej
>>>
>>> Jernej Skrabec (3):
>>>   media: dt-bindings: media: Add Allwinner H6 Deinterlace binding
>>>   media: sunxi: Add H6 deinterlace driver
>>>   arm64: dts: allwinner: h6: Add deinterlace node
>>>  
>>>  .../allwinner,sun50i-h6-deinterlace.yaml      |   74 ++
>>>  MAINTAINERS                                   |    4 +-
>>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   12 +
>>>  drivers/media/platform/sunxi/Kconfig          |    1 +
>>>  drivers/media/platform/sunxi/Makefile         |    1 +
>>>  .../media/platform/sunxi/sun50i-di/Kconfig    |   15 +
>>>  .../media/platform/sunxi/sun50i-di/Makefile   |    2 +
>>>  .../platform/sunxi/sun50i-di/sun50i-di.c      | 1142 +++++++++++++++++
>>>  .../platform/sunxi/sun50i-di/sun50i-di.h      |  175 +++
>>>  9 files changed, 1425 insertions(+), 1 deletion(-)
>>>  create mode 100644
>>>  Documentation/devicetree/bindings/media/allwinner,sun50i-h6-deinterlace.
>>>  yaml create mode 100644 drivers/media/platform/sunxi/sun50i-di/Kconfig
>>>  create mode 100644 drivers/media/platform/sunxi/sun50i-di/Makefile
>>>  create mode 100644 drivers/media/platform/sunxi/sun50i-di/sun50i-di.c
>>>  create mode 100644 drivers/media/platform/sunxi/sun50i-di/sun50i-di.h
>>>
>>> --
>>> 2.38.1
> 
> 
> 
> 

