Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA3F666433
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjAKT5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjAKT47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:56:59 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D69615B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:56:57 -0800 (PST)
Received: from dslb-188-096-145-172.188.096.pools.vodafone-ip.de ([188.96.145.172] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pFhDO-0005F2-Qo; Wed, 11 Jan 2023 20:56:50 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/20] staging: r8188eu: io cleanup
Date:   Wed, 11 Jan 2023 20:56:20 +0100
Message-Id: <20230111195640.306748-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up structs and function prototypes related to hardware access.

There's a number of definitions which are not used for usb devices such as
the r8188eu.

As usual, this is based on all the previous patches I sent. (I promise to
send no more patches until the pending ones are merged ;-)

Martin Kaiser (20):
  staging: r8188eu: remove struct io_priv
  staging: r8188eu: remove io function prototypes
  staging: r8188eu: remove ioreq function prototypes
  staging: r8188eu: remove async read function prototypes
  staging: r8188eu: remove async write function prototypes
  staging: r8188eu: remove struct io_queue
  staging: r8188eu: remove attrib function prototypes
  staging: r8188eu: remove rtw_write_scsi function prototype
  staging: r8188eu: remove dev_power_down function prototype
  staging: r8188eu: remove struct reg_protocol_rd
  staging: r8188eu: remove struct reg_protocol_wt
  staging: r8188eu: remove interface handler prototypes
  staging: r8188eu: remove readmem and writemem prototypes
  staging: r8188eu: remove IO defines
  staging: r8188eu: remove struct io_req
  staging: r8188eu: remove usb buffer macros
  staging: r8188eu: pass struct adapter to usb_read
  staging: r8188eu: pass struct adapter to usb_write
  staging: r8188eu: remove struct intf_hdl
  staging: r8188eu: remove struct intf_priv

 drivers/staging/r8188eu/hal/usb_ops_linux.c  |  34 +--
 drivers/staging/r8188eu/include/drv_types.h  |   1 -
 drivers/staging/r8188eu/include/osdep_intf.h |  32 ---
 drivers/staging/r8188eu/include/rtw_io.h     | 255 -------------------
 drivers/staging/r8188eu/os_dep/usb_intf.c    |   9 -
 5 files changed, 9 insertions(+), 322 deletions(-)

-- 
2.30.2

