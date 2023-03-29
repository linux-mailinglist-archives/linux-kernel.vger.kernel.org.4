Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556C56CD771
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjC2KNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjC2KNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:13:34 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A641744B4;
        Wed, 29 Mar 2023 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680084811; x=1711620811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kGKBpWrJhjeqZ63N4uCwPTScH6jQMbn2NzXtEV+NfP8=;
  b=DwsaSuHKltnIav94Vn4E6qWFUoxL2SDnDEWhR7pB6trhiHYIZNlyXgb5
   xDM4eiB6Pmpls/dGgYVOYgSJMkFEDknCVckvYwYX60XRa+TLgWbrPBxWF
   ljGgMB0WPwO5W3IaL8N3sR4OjFsAqpAXCB1d3BMODYRLQeYFpFMi2z9H8
   2SGop5wN8Wans0eb2F9Ru2I/BGqwN6Uz4ZWbYSH915VT1x7gqR6l6mdD0
   JL8DyJ8VXGx/mFb/QXOpkeymkM/xxjlCdvtHu8mp5YgKmgm1NUm2YKXZa
   hGWBOirutW1uL71SiAqIAP2SdKKVgx4iXCZCUWOdsrc468+r4OOYm70Ih
   g==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="226776296"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 18:13:30 +0800
IronPort-SDR: 3T+4hWPSPkuqPvS2UeoKyCxB6Ox6JwaG+UZM3CAZBqNvUo3XAeUpkTF9ZTQxd/fKgT9o+ysKbL
 58hWFqDN4QSfhv+q62AWjQikSCmbDDAOqr9dKmaKPFb7RyaSXd6Znok+I8n4Y0Np1hJRzjvVBw
 Vgb2QxkhTmmV+FzOpMF337wiotQS7rMq/5wN+3PjHaXSsQhg5VpGK4TD44sREJKPEFnd8TlSCf
 r/ZAbrnb8ngIAPrseMypG9tfoHkDO8NAqmpODDh3AmXT/MeJJ9GCMA0XAQViCx8DtFjxf3dUvo
 ZME=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 02:23:59 -0700
IronPort-SDR: 7lG0IkkMSiOKzMj0/l53NUa/dICUmVgT25vJt9j0j+9iU817Mq1VZt8sek9vNUm/Q2b0nmpju+
 ZsA/ZCS7+Uq5EDv5jzO0fBrhwRAn73OXUHJMzgqGwIWDK5kJwrwXOtEgmKLklx3abcRTW6lh1Y
 f+14dhL5bO+CD2rhIUg40LdAd3q175I0c6Vt9jths9xJUdsSkik8zM2r5mikxUBagE1VisT9XQ
 Tznqu3h4R8MaILYDNgiafL7xm19ImsptkSymQoxLqio9QgPKtu+G2sKu3a3RhVAlyI4nfPjdRt
 8tI=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.30.255])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Mar 2023 03:13:29 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 1/2] scsi: ufs: mcq: Annotate ufshcd_inc_sq_tail appropriately
Date:   Wed, 29 Mar 2023 13:13:02 +0300
Message-Id: <20230329101303.18377-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230329101303.18377-1-avri.altman@wdc.com>
References: <20230329101303.18377-1-avri.altman@wdc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow Sparse and such to know that the hwq lock should be held here.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd-priv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 529f8507a5e4..d53b93c21a0c 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -364,6 +364,7 @@ static inline bool ufs_is_valid_unit_desc_lun(struct ufs_dev_info *dev_info, u8
 }
 
 static inline void ufshcd_inc_sq_tail(struct ufs_hw_queue *q)
+	__must_hold(&q->sq_lock)
 {
 	u32 mask = q->max_entries - 1;
 	u32 val;
-- 
2.17.1

