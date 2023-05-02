Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6516F42D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjEBLcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjEBLcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:32:07 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4605B96
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:31:43 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230502113118epoutp01658df92c7d71d7f7f4767ffbafe442b2~bUDXeFlXc1163111631epoutp01H
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 11:31:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230502113118epoutp01658df92c7d71d7f7f4767ffbafe442b2~bUDXeFlXc1163111631epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683027078;
        bh=xmiMWORcrOAQxNE1CAsFrz5Kae9r4tZ/FFzkcGFfdC0=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=Lus+BKz2FMRCNma36805QyV7fTskm4DQfG6SWoXiJ5qY09kLcbd8jDENB0zK8DKEx
         bTYMHpxjTNUQ22ojXNL3nfNiEAwpTCxC4psVMhJHKWP2DDwg1abHTb40DMBBDUNq+K
         MtCZbbjna42OOtiJKPy1iL05/HfqK8UxeilQ1z68=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230502113117epcas2p1e97a512ba73df6dd2165af28259e1979~bUDXD4WrM0355803558epcas2p1D;
        Tue,  2 May 2023 11:31:17 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q9dFJ6Gjgz4x9Pp; Tue,  2 May
        2023 11:31:16 +0000 (GMT)
X-AuditID: b6c32a46-8b7ff7000001438d-69-6450f484f687
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.5E.17293.484F0546; Tue,  2 May 2023 20:31:16 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: core: Use readable 'return 0' in
 ufshcd_hba_capabilities()
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230502113116epcms2p7b83da0d683e29f667c38f5430b985388@epcms2p7>
Date:   Tue, 02 May 2023 20:31:16 +0900
X-CMS-MailID: 20230502113116epcms2p7b83da0d683e29f667c38f5430b985388
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmqW7Ll4AUg6WTDS0ezNvGZvHy51U2
        i4MPO1kspn34yWzx8pCmxaPbzxgtFt3YxmRxedccNovu6zvYLA58WMVosfz4PyaLhR1zWSyW
        br3J6MDrcfmKt8emVZ1sHhMWHWD0aDm5n8Xj+/oONo+PT2+xeEzcU+fRt2UVo8fnTXIe7Qe6
        mQK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BO
        V1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkC
        FSZkZxzpO85U0M5VsfR7L2MD42KOLkZODgkBE4mVy5exdDFycQgJ7GCU+NDRxd7FyMHBKyAo
        8XeHMEiNsECExN4pP5hBbCEBJYmuhVuZIeIGEuum7wGz2QT0JKb8vsMIMkdEYCOLxL8bB1kh
        FvBKzGh/ygJhS0tsX76VEcLWkPixrJcZwhaVuLn6LTuM/f7YfKgaEYnWe2ehagQlHvzcDRWX
        lGg9s5UNwq6XaH1/ih1ksYTABEaJxmN/oAbpS1zr2Ai2mFfAV2LBzZlgNouAqsTGfXugBrlI
        XPq0AyzOLCAvsf3tHGaQ55kFNCXW79IHMSUElCWO3IKq4JPoOPyXHeatho2/sbJ3zHvCBGGr
        STxasAUaDDISF+ecY4YY6SHRuNVpAqPiLERAz0JywiyEExYwMq9iFEstKM5NTy02KjCCx21y
        fu4mRnAi1nLbwTjl7Qe9Q4xMHIyHGCU4mJVEeD8U+qUI8aYkVlalFuXHF5XmpBYfYjQFen4i
        s5Rocj4wF+SVxBuaWBqYmJkZmhuZGpgrifNK255MFhJITyxJzU5NLUgtgulj4uCUamASfNw8
        27YnONyeebts35Tt+zm9/jx4J/1g/1w7j5C2KL7riW/2OS4JXf13TuW7R87MzzR+C2Yk377D
        vI/H88Cm+MyHNerqeqbfN5YHdyxZVdN+RPqklNiNr3fEIyLERf5tO9199a2G4LvqGO4b/A91
        AxXD/+kVurTOF1Q+dDOZY6/I1R8CThsfett+aMvUXsZW5Za8r9bo0YVZNQdZ5lY8PXUxtvS9
        3dL/RhcdXdyuvilm2+3GsTZ8+76kR2EXMm11bjBrKbvJTftUfJV920qvl6/npXo6PRMUq2ir
        S0ve4fPmv0iAZMpMc749Vr0Pj60/6MsuEib6cD1r4NMTtwK92RlMzW5fcNT9JmBuLK3EUpyR
        aKjFXFScCACdAcKtTQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230502113116epcms2p7b83da0d683e29f667c38f5430b985388
References: <CGME20230502113116epcms2p7b83da0d683e29f667c38f5430b985388@epcms2p7>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'err' variable is the result of ufshcd_hba_init_crypto_capabilities()
regardless of MCQ capabilities. Return 'err' immediately when the function
error occurs. And if it is not an error, explicitly return 0.

Anyway, if ufshcd_hba_init_crypto_capabilities() returns error, MCQ
capabilities is not used because it fails to initialize UFS driver.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9434328ba323..44328eb4158d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2343,18 +2343,20 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
 
 	/* Read crypto capabilities */
 	err = ufshcd_hba_init_crypto_capabilities(hba);
-	if (err)
+	if (err) {
 		dev_err(hba->dev, "crypto setup failed\n");
+		return err;
+	}
 
 	hba->mcq_sup = FIELD_GET(MASK_MCQ_SUPPORT, hba->capabilities);
 	if (!hba->mcq_sup)
-		return err;
+		return 0;
 
 	hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);
 	hba->ext_iid_sup = FIELD_GET(MASK_EXT_IID_SUPPORT,
 				     hba->mcq_capabilities);
 
-	return err;
+	return 0;
 }
 
 /**
-- 
2.17.1

