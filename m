Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF9A6A253B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBXXyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjBXXyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:54:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CB43B21B;
        Fri, 24 Feb 2023 15:54:42 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEoQgV007435;
        Fri, 24 Feb 2023 15:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=oZ9BEHYJlGHKY/kKsK38H8Qihi/5txNdXjMXpVs9UAI=;
 b=twHk6Zo+LiIC4BwPK7v1xL4wZh7zv3jeJzoMvNm9VkRUqd20alrBHaD/POvinjtPLCsA
 Kf7kYuzl4rPOsZok6L8A5C/zSzkoP6G8HWrdg3JY5jM0AxFdIXN7y9c7/WJEdHcSzasR
 xucYP5kVJcORTEHrpxqKby/FAT/BstjlXroEIglomPl/QA4rowHJuEv0d13dFE56LFVS
 vgQBVl2qkDvyzV1y+/dHD5J1MR2iXkn1JUUhshNC8bs20YQmEaGwU2xwelC4k7bAc9Ip
 3NZkYGiNtWNJLtX059igoqSG1Jrxn5maXtMwM2A0W0uxu3Orr/UcLTGMhQ52kmGgq9DD Qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn90wb5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODWtBK034067;
        Fri, 24 Feb 2023 15:09:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4gyu02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYSC4+if2bK8OuzeKoxUKO1BdOFi0AMBggcIhLXej/3uczsKioPL0qRacBdNiHzlVQud/tgQszzkKEcvP5h4P9KkCSkbm0C/pZUFyG741ORuYP5H65TUZDlWLx+E88Cu4VRK99whoy6MtA3GYApYC6woquI/Q6lXXNHf5hHf+nF88i6Ne3ZBLfhyY+xDGRIgdO/jUWZeMzMUpdjxZmEqq2kKsnJJA1071NtAsFNuUtncuq3/v2mZf3PBJGBgQWvidI6/xwliEp8q6MXjbgmFLu+2I6pjmdfamk/ZGAL5HBiWd1xmSx1kZEfghXayQUHa+gZSWGycpvM7sml49llCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ9BEHYJlGHKY/kKsK38H8Qihi/5txNdXjMXpVs9UAI=;
 b=Ouoq45hItv0UTPr9u0rFSu59/sQpSqpoc8tLhQ27Z9coZYl5dG7GDFMFEV59Md5yZlQoB5dCNRNnN0Rs1JLDIJj9XWyaQzqXUkwTi5LdCyXrx8Ta00Hm+T5buvJ2KPoefoj2UAQxa2823Fawk7FmJhM9c8G171+sj18v/X8oVBxtTn/VhtTpiHE//6R1aMNXE5RqwuMwD7ezVL/qqL/8RGFZk6Z3aO4w3fhwY/xzAPRDRQAfMxN9gUAD61pbZ1J1LZlZY1KqMn76syE63Oq1Vv3y0eMkm3X9QAKSxPwcLN9sBH9OHZ6mIEnJRuWXqqrDgbpvQ7PzwQB2qLCi1iYhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ9BEHYJlGHKY/kKsK38H8Qihi/5txNdXjMXpVs9UAI=;
 b=pf6R1uubUkHnM56NpAMUWtutSJcnjGGPVz5YIN0yh0hVRaXytqqb5vgdLPYYCTSIauoKfrcjbkAMnOXF8qsdHYseVsBv6fgFxpVLZ778ihN9oMv4f0w/eIH9tMxejSRBOGgUu8ZFJohmjTiSwvVJuge1g7fXUJyT1IQ2uPCvNA8=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH0PR10MB5244.namprd10.prod.outlook.com (2603:10b6:610:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:09:47 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:09:47 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 18/27] mtd: bcm63xxpart: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:08:02 +0000
Message-Id: <20230224150811.80316-19-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::18) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH0PR10MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 26058562-56be-489e-dc71-08db16792b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OiHxruetCK1QhT3rrMnkM3xjVY7mWEnCEGCWdyGVvV0N+U3Ar4loMirMFjqNwjsRM4AMap/3sbQ1NTqizYicNooj52WXCet8VVCYhPG7k/BiqW7HoCIc7aqLHijafFx973S6DCFNCKjhU5rH5zWN+rHei99amyjPUb0koff2kuCdm+ZA1ZM4VxIaFFN1YGOBkaMdTTZtV9IQQIHCKevGnmBfYcy9C59ptZrWDKWQWOfRwmrTFFQQx24qkf1lnxYapcIa044t+TCfAM5ZfnppaBNCIlldIsU2zQHLqIVXUOGFVOydgPH7iCp9B5osPNj1Lv1OA0ZwoaPSsDg8QEMBmCC0UOHN47Uv0chejviSeUkARZLzwKb/wVsfjfXE3kd3oV67SxFnyoZ8cg0HY7IAyNF8prsOfQiqn8IYvPP0cKyIq4XdiX3vS6S9aerITKVmSUk8pN40BNklhAhdhF/BUbDYQUGWh+2K8RdY3HnHfFIi654bi0blCNhHpy6TLTxatCVcFKCjf+ERzCD+/cS/SH7aYaA6qVNUlVe8ffk2F2D1InFmhgMSSYBogHf9lK9oHhiPCv6CogRi41YGHNz2bDK6Hw8F0WeJRLXpxlf+OBByrllphoQY9jgvoqjaDSrcaSVsbDi2mMede+XMosEwiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(54906003)(316002)(6486002)(8936002)(66946007)(44832011)(4326008)(38100700002)(41300700001)(8676002)(66556008)(6916009)(5660300002)(6512007)(83380400001)(66476007)(1076003)(478600001)(186003)(6506007)(6666004)(36756003)(2906002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ni/+BxbARMLQMfSDS8VJWrw166VmnxVorLrIWh1I2lyy9+pjM2WS+F74ojGN?=
 =?us-ascii?Q?oMgeYPf46DTWDOlB1DGJpHPD/WK2xXAnQCsihsopEFwit7vhGIO6RftU4X6J?=
 =?us-ascii?Q?lFa0UbwU9o790xFhstWAdT8Y7bgLYQyheY8KSrjlIMrT4lcr/grt4svG6sWW?=
 =?us-ascii?Q?QS5Vayhpv7/CjJD2j0YaIALrrpDGRdFiRL3UVkfzNk1v6x5a6g/ErMiSnBFP?=
 =?us-ascii?Q?U7ouI/xeVVd9niToxhOb096qIJ8wzPxhWsd/8ZxwCWoi5y/BianpxXPKFrkc?=
 =?us-ascii?Q?MVIeUL+tmmpTmEb9V4SS05RtGZFc9DZpCz/95PffeCFlQiIsmFvqypr5R9IT?=
 =?us-ascii?Q?Z3WLRf1fuTT6N5LhQDIU7Ha5HK3RVUIsJHnbDDlNo5OtJ4tL4NLmRF0s+ZcC?=
 =?us-ascii?Q?YrGGLBy0nZcFgNUxaT+xgGeeq+N74dBSqVR4w7HukVZOExxnOrhIi+mfKA/u?=
 =?us-ascii?Q?guwc+IoXiP4hZ7KhLBoLe1MNdhxBYxB39WybNbTsHyGn0RxA24xMIQ4DNYOw?=
 =?us-ascii?Q?ZAJ5RsrMKPaxDjyJtPcRQ1E+SAYxRfdF+a9/fSzupXR0SzCgYxXMLBMeTGOW?=
 =?us-ascii?Q?9cboj/DZnFDCa04vO3Lx1vk+5T3cdZka/mOVOxzmHI7uXpAJS1H1MxxoCdm9?=
 =?us-ascii?Q?7yp+sRxACf683Kxy5imW+A3ii+dNs9FdlSDv+s0+CQAYUbtzC73//5Twa0iL?=
 =?us-ascii?Q?db+B4uNeYl86pz2bwOlhbutJmKObiZyV0z6YKIqmEFDCFhXxCC0ecMFKmVPk?=
 =?us-ascii?Q?jMGjMZQeVEFRpHMyl7zduaUYlsrxHvkpDljSmK7eto/l5RP6kb2mGUD4/v1I?=
 =?us-ascii?Q?WRdPEBPFAi3oHYW5CuygnpFx6WtsVfm/RenW6bTg+1G8hMBJ3HfMDL7orVr6?=
 =?us-ascii?Q?ikYN0Ur4pZkK+19fFgP0//1cJSd8uBW83uhcZ9ciRoA4gO8L5EqJJ3QtS5jp?=
 =?us-ascii?Q?IIeFsqgBlkSabsuhM9ECWtkVrCEyhg09nOcnokloMJdA/aD+uqmRnigxD22p?=
 =?us-ascii?Q?9FTuLb7Ezr3An2xJHgekj0pBQVr/SlBztwtE4CnoIy6RiaTTTjbpOZuChBxe?=
 =?us-ascii?Q?LKozWNhu/yKeaVZj5sBzREuKdihMYoSafmsHJ4fXvD72wLgAwAj0yQ54vZxv?=
 =?us-ascii?Q?yoHJdyIa3QcwUg66U3cR7o3PwMQOyfJYJRxLJHCvhCNCQvm+BzEzbkV6swPQ?=
 =?us-ascii?Q?+A3RP4X0GUkmbKNQqcr8RQtfqUtm1Yo7moIt/mjLr7PIICpQv38ZlNwr1jsi?=
 =?us-ascii?Q?s3ITW9EstZol/ELMUUALLhCZjKUVa0fxkDA4z+5MD1e2hwuFlzA3SSkc+BIP?=
 =?us-ascii?Q?e2/SxMOAMqY2rXOLa15tcnuyL03EIRMKho3un1IpJsHr08hExwCIdY9vucZV?=
 =?us-ascii?Q?zIobZXLBW1r47MRfBpnKT/hbqGOkpkNqf3L5NQoRN4JvTA791/3n/iShOLd6?=
 =?us-ascii?Q?34ExObM7WqZtkhVhv/QFpont8Y4xLvDaElm6JvOhi2YygcgFoYrtwSHqslLN?=
 =?us-ascii?Q?+2rjlrut62Z3dD5zBTdbIGWMeuN4VKnDk9jl57cUMce1DIXB5wcnJFJ5t1O/?=
 =?us-ascii?Q?mpkbqAqLWhuMI30DcOzrpriErF21bgLWEw6oAtcZ/LBerzJ8fu0YZrfYQi4k?=
 =?us-ascii?Q?iR8YtooiN252rcs72VyddXg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lwnuWpAkwWw5M55O5sF2susePPYRQHHLkB/ENN95yw3kAr4yIzv3vTnLfmTd?=
 =?us-ascii?Q?JyuSCYLF+ylovU/IGTQbk8eZwuZNaGIlL1DQwU8dsEqviPDjCTlxS6nkwwyy?=
 =?us-ascii?Q?GbW7vaTB9EJCR4AsrdH86b6Vm5PlI0C7+4EbDLgj2UJP47svBT7bWuppfYx2?=
 =?us-ascii?Q?urqbikiCvNw5yjqGFHudVRQ22/3oBK2kLmeM2FpLdImDMoJuOVZZPp1Tylp7?=
 =?us-ascii?Q?D947S1WKl2kDb2fPEIqTVVNPYuRJsGkJ/6/DUdcjHL2T5UdBPo1wOQeD58YX?=
 =?us-ascii?Q?+NngaZ8lzgxc8DZYi8aTntVdf9BOFmoc6Thi6D73kmxfFiFkJu+OW8zP3GmB?=
 =?us-ascii?Q?szehIKg/I0TLqmtRIoFSYk1LdqZ2+Z5ITz4L7Kr/P6qJzdzk8Zu8V0JbrEaS?=
 =?us-ascii?Q?TAq0MmAU5nJg+KH7J/kiVfoQvys9/P5TXRzw1Dpy9ioRKOsGNeDWk/pB9vMm?=
 =?us-ascii?Q?88SQIitGqfljNtSo7v9IBzFBJMoAjBOXCUIxR+8Ss67r9guVHlW7+/8/HgVC?=
 =?us-ascii?Q?y94lP3ugXhFNuS95YxWitdF3zvl2Px6RX+5y9+kF7Wxgvv/v/Et/lK6MLBNb?=
 =?us-ascii?Q?vfjztZiy1equaschJ+6a0ow1Ih86neUTXJB/dyYJnl2VHuz+QzR1HEYVgQZT?=
 =?us-ascii?Q?K9fBkl7FoOfXrWD2zH8998D+K+sxsre6XNqx6oKgF0BUGigBr+j7MYb4ZveQ?=
 =?us-ascii?Q?NS+oEInTVRdAjB+wq1kAPfGtUl6WicRXEYGcTvV1FIMsiRuCSbrW1+cqMx6j?=
 =?us-ascii?Q?Eca50qKKKgZMQ0+jP8UaXK2Bx4Sh0VTu8zSJAzhxQYjDbrdsDTQMw+v0nw4x?=
 =?us-ascii?Q?ypQ0c9qQFo3M1VPiGDrhVG8XCmm4T4SlFpLpFgLyzYFPly/NliBb37kSIzNZ?=
 =?us-ascii?Q?whY1PRZRZh7uIY0dkOx62qfxUogrIuAPr9UVb9+3eGJqFs8MWgAXKNFtwtF2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26058562-56be-489e-dc71-08db16792b30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:09:47.5783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5u+sxTsxx21D0BgYsLOMxRoSVWcLVywDhas9RRMRvsDFsGZzBH7nFcEt8Euh3hOMTjVHZGkFAxHFBojpyaoGfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240118
X-Proofpoint-ORIG-GUID: sBGLH6LhjSd5qxP9DDnlDTs5w4gvpOAw
X-Proofpoint-GUID: sBGLH6LhjSd5qxP9DDnlDTs5w4gvpOAw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
---
 drivers/mtd/parsers/bcm63xxpart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/parsers/bcm63xxpart.c b/drivers/mtd/parsers/bcm63xxpart.c
index b15bdadaedb5..6e7b1ae8f58f 100644
--- a/drivers/mtd/parsers/bcm63xxpart.c
+++ b/drivers/mtd/parsers/bcm63xxpart.c
@@ -164,7 +164,6 @@ static struct mtd_part_parser bcm63xx_cfe_parser = {
 };
 module_mtd_part_parser(bcm63xx_cfe_parser);
 
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Daniel Dickinson <openwrt@cshore.neomailbox.net>");
 MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
 MODULE_AUTHOR("Mike Albon <malbon@openwrt.org>");
-- 
2.39.1.268.g9de2f9a303

