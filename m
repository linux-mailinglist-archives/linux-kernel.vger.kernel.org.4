Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C276321BF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiKUMSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiKUMSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:18:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894ED2C114;
        Mon, 21 Nov 2022 04:18:19 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALBblqa018004;
        Mon, 21 Nov 2022 12:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=H4WSoQsqAjhEuqlHSwV/Rr5EjmcEyVIOOM1Kx2rH8gg=;
 b=zKIJyvonYJxHKUGW9MokM6BTKBzjXPajSnHYyfdhivRVEaonJZMNXyMiOKaz7xq3Dztk
 3Mklyl5foawoC8J5rxsOD+B+lDhnniWeU0lTsil5vuZOk5A9T2otFru1jM76FcXY5LQr
 PqwcpX9KIYGw6ifN01M3TWNLigWj1h+wlSM9+z4NzJhsoPzzRR4I3DBjCfwzVtBPCyJa
 GeQ0fa8GvjJQYgG1+2AapLnO7M9cOKikmPrY05FcAeS69cRDpVJB1uDs7+nA6Xmh8fu+
 KjCkt7KLCxTvQpd/cfdQCuKKAMkr8nG4wi+7e/nOJQ9gXLiOAEp31jVlEHtvToZFZdVR dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m08e5830p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 12:18:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALBjMA8039675;
        Mon, 21 Nov 2022 12:18:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk9wkrs-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 12:18:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKwGJD9P7jGZqLJJd1Z+8ZTrhq+vIUJ61bCgS4azScNwcTbu8gTYwyg3oK1doLDAfIzXF5bqE72jmN26SBm6mKFIAo0I5/16kb1CXsDKNdKetfevGytRwPz68rC9dhy652F1EAgY2NAnbzDoVAR7v4SfgDPzZmunk+v0RiOtVOWvfe/jlMjK6l8ipP4+jbfVTIyf0uMzYRZVdShGpWIl93G12/M3vxwBh5mpH31FTIWjUKrraWZkmZFABKdWaFoJeLcIJuxWzg3HusAPyALbmIJx9F2fXlpwdtIAT4GlkceezAF0SDIzTWTrGA/DUyKPXicSncULs9gOTD5ToFCWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4WSoQsqAjhEuqlHSwV/Rr5EjmcEyVIOOM1Kx2rH8gg=;
 b=K0vM5z9C/QyZ10HDJdn57XVZc4Evxb4Z7HC1nWUxVQsTMGCkaBmJST0wauHBwtTvvRHAzMcKrD2Scv3G1vd8GQTGi3o3RBUnx01Bd+3ZD9TJRA6KWMNH8oeJDRa+8PhloICZpK/uNfZxWBfdASiuUnXbis2n+anZSfQKWLEcVO0TED+I+q397GZ27l0M883Fz0H/+QeolcOtb4TvsamWupu6ylup1/5LpISCEBD+Emo66ghCMnPMkeajyTtImcjUr2T1MzR5YS7YHPlTOVa/+oGajOAZMkP85trel8VMyp1E7NjdAqAsaFuVMqA2L7ersez3HyrPvAF52lfXRbj+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4WSoQsqAjhEuqlHSwV/Rr5EjmcEyVIOOM1Kx2rH8gg=;
 b=zbp427JlyeBvQXAnRxXSrRrNa5jG5xmYtmh2yRLSboy+PhO+j7zdlQBhIRSl2GRD8c5z/9zWiDjo1Z+K3OYuj6vt0zR6/D9g+gAL2DB8plcWJXRv69epr1UOvCOfC20N/jN5JxxNstGnX1oni6gPRzKZrvQSvOn1DJJdT1ILEuQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6496.namprd10.prod.outlook.com (2603:10b6:806:2b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 12:18:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 12:18:10 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        damien.lemoal@opensource.wdc.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/2] scsi: core: Use SCSI_SCAN_INITIAL in do_scsi_scan_host()
Date:   Mon, 21 Nov 2022 12:17:25 +0000
Message-Id: <20221121121725.1910795-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221121121725.1910795-1-john.g.garry@oracle.com>
References: <20221121121725.1910795-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: a058ace0-3089-449d-e38c-08dacbba745f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnrg/Sbmhv0yWBNmIoo1b8rLrn0+tuWGWu3bYqVDc8HXjt3gzgaDNV6qmbbuIba6bdrmsT/Z8yFyJfW4ty7KjpBJQLIljkV/mq3PvvdKRrli9cqz/lNtTURZcjAvxHC8j7lvJOL1Wpj62nuSqX8X6QY42m8RyHSRGWyiKIHtw6soRhwS+Z7iNqJN5gweoJm8QQ9mD222mPrP5uyrywuN6uOy13eg88tnxjg27uoAJNmIpqBXbAcjdUO7aHHN5YbQJ4nYsCOwcBRjc3hZOG4itSD2KQ6u9DywxxFLn7UWj2BYoG93tsTiQxkxIZPogL/KzkHQEn/3SxFXlptu4BrGbQUdMzFNdI4oqRNYvCSHr4UmyFu15OKElOfrFy/DAzb3m2yAWNFPRRM7UU5aLfmZg/fuIJZnVdLSbTZswxE0wkoQ4kdoJ+p6h+jM7ZzO0SArIByIpYFB5y9GLzMjWgPce5G3UG/h+NTVpInofl/baneU8qRbmh/dAjVjEv1s0SFaaypEPIQrqda4Ila1hzjxlD58TyCtv1rXdI19NDnP0eR0JlnG889k02+eb8CsEdbAlTnawHq2WT9dNAPWSkkcm4mw6cum4+p4hCAs4+TnP9AIFLntFluWGaw+ygsWrnaMt890PvcTVWnDxAedYBLHhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199015)(2906002)(66476007)(8936002)(4326008)(103116003)(41300700001)(6512007)(6506007)(26005)(6666004)(8676002)(86362001)(66556008)(66946007)(4744005)(5660300002)(36756003)(316002)(478600001)(38100700002)(6486002)(83380400001)(1076003)(186003)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W9a1FGkT7RHLDfRcm9oWdc2+e8DyZBr0WIPEqA/DsN6aAzgTJn+xYXDC91QN?=
 =?us-ascii?Q?/ooOOlO/4w2B+nl+TdIOp7xHcPFDwXTRsLDpVA9t2TCKm3S8ZsXpKJ3XMaBG?=
 =?us-ascii?Q?OS0xoxFOwe+M4zDqwNntQFhMwMRRP+vIDTHloeIIzwWA9w82LqJgAV9VzRqN?=
 =?us-ascii?Q?rvyPjvGmXHljO+WcBdmCIwr66t8oknA/BYx7tZDr8AttUAowVwLry6964nC+?=
 =?us-ascii?Q?i7q1gXDUg2Dh2V2fciDYsP4JFITDMfIDf/W6tZ+5kuGeCoc7EivYANLwJ5mo?=
 =?us-ascii?Q?fGfTwmJ5jaNBLSY9dQUdOQnfbqYhkmNE9eMPhDK35hb81Mfb9RJkQfGJ5PHB?=
 =?us-ascii?Q?YIZkmws7UW1iYFX83XH8ex4WSJxYfnsKBk2wKrLtheuH83KAJenTlDIQBtWp?=
 =?us-ascii?Q?oUTFYpeEzEhHkpIyI+HoLz8NqnuzFN2ZzF52as07v+s4Mq4jHwioSP02kgsQ?=
 =?us-ascii?Q?yVAiF30tF/RsG7MtA4aclhnjmWWDa40RT1z0Dg5wtJsi96DHgLmmztFXQGVa?=
 =?us-ascii?Q?iIqV37vkNOYe7vWhogfBP3vQilZC8U7Vrv43HjTCt/j6z0dgXCzHCp5inkUN?=
 =?us-ascii?Q?36Ts31S0go1zMy8sF38ttXSTE1irFqMxyyngByC7E7sgr2VLk4JC8i9Rfl7k?=
 =?us-ascii?Q?llHkRRev4LnYvNfu4xr7acNQVnUYI1J4khS2KZyxCJjmIU25y+aWRMDeYoOR?=
 =?us-ascii?Q?o8xph2h1+Oz+s7X/CkooTHpal3agu3b++LuGIUmfDdvgIeAzwzEB1k1kbhM9?=
 =?us-ascii?Q?bRkcUlWBBBhV1EfCQdzu4NC6tB5WMNAHP1YmmHQlDaoHjZh9KMGfv57eXK43?=
 =?us-ascii?Q?7QPgA1i+dTDdy5tortke7OOLG7PbwVjfq5/LdJ41zWEoS4TCJPXMoCWNUMSb?=
 =?us-ascii?Q?mhtew+jrbp7ncG301GIaeNck1fQLaS/rv3wl2zT3K7OLighDKMT0LcGRsJnA?=
 =?us-ascii?Q?7vGmYg36xulbcVkCsrPbBDLlWb9Uf7p46o5xhBD7boHvARXQrhSy+Ce1kCs/?=
 =?us-ascii?Q?dufvjYn8Wa9mJzG0NM3U/dboeTBOnUz+QhASNzGdkCmnYAk5R6xmOQP0x/m/?=
 =?us-ascii?Q?+sfnokpzWVCy0XYRCSNiRyILnLAJh6guxL8oX6sVdPXuLu8KtfaQnCNbqViM?=
 =?us-ascii?Q?s6SCgNPzkx2U8w+tFUwR+79YtbbMOqqgZwcHP/6uGwD6QQg7NH0znZsMsPZ1?=
 =?us-ascii?Q?xbjlj0+GFaGne7cLP1mHxyctTIXwmwh4lncTlUwybYBkUfaEKAJZgD/HYSyz?=
 =?us-ascii?Q?4bHyV6aZnoFix0zJL6vwVnl1sbgoifQLfKNJp/c1LoRtpZn1cc5Qb6OAGwCu?=
 =?us-ascii?Q?VOoxnHughTV51CZF4zADZEaZ8aFHT23KoKQFCF4didp3lv5D2AxplM+0KoM4?=
 =?us-ascii?Q?5czClI6Y5qa6FVVclaaaEwVDRz3YPQQdKm9R9lP/2vq0/4juqE2dgdHsJvS7?=
 =?us-ascii?Q?GWEMaX6risgUvdm+pwTo2Nzirt5yVF0lvsiRPcn+ontnjv9yH4/+ca2XU8pn?=
 =?us-ascii?Q?oyobqmuiMFtQ/Ze9n9LX6MLMCbqQoESeZoh1qFF6y0gy1Pus6yXHlDBTH0Jm?=
 =?us-ascii?Q?x1bpV5iQikuTXZhlMp5jIp61WsMHzoY0OVLazEfqa+25qh6Pd1N3ykqI5UBy?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XWkFq2dcfOT69FMRQgI6/6SnGOdlgy8mJ58rAtj1zuL7kCc/lIEyiNlSHiEnhfoUuqT7lLKMGUVsS2R3WlRgUBla1fH+lO10cJoYjIIugq62Lq+K+zuHInSbq0BC77HvDv7IvhTNbVGwKDHCEQSuaOHJWV7N1GpUoftVu36wfWrkh3sq5LAHq5XSKsKhBLidGo5s77ZBMSVhi6Ss+yVhX5TyCQqOqr8NeQW8OtWcq4TUkPGADAtPYpDnkbBKuGmeM1kAS8Rsv71Un2YogkI5hiJ6PaX+D2Hntv3qfzeiBzYkc8y2dfYPDMamG6+UkXHvgmll4wyeQy+SuFwl7K+f4uEiecSfEmu3vUv/nmC2KmIw3/mi802hMKmg/ABPSRa9ep9vbRrofzilYdxmPQyLS/wvKI4iOC6LlZxK6pkCXHWgYAporELxPGGVOsw41pgPiakVYjDu49dTCydrCvTKrrOboSgdkUN19Vg75121y/Ec+QhGxOsPL1uS434SU+bCVZnFAddvrb9KGtlr12S4pVBk9u/wvEdJpZqjCWzrubiRbhPfoCL3fd9kiIe29Mn7YwWbME570jUi7O2S/lv6yqkpChtjNRi1YDftRKflElk6YvQdQ9i56cvoLPSTjFNIJPfRXrho+a9BKLGgwJX8waaW1NAjcOOdwAPw2heOjdUUV3pXSpSwQ5EKC6uM030OiFaLpluYiObASMCNgCw/k6W/Bn1yMfdMyOTBroqAWv/IgUhFnlYPCnR8d8rJiJF/0i2aSWTaNvEPwL/coWk5NeSucDXF4XvV2nCYPIxI033We9gFNW5USPBoYpAhhlb3hotEZ1/y6x9M6tcoeYEtv9FIOKmmC/u7V2vh7G4XsCEp/iIrNulzJSkesEeEMdqBR1Q7TziX3heZi865Ad1QDQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a058ace0-3089-449d-e38c-08dacbba745f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 12:18:10.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPGgKjgS//KXarZOBxNnFMtQ5abss6qRFiqbPxSpFg6fs/u21jzEncU1CqdnzKdvJDlfky0UW2X2CTj+lnfhlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210096
X-Proofpoint-GUID: tkOax71cwHZmEfoQsdrxWb4A2qyIsxbf
X-Proofpoint-ORIG-GUID: tkOax71cwHZmEfoQsdrxWb4A2qyIsxbf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using hardcoded '0' as the do_scsi_scan_host() ->
scsi_scan_host_selected() rescan arg, use proper macro SCSI_SCAN_INITIAL.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 6cc974b382c1..920b145f80b7 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1920,7 +1920,7 @@ static void do_scsi_scan_host(struct Scsi_Host *shost)
 			msleep(10);
 	} else {
 		scsi_scan_host_selected(shost, SCAN_WILD_CARD, SCAN_WILD_CARD,
-				SCAN_WILD_CARD, 0);
+				SCAN_WILD_CARD, SCSI_SCAN_INITIAL);
 	}
 }
 
-- 
2.35.3

