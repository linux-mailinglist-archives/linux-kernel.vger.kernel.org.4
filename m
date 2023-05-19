Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC6D70A29F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjESWCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjESWCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:02:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D052C4
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:02:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JJEHwh019014;
        Fri, 19 May 2023 22:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=cI8XDeykOtIhoSBVPDCTYwMHK/12a2A2FkU9PreC4R4=;
 b=TDVt5Isk8Ojlaa/g8NXnAxLz9DD5SmG8MC3QkWGKDwZEu+IC22lKpBr2ozsAShpVp9VA
 y/AsgdQ8PPnTmqdQDLQu94BvDuJvqZXpwclGBTFsFWeBhAtrO9YtVdKcB8lHNFYps0Yr
 I56DMb7NQW8hIxip3+GOImLMowyn9OSt+yxeIq4LOsQzbmNbt5Fqeco9Cv5ScHuBDXzc
 BIICnfcDR7AB3GHcvE43BZlVsvqQ8aShaXSLDhd0RA1bjOT5ILXnUuVhPBUJHAebVHZL
 YC2lKdoMncVWqNZdY7U2sL8hvPXUhGPDgvwJBrcTHK7YHNPgLQ6NVlmpRIcUb6NwNOmy 9Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0yeb336-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 22:01:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34JKSMC2032139;
        Fri, 19 May 2023 22:01:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10enqdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 22:01:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwDV3VRloLuAjmTg5vZdcjZJQ8Gd8bKwXL0k55rJZI5dFFIKVMqwy1jtalJJ6rcNcs+JZr/m+dZJ7dBfk6oER4AG+S5b7ty4ox5Er0+7SGZR47N2MDBPPqcX6mnFG2uoTCH+8tWsX88a8nQgGyeuHVyZbSYKQYIMhnNdUoFbG3IhQ+zbEsLIh9qM1u4GlediCsQUyl3j1jxAOYKvDUNJ8stDURmQ+qa8VkHdwIBwvMAShCk1bNG3ud/+tFJ0iBGIbZceOLE3tOP0sh4uNpH57R6YLwVEjZ3DxLvEmT8mZnCpQ3eJIFpI6zJo2/66wtOcuB5Am9AHMcDjwQ8nQEJ0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cI8XDeykOtIhoSBVPDCTYwMHK/12a2A2FkU9PreC4R4=;
 b=bHfYn2NzdIqC+mf5IZ8706NOmzBRwThlDmADDJWpeZrCiYGMr9NIVs3oKg4fKOGm714aH7DrSvaw8tgY2V124s58YUyrbV9SAaznhrVFOcimIHQHd5lGZxJxpazw1MB69+Ntttw3vcErVbZeerFIcdEGpP3gMhadaX85CrngwVlMcov0cq3ABRmE2YTzwdk08exosV+jA5r46O39dXij4zCmt/MD3Y9yrZhxYKIrAi2lx5gorr6byzcbl7iWdDTYvMQTlDZBUPTLXfGmK18BuoMvsmxGtQ260Xm1/LUSGwY3UR0PdqS2n7j+YfgwEhIF6PLjijwx3N7H+VBiGh1urw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI8XDeykOtIhoSBVPDCTYwMHK/12a2A2FkU9PreC4R4=;
 b=KvKEVrwKCAOXd4qIVk7C0MpZkqq2kzYLf55ZJeIElHXbBu/eoIPU/W7EsSjD+z7TYBvdBondUrLySiCwxR2G5bdAUZaKBCHQoQe5mhcC8765syxbZzWbRTWjjtc0lpSOWf88x3JzCSt5+y0x6xRnkIOMGz7Wz+b3Q+m+MVCgwNg=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7862.namprd10.prod.outlook.com (2603:10b6:610:1ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 22:01:48 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 22:01:48 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, david@redhat.com,
        nphamcs@gmail.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [RFC v2 0/2] change ->index to PAGE_SIZE for hugetlb pages
Date:   Fri, 19 May 2023 15:01:40 -0700
Message-Id: <20230519220142.212051-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::15) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c44ff5c-71fc-4cd3-ca9a-08db58b4a47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrtsDBkIx7BuU2puP4W4A6bpfw9RVt6ulz8VoL/CxV3882t2gDXzLrCKi3IDbiYRkCFvoERyqExx7lnwNPqYPiFJ//VPVaNkC6yZisUNLGlL7bAlf+sU/BlVctBunny70puXKbW1ZXGtknBHYksP8UkUq+MswCtQ2uh94l3OjTLvA4UQH9ZG1B1hqMfTWvXgz34xh0UXVhB3OYbQFLBEAFqH0VaEzfrP7XucuXs0Kmi26n23mmhIhVzK8a8ss39pAYLwU7QQi4+z7D3mL1Fq0w4DmHp0WT2iKMUu8YQkSAAVY3QawjaSVTJgBETR6b70R8E+Q2t6jx/cFqqYKISRPQJSn2fI/04lVYUMnmnZUQ24knf/AMNt9xgurbypcQpBkC+EIIK3hK/cDf9eqWQtuvE1vQm1IPDNTEZSiiPmZqO51Trm9fw3u1ouwlPE58G+10gSBi+hgCt5lnefT/yCvsKjrrlQXBrwNeWgypmpQn+LxDxlLgEPIjTXiqHj/tps8fm6N4x30QuZ0IvY5jBLbNrm5YIEE+ueUm+sXmh3kPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(86362001)(36756003)(2906002)(2616005)(6486002)(83380400001)(6506007)(6666004)(107886003)(6512007)(1076003)(4326008)(66476007)(186003)(66946007)(66556008)(316002)(41300700001)(38100700002)(8676002)(478600001)(5660300002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JOFBXQ5qfk3xs+JERKSKpLlMmeeejxzlfQ5QIZKesVZYsMDyGRZLQTzEWcFM?=
 =?us-ascii?Q?4hRzDzzfVwKnUQEFK+dYDWiD3F/7VXgeiFWhZKSzfbeG7UkBFv6k46mqVhKo?=
 =?us-ascii?Q?wcJcyVuWZeSiYRyu/BFljyLlawkyfvTUfrr3XJnE35Aom1yv3ECeBpoNDix/?=
 =?us-ascii?Q?vrycC+b3lSYnlTIgRnN3DUtkzB4HXuJlZL68juZNgSam4xdLBieYZqa/Ydl3?=
 =?us-ascii?Q?17+7uQWwAtJGHcktUZd/fNKe3+6oZqf5ukUUcdpbNCGmRhIyYluQny/8VSbH?=
 =?us-ascii?Q?Oa4IIWKVP9VMDQc8o6gsoBfGDaoO6DYiNwp3WrnCvaj2XKSgua+5LpFrsVfF?=
 =?us-ascii?Q?QH4wX0r7xI+L8hUSudMqoePz/HHsK50ssoYWMp3mwU8Bug1LU4SE+r2d6ntW?=
 =?us-ascii?Q?N/0GAgQedgXebItcH5iC96CA5NXYbelkDI9O0Vt2Z8ElSFNDm2nWM+2NNxWZ?=
 =?us-ascii?Q?hdo9p7FknRaIFXXZUbqr7b8GIoQfnH05mMGDDd2hYa/KAxHVdv/C97PUj73K?=
 =?us-ascii?Q?phqzwm7jn3xi5Bq/2P4IzBNdYe3YcJdpDDmqJVch3MhJ47a6oGMszvEwjDdf?=
 =?us-ascii?Q?NJDYkmcEPhkAibCvISTgSSgdVZWcRVQbQIjY4Rfc1MnQNzxQGksR2NxG/H11?=
 =?us-ascii?Q?1ZTZW4IRndnSskDNQpcpuDSEu2+8D1CnybIhEp53CSPPJKcuCfs2iX4jNsp8?=
 =?us-ascii?Q?kSapQTgmtiAbJrI9ZcfKaLiqX8CjLDvkunI/NFaAjjEMRMBOJFnGNSen03bU?=
 =?us-ascii?Q?9Mz3APIaKvNurnbu4aLccSrv6AjUxdIwQJNhcnUjhZApxCHeuP1Kci03693L?=
 =?us-ascii?Q?YvtfxtTW22kryeNDWPlmJ25iUAxUgpwKQKdUtXo19eNKJlSMMqbeRUq2CLmt?=
 =?us-ascii?Q?Kdp1w1UDUml3xUd3NRjrLGo//cB7y0zjwuO7wHKNXNHOGDCgIKu3WMXRu/eX?=
 =?us-ascii?Q?i0awnRVDYWgkb3Gs69NIPJdbpTZHM6cMwUkKkY1uGEf+Wup31Td4RqpezhNQ?=
 =?us-ascii?Q?Wqumlp/vQAodRpzeP5TCohC2ZlgJL0OQ0NO01oq00HRY/Nveo/qlFOqjdw8Y?=
 =?us-ascii?Q?TFZggjW0p4TXAN5FgnMpG7rMl/Lqz66hYSnLaHLNUV34IoEvIvH7v5RPJQD/?=
 =?us-ascii?Q?Wh11434lavps4zdqgdhGQ4nVELk9uMnsWNJdqoRVCVPOMNIYgqRir6I4AgVA?=
 =?us-ascii?Q?+hZrdeI4Q2XvY2kyWsHbPq1dNHA1VofYv+FVKDfM7I39UX8YMPwjqK84ua2C?=
 =?us-ascii?Q?XWtzMDtgE6O4CgoDVd0ZTwGlZxxvuE1RqOXALBFtpRQnNYBuI6cIlpwcf10x?=
 =?us-ascii?Q?Di8x0ph9jXK/LMtArJ4OteV0AxPczt7lngrKIwTkiQvVDJohjjhRoioRPnii?=
 =?us-ascii?Q?868e5pXDIzIdPWKGoq+em9IxU/PWvwcgJVJ87ZvyOAxUBIBFgZjBedrcU/7P?=
 =?us-ascii?Q?ZdfDpJ1Taw2V5jyzsryCbUaBetKr1IFFYKqT33Odzs+xgu+NcKIxownk58Lx?=
 =?us-ascii?Q?UNTPv6+OMjzUb0F4uZOeuMCqXNFkPDEsDIfRNtAzMzNgmv9ZiCnkisA8oMdN?=
 =?us-ascii?Q?fH7dItRlfZMNrczHs7e4E1l8oNjReMGtvavJF0pQAW60xJ7xc3lEVy0yJi6l?=
 =?us-ascii?Q?VzB+w8ptVvzIgiEJx86H9ng=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DM7rB2qUNZOFDgHANXcb9Xd8+12D28ptWgpvqewO+ClajRBxBMh5LFL3TW5a?=
 =?us-ascii?Q?azGfHcT7mQMB2luGXupIOg5+7PwVi2Dq3NQYUfeRsVTzUPjqPRIJiTmFWHGh?=
 =?us-ascii?Q?W950Kvvvvr+PtM9xtZW0SGTqEEtmcxtAwHJ4saZCND9cIugmxAAcjzIRpAtE?=
 =?us-ascii?Q?P17sg0ECdS+vNGbRTENpqkj4Qawd3sBW2NiQjnmEzxNj1tjOd34tlkr1tWmw?=
 =?us-ascii?Q?Hh0jFDj+a3WjJPclygWgQakgf+G3kVujL2se7Q0+HeqfQUqtNsByBhOiJsut?=
 =?us-ascii?Q?iH8yyJCqGS2WKNuF4THngW1J3BNPo8lkac0R1zG53IAdxYsPQANV2+7qJmpQ?=
 =?us-ascii?Q?vuXzqBy4KkQ2wWnef6eBhsM0q8DnbQwh5CAK3MHikFex+rPEpPRNaAu8Fo/g?=
 =?us-ascii?Q?5JLrVjdjzR8E5HmxCAQQfKV5iq5zm5wyl/S9DZxd7UAK868hGmlZ+PBXHg0+?=
 =?us-ascii?Q?GM9Wtrlk/YMfcOaJGFO07Lxb8HQ9gKJscDeA6RxemJFykQoi05odMRs3BpyQ?=
 =?us-ascii?Q?JOIa44wrTiu5cqjqwewoSow6Gp1bfc0WFEn7N4oA48HEacU+IIgG7mEGgRMs?=
 =?us-ascii?Q?jl/KmKLnS7204834EIIB6uxcYOx4mQGK/eveAb26FXUskoCFX7MHGbfT74zt?=
 =?us-ascii?Q?NbnEqZaqjWaLCIaAIyPBxAgoRWMFfGIfXVD+fnPlGiQdiFZ0v0tICrJhWUXr?=
 =?us-ascii?Q?QcoTRRhIXl463eZmysTfrDhNX71rf4kmlOdjiMaDq0usZ4DO76lTvndxlNpK?=
 =?us-ascii?Q?AH30Zc63P7ajpDHce1JG7biIH0pn+5V+8EPuUSfVtQx2b2Gy115Ldyj0oQfR?=
 =?us-ascii?Q?QGq6eFKWLrsdh3bXcuJjff8oyWtLmwck0u7TiRYgcgPp7AePeqJ+2lwfE3+c?=
 =?us-ascii?Q?5QeYoIaPKpE7YWSgBMi/u9b4LoUsq17uSIvUZJIt9fMr2yj+K+WF7FvWaefb?=
 =?us-ascii?Q?HKxEsDw8kbqpSJCKkENAxsnqqlR514GgBwU0zjmtnTA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c44ff5c-71fc-4cd3-ca9a-08db58b4a47b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 22:01:48.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBph0Lg9cdTE0hGOmtyq7o09yN3lsFeyM6mVsHm1BNokNviVM+Zfi+nHUmJ/BGmGkTmEQ2g+8Vfz/TQJWT9DLBDur/Jit6UZopsyq/MZWPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190190
X-Proofpoint-ORIG-GUID: 03hDKDYjeXY2T7Y6Tr8zZaKOVY7ed-dh
X-Proofpoint-GUID: 03hDKDYjeXY2T7Y6Tr8zZaKOVY7ed-dh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC patchset attempts to implement a listed filemap TODO which is
changing hugetlb folios to have ->index in PAGE_SIZE. This simplifies many
functions within filemap.c as they have to special case hugetlb pages.
From the last RFC[1], Mike pointed out that hugetlb will have to maintain
a huge page sized index as well because it is used for the reservation
map as well as the hash function for the hugetlb mutex table.

This patchset adds new wrappers for hugetlb code to to interact with the
page cache. These wrappers calculate a linear page index as this is now
what the page cache expects for hugetlb pages as well.

This series passes the LTP hugetlb test cases. I will do more testing
and performance analysis but wanted to get some early feedback if this
approach is acceptable.

[1]:https://lore.kernel.org/lkml/20230425012721.GA6696@monkey/T/

Sidhartha Kumar (2):
  mm/filemap: remove hugetlb special casing in filemap.c
  mm/hugetlb: add wrapper functions for interactions with page cache

 fs/hugetlbfs/inode.c    | 14 +++++++-------
 include/linux/hugetlb.h | 21 +++++++++++++++++++--
 include/linux/pagemap.h |  8 --------
 mm/filemap.c            | 36 +++++++++++-------------------------
 mm/hugetlb.c            | 22 +++++++++++++---------
 5 files changed, 50 insertions(+), 51 deletions(-)

-- 
2.40.1

