Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04A0708465
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjERO6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjERO5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:57:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB310FE
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:56:58 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6Iv13012574;
        Thu, 18 May 2023 14:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=zRLGH7gq58hVqtaoAKIrtHWyx5C7rqWxKaoNSCx6ny4=;
 b=p0oSPVXY8tQ5J9VpLljBbHpFkmBF0hxlUyFFXQ1W/bYVGKWNtYB9/rhXfh8E8FU5a9lR
 aHALLiNP6LSwu/ZavTfD2ArkCdfzkT3t8m5yLy1LDvIqDFsZFBN4fuA0NijcCAn73fR6
 wG2IBUrk5pX/ouQWno5kOTAlVKfxTdqGTO2X6WXh+omHkXkKwhhgRC/fTmk/qIhJoFDH
 toBOV78yAIbLtPKeJeYSxRENkKC43saGhup/KtcCYrv+diwTeJsEdjHnGIsLfpZK5Jah
 1yrbA+NMBYh7BXhVRh+URizkNZIi5I9+HFZDe9PiGmTo5hXY0ij/bbFVMTI6tQ3uXK/X cQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdrgw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:55:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDcgNr004192;
        Thu, 18 May 2023 14:55:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10d66h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:55:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mzl0P4TIrSQmwWKT868BJEByQ2R/K/XY2YgDAEgP6tdPCc7SPN24DNnh8h/Zrwcpp8D8ylrOPXIbEioHgnCwkU41bS3hq7C1D/h6EUck/dlmlu2D8PsDBKUrcKoWoM71Odm7Q67t0fm4PpHU+8BhCU8jk5TrLVBKOdeax03Jaz7wUluzfHZVhB5NHa6oasU1E9/A0LR9cNrr3PDTXaaLBNT3afKfUhgVggNY8T0ZR1qJAzA0rNuvgaGXjzYNACipu57UFhoAVPR+sfvlnaArDhHlNF2gA4VlR7izxhiP6LKpZv27JifN2KkgcXlgEI5UJulQ9Hb4AemGdqZUHHgpag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRLGH7gq58hVqtaoAKIrtHWyx5C7rqWxKaoNSCx6ny4=;
 b=XsyPG3dD8CWIK9T0RSCEaP6J0OZGbGaQzDsDWtZeG8ZNc3PiNR5dfjb82K85xcXlBBI8nBKUJyE/+/VoFlwO8CN9G7jCXeM1+E42giTRgTjKReh+tYOHrqhxZApEq9V5xXCSSwEg8nIl3EpncNK5iXuddQQgfzZyQG1jQXkC5QzFNgIPk83D1SQJmuhPorOBe1tsoSSHffYMS7Yu0OrJjiwscaq5X19oe/yKv6HirGjl3yi36qq+V8KJ9lLgL33r/RbOY6tQeY4YLrQF9d/ypMXlYMiy663sa0jwYZtmlylnoAuQNOefkN1MRDHGEZLB3eMsTN03v7aBYwB0obFkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRLGH7gq58hVqtaoAKIrtHWyx5C7rqWxKaoNSCx6ny4=;
 b=hFVZEekzdUzi6Fk2AuqCxZsWoM7/le/J5tzCXH6kpVQARxfuffyorWYa8xu/KvI0vCAZi7cu4MoNXq/575+YGoj3zvll3x9mMyBQ1JZBktGoQgn/wSuNa7TPbZlFd0jADZT/6G/EplP/GS1VmeTOUAqKun8/ayAQx38qt8wKdzk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:55:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:55:49 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 00/35] Maple tree mas_{next,prev}_range() and cleanup
Date:   Thu, 18 May 2023 10:55:09 -0400
Message-Id: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2b2286-4c7e-49c7-c355-08db57aff7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bBWgARPoPl+L0cRddD37dzQlixZWVm8ypZYqYwCaYI8NAgRkJrw2rywYV3WB5RdWwo3fiMVt16KJkjCORkUMUZGJBwt7oTLOLCuXc9hddYReSSiqwpGJMpQcVLCc4rX5062HqvSFyyjblPGc6hlYjkVfUzSzwRdenZOZvnelatuGEEg8d+DwiFYRr8oi5hoW5JIUA3RJmCEOUKGkkBp4SkLxeTUm3xN4Fxm4oH97R4dlp2hVbOtAVHjlGHCVONYr52MbkRLsZRW91819jRz8HZI6GX5tfKebRE8swHjEOVqyccmq3HREJjAWUSVD4UeUeKur3zz+y1Vbal+93d4BhmA/fGccNa4B1o0Xl3AQNiVjlWz8+23xY3vB72mHkpMwvScgw9rLZclOMrbNXZqV5dpUGZHwkCC7Y4S1llrWLYT7LOxmP646Kdm43GgTg9i6DEZZmtvaUvq87m1NkFjK9pYTTxlssGSI+uVdWc4sqDG47whRLF0373Na9GRpZTGb7oGs8x2gUI3NTJTPrGPaBSdEvRcL5TRLeauN0U2ylXNVyNNPTjyLKKVsWUkwdrHr9sOkyK1oKdyCb0UVl7foKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(6666004)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(2906002)(41300700001)(966005)(107886003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xmsxk0x9b4zshXoI+m7wlGP5bRnTqwhIkgFzfAaYJFn7Q/uSx/ZXoUz+7oCs?=
 =?us-ascii?Q?SvH7CPQ160TL8qHBZkRm1c+NSzuPyVnhLODUb8xWrqaYuaBlfN4aI9rT2Ik0?=
 =?us-ascii?Q?aavwDrTbXKucnIPuBW1cLpnlEGUbq+sesQB1VYOpYwxKutQSvSsMX6O1pUQ3?=
 =?us-ascii?Q?jo83V+5sUy56HkZyk1eImuWYdVu3viHiw2/DaMLUnAcYGLXDkI675PUvptd3?=
 =?us-ascii?Q?Cu6lfSax+MIlQyunihj++HKFY55iVZ0Xci2Sg98kGvKJugARk2saAV34+p0i?=
 =?us-ascii?Q?0VqkP6WY1WvGSGr6uzE5C6QMThmH5fSj7wBXSmMYnr3ioSwM637eHYCP42Dl?=
 =?us-ascii?Q?5jT7Vf/u0n1RYASHZJvjgTzeAWXg1an+5vpluyVAnu7OKun2R+UhfY6FmE99?=
 =?us-ascii?Q?vSPiS3xzqC0Jh89mhaI2Uu8GitKKPKs4rtcgQkJEgv1pifO9i4JdAiQkJbLS?=
 =?us-ascii?Q?KFhOteyJUNdWoY6/6lBNsDn0v0JAJNhpe6Rs0bL0dUavRicFX5Sx288IbJ7W?=
 =?us-ascii?Q?YD7jONuggqiw7L3Mp9sLF56dEKoEWTUYQdLk4t6lTITu2T6CiHXwrHwiZxrc?=
 =?us-ascii?Q?2KF3ClG5DG2akh0M6puz7x8gvZge27UZMQQV/9/B0xjQx8s2ShAerynqpZN9?=
 =?us-ascii?Q?Ff8Ci0N/dajPfocEreG/gkwAyJK6/o93p8Hdqv5y1R4kQFD/BiIs4+n2zYkO?=
 =?us-ascii?Q?4edMl/so9EheXBoWvRjzJcjNJi45vtXsAoZus8UA/u9fozBImFl/+GqV6gq/?=
 =?us-ascii?Q?kbdUPmEUdS+eDMA+xw0Dt/zwn813CaZMgzpv0NZd7fcYrzj4ygRSEvgChQwz?=
 =?us-ascii?Q?UnK4pubj6jRwC3dw4uPNrxVYrT8AKBYcdIzVBBcOkWSlyKOiwbbgHE13d381?=
 =?us-ascii?Q?dXjs7er8nmmF9bXyrKK6dQchi3N/g91DBEwjjmMB5t/gpHQdiJVqi7C8ocBF?=
 =?us-ascii?Q?dL2KYpgvOBKVRXY/g3BZA1sDhcZNDrn6REZEvD5/6Yeh1anrnXOW4XhL88e0?=
 =?us-ascii?Q?O7hzs00i20wyZaVRtUHplebYdK+HNKo8W69EJK2i7holey4FzvAdKYtDVDvL?=
 =?us-ascii?Q?r6HKXJcRLVAM47aQz3SnVzUoBxgHq/XuJL3A/evJVAnHZkpvovaC+K9j9FM/?=
 =?us-ascii?Q?mQdWcgPzkBX8mv4ichouZTck6TR+7EQxrqRou1x/JAM1lnPo3JVFMwB4ZIyL?=
 =?us-ascii?Q?1HD3E0ZmYRzaBcq2CRCa/Su4S8A+zssQ2j82Qg91ix0eDlsk5yFWQc1OiXgD?=
 =?us-ascii?Q?gwxA1/wvgsW7qkZCJh1U+vjrKsFdvyGcmz7T/hfyuFrtfDnFpcb431+wFpu4?=
 =?us-ascii?Q?ognaIV9JqT4TP83z3MlslBv7GHZkl/lYTQnTL2fa6xkzw90ngCNF7Be/N7LZ?=
 =?us-ascii?Q?04AoC4i6l7bIHvRbc2pluG1SvxDN4VrDd/qOH8JyIQeGRh6xESdidFqy+DYQ?=
 =?us-ascii?Q?nhgrkRNd+IFXka3RYV7QMX9a7hTkdXWza3Ni2zjJDN++AciwT9tSxMStSNE2?=
 =?us-ascii?Q?T+iHF4gmB+niTNyJi6r1/1gdNtUhOc5NsQsDecs6wmK34rjTmfYDjJAkFwMN?=
 =?us-ascii?Q?6zxPDgJWGIcvwPTQMOo5DIZd8bvYJyLb18ufO01GAipSaL6IEcIhO53IfDNF?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3DwWdXpZ7Io3DGmPkFH0OVvJBg1k/imRboUqiwLMh3ZL6y7ms7lBF3guInCjjPfJZvfEuMeF5KiEg5sWLxPxi1RG9fi/CYNXHpjrz0xvdVaYbpvrma6ZHSitEA85kGgF0zL0HQvGGsdm/YITBIZ8VvPeWfua2UgY5fmDx7FFwXfY+ZYDr7dg3NPME9I9SEObNn5hQX9ZSPxAZYjxYeAopVlINb7OWqckiZxXpgnyIoLinlYzosrJeWQNxi0jAVfTR4+LSix8Q5IhKh9FzDeNo8vt3iAW7/J2MdvMEAxaRGjWK56f1ltyOVa3saJc51Zb/ZCr1FBJLhM2NzJKZGZ0473ttFuT3L4OeITcQ9I4NmVTTZ1lvhVgbk20Mw0yX3M8BXKeyiQNSYcFtdj7deEyh4WSp6JLHweyBvoPP21q8cY/PBCuMQSGT6kJcGVWj7rNSWGUtmLQA+Hy6KXYboFRjoVOwAnhQINnrPCTGhKh6jiayiCa8as8Tem6MznaIh1e/QD4Azvjr1nty5q+7fWZkfyfumqGrPukSTddR7bsA9p1DBY6/AU09m/kwggKDN+o6W/ULqdYjr9r9vxCcN7l0be3OyrdvZGPMj7lFAuSA6qnzm7885CwuL6Dw6Jh1HzckFTLQCHuF0CdBj1p5rFkerRNIGrzWissM+vkwlbtshtA+HdCqfTT1v1gPea7VFNJi/9ddsplJNg/Xr+eztL8VscT3cTOGvKtWLlFi7VoARk1NnZUwDmVhhOoYSIi4jko3hVdSJQnhgAWUnQSSgEgwitjF8YDvoSuurP5aYZ/NwD6aWFGIe2m4RnOzZNVRgo6Vpdub4kRCXELxHAEaubXA13GxVNHTTqyNQo3QaiTqlHkIEo0FarqYmV44/HVNQh2n8BWMExtm1QL0Cg1o32r/Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2b2286-4c7e-49c7-c355-08db57aff7ad
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:55:49.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrP4BMmdM1SoqX4VqVRWAdXWvTziKiCKnInzYJJzMRV7GmiN/Hyo2DMSemXBu/HpV4yC8UwvhGrFo6rlI/R8GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: QD7AWM--DdPUfmKIkJyx5ednvHwGjFNm
X-Proofpoint-ORIG-GUID: QD7AWM--DdPUfmKIkJyx5ednvHwGjFNm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains a number of clean ups to the code to make it
more usable (next/prev range), the addition of debug output formatting,
the addition of printing the maple state information in the
WARN_ON/BUG_ON code.

There is also work done here to keep nodes active during iterations to
reduce the necessity of re-walking the tree.

Finally, there is a new interface added to move to the next or previous
range in the tree, even if it is empty.

The organisation of the patches is as follows:

0001-0004 - Small clean ups
0005-0018 - Additional debug options and WARN_ON/BUG_ON changes
0019      - Test module __init and __exit addition
0020-0021 - More functional clean ups
0022-0026 - Changes to keep nodes active
0027-0034 - Add new mas_{prev,next}_range()
0035      - Use new mas_{prev,next}_range() in mmap_region()

Changes since v3:
 - Fixed whitespace issue in mas_find() - Thanks build bot
 - Dropped mas_contiguous() until a user is implemented and it will be
   renamed - Thanks Andrew Morton
 - Added missing comment to patch 34 "Add vma_iter_{next,prev}_range()"

v1: https://lore.kernel.org/linux-mm/20230425140955.3834476-1-Liam.Howlett@oracle.com/ 
v2: https://lore.kernel.org/linux-mm/20230505174204.2665599-1-Liam.Howlett@oracle.com/
v3: https://lore.kernel.org/linux-mm/20230512182036.359030-1-Liam.Howlett@oracle.com/

Liam R. Howlett (35):
  maple_tree: Fix static analyser cppcheck issue
  maple_tree: Clean up mas_parent_enum() and rename to mas_parent_type()
  maple_tree: Avoid unnecessary ascending
  maple_tree: Clean up mas_dfs_postorder()
  maple_tree: Add format option to mt_dump()
  maple_tree: Add debug BUG_ON and WARN_ON variants
  maple_tree: Convert BUG_ON() to MT_BUG_ON()
  maple_tree: Change RCU checks to WARN_ON() instead of BUG_ON()
  maple_tree: Convert debug code to use MT_WARN_ON() and MAS_WARN_ON()
  maple_tree: Use MAS_BUG_ON() when setting a leaf node as a parent
  maple_tree: Use MAS_BUG_ON() in mas_set_height()
  maple_tree: Use MAS_BUG_ON() from mas_topiary_range()
  maple_tree: Use MAS_WR_BUG_ON() in mas_store_prealloc()
  maple_tree: Use MAS_BUG_ON() prior to calling mas_meta_gap()
  maple_tree: Return error on mte_pivots() out of range
  maple_tree: Make test code work without debug enabled
  mm: Update validate_mm() to use vma iterator
  mm: Update vma_iter_store() to use MAS_WARN_ON()
  maple_tree: Add __init and __exit to test module
  maple_tree: Remove unnecessary check from mas_destroy()
  maple_tree: mas_start() reset depth on dead node
  mm/mmap: Change do_vmi_align_munmap() for maple tree iterator changes
  maple_tree: Try harder to keep active node after mas_next()
  maple_tree: Try harder to keep active node with mas_prev()
  maple_tree: Revise limit checks in mas_empty_area{_rev}()
  maple_tree: Fix testing mas_empty_area()
  maple_tree: Introduce mas_next_slot() interface
  maple_tree: Add mas_next_range() and mas_find_range() interfaces
  maple_tree: Relocate mas_rewalk() and mas_rewalk_if_dead()
  maple_tree: Introduce mas_prev_slot() interface
  maple_tree: Add mas_prev_range() and mas_find_range_rev interface
  maple_tree: Clear up index and last setting in single entry tree
  maple_tree: Update testing code for mas_{next,prev,walk}
  mm: Add vma_iter_{next,prev}_range() to vma iterator
  mm: Avoid rewalk in mmap_region

 include/linux/maple_tree.h            |  118 ++-
 include/linux/mm.h                    |   13 +
 include/linux/mmdebug.h               |   14 +
 lib/Kconfig.debug                     |   10 +-
 lib/maple_tree.c                      | 1181 ++++++++++++++-----------
 lib/test_maple_tree.c                 |  863 +++++++++++++++---
 mm/debug.c                            |    9 +
 mm/internal.h                         |   20 +-
 mm/mmap.c                             |  111 ++-
 tools/testing/radix-tree/linux/init.h |    1 +
 tools/testing/radix-tree/maple.c      |  164 ++--
 11 files changed, 1748 insertions(+), 756 deletions(-)

-- 
2.39.2

