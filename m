Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27C36EAC1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjDUN5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjDUN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:56:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B074559F9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:56:52 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LCYhuD025556;
        Fri, 21 Apr 2023 13:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=uYAWVCpyzH9MIuX/naIbV1XFjIR8SNTM4Kb54o/jV1I=;
 b=HETluDDUNCBbx2p7zlBom28gP5zcU6NwrsP94GFBDSArwokrlZi2jBJ+QWz37lHHm5kH
 bOT3Yk7aMrjMIgSQ91EvfEkSOpyKDWvyEYx3xwMNxXSU5MrvBjJjKKCUFzOS/Ow1VSwx
 WwjaPb9ldTZk4KD7ymLCebx2Wh9MwW0OrP3esm25XXY3IBV59DYKeIj36iguNiVA6wFZ
 rQk6/c2dBqM0HonwGjtFYXlZAxP0Hs/yBXyyjSHH7X/hJnvzokBURfHj6jqrGcxfnEKw
 vuiPCkvQSZypYted9Dxnj5uqF/1nKBL2h5rYcTP2ZNf2bSPJ7C5p35e6ZmKROfVq2igQ Lg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjucdeby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:56:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33LC93F5026314;
        Fri, 21 Apr 2023 13:56:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcfy1d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:56:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xj2b4VSQ+zMKnK2Bc17FGzQpslh1lYwD0JITgcSdNLBvu1q3Jp+Fh8Vy7tf7lgLwjcmkk7tfDN0lBfY5yMgqUyHjlQJYilRJ6uKdj2vKVSTTkFWbB+UuZ6DL+i1GmbsDiBh8Vyyc2QiNrybFAkulArYieNVIQ6N/F1Y5h74qeURjtrgbVQfTAkdBTMeTz5yjcbs6k2hBbTn9+vNl2o7o1ZgtQiaGzUOix7cMOgoSJj20RjuqLkBj13bcFrpkOdaM4tzZ2ktn4SqdUQuBJge1GB2bOdmM4kdnrNxzrQWXl+oWE3kNolYghknDKvO6A4MZoIJmXnH10suERMNAFC/H/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYAWVCpyzH9MIuX/naIbV1XFjIR8SNTM4Kb54o/jV1I=;
 b=JWUr85aQGg5lzo6R5xKSJdDmVInD0DCTAfyRuTrMW7o74cEN5719T1aFmy6wCV4yry1VCb9goZnF4RFXmn+juvRX/+Xbhbb/koFpct8enkde1c5ByXbX978PqGBHdcOa22FT2GBCe3gKtvmtmt88YsoLEzcHKMByD+LRHpFKLLuLuP7C2dAK3LkLc9n93xuyFAPk8PFouCH7TJ9E4d5YS61s2u70vAKq5B0M2i3wmjEnc6DFbdYQhVq/CMIUUcUVOTL1wzuJV2A4PjI3tYa4EiROn14S0gtfR1189/3ziyaq/XRQX6z1zO43Kt+57qE14KIeF5jlQKZ58U9X3J83yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYAWVCpyzH9MIuX/naIbV1XFjIR8SNTM4Kb54o/jV1I=;
 b=J0+C//0WnlWXqu3Lx32lNuHrldef6sII+hGLzmYxZqi2Dki7NoZGRh8HGvSTaRHHYcj7vrjMSkLwMbslkQOm9QiRJLAhTuUd8wzKVfYqor3GqQNSHBEfLfL8yXsqE2Rpn0jai0iS5JkF+8cqteSh8EMmXOjethGXw8fgQ4ARNjY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7540.namprd10.prod.outlook.com (2603:10b6:208:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 13:56:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 13:56:19 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 0/4] Fix mas_empty_area() search
Date:   Fri, 21 Apr 2023 09:55:55 -0400
Message-Id: <20230421135559.2163923-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: d67ef863-293e-463a-9cec-08db42702efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXWYYwbMAKAYyZug541QNa0jgxjWkS2Y04MHwuhixJQWS32DiKTDEe99VbO36AhhTHPvyyfqgvYYzaZQF7p6vW5tP+jYZFRWEIiOscln/x2woRNX2MaNYkgkqJPmSnxF1cpDxehCpSdhey1t7WtGtGfxK5E8YQPYHP43Ahrnz7IhDW0Lz4wkaX8q+OcWO66F1BK7LLwF7vvCn1gYQOx1NAbDu02IpQAQWtV+phTGwt3ZykNf/l9gKeFwdoZKp9GenXDz9+o2uE78dyp0VDpTjOVI7aNfxGDL4lRUKgj0JKTL7nKCxvIufqhqK06gJAI2I/cWDWrOw5dyYCNhh4i4he6iSD9EhZSqCAtifMIy0UbsCw4K1D/K/TXEIuvr/6r2oLN94+ajeVIyEnH0I9uZ8U16hiTr1UIPSjXtWfNIHcFSWrqqBcYSLFzCA6/4jW+45tmNQEVz5bxzoaSM1VowvdlJXpuLMmH0/M2xnbm4H5/sWdIKtbhnDPD9wfyyDH/YzIHnh3/+qigTREkx1cdBt0Z3gsvk0rc81nXZ45P7GiuG67LHR/DSNlbuz1NqBgxnUTz1rSB8W1Qt0TZi4HfkCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(8676002)(8936002)(38100700002)(6916009)(4326008)(66556008)(66946007)(66476007)(41300700001)(316002)(2906002)(5660300002)(186003)(107886003)(86362001)(1076003)(6506007)(26005)(6512007)(36756003)(83380400001)(2616005)(54906003)(6666004)(966005)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/TL6AqmAvfebHxf8Hpyop/TSZFwjgiPaEMpnrOsn8vBHp+n5vbYx0XhmAgeJ?=
 =?us-ascii?Q?etk8mFGtU9ZunxZEUXOuANJZKnUKl/kX8CBnex4jOt2fUVAfWQroVmCXQaJC?=
 =?us-ascii?Q?RivL8WBX8jS76pXkXZ/auu14uJhMNPXYIJkUn8qNFshcNS4yyVlWNMsPIZuf?=
 =?us-ascii?Q?lHRsPD3XVbF+ZEyNrFs3C7gMSure9/FzKDUqjeM694QhoW6cCiOm7AMu1a6M?=
 =?us-ascii?Q?vQIf5p9Pvfzo+CSVS3VUto6Hvg1T41bIeHIrxksGYgSKyRYCjU2bzFIWvje0?=
 =?us-ascii?Q?ak23tgE+K0ZbIPvP6cR1ZazS2uJzzEOHOKY5t0voxzglVVxCz4Yh1X772LqM?=
 =?us-ascii?Q?C/MsLZsKd9qCuF1QAHRHpuOeFyxc0ODbnnkWWQwNe/7d3KHuQB0CwtsOKfja?=
 =?us-ascii?Q?t0dEd+Mg9kEXV3jR2ZEokS2nLpVGDycf0Ony6kyAYJMBBS69qBKbfyVuW8ch?=
 =?us-ascii?Q?U11MI1VoaoRzgjg1QJIvyKPHx8ywg1pJudj2wNM1N3VCQqVErh7toOuSSvkT?=
 =?us-ascii?Q?Lm1ZqoojQjFGklwxUycQhCdZB11QhTqqUQLx3Uu31Qx1b5A3Pzz6J9QhbFKQ?=
 =?us-ascii?Q?pU9QLF0rRei1nKlgkLtmFGn3u29xStjg7S6qKZ9VeDXtn1pT7oCRCpC25AJy?=
 =?us-ascii?Q?v5TAANeneJZyAfD7eYbdb9b7qJN/cL/Lb+wTymta+W7OHiZBSNjRRF6vx5rv?=
 =?us-ascii?Q?C6QuBhHyNgfqaRWYS8trzLz3SmrcZKI9tkjwdJDz+q32oRSFxYOtmXIACPFo?=
 =?us-ascii?Q?Wc7Mtn4WaiIVm+X3jf26U54OntEatH7G+yZrxMCIIwsp4tp9LMBtXOBDqtD7?=
 =?us-ascii?Q?GQGRo6xPlzKK5aoU57vESZJeTtbXsMsUiSZmW2+M2p/8KEg5ZXWZB+JqRGbE?=
 =?us-ascii?Q?sZtfPkMFsljxUKn8xKhe2buYEUulA3ECz0zaWKLw7LYNQ6GSVhFk50cxJkTQ?=
 =?us-ascii?Q?tGNVaGLlT343h/FllUlTfbb9slSKPzW+YCHrcpNdxTmwwVK2rM0KIn7msoh6?=
 =?us-ascii?Q?H3fTnJjP174znrPw8O0OTeXnJ2oUalA3uA0caC4XtWoYuC1epkQozl/jmYLT?=
 =?us-ascii?Q?FTU9MNFMMw55dfF2/+Br4PwQGFJBruo7eM5s9vG7J9UlwUIiUFheqY3t2Wxi?=
 =?us-ascii?Q?sYRTgl/vl9I+Hp5V7bVBvlDiDpJIYyqWHJiWzLLKSBYXnaUOhJ+t2RiEp0C+?=
 =?us-ascii?Q?TMh35GdhlOZcS1ktIPP1fafF6vDZawv2G9VYlsIXP/yqCIDUBefj1c8glkbs?=
 =?us-ascii?Q?XaW+U8H0IbUqZYljyd217QACdATr985BrZMu5UBh0MeaDeA3sL6LE0LpLXjl?=
 =?us-ascii?Q?Mh83ep/NZMNoEwH0zYgdSK0qi0PX8tp9Bpks64WAOD2/vQLhrJ2rfibGl29X?=
 =?us-ascii?Q?Tn1oBPFVxKe1y19lpNT/Nv47N4gGFlAQuzua1IfoxN+Khcqb1DvHbT5zff3i?=
 =?us-ascii?Q?YQMRScNU2Ft1o6voMCi1XAwunP8ymxv0AmKpod3/5p0T/2AnEUFo9EfCFZOS?=
 =?us-ascii?Q?UaTQmT2UPPP7zP68hcR9uULWwwX/UoblJQGfw/h8rq0sSxNhI7BQ4kjRLpgr?=
 =?us-ascii?Q?xFpYf/uYbF0MXXtbrSWf/nP1vemXGDfQ28Gf0CBPvx4Z7wWYN/NtR2POk4Q7?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XRyEWgqvfOMzlqRlPY8OzxSQNujjQ3g0cN4FSwunH/J+IOICwMv88ANofrlW?=
 =?us-ascii?Q?fwv42bjJzQj6RP2qLXhRdf4+WnpRbN4fD59xz5i75WhX0CC/wImDikdapYvr?=
 =?us-ascii?Q?NMawnudWVmF0rNBd/MJzJcLNHideg5HN8D7xisccFsrNa6UnRUpGxAirZ8YK?=
 =?us-ascii?Q?DUTl41yoWqfdU6wa7UNBjaMsTbUWFrH9pJCWr8mttMNb6MR6E9FnYKYeHq2W?=
 =?us-ascii?Q?m1H9zNz72STVC2k6TykAlwzwrfChUW4VSyesovhgT3HkJEvZLPgk+vc/InPb?=
 =?us-ascii?Q?Q8YsJ3accLDh+FbPZba+LHxNkLs7iN7WyFbMjrWlP7G0umg7aQM/pfJ2hQ0u?=
 =?us-ascii?Q?t/v+cbLiOkQFdJQ4TLESw0KNyDdPWOIegeqgGQZY0zO3DMTDej9gtwfDbx54?=
 =?us-ascii?Q?qHIZ90cUFw18fFg4SvYd4i8WpNtsmcqat4KTIzcJhYJrjnm/sxgt1lajWQtX?=
 =?us-ascii?Q?0HLgF1q8UT4SblQRzzSlDvBhx5sO9+yDKWe0ECvkU3mlXi6We4ipuD1TSISa?=
 =?us-ascii?Q?fgSm3SgfmAtu3JmBAr0aIek63MgKb7K3pna2NS/hDjI4EfnWLc1HOnXL6hus?=
 =?us-ascii?Q?YiOD7uUnsR1twHFMfMP3Ian+bwKnVZmW43RTzvOOWGnC+Yp0O9Hp2bpvBRSx?=
 =?us-ascii?Q?a7p91L1wBesptBPOPwykI/PgvHB3Zz+arQEafE19/mTOKzAqhUBDN7pkEizG?=
 =?us-ascii?Q?YY46ylc8eybXkoBKWFkxrF36urknRlCnCQoNcOmBnNks4B/iBxnQwiBPHJM+?=
 =?us-ascii?Q?AWO/oklV+f8+U7gkZp+r7FfdkZf8nmloxYi8CyVtHdYzq6HblAZ0HxmwyKSe?=
 =?us-ascii?Q?tFgrJv80y6bqbXb2uoS38tn1+1Byrdo2CnXlyg2Dl3O7HD6BLSYob6HaNEwO?=
 =?us-ascii?Q?EAZFCDEUyQT+ilN9L2Uo1aQJGDLo5bXz9LbGmIp06EKKNNynGAYsahHFBnyc?=
 =?us-ascii?Q?+UdXO47R2x1U9Vz6gr9VWA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67ef863-293e-463a-9cec-08db42702efc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 13:56:19.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00USB2EMvQlh9992ZMezxqLeGhjToxQ5vWPsbcJmGfsZwOHgV9o8gtdStinZTRquXlLuEs3utCkTSHzSGhrT8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304210121
X-Proofpoint-GUID: ZfPdlqGBWiv5EdW-KU_4k2t0u8Xslc-m
X-Proofpoint-ORIG-GUID: ZfPdlqGBWiv5EdW-KU_4k2t0u8Xslc-m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_empty_area() search could potentially return a sub-optimal position
for a VMAs as it is coded.  This patch set is to address the issue by
altering the maple tree search and the mmap call into that search.

Changes from v2:
 - Addressed Peng Zhang's concerns around limit checking.
 - Updated testing code to work with size of 1 and added tests for this
   case.

v2: https://lore.kernel.org/linux-mm/20230414185919.4175572-1-Liam.Howlett@oracle.com/
v1: https://lore.kernel.org/linux-mm/20230414145728.4067069-1-Liam.Howlett@oracle.com/

Liam R. Howlett (4):
  maple_tree: Make maple state reusable after mas_empty_area_rev()
  maple_tree: Update mtree_alloc_rrange() and mtree_alloc_range()
    testing
  maple_tree: Fix mas_empty_area() search
  mm/mmap: Regression fix for unmapped_area{_topdown}

 lib/maple_tree.c      | 61 ++++++++++++++++++++++++-------------------
 lib/test_maple_tree.c | 27 ++++++++++++++-----
 mm/mmap.c             | 48 ++++++++++++++++++++++++++++++----
 3 files changed, 97 insertions(+), 39 deletions(-)

-- 
2.39.2

