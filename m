Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDA669F76D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjBVPM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjBVPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:12:57 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D69855B4;
        Wed, 22 Feb 2023 07:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677078775; x=1708614775;
  h=from:to:cc:subject:date:message-id;
  bh=U+R+87D0mpPpdtpNIWR/U9pn5DmB8jB15D/IW/KPSNc=;
  b=B0nwYNOOG7hvPdhdDtOATFZoE0SrotB4TYyo7tLC06fddts5/yrS313Z
   GgokBB+XtbCbhs4kVHvWzaOMNFAsFrgGGW1HKqglJRTWB7iLp/Qe+X1lN
   BPkaDNmHcg2fXdDNJqrAc824jAoLe+ELrFgJbCI1nIfqaqZHd0pQfqkI7
   n4iNU+2sOrOQc1/JxhD5qtJsDCj/xUqTRah77INK2DQk7OEJJBe0dykUT
   JKk09FVO8adLGYhpw8m29VaBZcDnzhwvxgZTy91FAg0dL3kNxk9w8U9Ye
   OGT41issWE3tROTeNsAu/HkAPZKZH6mpBrh06r36vijtGhUl/9Yy709r5
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,319,1669046400"; 
   d="scan'208";a="223701427"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2023 23:12:54 +0800
IronPort-SDR: /jloQfnfPfn/bYNDH4llbFO6O5NdpWjk3mPKl1U6JGruCRzLcPR7BRMG2RuaoOakGH/ARDBKHE
 HneZMl4NsJrphINop52cHofShHuZZqauaIy3wovK3fMqFVHeV7r52QKfoWiYObVkPTJZZMFyIH
 qrDyEh5eDqnZZ3hsJZGtiYfDzFjA2w7+UVLKU3HRoa6ufK5z6XUHOFPIgjnnoISWqw6rjvMdqv
 51QTezlupMhVeLl3yKZ1ZEFgb22J61iu36ItDpXUrmQfEwkGQ4psulichHFbGN5Wy8RZifX9Rz
 zQI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2023 06:24:08 -0800
IronPort-SDR: IZrUzWc1cnqw6KYMn7EZulLKzpj9mZC0sfOZBcq0Vyun/Pe+B4b7fdC9aA6LqcK+/JIIddXtjW
 C54xerxnxsfvhPned+rBzjINfnQXj6kwgEguFR/BEsEQz4vCTx9wThHP6Ct09JyRKe2a1ImqTU
 hpxVc41sRRwehVZDSIJzNXMwxKIE7jR4qcrufS5nejQOhJCAYB9kn+y4TUd3n5+Ht/PJtnSRPO
 zVacv8kmawYafKu4dbqhoXNgMbb8cjwvBAJ1KmHO6c50yT8MwwELcwN2zS5JvvPcOU48Uf2Brt
 0WA=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2023 07:12:53 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, bvanassche@acm.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH 0/2] ufs: core: Add support for qTimestamp attribute
Date:   Wed, 22 Feb 2023 17:12:48 +0200
Message-Id: <1677078770-30994-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new qTimestamp attribute was added to UFS 4.0 spec, in order to
synchronize timestamp between device logs and the host. Due to this
attribute, the attribute's max value was extended to 8 bytes. As a result,
we need to adjust the definition of struct utp_upiu_query.

Arthur Simchaev (2):
  include: uapi: scsi: Change utp_upiu_query struct
  ufs: core: Providing Timestamp information to the device

 drivers/ufs/core/ufs_bsg.c       |  2 +-
 drivers/ufs/core/ufshcd.c        | 62 +++++++++++++++++++++++++++++++---------
 include/uapi/scsi/scsi_bsg_ufs.h | 17 +++++------
 include/ufs/ufs.h                |  1 +
 4 files changed, 59 insertions(+), 23 deletions(-)

-- 
2.7.4

