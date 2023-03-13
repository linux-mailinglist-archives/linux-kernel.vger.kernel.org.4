Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F8D6B756A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCMLLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjCMLLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:11:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6D25D8B1;
        Mon, 13 Mar 2023 04:10:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CN2m0T027099;
        Mon, 13 Mar 2023 11:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=rgfVvGUoXO5A/cySkwEaPA/9Kk865j2gO+lEXo5cKZk=;
 b=SixkXK0W3C5guBtnV56iHDvoqe2OjAf93f39jrZCpN7MC1nuMqCvnh5lxn/iElkjF9qX
 cUwgcbM8vhrS/EB+pLgE1tn6jHmRRQGjRYaOn1/DPvOVsYX8utu4AmNMmJn2P9j6QHBJ
 wOEEpaii6kxZJWLaW8nmnNBBPmZOdgKiDLOFVh4rX666b5q6SjnDOgx1FhpFNGHpomEQ
 2+uULL4xb2P/5F48SaGZC7WO9vNaW6vd5gjezQtQlEmViaWhLxggiDmOZ3HBJKixcYFx
 F9mg2dYFmhF9lK0aWSZch5vk5d7CVPWijUWPabasX6wdH9k8jnUOf8LEBE97yrhtxz48 Ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8j6u3h7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32DA5Xnl002375;
        Mon, 13 Mar 2023 11:10:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3b0k85-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6x2wppzFP51+127CfLylSbCs6yPpyApSoVh8gxturQiMWTbk+AkkRge9WqalBComVJE1o6+ec55g2u4BGsXVXXCTsy8m1lIfeLcBvMqzmIOG55p5DbOl6VLfvkcO+PCJLZKsRMmfPA2mssGB3fmqn1Ca5blRzHF2Ka7jN3RUYWh/ImbwdrM5AKict7TscbYPPHb4lPj4qhJE1BkXUf/LixqnpHRV9d617ZTrK1b1Ffyqm4QjM8gdifZCTFgoZkeg90DiJaJQnQs7NiCxMxgIws6FuD/uFRvED9AnTx4kOFOqtJ8A5WB7rfUgAMaKRNnOl1HNWR6HVN0HeLIBw3Wmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgfVvGUoXO5A/cySkwEaPA/9Kk865j2gO+lEXo5cKZk=;
 b=Jv0z2yllaOVownH9EG++A8H8E+xnDhsMrZGEF/BaeB1KoIMZSGXrGZnx3lN1681MYF9/5Le0Op0bPz4RRAubQ4c0aEXl7ll+n4kIQe64eL/l92igEFBi7qNaW5kJ81b3OGssSzBMG1H5HreIY0Bf40pufXDE3c//ZL0RM7QkKGl9u7oi6uIQIOb0ZH4MjtFHmdM9qV795Dyy/d8wFF4qMOrWlFuWNmLb2CafgqXnOOw24L7uTlJ8rbtano2osMLZD69rQmUUTiZkWoC/oW7RmZhrk3FhforlWZWYv3P6gPBmdE94NijynSF76yY3S06NGpsWy+3rdrFgnPxx4ZxUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgfVvGUoXO5A/cySkwEaPA/9Kk865j2gO+lEXo5cKZk=;
 b=aLq96P7cB42vQnldW/iaY+nmqswxSkzV0iuFn34bStvY1M+9yrXMvk2K4JzfvE0PYTnw9FtOgooe0ayUGRsInx76lJ5FjCdEtMimcbE9CAjWK618Oa5yBpo2m/SOHSd0PT7aDUCTTdVA+wKeT9YR0VaZEkjNtq6xGT+4YKIr4cY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7672.namprd10.prod.outlook.com (2603:10b6:a03:53e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 11:10:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 11:10:41 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        dgilbert@interlog.com, hare@suse.com, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/9] scsi: scsi_debug: Don't iter all hosts in clear_luns_changed_on_target()
Date:   Mon, 13 Mar 2023 11:10:11 +0000
Message-Id: <20230313111019.1521680-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313111019.1521680-1-john.g.garry@oracle.com>
References: <20230313111019.1521680-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:805:66::36) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 7562f3be-4e5d-4a75-5ba1-08db23b3951a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4EMYFJZtwg4DY4QrXL7pBuamOcRSZKwyoUwUmVsmFPl3jP4K1wZEI0tcxKRUW+9dwQPzo8iyo1oBcI7lNOz/0fSYXaoz+u4Pmotix32IiqoE3Or2CwgmAToUCMXKQv7mfhnNxsE68doj/b/KvNSTDIDpjCrwTdP8h5hcQzyK2UgVjJh5GZXoiz3xGhPZb1lWg3NtbossW9u9t4eBX6QqDzQalp6txhuHFMz1UeamVM8D8eEHS8dzg/8vc2ompaXTwtHJ8Gpel+C1IqC04B3b7dCbf+M88Pzs+LHsM1I2Rrs04FWtimDmBKU3QROiWHsbgk9MQ9wuD75TZtIzEhNeuFy28uIZumHAsamC/de3A0omkW3GHFJR7b9CYcaO+RcKu0l4zM+DBfLDadcwbF4Iu+a+aet7DGvM0jYl1XAaV06OfkWraMJ6CzQ7T7rtigxAoLJQppsCLz02rrYO7tjQAay17a8H1176KSeUc5Ky+Msdd9gFBuJL4oYVbD5m52QTb2A/YC/vVoYjiB+1y30BMP4ZF3nDv95N3/qYjV7ZeDeMRlmngAotTffo6Pa9ZScxVQObkGsTpBY/dMTcH3pd2DdeELCX4B5uvFfDvUagErZne69e0V0UUiZJZxEb6xEjFKUPYtgLVDwgIVC2cmrKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(8936002)(5660300002)(41300700001)(6666004)(107886003)(6512007)(6506007)(26005)(1076003)(186003)(2616005)(83380400001)(478600001)(6486002)(103116003)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IydlCYLTB6zH8FqfPotZl1jm0SHGnH6H0IQl97J+SHCKi505eLXM+wkc62X6?=
 =?us-ascii?Q?Nfz0pAanRJp8x5RTabKku2I/89+LsWaVV47fNJ53UbL7dlDVtQGmM+vH7Z6q?=
 =?us-ascii?Q?8cBiNr4tyyK/VamR1Teo3slla9dweiyKufjvP1F9BlOkkPKnmrTdPSliHVkD?=
 =?us-ascii?Q?1erwvp1nESnopfmBP9gjGINr1AduOhd+QmA1KNB9jtpcWOuG5FL3fG/JEvu+?=
 =?us-ascii?Q?wV8W9Rf5ywSw8px7eDSx6QYpYQI/dEPglB+/fUGwWqwP4VSYXvIhbtExtoDh?=
 =?us-ascii?Q?rKSmZhZUAiK7eXm3jmaRLJKNnNJSK9WxGBqZSgVqNU0594/vfqlhwvyZ0KBe?=
 =?us-ascii?Q?quO4lggBkBB4rXTyZ2hiuAwSB3KijWOOw0BLJoSoAKYvu9zqM2Nx5hy1LWfp?=
 =?us-ascii?Q?vrNOOiDdsRqr6pj+Fst4gsPsmr58/bWbbWKI1mhMZAPl/bIOfdFHI9kF+p92?=
 =?us-ascii?Q?rAwQa5qu/TTB2po/J0R04A7s9ohvSODnd68LKdJ1Ng2+CAbo8ePiV071IfMM?=
 =?us-ascii?Q?vo0ndf6ema/PpjrcwbYgy7ZZa75WToB37tRDLu4VyeNdW7sib2sF9rTxn8eG?=
 =?us-ascii?Q?O0ZZu7uHTSBuhQSS5ARbLF6/mGGxGFGkEbU/NTQOAtaiZ254teBKPAdmSb0+?=
 =?us-ascii?Q?5wpOgVXmGxc2b71fSki9pSbg2CgCNG1cHaeFqrBg6c0d/wg4TGkClh+y9na3?=
 =?us-ascii?Q?P9OLUZVXO/qijQiZ0nG+pj5rxgHrkCWlZ42UQ0OeoADVsc8kBTf+3eBXhNLZ?=
 =?us-ascii?Q?pIO6e5+7qYUi3SVPWiR4f8mQvl2naIv4Prn76FEEu6A1lYRI26FyKpleB0wQ?=
 =?us-ascii?Q?3UcA0xTJvRmE/FXG3/LfvJFYSqmNPIjTVlaPjeESmSIRu9nDztWXs6KSisfY?=
 =?us-ascii?Q?CO6oc+Khx9TCBPz/c6BmUFKPrDTC0JnOcRHfO86rUKn9fgATHaPdiANU92fV?=
 =?us-ascii?Q?G1yZFAMrO/bffusWKrpy0cilpuHispM0wg/iek3ePxWfyevkeoHpHmKn+bTC?=
 =?us-ascii?Q?uhA+TM8haoyV03ZWC+/OyerezmdzAVVRaWSTyXLaQo+WOMRXZ2QfaTAe/hJ3?=
 =?us-ascii?Q?MUFp6xGblTm0Z0lqAqY0aBlVcxSX6YltnrR0Ujv47j3pS1vZdDszFYIZ3zMA?=
 =?us-ascii?Q?13WuthZoziUg/SHxttbbxndcDy1/onHHZbtcxXgNZYAMxATCQpehsdbO4FEl?=
 =?us-ascii?Q?h/TYQcEAAwfiJ3fcn7aGsZ5lCMOTTfzAWoeRjqZdlg6m+lUEWr+obYJcfafa?=
 =?us-ascii?Q?6TMOwCpQ+HoiYStzcoVHg5BCYMNCYMNEZgTyZ8nwTL7sh+2IdQmzTIdV4OSS?=
 =?us-ascii?Q?Gx1K20OUoD9UapgUeSklaPKUhWuqddPfOZlhNYTsAFvNKh6RQpJZsryhwiZk?=
 =?us-ascii?Q?1hM0myIDx7bPIaztjEK2h21kN8I2xSldP2Jtx77l/r+/c4D3JsuHep1XxN+n?=
 =?us-ascii?Q?O3a2Y/VG8YJm8W1MXzMCEy6DRCrmujgaVFsUJ22MZCJHvDZGrp53uZel+N+Y?=
 =?us-ascii?Q?PtEflC1uL69rVxiZq5VE72mndsjQhH1GoOOvMdWdQy9N+38+pNaSdFvDfKwl?=
 =?us-ascii?Q?sK1HGkQ3cTyI2zKWT8+QehSQCXUVRUI6FWueYGsq9bUKXSA6V//ivKD6Ifs2?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5UGoDnmVkrzSBzUaotnmmap5KFWNvCJSZxnPzpsJL2YEHl/fmfD8bGGcLaB3X7aiRMUI3s90zzJjsF95d4uZ97wojEdQ3p9SXE8DRKzXvppOtcs/Fxcel/q4mG9Zgw96OlnzOzEyhQVRem5AMGlbiSHJWtLHWjW1BzlGUMGBQ0i0Bn8v9LJdy7ICzaOOxNGvPlQskUvhdD3IUI0KfQKZwTwPIDhDw67qYCEuj1rKhprNaHPHctnIUUALrA9LHB7fbHaGelpfmETidZ60kGrb3DQiFeaVY5q+qTQ3csn7Cqesge6lcFIy+kM8cBS5yG+9GnbhGufG82HrnJNqUx4o5gjJ881oYUitach0H39n1XhbervoeLbzpzAwUfwH62NtxUjqLCuJSH+nwjxNblubZktbJqAgRe2CIB0jd4vYYOH6DIAvNEx9ivnXF0dyHpXMLj+DnxugNTUIBq8Pnav90YeksDO4f3/uUclvd07MoiTNoT7y7wTP1crAfn1opanBkBe2de91aMkhONzZ+GSjPfT1n0xpenX3tUS7nA+t9SDiv8c3Bb+fNWGhGTWOXIAh6vYfoGnsINrAgXNJGoHZ/jeurphrBS2TYNXvC6HNsa5PIdLcrMrFCYoW57NMS1bu4VGRWwKSslsWdJmcsZR3KwzadjVwUMfp16bAHEvM2W7kk5l5SiIi+289nO4Hl3HmDB79bRFe87J7yDYRMZCKgRno3+sNonWxN9bWdBtC8kUtMctYQcOIDMiX4Hpepc4nOd1JM/K6GbHwYTqymKAndYKn1+3+8WAFU4qtj0s0nlE/Sjre5m+RXTIUiYjlvVmu1BDSNshYZrGODAwP/UV8MW72ZXSUWL4JrBTr/JXOKwqDY+8Ky4/w4PfoAzqRol1CTvaX/vyDzpDMsvvDJwJkVqz4zpiw9TGnC6yVeX2y37o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7562f3be-4e5d-4a75-5ba1-08db23b3951a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 11:10:41.2113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yENFQFLdBuBPlhyVxG87z6OgEWk25g+slLwXwwmr/yWWA0JZuKCdX8qgpZuv2HFtdss2/rn8pWpXTTltU5NfbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_04,2023-03-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130091
X-Proofpoint-GUID: HbrYbHoRJDi4Glp0xYU1Hl26jTmYNvpw
X-Proofpoint-ORIG-GUID: HbrYbHoRJDi4Glp0xYU1Hl26jTmYNvpw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clear_luns_changed_on_target(), we iter all devices for all hosts to
conditionally clear the SDEBUG_UA_LUNS_CHANGED flag in the per-device
uas_bm.

One condition to see whether we clear the flag is to test whether the host
for the device under consideration is the same as the matching device's
(devip) host. This check will only ever pass for devices for the same host,
so only iter the devices for the matching device host.

We can now drop the spinlock'ing of the sdebug_host_list_lock in the same
function. This will allow us to use a mutex instead of the spinlock for
the global host lock, as clear_luns_changed_on_target() could be called
in non-blocking context, in scsi_debug_queuecommand() -> make_ua() ->
clear_luns_changed_on_target() (which is why required a spinlock).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 52e33ecc6122..6e6eca694bb5 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1063,18 +1063,15 @@ static void all_config_cdb_len(void)
 
 static void clear_luns_changed_on_target(struct sdebug_dev_info *devip)
 {
-	struct sdebug_host_info *sdhp;
+	struct sdebug_host_info *sdhp = devip->sdbg_host;
 	struct sdebug_dev_info *dp;
 
-	spin_lock(&sdebug_host_list_lock);
-	list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
-		list_for_each_entry(dp, &sdhp->dev_info_list, dev_list) {
-			if ((devip->sdbg_host == dp->sdbg_host) &&
-			    (devip->target == dp->target))
-				clear_bit(SDEBUG_UA_LUNS_CHANGED, dp->uas_bm);
+	list_for_each_entry(dp, &sdhp->dev_info_list, dev_list) {
+		if ((devip->sdbg_host == dp->sdbg_host) &&
+		    (devip->target == dp->target)) {
+			clear_bit(SDEBUG_UA_LUNS_CHANGED, dp->uas_bm);
 		}
 	}
-	spin_unlock(&sdebug_host_list_lock);
 }
 
 static int make_ua(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
-- 
2.35.3

