Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2847328B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244650AbjFPHUM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jun 2023 03:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244566AbjFPHUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:20:09 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78D71FF5;
        Fri, 16 Jun 2023 00:20:06 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 14DD024E24F;
        Fri, 16 Jun 2023 15:20:05 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 16 Jun
 2023 15:20:05 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 16 Jun
 2023 15:20:04 +0800
Message-ID: <cb5a9579-116a-e7df-0e53-6b57975f031d@starfivetech.com>
Date:   Fri, 16 Jun 2023 15:20:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 0/6] Add StarFive Camera Subsystem driver
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230525083202.67933-1-jack.zhu@starfivetech.com>
 <20230601103749.GA9271@pendragon.ideasonboard.com>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230601103749.GA9271@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for your comments.

On 2023/6/1 18:37, Laurent Pinchart wrote:
> Hi Jack,
> 
> Thank you for the patches, I'm happy to see the ISP driver progressing.
> 
> On Thu, May 25, 2023 at 04:31:56PM +0800, Jack Zhu wrote:
>> Hi,
>> 
>> This series is the v6 series that attempts to support the Camera Subsystem
>> found on StarFive JH7110 SoC.
> 
> Could you please share the media graph for the device ? I'd like the
> output of both `media-ctl --print-dot -d /dev/media0` and
> `media-ctl -p -d /dev/media0` ?
> 
> Also, have you run v4l2-compliance to test the driver ? Could you please
> share the v4l2-compliance output ?
> 

Yes, I will provide the media graph for the device and v4l2-compliance output.

>> Changes in v6:
>> - Added 'bus-type' in bindings example.
>> - Corrected spelling errors.
>> - As reviewed by Bryan, used 'nclks' and 'nrsts' variables.
>> - Added lccf config for ISP.
>> 
>> v5 link: https://lore.kernel.org/all/20230512102844.51084-1-jack.zhu@starfivetech.com/
>> 
>> Changes in v5:
>> - Rebased on v6.4-rc1.
>> - Added new patch.
>> - Modified ISP driver.
>> 
>> v4 link: https://lore.kernel.org/all/20230413035541.62129-1-jack.zhu@starfivetech.com/
>> 
>> Previous cover letter from v4:
>> 
>> This patch series adds support for the StarFive Camera Subsystem
>> found on StarFive JH7110 SoC.
>> 
>> The driver implements V4L2, Media controller and V4L2 subdev interfaces.
>> Camera sensor using V4L2 subdev interface in the kernel is supported.
>> 
>> The driver is tested on VisionFive V2 board with IMX219 camera sensor.
>> GStreamer 1.18.5 with v4l2src plugin is supported.
>> 
>> Changes since v3:
>> Patch 1:
>> - Modified port@0 and port@1 properties.
>> - Extended the port@0 example with appropriate properties.
>> - Added 'port@0' for 'required'
>> Patch 2:
>> - Modified spelling errors.
>> Patch 3:
>> - Merged patch 5 into the patch with an explanation for compatible in
>>   commit msg.
>> Patch 6:
>> - Asserted pixel_rst[i] reset in the loop after the err_disable_pixclk
>>   label.
>> - Modified Code Style for getting sys_rst and p_rst.
>> - Renamed clk_name to name and modified the relevant code.
>> Patch 9:
>> - Added static for stfcamss_get_mem_res function.
>> - Added static for isp_close function.
>> - Fixed implicit conversion warning for stf_vin_map_isp_pad function.
>> - Dropped unused variables.
>> 
>>   v3: https://lore.kernel.org/all/20230331121826.96973-1-jack.zhu@starfivetech.com/
>> 
>> Changes since v2:
>> - Rebased on v6.3-rc1.
>> Patch 1:
>> - Modified spelling errors.
>> - Added port@0.
>> - Modified '$ref' of port.
>> - Added 'ports' to 'required'.
>> - Dropped 'stfcamss' label in example.
>> - Added port@0 in example.
>> - Added MAINTAINERS file.
>> Patch 2:
>> - Split this patch into three new patches.
>> - Modified compatible property.
>> - Replaced clock names with the existing names.
>> - Modified 'bus-type' and 'clock-lanes'
>> - Added port@2 - port@4
>> - Dropped 'csi2rx' label in example.
>> Patch 3:
>> - Updated rst and dot file as three pipelines were deleted.
>> Patch 4:
>> - Split this patch into three new patches.
>> - Dropped .s_power() and .get_fmt().
>> - Dropped CSI-2 DT support.
>> - Dropped v4l2_device_register_subdev_nodes().
>> - Used assigned-clock-rates in DT to set clk value.
>> - Modified 'compatible' field.
>> Patch 5:
>> - Deleted three pipelines. 
>> - Modified 'stfcamss_clocks'/'stfcamss_resets' struct.
>> - Dropped stfcamss_find_sensor() function.
>> - Removed redundant code from stfcamss_of_parse_endpoint_node().
>> - Modified spelling errors.
>> - Rewrote stfcamss_reg_media_subdev_node() function.
>> - Modified stfcamss_subdev_notifier_bound().
>> - Modified stfcamss_probe() function.
>> - Dropped stfcamss_suspend() and stfcamss_resume().
>> - Dropped dev_info() in stfcamss_remove() function.
>> - Added 'stf_' prefix for enum subdev_type.
>> - Moved all includes to the top in stf_camss.h file.
>> - Dropped unused fields in stfcamss struct.
>> - Replaced Custom logging macros with regular macros.
>> - Rewrote register read and write functions.
>> - Used lowercase for all hex constants.
>> - Used macro to name registers.
>> - Dropped unused ioctl and stf_isp_ioctl.h file.
>> 
>>   v2: https://lore.kernel.org/all/20230310120553.60586-1-jack.zhu@starfivetech.com/
>> 
>> Changes since v1:
>> - Deleted starfive,jh7110-mipi-csi2.yaml.
>> - Converted cdns,csi2rx.txt to cdns,csi2rx.yaml and added ‘resets’
>>   properties.
>> - Added ‘cdns,csi2rx.yaml’ in ‘CADENCE MIPI-CSI2 BRIDGES’ entry.
>> - The following contents were modified in starfive,jh7110-camss.yaml:
>>   dropped quotes from ’id’ and ‘schema’; dropped ‘|’ for ‘description’;
>>   corrected the wrong or redundant words: ‘a ISP’, ‘PD ISP’;
>>   dropped ‘minItems’ for ‘reg’, ‘clocks’, ‘resets’ and ‘interrupts’;
>>   dropped the '_clk' and 'rst_' prefix about the 'clock-names' and
>>   'reset-names';
>>   changed ‘endpoint@1’ to ‘endpoint’; updated examples;
>> - Updated Subject for some patches.
>> - Merged patch 6, 7, 8, 9, 10, 11 into one patch.
>> 
>> Jack Zhu (6):
>>   media: dt-bindings: Add JH7110 Camera Subsystem
>>   media: admin-guide: Add starfive_camss.rst for Starfive Camera
>>     Subsystem
>>   media: starfive: Add basic driver
>>   media: starfive: Add video driver
>>   media: starfive: Add ISP driver
>>   media: starfive: Add VIN driver
>> 
>>  .../admin-guide/media/starfive_camss.rst      |   57 +
>>  .../media/starfive_camss_graph.dot            |   16 +
>>  .../admin-guide/media/v4l-drivers.rst         |    1 +
>>  .../bindings/media/starfive,jh7110-camss.yaml |  180 +++
>>  MAINTAINERS                                   |    9 +
>>  drivers/media/platform/Kconfig                |    1 +
>>  drivers/media/platform/Makefile               |    1 +
>>  drivers/media/platform/starfive/Kconfig       |   19 +
>>  drivers/media/platform/starfive/Makefile      |   14 +
>>  drivers/media/platform/starfive/stf_camss.c   |  476 +++++++
>>  drivers/media/platform/starfive/stf_camss.h   |  157 +++
>>  drivers/media/platform/starfive/stf_common.h  |   18 +
>>  drivers/media/platform/starfive/stf_isp.c     |  550 ++++++++
>>  drivers/media/platform/starfive/stf_isp.h     |  483 +++++++
>>  .../media/platform/starfive/stf_isp_hw_ops.c  |  468 +++++++
>>  drivers/media/platform/starfive/stf_video.c   |  864 +++++++++++++
>>  drivers/media/platform/starfive/stf_video.h   |   95 ++
>>  drivers/media/platform/starfive/stf_vin.c     | 1134 +++++++++++++++++
>>  drivers/media/platform/starfive/stf_vin.h     |  180 +++
>>  .../media/platform/starfive/stf_vin_hw_ops.c  |  241 ++++
>>  20 files changed, 4964 insertions(+)
>>  create mode 100644 Documentation/admin-guide/media/starfive_camss.rst
>>  create mode 100644 Documentation/admin-guide/media/starfive_camss_graph.dot
>>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>>  create mode 100644 drivers/media/platform/starfive/Kconfig
>>  create mode 100644 drivers/media/platform/starfive/Makefile
>>  create mode 100644 drivers/media/platform/starfive/stf_camss.c
>>  create mode 100644 drivers/media/platform/starfive/stf_camss.h
>>  create mode 100644 drivers/media/platform/starfive/stf_common.h
>>  create mode 100644 drivers/media/platform/starfive/stf_isp.c
>>  create mode 100644 drivers/media/platform/starfive/stf_isp.h
>>  create mode 100644 drivers/media/platform/starfive/stf_isp_hw_ops.c
>>  create mode 100644 drivers/media/platform/starfive/stf_video.c
>>  create mode 100644 drivers/media/platform/starfive/stf_video.h
>>  create mode 100644 drivers/media/platform/starfive/stf_vin.c
>>  create mode 100644 drivers/media/platform/starfive/stf_vin.h
>>  create mode 100644 drivers/media/platform/starfive/stf_vin_hw_ops.c
> 
