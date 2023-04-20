Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4876E8DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjDTJVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjDTJVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:21:35 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F7C26A9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:21:33 -0700 (PDT)
X-ASG-Debug-ID: 1681982491-1eb14e63872da70001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id YZHkuArtaiHDPmvN (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 20 Apr 2023 17:21:31 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 20 Apr
 2023 17:21:30 +0800
Received: from L440.zhaoxin.com (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 20 Apr
 2023 17:21:30 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From:   Weitao Wang <WeitaoWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>
Subject: [PATCH 0/3] Fix some issues of xHCI for zhaoxin
Date:   Fri, 21 Apr 2023 01:21:27 +0800
X-ASG-Orig-Subj: [PATCH 0/3] Fix some issues of xHCI for zhaoxin
Message-ID: <20230420172130.375819-1-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1681982491
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 432
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.1337 1.0000 -1.1941
X-Barracuda-Spam-Score: 1.91
X-Barracuda-Spam-Status: No, SCORE=1.91 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107672
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
        3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some issues of xHCI for zhaoxin.

Weitao Wang (3):
  xhci: Add a quirk for zhaoxin xhci to fix issues.
  xhci: Add zhaoxin xHCI U1/U2 feature support
  xhci: Show zhaoxin xHCI root hub speed correctly

 drivers/usb/host/xhci-pci.c |  5 ++++
 drivers/usb/host/xhci.c     | 49 +++++++++++++++++++++++++++++++++++--
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 53 insertions(+), 2 deletions(-)

-- 
2.32.0

