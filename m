Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4630D60CB39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiJYLrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiJYLqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:46:34 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3CC5E55B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:45:53 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221025114547epoutp034e9fb9e56df2ddc1e4253c465f4b0c8e~hTVEcB9Um0293202932epoutp030
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:45:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221025114547epoutp034e9fb9e56df2ddc1e4253c465f4b0c8e~hTVEcB9Um0293202932epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666698347;
        bh=JO8XgWZ+zDgtCY6iDyktTWd653/AUbfaIwJv6C47htY=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=qT1rE9MnYQVxDFmFpbpsIvUJirh5UCxDT/P2lyWilK34ZY9xB+YjQTmRMqTPmB3It
         EjDFkhMpF+ABnWE/P7wcS1kZAgl1juNEacbA0vU4TrYK0F7iLmMLUjyzUWcFkVwzus
         POKM3J+H81U3xYLv/3euJgZ/vCbQaIFQfsNvPxs8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20221025114547epcas2p2e501c1bcd8f1f296b8a6562d1be55194~hTVDvNNs52435924359epcas2p24;
        Tue, 25 Oct 2022 11:45:47 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MxVWG5gr4z4x9Q3; Tue, 25 Oct
        2022 11:45:46 +0000 (GMT)
X-AuditID: b6c32a47-ac5b870000002127-60-6357cc6abbd7
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.DF.08487.A6CC7536; Tue, 25 Oct 2022 20:45:46 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] dm table: fix typo in comment
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From:   Yonggil Song <yonggil.song@samsung.com>
To:     "agk@redhat.com" <agk@redhat.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20221025114545epcms2p6f0a8fe05ae674709ebc6ea2f348abe3c@epcms2p6>
Date:   Tue, 25 Oct 2022 20:45:45 +0900
X-CMS-MailID: 20221025114545epcms2p6f0a8fe05ae674709ebc6ea2f348abe3c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmuW7WmfBkg0czBS3WnzrGbLH33WxW
        i8u75rBZnLglbTH1/BEmB1aPTas62Tze77vK5tG3ZRWjx+dNcgEsUdk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBrlRTKEnNKgUIBicXFSvp2NkX5
        pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGc2bAgrusVf86ixoYNzM
        1sXIySEhYCJx5eUi9i5GLg4hgR2MErM+f2LpYuTg4BUQlPi7QxikRlhAT2Le25nMILaQgJLE
        tQO9LBBxfYnNi5exg9hsAroSfzcsB5sjInCAUWJ6/3pmiAW8EjPan7JA2NIS25dvZYSwNSR+
        LOuFqhGVuLn6LTuM/f7YfKgaEYnWe2ehagQlHvzcDRWXlFh06DwThJ0v8XfFdahnaiS2NrRB
        xfUlrnVsBNvLK+ArMevHE7BeFgFViT/7N0Pd4yKxqeE42HxmAXmJ7W/nMIP8ziygKbF+lz6I
        KSGgLHHkFgtEBZ9Ex+G/7DBf7Zj3BGqTmsTmTZtZIWwZiQuP26Cu9JBY8uAUEyTYAiUWP37L
        OoFRfhYicGch2TsLYe8CRuZVjGKpBcW56anFRgXG8NhMzs/dxAhOclruOxhnvP2gd4iRiYPx
        EKMEB7OSCC/Lk+BkId6UxMqq1KL8+KLSnNTiQ4ymQB9PZJYSTc4Hptm8knhDE0sDEzMzQ3Mj
        UwNzJXHerhlayUIC6YklqdmpqQWpRTB9TBycUg1M7mKeUqU7d/78fmrrwZWCf/t47jscOrmP
        tVzp9Lt7PjKn7y3S/Cyhs2GG/Qojpl1fghi3X2AS5Gw/OWOVyhfjvMB3mxk6lFNkjvn4rZN+
        8a/yfWd0TNX9/Q82Hr/4qbdNK/Dopg+zNQLWLcxXeLlm2kzVxdNXTr+lIJ65+Ov31OnpOx++
        C+5anak4c22ele0txTuy+nkXV19cyqt34s/J6C+8bvVtS0tfGOQ/XLvuitnXTJ9M/Q2MTlrf
        /7Ok9xxcwNK4WvPVAa2esjv1053yjbh1FzE63m+wqTz2ML+rvbvg/sXdN1aqZv4Unb7Qc8la
        Z+FjaQU9b4zEMp3XMOQxOB3eqRYnbSAbt+77x4KubCWW4oxEQy3mouJEAAl5CFj7AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221025114424epcms2p4e271ada9e2ce7a4992e908fc3a30167f
References: <CGME20221025114424epcms2p4e271ada9e2ce7a4992e908fc3a30167f@epcms2p6>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

integity -> integrity
in comment for dm_table_get_integrity_disk

Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
---
 drivers/md/dm-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index d8034ff0cb24..be0a9024923d 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1151,7 +1151,7 @@ static struct gendisk * dm_table_get_integrity_disk(struct dm_table *t)
  * underlying devices have an integrity profile.  But all devices may
  * not have matching profiles (checking all devices isn't reliable
  * during table load because this table may use other DM device(s) which
- * must be resumed before they will have an initialized integity
+ * must be resumed before they will have an initialized integrity
  * profile).  Consequently, stacked DM devices force a 2 stage integrity
  * profile validation: First pass during table load, final pass during
  * resume.
-- 
2.34.1
