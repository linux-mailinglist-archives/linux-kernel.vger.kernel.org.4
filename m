Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86ED566A6A2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjAMXCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjAMXB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:01:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3C684F8D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:01:53 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DMpBYp008226;
        Fri, 13 Jan 2023 23:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ON8r4iAi/C54BL7LxCnv7ms9x+EBmJEmmOUIFctdR/Y=;
 b=anG2gdXMW7cw6oPWnrP9UoMR4ncSrGYHV9H7CsvfqQHKVZbDPLWLfiOER/CT2oHvC3Ns
 cokkWacXbDtBUCg2zW3urVbppuzyFObyY8yUOIw6M1MfXQEAr+0OKM5ZgMYCsNkzIubN
 eilZvYafHxklzpvism0fJCxpnFQDxoCJAwrzA9ev/zmaNY4tyU33l/sb3rYV2+RHkTC/
 6dSK/XyNxWeRTKe5Pn5yyWcFSAoemVTrE0FhuAziAcL2DMMfOmHOKyhnuUBFGYEUqyse
 QJ1cRyX0DrTIkOMMqDpFNS8e0gSHzSwlEkJ2cc4U/LF+EL+4/7GPAE8GeOhUd7kQOy7P qA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3e0w0adh-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 23:01:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DLRUnl004403;
        Fri, 13 Jan 2023 22:31:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n3f7usqt7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA7hJmk3W/fHax6ZoaehiIWRKW+1y1x48Eavc1xaC0Xaa9fAQ18IpUF7EWL+cQsMsws7Jp4uhofqb7JKLd4uI4XQeL0bpKTWfGRRm5+sIoIDxj+PXJ2ZLt8Xnaz74t5eHu4j0kYg0aRDWCQfzWSqjP6tRWiPx/mBeFphe3wBXXwHAEKzv5mqnL77q0SShj9MurfmwDZnF5tmXmnnabApYE4dijTUvlpD1yGqwnXZKkeJOswXNBL0+v4RMLuVtFNBdQgS0UohdkCOjatCyUyJ5F5Kzyc5xwI0+qPRPCgWQ7UJmXcmfYxd0H63MtbuHdZyVREagRhkn70pJpxZILjQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON8r4iAi/C54BL7LxCnv7ms9x+EBmJEmmOUIFctdR/Y=;
 b=kMcqHD2RDXSG84haPC/CevD3AgAfup5DTcvznQEMBlmMA8wmhfiizuCeW2E/MMkKN4rBWE7jLPyJfSR0G7RVndLxV/jQOeV8Rxx3zgUaVIXY3IetPTLb/kevGJueSByaPqUUN4wBaF3MCgCwLeE2CITcYljPLST5WCj6qx58uXyzhW7fWrT57D44OHByJY5Aaxmp9aShLKScKNxISg9T0NUN/X1T23xajnF+8qWAhhDlNTUKZvhuHRLyATO6Neu/v5YCDZNTx+sY02GHm937GK2Ow/EzOUViqjyR889pXt7piPdsWr9UZ/ah3zmPYa7j9kTAIx6iBkUIUq+WQLKi4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON8r4iAi/C54BL7LxCnv7ms9x+EBmJEmmOUIFctdR/Y=;
 b=jPCUEOWx3QM/CeQAUyg5Cwk926fAKdqFSUI3woPtJfJJswW8XN+2dBil/GA62OLLem2AmfFMoKm683AUBHNlMiM/mIizpnFdcp7mDwB+mBhcp9aahYq6Ix1KqNlECg2hc7SUzsMGHg1ZtFtcgaBoK1ZTQF8nKircj/3WBPR/SMs=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 22:31:11 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 13 Jan 2023
 22:31:11 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v3 5/8] mm/hugetlb: increase use of folios in alloc_huge_page()
Date:   Fri, 13 Jan 2023 16:30:54 -0600
Message-Id: <20230113223057.173292-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
References: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:610:53::39) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 3429cd2d-e3ec-4886-bf0d-08daf5b5df09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLRF5rQAm9caLRK+zOZHkn+oiyr9zLq/BkMigmq2dNjNPOBW6x4+rofg3s5yDIgO8pK48OeoTgKxRfZIRrNE+8CQY/BgsVrSmUnf/wML4R3t8CLFomWqQopPHSsl8rowieO6LO9F7O3Rs5OZGfLJPRmtOBVTzJY0j/f28GfH2mLfVMzImqoa/lDQnG6BdY2GxAga2uiv2rCsLhANTupUY4r0n1veIQeK9jPrfXVoBRIKxl1Z0ckX7M0HUq8U0/XEghv/tQZ5Jr+O3qHoQQ5EVz4fS+q9eqgzJVOk2cxfLDEeXg/rAXthc+Vkr5lgOHpRAlEqssCt+PxogqZy4tZfGWDAU7Rq2pcHxnMiic830ZEyCoSNSLy90uezlI4S+6fMnz4JkctltwJp7sYpWklMkdDrKJi7vodO3uqKVcYKuPyojWoj/4FFnNrVYD/pKz2vHQUiaqq+MdJeib++kJunKryYjBAXjEGFcLRjiDMyb5T2tWB/cgFbL2Uda6CMUSLWPWD1o9HRGfYvWHGdsRxWHyK3ub3PQ6ssBEt4HmkDWg5cRvM7SgOBqt0zR1CHiAGhGp/E4fcQhnSOt1RRTm4j4oIRNEVda6bG0iR9ojA2uso7g5DhxOTzxqqF8XDeduMS80/gMyrwDpjtRbOUhwJp60GvHLvDCHQoxoUbQ8YG0UiMMrtB0KwfvHLRXuzF3oWa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(44832011)(38100700002)(86362001)(2906002)(41300700001)(8936002)(5660300002)(6666004)(107886003)(478600001)(6506007)(1076003)(2616005)(26005)(186003)(6512007)(8676002)(66556008)(316002)(4326008)(66946007)(6486002)(66476007)(36756003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I7Zu4/edujXnc2bEX1bfYKj7hfVaHMNFpqpVbw3mGOT3d8KXalFeW+vsFFDO?=
 =?us-ascii?Q?Gc69zxT6Z5JaMqU18kjDSCK1aXJZTHfehq9lopNIDSg0iCI2lLSL5LBSYnqA?=
 =?us-ascii?Q?qsbizzM47rJ6+NofNIGnoLUIl7F+fR7A/fZY+wkb2wps4A7qYNpAEBYesBMX?=
 =?us-ascii?Q?jxwWF0u71Fiv49vKh2BHYTnR6d/UK5tngirkx5eigz0ap6hT4ABgSDrlDC8S?=
 =?us-ascii?Q?a37V8BGpv/FfHbyj2xLNej95JmS7YQW1SU0ViVKzZZW2JNwJL1nqhzWNXOwY?=
 =?us-ascii?Q?j9rC2qaVPUmgg1nYYQxMii8eblCeSQAKotsFZt+X9km7Dzinzf2Me+qJBMtu?=
 =?us-ascii?Q?ajb5CSI0HF9bMzGmi1U47YQJBwrUxZ1zc/jb4jWQHHvdX+9FM0t5xID00M6Y?=
 =?us-ascii?Q?Y4ytdvRpbS/EdlYwm3Qa86UIJGnv0QzW5uDwdCXkiWdZlz6ZKhHkucU5344k?=
 =?us-ascii?Q?/TlKn8IVWuGbdPM+IyKopuS5/PXWbRgMkG6/QcguBmJm4IsTAms6nvoZSxgm?=
 =?us-ascii?Q?KKOfbHsU92UK6KbWMSX6YCfyyqnvpbssLQpjc8z1P3e9DuCgKzJdSUb7atQD?=
 =?us-ascii?Q?clSxAisnoZKStdG4K3V5yNOgFaJ1dr/UHIph03A5jgu1rAS2EPmzXahG4KEP?=
 =?us-ascii?Q?KwgnC4XW/88q2lFI96L9n2RngNzoXC7BzZrVK9YFo8I2MLgUJKVCiQErw2w5?=
 =?us-ascii?Q?U1V+9JmwHC2PkBDrDoiLFtlX84RNhdIsArL09KUaImx/R0m3DHhEzEGmBCGt?=
 =?us-ascii?Q?uSYDDY2ak03t9zVbCIEBiOzpiwHL8b8JZgHxBp039Rtyu53yEPraWODkBxAi?=
 =?us-ascii?Q?Fjt+m+81L7XjPETGNBzbfimWr/mgIes5SKBhVnhTxSv/pdcu+mkWcBPk+lYZ?=
 =?us-ascii?Q?PuXhFBbM3yFjOx13Zy8UjCxbBc6u1xtSZwaGovXbNzemalSDxgR/xuyG+MGE?=
 =?us-ascii?Q?ilSAfrc4TxYMXxUxdQY+dsUKdnMjivIYhrmtsjoQNaenats1TL+4QCglTGy1?=
 =?us-ascii?Q?OzX0k0C3lX/LfYJaVW8s3hDQ6VsqOiwpLaH+1lJR1vdTgiFX5CE5ZIxMHEwU?=
 =?us-ascii?Q?6s3FBq8pa/SVhKATKgIIk6p5TiKbi4Ix+j4nzCVmxNPml8BktNlcPy2GG33M?=
 =?us-ascii?Q?OUxGeUGMeRpUkMeuDBHNPl8H6GHV+8C0EiNmd85nxL0KtJd4gFuEFXKipMqE?=
 =?us-ascii?Q?sIQpzn6dd7SyHaHKPpWFaYFdXOUCBRgvch/ucep9ZnGyg0JnJcmXqqlfikJL?=
 =?us-ascii?Q?3HVnDATxvY7JGR/X2v6rWzeyHXZAAZWzV86Ub3UFrwyrhywWkgfnDu4s1h6h?=
 =?us-ascii?Q?2ISlFXFJQH03SIIdvmkSAVP74zq7UYohcOc2GhcU3jSIFwlmvAtWVWwa9d/e?=
 =?us-ascii?Q?9tmDEF6O+BUC4F9jtFHD5TB0+YUuoO/OnjYOalNnKaIZ7kSWikTQj0hEoD+s?=
 =?us-ascii?Q?8egFPzN8KVSyLATROTHhPVW82B90EgjqKOjAuMgd3BOx0AlbhW2kmj/IU6NY?=
 =?us-ascii?Q?oPSZ3c/hQgSCIyK7G0Y76K9hRMgs5abWx2u8FSBJnU+Nc99F+VcLCWnx2jru?=
 =?us-ascii?Q?jkWuNIDXsrfGAQkEETIMyo0sOgZ7riRfkY7nmWcySsmBc44BxQCacUOtQOKT?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5bTXZsdv/0k9zK+b71PKLHvIUn4COtqMzAuYVxEIq+O1+jwjo+okN4t+oFSy?=
 =?us-ascii?Q?JxB62RRP2Ez7oYSjsaSCECTOtB6xnnGax6majKSNitR85FYVvEvINpxI72he?=
 =?us-ascii?Q?zX2RRzvv2OdWtV3NKa9OGkzGuWQak16gXtZU2KcQaAjtBIwR10g+Me3L+9XV?=
 =?us-ascii?Q?ZRbbUsyUP9X5EB7iihPbM/5LQMtOa2h8bFO1hqXHkNxd4x4UwQPGJjfIYN/b?=
 =?us-ascii?Q?5GVzm+/gzE2MkeLaDUuaN1WBlh1aLo1iQV0EnV6uJ2z8R34wQN12+T8jb5A2?=
 =?us-ascii?Q?ZiH/HkHfeYdelLB3BayxZvgapf3F/sToEiTTvRWvJYO6lL+GAfO+G9fSd2zH?=
 =?us-ascii?Q?3cBE78C9RFGFNRUnlBFOSHuFt7sy5OO6BnlN+1iopPTN5tFx2jrvCirnyAWR?=
 =?us-ascii?Q?wVNRgZeA0ISzBDXumgZn03Z5rlXDRSDNNM6w31oMuHVV8/xPcXqWMlnzMUfY?=
 =?us-ascii?Q?LuzgP4/8e5it90IicIDUTSW2snd1ydaHbiWmBMAd8uK/X+2yoIe/Axw9QXv0?=
 =?us-ascii?Q?t02OZ9g+UPkM2CEkLQGMwaAo9o5mBQ9HYkyvKXEktPU40/IbBP1Mre4s1jTX?=
 =?us-ascii?Q?8FgAoGvf6CugRazKnHP5drXoXtD9rtgkW9gK8Bsi1FzgH/bFBg+W6BXXy7H8?=
 =?us-ascii?Q?zjF6Kl0llnnUCxPzSGDtiG9/+BJKCqPMXTyYhQ9a1CGQgefZXJw+CD3c5HE4?=
 =?us-ascii?Q?0beFWMN3cjFwKl+/uyX6mRaTX2NNImUILv5Vr4UiLF0VweGGDnpq5+ZZJ8kM?=
 =?us-ascii?Q?FtUbGZ0omyFy8k/j+CNlpqfa4ekFC9UMeeHRcd917y/HCnfuzp+3KfS2zR+J?=
 =?us-ascii?Q?X3mGrykW7/AgXR7p3pyKB1PfEkRPuJL5NepmyC1CtWrs5a9oUQAJxbgUIozj?=
 =?us-ascii?Q?M9HIkx6w9IDJXsmdtM1Hz7SOO4veO1MkwSoSKnAzaD4OoFION1wODhxMlLBx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3429cd2d-e3ec-4886-bf0d-08daf5b5df09
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 22:31:10.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMue7lt5AlYJL4l/w8TZm1nBMO657m+94J/gx51D74k0d0MVD5IJlzRYEbROXjh923EHPPzV5hag2CwArAjBT+NJkZSlitnZ7yijwuHtpuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130154
X-Proofpoint-ORIG-GUID: 9jFQFCRsq-ngaknBfjWp_a2Dhaz2fNDD
X-Proofpoint-GUID: 9jFQFCRsq-ngaknBfjWp_a2Dhaz2fNDD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change hugetlb_cgroup_commit_charge{,_rsvd}(), dequeue_huge_page_vma()
and alloc_buddy_huge_page_with_mpol() to use folios so alloc_huge_page()
is cleaned by operating on folios until its return.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb_cgroup.h |  8 ++++----
 mm/hugetlb.c                   | 33 ++++++++++++++++-----------------
 mm/hugetlb_cgroup.c            |  8 ++------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index f706626a8063..3d82d91f49ac 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -141,10 +141,10 @@ extern int hugetlb_cgroup_charge_cgroup_rsvd(int idx, unsigned long nr_pages,
 					     struct hugetlb_cgroup **ptr);
 extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 					 struct hugetlb_cgroup *h_cg,
-					 struct page *page);
+					 struct folio *folio);
 extern void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 					      struct hugetlb_cgroup *h_cg,
-					      struct page *page);
+					      struct folio *folio);
 extern void hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
 					 struct folio *folio);
 extern void hugetlb_cgroup_uncharge_folio_rsvd(int idx, unsigned long nr_pages,
@@ -230,14 +230,14 @@ static inline int hugetlb_cgroup_charge_cgroup_rsvd(int idx,
 
 static inline void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 						struct hugetlb_cgroup *h_cg,
-						struct page *page)
+						struct folio *folio)
 {
 }
 
 static inline void
 hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 				  struct hugetlb_cgroup *h_cg,
-				  struct page *page)
+				  struct folio *folio)
 {
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 62552172683a..f3e1d052b40c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1206,7 +1206,7 @@ static unsigned long available_huge_pages(struct hstate *h)
 	return h->free_huge_pages - h->resv_huge_pages;
 }
 
-static struct page *dequeue_huge_page_vma(struct hstate *h,
+static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 				struct vm_area_struct *vma,
 				unsigned long address, int avoid_reserve,
 				long chg)
@@ -1250,7 +1250,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	}
 
 	mpol_cond_put(mpol);
-	return &folio->page;
+	return folio;
 
 err:
 	return NULL;
@@ -2302,7 +2302,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
  * Use the VMA's mpolicy to allocate a huge page from the buddy.
  */
 static
-struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
+struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 		struct vm_area_struct *vma, unsigned long addr)
 {
 	struct folio *folio = NULL;
@@ -2325,7 +2325,7 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	if (!folio)
 		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask);
 	mpol_cond_put(mpol);
-	return &folio->page;
+	return folio;
 }
 
 /* page migration callback function */
@@ -2874,7 +2874,6 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 {
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
-	struct page *page;
 	struct folio *folio;
 	long map_chg, map_commit;
 	long gbl_chg;
@@ -2938,34 +2937,34 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
 	 * a reservation exists for the allocation.
 	 */
-	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
-	if (!page) {
+	folio = dequeue_hugetlb_folio_vma(h, vma, addr, avoid_reserve, gbl_chg);
+	if (!folio) {
 		spin_unlock_irq(&hugetlb_lock);
-		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
-		if (!page)
+		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
+		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
 		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
-			SetHPageRestoreReserve(page);
+			folio_set_hugetlb_restore_reserve(folio);
 			h->resv_huge_pages--;
 		}
-		list_add(&page->lru, &h->hugepage_activelist);
-		set_page_refcounted(page);
+		list_add(&folio->lru, &h->hugepage_activelist);
+		folio_ref_unfreeze(folio, 1);
 		/* Fall through */
 	}
-	folio = page_folio(page);
-	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
+
+	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);
 	/* If allocation is not consuming a reservation, also store the
 	 * hugetlb_cgroup pointer on the page.
 	 */
 	if (deferred_reserve) {
 		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
-						  h_cg, page);
+						  h_cg, folio);
 	}
 
 	spin_unlock_irq(&hugetlb_lock);
 
-	hugetlb_set_page_subpool(page, spool);
+	hugetlb_set_folio_subpool(folio, spool);
 
 	map_commit = vma_commit_reservation(h, vma, addr);
 	if (unlikely(map_chg > map_commit)) {
@@ -2986,7 +2985,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					pages_per_huge_page(h), folio);
 	}
-	return page;
+	return &folio->page;
 
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index d9e4425d81ac..dedd2edb076e 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -331,19 +331,15 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 
 void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 				  struct hugetlb_cgroup *h_cg,
-				  struct page *page)
+				  struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio, false);
 }
 
 void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 				       struct hugetlb_cgroup *h_cg,
-				       struct page *page)
+				       struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio, true);
 }
 
-- 
2.39.0

