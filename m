Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33AA681AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbjA3T5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjA3T5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:57:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ABF3D0AB;
        Mon, 30 Jan 2023 11:57:35 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UHXhBD011874;
        Mon, 30 Jan 2023 19:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=g1jP3cdvFI/zvbYJ77Ge44NpJkobjOgl0GO44UZQsuw=;
 b=2YwSKr6QNHJ+ctW7a17HOKLNckWpkaB71HixhhGAP/0Wq5xIcAwU6y+YesN5AHUtU4O6
 /zWqRubIGZQIaUPhxVrQ4fPnBs3Ghn0MaFhinFLgqOrmfdKUeTWwD5sDkROXTMPcGL3D
 sOJRKCPwGo8MAyn60lxnN09BR25eSi9ngtezFV351JpDyVX70o2ArI78dlmxIdvEbR+f
 irnHUOoKvteCErTIY8ZCtCgGHUtkuSm9gCWMQK+d5p/3VhoXeXEyTipQGxhnNwf+TWs9
 csP96Dc3AIuDhuQH5h3R+8/XLSqHsucLRObA7vwaQ01ykBLlZ3wSyMIW65UMsAdjCJvl OQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvmhkukk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 19:57:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30UIGccI020456;
        Mon, 30 Jan 2023 19:57:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5bc4f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 19:57:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB6gcSmxNk4ZqGbDJCemf8etW6TyWHT36QgB25lwesVh2GizAFz+SJemoRZghcO2YFCzhmUfADKC6gq1qG4Q2HGQVQtVc+jjw7ZaJUnvqH3xpbShJfIC0Fp6UBq3aHBLwfsKDQhtu+nYKADKT4EY2+uiE7DDl8L3egHYQtSsz+LyH2P/+lFlGgkvpUmsHb0GI7Ce0WcNjToqvykG6KpBxkVtHlCgqCNacnAMx3wB3xuvy9bVs5oQyqBaRvYxcAvez3OOAlSaQmVuuKcdBLr7bNcXfHNTHl8Jnrrlaj6LzNSj4enrtVVa5jor9+RHJ1xsaTZdV4H/XfKgJo76LOOsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1jP3cdvFI/zvbYJ77Ge44NpJkobjOgl0GO44UZQsuw=;
 b=NTHzROOxo6i0QMBuTg0NjR3KHHmQ/D9O8YjcoqmWz7XsFxnolHj2FWLjRa6z2z2jo+ZJn+wFonj+gR4t/1TuNdyHNtCNwJ4klrAlDFkpXttmu7f+MWRm7tbxSsYpvEX15KydoTk+aINPGeIEUa9lehlvg+OCG7KvuYkS2mF29IXWo4PAsHmiqfBmGaT+RgGeio3A2U9Ih2wTDrTLdnIw0KuHvUdmWDngd+ok9Ha6JqLLOPQ1R0f4Y/Hbtz4+4AMY9r14JbUu8NOcyTJy1LlhSBYkND/5vcwEZ2EzAyEjXROJxkKtvsmWsr4XjxK9Bm09KEkaIPIXiArBJkd9Cnr8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1jP3cdvFI/zvbYJ77Ge44NpJkobjOgl0GO44UZQsuw=;
 b=VBIdMORkDVQYBkGAjhjGUVsacQ4Oqo8Ae0TCWAoOS55Mgq32bWb52dhTehD7/7desVvT53KRVGEpcSH4r12pOdxsGYhnCBavGAu1eclau0jJeOqvk+z912t92oczfeSR76lLux+a5tGs33HzX3awD9ft5gE4/nfNc6a4RCNzQeI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4776.namprd10.prod.outlook.com (2603:10b6:510:3f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.21; Mon, 30 Jan
 2023 19:57:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6064.021; Mon, 30 Jan 2023
 19:57:18 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-next@vger.kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm/mmap: Fix vma_merge() offset when expanding the next vma
Date:   Mon, 30 Jan 2023 14:57:13 -0500
Message-Id: <20230130195713.2881766-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4776:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3daeb5-41e1-4e0b-031d-08db02fc30f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0Qb1wvviP0x9lllg+iNfZctSeCGNCyyftSdO68gUt61xndlxdsDIK33AH1ml0NbK9TXkrfISELzwlSr01GVeymYuH23D18EFxGW+B+B+mAjF0OpHLortwLihj4rn3poE+D5wFtsahmnZFhlKO+bsrLVuXIW6o0Mdjeqheq53V5g5ZXtKo8P/SI3aMnc8tyk7K2xxEwA03H3VwJ0a8LF6N+xiUUI7BRaqJE1tb9cwPDd5jKEflBFdKnsHpwaeZ2XxfODBqVbfLCnIBPGgu1/6Ks7y819u4yFixMHdLKaT3WFgoRQYtv58XzpcC+eOS0AgjA50X7uc2nZjA6MStp8bl6WHIRb2yz1252uxES4f48tQQDiPwbcAgCSqBxxR/d24Dy0QzMk+BCnN+Xzcg0n5GvzgBTQE1Wf9PdyvSH1a9tWKTF2zmaK9xXmJx2xDhH/Ni7SmliMMRejNyUaDval22nkDkiJQpfwrVMLKP/jI3KCFO86BVqinA6yHtJPW8gW5Y9lPQ/7byLGhEpPzc/E7iI8iBjjETc4Q1WvlA930LHeFMRWuGTWBV0tGDq52QhwlGtn6/LzsBLgFKPTJKI50VmMZtlsQNIVCFaas4FyikW0rScMAICjGjiqsm+GvW+V6Sk9ZYNd1QOScT/NxO/N7iPnfBtojnPErdYtLxrOqs0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199018)(4326008)(41300700001)(8936002)(8676002)(66556008)(66476007)(6666004)(66946007)(316002)(966005)(54906003)(5660300002)(83380400001)(6486002)(36756003)(45080400002)(2906002)(26005)(478600001)(6512007)(186003)(1076003)(6506007)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v2zkBL6DiPjevqlVEO8XGJD1NDj/Ee+MlTeyh+7HLn+zGK9l9v+dGNBdcjSJ?=
 =?us-ascii?Q?3FSrE7+gP1I1Y+jzWrU6t0bhlrZV23j6exv5qoBYRnGKADq7YrfXsMuQd8cI?=
 =?us-ascii?Q?xQ1GQhP2VMTg1gJ7nctkvKqzcWzKcnPp0khMYvj/ip/5KaNeTnFfk5h4RGuP?=
 =?us-ascii?Q?OcLLa14b/JH8dZLSvq8DudMj0253jbxpPBLfCrwHUxmXNRT7D5j1qWS1GyE7?=
 =?us-ascii?Q?+yskSdPuoFpyIR/pJwh3Tvh/IDPI9XRplekVUJQUGTppmzWits/glNkhfB1e?=
 =?us-ascii?Q?NvzkW5MofpId2ggwngIXJ7Z7sBzanQiNzvBHCZ7UQi7X/e1ezhr7TyjSZGHE?=
 =?us-ascii?Q?xxbgyceReiljcUoPMaaOisfYK51JIoy9J5W3VYtigEhHgvQLiRZ5eLQP8cv2?=
 =?us-ascii?Q?up3iKlpO6+6PHv7pRoQ+fPLO3+81Fv6lun9DEVTlNEo4c8DnUv4hw2K7QhBN?=
 =?us-ascii?Q?svmawCyDAVVfM2ZWrhFe0+hqj+dW0mtgqADxXeWw7X1pcTZohwxA0CwGxvdk?=
 =?us-ascii?Q?fkRVz3Fe5/XW9eip0CDXMJCxf+yqgBYIFPvbv0vOaarpTqSeuzaIIVO85i5t?=
 =?us-ascii?Q?hZz8QO0KbQw1+rSx2UBXOO/9V0T299yKHlmm8Mq2SHr9JGyIhtdVaYoeBBSb?=
 =?us-ascii?Q?GbYbq+SyG86BdQ5QZJkr/se5y8cjdLdN9tedPa0DdYQ5dY9/FpstcuTrk50N?=
 =?us-ascii?Q?KllN238OUwU7OzzoK3aTMuLehoWOJ4hp8ZxNMTfnPvfAGJnl5EtCsDp5/Bo5?=
 =?us-ascii?Q?kFIPyGe0idXx152R6Uh07EiBVQhQX7d4M8o2VgFPYqL3SxxqE/c8sxe+7u5y?=
 =?us-ascii?Q?YOFITOK2Rpvm1ymfoWAmcNQlxCFPwhNryzgqtHqTT7iU3D/JUHpUy5r1SrOT?=
 =?us-ascii?Q?qCaUzqTrvqbFGuFGDYqrU1c5B5q5Q0XFuAQjLgVYKBIt5ZjomI3lx8F0s1ts?=
 =?us-ascii?Q?SrMnRf+LDdN9hJF77krJ+fhlqKTX3/zhx3+oe2cLTP+g4D1y1bOduYZXaQgg?=
 =?us-ascii?Q?BAlL0iWduHRuHhNbnVMPMNKPeZYQRGBPIwJQjBd6FHGX9ZphiIZqf1RI9YiW?=
 =?us-ascii?Q?ntu10tG8QhmyIyzPjF9zR1sWB2OdyxD6/5+6Ia4t/ehJlHJBxYZYv8bpNYTS?=
 =?us-ascii?Q?bCuQ41LJyJhE2EExlp409Rkv/qddnJOf91IUhIj6clfNbfWIl7gn6qvzBsr3?=
 =?us-ascii?Q?AQrISJ1CB28W73+RK+4qKMkMXNXWRkf9qXU3g+38KLbYcBly5rmMMkzQkb66?=
 =?us-ascii?Q?CfPOOhgPyUg1amel1J7R/+yVA9TkLh92UUww4zB3jEBSBMF6ChbjI/yyTqqO?=
 =?us-ascii?Q?BaqUtOsBDEqllJ74l+w0lt0v/Nmtolrnuq+y+Ql4ZAp//Scfd+PqZfIkVx0N?=
 =?us-ascii?Q?LWkdecpbzZPRSJLu6MW768O8qa8AgFGWZkJqt9dLKquZ1z7Wj0KG8CdWu79r?=
 =?us-ascii?Q?VV6AkmE0UDVyVxWVwX3ie3TI/NSB/1kwV1ltUhd+57qWKhjS96FVfUaqreQE?=
 =?us-ascii?Q?BXGvnLmp/VYGaXaeGwY7kr2CDNeB4LDx6T16b72rlKb4+QKZF0r4S0nMNicU?=
 =?us-ascii?Q?4hvPozWVMTyNSNLPOAHxNn0xzXE2+bkS5O/KrXefzmmDP0wMf7lD6aWXuSzu?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?10L78aqx/cyFWXyiKSN4pdU4cLQ1cnLWK+69Cah6V8sfP9J0ATssZAp2z+oE?=
 =?us-ascii?Q?GW9gn0935SSzp3grKpqjQ4hyy7+MLJT36lnKZHx8/ubQMhXNguOYUxg/1gJ9?=
 =?us-ascii?Q?LZxbQn7RXzdPGvZ5QZJSPIQjQV/t2XHpAIp1kaUTRY7THbRmudo7etWBoipZ?=
 =?us-ascii?Q?ihL4ULgygSaRW1j1iZFIURWuKXZhEmM/I3jieDjmzh9veK3TdPtaVwn2rBoV?=
 =?us-ascii?Q?NtX1iPK7Dij1VyaU68n4Hc/zJ2nPrkgXPCS3CReD8LXTaTd6WOQo0in65Yyl?=
 =?us-ascii?Q?UpdXbc1sadTizUOC4H7dhDZk0txJIYkHzKAzBnj+FCBwBnf5dQcSap20tlsx?=
 =?us-ascii?Q?ANDUjAFjIIxlrQ9CubBNBT1rPv0XSOLg1hCz3VtnU8HxUcY++EgMWKlV93vB?=
 =?us-ascii?Q?ZgNeV7mh/AXbwkhGJXV5ROPyv4w/CVD0+tb9SwBai1tqWBIwXya2NluyRJrD?=
 =?us-ascii?Q?NpVWaHCcsgMyfvy+YpMYwoXrDnt9I93iE3z/D9GjE9XFJJ2NOFWiwCzyeQTH?=
 =?us-ascii?Q?wH9oil8wtMJe97/C06lT2XHrEkhoR3QijFjTTKtU8k3c+/TI4wdXnbWRm09t?=
 =?us-ascii?Q?2Mz+oqNydOWpxscLBRN38qe2TdkE5pbfRhYyr/5gSKi8iEs8lQAwgZ2Rg0Ck?=
 =?us-ascii?Q?pdvafrxN7HSAMh80Tm45BZTXidame1iPwPdUqJOrhjxobHwb+qHLJeF6eHBB?=
 =?us-ascii?Q?QsMPYlOjBniJ+DUP9HHCU7N83rKunytSr56/AfYMML8GXKk+RmGSx04xknaA?=
 =?us-ascii?Q?JWEKnWeplAZ/pPgg+L4hTl0FPl6pUWw5PjXlPCivlTdgJ2xUdIX8qjmWMczX?=
 =?us-ascii?Q?h/742TRXN7vVRi15GPgt8JebgSx6pKoxX4jvJ718umLlYDOzTBxwZg89GZgb?=
 =?us-ascii?Q?pkXr5Ufs08zrlAhb+hka9ioiYyXp/FAYPoKWB6stCIW367Nb/yACZBymguBC?=
 =?us-ascii?Q?ooUEqJE5KbPWl2U87mV3NAq4pPzYIqC6rcs14/n4JqjjmiS66rHy1eplcmv6?=
 =?us-ascii?Q?i8Jqn2wKFCry/zWNfe7eT61ZoQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3daeb5-41e1-4e0b-031d-08db02fc30f1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 19:57:18.0266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBbId8tAZFcyqc+L7w3sN++MVcSuWapJKfcNMZ926k589SpZkwRWtzitI0/bJtJoY/oaDHVJx042jeR4MFuhvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4776
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=952
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300186
X-Proofpoint-ORIG-GUID: o_47QlAEe9vK1DVzYIAuNOXBdt8CKP_X
X-Proofpoint-GUID: o_47QlAEe9vK1DVzYIAuNOXBdt8CKP_X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vm_pgoff was being set incorrectly when expanding the next VMA to a
lower address.  Fix the issue by using the mid->vm_pgoff value for this
merge case (aka case 8).  Note that this does not change case 3's
vm_pgoff as next and mid are the same VMA.

Reported-by: Sanan Hasanov <sanan.hasanov@knights.ucf.edu>
Link: https://lore.kernel.org/linux-mm/IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com/
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 00d90bbc250e..614ea2d93b0a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -978,7 +978,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma = next;			/* case 3 */
 			vma_start = addr;
 			vma_end = next->vm_end;
-			vma_pgoff = next->vm_pgoff;
+			vma_pgoff = mid->vm_pgoff;
 			err = 0;
 			if (mid != next) {		/* case 8 */
 				remove = mid;
-- 
2.39.0

