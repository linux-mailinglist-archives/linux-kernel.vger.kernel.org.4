Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9326C6B7E40
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCMQ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjCMQ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:56:46 -0400
X-Greylist: delayed 342 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Mar 2023 09:56:29 PDT
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0286F622;
        Mon, 13 Mar 2023 09:56:28 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 7286821E1F;
        Mon, 13 Mar 2023 17:50:44 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-usb@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 0/3] usb: misc: usb3503: support usb3803 and bypass mode
Date:   Mon, 13 Mar 2023 17:50:36 +0100
Message-Id: <20230313165039.255579-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add support for USB3803 and bypass mode.

While the usb3503 variant uses a HSIC connection to upstream, the usb3803 uses
a regular USB connection and provides a bypass mode.

In bypass mode the downstream port 3 is connected to the upstream port with low
switch resistance R_on.

Controlling mode of operations:

| RESET_N | BYPASS_N | Mode    |
--------------------------------
|    0    |    0     | standby |
|    1    |    0     | bypass  |
|    1    |    1     | hub     |


Emanuele Ghidoli (3):
  dt-bindings: usb: smsc,usb3503: Add usb3803
  usb: misc: usb3503: refactor code to prepare for usb3803 addition
  usb: misc: usb3503: support usb3803 and bypass mode

 .../devicetree/bindings/usb/smsc,usb3503.yaml | 54 +++++++++++++++-
 drivers/usb/misc/usb3503.c                    | 64 +++++++++++--------
 include/linux/platform_data/usb3503.h         |  1 +
 3 files changed, 92 insertions(+), 27 deletions(-)

-- 
2.25.1

