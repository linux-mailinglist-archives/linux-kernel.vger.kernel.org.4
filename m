Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A646F6558EF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 08:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiLXH01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 02:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXH0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 02:26:25 -0500
X-Greylist: delayed 4992 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Dec 2022 23:26:20 PST
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECFBBC20
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 23:26:19 -0800 (PST)
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
        by mx0b-00364e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BO30G2E010240
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 01:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=pps01; bh=7sq646Bo20ldC1GjyiPg73tttyJRs634Hlo3u8eciCw=;
 b=F7CR2LUXoUhL3Vn8gfR5MMSxPE20FQhj+2u6S7tRduA4mLiPvUIzkBDNFBfCVysA01K7
 zqMji+tZb/ZRi/MJUQ5RZpWmcG0Iv3wLiVDZ5m5xxQBIqXO+XZy5Fga0WF6eJm0LJmvt
 2666cqt03DL1o3ZgzJ0M9Q6J58m9K6Rt/DTOsBiUq7uedfT9We4vT7LyA1ivUWyS3tjw
 EZreQc8uHHYSjUqGYyXbIy5zStNvMSwRHUPR3uRAKFU9VkfhM7pvr0Z+g2ykm5HoeqRA
 QM4VI/OxxXM/VZOW2wsXVuJ7F7QR2oVE50ag7UGaoj7bBw5XCphpsCN11ztupztGVvAe AQ== 
Received: from sendprdmail21.cc.columbia.edu (sendprdmail21.cc.columbia.edu [128.59.72.23])
        by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 3mndtyw5ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 01:03:07 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by sendprdmail21.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 2BO637Gl125633
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 01:03:07 -0500
Received: by mail-qk1-f198.google.com with SMTP id o13-20020a05620a2a0d00b006cf9085682dso4472404qkp.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 22:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sq646Bo20ldC1GjyiPg73tttyJRs634Hlo3u8eciCw=;
        b=Zov+C3nExlB/5PWMP9xjypG65LSHLCIdyvrNbRNFFXqwL93rtqsica6Dois6BddJZP
         ZvTpwCtSj9fWvtFLTzRcCKrgQ9fv5nqHkH/fhXms+AhFpikaZjDRzIEX/8ZiMrwxI/2x
         5XZhe4ViTZtUkx5LxHpImRvwUpPSlpt2qsJHVVUvDDt5EfKFbH8bXU/8v9ooAUOPIgqJ
         VVYEL00dGC+USGqlrFRx3Nesk3S814RsL9E/mY28pAvQIsC9otyNq6VCiQAnWGt6vDC6
         jxvRMPkGscJUb+gEyxdFNbXOKMjCemdgVLx+svL5MYeloAk5s2B9T2XtPv1NxrE+hQ1+
         FIng==
X-Gm-Message-State: AFqh2kr+zhCdpNKswqrYgMXL1QfOzqOrXQpMg6ZF5U+8+UdBP1cL47Q1
        Ozk5qo25QcZ0jXLHxW8ysJphxuDTKXmDRT5u5/l/fhvxxqaPkxielvxzd/4EPK2l02QfrNPwAaD
        Y9VINF8UUVH75mvx/7Yb8EdkEBX8PtRKz
X-Received: by 2002:a05:622a:988:b0:3a8:1fde:8ec1 with SMTP id bw8-20020a05622a098800b003a81fde8ec1mr4447649qtb.6.1671861786026;
        Fri, 23 Dec 2022 22:03:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvM44+k/D0H4AIVmpte8FKGY9alsbLHYh1OArWlLuCLcPLHQt7GLHLX9z/t6IPNEGHyfrv7+A==
X-Received: by 2002:a05:622a:988:b0:3a8:1fde:8ec1 with SMTP id bw8-20020a05622a098800b003a81fde8ec1mr4447638qtb.6.1671861785831;
        Fri, 23 Dec 2022 22:03:05 -0800 (PST)
Received: from rivalak.cs.columbia.edu (dhcp103.cs.columbia.edu. [128.59.19.33])
        by smtp.gmail.com with ESMTPSA id w13-20020ac8718d000000b003a7f9b48e35sm3034253qto.29.2022.12.23.22.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 22:03:05 -0800 (PST)
From:   Kele Huang <kele.huang@columbia.edu>
To:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        david@redhat.com, Liam.Howlett@Oracle.com, hughd@google.com,
        peterx@redhat.com, yuzhao@google.com, ccross@google.com,
        arnd@arndb.de, pasha.tatashin@soleen.com
Cc:     linux-kernel@vger.kernel.org, Kele Huang <kele.huang@columbia.edu>
Subject: [PATCH] mm: fix comment of page table counter
Date:   Sat, 24 Dec 2022 01:02:33 -0500
Message-Id: <20221224060233.417827-1-kele.huang@columbia.edu>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1W9N2F0P_oawEFQ_urPXqnwBkiBBQBjw
X-Proofpoint-ORIG-GUID: 1W9N2F0P_oawEFQ_urPXqnwBkiBBQBjw
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_08,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1011 adultscore=0 lowpriorityscore=10 spamscore=0
 mlxlogscore=903 bulkscore=10 malwarescore=0 priorityscore=1501
 impostorscore=10 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212240044
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit af5b0f6a09e42 ("mm: consolidate page table accounting")
consolidates page table accounting to a single counter
in struct mm_struct {} as mm->pgtables_bytes. So the meanning of
this counter should be the size of all page tables now.

Signed-off-by: Kele Huang <kele.huang@columbia.edu>
---
 include/linux/mm_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3b8475007734..1c06c3cb6530 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -647,7 +647,7 @@ struct mm_struct {
 		atomic_t mm_count;
 
 #ifdef CONFIG_MMU
-		atomic_long_t pgtables_bytes;	/* PTE page table pages */
+		atomic_long_t pgtables_bytes;	/* size of all page tables */
 #endif
 		int map_count;			/* number of VMAs */
 
-- 
2.38.1

