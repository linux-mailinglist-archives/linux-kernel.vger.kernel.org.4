Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85F174E1CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGJXGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGJXF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:05:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446D310D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 16:05:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AHuVSQ027999;
        Mon, 10 Jul 2023 23:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ddw8vvxnMaZ5QJEIQHQCGFP32Sl6kqvbyaVBZ71ZMQg=;
 b=3l4FU5hluSZeWlUc9Cku1UhqFe/gRVc05KBJ94Vw/4tNrrC/FSAt4EiOm8otmy5w7pmC
 +Oq2E62TLZwhhts6eCGWVoXLWizSV94Lago+fjStHQd9jPwQTac/V7qYbIp0Ce4XtvZn
 Ui9Mpjp8G//hx0NPCh9TlzNe36bAUch+Ast3RsN+Xu9YVxAtIB/JIorpkKpTweJNRc0q
 HvsvUB46p5jpMXwpQFDDWBZb/TfOkqdtsf+aDPg+dpcdJNgVBC4FWuyPAySizABJJYfJ
 /soopXAVh4Y/lFA8vpXZNw1J1sqaMMreRYi71TOKvlkhc6glBGxPmUPxzUYQI3fRCFT/ sQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrfj61k7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 23:05:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ALFFqj030798;
        Mon, 10 Jul 2023 23:05:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rqd28bmp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 23:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZJRY2fvZiffWhns7+uGupsSwueiAopa4wuI9XH2Q8wbWuiDgRLPQJ654ah6VqNA/ip7pMdGeNqa1M9TJO7qg/ORQ2RmUHp4r9k8rh6CgfjMzSAHghySHzGiizxZZL9bBNGdwmAweGEw4eWoKyih1sKiDY2jgafS7G8W7tVBDKqgvbftZtQKPn9X0cRFk19A0HIhshVan/T1/0NLqBBuSHA0CCyKMBMH0+sUKxQwCcigDeByJn4zWa+NqgxB/ad7IZLAkOGF2L5JKfmtXLLPT19caqBY1IF9cu/TLLfEqudVpFdEoKgbSu71ERJUVZoWSlq+ShY/IzINjHKq1fa+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddw8vvxnMaZ5QJEIQHQCGFP32Sl6kqvbyaVBZ71ZMQg=;
 b=jSbGMou3UgGHUUm+ro6yOI+gnLIx0ylEiaIKvgC6VfcqHEliCiWETz3esBl0xq9Iw3FGXQBEjwjzhjClB9IgR/zmNU2EMHbrp17OAceX8P4AFcvLfilelh2WANawWXemN4jLsrenVeXv37T7rX6b9UCUqBjKh6p5BgoZYXOX3j4KnVzMxo1XdjvWO3Z9TiDsqWZ5Eb+SdjsM3cY66DgLoBjTyGm8M0mlHwt7ONuMB1AS46Sk2yyScANomozpAqD37LLaIP7itllOwikFHVfM6Qt6eOnxKJZGGqxNjMeaGV17cqTj0AboUQ2xQVVflhe/vS2CokI9dSTrOx2s8rbV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddw8vvxnMaZ5QJEIQHQCGFP32Sl6kqvbyaVBZ71ZMQg=;
 b=jEQQWXi4IipwWM/Kr2RTwN/505Z3FnrZaeTnX9GLvbLt+MWhfGGa/4LM2LIQDs+HOcdvDkCbKU0Wn8eWHR2RS9LAf+GAX6V3Jhq0vzsNPVLdOmoFdNChjsKTTvHSkwscLbOXm08TJSJqIpReoYgDrldTltCDkJs+NDg9H1hFNLU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB5856.namprd10.prod.outlook.com (2603:10b6:510:131::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 23:05:21 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 23:05:21 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        david@redhat.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 0/1] change ->index to PAGE_SIZE for hugetlb pages
Date:   Mon, 10 Jul 2023 16:04:49 -0700
Message-ID: <20230710230450.110064-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: aa18c889-70b8-4809-46a5-08db819a22c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hl1J/PkyO3mFF3ww8XAicOIU7VYfTLtmgLxWejpwzOwE+TBclW2V8/QYi+C0F3PT4V04fwUjvtenXoPOXKC15biy2rUpEliQ+J6VOBwt+tawXX8+cY8GECIc0pTmNXsZ9ZkfQTPUevoSjz/VI4AlCGbuyQD0StYZaNVIeQjsi61FsIPvw9SDnOP0Snaig4nB9yfoawKJuqVPSmRiCuCaolOsBNoK9NY0oDnM0+NWplWGY7vcsWtIno6c9eQUe8JxdqAleQspW2rG1mfhejBqUMcIa9kLifrfJLJiWEXsiiuvzTYRdm2QEkPQorlMbAWnY0PGIaJmQqZr8oxv5gx7FwCOxmvTvt/0c4cm+b90eHdLUWAYsDNiG9IaEz9QYB2/KxEAKJOxxxm8ySAEWFEuM8gyVnWSkn3t1BwUSaHlA9rBBRa3VyqtlTeYeeeAcmkmKOCNwhMg9edq1xN889Zv3Amd07bp5fFWOMH3YNkBf8/W2IcDddH3vkkuYGz+Gj78fnwMG/9oLr97yqwKNLWNemws+sNN4GEkfEIyZigtlCFjWcH2Sl6WnjzXATlLMl/O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(186003)(1076003)(2616005)(6512007)(6506007)(107886003)(478600001)(83380400001)(41300700001)(4326008)(66556008)(316002)(2906002)(5660300002)(66476007)(8676002)(66946007)(44832011)(8936002)(6486002)(6666004)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0+nvvbWQ1t0dME5dHDGLZW61ovP2h5icbJqrOgFkzXFMXDDFXfol8TfwE5JM?=
 =?us-ascii?Q?BezfvYkdNeV89a8X7FieGuZeKWq86cwp8yVX43nYPXMuQkbY7YhCX+jrvkix?=
 =?us-ascii?Q?mHU27OIGnoI4dUznpSDf/4R38PnTxdteypN6ZQrQGx7MatJF6amSZkngjgZx?=
 =?us-ascii?Q?GZjYb0YJzhgFzh4p0axyf06jX0tt3g8ZQE79E4esSxEqgzZZdJmK1kBNt5Qd?=
 =?us-ascii?Q?dd4B9mwvW68e1BOiyf6QksIuyhLYGIIH9yjxw1kJ715ca8wUlvRTWxEH7SfM?=
 =?us-ascii?Q?WeoUHHgGPttgUgNZdO6PiAnYUSKHCdo4lFiWn3EIgufWQ3VfU2HqRkkiX21h?=
 =?us-ascii?Q?xd7bhFUPhmDLw9xIOTZppqOQre8+bbVbPSUYrkihDhAydC7ElSJqkckX9lJK?=
 =?us-ascii?Q?hm59OgKHteOIiyJnnFeJw7FLa1aLDDcyK4rD9b1EGSbH2Nav30PaO4pEp6kX?=
 =?us-ascii?Q?3+cJwSg97kOpbHNq9ga0qxZxyq+1SyuoQLPgQPzshnwv5jgiJX3Jp5wdqT54?=
 =?us-ascii?Q?DtJPvsaNfog3+Dgo3ciRnhGKYFvOM3IET5gyHyeO4L/3aRoJvmsdPdQ1EBRp?=
 =?us-ascii?Q?DJaZNxLhcyxDjS2Mm48c0/bWVz0wG28GNAmFlG2a3+5fblthhxnCgUK9rliP?=
 =?us-ascii?Q?ZHtVeiZtOeEYC7jidHeGmvgyAUBzLM/DITQipqqz61pnbRc7il2WKoWVNlbv?=
 =?us-ascii?Q?F/qQ9BNJrPlNN3oxMNFVE0HJwlBQUYS8qOf02aZ2n07PBhebI8hV8Hepszjj?=
 =?us-ascii?Q?VdXH+uKHOKBqGTcx1h0kH6agMuow30F0I5jfJyg7Sveh7Gb9pPvYQyGxDdIP?=
 =?us-ascii?Q?+fQD98t9uKDUCtDKY37LwH1i5thlN9iU1iPof1I8tuapEqT/D/jOyHdiJ2TE?=
 =?us-ascii?Q?sCq8W4sKVylDdcU08pkS0t8YzitGjjtPHUv7BUf68ijyg2GOlwdSBQk48Mb5?=
 =?us-ascii?Q?aL1R1jmhTYxe92Lb60KqToQnXbB/VhJIC1oet7U48JLemwOr7rpalBx1YRdW?=
 =?us-ascii?Q?2KW4RiovDVdNsI3Zv44oUnanZH3n5y70h2FTJYsHOZJ0LPv03TOz/T8PXxtF?=
 =?us-ascii?Q?GafcqNhQy/kJNVhV5FvBTwMXQy76ZFWUqbhyZ3iiZY/510fjOZDyZi53jvW2?=
 =?us-ascii?Q?DKSz5Q4Yj8OKVBLgkwfzEeIUolSr5Dv8aU1Gwv7rSTaNAtRZ9D+fx3BAY5xN?=
 =?us-ascii?Q?c6pOOiB6ooB4hZfEmjiS3I8DQcr/9GfWPSbnhRoNlT6vcBu0nCQGiBZ43+6Z?=
 =?us-ascii?Q?BwbvndzKIHhMeb6qjFqz53UfAX9jqKNgzDk0L1xfrnyA4BMkagaX7cwzQrEk?=
 =?us-ascii?Q?IFhCghrM9f4xzjGOqAo/M5CyfeIhK1euJo/w7bRDdNUsQCC6mLzqTOzG1Lnb?=
 =?us-ascii?Q?Uu3jwrR+EGk7C1vF4RsS8CSNC4FnG/ZmL+MhCxWATlHeHvBgzuIiPKVsphnf?=
 =?us-ascii?Q?+hDRdrAKmIAY9L436fvyynH/lNMVLTea5cpvgcl67GCFXh5k79dVEAoof8AK?=
 =?us-ascii?Q?mwTwNe2QGS+bhCwtXmgE3KaqzqnhNRlmhsf/lW9+RFcEB0wSW9/+0mH6VgRA?=
 =?us-ascii?Q?lIr8dWkmffhs63jzswpdAunzImneHP2cQWwOH2QDZ2PC64qfAv7WhKDLHF8B?=
 =?us-ascii?Q?yFGo+d7bbgYpichhOTjeqGg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KWyIUU+cJBnlUHOCgjxLgGaqGsfFJoweWMuVMVtPesJiYB2pv8ZSBrt44mHp?=
 =?us-ascii?Q?mMT+6DGGjIMxmAGES9QcfdgAbfutw6hgbZTklQSd2uOjUbW8kMHCIH27s0j0?=
 =?us-ascii?Q?nhS4zortkSmofB7oXSr4foS/IFXsLbFmOYfscnmr28mgtktPe5sFRstJB7Pb?=
 =?us-ascii?Q?cnbUnmbBNfGRWTrrVz0nLyvf9g7gNWAMJufjSsqvm7OYaIYE3gGtvAAM5OHK?=
 =?us-ascii?Q?JKXD3Y5SJ+kqskAAmXOF4OMm33IWkHUqzHJfWx8NN4XpDrbFs8KaBuRYgjRO?=
 =?us-ascii?Q?jDONXl3RDcDVXoK9dTP/sqlU/YCSL2IKzTzzE0L87cPL4PQ9yt6wtsPqdqKB?=
 =?us-ascii?Q?HEBVHbtEve4UTa2ojcWEyXbCRx7cl2jkUFEN42P0+jlItYlaHg11d9HN7mdR?=
 =?us-ascii?Q?giqXTYFNPZuzJ2Nl+9rS0MMm3cmkVy/cZvZJfJTctoMf51XBU6qttr0CwPar?=
 =?us-ascii?Q?gvsDTVFH4gJTEVCGUqeYsNE7ttyiOmbSQ5FjFnNy2QGzvR4WuTosR55S6dbd?=
 =?us-ascii?Q?2NYm+1CVlkrHfv04Ot3ZGxMS9p6lh2k5L4mSkT/KmVe5LlSl7gwFHb2f/1WV?=
 =?us-ascii?Q?nP3G3TYtpjJiwCasIV9uhDn9CUi2lUX9uxTzbzQcb8iTNlQyTyvbGT7rlrcd?=
 =?us-ascii?Q?Y0MwG6boaSVaQJHWv027MzpdG7l0YD3hgoFsa69ysZZ+2ll4zp2dfgIjfT3l?=
 =?us-ascii?Q?K75xnjS3e7nKHYzJANDrnaRJAoQ9LbW46N5M/mxVyC88oQ/Lqw4IEGN2vMlM?=
 =?us-ascii?Q?iufK8JcR2hqs2IXTESUHnHsYpi6unZ7Dh28xHL7eco/xgcfGfLw2UV2eK3cR?=
 =?us-ascii?Q?jrz1KBH6oIhmvA1Wji6wH3R1AV8XqprA1QupeipQswcREvQ9Y4bHg3IMH0x0?=
 =?us-ascii?Q?pjUP3aaDjMZzL6CnjfOOjl7cbnboD2shzVJ+IoMV2x2NVhW1qiHNlW7J9EfQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa18c889-70b8-4809-46a5-08db819a22c7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 23:05:21.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3oqtZf97H6qjiH27mQTv1pG0eb65tA+XQSLxt8un46sXuKeGATmbaewkzCodoBJ4p+fnlluHQHYU1u+7f9xKTyjQYtvQVbRp13j0jjGYDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100209
X-Proofpoint-GUID: m0ytpZvstgMBRkoW-mfvYlV0bY-G9_RJ
X-Proofpoint-ORIG-GUID: m0ytpZvstgMBRkoW-mfvYlV0bY-G9_RJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

========================== OVERVIEW ========================================
This patchset attempts to implement a listed filemap TODO which is
changing hugetlb folios to have ->index in PAGE_SIZE. This simplifies many
functions within filemap.c as they have to special case hugetlb pages.
From the RFC v1[1], Mike pointed out that hugetlb will still have to maintain
a huge page sized index as it is used for the reservation map and the hash
function for the hugetlb mutex table.

This patchset adds new wrappers for hugetlb code to to interact with the
page cache. These wrappers calculate a linear page index as this is now
what the page cache expects for hugetlb pages.

From the discussion on HGM for hugetlb[3], there is a want to remove hugetlb
special casing throughout the core mm code. This series accomplishes
a part of this by shifting complexity from filemap.c to hugetlb.c. There
are still checks for hugetlb within the filemap code as cgroup accounting
and hugetlb accounting are special cased as well. 

=========================== PERFORMANCE =====================================
6.4.0-rc5
@hugetlb_add_to_page_cache:                                                                                                                                                                                                     
[512, 1K)           7518 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|                                                                                                                                   
[1K, 2K)             158 |@                                                   |                                                                                                                                   
[2K, 4K)              30 |                                                    |                                                                                                                                   
[4K, 8K)               6 |                                                    |                                                                                                                                   
[8K, 16K)              9 |                                                    

6.5.0-rc1 + this patch series
@hugetlb_add_to_page_cache:                                                                                                                                                                                                     
[512, 1K)           6345 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|                                                                                                                                   
[1K, 2K)            1308 |@@@@@@@@@@                                          |                                                                                                                                   
[2K, 4K)              39 |                                                    |                                                                                                                                   
[4K, 8K)              20 |                                                    |                                                                                                                                   
[8K, 16K)              8 |                                                    |                                                                                                                                   
[16K, 32K)             1 |                                                    |  

6.4.0-rc5
@__filemap_get_folio:                                                                                                                                                                                                    
[256, 512)         11292 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|                                                                                                                                   
[512, 1K)           4615 |@@@@@@@@@@@@@@@@@@@@@                               |                                                                                                                                   
[1K, 2K)             960 |@@@@                                                |                                                                                                                                   
[2K, 4K)             188 |                                                    |                                                                                                                                   
[4K, 8K)              68 |                                                    |                                                                                                                                   
[8K, 16K)             14 |                                                    |                                                                                                                                   
[16K, 32K)             4 |                                                    |                                                                                                                                                                                                                                                                
[2G, 4G)               4 |                                                    |

6.5.0-rc1 + this patch series
@__filemap_get_folio:    
@get_folio_ns:                                                                                                                                                                                                    
[128, 256)            13 |                                                    |                                                                                                                                   
[256, 512)         11131 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)           5544 |@@@@@@@@@@@@@@@@@@@@@@@@@                           |
[1K, 2K)             996 |@@@@                                                |
[2K, 4K)             317 |@                                                   |
[4K, 8K)              76 |                                                    |
[8K, 16K)             23 |                                                    |
[16K, 32K)             6 |                                                    |
[32K, 64K)             1 |                                                    |
[64K, 128K)            0 |                                                    |
[128K, 256K)           0 |                                                    |
[256K, 512K)           0 |                                                    |
[512K, 1M)             0 |                                                    |
[1M, 2M)               0 |                                                    |
[2M, 4M)               0 |                                                    |
[4M, 8M)               0 |                                                    |
[8M, 16M)              0 |                                                    |
[16M, 32M)             0 |                                                    |
[32M, 64M)             0 |                                                    |
[64M, 128M)            0 |                                                    |
[128M, 256M)           0 |                                                    |
[256M, 512M)           0 |                                                    |
[512M, 1G)             0 |                                                    |
[1G, 2G)               0 |                                                    |
[2G, 4G)               3 |                                                    

=========================== TESTING ==========================================
This series passes the LTP hugetlb test cases as well as the libhugetlbfs tests.

********** TEST SUMMARY
*                      2M            
*                      32-bit 64-bit 
*     Total testcases:   110    113   
*             Skipped:     0      0   
*                PASS:   107    113   
*                FAIL:     0      0   
*    Killed by signal:     3      0   
*   Bad configuration:     0      0   
*       Expected FAIL:     0      0   
*     Unexpected PASS:     0      0   
*    Test not present:     0      0   
* Strange test result:     0      0   
**********



RFC v2[2]-> v1:
  -cleanup code style

RFC v1 -> v2
  -change direction of series to maintain both huge and base page size index
   rather than try to get rid of all references to a huge page sized index.

v1 -> v2
  - squash seperate filemap and hugetlb patches into one to allow for bisection
    per Matthew
  - get rid of page_to_index()
  - fix errors in hugetlb_fallocate() and remove_inode_hugepages()


rebased on 07/10/2023 mm-unstable


Sidhartha Kumar (1):
  mm/filemap: remove hugetlb special casing in filemap.c

 fs/hugetlbfs/inode.c    | 10 +++++-----
 include/linux/hugetlb.h | 12 ++++++++++++
 include/linux/pagemap.h | 26 ++------------------------
 mm/filemap.c            | 36 +++++++++++-------------------------
 mm/hugetlb.c            | 11 ++++++-----
 5 files changed, 36 insertions(+), 59 deletions(-)

-- 
2.41.0

