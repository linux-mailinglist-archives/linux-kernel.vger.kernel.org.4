Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFA76EE3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjDYOK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjDYOKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:10:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBC61A4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:41 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDhpHA001846;
        Tue, 25 Apr 2023 14:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0I/GuI5QEyZWq7urrTdN0//wqkgqXn6YNERYZgyoi84=;
 b=iLyayOwRgaqS6VULgSi32LrL6A1Mi8rl6huCf3y7GWxqOLIrw5ZC5J7qEH/URZ3lTFnM
 N2y/kN7LreERaikuNH4Z0pCRXVyndz0oHcTOkRMOuuxUiqk55/tpgD+vuBeLlMTZOL9J
 ZseDr6sqXsu0NqfF27X6Og9znvm9SJjPT/6eJWAWbd6zKjkq9gPb3dLGyBbX0mMUAIPe
 E0etNIk94NnAE5J13cGdagPVd65rFuZxSpBxcJQotTyQfbg+0yOqhlbb/7Zfp/C5rvvC
 Dhu9HlS9Bn3U3W58L5SNE3SLRw5doMyzyT95Ip5qw2wzf7I13e2vUEw1WXw/YoQKzCk6 4w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47mcwfbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PCfTaL007440;
        Tue, 25 Apr 2023 14:10:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616gcxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMXnJBzPnofTcYXqWSlHwybKNEiw6I2O1qcUGfXmrXL3up48zAaDpk2eoRKUdUiVE4pSsgNR8QUfZjCspxofQ68Me+FmEGsqcMFjr4tZzjzx5MW823vGkBDKpyGahO6ecJa//4nUHWFqYILb2qoOe1/lrVDePOOwykJgRL1TyruCxxTB8UH7udhUA3WQkxbikeK7cuJY7EYie1b7ePZgQiBJ7B8NMm/IvgOfeZjbldNNlCxVRV2zeGseCUZRncW5XeWRYx69Hl/F1n1jgo3WQ4KicX75bm+w1ul/v/TvStxL7tBhCfSxD1EL695kXvwKG6Fyt3IYoMMYrJ9nfuvvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0I/GuI5QEyZWq7urrTdN0//wqkgqXn6YNERYZgyoi84=;
 b=b19jTnzELAqQLnkwXB9aVBVeR+RkoQPKo0aLN9PjUI6p9BK8IUxdl8bpeg+2Ik2tV5SB9bMCz8iF0YU0Mtket5WnbG7PZf6/DqunFrzhU0AC7C8Nh5hP1KvSiazzym/SmBIBgrJ1hsgWmsqHKgKEv5a7twZhe7ic1B48ODThdr8ikQvKzOcV4EGkP7H9zhjRR1sOZDGqXP3is+5xAfbdV5ME1vD4oQ1dsIKF21ATnfOUMC+TWmzSlDKPSfDwZ1Ud7Fu+mYRVQbiBplpyXYAxsTG9URItwGth12xt8D8yXe8inVLOefy1H7gPujE/Djqc1dC73d3Ls/89DhNReikvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0I/GuI5QEyZWq7urrTdN0//wqkgqXn6YNERYZgyoi84=;
 b=KA7ddovESqbI9ZuXrtfo1TdXU+A4tTLFAgnH5Zi9KIPpyJ4Eqp95kyWa591+CFgNisoX571ZFtryhW+g0vS0552C8bje0BZTNpspBPgY+jiT8CpcutyQwfWocQOR3VnGxxqNMv2HOQgOL/E7uZwzVUvGi3itIgyN2G8eZj/bPuk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:10:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:33 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 06/34] maple_tree: Add debug BUG_ON and WARN_ON variants
Date:   Tue, 25 Apr 2023 10:09:27 -0400
Message-Id: <20230425140955.3834476-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0087.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf0ac81-85cd-4a43-e343-08db4596d5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xg7OOZqQowH7pqFKAVgIKs7LNJmas3GB35pehmUQvcdlRbXzYG/GhMcP1iwK/8vzBUuw6syZTlHtJ4XRNp91UgRkGQQ349uN3lfIji0QMvEOcZwHMw4lId10GYmyddIDNhr44tirI0xdIb8+F9kMvcgBUHfQQT62voEx5Va7xRvwRGFHzB6VMk/mIQAnIaaN86nXjcd3HjNiZfYPcWmjiVHxK/jYBM+6dvWeqGkJz9uFpAEGwRGGb+KQb14quUh5QFBbkoDe7/pFOPPgTiacrxRwB0jMBd3V73xar+1dY6QmHmvIEkCIB/bNOce3JviCqB48DDBiTptSlcVp39uOmSFofsgrFOm+XUf5lw1KJz2G4zEbsMLLo6BPkrT9xE6fCWthtPKf7+whfZQN+VabhoF/+TWlz5NroYu6ypMTASJ83bA4tt5XE1hj2kU33I2UMx1hL6ZoNyWqOzsGhjbi9HC9dk8JXYyfSJoSv0uVcvHunASoaNxcCSdZHYeALTk5klBkPNliRtrv6LdgI5AekV20wu5mqDEDgK4aUtk8qytgXkcuGSFZy/5fQXAqO6ou
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(2906002)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(5660300002)(8936002)(8676002)(41300700001)(36756003)(86362001)(186003)(26005)(6512007)(1076003)(107886003)(38100700002)(478600001)(6666004)(6486002)(83380400001)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oToTAqOtNx7Z/cUzwYfPBJxf5vCQ8v+proE5dYh8bZtPbHzok4lwcYlLYoj0?=
 =?us-ascii?Q?gmbd4CGSv+DqwzdEUjXOozOg6JOD/OS2pbhvaSWJ3HImDP/H9Z8mN5EjENk7?=
 =?us-ascii?Q?YqjwrTSUZmfG8qUzxmP3c7BCj01cO8Q0NRy4MFkZssERcmv9jRXHwft8bOTs?=
 =?us-ascii?Q?okcRQw/nfsKAS9uRMPSEVjG8AbxWvypViGCERWAmwIjnBckzBKzpgIzgVZJR?=
 =?us-ascii?Q?tXFj68ID/7tlusAD7TZuhVTU7G23TugWwspkxuO8w4UF4MVNT02MF/HRbzby?=
 =?us-ascii?Q?zFf9K/v9IzItDcxn1MigP192FepBPxOMDMaFLcsuIXLK8clu8iklHHBLSkqd?=
 =?us-ascii?Q?0G1VUJPjywBhq6Kj/PHCTF9QFcJvAgwkT/fx7s72Txf+WauKU+776t2QQpnp?=
 =?us-ascii?Q?7RoE3LTVIcwdZFPjI0Pl2VekViorwgSCOBCo7tmK5iRqYiCgqiq6U73UxFGI?=
 =?us-ascii?Q?tsZA28byVl/VVkDJM9/iZqTu3uwdgT5WoBwX2whaRani0TLLJJ0V8ABwVCux?=
 =?us-ascii?Q?bNlrUfCBoHcvT3/6sQEaqGZS7UadzGd9KYarXL1zeqmYo5D1IV+TCTE8Akt3?=
 =?us-ascii?Q?Kijv1p+C++sotjl0YNVrShq+ZvgheJJ049uRswFF4T5dO8d0YGIhsSj90t/s?=
 =?us-ascii?Q?UGJH++Ojx2YjpnjcVKgSwK3g4IuyCNMEuivUAE9NlD7UZevJUXFDRTCOR4Ju?=
 =?us-ascii?Q?vVkGiW2BE89MReL97tn9LQvbRUdsqJXTD3tGZKBFdwieUpVDHTV+iRoJgUHv?=
 =?us-ascii?Q?xJIPpH6J0n061MIbR5mHxyQZRFO0w/7mP/Yhyy8xe+nAkEI7IDqigSuNCwx4?=
 =?us-ascii?Q?Wz7sTR5FjrVFhUOENVbY/lDDxhjNP+ylhrr4fVkXDNrdj8mR/j3JrjCIFtGY?=
 =?us-ascii?Q?vGmt5oiY7HT/3nkazf376b1XyjESTpAkPM9OMekWRngYO7PBFJuqmjgo5pti?=
 =?us-ascii?Q?EmYWxbtNgCoPg0Q0iaZ4j2/2utT3zmL8tWj+gNY8L8R22bBw97p0Z7/I/r6Q?=
 =?us-ascii?Q?3t6wUNgAVcStDF6AcZ0x+nAMLMhtx+xtGYE3EjRrnqlBHA9AtEmVQBQn283q?=
 =?us-ascii?Q?gFJvWFuLGkSoIycXlPdr5v5VGbLyND6yD9waRGnHmcRpVG+z25hSzNnu/WXc?=
 =?us-ascii?Q?NIK5d3WaTNcUKkIwJhMvrMpViJy6LfWbeTJVs6hy49vxePKp+zpdq7IgglMO?=
 =?us-ascii?Q?XXOxMyxoqQSH+hQmnBMPaTH9JZB5nKu0hjfMiQ4m8RxnGccfBsstWLV+yfwX?=
 =?us-ascii?Q?kV7Qg1EsmRa+GPowuCr+irdemTpQHcx6Hs7r9kqtVvqwWJO6WwnqcOWiv+Ne?=
 =?us-ascii?Q?QibaLxRGrKLUxgcmLImQPyqdGB9WyJj9ozvXAW+RI9hWPJpZvZp5av3Vs/Cd?=
 =?us-ascii?Q?g569yr3FMYzhwPKLrCJ0+VnBRW7XmntjyEq+aTm+/ZcxvV7oGmVLLQNeVGtF?=
 =?us-ascii?Q?+BKp6evtGJCEmgd9OVT2tgZeb/OwudSk2E2hbOIYwmMYep7yJSyAhDKkEqQM?=
 =?us-ascii?Q?9Tk0eaQZ4AU5GjEv8c/arZ8sirtXO/fW1Mn+KEfC2SC0vrDVpFFyHDqUgISD?=
 =?us-ascii?Q?+wJH84uRwAby7RyNHz0a/Vh1IJGrdRD4ltB+HeSafWzOn8qDYgayg3LwiY+2?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XkXV2nY2olg/j2RlT6He+d072etFRgvtsOnLMX2PDnLNUVYg2t0nuShj6MoBSA0bv3h9sEuBg9JaH7FVUk5oNUQJ1X7SYknvv4IlsahRKlL5r+glmS7Er/d5WjtZGWy1bcETNANVTLL+NDzDIiQAtXgmHvdU9svUPb9SctKYv+GK7OG48hHfZMJ4Te9q2memJIFxqw0mPU2Po79ViMaX6eaBQLyLJdz0AZhTh+TFmdeHGgFIEULWuFKT0MO10obijyTd244W31IImGVBofiIbGO0xbCzQbXJLAegvLiRiEHJ8KQWJT2BoUHIqEkDy1Ow1+SGrp+yj+uIYnR/Wr4c2hcLaUCaDgKt4erhEaOT6D6+b+4U4hlLy7kRyop7lvFDJxrxm/p4wcpQMpvl3M3faPds6AKvwQKOn9Mz1TujMVW0qGFTVvkjvZmAZ7Ox0zNAvWsZF1Bel2TSu/u1iTTbJigINKhf+ECUJO+QiKn1fDOOMy0reLBvd5Geeko+q0lsf8UyEXKqXy2vCbfK68tKT3mMQXVMEfUOXyZvkL3Kzhryi14UXqcVRchrcIOQJmp3m0/sie81YHG/eGL3msctXJLlNMmNHe0JGyzV7ZAhuNFPFmi4pb5ncHCqB6mzNjRcnemDhp/MG3f3nIesKWGaPYh5BjfzkVIRNJNU96oqUB9QqE+VY3VuI5/6A3sHSMAQUihg2R883rPMGw9cjL6aKF1uwNASDlOsBnTggZ/yzC45HeOVbioYTiz1JxxBTGhi4YVhUaqZ+SJUnMOdQcnSOzL/LnxjoHb3VCKkFIR+4Dorf34fL0PIc6I86g6OAWZLh1MSYnEOfWlmfXT3dLVmSvsPJcRClwwreOBFdoY2V9uueO4pRxjgApBPkoywljrFl3S/EB6jUtEGFarDvByEyw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf0ac81-85cd-4a43-e343-08db4596d5cc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:33.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzIrNTi0dWFLv6FVqxqap7zExmmphW0gtvHOsvjsCUd4I6ufNF7PLvDNxXt/r1Z+oz+Fy7oK7okJ6msu6A0kTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-GUID: V9ALBE7ECjArrnrEYKvFk5M2NUIC2kRi
X-Proofpoint-ORIG-GUID: V9ALBE7ECjArrnrEYKvFk5M2NUIC2kRi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debug macros to dump the maple state and/or the tree for both
warning and bug_on calls.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 100 +++++++++++++++++++++++++++++++++++--
 lib/maple_tree.c           |  34 ++++++++++++-
 2 files changed, 129 insertions(+), 5 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 140fb271be4a4..204d7941a39ec 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -482,13 +482,13 @@ static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
 }
 
 /* Checks if a mas has not found anything */
-static inline bool mas_is_none(struct ma_state *mas)
+static inline bool mas_is_none(const struct ma_state *mas)
 {
 	return mas->node == MAS_NONE;
 }
 
 /* Checks if a mas has been paused */
-static inline bool mas_is_paused(struct ma_state *mas)
+static inline bool mas_is_paused(const struct ma_state *mas)
 {
 	return mas->node == MAS_PAUSE;
 }
@@ -679,6 +679,8 @@ extern atomic_t maple_tree_tests_run;
 extern atomic_t maple_tree_tests_passed;
 
 void mt_dump(const struct maple_tree *mt, enum mt_dump_format format);
+void mas_dump(const struct ma_state *mas);
+void mas_wr_dump(const struct ma_wr_state *wr_mas);
 void mt_validate(struct maple_tree *mt);
 void mt_cache_shrink(void);
 #define MT_BUG_ON(__tree, __x) do {					\
@@ -695,8 +697,100 @@ void mt_cache_shrink(void);
 		atomic_inc(&maple_tree_tests_passed);			\
 	}								\
 } while (0)
+
+#define MAS_BUG_ON(__mas, __x) do {					\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_dump(__mas);					\
+		mt_dump((__mas)->tree, mt_dump_hex);			\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+
+#define MAS_WR_BUG_ON(__wrmas, __x) do {				\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_wr_dump(__wrmas);					\
+		mas_dump((__wrmas)->mas);				\
+		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+
+#define MT_WARN_ON(__tree, __x)  ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mt_dump(__tree, mt_dump_hex);				\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
+
+#define MAS_WARN_ON(__mas, __x) ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_dump(__mas);					\
+		mt_dump((__mas)->tree, mt_dump_hex);			\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
+
+#define MAS_WR_WARN_ON(__wrmas, __x) ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_wr_dump(__wrmas);					\
+		mas_dump((__wrmas)->mas);				\
+		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
 #else
-#define MT_BUG_ON(__tree, __x) BUG_ON(__x)
+#define MT_BUG_ON(__tree, __x)		BUG_ON(__x)
+#define MAS_BUG_ON(__mas, __x)		BUG_ON(__x)
+#define MAS_WR_BUG_ON(__mas, __x)	BUG_ON(__x)
+#define MT_WARN_ON(__tree, __x)		WARN_ON(__x)
+#define MAS_WARN_ON(__mas, __x)		WARN_ON(__x)
+#define MAS_WR_WARN_ON(__mas, __x)	WARN_ON(__x)
 #endif /* CONFIG_DEBUG_MAPLE_TREE */
 
 #endif /*_LINUX_MAPLE_TREE_H */
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 535efc39f7758..a4c880192333e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -240,12 +240,12 @@ static inline void mas_set_err(struct ma_state *mas, long err)
 	mas->node = MA_ERROR(err);
 }
 
-static inline bool mas_is_ptr(struct ma_state *mas)
+static inline bool mas_is_ptr(const struct ma_state *mas)
 {
 	return mas->node == MAS_ROOT;
 }
 
-static inline bool mas_is_start(struct ma_state *mas)
+static inline bool mas_is_start(const struct ma_state *mas)
 {
 	return mas->node == MAS_START;
 }
@@ -7252,4 +7252,34 @@ void mt_validate(struct maple_tree *mt)
 }
 EXPORT_SYMBOL_GPL(mt_validate);
 
+void mas_dump(const struct ma_state *mas)
+{
+	pr_err("MAS: tree=%p enode=%p ", mas->tree, mas->node);
+	if (mas_is_none(mas))
+		pr_err("(MAS_NONE) ");
+	else if (mas_is_ptr(mas))
+		pr_err("(MAS_ROOT) ");
+	else if (mas_is_start(mas))
+		 pr_err("(MAS_START) ");
+	else if (mas_is_paused(mas))
+		pr_err("(MAS_PAUSED) ");
+
+	pr_err("[%u] index=%lx last=%lx\n", mas->offset, mas->index, mas->last);
+	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
+	       mas->min, mas->max, mas->alloc, mas->depth, mas->mas_flags);
+	if (mas->index > mas->last)
+		pr_err("Check index & last\n");
+}
+EXPORT_SYMBOL_GPL(mas_dump);
+
+void mas_wr_dump(const struct ma_wr_state *wr_mas)
+{
+	pr_err("WR_MAS: node=%p r_min=%lx r_max=%lx\n",
+	       wr_mas->node, wr_mas->r_min, wr_mas->r_max);
+	pr_err("        type=%u off_end=%u, node_end=%u, end_piv=%lx\n",
+	       wr_mas->type, wr_mas->offset_end, wr_mas->node_end,
+	       wr_mas->end_piv);
+}
+EXPORT_SYMBOL_GPL(mas_wr_dump);
+
 #endif /* CONFIG_DEBUG_MAPLE_TREE */
-- 
2.39.2

