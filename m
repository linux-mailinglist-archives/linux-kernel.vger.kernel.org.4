Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A1C6C27B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjCUCDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUCDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:03:49 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5811B9EC0;
        Mon, 20 Mar 2023 19:03:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VeL..TW_1679364221;
Received: from 30.97.48.72(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VeL..TW_1679364221)
          by smtp.aliyun-inc.com;
          Tue, 21 Mar 2023 10:03:42 +0800
Message-ID: <cc819e9b-c613-b3c1-4ea2-8ef828e97508@linux.alibaba.com>
Date:   Tue, 21 Mar 2023 10:03:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v1] usb/phy add sprd ums512 usbphy
To:     Cixi Geng <cixi.geng@linux.dev>, gregkh@linuxfoundation.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        tony@atomide.com, felipe.balbi@linux.intel.com,
        paul@crapouillou.net, linus.walleij@linaro.org,
        cixi.geng1@unisoc.com, gengcixi@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230312171438.177952-1-cixi.geng@linux.dev>
 <01d7b3c7-1514-5d8c-fc88-11b3d806496f@linux.alibaba.com>
 <be5ddb68b247b8d3b7305ef46d703d0ba2b3753a.camel@linux.dev>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <be5ddb68b247b8d3b7305ef46d703d0ba2b3753a.camel@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2023 11:37 PM, Cixi Geng wrote:
> On Mon, 2023-03-13 at 17:11 +0800, Baolin Wang wrote:
>>
>>

...

>>> +
>>> +MODULE_DESCRIPTION("UNISOC USB PHY driver");
>>> +MODULE_LICENSE("GPL");
>>> diff --git a/drivers/usb/phy/phy-sprd-ums512.h
>>> b/drivers/usb/phy/phy-sprd-ums512.h
>>> new file mode 100644
>>> index 000000000000..903da0573eae
>>> --- /dev/null
>>> +++ b/drivers/usb/phy/phy-sprd-ums512.h
>>> @@ -0,0 +1,39 @@
>>> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>>> +/*
>>> + * Spreadtrum UMS512 SOC USB registers file
>>> + *
>>> + * Copyright C 2022, Spreadtrum Communications Inc.
>>> + */
>>> +
>>> +#define
>>> MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_DATABUS16_8
>>>      0x10000000
>>> +#define
>>> MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_DMPULLDOWN                 0x8
>>> +#define
>>> MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_DPPULLDOWN                 0x10
>>> +#define
>>> MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_ISO_SW_EN                  0x1
>>> +#define
>>> MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_PS_PD_L                    0x8
>>> +#define
>>> MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_PS_PD_S                    0x10
>>> +#define
>>> MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_RESERVED                   0xff
>>> ff
>>> +#define
>>> MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_TFREGRES                   0x1f
>>> 80000
>>> +#define
>>> MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_TUNEHSAMP                  0x60
>>> 00000
>>> +#define
>>> MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_VBUSVLDEXT                 0x10
>>> 000
>>> +#define
>>> MASK_ANLG_PHY_G2_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN         0x2
>>> +#define
>>> MASK_ANLG_PHY_G2_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN         0x4
>>> +#define
>>> MASK_AON_APB_ANA_EB                                            0x10
>>> 00
>>> +#define
>>> MASK_AON_APB_CGM_DPHY_REF_EN                                   0x40
>>> 0
>>> +#define
>>> MASK_AON_APB_CGM_OTG_REF_EN                                    0x10
>>> 00
>>> +#define
>>> MASK_AON_APB_OTG_PHY_SOFT_RST                                  0x20
>>> 0
>>> +#define
>>> MASK_AON_APB_OTG_UTMI_EB                                       0x10
>>> 0
>>> +#define
>>> MASK_AON_APB_OTG_UTMI_SOFT_RST                                 0x10
>>> 0
>>> +#define
>>> MASK_AON_APB_OTG_VBUS_VALID_PHYREG                             0x10
>>> 00000
>>> +#define
>>> MASK_AON_APB_USB2_PHY_IDDIG                                    0x8
>>> +#define
>>> MASK_AON_APB_UTMI_WIDTH_SEL                                    0x40
>>> 000000
>>> +#define
>>> REG_ANLG_PHY_G2_ANALOG_USB20_USB20_BATTER_PLL                  0x00
>>> 5c
>>> +#define
>>> REG_ANLG_PHY_G2_ANALOG_USB20_USB20_ISO_SW                      0x00
>>> 70
>>> +#define
>>> REG_ANLG_PHY_G2_ANALOG_USB20_USB20_TRIMMING                    0x00
>>> 64
>>> +#define
>>> REG_ANLG_PHY_G2_ANALOG_USB20_USB20_UTMI_CTL1                   0x00
>>> 58
>>> +#define
>>> REG_ANLG_PHY_G2_ANALOG_USB20_USB20_UTMI_CTL2                   0x00
>>> 60
>>> +#define
>>> REG_ANLG_PHY_G2_ANALOG_USB20_REG_SEL_CFG_0                     0x00
>>> 74
>>> +#define
>>> REG_AON_APB_APB_EB1                                            0x00
>>> 04
>>> +#define
>>> REG_AON_APB_APB_RST1                                           0x00
>>> 10
>>> +#define
>>> REG_AON_APB_CGM_REG1                                           0x01
>>> 38
>>> +#define
>>> REG_AON_APB_OTG_PHY_CTRL                                       0x02
>>> 08
>>> +#define
>>> REG_AON_APB_OTG_PHY_TEST                                       0x02
>>> 04
>>
>> Move them to the driver file and please rename the ugly macro names,
>> too
>> long :(
>>
>> And why not move the usb phy driver to be a generic phy driver? I
>> mean
>> move it to the drivers/phy.
> Do you mean all the usb-phy need move to driver/phy? or just this
> driver?

If I remember correctly, new phy drivers should go to the generic phy 
framework unless there are some reasons to prevent.

Greg, how do you think?
