Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1921D65C73C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjACTQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbjACTPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:15:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2451409C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:14:31 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303G3gkY002803;
        Tue, 3 Jan 2023 19:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Got+/JhlEbn00M0JyDO+i+N0rLTksWw+LVmAVXZxyq0=;
 b=sQbix2s5B2oXoDrDKOqFM30ToN68i7RjI/TvYtVbZUEvXPACUkUuk1qptiKh1l4kv2ff
 Hoo/x89KXX7SLun1I6PfotxLOXGpp+MU65sfqF8KAldNnzA9HmRcNMcBjVppncqfThd2
 RdewSUnS5YBc5dzC4Vv4niJ12+c1tudw1JeWtN3NgAyQL1vVYhrXZCMbjhDUMZsUuU6I
 GXtcL7AglsBr6HtfQD99rDwoV356OB36yB0tUlYWeO7f97FwUsS0uwAcaLwCYugm/9wh
 TfoVPwpNJcQKiYAfFGfRTbzCHU9MMohLtfLESknjyIhvUapfqVaGLxG/ifq6PJqCPTKN zw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcpt4w39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303ISTnK012266;
        Tue, 3 Jan 2023 19:13:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbh58q1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McgaTY1uzXWVRuOjCXiC29mVE4X8gKceCPBETOtC5gotSKSCKZ1NhVnN9DAbu0PaJrtJVJSDhSVKbGZRAlTUCbB4vPhpNSH61oMZcxjmutXnyGS1363ckfQnF28k0ANqLdt1+EHGI1ylfoiDTMT0gLKw6h85cKsHbcLRWa8CI3nWZnnilSS+BXa7QWCBgMErmJtKL/WLQ6UG5t/qs6hiMeaqFPIUCNtGVqmEOrSeZFLo/Fp8j0falAdFQdf7QGZY1Gj2MxsTxUhfXF5OSC/TtgrD5UWTq+KqNeJ0VkESyh/7xBK2gYZLQallQmUAr+ZPldpDOSYn4sMWy3mELi+OLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Got+/JhlEbn00M0JyDO+i+N0rLTksWw+LVmAVXZxyq0=;
 b=fK68sB+ErNdoFI3gW795pCcVVanj0efk3f4Glchc2Yi+qBbpbeWuG5qgNrbyEsDaRYvYSuXkwImn0WW15ogXX/UHTvUc4Syuf3tYV7yxVMQ45IGPlJi635nor0OJu0uwFg8MmUInOAQ8B+o/hlMGPFy1mwJdSU3N0k6iXbKAsuyR2v1yH9T/oTlL7hzYgr+VdcqjHG9yMFHqA+kfXnn227uLIJ/dTvw/WN99W42k2dfwqnw/WJ5GIq4Rztl8HkzQ2QXoyi2wxDEDQDEtQhlMLy+FVklapOnk380yW0XqJrUgT3Wi6QWOSEdvLR+qW/1U6d8almRBxQKG2+IuKVjA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Got+/JhlEbn00M0JyDO+i+N0rLTksWw+LVmAVXZxyq0=;
 b=Cu8CCfW4l44t8iV9Fh75a3AQ1XjMETZQU27unL1lBoDqEGnO0y61ymKe6LmE84bANyyOG1XpmQ70l0mBjJXdhSVF01q6q5lYUSPEhoJazNn8B47tKFwxaZlai65mVMEcQQrf0hdTiS2yyFQtvh+7EhXVGGtPWlBRorpP5+WwYgk=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7332.namprd10.prod.outlook.com (2603:10b6:610:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:13:54 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:13:54 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        jhubbard@nvidia.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 6/8] mm/hugetlb: convert alloc_migrate_huge_page to folios
Date:   Tue,  3 Jan 2023 13:13:38 -0600
Message-Id: <20230103191340.116536-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:610:58::24) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d897179-a488-4ade-0f99-08daedbea7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FGS2JXdQ6uqI1yyOV6RWxxposKF3Jj5vNCCv1euCYb3SRQ0GEEd83fpQqK2UKiWaS85lfvh6N0cRiFKZPXMmps80jg1sqH6LeFddhYG7j0WPJ67xKEEdi/OUM+OBBnof9ST3sYIz7kwRjVa98qmH2HYvWvkiD/C340xbrjFCHMq3FoDkoF6h8p4dfmR7H+UiZEtwgZM4kljfDgay+XefmxEwgArTdMP/P76NvdAqJFe2IBXxL0hmZWY60d16SGo+dTbksi2fKh76sFkatRW1byjPf9CaN7OZFBMu5vsQLxQ2uFLzMjdve7pMjW1anw1/iDoPdgtq1kUugTq+GfF8L2hyyFeZsipX9EBKguBamAVjbpUGyDtmy2WQflMrjI8jbi31s7lnI+szchZokZYGRge4P7Hp65gs2845MkCJKQOHKajW5mhIYZVHsycaj3BlfxiLi7Cuen8NpqPI9t/sInI956i6H0u/v7wvmsEt5MnFhGWPclVifSHfgkh3RlxDWjGC438GE6msyIwoxLeZm5Xj3Q3X7t5nK6h+9JmSTnFnyBBT2cO/EvmSpdMdCZGQMHeE28fJcht3Icdbd+txZCsQ9+1T2Bapd0ACG/flLI90vvXWGeioOiBMswW6YkNxhEqm3mMHADngQSqsJeCPjvC3x1MWFitYuesXm/FfDdI7O3Hi0kk6KnTLh6txZXh3JnV01+B55gXq9mYCqTH7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(5660300002)(2906002)(44832011)(8936002)(8676002)(4326008)(41300700001)(478600001)(316002)(66476007)(66946007)(66556008)(6486002)(107886003)(26005)(6512007)(6506007)(6666004)(83380400001)(1076003)(186003)(38100700002)(2616005)(86362001)(36756003)(22166006)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CeHWXLplE0WHpEukUVK5iKKbQdaLk4kUnPNYDEp41IsItpiRAFuw+DbK/Bkg?=
 =?us-ascii?Q?o+MUYZcswYPPbFHQsr46gMZzwYHBm2p1RSJtS+PkroU9ZmX31+v6Vy0+i5bS?=
 =?us-ascii?Q?dFHyMABd/aGm3Y/OnOaN2Nc/iYTkYySgKvQW5HJYILeKfYclDWZ8j2i3qR4i?=
 =?us-ascii?Q?Ga2O+JNMLEA8OEO/7ZYF+kz0v0NtRXvSkLH6sfeKjlrKv1oHEqQfNElsdX2Y?=
 =?us-ascii?Q?LvUoppLdx3VpbchR8egGpA5TzdjCtKhUsDEldOZjuI7DTUqPSHLoVGcW24Ur?=
 =?us-ascii?Q?xx5Qxl2+AaiEl0AAAXm0QIiqC8J+xcZgwmRaSGHobTMqelX6aqbbw5NpvJAz?=
 =?us-ascii?Q?+MfQ5XctODdAqiMaDU9WaDAzX6HEd43gH2k7BOrwVDrZJJIGCxoOgYBLvEBt?=
 =?us-ascii?Q?ysolmJkzwhI7dTnFAaS3e1tb2T80V4AYyMdLfbBPeIjQddoU1wIbJLczCI+V?=
 =?us-ascii?Q?G/zQ5FuJP7uQma2ir3h92dbRIWEbA4hDPHcY7XBdZtukso8Tt1gUG6AKXMqy?=
 =?us-ascii?Q?TKxsOnrEMLBQh/MwIaFlA4PI2n3gNo4RBI0fynY0ma12wDBiz67rn0QskIjm?=
 =?us-ascii?Q?fgE+Z1B7P/ZReVp+TzGr6lmHIWz/gq+b57fNQDMiEzwvbm/vVMrsOKIg0M5L?=
 =?us-ascii?Q?w2cvIMUUxo9rXoqnRnEG9J5JoFur0arAiHx8StfEn/JYzRbI744FcTGj9yI8?=
 =?us-ascii?Q?XLp25xkypwResbAqDN64t08vX+Y7GMxXM46DjvFfCz+hdkKfu8XyXN9htitz?=
 =?us-ascii?Q?C5r/2r0IPsvY0GmMzR6EGAv9GWNElvmnI0itrnzncMYPU+DHUrLiVX0Qj37h?=
 =?us-ascii?Q?7MWhIVrsNeJ/y5Jz7UlAE9poC7HpbBBYYYo2IlTWk5eeEv+ATI0GOZoV5TiT?=
 =?us-ascii?Q?xgGXDngkuCRbJHO527PoBMYHhMWBbBO1oDvBkK1E8U9No0SV0O3zV+H3lSVE?=
 =?us-ascii?Q?xi2LKEFmI5xKGHAGJh+a/eyLxWoQ4zRKvmvayQfhaIs6BF+63Z7rH2J1BcRa?=
 =?us-ascii?Q?GDScw9ZEEpNbXl+dvx9BaCeBUR/1a3FjmnLT7KsGpCM7lZxiz62dp0z89v6/?=
 =?us-ascii?Q?TRHhAftXO5qRcAGdBLHulMdrny/jX44E1z6fPRWQJch0SuxsDEH62MAtSeIW?=
 =?us-ascii?Q?Tc4nq/a6WgLkNtrRKe9W5M29zk7RTIgnAFpmbd0fXMpXPDLm09YCejgyMF0j?=
 =?us-ascii?Q?k1JldTUwYGy8EG5uaDhylfS3n546u+ObbTTxduXTK2/JFiqJjzsXWZ/ePxS/?=
 =?us-ascii?Q?earFVtBHsexdutbszolci7KljKVgGrmlqrndm6hE3IxCtugKfMS1GsCOpVru?=
 =?us-ascii?Q?YjNGmjTLCsVsvolJFUYvpfE+0kI+O2NRpXq+iL6cuybrJkNmA46eAKOl2gor?=
 =?us-ascii?Q?fzlohlsH5hKKTYAAhqhooeg3NBl83bUDy3mxHhTARmQT+axpe5r1nbXWrcLL?=
 =?us-ascii?Q?II+l6fm8QJn3r+suHpn7qZTTmZ6Eh6UznoEbBBTU8cOrYSSb5IQwP0v8vh1p?=
 =?us-ascii?Q?LEfc+GYUFaZya0glOUKso052glr2vtEitoHaMxmwRXD9qEbd6jWl9jFAguzn?=
 =?us-ascii?Q?PXaAltU04bQRP7LLX+YpYoQBo5fnEAhf4UasYKs52YYoZ+N7ZuyEP5oRtrRL?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/xRf5i9sK1xaGS/w4kEBJjWn6RM1RLqIsiKYgqy0y6Qsz23HbA7A7WjftdLM?=
 =?us-ascii?Q?7rREC7fNjldG8pVtzC3TigGkkRxgAO7MwBT6zOyPoaEk5z1AW/RgIYJoPDZW?=
 =?us-ascii?Q?I9ei777/rHUJBx0YqDXVR+FFA4gUsWZRiJUgq7ZStaGyxp3srvgUUihwe25t?=
 =?us-ascii?Q?FnVv0GIzyLCqcGdvfmttX4ifEkIUMrDj6mr5f2amsZlFxgp6Kz6SK/xwIT5P?=
 =?us-ascii?Q?Mjj9nm9w/NB8dnizjjH5wGQ8fs6qq5zpCdn4sgb8fnGbctu/2ApXYjmI18zZ?=
 =?us-ascii?Q?2E3O7CQdW5DL1Pgv25GrMF53rME4Jn7LWFntsF9vo0dFxUsUQkm8dfDvJjJC?=
 =?us-ascii?Q?3XE/CAaxHzk2B5GG88anCU9dI2t4fW7ksW535o4aWwr/COyhWKkW+s5A8dOo?=
 =?us-ascii?Q?MeEVu4X+NTr3myTZmUM77TZa1KqFo/1rmVR498sKOq+hrdoo3tzLzYnUzAhb?=
 =?us-ascii?Q?KKz+UdvCSA3OgAffP4BJJQN/lkcaVTOBYaUP5rWXwAtgH1xXp8hBiOF+DxnW?=
 =?us-ascii?Q?P8uarg0W4VcJDgvTRax5yiUIhpOHWMErHMoUMjpcL1Is20WWRjXrDddkhzR9?=
 =?us-ascii?Q?ZMgFWxb0eNlXhaKFdWAgsFeLx0rqq0MgoBiZgQ9wZqmPt/u8I6W8xkZ5JX11?=
 =?us-ascii?Q?S9mqx5ggFgGs8WId0fcapIIV3JdVckKZpoYABxq4ys1fjE2PpAGxdTtglzCz?=
 =?us-ascii?Q?6KKm6cu2Z7jhf8M3oobqr+cU1H6Z1MiV6IKGNc+r/Gmhyd5qVz4N7wD1o0Pt?=
 =?us-ascii?Q?jgPKMPm4KF5zpyFllRhrqOfnez2x/ihC2/Y5qoCzSU2Xccq06EXzomkxuMuf?=
 =?us-ascii?Q?a0ygDv8gvJn/RWRETNbCSOqUxrpmCC/svKgo2qTY2bLiC8HFHRb2qr+mDF3O?=
 =?us-ascii?Q?DtIcTIs8m0GLIq+sTwOtAyXjNEgMDWnWYk6Lt+J4gyIad5UnRLmNbO7curjt?=
 =?us-ascii?Q?fq5DKFuKe/jtl5/bx1QaQa6ewzeySM1lgx6rzC+2Z6I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d897179-a488-4ade-0f99-08daedbea7df
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:13:54.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVxvdyv46VSJHrQ+8Dk0Vf/J+wgBwN7kKFbFieuvMEsU1ZcirYXvH6DoDa5N7xEreINOzaNbXrZ6WLGeV0OzXOsKlZ6N41FuiRcn9k7leMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030165
X-Proofpoint-ORIG-GUID: q05cFM0JuZvSUymM15PuDO91ftZAePl0
X-Proofpoint-GUID: q05cFM0JuZvSUymM15PuDO91ftZAePl0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change alloc_huge_page_nodemask() to alloc_hugetlb_folio_nodemask() and
alloc_migrate_huge_page() to alloc_migrate_hugetlb_folio(). Both functions
now return a folio rather than a page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h |  6 +++---
 mm/hugetlb.c            | 18 +++++++++---------
 mm/migrate.c            |  5 ++++-
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 482929b2d044..a853c13d8308 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -680,7 +680,7 @@ struct huge_bootmem_page {
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
-struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
+struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
@@ -1001,8 +1001,8 @@ static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 	return NULL;
 }
 
-static inline struct page *
-alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
+static inline struct folio *
+alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 			nodemask_t *nmask, gfp_t gfp_mask)
 {
 	return NULL;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 640ca4eaccf2..0db01718d1c3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2278,7 +2278,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 	return folio;
 }
 
-static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
+static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mask,
 				     int nid, nodemask_t *nmask)
 {
 	struct folio *folio;
@@ -2298,7 +2298,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 */
 	folio_set_hugetlb_temporary(folio);
 
-	return &folio->page;
+	return folio;
 }
 
 /*
@@ -2331,8 +2331,8 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 	return folio;
 }
 
-/* page migration callback function */
-struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
+/* folio migration callback function */
+struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 		nodemask_t *nmask, gfp_t gfp_mask)
 {
 	spin_lock_irq(&hugetlb_lock);
@@ -2343,12 +2343,12 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 						preferred_nid, nmask);
 		if (folio) {
 			spin_unlock_irq(&hugetlb_lock);
-			return &folio->page;
+			return folio;
 		}
 	}
 	spin_unlock_irq(&hugetlb_lock);
 
-	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
+	return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, nmask);
 }
 
 /* mempolicy aware migration callback */
@@ -2357,16 +2357,16 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 {
 	struct mempolicy *mpol;
 	nodemask_t *nodemask;
-	struct page *page;
+	struct folio *folio;
 	gfp_t gfp_mask;
 	int node;
 
 	gfp_mask = htlb_alloc_mask(h);
 	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask);
+	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
 	mpol_cond_put(mpol);
 
-	return page;
+	return &folio->page;
 }
 
 /*
diff --git a/mm/migrate.c b/mm/migrate.c
index 6932b3d5a9dd..fab706b78be1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1622,6 +1622,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 	struct migration_target_control *mtc;
 	gfp_t gfp_mask;
 	unsigned int order = 0;
+	struct folio *hugetlb_folio = NULL;
 	struct folio *new_folio = NULL;
 	int nid;
 	int zidx;
@@ -1636,7 +1637,9 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 		struct hstate *h = folio_hstate(folio);
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
-		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
+		hugetlb_folio = alloc_hugetlb_folio_nodemask(h, nid,
+						mtc->nmask, gfp_mask);
+		return &hugetlb_folio->page;
 	}
 
 	if (folio_test_large(folio)) {
-- 
2.39.0

