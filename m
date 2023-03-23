Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162236C6672
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjCWLWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjCWLWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:22:31 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EED125B1;
        Thu, 23 Mar 2023 04:22:25 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D65D124DEAE;
        Thu, 23 Mar 2023 19:22:22 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Mar
 2023 19:22:23 +0800
Received: from [192.168.60.143] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Mar
 2023 19:22:22 +0800
Message-ID: <d2dd7d2c-8469-c3a9-5ecd-9c1a22caee2c@starfivetech.com>
Date:   Thu, 23 Mar 2023 19:22:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 6/6] media: starfive: Add Starfive Camera Subsystem
 driver
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        "Todor Tomov" <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Eugen Hristev" <eugen.hristev@collabora.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230310120553.60586-1-jack.zhu@starfivetech.com>
 <20230310120553.60586-7-jack.zhu@starfivetech.com>
 <20230312124339.GD2545@pendragon.ideasonboard.com>
 <650b6882-ea02-e4c8-1f73-9e5bdeab290d@starfivetech.com>
 <20230321175626.GD20234@pendragon.ideasonboard.com>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230321175626.GD20234@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/22 1:56, Laurent Pinchart wrote:
> Hi Jack,
> 
> On Tue, Mar 21, 2023 at 08:56:34PM +0800, Jack Zhu wrote:
>> On 2023/3/12 20:43, Laurent Pinchart wrote:
>> > Hi Jack,
>> > 
>> > Thank you for the patch.
>> > 
>> > I'll do a partial review here as the patch is huge and I'm lacking time
>> > at the moment.
>> 
>> Thank you for the review and your time.
>> 
>> > On Fri, Mar 10, 2023 at 08:05:53PM +0800, Jack Zhu wrote:
>> >> Add the driver for Starfive Camera Subsystem found on
>> >> Starfive JH7110 SoC. It is used for handing image sensor
>> >> data.
>> >> 
>> >> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> >> ---
>> >>  drivers/media/platform/Kconfig                |    1 +
>> >>  drivers/media/platform/Makefile               |    1 +
>> >>  drivers/media/platform/starfive/Kconfig       |   18 +
>> >>  drivers/media/platform/starfive/Makefile      |   14 +
>> >>  drivers/media/platform/starfive/stf_camss.c   |  728 +++++++++
>> >>  drivers/media/platform/starfive/stf_camss.h   |  104 ++
>> >>  drivers/media/platform/starfive/stf_common.h  |  149 ++
>> >>  drivers/media/platform/starfive/stf_isp.c     | 1079 ++++++++++++++
>> >>  drivers/media/platform/starfive/stf_isp.h     |  183 +++
>> >>  .../media/platform/starfive/stf_isp_hw_ops.c  | 1286 ++++++++++++++++
>> >>  drivers/media/platform/starfive/stf_video.c   | 1286 ++++++++++++++++
>> >>  drivers/media/platform/starfive/stf_video.h   |   89 ++
>> >>  drivers/media/platform/starfive/stf_vin.c     | 1314 +++++++++++++++++
>> >>  drivers/media/platform/starfive/stf_vin.h     |  194 +++
>> >>  .../media/platform/starfive/stf_vin_hw_ops.c  |  357 +++++
>> >>  include/uapi/linux/stf_isp_ioctl.h            |  127 ++
>> >>  16 files changed, 6930 insertions(+)
>> >>  create mode 100644 drivers/media/platform/starfive/Kconfig
>> >>  create mode 100644 drivers/media/platform/starfive/Makefile
>> >>  create mode 100644 drivers/media/platform/starfive/stf_camss.c
>> >>  create mode 100644 drivers/media/platform/starfive/stf_camss.h
>> >>  create mode 100644 drivers/media/platform/starfive/stf_common.h
>> >>  create mode 100644 drivers/media/platform/starfive/stf_isp.c
>> >>  create mode 100644 drivers/media/platform/starfive/stf_isp.h
>> >>  create mode 100644 drivers/media/platform/starfive/stf_isp_hw_ops.c
>> >>  create mode 100644 drivers/media/platform/starfive/stf_video.c
>> >>  create mode 100644 drivers/media/platform/starfive/stf_video.h
>> >>  create mode 100644 drivers/media/platform/starfive/stf_vin.c
>> >>  create mode 100644 drivers/media/platform/starfive/stf_vin.h
>> >>  create mode 100644 drivers/media/platform/starfive/stf_vin_hw_ops.c
>> >>  create mode 100644 include/uapi/linux/stf_isp_ioctl.h
> 
> [snip]
> 
>> >> diff --git a/drivers/media/platform/starfive/stf_camss.c b/drivers/media/platform/starfive/stf_camss.c
>> >> new file mode 100644
>> >> index 000000000000..525f2d80c5eb
>> >> --- /dev/null
>> >> +++ b/drivers/media/platform/starfive/stf_camss.c
>> >> @@ -0,0 +1,728 @@
> 
> [snip]
> 
>> >> +/*
>> >> + * stfcamss_find_sensor - Find a linked media entity which represents a sensor
>> >> + * @entity: Media entity to start searching from
>> >> + *
>> >> + * Return a pointer to sensor media entity or NULL if not found
>> >> + */
>> >> +struct media_entity *stfcamss_find_sensor(struct media_entity *entity)
>> > 
>> > From a camss point of view, the source is the csi2rx. You shouldn't
>> > need to access the sensor directly, only the csi2rx. If you think you
>> > have a need to access the sensor, please explain why and we can discuss
>> > it.
>> 
>> need to use format and bpp of sensor to configure isp HW.
> 
> You can obtain the same information from the ISP sink pad:
> 
> 
> +----------+       +------------+       +-----------+
> |          |       |            |       |           | 
> | Sensor [0| ----> |0] csi2rx [1| ----> |0]   ISP   |
> |          |       |            |       |           |
> +----------+       +------------+       +-----------+
> 
> (I'm not entirely sure if the csi2rx and ISP pad numbers are correct,
> but that's the idea.)
> 
> The csi2rx can't modify the format (size and bpp), so the format on the
> sensor's pad 0, csi2rx pad 0, csi2rx pad 1 and ISP pad 0 must be
> identical.
> 
> In isp_sensor_fmt_to_index(), the ISP driver doesn't need to get the
> format from the sensor, it can use the format on ISP pad 0 instead.
> 
> In video_enum_framesizes(), the ISP driver shouldn't look at the format
> on the ISP input at all, it must enumerate all sizes that the video node
> supports, regardless of what is connected to its input.
> 
> video_enum_frameintervals() should be dropped, the ISP itself has no
> notion of frame interval. Userspace can query and configure the frame
> rate from the sensor subdev directly.
> 
> In video_pipeline_s_fmt(), the ISP driver shouldn't look at the format
> on the ISP input at all either. It must accept any format supported by
> the ISP. It's only when starting streaming that the pipeline is
> validated to make sure the formats configured on all subdevs match. I
> recommend reading https://git.ideasonboard.org/doc/mc-v4l2.git for an
> overview of how Media Controller-based drivers should behave. The
> documentation describes how the API is meant to be used from userspace,
> but the operating principles apply to driver development too.
> 
> video_subscribe_event() and video_unsubscribe_event() should also be
> dropped, events from the sensor can be accessed by userspace on the
> sensor subdev directly.
> 
> vin_set_stream() should call .s_stream() on the csi2rx, not the sensor.
> The csi2rx .s_stream() handler will forward the call to the sensor.
> 

OK, will fix. Thank you for your comment.

>> >> +{
>> >> +	struct media_pad *pad;
>> >> +
>> >> +	while (1) {
>> >> +		if (!entity->pads)
>> >> +			return NULL;
>> >> +
>> >> +		pad = &entity->pads[0];
>> >> +		if (!(pad->flags & MEDIA_PAD_FL_SINK))
>> >> +			return NULL;
>> >> +
>> >> +		pad = media_pad_remote_pad_first(pad);
>> >> +		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
>> >> +			return NULL;
>> >> +
>> >> +		entity = pad->entity;
>> >> +
>> >> +		if (entity->function == MEDIA_ENT_F_CAM_SENSOR)
>> >> +			return entity;
>> >> +	}
>> >> +}
> 
> [snip]
> 
>> >> diff --git a/include/uapi/linux/stf_isp_ioctl.h b/include/uapi/linux/stf_isp_ioctl.h
>> >> new file mode 100644
>> >> index 000000000000..3f302ef235d2
>> >> --- /dev/null
>> >> +++ b/include/uapi/linux/stf_isp_ioctl.h
>> >> @@ -0,0 +1,127 @@
> 
> [snip]
> 
>> >> +enum _STF_ISP_IOCTL {
>> > 
>> > Device-specific ioctls are allowed, but they must all be clearly
>> > documented.
>> 
>> OK, I will add annotations for these ioctls.
>> 
>> > 
>> >> +	STF_ISP_IOCTL_LOAD_FW = BASE_VIDIOC_PRIVATE + 1,
>> > 
>> > Why can't you use the Linux kernel firmware API ?
>> 
>> The ioctl is used for loading config file, it is different from
>> the Linux kernel firmware API. I will rename it.
> 
> Could you explain what the config file is used for ?

used for debugging. It's not necessary. I will drop it.

> 
>> >> +	STF_ISP_IOCTL_DMABUF_ALLOC,
>> >> +	STF_ISP_IOCTL_DMABUF_FREE,
>> >> +	STF_ISP_IOCTL_GET_HW_VER,
>> > 
>> > Not used, drop them.
>> 
>> OK, will drop them.
>> 
>> > 
>> >> +	STF_ISP_IOCTL_REG,
>> > 
>> > Setting registers from userspace isn't allowed. No exception.
>> 
>> OK, will fix.
>> 
>> > 
>> >> +	STF_ISP_IOCTL_SHADOW_LOCK,
>> >> +	STF_ISP_IOCTL_SHADOW_UNLOCK,
>> >> +	STF_ISP_IOCTL_SHADOW_UNLOCK_N_TRIGGER,
>> >> +	STF_ISP_IOCTL_SET_USER_CONFIG_ISP,
>> > 
>> > I'm not sure what these ioctls do exactly as documentation is missing,
>> > but I don't think they are the right API. Please describe the problem
>> > you're trying to solve, and we'll find a good API.
>> 
>> These were used for debugging, I will drop them. Thanks.
>> 
>> >> +	STF_ISP_IOCTL_MAX
>> >> +};
> 
> [snip]
> 
