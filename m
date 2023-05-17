Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA0C705C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjEQBkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjEQBkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:40:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7793C0A;
        Tue, 16 May 2023 18:40:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJx2Vs021272;
        Wed, 17 May 2023 01:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=Uraontsvm1OZj6vXcVzseRqhjcD2PAThlDtD+QAKddm7BjIWqKl02k/lWwMjEcXze+cH
 Dw2w/qhMZb9qUTeVIRPO5ThJ8uHBoUpBDTbBKOihXeOQSVFrxfId/dZA+aQh+rYZTikG
 ZrmRleaiuOwSNHMcTAFGcMAwY5MgUCI4sqsgl+UusadYTleNpaiYPxqubmWY/Vjp6AXr
 TTarDwjzlirjihZgNbdVBdnkXd+vQSli03p30E2KeXVC9OWG92JQ71m+ypYwSi9aJi+X
 J4XjZVcaq11a7ntU5XdOxLvWrMajmMc+yDSDbzNq2KZ7J1mc/kxJl63Lqg99wrMKjYo9 LA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye4ewr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:40:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GN8fT4040031;
        Wed, 17 May 2023 01:40:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104jkpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:40:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyowEoxg3d3F62mHwFNBPit2yMwqPmUwzOwZp0vKId34PCo++PNCoTxNN9O2fFyrdP6hNdZOBEbl30zWq+QwdBN2wIq3X4yzXH5+8+AneCIF9rQaGyeEfHF/Eh/q6aiabszL7eBERdOpXEhCqo67a9oWHzm+KFZl5ATo+Vptpgj3GDBuKUmSDQSomrZN7iZKtcPytO9xSyS2Tekm5vbwfX05sb6sjde5YNqLB0O35NOgn/M5PJ68fDnxyq+8HuO4lr1Cd6oOn0aLd8h6R1FlKqtGEpAhQ1MbYE7vfS/+6OtYDNmixJQr4wWHByzTBWt6bougT6nNEiShMJy+r/7ZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=ahGMXyqbtwvQMbXGWp9zJMnAqsw9Maf8bwKIlXxeJ9rHiX1vl37sngSYcJgF62A4ATZ60VsdtWqCwXmQkJrbMfV5H4h+VG9TtNsPrC7sixA97adDHGGeuYrNo3S125SZ9pLD9zHH6f+7fDX2ZLhin5uAOOc0VIrWcuVVXItjpw02J0rBWFRGl+/6h9lI2/vnE+rOeYOLSOTebQ+ySaW0MeAqUH0Qm1NNVRVO60tYgGOs6cg/rZBEmsUr03OT1L230AOFmP/UockKhBPLd7WYkAJiZjKBF5pvjizZYiG3eIk7214TG5V94SyrV2oUyX5q/HPDRjnHl3te15Hp/a8e0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=fgeDSM4iekx18BYPmlfYoqgR6n7uRoP6e6x6rszv5rdlcsi4AbpaMzULbqJyzvEpMJy4qIJZ4Tv7O8kcrmyLLlT6rCvhOeY5zWOPq/ypnl9roWbST2dNk9xmpCSRxL6a+dcoH/hWY6Q01gd/jVQjSgbGqt6NK/z8JoGxFheuyPY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA3PR10MB7000.namprd10.prod.outlook.com (2603:10b6:806:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 01:40:08 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 01:40:08 +0000
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] scsi: target: Replace all non-returning strlcpy with
 strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7mju45z.fsf@ca-mkp.ca.oracle.com>
References: <20230516025322.2804923-1-azeemshaikh38@gmail.com>
Date:   Tue, 16 May 2023 21:40:02 -0400
In-Reply-To: <20230516025322.2804923-1-azeemshaikh38@gmail.com> (Azeem
        Shaikh's message of "Tue, 16 May 2023 02:53:22 +0000")
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA3PR10MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad8715c-e96a-45a3-5b67-08db5677a5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wfJBng1QHTQdbYEWMgDMFT3VX5YZ6AZZEIxhoES8vjhWlaLY13F04N7ru+N+tWn2elugDNPTBztYhqMuwuoXNVaZ6dS+Zk5ALHzcWxUf7HRtQap/tjfZXdwF1xmnkzGzUksaNXOtJTLqFLOJThNcNbrclnT0Ckc9VaoJ2HCWo30Pw9dxyJ1mmDTZx1zzAknG91GHC7lSpfADpyye91UhtgP3RI8EtHpyAng4fZJ9iNmwkyADHwQ1Bl75xMImR+eN0HSjFrgAfQCfKGTdOlWYaroHbnTzffu9MkK77suI8mxBWZO3mZot0RToNDPL6Vnp0WKLEX/QzBoCObQIqrUZNY0X3hXcdBNmrv7WDiXhSxs8YnxHJC1SbewQGNDaSSWXYfraUvQiu6T4DsgvTKGR9VHzz6U9uL5vcKVPyRnXI9RC6Mrj4zG4nfgD6o0A6zTK4pq4fr3P/1ejJbZA3Yw2V0lmWgm6QVFQwGmilfximT6dD87UmTuZze1Ip1KJN7SNQ5Xfen8kqbPzCExD1r5LAuqYRt6aeY3zPrwZ5hzSLjRdd+FK32lrGK5HaEQF/PmFubZiZFUuJhmOe8G67i60scCh5gcFH59+oI48VdYhAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(86362001)(54906003)(478600001)(186003)(6486002)(6506007)(26005)(6512007)(6666004)(38100700002)(41300700001)(66476007)(66946007)(4326008)(66556008)(6916009)(316002)(36916002)(5660300002)(8936002)(2906002)(8676002)(83380400001)(4744005)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8DlO03UJ8rgrhwx5tm0lRfnUbXiWZpsrK9G32ftVT6B5pHK3hJX+qx1ZbCu+?=
 =?us-ascii?Q?r385w1u3WY++QOos/M4OHvj5qkVI+hmdFh7ot6OCxIB4gex7VL7YLVVH8nsX?=
 =?us-ascii?Q?tV2KcHPdJHCaDe7lDZEFUWSRIIyRxpFZOwp7SYuAxmLhgprW4U+HKGdU4OB3?=
 =?us-ascii?Q?X6dMSsaLG57Yt67dUxd9Agqo1Vtfbsjcr0Y7YOAnlc0jnbMg9T+3iJlGb/mB?=
 =?us-ascii?Q?n288G8srgATWJawYwHJJ/RfVkAw6zNsHnXB0hrVConQe6Egu1qlFPacmGCco?=
 =?us-ascii?Q?q1jk2Hr2dudWFDnN7bYWoE2FDctKgZ4i1QybA12TWZwMx+29SLvSGtu6Femq?=
 =?us-ascii?Q?TjP6A7vzcCHzh1SM9Y5E7FkWpAlsiED6O54g65KDc7K1gZ+CzT8ISoP6msO0?=
 =?us-ascii?Q?MB902Sxxl+4eYDWpC0t6yniLZsdGZvtu15AobFz+GLK/DAgv4USMvEDWHxjH?=
 =?us-ascii?Q?cwKwxnsWE+ftw8KLrqQ+DehIJZo0g3qGhc0NTV7BE7fGp7NI+/lDFy0b0/HZ?=
 =?us-ascii?Q?7aONhexEWMRZwT979uG2t9HoXIbuYBTRF0zhUWQ77IyKCG06QVNxsZw9RqKd?=
 =?us-ascii?Q?irsakxExgOvLxx5P3ExrUb55VC1fSFceMGhuFumD2dHKKVKskaw3h7mS75ql?=
 =?us-ascii?Q?uHCFI9MlRB2c15acCZ+aNLSggriP3IKGkvi50oCdiaXQnslMWikN4Qmq44aE?=
 =?us-ascii?Q?6TR2j+DC/YXIGr5/IT1Gl2oiUhrqEVizjBZXBuc50BDdyo+hu0qc4XJL58Le?=
 =?us-ascii?Q?N8ixMPAeJWVMHaohzSg65TYp1AjKbAyxOqEZlDqTd/EY1nfdN7LC1IXmrter?=
 =?us-ascii?Q?qn/FEffv8ZAnDnLh6hrbni5ZATIbbi1HOuLC6lA1w/PCZ293waLzSQcpCea8?=
 =?us-ascii?Q?rLOdMMGCrAVom8K90/qLKkzUD6vxYoVL/vHwwl6+PVo4Z+5OX3yB9QF4ZYUC?=
 =?us-ascii?Q?QssUVp5cMcx2GzL6mFxmY2wHHQ0yk9uOq0sC395dK/TI+ZeTY2xHvdsjZe4A?=
 =?us-ascii?Q?CpaB0y6x8ZGl2flPUUZvSuIdhq0IiigTTj14XxWXdEm18zTW5o76mYnvREtd?=
 =?us-ascii?Q?9ErDqjsimVIx5xRbuVHsVYz7jMV0pRezNNlxtFOpfAYnAxlHclSIUKCVBY+v?=
 =?us-ascii?Q?p8j2fCpma+eL6edCRsykCdlQnrszlIEmKL94JbY3zyhgxIf8/WBvd1zg8UsH?=
 =?us-ascii?Q?tb9n0qyLGHj/MJ/CTnzh6oB3aKzKIQ4PnMkWODE8vXO0ByPOfA5zXExsUfuh?=
 =?us-ascii?Q?cMS0zM0hDR91dm80tdZXdcURL5pRyNMvBsrLZV/s9fOuTinpr8QMLNwHYFNQ?=
 =?us-ascii?Q?OQU9WayXJpjtNh5araYomfYquRVEU9+rZVpoAyTBKELJtwUF5A6exSz1QwNK?=
 =?us-ascii?Q?U1DXsLz8WCHx7O3Ih+TeROKhqepNEKX6pSZgHSPwtx4AB+AflunX3n1vzrDw?=
 =?us-ascii?Q?MOI2i15EECycdZ4EpkDAyhaOzBGSq+YIdkJm4ueCIeTGWyE/7JaZsZfEX8YC?=
 =?us-ascii?Q?R+EI3Yry7oZdSq5dR3a0SCZn2nwgawXPfRX+vUDjeLUHuQLo3zz8LadbcWoV?=
 =?us-ascii?Q?UjXaHk16x0fSBxSXgO6FQRuDdA38uqyoIqev83j5J4OXM+A0QYSka9lyyFbC?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AYlFaNiTha/Y3ESihPfP6Bo0q5EkGn3ERPBJMSZWKq9tJ1kSBYmSUiANNy6/fdEjebSpitieL/tbHWqyeGVr3bky18T6NFJ2/zXY2RB0cdXhQb6g4HUKSP1isFWNhY9tOfefba0jJkTLgVD+Nbky8eReAhse6pCHEDEl0rbSPRyJSs2GndQV3cB80RRAKsBq/OzgDHxyrUGn+6NPbkPkfEgrVvWwaGeih09tRqWK/oVh1rQEc41imcrnhQAJcDapnJyR2WPBIZrvsLWSPLnf6y+38rxgXx/J7pOTFmkCJ5ydcyKG+tWFzfOMv+V3UcEGWcKkZ+GP2aMf4Q5OpfBXW1fA8KHti78Ee5uwESQU2nKYyPkEWP8uYXj8aV1Wn4E0sTe2PLI7Cn/HCRG4doChe/t6wquXqJq1SHrc5yfLxqdeFv/P7uVInC3QTW9tVCnFUAlSxQdFCqkIjJ57S03OqCEXMeammpkHPXaYBfDfXzTFypslbp2uAXo5YsCtOuB89TI7ZKTjcKr08BL4ahID9fkxoTFl6M85TYu6TWhpmAfG8sUNGTdc5nNENlqBftD5okAsg6xSPYYEyENUKnuS1iesGbhezmoYd6KvYtaoED5dC0tehWBnIqaVBdMigoOt7LSqVQv5xFPPmSNQhluO6prAntEIDtCnVx6JZ5XJqYS1BCHZzeIOTkQygslcgMc3J67um10tHBKlpGH2Ws3Sec2TxYrLDndv2Hh8Czrd/weAxWoRUVSToa8xm31E8V1+d2Yj/Es23DRV2bSY1jRM40n+GgIUyiw4Mh9Vq1gDwS4Spw5PA8ZeOvIYmiCqB4JfwssOaXv/WXIpwAk+LL8zlK7ofP85aGvOTTgvLk9yUCzxzfENNbAZb6gr1rYD2iDZ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad8715c-e96a-45a3-5b67-08db5677a5a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 01:40:08.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsYwxoYLCsnfEQsOjmmqJzWErVotEHznoqRBxKy7HSb7aoq9RMXf7RbOFZalXVJoBTLYSj7UYS5UYYSYZ2X8Ln9GRyYcktMO1lItEsGG9Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=935
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170012
X-Proofpoint-ORIG-GUID: NsP0l0fciDHREbzO62oOtpBggcOWqL2K
X-Proofpoint-GUID: NsP0l0fciDHREbzO62oOtpBggcOWqL2K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Azeem,

> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead to
> linear read overflows if a source string is not NUL-terminated [1]. In
> an effort to remove strlcpy() completely [2], replace strlcpy() here
> with strscpy(). No return values were used, so direct replacement is
> safe.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
