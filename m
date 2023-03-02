Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23AF6A8CBC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCBXMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCBXMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:12:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4C948E1A;
        Thu,  2 Mar 2023 15:12:17 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6gWA024770;
        Thu, 2 Mar 2023 21:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=KVGAuLX9TKuu0tg2KJbjB/RVarHij0TeyKN+5BsI5eI=;
 b=ya7KGzNILMyAo0qM8NBy7Kzhcar4RuejSzXQemufanLtsWqIVgAHaJHrmP8KUoY65BCj
 0zSR9x84cB6x98KIidVzQKxF81xwZ1C3vFGriOUvMi/rKBDnZ5cypnw8rrCD9NtLRQEo
 FsaoNRxk8HMbN0hhFsHRTOd1ShcIzkYllozJoXc2jnx3L28lXWDUVLQ1ccUFeluaXT4D
 rlWppopMUnzJOL1OSFJrxOBfLkyVX44nCFkCwCPJxc7q2sWwakmgW4RRcdTUx1Lc+P65
 VF/UQa7x4bOSev1gO565MtaSZXrRfP1vsBPw+p1U+XVmegoBeHDUagv5YO52PVTaA98k dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybb2n23n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322Kh3IM000608;
        Thu, 2 Mar 2023 21:18:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8samf6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+0/3lFOtYzy2l9ETwqYCHhRtA8G2oYjVSJpe0sWlfnlftVRk4eJvBCPl6ZILVJ+zI1NfGjTW8lqq6n7uAoHdqDciaSklzpEhWl6Oqk4D/FbCdzSNw2OHOVcTaYyQkfY+Dyrm9+RooKiTUmEKZQviT6uI1BvXWzE5yeE8Zf3xkGXM0XtCskOxEqJAru/RioW/HbXR3zNCogMP0KGpMRWQ6ADsYYHpMBml1Keipb9+H22visnk1vF0maskJVmxg6cYgSEyEv1oNJHE1V+45zEqsr/PslhlHfUPMLDOtxw2SCWszt8mdcpbH4H0P2hCuQU0lHRXmhPrTjCmZqZmxYIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVGAuLX9TKuu0tg2KJbjB/RVarHij0TeyKN+5BsI5eI=;
 b=Mb2qOgHDc5F31WOH9fwf6roNI/rIxSsbnTkVuKwYuAIEb/nO9YLy3k1n7JUUsq4/sx52Rcvnk18iJnVhsjKJJG4EHDygKb3K8QVS9QjF1gZ6DOk7vOJil/MheSqWCJAcCzviLpfeIfRSyIY+MEWlWdVLOa0hBSUhDwCE+kYA9dSrDvedrhvwe98RCFviQ7U6A75Ximc96PIzVxURFpM6T8XxK8iy6ijw+f/djnTg2K8zPn999+SEa9DmfI19x6U5/myjhxFlv3XlBUK+7yU4dme9OSlOlyERlDwKsAMgMWwT0bmlVVUCZysnsnn6J3jfcEL4aDqtV6JVo6lX2sy/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVGAuLX9TKuu0tg2KJbjB/RVarHij0TeyKN+5BsI5eI=;
 b=qasQVyC4iGBQOMnM+4wD15LBhi2l1Y2m2d7zCRFMvB07rhldB+8/QbpJZGxX7XMYJF2IaENC5+I8IClCaMCaCDPn/K1/lkGdpAH5GjQGYoY1LhiP53BaOZbYktn4bvy9tFkc4G7Kc8ST2Jgj7DOYGHJK3nuIxulpBDpUhr426ZY=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:18:44 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:18:44 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: [PATCH 07/17] btree: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:49 +0000
Message-Id: <20230302211759.30135-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0198.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::18) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: eefe2de2-374d-4e6b-53cf-08db1b63b447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kF5D3VdGFEBtxOPlHvah39EKtHzGDMY0jJ4HOiIheHXJ/7QY7TrLrMRoe7Q8lAOWsdyRceYYmRQbuPK+0bcvkI2Ws9XHb2KJb6vpDdLrGK9uFJKBgLLoljJt5kfl3CC1wMvUynX1UQ72/JT56LuaZ5bRYFFTt79BsdbfIHFWl7yTkzKsLb8ZJf8QcDEZYdYNNDTxr2BLHhncvrj47Nmfa+DfPb2Ou7zv+u2YrNq9opK0pKtZJi2J0RRv1dS5UTbCv6YNM2K7Ez8T4EDE3oE6UpdRAtsI0lPdXXxFrfbCuEKmdnudm3kJgkC8c45vA8NPBz0fp4o0PnK8LXVqxybyI0Q9hjuAkLQRRDHH/Mru1Bk9MbUjL70sxxH0LuPW396QnZXtTNF28xWXxb1foD/hdFw8f1UzeMKdKgjSNjACRtKgK4DiCqh3TFHDPhsIv3Phuzd373lKRZjTGWZ2X1vdZdvX6OswWdhVJR9McQ0K3KgLbhhjAdVLHOUqRls5cdp3gTNVwgqYb2MG8cUVnbflCqsV17XF/zyBJssI9WdgtuEhwOb49SdrqKc5LWYwVgnD2DYh04Y0kLTHi4Q8SREObC5GVjWvw8NtARV0+Oev0gK+kaVQe4bqmO0BMUFasQMBxNZ/IBk73uBdwE9pfglhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(5660300002)(44832011)(83380400001)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(38100700002)(36756003)(2906002)(6486002)(478600001)(86362001)(6506007)(186003)(6512007)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vnv+0VamnbEcsk0Nc6lnvaqXcLiH4qRUZKvDByxhMNzyIReePAsX0xY7ndPs?=
 =?us-ascii?Q?vmBHuwYYJ0v/7fC5FwWXhdX+wRu+FJSDlWEKnnKG8eXgmd9A9YPlUE38AyfH?=
 =?us-ascii?Q?IKx/9jeiE3XDah/TAj5zQnj7bT0enJiJ5YZPeW5Yjk0wDpach5h85203lRnx?=
 =?us-ascii?Q?EBP4gEXlu5K/LmMJ/pKAfC7uJI6JGssGfSNaBR9yiV5qb15u5lxUtyy8vJhR?=
 =?us-ascii?Q?XfYI5WxdF20rQfrH5PckgcXbkqrWinS/Z4fgGsamPc4UMaWMmfBbWcjoaJ5g?=
 =?us-ascii?Q?Lc1kk9QEMQkWsopHZvUrHs3acF562SH5bXaBzqLFqJgflinURzO3G924u0QX?=
 =?us-ascii?Q?+pqU8DRIegXnvnmF20Gr2ItDc35hji/rBclreCkSRAPirszJ5AAw52XXDH8U?=
 =?us-ascii?Q?/6L1vaEBiTXfcHn3NYEl1Cb5voxLGCdLhSlyyNOX2I+1g2p2QS9xHytuoMl4?=
 =?us-ascii?Q?YE9snHI3grpX3PsuAKWmVuKeegYaLBQiFVC9jQ2u3oz6FbYDPlNlZZJuNdZt?=
 =?us-ascii?Q?BELdzKOeNhVEmU5PaGjyzL/MNd8m6W2mHMWJMceFv/RjOjxPX2yesJO5Cayv?=
 =?us-ascii?Q?1d0rIw8J6+LpAZ/0aZuNZEPQtOwoLtz1ri6W50PntqePiGa/+RIZlkOFZA+F?=
 =?us-ascii?Q?ekn8MqIpmDdQVBAh7tC4rOWjY05CMCS+bssHmt1zBdLWVipvgRsnFxeVjTyW?=
 =?us-ascii?Q?2Dxdh6NB6NKWXiNMtHODuXBWJRwIcefS71rN7ZatUIyQlC0VSMtq3ZAyYfAU?=
 =?us-ascii?Q?Kh58j/zgfWtR+Mwc78l9X8qNtHQlapAWt/Plkh/wwQxXtiTe7vaV/08hcqZe?=
 =?us-ascii?Q?kzOCyREKhmzbjfS804Um85Q6iiSM3/7Ws7G5k7PQf5GLAPK4WyMrJzNQVO44?=
 =?us-ascii?Q?ER+431DlvQeYwjXKScYu6d49+Qe9jGdkC8rquOLUcCXKU+jfW1cEmwxXPw7H?=
 =?us-ascii?Q?guLmD0X6ly7muV8uiFzu+aZksz4DXTjafGcxpc/nh40qAr+ClaIgyscXvh64?=
 =?us-ascii?Q?flNsBEYrj9FZvm6wPwOzzA/AU6M3Ua76Wsd1slkLeyPgC1DN5LVxjegjFiqf?=
 =?us-ascii?Q?qF/UMean947skS0qo/zvnyGqVeUiCKZakOgy1yVWkNkTFN71zVkD1UFtlAP6?=
 =?us-ascii?Q?RM97PkQPd5D1HR+//JTIqzqJCfDnNb1bVvXJ1O6KgQTSomORqfkvl9laFIEz?=
 =?us-ascii?Q?KwOxsmIjtOBRd2qUzyW3a8kYDoo3bkOTNc4wr+TM0h6XanKsk9G4J1Q15z6A?=
 =?us-ascii?Q?k+FRwu2r6XQ9fiZxD2NiRJPctsvhOacJZL50vcMcl1ym0h9dPv65Hbn2OSoM?=
 =?us-ascii?Q?YA5ZxnAT6uh/pEuEdR8q0/czlDL3NdqXbA8jfGo9MV6oI8yCMQlrFH6ZFGhI?=
 =?us-ascii?Q?jb7DXwVUmFPgTMfZqw9jRSd4JIqghLkgeLqzNNu+R+XJV9YA02N7AKEsGINi?=
 =?us-ascii?Q?48flIjdQKaWHaIXCJINDem0nq2vMy/VJHXH+56v+UgdEAQGoXp7sbGA6ppO3?=
 =?us-ascii?Q?kcR2Ja3m4M3HR6QHFQpuy7XwKkW/3QHxCWw3pYzD5GnoIyncv9m6+34sZ7R1?=
 =?us-ascii?Q?eAIaJQHkVJzlNEuNjSo9HMBWW83xJld/6ibXi3O5cplFcL3Xbd6KtFK4sWhb?=
 =?us-ascii?Q?US4/v5BKJz4VSsAuo3P6CdE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lPoZGQbl4HJWlHW8esdC7171yAj9Pl4GWiJOVS3p1JABXjy4Ljhv+8P/2dhsnQSRpDFtjLTd0JCtjRWADAvkmNbF5JOL0AUC4QmS5qCIG079QHSWhPzOcmr7GNpYlvAz4pDYyvewBpSsjND/FxSq+nM1RcLVLyDuOR2/1fd9tpgtodqjd0mTDkRFmJula/Q/EfH5i2NIKnfjEGwCfrDFPPNwxnCQgtkWxY8Ic5XHZYRSgz/YcMDdgxRZNx/11IyFIEc/SoEXB/ocHv+NwtFQsvOQgnhLwndpIX2eS/ELa04+g0F+cU+gPh4c64LLus8+iD1KDZq8twiimZnlQUPWcru5VqcT5CNjxZutkx5jULcG/yVvR60//b21zIbuQ/MN3xJF/I0GfmAn9g0Q6E+LZOm0Vicp83BVAKvi+wB/x6q67VqGAjjl2xNEWtoSbvrr81foxlYXP/AA7eoaz9MA3HETJ4X2Un8KRr0t7PURbPz0XIMkVz9biWlsW6m04qn4agr6AgB4ZGl5iexPgChe6vey8S1hMROw/FxMIED9amRAeO4PQt2qLK7F6U64JgZHUg+Ov+baSGMeyX3urj+PEt39UfXt2IrICLa0io3zcOqeNNMeb385NRAOFcw5ZVFkv1KYpwLMQo0/YVC55z6dWBjUbzuODOuSfTT6/f5th897Um0zH7y5FbLPSnWdKWPN0T/mv+/rf025g71UeN77C7Q54KUvHBDNHJQjT/bJR+NCnPiDt56H630p9ieDOOtgu9TEy7CO8T4Bce35N4D6mhri2R5CxAG908CkgIP9Rbda7EZJLT/pmwvqAUjoasYp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefe2de2-374d-4e6b-53cf-08db1b63b447
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:18:44.4280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8vb0kxKoEZjgMUhTsKWME+lqq+u2iSUYpgKRIU/wsUX1RW47y4mtLD49acRDD51vvv62G7yLaowwaXfpvdgRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020183
X-Proofpoint-GUID: 6P_vmyy23tnDEFKcEJLtoe5R0A8eaWYZ
X-Proofpoint-ORIG-GUID: 6P_vmyy23tnDEFKcEJLtoe5R0A8eaWYZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
---
 lib/btree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/btree.c b/lib/btree.c
index a82100c73b559..49420cae3a833 100644
--- a/lib/btree.c
+++ b/lib/btree.c
@@ -794,4 +794,3 @@ module_exit(btree_module_exit);
 
 MODULE_AUTHOR("Joern Engel <joern@logfs.org>");
 MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

