Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1001B6F87D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjEERoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjEERn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:43:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938FA1A4AE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:43:56 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhQ8T031799;
        Fri, 5 May 2023 17:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=C3AbTxtdfyzVTdgMrkt+8cguGreW/PZzveEPUyUGMKU=;
 b=VgAceUbpPzWiCwtSQA3dl/l1YD0pUm2LJi/q6R/RFF7PCihmO6oShGHXCo88OW1TgR+5
 iXdVVXh4vWFKP6JSn+81zPVx2Z2LbeO4651EfYoDEKtv1m+RTajr92ku7DxzAP/91Ipm
 0JHbdMBRq05q2A97glE0AMfxWaW/OLUu2ZP9OIs7zebl4ZYGSMPATtJTMG20y01SjCkw
 euIwn1X+XJTxuSgnFNr/BjXDr2EIH/BW6OmC2uJ/M7zQFFmadt+xhx6paf7R9Ur2AFqq
 S4X/4qLsz5noXiKoHRqlwoCf3cc4oKg5yr4KbMkNBxLPfPvX3kKdB1SW4+SdD0bhMlKQ 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d5ndw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345GSEvO009895;
        Fri, 5 May 2023 17:43:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spanjph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV/4EhrGzXjfqqrNNbj0jns/nfjKX4G7bigBJF2s5LQngCFC8WWRRZzuWvJgfRGxELoBQh2x8DSMB0k8fgs/iNh3Qgrj6e2Fdh9GgWMdZqWmx9FxH/TY9cnWOvPRaj/sOc+/g29HiYgQk823NksIXXSrp/no2ZSMcak6wuUCnBjfzmAJQjN/hGmtAS068UbW+lePv78rk28jd1onTWxbRYwEiOSc6mCvifVx/F2YQA21Js8XX5FKv16Hu067jSnVz8eiaaOi5LrZVz6uu3wyrmg2PM70Ey0wHbWtgq/VrRT9rYyUt2ij+tt8UcQ3rf6UFjm91TwCP9fMBKFwCSiJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3AbTxtdfyzVTdgMrkt+8cguGreW/PZzveEPUyUGMKU=;
 b=oFSbPscjy5atJTlSRu9ehuNMAYDTuqKQzKDP3iHfONYEsvTIcukcssQS840msI4fLkI3QHpIKbr6lWBS0q5rhyqxDzhneGNnChBoZAr7Qb9igziwnjbXhaQSjpJJZJb5WXJlhW82m+XHeDSDVxKLJKaL4Hkfc2vYGP9BeLXBlEW1yfYp8B9Dx+O7QSNPmx87+YvP1FEiJh+/z09sGYUJ0c0ug7Qai1h2vJfA5F6CecaVPQguJpWhGT9pm8ngG10ZITuJ4h+f3+lDgZ5aDv+zw9R44FmPo97CH4efZWrb42SMtXF/3ttPpDvv8uKBPqPL1papirtSvLHKRWK03xtPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3AbTxtdfyzVTdgMrkt+8cguGreW/PZzveEPUyUGMKU=;
 b=MSwXfXqXyCnq+GqarLVUUL64amtBj2QOtye0tDjlQ9mRl8Gd+NgqEG+BdFQRfoD2qcNw9klRFD/GoB74MH5N3flLBi75AlqEr1Z72cap//SwEslmujdWuFTB+lUM+ES6P2X/wmNCzEq9QspMzCZu8Wds0OeRlNKTNcziiE0x0L0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:43:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:43:50 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 04/36] maple_tree: Clean up mas_dfs_postorder()
Date:   Fri,  5 May 2023 13:41:32 -0400
Message-Id: <20230505174204.2665599-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0238.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c6f729-02e4-43bb-3a1e-08db4d904927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdPoYwWgDJ6Uu/XBXX6eA5So8gQlCiCoH/7onaF3MqQ98cIulkfvXf4M+O6KBPQ2E0xSBEj94V8XqxhoBHObPqOJ8/8Re/AbCA78ooqVUN0tm0aZfJMXoFVhiyBurznf62o03lB9rqTHYKzpjNSbX9uuvkCNql4TWGK7Jz8XCfkLGvQCX12osxxTnLZ9/22TvtYWyrSLMVKh112CqV5Z8vMwP87TIkzQro/DY/xNNkqw3L6qoxDjJqXGP9PHPln1WkX5xBak1hnFnB0app6ZMYLt8b1V7quBM27WfvxIEoPZ8YKcv1TLDfyB7SaCI/yQIRkznJrFr/MjuWUWBnuyJvl3U6MhPWJ4SE1I7HUVdtl5lOsa2j3NrC8gAsMWTyXByAzUixdsRjXyZIYh2CCLK+NJbdcwnVfQdcjpJ1CEnd+cddvDvSFQMC3YZ7Y+aagHgdLmLUChASwLsTLaQPcF5sQlw0+2ur05xdRvt3BLftWQwVDOK2B/ckaiVwwhpoh3qG7puSApeF2B0mW7gMRWziJPU83lKt6ZUG75RNlysZmNct8sp/G/qZTYh/dGQdvV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(4744005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?USJfvFzUb7nREQgORH1BSnYDPMo2Xc1RH8HEieK4BhMy0OkPiNtIpRT4mi4N?=
 =?us-ascii?Q?Fw3rqXPaIsl94uql3flwF5AE8gROZV96DIS/xklkeHKI0oSoTID2HzdoI4xT?=
 =?us-ascii?Q?nQrqMwM/bS/lTiGWIkLsXo7kQDv+V5AwiXtIZlxYSlTm/KAfxfqRK+J1A4uL?=
 =?us-ascii?Q?eMKOkVfHnNVFezeI0/mpOLn/X1s8XHlKo3xlekHycDPftVMiGjk/eovMb+pp?=
 =?us-ascii?Q?j5AS7HXnzCMwmMiLdpkyb5kvEJOTuBvXKPaM2V7udwgac+TzI3GRNeIef5xw?=
 =?us-ascii?Q?QzxRfXoQQ2ipNMgfCEBKhtI4QXpR8GPcONRnzoqfw6YKs6okDlDTLWbNZMOJ?=
 =?us-ascii?Q?bHOF93GtvJiC8CSq7Xzx8FUJg0vbqDQ34XRA3eueFmZL9z8GND1xS+bnvnm2?=
 =?us-ascii?Q?97Yd6L1WVQfDIOZWeLoyPy1qoK8fhFK3KcWtT160mQ+q+GLbWHMUIgI0Zm8n?=
 =?us-ascii?Q?Z/5Cx4Y9sPcwk9uenVC+pLSI8tNVgWuWsykpTRRPKc3BlbnRKooIhmdnggiz?=
 =?us-ascii?Q?htU23SkOnE9z4GDaFsvdEchhy6lduKLnTu+PN7d9PSyIv5BfNuPc9j6IViY3?=
 =?us-ascii?Q?4zoX/jhtmHl0kTCALkjIDjXn0FvExC766dYqiwi+P0sTpqJoMRNwKjmXq2DG?=
 =?us-ascii?Q?r6wbuZ05qlR4OSjaKc/6nFckw5BqRt6na4QPu8VhZ7lk0yS7TZI5QGJieF1v?=
 =?us-ascii?Q?ClJSUKI2lp4o+/UW+ahhYngy659+TjTnxfZAOwAiW4sk6RyLoW4NtLlxDAE0?=
 =?us-ascii?Q?pXCALOmZY+GYaqmqjpR/ytSEDEvXmAUzkjOjdF7f6pUGpA3UvAzHsi9k07U0?=
 =?us-ascii?Q?RAlPyU+4164CngSi60l8hYIU4Bh4KGuKkzLucyWTLffH+bS5B9xKFEBhtgOy?=
 =?us-ascii?Q?NWUtqqnW64sxhPtk8Eqtpmg3owEcFd4nQQqrv1cM2Pqn8I0wGVFlAxLBsvfQ?=
 =?us-ascii?Q?adilpzUgKgD4dFSEkYDkN2fgG9cy2jqmk57cj7v3Zw1vsTCM+L+HqRgOSVZi?=
 =?us-ascii?Q?qv9C567/1HzKNXvuZNvBziyRkFb3KyyZ68k5jyyBitbpgsjstHxMPLNXveIW?=
 =?us-ascii?Q?9znpX2avt1PukYKyEPyRyvIeSchEV9nIPVgz/FkIfmNDA6UabH+R4LZw7BBQ?=
 =?us-ascii?Q?FXyhbO55RliDtBP05MfB6U8oC64SgMUJwznZPy1TiAIJmsFPr/apM00V7XEm?=
 =?us-ascii?Q?3EFWxFu+GoCy6jGwB04HLnLo1OCZKZDku3We4mDz2I5ezpfpEzQlQqsHUrpo?=
 =?us-ascii?Q?LbRzWhOBnxM2A6+MrtaPItGZkadANyQ+vNG0epR1MAw88b1eVrcimrfVuzMp?=
 =?us-ascii?Q?adIIEqI4wBRVxf3u67xqCo2pbUeeg+tM9CUg3Kcnxqnp+4Ltly+Rq/L23+h5?=
 =?us-ascii?Q?9hCLUCnecqEgSn4k0tYSmMMjB+S7dOaMUGOYUn0KCOa3YHXDLg5I4YVjX6aa?=
 =?us-ascii?Q?hDm8/myTNe7Q8E24mlGzR+W6izKnDuj0S2Cbdat7YneDLD0dTgGB/SDokfQL?=
 =?us-ascii?Q?dSgfl7PdoCV3e8q9wP/35J2glX/koNz3ZJt2if63eRVXdFQn4Dp1YK7k7EYz?=
 =?us-ascii?Q?m1MHwUkGPa1o/k3mceiY3Zn270qkXHF1+7PXz+Z/3XH8OTLtFd80L2o/W4r3?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nKHwuSny54+hLUUNs6/NKWEWGUbl4Si7DmfQrunPQjgqlUkGu8dWPEcjCWI+hsZlVYVcGv2G+4YBiY+PiTg2lM/w5I1QDEhysuW7SAhkh31fDNtJNJT9GTh8hiNFfnSfR9SyvNG9Zj2OoyuLWyIKBYEprYTUI3jb6vFPd4FqwmF+JkYsLn4qMMf6L18ZIgcXSfTp5KP2DGInvF0qAbVVI9LHs4wAzorM/QApuRSsuyMSBLB7LA8tQDSmyjzx8JHWbVaPAFsGe2glygCcGEFbsLQI8PYJTUHILkd0PPkZmrwqRasVeDKl+wMHGVobB96vKZVFWLODrMifYqz2a0BZ7UZpVSebGvgNgnangG4bbnZUJlIEfFk+PQb5xS5E+9HUeIWCdrDgMZBgiarPqvJP/MRgq9zP8SM7qrUX5D2bz5RTdDIFstdTtw1oVISLXsEGhpjcvrnJl/qw2gJhsbpi5/yWMtoVS596CVJtNBilmfwZ2VWch00xdKIttSXUBBxo/KLKSEW4+BfAvC5sRR7RC4q/XkIAxU2r91xBtKQwguXm6MyNTXdviEnSHkvLbDYg8JT/X4EmNMOaGTOCYzXlgvmzWxX6rYGZYyTRIlyr1U7+Aofr4hioaEvex7qlPq8z15LwtEcfhbIZlaKWPEGlx9Y0qM4tWv/rqC/uF8JQvy0y7UmXkMuUnsBcSHuyuO0Y6hZHHHbgFBQGcQprpCVSin22+sxFsy+4k1jyJyJKy0ce2rzE6TdpIG5mnAjhaMpopW6kMmmAEneon0ia8OzK/14Vt5ntPY3piF1k1e35S4U4MuKhV6oicCx9bXPZ1aR7YA+w7THE222IRTYOuCeMhgX1H8yxOgUmkxBgI9HtQhpqNs02vYxU26v1yGpKvcgVmrlwR+kZqgrmZCdTWv4ZrA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c6f729-02e4-43bb-3a1e-08db4d904927
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:43:50.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdkU2h/xI/jTFSAGZNIUB2kyZ1r2VXmK4bBAYKQ1XmQ4Nofak5xRuMhPFMYFOfQ6kYwmAgEoAkmaJTE4UkwaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: bF4WDtPkzC7WAPmPJpFsTkkv4v7qEKS5
X-Proofpoint-ORIG-GUID: bF4WDtPkzC7WAPmPJpFsTkkv4v7qEKS5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert loop type to ensure all variables are set to make the compiler
happy, and use the mas_is_none() function instead of explicitly checking
the node in the maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5b29d5a916f2c..1e7e7249a0cf2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6739,15 +6739,12 @@ static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
 
 	mas->node = mn;
 	mas_ascend(mas);
-	while (mas->node != MAS_NONE) {
+	do {
 		p = mas->node;
 		p_min = mas->min;
 		p_max = mas->max;
 		mas_prev_node(mas, 0);
-	}
-
-	if (p == MAS_NONE)
-		return;
+	} while (!mas_is_none(mas));
 
 	mas->node = p;
 	mas->max = p_max;
-- 
2.39.2

