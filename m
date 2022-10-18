Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B1603539
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJRVv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJRVvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:51:24 -0400
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com [67.219.246.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C20CE98C;
        Tue, 18 Oct 2022 14:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1666129878; i=@motorola.com;
        bh=90tsAFWVuem2oALm0tqWe323WLTKI34VBqjTieqas1Y=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=IyC4eO5Qnu+O9o9JIPsc2Ou9yVFQ0P3sCnfMOLNKZV9HMrudkJ7KY9WUKjQGXkJXK
         3iTz0JoLYJnm3DTF4FD9izAD2NsOjEknsYevpjbvSsrC3Sxzbcg3qfYHtMnLCClGqY
         aVUxkja43aD7vUVR1dNdTAtiFtnqqOV2jOeq00Sh1x4VVnUargS3aUMFpjsd+5uCti
         tzDUQnu/Y3+tZfYbhn8Ma5QB76ilX4hfyg3iMAaUpGIXBBFhbsVRbePrWbm36olzsE
         atS2PMEuBhMTbhX28kLexLRukKv56EH8XPwSDwCa85CK1wPO+Ixf9bRecly8hchdDO
         1//XZXy1bmjWg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRWlGSWpSXmKPExsUyYU+Di+5Vef9
  kg9P/VS2OtT1ht3hyoJ3RonfZHjaL5sXr2Sw6Jy5ht1jYtoTF4vKuOWwWi5a1MltsabvCZPHj
  Tx+zxaoFB9gduD1md8xk9di0qpPNY//cNewei/sms3r0/zXw2LL/M6PH501yAexRrJl5SfkVC
  awZ++Z+Zy/Yplrxe8kbtgbG1bJdjFwcQgLTmCQOPTnICuGsY5K40nKfsYuRk4NNQE1iwetVzC
  C2iICsxOErv5lBipgFnjNLHP60DiwhLGAqMeXgIaYuRg4OFgFVibsvY0DCvAKWEp/+zQcrkRC
  Ql9h/8CwzRFxQ4uTMJywg5cwC6hLr5wmBhJmBSpq3zmaewMgzC0nVLISqWUiqFjAyr2I0K04t
  Kkst0jU010sqykzPKMlNzMzRS6zSTdQrLdZNTSwu0TXUSywv1kstLtYrrsxNzknRy0st2cQID
  PqUIqbGHYz7lv3RO8QoycGkJMo755tfshBfUn5KZUZicUZ8UWlOavEhRhkODiUJXk4p/2Qhwa
  LU9NSKtMwcYATCpCU4eJREeNNkgNK8xQWJucWZ6RCpU4zGHFNn/9vPzNG5v+sAsxBLXn5eqpQ
  4L7csUKkASGlGaR7cIFhiuMQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmPcAyEKezLwSuH2v
  gE5hAjrFdIsfyCkliQgpqQamldMjNbMvLvt6RnDRU/9v75a9VrGa+kvA8jH7qV/XpA1er00Uz
  oj6/e7YszabT18NpSVM8yTv8uQ1yXJ3sQZ179jxdOGZl7/nBzpUnA6JWCCln6X7Y1bFv7f7dT
  0Pnf1+kV9r2inGuwrrpvYcVOqZ4NR5ftLiU2Iv37rf2cBh/VDz2dLyvJ6sD5vNutZujp84fZH
  4b4/eyEevTty9+0zgRN5PUcuP1YcPLbm5+9+EY2n8jXvvTlpa2/bpynSJxOemZ38+mj5fwfOx
  y3Hm1cU3t25kv88/obR9HUfmxNA/izqVFNcEWa9a+k2jZs3uYLa11Q2Prqh9eveSabHblIaIq
  N93i2vuLBTe8N4snr9kzdkOJZbijERDLeai4kQAt+qfAIcDAAA=
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-16.tower-686.messagelabs.com!1666129877!52044!1
X-Originating-IP: [144.188.128.68]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20347 invoked from network); 18 Oct 2022 21:51:17 -0000
Received: from unknown (HELO ilclpfpp02.lenovo.com) (144.188.128.68)
  by server-16.tower-686.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Oct 2022 21:51:17 -0000
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by ilclpfpp02.lenovo.com (Postfix) with ESMTPS id 4MsSH90sJlzfBb2;
        Tue, 18 Oct 2022 21:51:17 +0000 (UTC)
Received: from p1g3.mot.com (unknown [100.64.172.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4MsSH857b0zf6WS;
        Tue, 18 Oct 2022 21:51:16 +0000 (UTC)
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
        Paul Elder <paul.elder@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 0/6] uvc gadget performance issues
Date:   Tue, 18 Oct 2022 16:50:36 -0500
Message-Id: <20221018215044.765044-1-w36195@motorola.com>
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

V4 series updated with comments to ("usb: gadget: uvc: add configfs
option for sg support") and extra stable cherry-picks dropped in ("usb:
gadget: uvc: fix dropped frame after missed isoc") since a request was
made to stable separately for those.

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
 Documentation/usb/gadget-testing.rst          |  6 +++
 drivers/usb/dwc3/core.h                       |  1 +
 drivers/usb/dwc3/gadget.c                     | 38 +++++++++++++------
 drivers/usb/gadget/function/f_uvc.c           |  4 ++
 drivers/usb/gadget/function/u_uvc.h           |  2 +
 drivers/usb/gadget/function/uvc.h             |  2 +
 drivers/usb/gadget/function/uvc_configfs.c    |  4 ++
 drivers/usb/gadget/function/uvc_queue.c       | 18 +++++++--
 drivers/usb/gadget/function/uvc_video.c       | 28 ++++++++++----
 10 files changed, 81 insertions(+), 24 deletions(-)

-- 
2.34.1

