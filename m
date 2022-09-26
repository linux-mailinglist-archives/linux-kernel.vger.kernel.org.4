Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9AB5EB1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiIZTyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiIZTyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:54:37 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529FDA2847;
        Mon, 26 Sep 2022 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1664222072; i=@motorola.com;
        bh=RZaPqiYCxO2MYMXHGDOyjHVP5gXf7ukYDIqiGimYGrQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=hkwD5eODPAfk1t7wimP5PptToftKeqjZiEvtSY1U6xYowDbrpfP+6MSugO7VG2vMb
         pA9owUb4nNjYAzLTusplrOO8eue/FEfBEkTqs0DhcuDp634BSVw1RQ4owJQpL0tRtR
         4kwsAeiMqFJpPtAG3R+0ykifsII+AoTqN3zE9SS6s4MadMzaClQX4eZmTOsO53POlt
         /6orvpZmFU1NlM3SuS2bEK4wMDJrUzTWzJrgZpygdWVhz2FkOYiRK2m4LuGipKKm9J
         Dw1UWGC8re/G0ZilVrF34RtcM3z9Ct2pg7+Kfe85Tx32opQI/7kl55JNL1Pv+Vlycb
         imzwQ2O/KaOsg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRWlGSWpSXmKPExsWS8eKJuG4ps1G
  ywd5H2hbH2p6wWzQvXs9m0TlxCbvF5V1z2CwWLWtlttjSdoXJYtWCA+wO7B6zO2ayemxa1cnm
  sX/uGnaP/r8GHlv2f2b0+LxJLoAtijUzLym/IoE1Y9+m/YwFe6Ur/n4XaGC8J9rFyMUhJDCNS
  WLBgy8sEM4SJom5ZyYxdzFycrAJqEkseL0KzBYRkJU4fOU3M0gRs8AqJol9Le/ZQRLCAqYSfb
  s3sYLYLAKqEq+uHmAEsXkFLCX2NF9nA7ElBOQl9h88ywwRF5Q4OfMJ0DYOoEHqEuvnCYGEmYF
  KmrfOZp7AyDMLSdUshKpZSKoWMDKvYrRKKspMzyjJTczM0TU0MNA1NDTRtTTXNTPQS6zSTdQr
  LdYtTy0u0TXSSywv1kstLtYrrsxNzknRy0st2cQIDOWUokSbHYyd/T/1DjFKcjApifKK7zNMF
  uJLyk+pzEgszogvKs1JLT7EKMPBoSTBu5TRKFlIsCg1PbUiLTMHGFcwaQkOHiUR3uY/QK28xQ
  WJucWZ6RCpU4zGHFNn/9vPzNG5v+sAsxBLXn5eqpQ4LzfIJAGQ0ozSPLhBsHi/xCgrJczLyMD
  AIMRTkFqUm1mCKv+KUZyDUUmY14UJaApPZl4J3L5XQKcwAZ1ix6cPckpJIkJKqoGJRTI4ub/A
  9sHxV4c35mdusBVPj+9StXs1b7q8S+IhTovS5TG7WL48437fe/CUZFZOwPmOHJFjmUs1VRc++
  aExTas8dH2qatPJ8zJBJcu9/py6En0t6brRdLPNDjZ8KYwSedEmXaa3+zfN/bLcNWDd3C5rxw
  Dfi/05Bw8tLqpKFd4UMO+P75pfr+smeze4zY96w3OrL0WVLdqx0OXekRPnDUXDQwTmTTs2++m
  3NTlqDz5sl/i4/+39pAq+u14dLbc1J92YnR75stT0/MmpHYyF0+cacdl5/LvKxl2/9pHYZN3t
  Gx8d5swTWWy6++aHuUf2vFVjMXghIsSu/DQ9XphtDZvbs7qrbvLnCm9s3X9GiaU4I9FQi7moO
  BEAySKxenIDAAA=
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-18.tower-655.messagelabs.com!1664222068!425426!1
X-Originating-IP: [104.232.228.23]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14279 invoked from network); 26 Sep 2022 19:54:29 -0000
Received: from unknown (HELO va32lpfpp03.lenovo.com) (104.232.228.23)
  by server-18.tower-655.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Sep 2022 19:54:29 -0000
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by va32lpfpp03.lenovo.com (Postfix) with ESMTPS id 4MbtkX4xjqz4yxKm;
        Mon, 26 Sep 2022 19:54:28 +0000 (UTC)
Received: from p1g3.. (unknown [10.45.6.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4MbtkX2jXXzbvDd;
        Mon, 26 Sep 2022 19:54:28 +0000 (UTC)
From:   Dan Vacura <w36195@motorola.com>
To:     linux-usb@vger.kernel.org
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Dan Vacura <w36195@motorola.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] uvc gadget sg performance issues
Date:   Mon, 26 Sep 2022 14:53:06 -0500
Message-Id: <20220926195307.110121-1-w36195@motorola.com>
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


Appreciate any thoughts or feedback related to these issues.


Dan Vacura (1):
  usb: gadget: uvc: fix sg handling in error case

 drivers/usb/gadget/function/uvc_queue.c |  8 +++++---
 drivers/usb/gadget/function/uvc_queue.h |  2 +-
 drivers/usb/gadget/function/uvc_video.c | 18 ++++++++++++++----
 3 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.20.4

