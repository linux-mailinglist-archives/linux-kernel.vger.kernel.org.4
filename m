Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E19F6F67ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjEDJGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEDJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:06:19 -0400
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D552B8F;
        Thu,  4 May 2023 02:06:16 -0700 (PDT)
X-QQ-mid: bizesmtpipv601t1683191150t556
Received: from localhost ( [255.251.132.4])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 May 2023 17:05:48 +0800 (CST)
X-QQ-SSF: 0140000000000090C000000A0000000
X-QQ-FEAT: Il1yX1zTS2AaZvPkKIPsBCyi9J+kgPbMSU9zxIwHbRESjPeDW66BEmAxvuIw/
        g9FNdAbWN7JLpZebEqTnhavGofkzOh1pAQwEi+qC5ZMtmqJto58tkXjRPAkbMarL9v6xcLR
        GsdYenz1+mGguE1pwLFPjs1JiU7QN2ntChWUlRpEvp5nlKrPVj2/1UbzhfayhsTFTkdq6Wm
        TQP4sCFm5c09TgvmE4zXRSeRpanoz5BrDBwxXH3dYnb9PiySrvRwadTzU8jVzmoqr6Zb5qR
        mmg2QjWqQh3ftugT3dFxJZCSiZxdtZomgK5MwcpvfdXFiM0lQurQ0fCGqdlD/fl40WDNvVX
        nn/djQwR9gS1fgSFe5cCgWPfX7AlOWv/dj79A54YGILeT/9IVI=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9945072676502930506
Date:   Thu, 4 May 2023 17:05:51 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dc395x@twibble.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] strcuture: Correct spelling mistakes in comments
Message-ID: <262EBDA8BEEA7619+ZFN1b1D66/Lp8hzh@TP-P15V>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:ucas.com.cn:qybglogicsvrgz:qybglogicsvrgz5a-2
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] strcuture: Correct spelling mistakes in comments

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
---
 drivers/scsi/dc395x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index c8e86f8a631e..a3f00e6e3296 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -3641,7 +3641,7 @@ static void adapter_add_device(struct AdapterCtlBlk *acb,
  * adapter_remove_device - Removes the device instance from the adaptor
  * instance. The device instance is not check in any way or freed by this. 
  * The caller is expected to take care of that. This will simply remove the
- * device from the adapters data strcutures.
+ * device from the adapters data structures.
  *
  * @acb: The adapter device to be updated
  * @dcb: A device that has previously been added to the adapter.
@@ -3980,7 +3980,7 @@ static void trms1040_read_all(struct NvRamType *eeprom, unsigned long io_port)
  * Checks the checksum and if it's not correct it uses a set of default
  * values.
  *
- * @eeprom:	caller allocated strcuture to read the eeprom data into
+ * @eeprom:	caller allocated structure to read the eeprom data into
  * @io_port:	io port to read from
  **/
 static void check_eeprom(struct NvRamType *eeprom, unsigned long io_port)
@@ -4578,7 +4578,7 @@ static void banner_display(void)
  * dc395x_init_one - Initialise a single instance of the adapter.
  *
  * The PCI layer will call this once for each instance of the adapter
- * that it finds in the system. The pci_dev strcuture indicates which
+ * that it finds in the system. The pci_dev structure indicates which
  * instance we are being called from.
  * 
  * @dev: The PCI device to initialize.
-- 
2.34.1

