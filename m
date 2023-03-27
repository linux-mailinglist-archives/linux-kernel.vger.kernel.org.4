Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB57B6C9C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjC0HoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjC0Hny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:43:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016543C2B;
        Mon, 27 Mar 2023 00:43:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7USIt011843;
        Mon, 27 Mar 2023 07:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=qFXVDiIPGL29fDlEkhrVi8b+mbqq8IgrnJcIxXciOA4=;
 b=Dj1AaXeRvOQgILs6XjwbjvqZAA6E7lQQlE55PClqVVtvgni2wGlNAkU4TjkdjQlPCJ7P
 zfggcIBXIBfKPFwOml/uyC1bZIbn9DwCwNl6kAfuzkKlmYipX3QgYCHvjp0+dIVCgH1j
 aj8V9/CFrGzuzHDzDonQY43Xl9thXdCCo5u9wVBw5Z4Mu/SuzZ2DzrGcRScWleOAdBBF
 AJPwr5aN1FPW2BnSTCIpAMhP3aqYikoiX2TQTFFTEoiLSR/k91YOaNlI03Y3rLvkHaxw
 ZlGGvQdLQlJWH0ua7G5K3zaIn+4+Iw7VR3TDKe7wc2+lcdUMkYNNyGfJmUT55HUWkUGX PA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk6t581p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R5W5gW032993;
        Mon, 27 Mar 2023 07:43:26 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdc4w2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lV+mSG0yTpqF4fKRr0eINWghALsIaH+I9sVkCwWKG4oPseaGrpaArV6pFvT2dEZ6uWU5J5Pbv6AO0trq6yy5YvsxiObPSNTAh+4Je5abvMI5Txt0U+2IzHDQrlbLbbuzDTdxezWBqMp+qMhoUXyA5WboedXoR1gacbPf2J/eEouiuPBS4PVCV94bbyp0es855M6Avd1m9yMUB4r8psHHVIb+mikaJKJxma7xZ4PMmWgtyyC4MWvPLZMJLl9WquTrEt7Jfi4v1pD5atYnJb30JqQpEFEX8l8edRCGsFqQ/0Vu632dpGwJBWcuPeChJDbraXADnOJhGmPwb2lp02TH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFXVDiIPGL29fDlEkhrVi8b+mbqq8IgrnJcIxXciOA4=;
 b=cl+2u42N6wxKEs/8o7RZJVGOYInZek6oOuVirYN/DyDo4xIi2Yc0GtV5XwSMI4wGXOZ/TTT02nsQGIcwDM4sGKmjFfJyhpmR+0oUiGmbfIfGrCUvpF6aHN4PzACx8eyYvAgU0i8XQ0FY0ryk9CotMgUVAejit8cwzvS2TFoRdmE4bpAZVdT48tIiQED2xklegGp2/i/ojBozgAtdIou1kFpVpBr0yv0GRhWqTzieQFEvcy7rQM2Vpc4c/draMZPeSBv10cU2LQzAxRoJXlwdmWs/f1nPhSCJKC4/tHXcsiljAis7mwODB1voA8DhbHQUkohtb7c+iYOlPlkIeltBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFXVDiIPGL29fDlEkhrVi8b+mbqq8IgrnJcIxXciOA4=;
 b=lu8kz4/4ZZJn6EE5f+fy3CmxqkoyXXrKRa2F7KkFK+FxEOo3xOq8PJOX6Kv5Ek4TIkSL/Zav1jNr+TTAauzIsMOs3QTXPmtWs6bHuqbgY/zYYDxQCdFYbuAOUE80sCtuMKVbtUWddSuHblz5sWtVtcYOlcuo0CoXEsHA8oV3pRA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:43:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 07:43:24 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 04/11] scsi: scsi_debug: Protect block_unblock_all_queues() with mutex
Date:   Mon, 27 Mar 2023 07:43:03 +0000
Message-Id: <20230327074310.1862889-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230327074310.1862889-1-john.g.garry@oracle.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:5:74::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f28132-57f2-4829-ba2b-08db2e96f211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zFkg/NLYST9h/X+sRQgLM9TSaysVPsinUv5LRCiEi8/fiqvE1IT3NO+jda2C095DXLO+35KsjU8mHAml8I9ZmVmPNA4fer0tVHN/aLjfigHkKFHS1UaKfOUD/iBoTVLrVwEXNT/0AF0+rw35WyOP8NoBUv7Pje3u8SyrDxPmZTKOhJXcqRd2MCNK91GTaq8N3a5rYWa+iqiuMMA1X2HeHPgwWqFlUx/zpX20Qx1JEg3oMPz0JQylsWMs+OLywm6qeL3uiIU9GVKnYIqphUwCBSwW9Tp2XMz/Tr3OCuNXRg/HG6JtJc/a86O5T6BZD9HdrUHJvDHkS+Bcb5xUUTj9RooAYBornZIf8OeP+8xfEWDK3RPJged6YKlXgXz7tqAiKoNC0PhHvKbyLwx03xMIi+YB1raqAZVzQXJqCgcPL4iS42qXfdKqbSb7/Hc+GcqRCPE5XCpfTPZuP1HgPEdY+Y5OIZChx+TfPGftvLSwOm0X6zJuaORtgkw6BlIfwS3apH8XUmtzouw8PSIAVCC8S3jj0DeU1wG5draMRZal2wunUaes4C9Od/GVBPdZxtP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(316002)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(103116003)(6512007)(38100700002)(2906002)(1076003)(8936002)(6506007)(5660300002)(83380400001)(26005)(6666004)(107886003)(2616005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G37yQnIW8/+COFSLN+7x4ZvB1mxDDGtrj0ik4+EQv3m0Cw04XNwvgz1QKx2v?=
 =?us-ascii?Q?T9JFUCJ8dSZdJ4pZAdVoL9toB96FNJ8oG/VDe47bRjNpkllzSfOEcfQAnw65?=
 =?us-ascii?Q?HtF+lI6Kr+7M0++URpxznOeiiCGIPJAEjvIq7pALMbtb2WMyGgN5pNLzg0yW?=
 =?us-ascii?Q?bdH1owCtd/TijknixpcBZTiTW9SbMqLWCgiFGnQOoe+l0DuzvJ4G9VWHyqut?=
 =?us-ascii?Q?MIOYQYZSR4hG5yMrXmDMg+EXPPdixNjcK7jhRhdXoPR30F4Tw3iKt3Nt2QGN?=
 =?us-ascii?Q?LinBM0hQZ/L6gR8zY2LKnYU9u8mLMAdU8xyCMBLWo9Kh9T1eOlF9+h4Gmh1Y?=
 =?us-ascii?Q?Npr+T/whqhbdvKtIg9J4lmfRnmbT/JHMnQwlauZDoRzwPwmwQa0Vm3GV+gne?=
 =?us-ascii?Q?WXUnz3/uEH9UgtnXiqvhBtzNNgrHlLuxO7sL4f9CrF/L+eLQrGcPj+HDdbbG?=
 =?us-ascii?Q?7E8Si9r9UMsrNc79nFzyAu3kcJwdc2SgzHtCMHZrAfKtTV5hayF3pY7cieJd?=
 =?us-ascii?Q?k+tPeVz1HNAsS254SHmwrVl7QC2xp3m3rB0KxCiwW7qzd4u7uqk3n15yG+aP?=
 =?us-ascii?Q?jt6WIA+psnmjwgN+Vxh6SdpGpkBzHp8pkOBphiePmpRQjiwjCZu5kLfEZ16j?=
 =?us-ascii?Q?F4CpN/GFelaglLIAzN3/zWeUkICDUeNBBrsBkpyhMaoqTwave6NZwJhA2Gon?=
 =?us-ascii?Q?e3oGZYXRQl+hhSwM/nmgy6UvBpemZVoQBEzKXrERCjrZIHCbxk/426wfdowZ?=
 =?us-ascii?Q?F7FelrcAx1iqgvBrL2OgWYN5vSweIfVmjLukbNyIH/lI4n2GxPy96WMLRo7R?=
 =?us-ascii?Q?RW50n/oR8aq4G2PiKJbsHTHS8ekwSMzrTvn2HFo/IPWpLTLqC5uFAQ2jgi3o?=
 =?us-ascii?Q?4ZHRL1NfDFPZ2kpvdrKgYCERtAViQVn3QJZWytD3FBkZ2WzfD0iOlZfjDJZk?=
 =?us-ascii?Q?YfMm4oJswnpau32p3XZaqAOrLvb/hH6K3jAWNI88bMXt23xshEoFTHKjURtA?=
 =?us-ascii?Q?WxF6RdZHWyuNF0o9l6Pn0+BuXNtTjjNYm1milGOnjvv63NZijBQXWNhyx+hm?=
 =?us-ascii?Q?kZqxBfV2wwj3bdJkeW2wNbD94c9QomAce3r3EPpzRdWfJStnEKddEzFYvJoj?=
 =?us-ascii?Q?IGEjw8Khc17c60f0ACWPQuVhu2UQ+EHUXVbFzkbpK0zJ+pkIzF0eDjL9mFYb?=
 =?us-ascii?Q?+7ZmyD2EOCkLWseCcM3k1XHiiFFbpi+nJ3T47M7rUNNshUkdjmdNcOpe6XAz?=
 =?us-ascii?Q?MaOPeVvR5A9PICojiYcmkiWsdtrjHB4UuD/ou01dUMHKjSPKQQEMCUdgJSbc?=
 =?us-ascii?Q?brxzLLY9cQ6Wb5n1p6JDfVD5PSNnNZNT8KZ/3cGCTZkfAXFyBbKqSkAWfSLB?=
 =?us-ascii?Q?sP3T7Zo/Hw9hCBxoAy1oqY3FHL47GMjnK8fqBvbZTQR6QQZQY0BL3zl4xh0S?=
 =?us-ascii?Q?/F9LI32yeesRPX6Mpsgs1c8FG2Qb/2ql0rhxiUhP/8Wz6KpUkhM422WYlzPm?=
 =?us-ascii?Q?C9SoJ61FMEjj7nNgNVsV/kTKkM7vtT0jlHObqSgWlChZz3bgaGi7lD+63UFw?=
 =?us-ascii?Q?bO3CEAnJk9IBfFNsrMgLWWd+f3i0bheMMOymWMhwOCYRp2w5//tuWiGGSmQx?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nEFEmBvWuVEyf/T7b9Ttvdp8zKwUHARzQ//4wY8RSRVoyOXH/VRRoP9FyKahM5riYTTjxrFPJj2BFDMWuE+3K5OKQb4XXOZ2vyvxRU9sRmLiJaRJyaaPgCeZ5wmI26PoLNnlHXn2qxWQZ5f0MxIeTbXfXE7tF+zuY+qzGcgLTdVkV7BU7IvXhJNAYSb9AbK7YzB/yqSiOTGhrOyPpgX4MyPXI0wVe3ka11/Y2+ELorm8XCGUyweMJ77c8LdK943iQu7Nv86pVPFCKT/oTISyFtOChlzurAv0l1epN7IMKCz/63thoPl1W6lMTcstjkZ1Ozv3fcUYlhCQdeUCziKV5eyqkfLZdFrP4lsIQjl/TUmBvFSTFZV4jGOcIilc4/e6jk68K8SxdKZADNeqXiMPKqTzxxIJ5oKJFaTw7rFk5u+wQ5M9DPRH7riUQRKe2sCRMA6TPiyLKbN1fO+AwmP7gsfa06VlbQGiOBfSiVN+1id5u9WPmMm4pY0CD8JKbo+HglcLXCmXCKpRQY8Ie8ELwUpippGMdIXgiLJYS7a8Kc0fk7BYbIisJqngDYjxnlG4tAeY1tO4ELYSFsh3Q3DW4TYNzKSEhuJvCSMPVj1u3rxjj8uFHx7LRHRvl2zx4ISz+N6PS2CwLcaTJGZZ31i/oS03LxDiFesOFq4s+3G4fjD6SmbIduaMhXVQX/v2IF9XV4Sd7KBo73vUhVC2eNKiXOcTEgXu+ztdvHULM4ChSMbmyFT8FC1shimX6dT9XNO4PRAVz+Ftxju8/R7Md3+Drg3tjvEw5cZAlsj7ElAYSeF6ccFy1FW5uck+DMU3DiI70koxT8dA9fYU6QyvL6bIaVTfdejyZssyYIUQZC1/sFA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f28132-57f2-4829-ba2b-08db2e96f211
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:43:24.4745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUoZoDKcyGRET7l2GSsEjFPWZ9rFsNTs/QmSXXBjy3/zQrDK21iK46auZye4pLcVdxv2k5B3a7NFY4NXCuSlZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270062
X-Proofpoint-GUID: eVBNTZO0C1y13-X0B8TMUOS_YiMlZ3-0
X-Proofpoint-ORIG-GUID: eVBNTZO0C1y13-X0B8TMUOS_YiMlZ3-0
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason that calls to block_unblock_all_queues() from different
context can't race with one another, so protect with the
sdebug_host_list_mutex. There's no need for a more fine-grained per shost
locking here (and we don't have a per-host lock anyway).

Also simplify some touched code in sdebug_change_qdepth().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index a61e7c31dab5..cd05e2f87417 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5497,6 +5497,8 @@ static void block_unblock_all_queues(bool block)
 	int j;
 	struct sdebug_queue *sqp;
 
+	lockdep_assert_held(&sdebug_host_list_mutex);
+
 	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp)
 		atomic_set(&sqp->blocked, (int)block);
 }
@@ -5511,10 +5513,13 @@ static void tweak_cmnd_count(void)
 	modulo = abs(sdebug_every_nth);
 	if (modulo < 2)
 		return;
+
+	mutex_lock(&sdebug_host_list_mutex);
 	block_unblock_all_queues(true);
 	count = atomic_read(&sdebug_cmnd_count);
 	atomic_set(&sdebug_cmnd_count, (count / modulo) * modulo);
 	block_unblock_all_queues(false);
+	mutex_unlock(&sdebug_host_list_mutex);
 }
 
 static void clear_queue_stats(void)
@@ -6036,6 +6041,7 @@ static ssize_t delay_store(struct device_driver *ddp, const char *buf,
 			int j, k;
 			struct sdebug_queue *sqp;
 
+			mutex_lock(&sdebug_host_list_mutex);
 			block_unblock_all_queues(true);
 			for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
 			     ++j, ++sqp) {
@@ -6051,6 +6057,7 @@ static ssize_t delay_store(struct device_driver *ddp, const char *buf,
 				sdebug_ndelay = 0;
 			}
 			block_unblock_all_queues(false);
+			mutex_unlock(&sdebug_host_list_mutex);
 		}
 		return res;
 	}
@@ -6076,6 +6083,7 @@ static ssize_t ndelay_store(struct device_driver *ddp, const char *buf,
 			int j, k;
 			struct sdebug_queue *sqp;
 
+			mutex_lock(&sdebug_host_list_mutex);
 			block_unblock_all_queues(true);
 			for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
 			     ++j, ++sqp) {
@@ -6092,6 +6100,7 @@ static ssize_t ndelay_store(struct device_driver *ddp, const char *buf,
 							: DEF_JDELAY;
 			}
 			block_unblock_all_queues(false);
+			mutex_unlock(&sdebug_host_list_mutex);
 		}
 		return res;
 	}
@@ -6405,6 +6414,7 @@ static ssize_t max_queue_store(struct device_driver *ddp, const char *buf,
 	if ((count > 0) && (1 == sscanf(buf, "%d", &n)) && (n > 0) &&
 	    (n <= SDEBUG_CANQUEUE) &&
 	    (sdebug_host_max_queue == 0)) {
+		mutex_lock(&sdebug_host_list_mutex);
 		block_unblock_all_queues(true);
 		k = 0;
 		for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
@@ -6421,6 +6431,7 @@ static ssize_t max_queue_store(struct device_driver *ddp, const char *buf,
 		else
 			atomic_set(&retired_max_queue, 0);
 		block_unblock_all_queues(false);
+		mutex_unlock(&sdebug_host_list_mutex);
 		return count;
 	}
 	return -EINVAL;
@@ -7352,7 +7363,9 @@ static int sdebug_change_qdepth(struct scsi_device *sdev, int qdepth)
 	if (!devip)
 		return	-ENODEV;
 
+	mutex_lock(&sdebug_host_list_mutex);
 	block_unblock_all_queues(true);
+
 	if (qdepth > SDEBUG_CANQUEUE) {
 		qdepth = SDEBUG_CANQUEUE;
 		pr_warn("%s: requested qdepth [%d] exceeds canqueue [%d], trim\n", __func__,
@@ -7363,9 +7376,12 @@ static int sdebug_change_qdepth(struct scsi_device *sdev, int qdepth)
 	if (qdepth != sdev->queue_depth)
 		scsi_change_queue_depth(sdev, qdepth);
 
+	block_unblock_all_queues(false);
+	mutex_unlock(&sdebug_host_list_mutex);
+
 	if (SDEBUG_OPT_Q_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, sdev, "%s: qdepth=%d\n", __func__, qdepth);
-	block_unblock_all_queues(false);
+
 	return sdev->queue_depth;
 }
 
-- 
2.35.3

