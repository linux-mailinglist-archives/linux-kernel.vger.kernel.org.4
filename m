Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE245FBA71
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJKSfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJKSfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:35:06 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5811133A21;
        Tue, 11 Oct 2022 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1665513304; i=@motorola.com;
        bh=MGt60hVQQ5VJI4RJz0uZlOG6yEiXbNGBxvj9X74xbpM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=e2+Xa1Smx/7IZq3Im+cgtnEuRyar6Z/xmJjCFm3dnezMMCzAMVJgbnTHSCCHppnJw
         ESxqdg+yUUhARPxbWKe/9NGEy37efXsOQKLYWH2gTOe1gpnpRgme3lYKIGYJsz8rGJ
         euIsh1PMvOpIPsCJAaGxCZBQGdA47IoavxiB7S02YDWrVrmDKkNT3JA1rJi0rurxK7
         y8eZiglGyq2oNCROAt5GM5O4qVJ+oMe1oRYg8ojJVMclTXicURr95vK80oM6aDntBw
         PB2gP60YgVz+76NFjqLVuCSVRPuu/mNK3qJYBfS+yaIYjz9a9CAK1Icd9D3aCnYYKd
         7ZNgEECtciWpQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRWlGSWpSXmKPExsUyYU+Ds274dtd
  kg6mb9CyOtT1ht3hyoJ3RonfZHjaL5sXr2Sw6Jy5ht1jYtoTF4vKuOWwWi5a1MltsabvCZPHj
  Tx+zxaoFB9gduD1md8xk9di0qpPNY//cNewei/sms3r0/zXw2LL/M6PH501yAexRrJl5SfkVC
  awZ/5e/Zy1YqFDx8XNqA+N6yS5GTg4hgSlMEvs+yXcxcgHZa5kkXu7dwAaSYBNQk1jwehUziC
  0iICtx+MpvZpAiZoFDzBItn/vZQRLCAqYSRxY/YwWxWQRUJc4uWQhm8wpYSmydeR3MlhCQl9h
  /8CwzRFxQ4uTMJyxdjBxAg9Ql1s8TAgkzA5U0b53NPIGRZxaSqlkIVbOQVC1gZF7FaJ1UlJme
  UZKbmJmja2hgoGtoaKJraalraGKml1ilm6hXWqxbnlpcomukl1herJdaXKxXXJmbnJOil5das
  okRGPwpRcmTdjB+7/upd4hRkoNJSZRXpcc1WYgvKT+lMiOxOCO+qDQntfgQowwHh5IEr+ZKoJ
  xgUWp6akVaZg4wEmHSEhw8SiK87zcDpXmLCxJzizPTIVKnGI05ps7+t5+Zo3N/1wFmIZa8/Lx
  UKXHegq1ApQIgpRmleXCDYAniEqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVhXrZtQFN4MvNK
  4Pa9AjqFCeiUk1edQE4pSURISTUwVR2/uHjFkZ67Z5guTnFRT3y1729k8rc7V1zkPzTPeZCuy
  t5gyG+o3pass22ZPlNN9FsDD/GtrK9+HzfZ4ZU+5Yhrw59MBtdvmm8fajy4sDT3KuPKl663Tu
  //8WdS19Wr3J0M/EfYVuSoPVH187Z4VOzgI2+Tny7ovPHKnAOnJ31zfyN27nfp/4MXJHVF/Wx
  kS49L+B8oO3VRIy03d7tw0EUXNakTLza+bljrIPl3JdPsu5HPfbn+56lZG16y4lyacWuR5e6I
  cFmxF5IF8R6TLL9on37yZPK6bU/urmZfYZLW5Hki6URi4551Yhb7b117tzhzhs+TQ8Ghgpdey
  uy+HOMRWbZMf9brz8+EGCYc+K3EUpyRaKjFXFScCABaAhqBiwMAAA==
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-10.tower-636.messagelabs.com!1665513303!517972!1
X-Originating-IP: [144.188.128.67]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7048 invoked from network); 11 Oct 2022 18:35:03 -0000
Received: from unknown (HELO ilclpfpp01.lenovo.com) (144.188.128.67)
  by server-10.tower-636.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Oct 2022 18:35:03 -0000
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4Mn4Fy6VzWzfBZq;
        Tue, 11 Oct 2022 18:35:02 +0000 (UTC)
Received: from p1g3.mot.com (unknown [100.64.172.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4Mn4Fy6FDszbvDd;
        Tue, 11 Oct 2022 18:35:02 +0000 (UTC)
From:   Dan Vacura <w36195@motorola.com>
To:     linux-usb@vger.kernel.org
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Dan Vacura <w36195@motorola.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 0/3] uvc gadget performance issues
Date:   Tue, 11 Oct 2022 13:34:32 -0500
Message-Id: <20221011183437.298437-1-w36195@motorola.com>
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

Please find my V2 series with added patches to disable these performance
features at the userspace level for devices that don't work well with
the UDC hw, i.e. dwc3 in this case. Also included are updates to
comments for the v1 patch.

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


Dan Vacura (3):
  usb: gadget: uvc: make interrupt skip logic configurable
  usb: gadget: uvc: fix sg handling in error case
  usb: gadget: uvc: add configfs option for sg support

 .../ABI/testing/configfs-usb-gadget-uvc       |  2 ++
 Documentation/usb/gadget-testing.rst          |  4 ++++
 drivers/usb/gadget/function/f_uvc.c           |  5 +++++
 drivers/usb/gadget/function/u_uvc.h           |  2 ++
 drivers/usb/gadget/function/uvc.h             |  1 +
 drivers/usb/gadget/function/uvc_configfs.c    |  4 ++++
 drivers/usb/gadget/function/uvc_queue.c       | 18 +++++++++++-----
 drivers/usb/gadget/function/uvc_video.c       | 21 ++++++++++++++-----
 8 files changed, 47 insertions(+), 10 deletions(-)

-- 
2.34.1

