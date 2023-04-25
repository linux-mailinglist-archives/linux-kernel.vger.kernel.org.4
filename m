Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886A46EE3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjDYONe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjDYONS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:13:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D193C15
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:12:35 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDic35005263;
        Tue, 25 Apr 2023 14:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=a7fPAWEOduXYw/G/3/MYPCdJRMwWOwltmUWi9khAMRY=;
 b=jiVMh+JOS98b9e1hjX665z3BTuuupH3/SAC6IsZ2/SFXg4qatGhbVzYYokJwbKMvn+8w
 iHp88U7I+mWVkPjPkEnleXmOUEzFwNdVaprWyfvw2nzt8k+wSJ3xr+eQgTzz2YebiAgx
 XQBk5ZIGNW5j3tyxhd3EqXbOKxQSwFvzShnhWlMn3eAXZKhhPMUN3wAi5TpMO+pn1BXx
 altKjklC/nm/XBSJs7arAFjkg23bw9M2wzxyUC/dY1QFk5T4UI60JkaOUiyvmaHd6cp3
 wYjUcl1aR4TH+AZLroNg8w1Pb4pxNt6d8ucvEq6iNCvmI8JjALd3FekHHQ5NTu4r+luJ eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbng9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDo5Zr025221;
        Tue, 25 Apr 2023 14:11:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461crcpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9cayGSwC5rx6BGOUach/bIZRejNbWmD1R1aNfK8vtIyXSaBuYQCGyuBCra+enCvx9sDOle4hvY65mUofRa5Ejzq1K+CohNKFwPUDC3xAXTW9p3+IdQavixtbfToPuluMcthA1/PWSuLhSWudtHTSlW9yxsvnhSMITji74c/i88r2WuXacNFjtUGtmiAwzv4uHdQjHLUbKyvojGV/h8v8GHpo/IqeOxM7AmEqs5W/L5Rvk8gU6y0IZ++yijIQjqOl0ufuVtexXTcrYWHM4nA+Nt3V5gnuHGIuE0TiHCvq3dRX0d2Mp+nh+QsSDrPHnu6qAG+aYnjkMCABNHThRnpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7fPAWEOduXYw/G/3/MYPCdJRMwWOwltmUWi9khAMRY=;
 b=IBxR93cpwr+sIfROqb7OfVCEgL4dhgZW+XBZM+l6o8yFMkAEuDIF1v6vYfnAm9eSv+UF1ZpNUt07ke8NUwTs1vD6GFHj3BAuHYzika2kO6Dws0Doq2LQ74VuG2vkdbjyx8VH1wFZ2JLo539Zd6o2UT7yT/x0omcXfElVhRukWvq9bBgwtfdU6skJh69IZ0KFXuAb2LCSWQDH5b38O6vUPcjKkXCpAQyB5lSUQI5OtPi8maKuUlOjxPKibvMK0zjyxHYQIpSlWKQMPWV9pFsqRnpFmIhIvM8O81LLNI86qj9ZoJFtncQwit4KXNF89HWmeit4N4FYXIJl8e2yb+wTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7fPAWEOduXYw/G/3/MYPCdJRMwWOwltmUWi9khAMRY=;
 b=itWB01lFw1awA4HXqZZQ+abmL9supCCVUkB6dFp6q6qXnvpsFldv6uC+9SOebkqpuLRMcvavARmM/uxxbDcpiUE4aoVfB/gdPH3CyYoMMMqxCj/73DnnwylbY89T/x63lFM0wbWyS9JTU+4xCCeSVf5q4vaWD7rBssj7cLWDe6s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:11:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:12 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 22/34] mm/mmap: Change do_vmi_align_munmap() for maple tree iterator changes
Date:   Tue, 25 Apr 2023 10:09:43 -0400
Message-Id: <20230425140955.3834476-23-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::35) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb3e998-a05b-4a26-b99c-08db4596ecfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WS/KgJGFa4g9iZTMqP4Jpyzt6sIZOreNfrnwGsoO/qHwd8tF9SCy6h7d4Arh24wgkuWiuB4kHiKe4+MfDyCYqwUZK0cAqFhHSn3UOh6U6ogGRY3Rupqm7xTRM3EIRzeQO4IXb8y/ZHV2yaOnhChhT6a+ucIaQUn4TnDw++fr9I0jEPpaCl2Tv5rQANMJmnlxyi1TZqVwPnG69fonNJ55NocVxJ8cquB5bn0iOfDs8zN9XaI4H/tHgS7OqBDkPe8l4JbZEUeQZOoFCWTVJ3W6V0MsHO1MYv2gcwhsx0WmGfKsHdttjLvsfG0ogQum5BIZzaOK0A4IyU5LoaLvru721OeivJ6zoTbmeBeQzJ56lwakKYrGsrk08GrGoeV4yhbxwvvwTp/f59vPlM70MdLCX3hG0yNVWunt702elT6xXBAshI/zM+FoDCgn4vEQbvA6hLG+j5H47X3fdK2dA9H526rEF2opX0fEaj+daFw9WVwOEgPJEY3jR486SUs9EXkhxptckZNKJpdAsVCfKFJGXbwERpWhl8bn0l7wDE51jFNGV5sSfWha/d5RyaZ6Bv/3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(86362001)(36756003)(107886003)(186003)(6486002)(26005)(1076003)(6512007)(6506007)(4326008)(6916009)(66556008)(316002)(6666004)(66476007)(66946007)(83380400001)(2906002)(4744005)(38100700002)(8676002)(41300700001)(5660300002)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4C3SLf9ad9Xq3Bq2R5PS0e+ln4hx7TObIVVktpClJmrlrcyhrAkfYDexvmDf?=
 =?us-ascii?Q?VtMvl7GLJOjU5WcMdui06CXR4mR2/SCPPXQsvfEFM9HqOpArqHYiTLkkuorb?=
 =?us-ascii?Q?ng0djiCQK7QbD5jyrEUs5ApEjSjz8CqUMQah/LtuX4Z/n1xJyhECktEbrBls?=
 =?us-ascii?Q?Rwwc8ahYbGfXQ/zfggairBGgHeiQR6pF+l0zkMKpBVtejC8R/RJuHvW3NbFe?=
 =?us-ascii?Q?rR7PHm5A7DiQ7dT3/Np4HkVPb2jjmR3OloePW0kOUmD96rk9Zq8lFpNs5/Ol?=
 =?us-ascii?Q?4KwFludoNy009YuYJsstJPDgOjil+GIc84uiVPR7C9295kgy9afPmJeDUqzB?=
 =?us-ascii?Q?7uNo7tftzP7iVEobrAocxSarpGrQXLN267FPxj3L2/D4MAPXZQfnuhxRzXY5?=
 =?us-ascii?Q?K2bttwtpIFPK83QPn8l1gx/aWx0OZ5uQMEOemXxzVHr/ZOLDn6w0BuhyD9Fz?=
 =?us-ascii?Q?HJ/++ae9KXtlXrO/7yc4TPqfAwg3puDYepGT7o03UkcrUOy/263Nc4ycDn6v?=
 =?us-ascii?Q?Q6mGREBTu4B6b9NojDml7QfTbRs6g7D87eIAY2r1doN5xQeodLAnss083QfJ?=
 =?us-ascii?Q?Yn2N9JH/HcRujLbALkASOJ0Zn95SmJ9aHS8ENmWAEG2iBE1HrWeVwVQIsxWH?=
 =?us-ascii?Q?WVvwqW0ryl/vS0jNUB++Pm8xgprdQz270NyYtliCLX2nyXMGm8dkQVbHakdH?=
 =?us-ascii?Q?NKK95Eqy5qKiO0Fta6Hd81+CUvqCKZF2F3S6D0TyIDdErZra1iIqwr9/Eo5X?=
 =?us-ascii?Q?T48B6XtQT/ExUKe7xWq3PZhUtnCpOeUuvvZC26TGrOImj4JOwezss0F8VXaO?=
 =?us-ascii?Q?M5vszBF0gGbW0ZfoUnK9buZn7fhpgT9ZJDvki9Ee64+A5r+kBnTuwEwfeAcY?=
 =?us-ascii?Q?fVbgLEZNdcBO/GWJILo0i1XpVCIdc1ji+U5+NruWSNrf9UI/kd6kneBV+Oxw?=
 =?us-ascii?Q?ZbNykSNglasFLyNC09lJaBTDOFKYH4X8r5bjUivtsUgTo/5gwzqqRf1Yjv0H?=
 =?us-ascii?Q?1mToNNj0aoLUYZbGAAzOAYJFM4YoMtU+TCrXdCaRiLQCQh9szW9145DXjWz4?=
 =?us-ascii?Q?Xb7RaCBUeEkTSPC1TgETFjFSLti7VJI1RrPw++AQkXuOSOeQHNRjIHKGhYKx?=
 =?us-ascii?Q?jxrOP8CqcHs2eZbYQ8ZbAzuQgCnieDIIYt4QGRnNcRFqk5+cKYywAjpNttey?=
 =?us-ascii?Q?QryDAquPOhSnxz7LstXcQGH9q7f2QO2PuNQQ2nWKcFyeSFtQJ7mpZLV7mykl?=
 =?us-ascii?Q?khqXR+t7mkyQGSX4+AWcMBl0gIeLAu5i8q5+cibwNDDLF6LuUqpSvnwQxx84?=
 =?us-ascii?Q?rO4MyJc+QBDcH8iPIOTOM/2o3tr0+4ZIJpidEc6QlRqGeJ36Ej3U+cP/2nDT?=
 =?us-ascii?Q?M0H9H9q/ybyauJlf3rHd5W/Kix8FRFv7tKMX6LMbShFTuNm/LuUE8HGXen8m?=
 =?us-ascii?Q?r8Po2oV7jx9rGTqVJigyA1utiNlNI+krRQusY8txPk2f2ZeiImKCZMr3M3wM?=
 =?us-ascii?Q?x+Eg5sldCq41xXeXf4OicvL2WAk9C9jtHoLCRlhk+lresQYDMY0A+O6V5DMa?=
 =?us-ascii?Q?L5YSSr/6ilVVhuoKfxKP2Kdfptch8GRoqOiaC59nnTiXR4zK0MZQdODbJHO3?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ejWzLphT3T+ClNk9wQs1ovWh0d4/g314EuMqF82NHC37XSknO/Ai6zjemP/rqkkTirgznjxrr5vBQH8TZMoUWN7ewC9TmNSs9bRzkHs6zGwS/52hjYyOf+DNPtRxGL8bI2KYi54tHVr5WHXY2UOcTI3SmtaqIXMCbxJHEfDPv8V8DOoUVeBgGJUvEttWfXjgo9+z9ASMJs8fVMUQGB8/53WPbjgwz3+jFWcp7W9JLJcEFUKkn3gPywSqFzFife1eFs/qt4U/U8kv0HUEphi97G9w7rfei0XXq7vXXS3BEAklFZF43ESMva4+oZiGK/MnJQIYqUznNVB/Dqb0mzQWLVYhydVa+bZdUKw2tBwhbID2Zw6V+qPkK8ByM1IJhKZH0jki5Mj1PDyOzSxK51sAehL/BqCBYsU8XzBOkaHia2vwh9/lzD2xIzskAlAt7Ww/6wM3ePav+oCWIOymAu65dD/m/0yO5+kp5Ol5jK1IvhCgf6Ja8fj6YydWro/BRCu3YqGYoCMRVGF1nq8DR3MbrPy7KVX8QFl7vJr0f5iiKIEmpUFTCNqPCiSsWV8hJtpHP6azNEm4CZoF+GX1Pg3KWWuzYRh2YnZUW/eWUaZFIhlPXNXZOevByP9GaVTpkZiN7dEcwxfo7zYAOeFndtL2zZ6OZCDW4uwAUPycxE4H8hcytjgvPTttrLZwMEwaAkW8xQdj0xz/dNXr/KQ+XLbzk6S6UfgRssfTBARTLwgdZ1mRG/aE6CxiPwwU0NWVQwDo31O8gvuDolHpyExJfbyctuqwTccsm5cFJPjHQ8qz6S3+HJTxPu9/+yx2IB0xt85pXVlh/qzeLZoSeFhfZ25h3qheOQC5aJRjhpfeE3iCx132djwLy5Jz6SGpLm7q1oRsvCAp+S0uU5ZSrntBgajnJw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb3e998-a05b-4a26-b99c-08db4596ecfa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:12.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhGuCQPMDQzc7TKMVLxR+n23Go2gXGHbD0ytXjDV3XE1+irZ2xCienZ/49WMd+qHM/zTtr9Bvog9EXxBVEHE3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-GUID: V3j-aEsCKsoSNYX7ECsgYiDCn3kIT5Xk
X-Proofpoint-ORIG-GUID: V3j-aEsCKsoSNYX7ECsgYiDCn3kIT5Xk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree iterator clean up is incompatible with the way
do_vmi_align_munmap() expects it to behave.  Update the expected
behaviour to map now since the change will work currently.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d34a41791ddb2..c0140a556870a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2391,7 +2391,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #endif
 	}
 
-	next = vma_next(vmi);
+	if (vma_iter_end(vmi) > end)
+		next = vma_iter_load(vmi);
+	else
+		next = vma_next(vmi);
+
 	if (unlikely(uf)) {
 		/*
 		 * If userfaultfd_unmap_prep returns an error the vmas
-- 
2.39.2

