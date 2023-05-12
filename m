Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498FF700EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbjELSZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbjELSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:24:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91079D850
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:24:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF49dt010136;
        Fri, 12 May 2023 18:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Gf/8bP5/7Y00ZHHg7g7YJwogjH7fdNlLAETXhQj1hlo=;
 b=RdYzurN6Ys4MKz/5qV3veOHsOnLk9LbAeu9SV9bnMgoSV9bwDm5/5HvEZGCDWi5kPEtX
 IK0zTuWhhHqzAMdC+6mFzfuVzSfxK4fvehC5UtDAhcFCC3Zgs9JsU5Mm4sjO/ECOJuzY
 SI2HFQ2yvrwXx20eqc2PUnXGPC83tAN3hbBzD+mw7+j0CSpIFT/j0THuUqQ1JCBgNec4
 G+mFLkxsJaz127ikWX7z3DrwxqtGi7Ds/40tJZUBaHhVVNJC4T+IZx7+rNfuexkz8h9G
 EfqRMbSpAtvVqPK35EUnyGGKvrzQFIa5DNYaIgGNzrRDJ2QXA+xHRGfvtZlWniQ0RnTk Fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf776ubhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CHqHrB004416;
        Fri, 12 May 2023 18:22:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pnt6cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjnKh3qSVn6MO19HC2IDjnPyc3HUYXOHsUxhyAxu3dpyqzKFF9Z1hd0o4Vh6ZKPaOGJRw+vTEQPKyJHZgpOvC78RL0O90l3O7zGQpuEtCiGDbqPvsFW0NLWZPDiS9fQb+PXJ/ea9m/fC+BJIXp2ykSGmO7tmah1PT8pWi7AnHwnA3zVLC+FFbUihVk2N1hlrYVcQgEW0Oukp4BaZQTkvFW0DW9T+gtwziN8aYbGYzfV73dskt1wIT/ZN5sof/rfmgT7S9mS4nZ68OdBGzZiEeABVftxlpKMOGxL6gkftKdRx3kHAcwGLkAHQr1Oese522LjubpmQlHT/4A85vfB2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gf/8bP5/7Y00ZHHg7g7YJwogjH7fdNlLAETXhQj1hlo=;
 b=hFujwy9/9LTjoeIqV/+yO7X5d37Wc0omRNdLcA7JkNdxEO2lGc8UKz6qdxaemV5GEEKXTA/tXoJaIV2IFNS6NtwU+YmzVL1n7uWAJ/1TfY2D0t/6a1FgZsKj9muJAet4iXXLCy00FGcV8KVS9hyJ9rc8lXCpO/8xZvOtLqb8/zrA+WIqCST8EZ5fgmX5XmqS9RynZhvernRTQL9IR+rLR1w77BSHKnUZsopkL2gU8Im46TzTl/RViqXbcLQzDCp/Jg9NAPulHg4cj2P9fWQlZqJA1iD9j2JhdNmlRWceZF/6MAhueVLJuJZEUqmUJ8FD9NG8v983BY8OmsC9Vz2w3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gf/8bP5/7Y00ZHHg7g7YJwogjH7fdNlLAETXhQj1hlo=;
 b=RJRnFQWIoHDEii1rlJo52jDvBNRsCa4DtZJLWOqN+UCaLURwqbrFr42cFavi5mW5vp7kIrh5KEByf9U+cZFJpgdq04oYhF/o45thqxKBJFGcgpOCR9qRq1/Io7hipNkW2HuRXtehzvCzwpNqNPJjEtum27kOCWhGrZ8Gj2/IAls=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:22:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:22:16 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 34/35] mm: Add vma_iter_{next,prev}_range() to vma iterator
Date:   Fri, 12 May 2023 14:20:35 -0400
Message-Id: <20230512182036.359030-35-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c2ad52-d69f-4956-a479-08db5315d0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z64qFUOP1lHMrrTR0tL7R+aHJ/0uyM6kUp9xVQzbZ3O4YxMaD2eefn1onfDir/ByoPLAX8TGvpcXZQKgQ3XqFph16bqDiB9Pjph9KFA1IGSgW02++JFi/HaRBksJF8isGoEfM+lfziw21nb7qEAnLMRVv79jtTGoCblziJoqyYayRg8tbZYUPZN6OZH//7JyMzRwxFIgSXGCpCaSnjm7VID4nSxT+pfIFCCRTaqBDdBwMDnP4bh/Rx6qPYhANJ5YKfa1QanbeNn4DDl+U/nPbMPqUi+Bji4VeANAMzICyc0n2IBeN4LE6iaX64+AH1kwBmTdok2efjhJKQujDz6ZaB+1CPxCvpaujTWmOq4lzidF6cQLedXM9YTo5aHpoLC0CbniyRTSyQI0B6fxTjT6nZT5rsYP2Plus3rn76EWFXE06XqHOShdQBjTVt7NYoM8oQHo5tAMxCGaOk5dIhb4QlzhQUPp+lVGh34NYw6W6ctcXlczn2DaPYGPBU+ZVgfS5mPKX58Ft4xqENKtcZLKud4mNV3AdhG1Z3oD4Yg7cCsarM+6RqA4JxIiawlpS67V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(4744005)(6916009)(66946007)(5660300002)(6486002)(316002)(107886003)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qYn/FXYp8oHFSQOJKo/5yo3t5kwcLwpaLhT9UotijVBoTdGb9hyErVVwNSPY?=
 =?us-ascii?Q?UPsVMOVVY7gdPKYaV0XQUWqizZwVUfv0CknroVv300uJY/xgXN5sWVWvl1d2?=
 =?us-ascii?Q?/fbm6jO6r+2Gl5Wa3W8wgjXTeB5IpYFUxgp9xZZUHsmA12bNNQFGTAOl4Wtp?=
 =?us-ascii?Q?eGKASM3qiogS9Qf4vcEeau+kCg1Ivwu+iFkwgmS0Tj0piub/8O3bMv1Bwu/6?=
 =?us-ascii?Q?Tt6m0Q+zrwVZ6fYF/dV019d6a49yhQdilT7/f2f8NFWDTO0BPt31XUMvX4zc?=
 =?us-ascii?Q?xS3sGQAZk/7QYZLabLLMaCqJFC5DM3IA4wLo4FslLi1RNhZBmNKl4Hy/BjZB?=
 =?us-ascii?Q?wWaINxDbpk+PNYbhQFeiIQtQEx2OrbMyOSj/Rj+/YT9Yv4uwKqEtLyv6fpSg?=
 =?us-ascii?Q?57JMjePPEBy7Ep4QfCd8QGcvPFtIO/YbMw171V8aaqAOx7QyBFJCfjyQSjPi?=
 =?us-ascii?Q?FSAfxL83kiI7Sn+AHCEo5UShFLBtNqXtK8B2QuS4ZLRUjqMeUMgig4AzK0qA?=
 =?us-ascii?Q?L4bsiPkrZI+fHuQOge2y5wQezB7B5RV6Jb3Xvpo9JGVFOfUYPQGaKLlCF9SP?=
 =?us-ascii?Q?w8LkSMfVPV6s7nmiC5MBC9IMH+ymPKw21MHbR+pSzh2XV64/JivveBg/L/6q?=
 =?us-ascii?Q?FBWeSobSeg61+GH3bs5vu3/04d/DmNw7MTE5nkg0jBWcNu+l6DQebZiQwzCl?=
 =?us-ascii?Q?d8UHac+q8vMmNvoMSKXs6VU7RXmYbPXh8eS5+7kddRGgJ7SMwZqt0OsKGAZl?=
 =?us-ascii?Q?a8swts2bodI0A4NjP9FtARxlhNdtGYlki6aeYtWLc8REVTQ9dHBeWAzfmC1S?=
 =?us-ascii?Q?RB5spEwBXl3IrNQ/IS9wHWC0TTTcgEiCEZoU79dck5inPYG/xhS5llC/5zhm?=
 =?us-ascii?Q?DaTxKRtL7sKCStS/cAzvBURWuqZEKsvdjrq2x7D6H8tjarMQgqCI2JAvE3+m?=
 =?us-ascii?Q?nfASyew2j4yVKDzxqqv9p0xinnq2RH3G3x+OI5qLWccsGzBOOmoJqmaBK/qL?=
 =?us-ascii?Q?vzMtubXXf31GAUmJKf6/djkjCmyDAtJS4moDdeiyM25ZltaKs9LqZtaU9ROY?=
 =?us-ascii?Q?Mxlku75lbfyuVS0bU7QzFfw5wAzs1kWdNmlmmBdwSYnroT0Um7sRF358pcwl?=
 =?us-ascii?Q?1fXFwCiYdekuWdyTan5W5iNX7rjrJr1gwuCj1JhNeBCujOSUlAa5p+ks0/8e?=
 =?us-ascii?Q?nRtBEfJHwOwqoYkh0WzKNM1T2GxuIKqFCborEf4mR8Kim3rUPhJRCz5dfF+E?=
 =?us-ascii?Q?yBuZyXyP4/TcWk7R6ULHY53dbkntKDwU7ElGn5F8vmm0Qd93+ujre3C87vTS?=
 =?us-ascii?Q?Ijbp9hU9H6zI5yXwKzRg4km0BlDwX5iigDjYMgbTAaVvhWZDGv11p+QE8VMA?=
 =?us-ascii?Q?45mJPsB8ai28d6lfBiQHEOWtSdGR5/Cj6b1XDzH6R8Zwe25FCwuNkRyWRxN3?=
 =?us-ascii?Q?AQ4Un/f+RRQh3cVQ10P/C7R7cuMwLFudDv5fR6PFy5wHJxbqu1D7wQrXQGb2?=
 =?us-ascii?Q?HY9gK2sJxLf5stMD8s9ylPQwdBSZmMBtqaHhVFXrAoKAmYS0MM7vvMxRhWex?=
 =?us-ascii?Q?L6Gsekp1cZYsf2KICLlGZVrpWCfunPAmY8hUb/4UJAF911ELTUTI2FdhcZhM?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 51VBEs6QhHtHhG1hdTRlzn8ZgiFw1pscaBlNLFFASxdr+hSYGs2uAstGjwHuAoS0rWtjsJxVZhvD9M8bTEbEmAE2waLk78JflAQBitzrHfSZDZwkXoGFnc2UG6oAGRoMbBnsIpLLlOMbMvFBysfurj8GkaLH5tzwivHvzfttd4kFTxZMAy8u6MFT9Jai63MHWCOQ2+RbQOwbnyo55ta6q9Xymo3yWp0pxZxelA3XYGbu/jyYCS62dHkN2kc8pnxol8l3didqRj3h63WU58LygMOXuiIQcDQQLCmaQ/1tvinMzV/I0Sl2mYljKtK9IoXjxPqEN6BxKw6t9UaOyzGleNoCXsqggSUMT8sOVfhIAv+VB0J2PIHkneDmHZPsScmeKM/RliZcqxx01sgSrR5gFQfj951H3nZfbzrJsY0TT+1rJftO6ESCJILAqPpxuMPXjoEZPxZtAfM1M9B760M9mY/q+XpipQ747SRLWtwk+he3Hj8pMtLAVMCyjAkNE/nTUyyABqEY0FvnGK51ZQzTr8412a2ZjGGwdaGYTYT5pdNffhywOE7KHiZvJmhvBjGZpy/b4xj0MTvdWBrRAB8xKq2X2Oc6NvJTltIgUPC9SXizvFW77RDEpq8emJPAuNfCNAFoqer+QCywT4SzxGekjq3sairtSYW3n10AUX4Y3BqhA28j0eFyUOwztgj35M6ZnHvGKxBXI8slVgzu8wAVL+zd+za1NZq/0MkKf8/X7GLowK84pjjLW3KNJVXUtDvnaiU+GzBElgmbGqqBR8DpoMf7VLI9mjR+32dTDawji5TAbvnNykyKXDJEXqV2L1zN+d+NHTJjwLkdRTxuAJ9h4t+zsxdBI4FWKYrXBRUda8NCWRl0BvC74j/pBlckuyueOidUTY7s8oRcXTed10ObWw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c2ad52-d69f-4956-a479-08db5315d0d6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:22:16.7196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFGJOpVmj5EWoXOVaUr78B5rj1gMw6dVblYbx1QTRqzxAYfMZ5SQqCGwY1H+rNkpTRTC16A5Csjblt5TtdfV0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-ORIG-GUID: ClqZiwUU-eUopPvTNZvFGWzt8hoBwn4i
X-Proofpoint-GUID: ClqZiwUU-eUopPvTNZvFGWzt8hoBwn4i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1d4e7393efd..1bd731a2972b0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -866,11 +866,24 @@ static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
 	return mas_find(&vmi->mas, ULONG_MAX);
 }
 
+static inline
+struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
+{
+	return mas_next_range(&vmi->mas, ULONG_MAX);
+}
+
+
 static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
 {
 	return mas_prev(&vmi->mas, 0);
 }
 
+static inline
+struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
+{
+	return mas_prev_range(&vmi->mas, 0);
+}
+
 static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
 {
 	return vmi->mas.index;
-- 
2.39.2

