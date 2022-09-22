Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2802E5E6665
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiIVPDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIVPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:03:49 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E801ABD78;
        Thu, 22 Sep 2022 08:03:47 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z25so15191000lfr.2;
        Thu, 22 Sep 2022 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date;
        bh=FqJTTa0040pz4+zDEMMVMjYX693hU3+TskBo25nD1Vg=;
        b=pzASvSpau+ZVDPtkMcK/X3/2vgwJLDcKLysSpf1Qgs4mv2dl5QM53QEjWeDKQKfdem
         HnJTSofg6eFl7kY+YnytctI2IzhvIDwLBuWYwGHejdu6y6ZxTxbiLuhl30KJ8BDpQZfi
         LPuNj4wF9CYnpVEUT1MN0/4Rum9seT4/8fPS2CkhBky8bp3oKL1e7n0uHrIbJdznSjqm
         YidobCNCx4WWtM5DX+s3AJBCvpsEkf3CdDA7kSLaT7vVH1ACK1tD8lKFLGnE6gZAfjXT
         gCTXCqOTbgWblrlHbrg7Wt6ZoK9v6uHUq9Vwrxfu6QwdjqYf0r2zu+sJj821q8SGXbHO
         pReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date;
        bh=FqJTTa0040pz4+zDEMMVMjYX693hU3+TskBo25nD1Vg=;
        b=qCkHSnnXEGsVMDjZcvnMZSZEZVS83O1bBGHbuccJxTbHcD5R9bwpDmdofXI6DMoDT7
         LAcKd+O5Uf8qPadx98h69fTHXoLWOQ96ChTViozV7MdtQsF9XzM29zZP0as9k96IjzuE
         TZTiJoR0pqFiJAP3m2sSkriDF2JsVN1t21uAppd/af25I5mxnQZ/VTFxsfqVb7hjgzKk
         JzXeEyiCtDttFEextJ++YEeMRStas/+T0wM6NjEUrkUVQP1dVadmsSfjlEog/6TflT0z
         ftSpmF6j9STwaGE0cfVPNbfUKvi3PqvMfgC5rf0r9esJ/fOu/dkLC6m23AevY5ZEpQMZ
         d78Q==
X-Gm-Message-State: ACrzQf3ZRAjcUZW92gj1TsKZDgIkqigQBPd6e5JZD68svr4del1FR44n
        7k2kPuAzaLvOV5B/wsKMKGkSwH0k92GUdA==
X-Google-Smtp-Source: AMsMyM6Fk1BQFwcQIaEzEk1/fhnAE82qw8yCYAl3hj+/rZxSUzqMftVEDpI/RMGORWY7qQeqH3gd5Q==
X-Received: by 2002:a05:6512:b17:b0:4a0:13c:9b3f with SMTP id w23-20020a0565120b1700b004a0013c9b3fmr1371583lfu.91.1663859025100;
        Thu, 22 Sep 2022 08:03:45 -0700 (PDT)
Received: from razdolb (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id f16-20020a05651232d000b0048b365176d9sm966359lfg.286.2022.09.22.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:03:42 -0700 (PDT)
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-3-mike.rudenko@gmail.com>
 <CAPY8ntAqCR_OJOX7qbZcsj55SXnB7K4aLCYY4vbTJWKGYoTX6w@mail.gmail.com>
User-agent: mu4e 1.9.0; emacs 28.2
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: i2c: add support for ov4689
Date:   Thu, 22 Sep 2022 17:56:02 +0300
In-reply-to: <CAPY8ntAqCR_OJOX7qbZcsj55SXnB7K4aLCYY4vbTJWKGYoTX6w@mail.gmail.com>
Message-ID: <87h70zjvsk.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

and thanks for reviewing this!

On 2022-09-22 at 11:54 +01, Dave Stevenson <dave.stevenson@raspberrypi.com> wrote:

> Hi Mikhail
>
> On Sun, 11 Sept 2022 at 21:02, Mikhail Rudenko <mike.rudenko@gmail.com> wrote:
>>
>> Add a V4L2 sub-device driver for OmniVision OV4689 image sensor. This
>> is a 4 Mpx image sensor using the I2C bus for control and the CSI-2
>> bus for data.
>>
>> This driver supports following features:
>> - manual exposure and analog gain control support
>> - test pattern support
>> - media controller support
>> - runtime PM support
>> - support following resolutions:
>>   + 2688x1520 at 30 fps
>>
>> The driver provides all mandatory V4L2 controls for compatibility with
>> libcamera. The sensor supports 1/2/4-lane CSI-2 modes, but the driver
>> implements 4 lane mode only at this moment.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  MAINTAINERS                |   1 +
>>  drivers/media/i2c/Kconfig  |  14 +
>>  drivers/media/i2c/Makefile |   1 +
>>  drivers/media/i2c/ov4689.c | 951 +++++++++++++++++++++++++++++++++++++
>>  4 files changed, 967 insertions(+)
>>  create mode 100644 drivers/media/i2c/ov4689.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 63c4844f26e6..1857f3864e1b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14529,6 +14529,7 @@ L:      linux-media@vger.kernel.org
>>  S:     Maintained
>>  T:     git git://linuxtv.org/media_tree.git
>>  F:     Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>> +F:     drivers/media/i2c/ov5647.c
>>
>>  OMNIVISION OV5640 SENSOR DRIVER
>>  M:     Steve Longerbeam <slongerbeam@gmail.com>
>> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
>> index fae2baabb773..4993e1ae2ea8 100644
>> --- a/drivers/media/i2c/Kconfig
>> +++ b/drivers/media/i2c/Kconfig
>> @@ -429,6 +429,20 @@ config VIDEO_OV2740
>>           To compile this driver as a module, choose M here: the
>>           module will be called ov2740.
>>
>> +config VIDEO_OV4689
>> +       tristate "OmniVision OV4689 sensor support"
>> +       depends on OF
>> +       depends on GPIOLIB && VIDEO_DEV && I2C
>> +       select MEDIA_CONTROLLER
>> +       select VIDEO_V4L2_SUBDEV_API
>> +       select V4L2_FWNODE
>> +       help
>> +         This is a Video4Linux2 sensor-level driver for the OmniVision
>> +         OV4689 camera.
>> +
>> +         To compile this driver as a module, choose M here: the
>> +         module will be called ov4689.
>> +
>>  config VIDEO_OV5640
>>         tristate "OmniVision OV5640 sensor support"
>>         depends on OF
>> diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
>> index 3e1696963e7f..7446c0a1eed0 100644
>> --- a/drivers/media/i2c/Makefile
>> +++ b/drivers/media/i2c/Makefile
>> @@ -78,6 +78,7 @@ obj-$(CONFIG_VIDEO_OV2659) += ov2659.o
>>  obj-$(CONFIG_VIDEO_OV2680) += ov2680.o
>>  obj-$(CONFIG_VIDEO_OV2685) += ov2685.o
>>  obj-$(CONFIG_VIDEO_OV2740) += ov2740.o
>> +obj-$(CONFIG_VIDEO_OV4689) += ov4689.o
>>  obj-$(CONFIG_VIDEO_OV5640) += ov5640.o
>>  obj-$(CONFIG_VIDEO_OV5645) += ov5645.o
>>  obj-$(CONFIG_VIDEO_OV5647) += ov5647.o
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> new file mode 100644
>> index 000000000000..9f05e812acf8
>> --- /dev/null
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -0,0 +1,951 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * ov4689 driver
>> + *
>> + * Copyright (C) 2017 Fuzhou Rockchip Electronics Co., Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <media/media-entity.h>
>> +#include <media/v4l2-async.h>
>> +#include <media/v4l2-ctrls.h>
>> +#include <media/v4l2-subdev.h>
>> +#include <media/v4l2-fwnode.h>
>> +
>> +#define CHIP_ID                                0x004688
>> +#define OV4689_REG_CHIP_ID             0x300a
>> +
>> +#define OV4689_XVCLK_FREQ              24000000
>> +
>> +#define OV4689_REG_CTRL_MODE           0x0100
>> +#define OV4689_MODE_SW_STANDBY         0x0
>> +#define OV4689_MODE_STREAMING          BIT(0)
>> +
>> +#define OV4689_REG_EXPOSURE            0x3500
>> +#define OV4689_EXPOSURE_MIN            4
>> +#define OV4689_EXPOSURE_STEP           1
>> +#define OV4689_VTS_MAX                 0x7fff
>> +
>> +#define OV4689_REG_GAIN_H              0x3508
>> +#define OV4689_REG_GAIN_L              0x3509
>> +#define OV4689_GAIN_H_MASK             0x07
>> +#define OV4689_GAIN_H_SHIFT            8
>> +#define OV4689_GAIN_L_MASK             0xff
>> +#define OV4689_GAIN_MIN                        0x10
>> +#define OV4689_GAIN_MAX                        0xf8
>> +#define OV4689_GAIN_STEP               1
>> +#define OV4689_GAIN_DEFAULT            0x10
>> +
>> +#define OV4689_REG_TEST_PATTERN                0x5040
>> +#define OV4689_TEST_PATTERN_ENABLE     0x80
>> +#define OV4689_TEST_PATTERN_DISABLE    0x0
>> +
>> +#define OV4689_REG_VTS                 0x380e
>> +
>> +#define REG_NULL                       0xFFFF
>> +
>> +#define OV4689_REG_VALUE_08BIT         1
>> +#define OV4689_REG_VALUE_16BIT         2
>> +#define OV4689_REG_VALUE_24BIT         3
>> +
>> +#define OV4689_LANES                   4
>> +#define OV4689_BITS_PER_SAMPLE         10
>> +
>> +static const char *const ov4689_supply_names[] = {
>> +       "avdd", /* Analog power */
>> +       "dovdd", /* Digital I/O power */
>> +       "dvdd", /* Digital core power */
>> +};
>> +
>> +#define OV4689_NUM_SUPPLIES ARRAY_SIZE(ov4689_supply_names)
>> +
>> +struct regval {
>> +       u16 addr;
>> +       u8 val;
>> +};
>> +
>> +struct ov4689_mode {
>> +       u32 width;
>> +       u32 height;
>> +       u32 max_fps;
>> +       u32 hts_def;
>> +       u32 vts_def;
>> +       u32 exp_def;
>> +       const struct regval *reg_list;
>> +};
>> +
>> +struct ov4689 {
>> +       struct i2c_client *client;
>> +       struct clk *xvclk;
>> +       struct gpio_desc *reset_gpio;
>> +       struct gpio_desc *pwdn_gpio;
>> +       struct regulator_bulk_data supplies[OV4689_NUM_SUPPLIES];
>> +
>> +       struct v4l2_subdev subdev;
>> +       struct media_pad pad;
>> +
>> +       struct mutex mutex; /* lock to protect streaming, ctrls and cur_mode */
>> +       bool streaming;
>> +       struct v4l2_ctrl_handler ctrl_handler;
>> +       struct v4l2_ctrl *exposure;
>> +       struct v4l2_ctrl *anal_gain;
>> +       struct v4l2_ctrl *digi_gain;
>> +       struct v4l2_ctrl *hblank;
>> +       struct v4l2_ctrl *vblank;
>> +       struct v4l2_ctrl *test_pattern;
>> +
>> +       const struct ov4689_mode *cur_mode;
>> +};
>> +
>> +#define to_ov4689(sd) container_of(sd, struct ov4689, subdev)
>> +
>> +/*
>> + * Xclk 24Mhz
>> + */
>> +static const struct regval ov4689_global_regs[] = {
>> +       { REG_NULL, 0x00 },
>> +};
>> +
>> +/*
>> + * Xclk 24Mhz
>> + * max_framerate 30fps
>> + * mipi_datarate per lane 1008Mbps
>
> Data rate stated as 1008Mbps here....
>
>> + */
>> +static const struct regval ov4689_2688x1520_regs[] = {
>> +       {0x0103, 0x01}, {0x3638, 0x00}, {0x0300, 0x00},
>> +       {0x0302, 0x2a}, {0x0303, 0x00}, {0x0304, 0x03},
>> +       {0x030b, 0x00}, {0x030d, 0x1e}, {0x030e, 0x04},
>> +       {0x030f, 0x01}, {0x0312, 0x01}, {0x031e, 0x00},
>> +       {0x3000, 0x20}, {0x3002, 0x00}, {0x3018, 0x72},
>> +       {0x3020, 0x93}, {0x3021, 0x03}, {0x3022, 0x01},
>> +       {0x3031, 0x0a}, {0x303f, 0x0c}, {0x3305, 0xf1},
>> +       {0x3307, 0x04}, {0x3309, 0x29}, {0x3500, 0x00},
>> +       {0x3501, 0x60}, {0x3502, 0x00}, {0x3503, 0x04},
>> +       {0x3504, 0x00}, {0x3505, 0x00}, {0x3506, 0x00},
>> +       {0x3507, 0x00}, {0x3508, 0x00}, {0x3509, 0x80},
>> +       {0x350a, 0x00}, {0x350b, 0x00}, {0x350c, 0x00},
>> +       {0x350d, 0x00}, {0x350e, 0x00}, {0x350f, 0x80},
>> +       {0x3510, 0x00}, {0x3511, 0x00}, {0x3512, 0x00},
>> +       {0x3513, 0x00}, {0x3514, 0x00}, {0x3515, 0x80},
>> +       {0x3516, 0x00}, {0x3517, 0x00}, {0x3518, 0x00},
>> +       {0x3519, 0x00}, {0x351a, 0x00}, {0x351b, 0x80},
>> +       {0x351c, 0x00}, {0x351d, 0x00}, {0x351e, 0x00},
>> +       {0x351f, 0x00}, {0x3520, 0x00}, {0x3521, 0x80},
>> +       {0x3522, 0x08}, {0x3524, 0x08}, {0x3526, 0x08},
>> +       {0x3528, 0x08}, {0x352a, 0x08}, {0x3602, 0x00},
>> +       {0x3603, 0x40}, {0x3604, 0x02}, {0x3605, 0x00},
>> +       {0x3606, 0x00}, {0x3607, 0x00}, {0x3609, 0x12},
>> +       {0x360a, 0x40}, {0x360c, 0x08}, {0x360f, 0xe5},
>> +       {0x3608, 0x8f}, {0x3611, 0x00}, {0x3613, 0xf7},
>> +       {0x3616, 0x58}, {0x3619, 0x99}, {0x361b, 0x60},
>> +       {0x361c, 0x7a}, {0x361e, 0x79}, {0x361f, 0x02},
>> +       {0x3632, 0x00}, {0x3633, 0x10}, {0x3634, 0x10},
>> +       {0x3635, 0x10}, {0x3636, 0x15}, {0x3646, 0x86},
>> +       {0x364a, 0x0b}, {0x3700, 0x17}, {0x3701, 0x22},
>> +       {0x3703, 0x10}, {0x370a, 0x37}, {0x3705, 0x00},
>> +       {0x3706, 0x63}, {0x3709, 0x3c}, {0x370b, 0x01},
>> +       {0x370c, 0x30}, {0x3710, 0x24}, {0x3711, 0x0c},
>> +       {0x3716, 0x00}, {0x3720, 0x28}, {0x3729, 0x7b},
>> +       {0x372a, 0x84}, {0x372b, 0xbd}, {0x372c, 0xbc},
>> +       {0x372e, 0x52}, {0x373c, 0x0e}, {0x373e, 0x33},
>> +       {0x3743, 0x10}, {0x3744, 0x88}, {0x3745, 0xc0},
>> +       {0x374a, 0x43}, {0x374c, 0x00}, {0x374e, 0x23},
>> +       {0x3751, 0x7b}, {0x3752, 0x84}, {0x3753, 0xbd},
>> +       {0x3754, 0xbc}, {0x3756, 0x52}, {0x375c, 0x00},
>> +       {0x3760, 0x00}, {0x3761, 0x00}, {0x3762, 0x00},
>> +       {0x3763, 0x00}, {0x3764, 0x00}, {0x3767, 0x04},
>> +       {0x3768, 0x04}, {0x3769, 0x08}, {0x376a, 0x08},
>> +       {0x376b, 0x20}, {0x376c, 0x00}, {0x376d, 0x00},
>> +       {0x376e, 0x00}, {0x3773, 0x00}, {0x3774, 0x51},
>> +       {0x3776, 0xbd}, {0x3777, 0xbd}, {0x3781, 0x18},
>> +       {0x3783, 0x25}, {0x3798, 0x1b}, {0x3800, 0x00},
>> +       {0x3801, 0x08}, {0x3802, 0x00}, {0x3803, 0x04},
>> +       {0x3804, 0x0a}, {0x3805, 0x97}, {0x3806, 0x05},
>> +       {0x3807, 0xfb}, {0x3808, 0x0a}, {0x3809, 0x80},
>> +       {0x380a, 0x05}, {0x380b, 0xf0}, {0x380c, 0x0a},
>> +       {0x380d, 0x80}, {0x380e, 0x06}, {0x380f, 0x12},
>> +       {0x3810, 0x00}, {0x3811, 0x08}, {0x3812, 0x00},
>> +       {0x3813, 0x04}, {0x3814, 0x01}, {0x3815, 0x01},
>> +       {0x3819, 0x01}, {0x3820, 0x00}, {0x3821, 0x06},
>> +       {0x3829, 0x00}, {0x382a, 0x01}, {0x382b, 0x01},
>> +       {0x382d, 0x7f}, {0x3830, 0x04}, {0x3836, 0x01},
>> +       {0x3837, 0x00}, {0x3841, 0x02}, {0x3846, 0x08},
>> +       {0x3847, 0x07}, {0x3d85, 0x36}, {0x3d8c, 0x71},
>> +       {0x3d8d, 0xcb}, {0x3f0a, 0x00}, {0x4000, 0xf1},
>> +       {0x4001, 0x40}, {0x4002, 0x04}, {0x4003, 0x14},
>> +       {0x400e, 0x00}, {0x4011, 0x00}, {0x401a, 0x00},
>> +       {0x401b, 0x00}, {0x401c, 0x00}, {0x401d, 0x00},
>> +       {0x401f, 0x00}, {0x4020, 0x00}, {0x4021, 0x10},
>> +       {0x4022, 0x07}, {0x4023, 0xcf}, {0x4024, 0x09},
>> +       {0x4025, 0x60}, {0x4026, 0x09}, {0x4027, 0x6f},
>> +       {0x4028, 0x00}, {0x4029, 0x02}, {0x402a, 0x06},
>> +       {0x402b, 0x04}, {0x402c, 0x02}, {0x402d, 0x02},
>> +       {0x402e, 0x0e}, {0x402f, 0x04}, {0x4302, 0xff},
>> +       {0x4303, 0xff}, {0x4304, 0x00}, {0x4305, 0x00},
>> +       {0x4306, 0x00}, {0x4308, 0x02}, {0x4500, 0x6c},
>> +       {0x4501, 0xc4}, {0x4502, 0x40}, {0x4503, 0x01},
>> +       {0x4601, 0xa7}, {0x4800, 0x04}, {0x4813, 0x08},
>> +       {0x481f, 0x40}, {0x4829, 0x78}, {0x4837, 0x10},
>> +       {0x4b00, 0x2a}, {0x4b0d, 0x00}, {0x4d00, 0x04},
>> +       {0x4d01, 0x42}, {0x4d02, 0xd1}, {0x4d03, 0x93},
>> +       {0x4d04, 0xf5}, {0x4d05, 0xc1}, {0x5000, 0xf3},
>> +       {0x5001, 0x11}, {0x5004, 0x00}, {0x500a, 0x00},
>> +       {0x500b, 0x00}, {0x5032, 0x00}, {0x5040, 0x00},
>> +       {0x5050, 0x0c}, {0x5500, 0x00}, {0x5501, 0x10},
>> +       {0x5502, 0x01}, {0x5503, 0x0f}, {0x8000, 0x00},
>> +       {0x8001, 0x00}, {0x8002, 0x00}, {0x8003, 0x00},
>> +       {0x8004, 0x00}, {0x8005, 0x00}, {0x8006, 0x00},
>> +       {0x8007, 0x00}, {0x8008, 0x00}, {0x3638, 0x00},
>> +       {REG_NULL, 0x00},
>> +};
>> +
>> +static const struct ov4689_mode supported_modes[] = {
>> +       {
>> +               .width = 2688,
>> +               .height = 1520,
>> +               .max_fps = 30,
>> +               .exp_def = 0x0600,
>> +               .hts_def = 0x0a80,
>> +               .vts_def = 0x0612,
>> +               .reg_list = ov4689_2688x1520_regs,
>> +       },
>> +};
>> +
>> +#define OV4689_LINK_FREQ_500MHZ 500000000
>> +static const s64 link_freq_menu_items[] = { OV4689_LINK_FREQ_500MHZ };
>
> ... but a link frequency of 500MHz (ie 1000Mbit/s) here.
> Seeing as you compute the pixel rate based on the link frequency,
> that's going to mean that the pixel rate is incorrect.
> Link frequency should be 504MHz.
>
> Your PLL settings appear to match the 24MHz configuration in table
> 2-11 "sample PLL configuration" of the datasheet, so it would confirm
> that MIPI_SCLK is 1008MHz and MIPI_PCLK is 126MHz (at 1008/8 seems to
> be more byte clock than pixel (10bpp) clock).

Those are leftovers from the bsp driver, and they will be definitely
changed in v3. Recovering correct pixel clock, hblank and vblank
matching the observed fps needs some experimentation, which I hope to
carry out over the weekend.

>
>   Dave
>

--
Best regards,
Mikhail
