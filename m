Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9D2700EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbjELSY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbjELSYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:24:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB8100E2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:23:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4Bpx002669;
        Fri, 12 May 2023 18:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=u3/zRZ2Ucre2QO+L/T9jdiOBbG7EEf5W3yMRjcw71Ww=;
 b=1Ll5Le8jT9nTW8BCgVJgQCpqJ3znWT+gUaJul275pqaVq0yn8lKWyuFmTSnRYu6MSBTG
 5YQoRh76Bd3+x+zfK3HIr0iRHOZTkDOGa1xjPGy9L1aOHBMMijdJDaF8EcQ14fId05v9
 KsX9j1UT07ulWzGqV0uxjhcff68NtzVe5DWRUGpYwbShYnBO3hjuzFpyVLShzkY1IeGN
 Hg0nSfLqrFMUlRIsPCMaFKZ45WmzHF8cP7czRBFADKcbijoytyXXS/UOuLfF/eVxgzFw
 XSEt36049dm5SRlVx9F0fq4O4WBL22uXTzoXbacomRskPn2z/LQfhYv6oRhz2qky97Xb Eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777bky3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CHDjDJ018568;
        Fri, 12 May 2023 18:22:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77mjmp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8u3sf3x6rts9LBNiUnjM7y+ajS5HlxgpiGPylBRid1Gu/3eXzN8OGdBBpWMTyBU1xZMsaVgOoFevI3zB2CjH/VVE0MJj8ZlJ1tIAHHU3FzxHVLBWjEf0pdPb83zwkZQf/J9K/mVZgTNxnDhhiQO8naRTYv1E0YeSDGJUCE+CasSBAd8y21n2cFwAPx+Z1gsUcfh4jfuOLUK7Xh7dIvIKeTCDw4M3VoFIXsb+gYBo/Pay7n4LU9gzjqWpBp/BXcCPpqECFvb2hM5yeQKRdkcbhPIXiKQMf3SeDXL1I2R31DV6kXlaBJ3lqOtw2gDlmhSgY6rqlhOMAJCk7ijlg962g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3/zRZ2Ucre2QO+L/T9jdiOBbG7EEf5W3yMRjcw71Ww=;
 b=WupKGF+GJzImrt2y+fG2cHOFyXliTAPCBZ8oz5HZE6ju3kuBDtDwAd+VG0RCnRMJxoQN5gm16JU0dcGAWkaLQcRlEp/WzUtek4aZiZN7GeDm5lbRfOhfWh/+7u3mUra+eMhLl09oi2URIBiubknWuou7p5bB7mlwu5O7rqsj6aPMS7jWfYeakgIkWaOgqFDpy4TsEhTC6NaqgUK/i5bvo1eWl3F2r771PGkvkwZ+LvjUN5eWmzZoURYRG4WOB4xqnD1RAIf3SRKKlxv3z/DJmYKK5QAvmk7QhlO/gl50QTJng+rhFMOs45WJCkmMdzzbNXH1x5yJa3Nbkg8exbMRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3/zRZ2Ucre2QO+L/T9jdiOBbG7EEf5W3yMRjcw71Ww=;
 b=YaRxO+RbqjJdf8EdkwNX63ENL0gWKTIBQUbV9yVCT6LHb/1z9dtQ7Ut0jBSJhVR0Ty+MdOgGP4F3FWQCN+5hCuppnbdpQeI67gV501Z8ioxBYXolQ5r7BSgFPZh8ewEC2G/jevSTcH/s0sNMvpyWCyzXds6Lf0Fdx2nUFq91dRI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:22:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:22:19 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 35/35] mm: Avoid rewalk in mmap_region
Date:   Fri, 12 May 2023 14:20:36 -0400
Message-Id: <20230512182036.359030-36-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0218.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 462413e4-f6dd-42f7-b5ee-08db5315d232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqWWUB9XsBaGiEhb2pkUMauq7rRLJ1TF0JfNrOUomOX06vh2DPBqFngqRg8f+O2bzZx8hEYpBWdLlzisDgFxqNCA+PttP8DOOiYDb39OlL/iQ0YP1Uad8jZDOmcxxRtP8sLOs/3ZBRtGsnHhnhBL4xs4rkitL/RBEJapA7+uLVjjJOAYUwB07IZOrD0Eg0wHwAlC1zpf2hcyyFwvKKmBsVHrE5x0AU2XxD/0Z3lktC8KhR9ZRd5dWDBRnZAxM7P0bGNgLvnVVgru8Ud/OSla6HqHA1ptjLPXqLLRY5L3zg/oSkLHzKPDNjD+NrtEbBoYswh8QOKtRkSve8DqSOvK+vY2WKvjCIC47/41XWL/O2HVV51u49nAfiKOH80h6CN1TlRnFieAvx7UYmXdVI9CwuJsTX8seoQF9Awl5beAtrnvkRpBNtY8Y4qineGgvLRhOWkRoxpxt8udJgb1KSWj2Rj42GnV5Lc1xsEOIu2C1wL4l9g5WyTUvrjIyySnQLUVIcLuemPVEyukg18WawA0DbLQRJedKoRJRV5lTBFeeVVz3/tuZhf/C2ZHnkzatX3T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(4744005)(6916009)(66946007)(83380400001)(5660300002)(6486002)(316002)(107886003)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1SjPSGLKeboS7V2xT16ugtove53isD9znPfG0SOLvo9Myi/5+r2kB0Z8yNHY?=
 =?us-ascii?Q?Q5iHLTrYzEglzeSJfPI0L+P2jqHl02fuReG1brEtg87rio88s4J0j5oTsiMD?=
 =?us-ascii?Q?0DlkFrYdaBYx04T4ytD/lXI2mA2SFp0k/pi77dq8ZqbNI6+KVkXeXJsU0hv+?=
 =?us-ascii?Q?I8kfYixa3sGu0/lkuz347bhbnI5e5XKpy0P0IRdYX0Ot/EM71y5bmnbuKBt0?=
 =?us-ascii?Q?mH4yBSwibXgDRBqqWONTNnRwyfpk9+Q66+URvBjpnGFbTbQdcU2IzkKhOsa4?=
 =?us-ascii?Q?d0+iP+2UYDR/ZSnVabaRcgdM0DYlMDkPJveWG9UzMXwV/qZ7XwrUckJ2OJv8?=
 =?us-ascii?Q?jkm6lznyqKI+SCiZLLpKu3UOUj28ZFEWIsXb3XRgoTCm/IXpvras61cWifrL?=
 =?us-ascii?Q?ozBTAMaXDW7WKbM9HUw4CE1r4fm9vmP+QD8kJ/B8h0SaWp4GzIA5SQgTVz59?=
 =?us-ascii?Q?zMy0SPbYlRaGpIuhDABzKTeq1IvT8oeThFtzc4JBlSiDsPlX0DR5d06bIl6H?=
 =?us-ascii?Q?nUQzIktIzKAiFXjzYe2X2/E+zc81yQ0ZxX2hS0VrmCvhN84eSCCjp4uCTky1?=
 =?us-ascii?Q?HvyoHr5bYvkitnX6Fa87HwxJhEtM5FIw7JND094ObNRTeV+/AkUWBBKlaegQ?=
 =?us-ascii?Q?0fN9IuZRt7OCALcv09TI3OxVHG1JZkldHqFpUJoA73IhYhHxXfjz848mD3OV?=
 =?us-ascii?Q?dwWHUOwB6M1NQYAg6OtYR4YGJLfbwj+8EDWx5daSMkZT6rA+Nzbwq4K/4uqD?=
 =?us-ascii?Q?146ztFMmLlT2X+kB92ThwSTGchkj/QWc22Y1+3e6VPtYYN421uwW+Kckvii0?=
 =?us-ascii?Q?RGKAQtISyQjwjjWvaJtxUgFQv1CPwr7w09kmdyhTe86e6ck5m1y2ysTI4HWe?=
 =?us-ascii?Q?bmqytM03UvkyHO6plYboEJZYmeeMgm7qQfSPCEEwdgj60uxPg2CLEY44h/gu?=
 =?us-ascii?Q?0aZKF4acJJJ4xyBeeVuynYCdiZV/VfgTABwK9zmS4RP9IpjK0Ev+geHqP421?=
 =?us-ascii?Q?w3Pz5oOOQQQkTZELaXtvql+REV3Cc3V3ml7j6OdJXHkQg06eNL2BaXzwDiCH?=
 =?us-ascii?Q?NvxFMuoO9paLqBzKvlsXpzxACm9v9KYEBS2ZYzcTlT8cOdBBC/vj75Z4nuUC?=
 =?us-ascii?Q?4UL5hECI8yXkXFzxitn2/qO7RiCuDgvPglR4Qhp/YTD5BocPBXMo1K8ZkBmQ?=
 =?us-ascii?Q?p0CPmWehs+R8+/WHweHH+r8g/5xvzAQfgCyuamgKasHZ6pVZt7kKuxFpVpeo?=
 =?us-ascii?Q?F/iBs7tlQV8IfSmvJv8JcF5rrnIq4GS40ypUKe09ltdSv1OdtrPDiW/cYICO?=
 =?us-ascii?Q?Fnxt+RMgyaY+l2iSSX9gqD0S+8WexoGrLRqnSZPHVROvppO0rIBsLAaPhqbC?=
 =?us-ascii?Q?Oep8qgCyEaqd17eQuposDm/cEIDFo0nOs71X7buPRDF7aE+es8F5RTimeVxj?=
 =?us-ascii?Q?gyOCqr/FTdHgbcNDzKQkUNQgSzeHunRhuHCUTgx6M3RER0dX3BRLExoSbR7h?=
 =?us-ascii?Q?hZVAki0Gty9E+bi9kRlCoga8JcwDlvXTdkD1DRR2WSN2BQuSc7oeEunu54dj?=
 =?us-ascii?Q?1EBTYj4UPV8WtpOwTjoggkn43AYsNJFwfPykhUGBLeV3Awy3nf1kjDtWTFL0?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tNXZxPm/afG7dxxOhTt/9LcBjnxEpaRzwCUXg3OqTurmpIneuP72S8BFZJndKSchRirQh8OhdhXEayToi+mABjhMrR6OS4Y/3DInYXcUME8Ws7RCosE4aUzsBUN1DBO/i6Y2H8grSyxjwhpy0LjvM1s4PHPvtgOTT/907L7b8wVakOH/+4FakryoTeXZpxZpQ1nrSkljjNAhtCKyelbZkY99t+BL0O9jZ9hwFuiEPmUQ1f3NXacQ0NMuYu8uD8ypnD3Y2uiCV97Yn2rBEvf9LGjKnqUV9UxvJrjer6iW6++Oa04TXVe9P5Aj6BVncF36K4S43PCCLQuc6snQL6loPEQQbzNtgjRHCzpCeD70kAh8IOoFy2xtmWIZewT6WPkN3dii13ayEjEUQrY+LjIMecdhkDfE3wpS2cp+y/LpMHrt6ylK5qK3eJPF6QuuihKucQgYA+1YRfbXg9D0KkpDVjXbO685DDadgImH3aoPGdXD6RLCC1dp+ZxITQheY70WrsNwd4OsCWeMClKrSLdIsC80OBLbueH/n3BBciBBiyyf2uqZA6u6vTzgwKonHdE1w85DuO8zi4+RC+C7ktqsD1ed2V2y0uTjL6WupTvLELMgpMoR3NbTo+qwZgUws+5YA3GkYET8otkSsQe5DfD30vzoe8cj6cE/LlrmVEtRHJD3TWnPDeH+sSxTJriC0qkOXb2RlXaxxEMOUNLKhG407GA8wWxTZNCEJxyUOxSA2IGsPD/JYH/vee0l6aXENFIXzQfeY2q99B3NWBVMQftISOtEDFH+LC/HZi+U5L7ymfz+PptXTvc1462koG9ONhNpFLznKkZq+MWLy38caqrPORJc/HfYT7wK0SIL3IKOfHR+p2jJTPCOYqmg6ZKif0vAKh+Bfy2josC9Mxy5xLfppA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462413e4-f6dd-42f7-b5ee-08db5315d232
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:22:18.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ileCfKIINk0eFWRnUh8UEwuF18v8CMAFubTGYriM3YyXpUt/ajnoUTUPeholG8IjHh+6z8mZpaRkmmDdiFX7sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: 9Yd9B89UlJPiXkQ37-0q0ahAYFm9MIPb
X-Proofpoint-ORIG-GUID: 9Yd9B89UlJPiXkQ37-0q0ahAYFm9MIPb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the iterator has moved to the previous entry, then step forward one
range, back to the gap.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1602c854133a4..71733953ff836 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2636,6 +2636,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 cannot_expand:
+	if (prev)
+		vma_iter_next_range(&vmi);
+
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
-- 
2.39.2

