Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E68A6CAE2B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjC0THy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjC0THu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:07:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A89A1FEC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:07:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RJ5F5g016475;
        Mon, 27 Mar 2023 19:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=sF5HQVvB9dOyc4hYY5megikUFknxk+3O6Di69A1QnvA=;
 b=clDRe0vRZ2CA6xoqYWZPr2/cwvjp6d+uzMkcFK+LHvBnAPxTooO33fFuv1CgSeYXfDnN
 ELsSomgP6W7/3Sx+GhUBnHis/SdGYGNrHLbToHW4Kyjr7l8J80yi8Ho6VVmxvUwWItuI
 r8a4hyG2nlc6bT5fPOVVTVWIGr1yhJKfsVDZOrpFuvhw+FYjMmqZQCR06PRnysqExBkZ
 nsHvKdKW3eVh7C+q6FcPXPn5JexVxQ3x43R2hBbZLOS/FeVsXWbnHUzQs+XicbIBdqU/
 6/G+cqL4YUlpdwGQusVFVPqt1wrhaiFym+QiyveHrzIM2YD9Vk7iqpkHyCP1CzWBG1NT jA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkgyw005e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 19:07:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RIO08j032313;
        Mon, 27 Mar 2023 18:55:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdd4vhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 18:55:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEyya39xerJ5y+7i2+CJ9RhkfyW4vxcuElSmodYjy26ATdPx0wGyVukud++BLirJJsS4r0KyJGkk3sJ2UXRrcvsOQ0JHd3M4DIvEOiZu956DSEanph0/1quHld9PykG/8CaevmsBBCHdOyRiVQVrYh1cyQktdkIX47HElNFpgBFBUl9ohSvOUDHauodY25xiGd14nTPIGHLhx8ZxHMsUIq1PMuoDNeSBthwXsNKIhXvOKDRk1vZ5J2P0fEWs9q26qN/e2+VbeuVdXZtp+hJbZ7qOyxQnBiEGDhhzmaCvqhJgYH60soPKVkg+UBXWmuhokJOkSVswsBxQPHIXeyTLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF5HQVvB9dOyc4hYY5megikUFknxk+3O6Di69A1QnvA=;
 b=LMc0uq6TBdQxYR7SxbgMWy3PL6NBV/GAr1tyqfcVb9cMcbvy6uuMc/uFpl7qyChZIiv72no5a76ZLcTxcivLJEQ2g9aoaokbuEPoC1cWETmYEo8HvFLKQ/e9gstJvxhZ/5G+rUmqdIgX/CushlvOok3CsEZ7pqOk611jBE9uQJOgbIPf8prKdkjEkNg+FoRQYjZjRLRFZPz/XIC/xoJ02bUeFBDSTfjnto+XAwRapsMXvh+IZppPc6csqZmXTGQrSzRCNZFWJaL5Xa8CgueMj85QleofNRdFQdqNUWRY6c5fr7lH75kByiZQrEPj9SO+tR4N6XLTpDvSU5tBfqNblg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF5HQVvB9dOyc4hYY5megikUFknxk+3O6Di69A1QnvA=;
 b=qoS4lRMT+WFydTMTFK4rHNqYQAmE7pSxPOqtmkb2kzYkDcg+q+l05jsIa73fVE5mRqKrGnMhZYf/w/dq+5F7NEFW1//tBd3dHeGW+phmXruY92a9xPqup6o0rT36W6Bq99TsKvv3g21lo0jG8cHIn7ExUiFDmVzlMaDkuiq1hxw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5722.namprd10.prod.outlook.com (2603:10b6:510:126::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:55:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::9fc8:73bb:cc29:9060]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::9fc8:73bb:cc29:9060%5]) with mapi id 15.20.6222.029; Mon, 27 Mar 2023
 18:55:35 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 0/8] Fix VMA tree modification under mmap read lock
Date:   Mon, 27 Mar 2023 14:55:24 -0400
Message-Id: <20230327185532.2354250-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d16b62-7505-4a8e-78a5-08db2ef4d921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aftyUbk3NtZW9jpRih3nT1v8EswpBmFRAfIw+y+2J9Y9KdVjA10WaFQpnSbgdgb858h1otktW629W/vLeiTkfZvv0tae4j3XwCvbrD5C0QlSjDhVa1TP/HPM/EjbyQP17lMpxC65fU19Bu4TdCLvQz3Zwbi6J9r+z/jDqMbADxhA80KWqddei1m3MdKtFZEl7N8uzX/CJZm9ulcEdpFkXnND3KC8bTCR7lyXr9tSpQf/j3G3RcyfpQ1Qg77NR4bH/VKRvAlWBo5RdpXhfHaU+Ha5roNCgq0W7ESRKDTQFJfpQhisqRXYNyTizdpKWeevHmzDVfHNUfTZoOKSWrC1BBGnF5ldOQMvg2AznOK0DG42lkUmHAfAV6bG6C/UISJaZ8/smCfF2mC6/c0IU0+LC0bEbJH5d35XnQyIJuQfEkESOTLomMjXSSfN0EFTZ3NFbwygaIMkJi1x5J+zxo275ydv+wlWKyuvEVcv6Ak/XVIu3dahoYhEU69bBjVrol+Xcn+EhGI/A+CnPPvGzR8duV14nZvlx4OLq+L4dLTZX8N7zlJR5radveellJZAvaCo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(2906002)(38100700002)(83380400001)(36756003)(5660300002)(41300700001)(8936002)(86362001)(2616005)(6666004)(107886003)(110136005)(6506007)(1076003)(6512007)(26005)(316002)(6486002)(478600001)(186003)(4326008)(8676002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e2lUf+rs2AowMbs8IsKTQhe8Nim2Yz3DumizGY6t59Zczf5NGnwOAP5eUQTr?=
 =?us-ascii?Q?viQuCcDPhun/SPFAXRFOQo3+3E4wUNCx3j605xAAt1Kp3wsyRak67vVQWXQ0?=
 =?us-ascii?Q?1mKtc2OQ+VGfaDO+reNJNLvnEzssOdfwy9aCbnZf0Ua2FLwWHdtEkHp1NSik?=
 =?us-ascii?Q?7SRZPJSnRVvHQHRLX6QFMrHFKI9Ai+x0NP1eGCkAiQql70SwNQxWAzLS5Spl?=
 =?us-ascii?Q?7YmjCK/GL1GC42bm5wIdcOLlaF4GUl33k/DQapSQ2Deu7IeAcv/G6ad8b7+h?=
 =?us-ascii?Q?MTtXGFCf5eyt9XQHid0xuSV0NtBPtwZYrAb1tByTJDToUP4t8ke8lIQNhpeg?=
 =?us-ascii?Q?iC9mjsP+HO9/X5O7m8xBYnkz52/laKmPsQmN9L4DXMAqz07l8pG4Tu++ey2V?=
 =?us-ascii?Q?1/1SyfgRDhrZV4DqsvM/njo6VBNDkQ5Hf+N2gP2NWdiXVxyBwNsfVVPkwZL/?=
 =?us-ascii?Q?lBB+18XuFwbB26C0xYWY5bxirn2Ue5/o622SBe4+V43Id5KDqqj6MPs2ob7H?=
 =?us-ascii?Q?14lgtK1hW9N91ZxUC6t+qQIMUcUkCsiwKdkji2iz2gpRc9RuFt56asFeZVxw?=
 =?us-ascii?Q?KM1Uexk7Lhxi+aZL5r3q6E3E+mgXzNgojSopGaBhehD4UswDDp8nv2XnLb8c?=
 =?us-ascii?Q?0cu2RVBQtdl8ertCcnuTCopEVMJQVl91ljexuux3m8ZEHE8h3KBiJaaiTIS0?=
 =?us-ascii?Q?WbgJ6mqGDkWUC1nytr18QmfUu1o+N5GFaCVwS9JVlI9cwo9wHNjGiIlMWwF0?=
 =?us-ascii?Q?skQgiOWunezFR2v7jJTB1mph3iKEt7nF/sS86EGM9fiIOPyQiVbdLtJAsIL6?=
 =?us-ascii?Q?WFZ7h5z0Da1gKSBdMkAm6hEwhyYa4WBPtVnnpUBb5xPSjz4DFxfSTpkGeck9?=
 =?us-ascii?Q?C/D2eiqeiGtqX+H/nS389d+VeIwvGfn0ClTwPKR+QgifOyYlxZYB21SvqkHY?=
 =?us-ascii?Q?KQpPCwGQlUeUUkDrBF7rfGOCieqM0MkUIjvx4F6vMDXGbgE+oqgfCymN+en9?=
 =?us-ascii?Q?G/pe68xynWqqw8pT/HlT8t+OkR7Vgbj9wRSeBDZ429Z1UAvFUDSREtNprSwK?=
 =?us-ascii?Q?zcP7m/EQWLMEUy0uKPUz8RoiafOTSWpASS6sIg1i9Suvz8Yfq0D37jYh57g1?=
 =?us-ascii?Q?LDW00z43fAtjXfz6mJIamv0cBH+eKJu8zlOSEm68JUozwK2liJWshLQ8Nb8e?=
 =?us-ascii?Q?uw6Yu9bnRQrwg4xqs+gYZiYgX4+L5YywFW2NVCIZNkvrrp6fBf1vN+L3W/Tg?=
 =?us-ascii?Q?umvljipfORshNmJX5V6XgfpVoT+EPUdPeSKxEEotirm/jmWwl5zrOiKDxLUX?=
 =?us-ascii?Q?sK00h1GkK52cbaJ+dAuWab+p+napVVDcM8/x46+SmgSoGt9H0F06+rLn6/Wg?=
 =?us-ascii?Q?B1yTnYjkc0HroesLoU2aGDXkrVy296lbzjHX2W2zE1aKA+KM12Q89SI0m4jA?=
 =?us-ascii?Q?xQPc5+CrO3TvVd785b7mfbG4ILdXzUMkhycFQF5/XA4JZ6ka/fnzYeU20r7r?=
 =?us-ascii?Q?4BMsOeF5WQ1FSmryohfCF9vqY1WxLOfaEgiQIr89B1Jebek1Hk45YR22Tb85?=
 =?us-ascii?Q?O+fbSpH8DJS74Quu7yIU7Pwnxnpbm2bpIQyvUczPnphLQvUVkilp+DxqCFRL?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+4TwBHRM0jCvbqXDmbsQJG5bf5meJWF6r11pQF6ivlAKBpI/tw/+UulOLwcM?=
 =?us-ascii?Q?ri7wcTuccfHgh+OWrDpKf16XP3PjxOWmfYyiKfoQusr9b3Mp/cskUBQaRIbY?=
 =?us-ascii?Q?xGVrgH6jTMEHcDUP1LkA3F21YZgTj+0x8c8gJg4PBbCqlM6fcgZNIiUHuyRV?=
 =?us-ascii?Q?sdnzHHTLwelkvBVhHjKfhE3t7D1Q4EIyyU0lDZ1s0biulyuuJ/oZ8QwgevkZ?=
 =?us-ascii?Q?EFwTJR0GhpTo8ICKc1S10I8V/NUAHt7T/nQQjxJOY37/siwUE5CDNvOBI//b?=
 =?us-ascii?Q?iFhtx/uX3tRn9Oh/MsfFk0B5mgN7ca31fXXR2OxQQlzAACMi1ipG0vU3dTBh?=
 =?us-ascii?Q?xR8AGrb5za46A2ZaE7LXX4v4KF4P8Imwc6gbFD11rUPxEf4eCqAt4A1U78uu?=
 =?us-ascii?Q?2jPLOACL5WGXxoF5kXOX0havgYV//0ol6Y+/v9r7kLIdCsN1AXv4vqqHVEJx?=
 =?us-ascii?Q?+chm8/9SzumlUksP/vZ3ssSNFl9QkFyMPf3/TKHY8lNOsXw5dndXTwleUPyG?=
 =?us-ascii?Q?iLmMqdcIJV+xWmO9QxKzMTXTcf0u1s/1nJnyVZLe5L2z1JZ4jdC/gj3Ir8+a?=
 =?us-ascii?Q?4ATdH7ieUZzkRfD5i6X+lKjoXfSqsFVILKMjKFYRGH5nzX+vJTLJ9YH0Ydmm?=
 =?us-ascii?Q?iXiUU3aDqAkj/j3McZkuVAgJfAh+mkITtzUo3MVV/SXi0w81R2Z2LNw8eIGq?=
 =?us-ascii?Q?gpq5Riilr9R8d8hSQ1vEIabkmbvtB/TDEFj4dw7/EILWZomwqeCwhYUxTT71?=
 =?us-ascii?Q?otb7OJ3nAV8Byz2tHUwj04qwBxqAzZ3pRKXbSnIvfvAM4cOC2cbtJyvBl8a2?=
 =?us-ascii?Q?YGqDMe6MAOruFE7+z1oGnHHhTqE1xv5XQBC4N+UHyHsskAFxNHRZ/H8iPa+8?=
 =?us-ascii?Q?Bo+afxFH29hZYUPLEVEM8g/1pvbupmIY5zTsMVgMOdYASy4JJ7eYMrN7IFWU?=
 =?us-ascii?Q?OK9x5/eCCznjE5VBLOiSlQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d16b62-7505-4a8e-78a5-08db2ef4d921
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:55:35.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVb83GDwElHUf20Hh4etuxPizmV7+fy1QUwujlHXfTSQDi/xF1H7zpGEB0nq8Pvr7DLahXgpm59/4b8E81xF9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=636 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270155
X-Proofpoint-GUID: L81HgIQV74KSefx4wsPQWaiPDimHexDJ
X-Proofpoint-ORIG-GUID: L81HgIQV74KSefx4wsPQWaiPDimHexDJ
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported a BUG_ON in mm/mmap.c which was found to be caused
by an inconsistency between threads walking the VMA maple tree.
The inconsistency is caused by the page fault handler modifying the
maple tree while holding the mmap_lock for read.

This only happens for stack VMAs.  We had thought this was safe as it only
modifies a single pivot in the tree.  Unfortunately, syzbot constructed
a test case where the stack had no guard page and grew the stack to abut
the next VMA.  This causes us to delete the NULL entry between the two
VMAs and rewrite the node.

We considered several options for fixing this, including dropping the
mmap_lock, then reacquiring it for write; and relaxing the definition of
the tree to permit a zero-length NULL entry in the node.  We decided the
best option was to backport some of the RCU patches from -next, which
solve the problem by allocating a new node and RCU-freeing the old node.
Since the problem exists in 6.1, we preferred a solution which is
similar to the one we intended to merge next merge window.

These patches have been in -next since next-20230301, and have received
intensive testing in Android as part of the RCU page fault patchset.
They were also sent as part of the "Per-VMA locks" v4 patch series.
Patches 1 to 7 are bug fixes for RCU mode of the tree and patch 8 enables
RCU mode for the tree.

Performance v6.3-rc3 vs patched v6.3-rc3:
Running these changes through mmtests showed there was a 15-20%
performance decrease in will-it-scale/brk1-processes.  This tests creating
and inserting a single VMA repeatedly through the brk interface and
isn't representative of any real world applications.

Liam R. Howlett (8):
  maple_tree: be more cautious about dead nodes
  maple_tree: detect dead nodes in mas_start()
  maple_tree: fix freeing of nodes in rcu mode
  maple_tree: remove extra smp_wmb() from mas_dead_leaves()
  maple_tree: fix write memory barrier of nodes once dead for RCU mode
  maple_tree: add smp_rmb() to dead node detection
  maple_tree: add RCU lock checking to rcu callback functions
  mm: enable maple tree RCU mode by default.

 include/linux/mm_types.h         |   3 +-
 kernel/fork.c                    |   3 +
 lib/maple_tree.c                 | 269 +++++++++++++++++++++----------
 mm/mmap.c                        |   3 +-
 tools/testing/radix-tree/maple.c |  16 ++
 5 files changed, 207 insertions(+), 87 deletions(-)

-- 
2.39.2

