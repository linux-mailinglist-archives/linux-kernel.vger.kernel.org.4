Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6F874FABC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGKWLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjGKWLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:11:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E971BE4;
        Tue, 11 Jul 2023 15:10:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BIDS3s025206;
        Tue, 11 Jul 2023 22:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=2DxMbws++KqvbwdoPM7T8RtLODfPW5/jpMuy/WlrZ88=;
 b=eKAdZdsaxIHv9OmULW5zzvEnlnTqoL0XrAk1Ssz5H2EKQZmWCW4Y4vu1x0IEa2VKFPDR
 8Vm2PW0yQgHySvmS1WYaAXxTjLoQJ8DwGPciSxKbok+2AhmzLXbX7X+EJe8y1/sTHpbJ
 peUuRjcBsHQw/QSS6So7WgyisuH+c1JI/cMVjDdA0r0RSLqwPnVyRoYvWtpEM452KRem
 vWhdhQi2fy9z7R9vPLBPDQ4j2/8WliNSzZxwyWW3UPjuUSxNDLWZu1L1Zkw7JIeuxELz
 khPPFAKJemackWmwiV/couf4WaFIykx30frRu8052k3GgUVrBi9fnKSwQSqW2HKL/IXq ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrjmhbjem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 22:09:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BLd7ie008596;
        Tue, 11 Jul 2023 22:09:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8btb17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 22:09:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYhzqgM6xJNEMkAevI8c7HHevzEO7Al0/1SyfhGfjoX56HuF2ILLzqZEWzgwZkV5BHExoXbLIXcH6hU5Jm4Rk7ibsGKm++5zVDiVLuum6SUaPtGx9Xkzgve9bhJfhV3KwW8zZXj9WZpzp/j+wwqYzMWWR5Xy88Qm+VbBAt7Vc4wq+Z8SB8NVTOrzcTek7wOBwCcnL0QMhjsOBD08qhj+uINnU8E2lPpNFR56kcWW1Xy6jOmN7oQjUyVZsD05Ma9BEzLGHOSrY+tvmvaaWGT+i8mKbIqudFbT4rZT8A9TU4fuxIxECBLpSGgNjjE5iyCtHiehCA/WIXXXxX4OME89+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DxMbws++KqvbwdoPM7T8RtLODfPW5/jpMuy/WlrZ88=;
 b=j/y1RrVoP8NwdfviOCNxu4V2x9aOiQmpl3DSQ5766CPHRpgpoJdKusPR/NKe0TSiIycLLnaqKRNPqLQ7eqFRQg68SQPep7sKz2wr1EfsgauPzWs6sgTwckMDfHQtG1zUGlv3q0cfVOZrLYRU9BkyDDstY9oGJKWmXluKbV2y+4rYk6taq2auuHClgPkQBLY+RQmhezJRjKLKAfyA4GQQxxtR3obuUzE277v2A+s1+hRPmw9GnXmvFY7PjpqXPDl1ypw2QqLsDtHOEbWYKybOTxv9qrpEAVRftER3QrZMqBcGL6D1qlsosuyhBTh3Th8vZJ42cxCL45Wa6+KqRI3sUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DxMbws++KqvbwdoPM7T8RtLODfPW5/jpMuy/WlrZ88=;
 b=h2MfyXZnYM4H68WzPfak2QLnIRhnfk7puMmKoxvDtFGmOO3DC8ihvn1cs57aSlsKslccgRyBTbHEeGAZVF9hxgRpPoAt0pKXw3abAGCHzR+umaMUkYrSI6EukllP8eThImBoLaoH6Q7yFb8I/NtiIm3+egskrY3prfdrbcR1Zrk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4775.namprd10.prod.outlook.com (2603:10b6:510:38::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 22:09:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 22:09:51 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] hugetlb: Do not clear hugetlb dtor until allocating vmemmap
Date:   Tue, 11 Jul 2023 15:09:41 -0700
Message-ID: <20230711220942.43706-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711220942.43706-1-mike.kravetz@oracle.com>
References: <20230711220942.43706-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:303:b8::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4775:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a996e5-c080-4473-f866-08db825b8c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mwe7JKbpJf29CNH4kRC8GpUL39E6/bHPjuS+IRvT4WNW6ZoeWBHj888gWBxKLo36lNsRLgXnb2GYtGcV0leQYAz5kTSf0AdFCDE2jXaWrWbo4UhGVHHMkERRiVB/+JtNkL6lPug/ple/sFlBYk+SDPlqHLNOqypzSmdZqvhphnRsVZwCdpTSgMxNZ2w4k07tw1aRoTCr37AfiSxuD4I4lgwDSzLXAbd+VvsoNUOHz7jS4/4rQFvu/7ZuSOtcTx/+Ez+9HA5kKjlaVI/FOHCUbLyuPwWyox2oS/3xwEH1DbSBKEFl4LJ569ShoprQuFPJFuLw6PN99fDjQq3e8t2UsnYPyyJqtO9enkDCLPD+JsZuc/GexPs2MfMYbg1LFw7i1cjIV5/WyFLtQsTpfdk2qyyPvCAxP8PdhtID0cOGKJlwPAzHmGa6zu50E+SLtEZaOXMmzsu/a2lnaInqbYIBil0SA07kYwFls7uLRjgiFq1fuvwTaMunMogqxgiRZRwy7JirLO7Mb1/bT6Bt6grFNK3xdZmXkpCuw3KdO5h+tGlrxd4CRc0BX9WzLuSBK0X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(6486002)(186003)(54906003)(86362001)(6666004)(2616005)(478600001)(6506007)(1076003)(26005)(44832011)(7416002)(316002)(36756003)(8936002)(8676002)(41300700001)(5660300002)(83380400001)(6512007)(66476007)(66556008)(66946007)(2906002)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e0+yv8DHY7oSBdfd+soeJDcjjp5yzDnwGVfiH/tvf88UN60nMJVOnlS7lwyr?=
 =?us-ascii?Q?05EY9NfGMm/Bs1Sn8Zm6lV5oMX4jmEnAYSatnmDB/6vXMt11tYLLFrdMZm4n?=
 =?us-ascii?Q?O4kaQuO/BmSVUGC5bXLB+uRqCVTwg+qsAJgwwTd5SAAVhFvws1xhCZEL+DZe?=
 =?us-ascii?Q?bKqb/sKsrTMqsvVfIvRMnNt9UhragO9DitrYW4lruNLtn10OZu8Tmvkj7KlJ?=
 =?us-ascii?Q?NojSS9+idyp5a1L7X038+dPyBeL3PO2keKTb1eZeuWaNOS1zY+AkoQ9OwQBW?=
 =?us-ascii?Q?HkoXrURD6AlPI3LtwdbTjGNpIUW1WHHEVKr9UrhyOL69bwyq1kTTNFX3ixHQ?=
 =?us-ascii?Q?04cv0FOE1P3ipszBv9cUpIa3+h7HLL6/w+t6jfw35zLKOBJYDA1Y0QqaCIzA?=
 =?us-ascii?Q?2qsQBUEf7/Auq1Fvygy4w9zeyGtiT4gTDZm8xvcsTHDV7Pzox7st6Q1AAdAK?=
 =?us-ascii?Q?qMjeYYbeGQErsEwDYw0q79GCRhMWHKw5j3BdpFZMqkPAcb5xtGZALc31S/q8?=
 =?us-ascii?Q?kIA714Vzus2XblpnSx+LvVUy3jVbE0DwUlG/UQylSW/6BLTrrSV3AEp/c6nS?=
 =?us-ascii?Q?aZChEIKPtMpfhi4+FSkokk3mNc1R30tFzbaudYZuLVjCuFVS3wo0o+9eGpEX?=
 =?us-ascii?Q?hQFQu/QZl+jY2jO49WwDAX3cteUba8Y8uxWy12chiXVbwPjAVi1BlMNaOx03?=
 =?us-ascii?Q?J7N7s7tQS7QtsbSG+rrUZCTK7g6ae6mj65QO4Ms2LSbKCAt/WUFvyYH7HQxF?=
 =?us-ascii?Q?1mQsL4q5SaCqBDHESeqgx8aZlMw0oWVimxGsY7m1OFdMM3zoYO+OyW6u4RDo?=
 =?us-ascii?Q?RXpOyK8WEbabAoaqGKQ0QPGgQ5L2gatrUt66vGjTPDCyFHjYGtQW72t6vidA?=
 =?us-ascii?Q?0wRoWl/oBUEfFjsEjwtg7SARQhAoiZDZSR/cpexr3A++SKxJb7kkg7XTEiBh?=
 =?us-ascii?Q?dOTGAZNKXu8xC6SxMXVMsLlr/pnNmLZneE0kGO53iNy+m0ZOChQ2ijZp9dUD?=
 =?us-ascii?Q?b3DT15nF/rJReCb5J+AHA52Dkq06wc6BFzbUsZhK5FnFMI4hf+KeTfMpuqF1?=
 =?us-ascii?Q?t3Xjkp3z0zfJ6zA+0mZfeKdLIFPh9ECjO47ezEBIk9HVuB/gkfoKbStXOqgc?=
 =?us-ascii?Q?fDAqSXKfQOjZlOqsQLqk6LiM+NGWopWsmoHAo56DR/xdPwRjLxwjeyy+f1Yu?=
 =?us-ascii?Q?0KOw+crpVacHqnfUUiXh/fZTVxRks74v6S7fzI0tjzWjAOh9HPlsLZqKwnPr?=
 =?us-ascii?Q?cjeWtxNQjjeAXeorLKv6r5QrD7PaGpbj52kaom3c6qBP6UnzR2BFvpGpY8f/?=
 =?us-ascii?Q?4kRjk0TgLvOU6mlkS472HXDKtdi7Xok0mHxcNmFYv6EAxoBKxBRjhts3uxoy?=
 =?us-ascii?Q?A1oRlAIG5SJOBd9q6OthVYRlM1fVx2/qci4u1GnCkKb+uGGao6tclfJwEzU/?=
 =?us-ascii?Q?DMB8l/ECEJ8JxYDqmtH1AGOfejyzCe7egMWVdxEUL0bqDkGui5QJCa2KUHOs?=
 =?us-ascii?Q?/F0gLuDXG46LwLSF3XT7qipDuSUmdGXqoHgK/d7ea+/NbCYkQX6QCmtg+76Z?=
 =?us-ascii?Q?cejkoXlAXQjYlqI+vmvRCt/TSvoLpwtWH8dTDmXFiJd1lDKxyySz1vc0RfC1?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vLEcaqYu6newdwZwkDE8TRQ7c3Lzmhf8MEkzQyLfnRF6fofnevbQ7DYXkfql?=
 =?us-ascii?Q?DsN1wfnZei/2KHCcKhiXmGOWsy2YDfHijz9iBfGic3HH0s5amQjtngZiy7Pz?=
 =?us-ascii?Q?uXumBIT5kB3q939Ys4/DduK4r94aVjUGur1JVGnBtRDDemZGaMc97nE7Ea5f?=
 =?us-ascii?Q?TPmxehzGxmJlvSwpkFxvLQE47kOJSyagV/MSPc0Pc1Yt6k9LBeVxObmzh58x?=
 =?us-ascii?Q?UWtqmmHCXaFr7uAbyKKp8u6wyaP8yTcmPYqhZbiMtltf4rWDuf0FEjBU4ntl?=
 =?us-ascii?Q?YjIqIzS4wUfYue6qmmcRTuWQg64+keHYpalB7oQVbDkXyYkWaitfebak5wvy?=
 =?us-ascii?Q?79WU8xdTggvKVw+0D2GRwgp+m+bWpjn3dTauYzWwTcJSMDL8TKQwTi+2wvG+?=
 =?us-ascii?Q?VwKpFg0oVTfPU0UvbfsiXolY6me/63sSKH7r+HT7ie3HI1DdicJwtJcMq5xT?=
 =?us-ascii?Q?OraPlX3Aztb5BNOLUSnn3Q3bp1bX+fUVS+5XEfeosAF6+QXpVn6439dNMUMQ?=
 =?us-ascii?Q?FO2la1QdgjnMtRYQymnk8yA+OaQqRRGXRSpNOlivjzITRmHfEN6z3P4eulj+?=
 =?us-ascii?Q?B/uOykhpcPSu77fKO7ZkNenqQMceutRQgKSLmZLx7/lCYD+JHxpV+UQC+GL2?=
 =?us-ascii?Q?UM41CT5bqBd8FoO2BaByS5R+a897wdGKS24Ml0QxSlKjhyoW9tdTatNEv5dM?=
 =?us-ascii?Q?iS/DJ7Fiwnr7DimCz3CFIpyRBnaBoDocCWXOwH9OVAnaW8axoeSZ2bTRv3yT?=
 =?us-ascii?Q?9nS80YEUP2uAJLJ33+LFZiqWMyXSsQFK2ItQzkxkNTbQIABON9WlkUAHYoLI?=
 =?us-ascii?Q?X67lES3mZBBpy9iSadVcw5+HDx26ifG9/Nw8zw50Ujf/75yM/qMHK8ioJxDS?=
 =?us-ascii?Q?TwHlgrQPl2sPZyUtpFaX1N53kt41c70ZET5C/Jgwj6yFoq9UtfSDQMjX5gPv?=
 =?us-ascii?Q?i0v9Zcw4Ln+U7UZ1Txk5CqA8Zc+wSa+uzNr1EbcoJ2g+5lffzioCwDkomUSz?=
 =?us-ascii?Q?BtuO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a996e5-c080-4473-f866-08db825b8c4c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 22:09:51.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akqNV6v6s6FVxxU7PTC58AxW0TXs1Cx9E454OQchD6j01fchQKmgC0BlPiho8rQGmeK6B3RGThQhh74jjN5Jhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110202
X-Proofpoint-ORIG-GUID: zQdPaF_yMgoqbdw8IN-rbPkGgq1QEPSK
X-Proofpoint-GUID: zQdPaF_yMgoqbdw8IN-rbPkGgq1QEPSK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freeing a hugetlb page and releasing base pages back to the underlying
allocator such as buddy or cma is performed in two steps:
- remove_hugetlb_folio() is called to remove the folio from hugetlb
  lists, get a ref on the page and remove hugetlb destructor.  This
  all must be done under the hugetlb lock.  After this call, the page
  can be treated as a normal compound page or a collection of base
  size pages.
- update_and_free_hugetlb_folio() is called to allocate vmemmap if
  needed and the free routine of the underlying allocator is called
  on the resulting page.  We can not hold the hugetlb lock here.

One issue with this scheme is that a memory error could occur between
these two steps.  In this case, the memory error handling code treats
the old hugetlb page as a normal compound page or collection of base
pages.  It will then try to SetPageHWPoison(page) on the page with an
error.  If the page with error is a tail page without vmemmap, a write
error will occur when trying to set the flag.

Address this issue by modifying remove_hugetlb_folio() and
update_and_free_hugetlb_folio() such that the hugetlb destructor is not
cleared until after allocating vmemmap.  Since clearing the destructor
requires holding the hugetlb lock, the clearing is done in
remove_hugetlb_folio() if the vmemmap is present.  This saves a
lock/unlock cycle.  Otherwise, destructor is cleared in
update_and_free_hugetlb_folio() after allocating vmemmap.

Note that this will leave hugetlb pages in a state where they are marked
free (by hugetlb specific page flag) and have a ref count.  This is not
a normal state.  The only code that would notice is the memory error
code, and it is set up to retry in such a case.

A subsequent patch will create a routine to do bulk processing of
vmemmap allocation.  This will eliminate a lock/unlock cycle for each
hugetlb page in the case where we are freeing a large number of pages.

Fixes: ad2fa3717b74 ("mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page")
Cc: <stable@vger.kernel.org>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 75 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 24 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e4a28ce0667f..1b67bf341c32 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1580,9 +1580,37 @@ static inline void destroy_compound_gigantic_folio(struct folio *folio,
 						unsigned int order) { }
 #endif
 
+static inline void __clear_hugetlb_destructor(struct hstate *h,
+						struct folio *folio)
+{
+	lockdep_assert_held(&hugetlb_lock);
+
+	/*
+	 * Very subtle
+	 *
+	 * For non-gigantic pages set the destructor to the normal compound
+	 * page dtor.  This is needed in case someone takes an additional
+	 * temporary ref to the page, and freeing is delayed until they drop
+	 * their reference.
+	 *
+	 * For gigantic pages set the destructor to the null dtor.  This
+	 * destructor will never be called.  Before freeing the gigantic
+	 * page destroy_compound_gigantic_folio will turn the folio into a
+	 * simple group of pages.  After this the destructor does not
+	 * apply.
+	 *
+	 */
+	if (hstate_is_gigantic(h))
+		folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
+	else
+		folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
+}
+
 /*
- * Remove hugetlb folio from lists, and update dtor so that the folio appears
- * as just a compound page.
+ * Remove hugetlb folio from lists.
+ * If vmemmap exists for the folio, update dtor so that the folio appears
+ * as just a compound page.  Otherwise, wait until after allocating vmemmap
+ * to update dtor.
  *
  * A reference is held on the folio, except in the case of demote.
  *
@@ -1613,31 +1641,19 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	}
 
 	/*
-	 * Very subtle
-	 *
-	 * For non-gigantic pages set the destructor to the normal compound
-	 * page dtor.  This is needed in case someone takes an additional
-	 * temporary ref to the page, and freeing is delayed until they drop
-	 * their reference.
-	 *
-	 * For gigantic pages set the destructor to the null dtor.  This
-	 * destructor will never be called.  Before freeing the gigantic
-	 * page destroy_compound_gigantic_folio will turn the folio into a
-	 * simple group of pages.  After this the destructor does not
-	 * apply.
-	 *
-	 * This handles the case where more than one ref is held when and
-	 * after update_and_free_hugetlb_folio is called.
-	 *
-	 * In the case of demote we do not ref count the page as it will soon
-	 * be turned into a page of smaller size.
+	 * We can only clear the hugetlb destructor after allocating vmemmap
+	 * pages.  Otherwise, someone (memory error handling) may try to write
+	 * to tail struct pages.
+	 */
+	if (!folio_test_hugetlb_vmemmap_optimized(folio))
+		__clear_hugetlb_destructor(h, folio);
+
+	 /*
+	  * In the case of demote we do not ref count the page as it will soon
+	  * be turned into a page of smaller size.
 	 */
 	if (!demote)
 		folio_ref_unfreeze(folio, 1);
-	if (hstate_is_gigantic(h))
-		folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
-	else
-		folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
 
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[nid]--;
@@ -1706,6 +1722,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 {
 	int i;
 	struct page *subpage;
+	bool clear_dtor = folio_test_hugetlb_vmemmap_optimized(folio);
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
@@ -1736,6 +1753,16 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 	if (unlikely(folio_test_hwpoison(folio)))
 		folio_clear_hugetlb_hwpoison(folio);
 
+	/*
+	 * If vmemmap pages were allocated above, then we need to clear the
+	 * hugetlb destructor under the hugetlb lock.
+	 */
+	if (clear_dtor) {
+		spin_lock_irq(&hugetlb_lock);
+		__clear_hugetlb_destructor(h, folio);
+		spin_unlock_irq(&hugetlb_lock);
+	}
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		subpage = folio_page(folio, i);
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
-- 
2.41.0

