Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD9617676
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiKCFzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiKCFya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:54:30 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434201A807
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:53:53 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221103055351epoutp028923fbd1dd18026d2fb27421f9bf26a2~j-VWj10rZ1644316443epoutp02J
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:53:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221103055351epoutp028923fbd1dd18026d2fb27421f9bf26a2~j-VWj10rZ1644316443epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667454831;
        bh=CRL1m9ZAg2bvQ2jrsxr/t17JLuW2dDtkmywMYXFsY5s=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=FwUOfTHG5ob0A/SLck+3E35svTp9G85jBhkxsW6ucV4+ETzKrqC+0IOyLo5CH+JaI
         zPyh2af322SIMg4khKCyptqLzyTTYGncPl15b56QJOO0KIpzGfb0p9Cz63lODyCBgO
         6CXnfMa8jY2znNJ1eWlozs2n+/OTsgE6D+xThm14=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20221103055350epcas2p353f530c2f9dca4b8e91f309c4479b1ea~j-VWE4ySb0577605776epcas2p3F;
        Thu,  3 Nov 2022 05:53:50 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4N2tH23MXyz4x9QJ; Thu,  3 Nov
        2022 05:53:50 +0000 (GMT)
X-AuditID: b6c32a45-643fb7000001f07d-2b-6363576e6638
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.FD.61565.E6753636; Thu,  3 Nov 2022 14:53:50 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: Remove check_upiu_size() from ufshcd.h
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>,
        "draviv@codeaurora.org" <draviv@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20221103055349epcms2p338f2550c2dd78d00231a83b24719a3d4@epcms2p3>
Date:   Thu, 03 Nov 2022 14:53:49 +0900
X-CMS-MailID: 20221103055349epcms2p338f2550c2dd78d00231a83b24719a3d4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmuW5eeHKywZdmCYuTT9awWbz8eZXN
        4uDDThaLaR9+Mlu8PKRp8ej2M0aLs2f6mSwu75rDZtF9fQebxfLj/5gslm69yWjxde9nNgce
        j8tXvD0u9/UyeSze85LJo+XkfhaP7+s72Dw+Pr3F4vHtzEQWj74tqxg9Pm+S82g/0M0UwBWV
        bZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdLaSQlli
        TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj
        0aoe5oJJ7BUrPi1jbmBsYeti5OSQEDCRmLv/CHMXIxeHkMAORonVDw6ydDFycPAKCEr83SEM
        UiMs4CRxdMZ7sHohASWJroVbmSHiBhLrpu8Bs9kE9CSm/L7DCDJHRGAdi8SEpwcYIRbwSsxo
        f8oCYUtLbF++FSquIfFjWS8zhC0qcXP1W3YY+/2x+VA1IhKt985C1QhKPPi5GyouKdF6ZivU
        A/USre9PsYMslhCYwCjReOwP1CB9iWsdG8EW8wr4Smy8tASsmUVAVeL4hqlQB7lInDv5Aaye
        WUBeYvvbOcwgzzMLaEqs36UPYkoIKEscucUC80rDxt/s6GxmAT6JjsN/4eI75j1hgrDVJB4t
        2MIKYctIXJxzjhlipIfEv6/RExgVZyECehaSE2YhnLCAkXkVo1hqQXFuemqxUYEhPG6T83M3
        MYITsJbrDsbJbz/oHWJk4mA8xCjBwawkwlt/NjpZiDclsbIqtSg/vqg0J7X4EKMp0PMTmaVE
        k/OBOSCvJN7QxNLAxMzM0NzI1MBcSZy3a4ZWspBAemJJanZqakFqEUwfEwenVANT37KuJV5J
        c3QXtujUHZR+0xjxKeeFuswru4JH/yda/ynbEhm6+oRqknFEw84nc33L9ghbXhON+5Hl+vLD
        iwUJtirJCkZCL3st11z92yHCk3s68vemiAQ5L9/41uXbr+ceExEtnXrvSFvFqUWChfEcXk+0
        9Z5+kX+37cTny1tLdQrbilsPGBp8m58sdKXuZuihje4bKz2t+Cry//he/7jtyb37p05VtCo+
        CVS+skj11MubIU4ld9sPffB8KuR38tzzFx+Eq9u8Ao0r86ZXBT82M/8p4BZ45FpYj+l0sxtf
        Tlz6srt2dob2gld/rNWPlK012jUj+9V073lbSxM2FkzaEPl6gpf8z4ZVQgwfsv8dUWIpzkg0
        1GIuKk4EAPSwRZJJBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221103055349epcms2p338f2550c2dd78d00231a83b24719a3d4
References: <CGME20221103055349epcms2p338f2550c2dd78d00231a83b24719a3d4@epcms2p3>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 68078d5cc1a5 ("[SCSI] ufs: Set fDeviceInit flag to initiate
device initialization") added check_upiu_size(), but no caller.

Cc: Dolev Raviv <draviv@codeaurora.org>
Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 include/ufs/ufshcd.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 96538eb3a6c0..5cf81dff60aa 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1072,12 +1072,6 @@ void ufshcd_update_evt_hist(struct ufs_hba *hba, u32 id, u32 val);
 void ufshcd_hba_stop(struct ufs_hba *hba);
 void ufshcd_schedule_eh_work(struct ufs_hba *hba);
 
-static inline void check_upiu_size(void)
-{
-	BUILD_BUG_ON(ALIGNED_UPIU_SIZE <
-		GENERAL_UPIU_REQUEST_SIZE + QUERY_DESC_MAX_SIZE);
-}
-
 /**
  * ufshcd_set_variant - set variant specific data to the hba
  * @hba: per adapter instance
-- 
2.17.1

