Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E773F087
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 03:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjF0B3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 21:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjF0B3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:29:39 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9555E52
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 18:29:37 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230627012933epoutp046750c031942762397c7b6aedccd2c78a~sX995dZcx1024810248epoutp04w
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:29:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230627012933epoutp046750c031942762397c7b6aedccd2c78a~sX995dZcx1024810248epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687829373;
        bh=b3Fxvw2RdgOBtY36dPh2SiCe80DAP1YXQXrnXO0PHq8=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=FD3lBD1Aa7RP2eS4/hFsvBqPf/8B123yLPoC43CoDmCInVEH/qmhsIJ3XJGISmXCD
         iVm9yi8LSh3EgsjN267PnzjNpXpwUUcTB7HlWptYcq7wzfO6KFPkk6gMWLpLv11Ebo
         taeIc7wOu/6JhtP7mMKemKJRG57RdJX96Bl9blZ4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230627012933epcas2p27e02cfb103c73e2ae7afeacf9cb70f15~sX99We_X52977129771epcas2p2v;
        Tue, 27 Jun 2023 01:29:33 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QqnF82fYBz4x9Q0; Tue, 27 Jun
        2023 01:29:32 +0000 (GMT)
X-AuditID: b6c32a47-c2bfa70000007f5e-4a-649a3b7c086e
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.36.32606.C7B3A946; Tue, 27 Jun 2023 10:29:32 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: Remove unused function declaration
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "Arthur.Simchaev@wdc.com" <Arthur.Simchaev@wdc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230627012931epcms2p76f458e0b2ce8a591b56bbcc6a2f1a3bb@epcms2p7>
Date:   Tue, 27 Jun 2023 10:29:31 +0900
X-CMS-MailID: 20230627012931epcms2p76f458e0b2ce8a591b56bbcc6a2f1a3bb
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmmW6N9awUg89NfBYP5m1js+icuIzV
        4uXPq2wWBx92slhM+/CT2eLlIU2LR7efMVosurGNyWLv663sFpd3zWGz6L6+g83iwIdVjBbL
        j/9jsljYMZfFYtK1DWwWU18cZ7dYuvUmo4Ogx+Ur3h6bVnWyedy5tofNY8KiA4weLSf3s3h8
        X9/B5vHx6S0Wj4l76jz6tqxi9Pi8Sc6j/UA3UwB3VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxz
        vKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBPSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJb
        pdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjAtTHAsaOCo6d5s0MP5n62Lk5JAQMJGY
        +uMhI4gtJLCDUeLGoeguRg4OXgFBib87hEHCwgJ2EtO2/GeBKFGS6Fq4lRkibiCxbvoeMJtN
        QE9iyu87QGO4OEQEZrJJdN64AzWfV2JG+1MWCFtaYvvyrYwQtobEj2W9zBC2qMTN1W/ZYez3
        x+ZD1YhItN47C1UjKPHg526ouKRE65mtUPPrJVrfn2IHWSwhMIFRovHYH6hB+hLXOjaCLeYV
        8JV41NvABGKzCKhKrHs4jxWixkXi8suDYDazgLzE9rdzmEGeZxbQlFi/Sx/ElBBQljhyiwWi
        gk+i4/Bfdpi3Gjb+xsreMe8JE4StJvFowRaoTTISF+ecg3rFQ+JXSx/zBEbFWYiQnoXkhlkI
        NyxgZF7FKJZaUJybnlpsVGAMj9nk/NxNjOC0reW+g3HG2w96hxiZOBgPMUpwMCuJ8Ir9mJ4i
        xJuSWFmVWpQfX1Sak1p8iNEU6PuJzFKiyfnAzJFXEm9oYmlgYmZmaG5kamCuJM677GFvipBA
        emJJanZqakFqEUwfEwenVAPTiu8dju8+qbRFV8eE3nDjOhzuzFt6fY+O6Nqq6vo1tQtdrY4q
        G/ZqGr3PXREZ7Na/o8V2hvi+ZbNWqDran6u0SptxctGmzf9k5n7ZJvCn/pfhevMpB9qTnvRM
        MvzK/uhr7tIagXOHDvvyvb4wNfvqLb/l+0xn+le01zBsmTnJVP4vo9MP7ri30W1fnJe9Z7i2
        2v70vM+TVm/9uvkzx7V/523rsyIK11xY7WEqeM3CZBl/gcHz6XtuXl7O7HJ7psMLQfFr9tbH
        Fk7PXL/2+IrjXwod2nN8P5m55hlZTrv/Ub9tZvzRfZvsH11jKPXambRpmkaJnGvhOxWFXred
        Rk+cPsnbp6p9eLPOTDXw5QR7MSWW4oxEQy3mouJEAFluny9kBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230627012931epcms2p76f458e0b2ce8a591b56bbcc6a2f1a3bb
References: <CGME20230627012931epcms2p76f458e0b2ce8a591b56bbcc6a2f1a3bb@epcms2p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2468da61ea09 ("scsi: ufs: core: mcq: Configure operation and
runtime interface") added ufshcd_mcq_select_mcq_mode(), but
it's not used anywhere. So remove it.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/ufs/core/ufshcd-priv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 9566a95aeed9..0f3bd943b58b 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -68,7 +68,6 @@ int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
 int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
 void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds);
-void ufshcd_mcq_select_mcq_mode(struct ufs_hba *hba);
 u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i);
 void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
 struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
-- 
2.17.1

