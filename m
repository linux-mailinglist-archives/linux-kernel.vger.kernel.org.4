Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CCB716DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjE3Tko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjE3Tkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:40:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F4CE8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:40:38 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UJLxUY021706;
        Tue, 30 May 2023 19:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=KTVZNDKD326ut2TnMMYnyBizEHBrnTbV8E2qMCf8Cjk=;
 b=dLYX5DaOX0L5VdE6BPJi+PU09h4RqBOOffISedbZgxQebr3ZuHncU7Nk/GNo8nBWn4vI
 zUvYYky93M4N9LeR2NTjvdwAyDC3ohSJIBYsXeATBEs5bH+WauEL1fLR6R1l3Thmmjvy
 451BWIaDchuGnTV6JZwKVjF8/8k/rMZ2ixA046q4efjpON7hwvszn4M0vQoZiXIuKW4w
 JYg7vWfiAYJg87Fa8+H7wrTIE/BrnmSAXN1jgmgCrgjnDGIKaXnGVovUmYCtp1YpNk5H
 AZ991AWR2SoKvGedlRoEdB87BVsdn7zV1TZZfZbnCAI6KwcMPJPeJdvthjwiG1lI26TF Rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh3qnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 19:40:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34UJ69Sm003695;
        Tue, 30 May 2023 19:40:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ybyrdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 19:40:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUXkYM2FZS6HrUIhFg9p/3EqWoCOBuplEcbhncaUMT5dnGHCPhzQaw9n9JbE+fOVwUHfTlLxFsIvsm22RJUxh5bt15WuNyzu/kz9SjWaGS2G72+73Gg93W6YpJv599BmuPgqYCCfKIQmAyRHGSuYPxTOgzr9DEbtnbVZQdLYJ7aBAhotySwmQ+4CXT9WxsgXIthJ3B309Kh6lohh+qdtyGizw5IumvNCCKLMN/A9JXoubGRzxAm+pYR0rEoIDBwESRs8oIEKUaOiUiiOdoNWk0+kwzKrTfW2DSgU7/zmwKTu0CRZ3veDAWAsYsCyeu+bsRlJynjg4bo3sCItIDKGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTVZNDKD326ut2TnMMYnyBizEHBrnTbV8E2qMCf8Cjk=;
 b=iLnob6QC6Udmsyl2zw/TLesT6BngOyNBO6/ectGj3i8wq5P9p7ame4CIBqTwrwGvrSXS08IPgpasr0AYbJunOSOcVfYZ+Bgxl662EJJ6g1R46Q5mahZppjXNbizqG7r2a+0FOvV5PAsRfq319E9SI4k0GIxLjtnAQZ+ldRJnh/h3WfRT+Zgewduv6NbSEEcOMj7URPc7RUIzdOK1s5ja/8ZgqYIm2TuyjspWecE9k1dUHMpdbWL+Tke4jNvjMgozB+6RHavA7U2hcxur/FeLz2dpSRHGHSGGisDWOW0cElXEq0n8DfVUFjWEVSeFLu/ChKyzDZ9diepMs1KjXuV3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTVZNDKD326ut2TnMMYnyBizEHBrnTbV8E2qMCf8Cjk=;
 b=M8l9HO4HOkk8EMnjBR3DKtMAidhhHBFoxInt21qxmkwXdB4ebsmlWMUq7X99LLpYwt2uVOB6JGUbGYZq390uoDvAS7nTlxe9iCOTyFpVG49B1W7rFHYfZcG5GNm0EVmj6StyhqK6WsmIV8c6MzBmHMz4ZbLrpyUtBBGiBXUKZQI=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by CY5PR10MB6214.namprd10.prod.outlook.com (2603:10b6:930:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 19:40:30 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3%2]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 19:40:30 +0000
From:   chris hyser <chris.hyser@oracle.com>
To:     chris.hyser@oracle.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/4] debugfs: return EINVAL if write to unsigned simple files exceed storage.
Date:   Tue, 30 May 2023 15:40:09 -0400
Message-Id: <20230530194012.44411-2-chris.hyser@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230530194012.44411-1-chris.hyser@oracle.com>
References: <20230530194012.44411-1-chris.hyser@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::29) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|CY5PR10MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e63dd7b-2f66-4e7e-7f9f-08db6145b9ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hxk0UAThCy3N/SO/Bi9Pl6b7GaVw5ghe7crhs6m6u77veCEY9yxXtH9S4vE4gFritu3LM7Anz21b4hAh+xcBT00A68eLV3ozF4ZfZTsjvTFR+dfrbIck7w1zzRBlkpyHlxSyOi7/N5cbAomLYwbeLMXYms6IOPYWqDdXSUv3NQ07kI7ZFwpak6P9D7lxQxAkQSPlzw55uWi2PwWMIcLt5LpyuR80qHc6o/KohViCeM2VO90CZMvrgA7rlDB+HR7L0sKe458ICFsdGyQqNFRaksNbkML0S1h2z0S+GcrfXVeXD1XSfHK++hPg2IvGfhiRheLKaVeM/YYUhtB4mR5ITl7P/TeGdukTZkwxVLCKE1Jn9v8opfHjVspMyNom1LBs2G+F3QRBjv8HNfaFn0OVWishNmCOFtlv26s90wM+iWC3epGx3EQgDSTr608XBEDIsoFjMnKf7JbBmMbYbvCgxKd0bqhY+FserKtos5wf2ESWnFweZ2IUfSsC+V5NcJ1VehIwMidVGvEjms2mgDK0RsJI9YGypy6U4/YC24bUvNO4Mw7GHMLDHkmJOG/zt548
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(478600001)(8676002)(8936002)(5660300002)(6916009)(36756003)(2906002)(86362001)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(6512007)(26005)(1076003)(6506007)(6486002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/UtIxtnNRf/QcL92mD0bDAA8sYGGSeAN8qWJ6KRCe66eoA1DGzlI9pHjXk94?=
 =?us-ascii?Q?fkvf15NccpZJb0rGvL2MB+qbQGtMMAYblVltv7xpZbvGWmJI2eAE7SCte4sU?=
 =?us-ascii?Q?h/d6xxZi0ZMmoRscywVq0kI04o5lDtzp2/QAuW67IDGZbwxLuQ4fR4yxjRg6?=
 =?us-ascii?Q?ivCehKHun03bVs8Tir5sj1d6SEvti5GfrUZ2anHZUMO2Rr0gB3nV4uDIpRCh?=
 =?us-ascii?Q?og0/tPJe/6qbIlEZlxDb+FCkJY+QdOgeoViGpJIbSxGTc/AoUDVs5H/WN71g?=
 =?us-ascii?Q?Rym/QyESAl0m/t0CRbH+Iy+NzvZAfPGmCX4SRKonqsfRBqRolplC2s/caC+k?=
 =?us-ascii?Q?Ju45oVUnmKmCH5ndX9Mz0rF7Gx+7mgMHc/qI/uWAl3jkFEYVBbqfchOVgYt1?=
 =?us-ascii?Q?CMW6TRVbwy2P4LoxsM+wZDuGbLQ/poT8veUP/Ee/OtVpjC4JET4m8UeR2V0f?=
 =?us-ascii?Q?U7ri+RDcbQa6nbEYHAiqQINyS4WmM4sUvFbO56i7wpT3kwYyrda5SS20vr9f?=
 =?us-ascii?Q?91KRJFhOo9iX7atGCuou/zm5aRpxI+l8jFbZt2N9HSJgNS21wBkHi7iSsX+9?=
 =?us-ascii?Q?2CO/TeJIuPOr1mrF4FptbVzTnxL5ug5nwjtRc93poGxykW4W02wijGQrP9J7?=
 =?us-ascii?Q?Mg8xSxCGIZJlfjOiyh+hjOrpc6qIgp54hGX+zXQlduHFXSJE9pswJ3yxCwKk?=
 =?us-ascii?Q?JtKA5Kdv+MHcnUEFacDbIknIUe7jl+79I/Xv3ytsRz/oGEOqyp5sANe4qMik?=
 =?us-ascii?Q?lwiZdhayOvp20zGjbZv7YSkr6umI6KJogIdEcWgL6DmefvyPs5TLxSivaEwK?=
 =?us-ascii?Q?22nCENB2amnAXd938+5DghilBUxeuHB2d9bPfofkRqqGkHDFoTUE+RWggGvV?=
 =?us-ascii?Q?7yntwScAWjqn1t+q68riuC6L9x4U4Bdc895SpMZujlDpjsuJHYfglgw15DAg?=
 =?us-ascii?Q?VLO9T4XBWla4du8a0T3nxShJVlsHsPuBW3RHWPPjFjO5KxnNBNrvclIFBDZ+?=
 =?us-ascii?Q?9EA1S4k3DzrLXyroMGV5sU0yv99Fkb133ef7MPb3OnplBCxPyt+vvkaLbxek?=
 =?us-ascii?Q?FV1y6qU2/NmjpO06e1eAyFYhPUfP5LdMcj1MEYrweHS7RUuVtQHJxufkcHRs?=
 =?us-ascii?Q?+AmRuFaEK3HbWoqYqp5BLEzfLhHSTcTCi52maj/YS28JhKTlG29ehhjoh8g6?=
 =?us-ascii?Q?QAeUFa3JEbYc4OIEQvEF+2xpZftdo/uAvV46cyTrv0ayifkxBEw7dzfayFqf?=
 =?us-ascii?Q?g9dCxU9Jn4NzUsCdmq95RdTbpuly7my6DUAXSasIghoXSsluqxPI2Iw2i7/Q?=
 =?us-ascii?Q?no6IKRcE8kNz08THazvHvKbT18OiFadFqgX/FT1v7i+B1vQW7AB0Iu5658te?=
 =?us-ascii?Q?zLhnuKd4OJnRrElyPL0//pHuKs9HOWXiCJN/5+qmrBLbjy+ucuxjzJARxZGH?=
 =?us-ascii?Q?7TLqB086NHen4kSpTWn/yaSytvq4CRHdNC6YdlqttmfOImCmhT18yVJjaAOT?=
 =?us-ascii?Q?KxRcqH44r+3Llq/QmDf7n32zZpuvMLZ8sJFZ8iz1b+JPC93QQN+jfz9HMSwE?=
 =?us-ascii?Q?22JV0IcmgrN96Qwh1SDwiaBkiP4ZrXgvFAO5lgQk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ss2y6p5HUW0f/R7SYCV8QA1br+jbUMQrcDeWuDSVf2qGdCWtxJ1Tk8Z/izUmGo7gSnbT6kOT24gABL+T4PdCrvfD/Hg91Aq5n2Cfsm1eeHsjltPsrY4cJ2rz+p1XzHDYDdhJOLYnXXrdxxjVh4Waiq7nlCyA+72pwsgZiMO6qLxJ1+0KcBE2iZh9wA1mdeIYeIWezqdpACvMdhPmNrZ1joTihd3J/SNZPfcp/bUREdhFlFtLTCvj721g9b8X11iB9HSpKxwqFXcfCDzYrTH2vlZX5v33HERZgya1P+OeNGD7cdY1WHw09mNlguERDaT/N4kR4ckR05AbRMCmIEYyk52QZSRcvbls78izhv7EAyjgRAOE1Epav+CF+w221xtAKhadsgtoah1C+2J65YTteES5XCMI4vg6A4bwqn0mRt8Y4pHHwb2UGbpGQMQ9zKrE6XXf36DerGvhpwFfyu9uyoHrMx33JB1BtKp/wBBdxO3/WCH3NSx/NXdweHaKOaZYoZOgDiKsmC2dxuzc7BBmEm9ldQNBrBQnUVdL1FIt40KUdMfW3uVogJxsXqD3/JxnP4F+UhjO6CWsN03qXqA7gHViXClODbNNSifba2pPO0IKlBPDeWNlleAE2lovHq0BBHdnjaooID/3Gi23u7HrN/IRLqdyqRZ4Z/7MCnnlv2donD3R+6bJzDODYnyxAqX66KAwr+GkrXv8hM3wic1bqj4mSBdmoijsy+5V+xKoU7RiISkPQiNMPSexyctf8lPRVkdKbw+8A+U5rp66I41YAF4pdHlGjAGWSs+vWpz2UJq7fbJWV6hFrJf4bqx+EmZxEq11r+5javl0zTfZmOLBfw+x1UeAAGP3yU7LbarUYWAgaz7Fra5umBdwcwYSo73V
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e63dd7b-2f66-4e7e-7f9f-08db6145b9ba
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 19:40:30.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vc7Y2KrR1ryH3r96Iy8CS0a0UIYoUHT0DxoGmaR+ZXvGaZqNmyLSpM1eESRlnBPe5+QdPiwVegeiKp7yl/CEaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_15,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300159
X-Proofpoint-GUID: 2a0_VyNLEvLDnDs6A1dJRDvQPPO553oY
X-Proofpoint-ORIG-GUID: 2a0_VyNLEvLDnDs6A1dJRDvQPPO553oY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writes to the debug files created by "debugfs_create_*" (u8/u16/u32/u64),
(x8/x16/x32/x64) should not silently succeed if the value exceeds the
storage space for the type and upper written bits are lost. Absent an
error, a read should return the last written value.  Current behaviour is
to down cast the storage type thus losing upper bits (thus u64/x64
files are unaffected).

This patch ensures the written value fits into the specified storage space
returning EINVAL on error.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
---
 Documentation/filesystems/debugfs.rst | 7 ++++---
 fs/debugfs/file.c                     | 6 ++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
index dc35da8b8792..6f1ac8d7f108 100644
--- a/Documentation/filesystems/debugfs.rst
+++ b/Documentation/filesystems/debugfs.rst
@@ -85,9 +85,10 @@ created with any of::
 			    struct dentry *parent, u64 *value);
 
 These files support both reading and writing the given value; if a specific
-file should not be written to, simply set the mode bits accordingly.  The
-values in these files are in decimal; if hexadecimal is more appropriate,
-the following functions can be used instead::
+file should not be written to, simply set the mode bits accordingly.  Written
+values that exceed the storage for the type return EINVAL. The values in these
+files are in decimal; if hexadecimal is more appropriate, the following
+functions can be used instead::
 
     void debugfs_create_x8(const char *name, umode_t mode,
 			   struct dentry *parent, u8 *value);
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1f971c880dde..743ddd04f8d8 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -429,6 +429,8 @@ static struct dentry *debugfs_create_mode_unsafe(const char *name, umode_t mode,
 
 static int debugfs_u8_set(void *data, u64 val)
 {
+	if (val > (1 << sizeof(u8) * 8) - 1)
+		return -EINVAL;
 	*(u8 *)data = val;
 	return 0;
 }
@@ -465,6 +467,8 @@ EXPORT_SYMBOL_GPL(debugfs_create_u8);
 
 static int debugfs_u16_set(void *data, u64 val)
 {
+	if (val > (1 << sizeof(u16) * 8) - 1)
+		return -EINVAL;
 	*(u16 *)data = val;
 	return 0;
 }
@@ -501,6 +505,8 @@ EXPORT_SYMBOL_GPL(debugfs_create_u16);
 
 static int debugfs_u32_set(void *data, u64 val)
 {
+	if (val > (1ull << sizeof(u32) * 8) - 1)
+		return -EINVAL;
 	*(u32 *)data = val;
 	return 0;
 }
-- 
2.31.1

