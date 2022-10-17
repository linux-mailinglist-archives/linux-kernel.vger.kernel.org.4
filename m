Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4F5601ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiJQUzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJQUz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:55:27 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D8372840;
        Mon, 17 Oct 2022 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1666040123; i=@motorola.com;
        bh=HU1eyf6XxPxhgLDpdJSDh7oNO5BXTgMqPuFCWF35IyE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=H+I7adbEwQr2Yj8UepmwqyidB5sRsBMT6ggVRvDqOrwFqwrR44AtV4gx6NFByhLZe
         JniOc57zvrLxcHyr9PCoB6N/jweJsxhMxzHnFZHYMxLkoI7cD3Y0iDTfvwqpa1f7D8
         U2lcx+qmczuBxS6De4AZZ6RhGAN/EJV/E3NoghlHY2oECRCmQvolRDFWvL4f+acMWT
         EjuQTPPTHFXOWv6tk16wru97Wf8ssfzK/WD6wlRajipt4vXA5AWg533Xuqcwbl0elq
         BCS/1C/MK/+RCcQTLHpeVDxbKYK1pHOArmux6EQmpok3DXT3tJgkAnwNEb5bHVhG1r
         iN0oUMSbQ5/Zg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRWlGSWpSXmKPExsWS8eKJmK7VQd9
  kg3nfDS2OtT1ht3hyoJ3RonfZHjaL5sXr2Sw6Jy5ht1jYtoTF4vKuOWwWi5a1MltsabvCZPHj
  Tx+zxaoFB9gduD1md8xk9di0qpPNY//cNewei/sms3r0/zXw2LL/M6PH501yAexRrJl5SfkVC
  awZD6dtZizYo1zxp/EfUwPjLekuRi4OIYFpTBLn9m1jhnDWMkn8+tfG1sXIycEmoCax4PUqZh
  BbREBW4vCV32BFzALPmSWm7bzF1MXIwSEsYCqxemcMSA2LgKrEgx/nWEBsXgFLiQvHdoPZEgL
  yEvsPnmWGiAtKnJz5hAWklVlAXWL9PCGQMDNQSfPW2cwTGHlmIamahVA1C0nVAkbmVYymxalF
  ZalFuhZ6SUWZ6RkluYmZOXqJVbqJeqXFuqmJxSW6RnqJ5cV6qcXFesWVuck5KXp5qSWbGIEhn
  1LkcmcH44llf/QOMUpyMCmJ8nbM8E0W4kvKT6nMSCzOiC8qzUktPsQow8GhJMH7cwdQTrAoNT
  21Ii0zBxh/MGkJDh4lEd7ObUBp3uKCxNzizHSI1ClGY46ps//tZ+bo3N91gFmIJS8/L1VKnPf
  HPqBSAZDSjNI8uEGwtHCJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDv/f1AU3gy80rg9r0C
  OoUJ6JSM/V4gp5QkIqSkGpj4vx4v/GZy9nnUecNmvrsf/QNylR8k8ATNXv/mpPd8zhUv7y46W
  v1lTtGbemPft+Ffnxv5hnYU7ft6ViZwA8PjvcnCDm9dK1//deJs22/m2GTbf2Nl34tn5z0ZBJ
  sy3h7gtV66cU6Tl66KVP+XGLFNUamCy3fnOk/KsL65bsnix69n1Tz6O6lIV/4Jt+5ZvYkLu2Z
  V7cpfzZK7Y11q57FD+x7+1srJfDrXV96WPcXxVP1Mxh+hGxad1NkWumZCjPEnz7rLK5S+Zp/c
  qFFmpZj5bAHr0SzNq8qVa2e8F1ZIrJq/WTE1Yo9K8hzjj5sNvu+vPvdmhki4ybLPu/gWTzq4+
  OqWhe1WAnP57pYriWv9VWIpzkg01GIuKk4EAH2ZhrGGAwAA
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-20.tower-635.messagelabs.com!1666040122!17191!1
X-Originating-IP: [104.232.228.22]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25519 invoked from network); 17 Oct 2022 20:55:22 -0000
Received: from unknown (HELO va32lpfpp02.lenovo.com) (104.232.228.22)
  by server-20.tower-635.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Oct 2022 20:55:22 -0000
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4Mrq5630shz50GGl;
        Mon, 17 Oct 2022 20:55:22 +0000 (UTC)
Received: from p1g3.mot.com (unknown [100.64.172.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4Mrq561vSgzbpxx;
        Mon, 17 Oct 2022 20:55:22 +0000 (UTC)
From:   Dan Vacura <w36195@motorola.com>
To:     linux-usb@vger.kernel.org
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jeff Vanhoof <qjv001@motorola.com>,
        Dan Vacura <w36195@motorola.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 0/6] uvc gadget performance issues
Date:   Mon, 17 Oct 2022 15:54:38 -0500
Message-Id: <20221017205446.523796-1-w36195@motorola.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello uvc gadget developers,

V3 series updated with fixes for the two issues discussed below, plus
fixes for the configfs interrupt patch.

V2 series with added patches to disable these performance features at
the userspace level for devices that don't work well with the UDC hw,
i.e. dwc3 in this case. Also included are updates to comments for the v1
patch.

Original note:

I'm working on a 5.15.41 based kernel on a qcom chipset with the dwc3
controller and I'm encountering two problems related to the recent performance
improvement changes:

https://patchwork.kernel.org/project/linux-usb/patch/20210628155311.16762-5-m.grzeschik@pengutronix.de/  and 
https://patchwork.kernel.org/project/linux-usb/patch/20210628155311.16762-6-m.grzeschik@pengutronix.de/

If I revert these two changes, then I have much improved stability and a
transmission problem I'm seeing is gone. Has there been any success from
others on 5.15 with this uvc improvement and any recommendations for my
current problems?  Those being:

1) a smmu panic, snippet here: 

    <3>[  718.314900][  T803] arm-smmu 15000000.apps-smmu: Unhandled arm-smmu context fault from a600000.dwc3!
    <3>[  718.314994][  T803] arm-smmu 15000000.apps-smmu: FAR    = 0x00000000efe60800
    <3>[  718.315023][  T803] arm-smmu 15000000.apps-smmu: PAR    = 0x0000000000000000
    <3>[  718.315048][  T803] arm-smmu 15000000.apps-smmu: FSR    = 0x40000402 [TF R SS ]
    <3>[  718.315074][  T803] arm-smmu 15000000.apps-smmu: FSYNR0    = 0x5f0003
    <3>[  718.315096][  T803] arm-smmu 15000000.apps-smmu: FSYNR1    = 0xaa02
    <3>[  718.315117][  T803] arm-smmu 15000000.apps-smmu: context bank#    = 0x1b
    <3>[  718.315141][  T803] arm-smmu 15000000.apps-smmu: TTBR0  = 0x001b0000c2a92000
    <3>[  718.315165][  T803] arm-smmu 15000000.apps-smmu: TTBR1  = 0x001b000000000000
    <3>[  718.315192][  T803] arm-smmu 15000000.apps-smmu: SCTLR  = 0x0a5f00e7 ACTLR  = 0x00000003
    <3>[  718.315245][  T803] arm-smmu 15000000.apps-smmu: CBAR  = 0x0001f300
    <3>[  718.315274][  T803] arm-smmu 15000000.apps-smmu: MAIR0   = 0xf404ff44 MAIR1   = 0x0000efe4
    <3>[  718.315297][  T803] arm-smmu 15000000.apps-smmu: SID = 0x40
    <3>[  718.315318][  T803] arm-smmu 15000000.apps-smmu: Client info: BID=0x5, PID=0xa, MID=0x2
    <3>[  718.315377][  T803] arm-smmu 15000000.apps-smmu: soft iova-to-phys=0x0000000000000000

    I can reduce this panic with the proposed patch, but it still happens until I
    disable the "req->no_interrupt = 1" logic.
 
2) The frame is not fully transmitted in dwc3 with sg support enabled. 

    There seems to be a mapping limit I'm seeing where only the roughly first
    70% of the total frame is sent. Interestingly, if I allocate a larger
    size for the buffer upfront, in uvc_queue_setup(), like sizes[0] =
    video->imagesize * 3. Then the issue rarely happens. For example, when I
    do YUYV I see green, uninitialized data, at the bottom part of the
    frame. If I do MJPG with smaller filled sizes, the transmission is fine.

    +-------------------------+
    |                         |
    |                         |
    |                         |
    |      Good data          |
    |                         |
    |                         |
    |                         |
    +-------------------------+
    |xxxxxxxxxxxxxxxxxxxxxxxxx|
    |xxxx  Bad data  xxxxxxxxx|
    |xxxxxxxxxxxxxxxxxxxxxxxxx|
    +-------------------------+


Dan Vacura (4):
  usb: gadget: uvc: fix dropped frame after missed isoc
  usb: gadget: uvc: fix sg handling in error case
  usb: gadget: uvc: make interrupt skip logic configurable
  usb: gadget: uvc: add configfs option for sg support

Jeff Vanhoof (2):
  usb: dwc3: gadget: cancel requests instead of release after missed
    isoc
  usb: gadget: uvc: fix sg handling during video encode

 .../ABI/testing/configfs-usb-gadget-uvc       |  2 +
 Documentation/usb/gadget-testing.rst          |  4 ++
 drivers/usb/dwc3/core.h                       |  1 +
 drivers/usb/dwc3/gadget.c                     | 38 +++++++++++++------
 drivers/usb/gadget/function/f_uvc.c           |  5 +++
 drivers/usb/gadget/function/u_uvc.h           |  2 +
 drivers/usb/gadget/function/uvc.h             |  2 +
 drivers/usb/gadget/function/uvc_configfs.c    |  4 ++
 drivers/usb/gadget/function/uvc_queue.c       | 18 ++++++---
 drivers/usb/gadget/function/uvc_video.c       | 27 +++++++++----
 10 files changed, 78 insertions(+), 25 deletions(-)

-- 
2.34.1

