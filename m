Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EFD5EBCDE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiI0IMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiI0ILF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:11:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDFA855AD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:05:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R6Nw28027238;
        Tue, 27 Sep 2022 08:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=ZGj4lJZaTGRKUQrenH0kzlnp+4nluJQ/aGg8LEQUp0Q=;
 b=AyNnTV73iNJHdfimfzbyQMU+h9YvJ06Sl0hICvyMw8kP5H26/8ReRe9YPAPmBNiqx+lS
 c2w2KyiOi1c1en8qLMQ3n54F8jaPTw+R7GS2upYiJ/8ARedB+A8/hbKmqE/+UL99+EZx
 8ePWV4HI553w68ZRYdu/6ljMpJFK+rUlyR6mmWsQL26l3srupWi0TewfFrTGBqbsQjut
 pJ1BEO2KO3qIandjJUoDHSrcEgqoPzfIsNI5n5yJQ0qwftgPyRRopdCfSizB8P83NYNQ
 OYg76zTX9VFwgY4yPnoXfuTpSnBqcNutHOdTC/dOTNal1jdkMDXf8OTrmgvurEMMwvKu 8g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrwduxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 08:05:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28R7p7wC028222;
        Tue, 27 Sep 2022 08:05:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtps50q7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 08:05:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg6ZrBaBDzfMEaqHbHUMzuHgocwKthQ7drzUgNEfo4lyTu0uY3W/Fpj6V2QncpG+CYSPq/3U3QfnNehNzBvSSOygzLTrRl1sVaPqj9myRF8UmRCqb10neY9jswYucRYvdRp2gq+6mkym5V5i3OjLLp9IKrU8rfM2hmBcpJcWbeU34p4Ssf3T3r5zfLz8taWW4MyubIlWtuzRD/KMN+JU3Z/U+p9Js9FVePFg06TOo9mmERvaXix5/zsWvvfmrqvRZvv3wRA+WZu7hnOjaDVivjaohJJzFbEBtrguEE4E/o0IvaYvMVnY4yqDfD+xP4pz777hUUvexfLu2mc0En6nNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGj4lJZaTGRKUQrenH0kzlnp+4nluJQ/aGg8LEQUp0Q=;
 b=oLqTbQGXhh8XYBw9OAnlIe2j/F948bhKp1ocwv+D/0GpBVuBwhl5u22I2tYwAokmLXMggrNDO+7TRLgqRUkEJldBZmnNlQALnWhCtGdcz8LW4WzY+2Lw7ozsm/wlIcUhl7mipQL8po6hE6FxGUvqxKY9JStVJEnT+socfZNF/pKey5V/WWrpzGhA67fnMJuEGf9oe+nnhEzUNtSMUdC5aXldJxJHBqtNXxyghdxruRcH7ETBnCHKM2YRLAERUOCJHKmRIxLhBHO8b3oWtW0ec9MxyfiuzOElfRMJf4HJYUHMZya4Rna7hshGGZTUz9GHLVmmCW5AGhne/MP3Krvq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGj4lJZaTGRKUQrenH0kzlnp+4nluJQ/aGg8LEQUp0Q=;
 b=tCtqyvFGn5vDQ4cjSQyjPpjE8Ab3sKtRMaBzTkG0DSitBUTWBFvpVcBO7uO1hvCroswxAuaOx6XcsiV+zexuPFrF2SHX8g3TxM5Me3t/FOpo+Leksq+ED5cklkZa9v1G/MQEXUn8fMBeo8QhuL6rcvEMxyiaoGXDWutdKrh/wT8=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by DM6PR10MB4345.namprd10.prod.outlook.com
 (2603:10b6:5:21a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 08:05:42 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::25b8:540b:9e72:ca93]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::25b8:540b:9e72:ca93%3]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 08:05:42 +0000
Date:   Tue, 27 Sep 2022 11:05:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [char-misc:char-misc-testing 29/36] drivers/nvmem/lan9662-otpc.c:43
 lan9662_otp_wait_flag_clear() warn: signedness bug returning '(-110)'
Message-ID: <202209261902.qJDWZGUZ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: JNAP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::17)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2358:EE_|DM6PR10MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: 2489313f-17a1-4d5f-718d-08daa05f1252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0EFG+T+YccoVxThR8hqg0shTe87LXjtvOItpvPszfsmbbH7XtNpaukvMDh8xpkXWcwTFtqFtLAk2iYnQT9Q9yJLF1iyS6yJU7m+ZrA/6Vq0y6DZgv73Alx6IEjvR6WFf+JirmDvAnHOZa3RwJsWThaXRiODD+ycImqcsTg13K/a4bCYjen6hGBLsINPhRmxvLMX/LZhz2lSVpnmup5dEtcqd8QSrAPilCHLY7BJcKdcl8UAu043MCqaCXMt8xfVldL2VvPgZvvvxaI/Dqmulwf4hX47aRriTdxXkxclR02wV1+kgiSd2K5v684MaG4czNIiWn4sqk1lUx3yrmDz1k01uouf6W0l3GVw2Gs+cRFF7xZ76i/m8nxxjutvXUKaHgMuq2Jm+8XUNvXw7YSz0fWY8aeJeApW5dTRGH3z8/tO3/QbPPKqicrMhGrpFfDIxCG2IsHq5l/kqzaI7mp7Bx9CkPWFxGbyfgL0t545g6fSvEodGCb6W72riU3ZhndWVEPLnQh3KPtxXu71Xi7w1067q7RWr66iyWeWfePWUuzi8zc4zO+fIrzCLZKOhdVs4W8vtMPdFBn0XZ8lhwFKyoxW6CmZH4TzKBHv8mFmGrP/RsKBBKI4zhST1wQT+6S+6oj+ECw0j9bPKseoOJUEJogUtIaV160sCkMbLJYcmk7/un+9voQ27Ge+MSE8fswOQareBkUtUBCR5fvi6eMvvgIw4tqEvDCjCiS7KBuFAT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199015)(966005)(8676002)(38100700002)(66556008)(66946007)(66476007)(8936002)(83380400001)(6506007)(36756003)(6486002)(478600001)(44832011)(41300700001)(54906003)(316002)(6916009)(26005)(6512007)(86362001)(9686003)(5660300002)(186003)(1076003)(2906002)(6666004)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tHQS84MaRk4B3260ihNRNfsIsB/B6uKyqj1y4iOfzm3Nx1FopTUgWwG8A89o?=
 =?us-ascii?Q?7mzq+EtcmFQgfTUGi7wHVrfy1peXA9oLIOsXHaVdZ0Iz9pai1ZOY2GeZPvtn?=
 =?us-ascii?Q?Vw1Ve60guRSqOFLT/7UBp5DHhZdwwNbJqd98K5kPD3b7kP3kFZc9mQljTkPF?=
 =?us-ascii?Q?+1AKK2KWp16i3xVd2FoBZugGLV1aF2Qyjve18VRxz9lD3fIrFVDYHB8H4ADf?=
 =?us-ascii?Q?aMOd2tMdR5DIeq1VVyx1FwfeylBGyKa7yecVZ8oVtYJdGN9TWyriKH1YabDt?=
 =?us-ascii?Q?dT4UMm4xpnWhypgJKNjAloABM34KRDANYSV//JAy3snv6RNvBbSoPrhVlHyz?=
 =?us-ascii?Q?8WMfWGcamezDAQT0Fws7ivhuLfeTN6criFUHkXAVwRVSiZvq5ZKQeB79Tsw4?=
 =?us-ascii?Q?EBrcuHMvF9QmOYM4+Q9b6JvEJfJK92jfUMMgPoONeGpY35WyuQ8vQSu1hmeR?=
 =?us-ascii?Q?do0pR+GK1AM48jwrbRHcKxS2GUxSxTqJ6ThwZN3ccnhRM+I/1lyt2xvzrwdX?=
 =?us-ascii?Q?CiGqlxiPl+Y0r1t9JgiIjfPdSes7ondRfRxzfsIn62iN2NgrhJx3MhBNDGfJ?=
 =?us-ascii?Q?xnAWAmtrJGiE3ayy0UlTCEnfdj8XfSSbV2TDgz3KEEbiDVpWEuvWpZZhSfJj?=
 =?us-ascii?Q?ZNCTazb5xH6Qhy/BJsL8g4Bc7KsrusgZyXc7TLkMP5LFZBUAsHml5u9EUCeY?=
 =?us-ascii?Q?v2RXKCVAke1zj5njFxAKcbns6s0PpknJfuVJ9qPGBSCHy4Co0ggPnb1aFSLv?=
 =?us-ascii?Q?MlnIo9RGs0vomfHz8+T8L2fOoP01abDMyR7b4eTCL32j0ixoyLE3+KEed9je?=
 =?us-ascii?Q?tYkk6uPNhQ9GV6txHgwX7aW696DhqgD8gdv9kdswX0sKj3CxcFFX0FKH48o3?=
 =?us-ascii?Q?d8F9oga9S/P2BSsLsf4pPN+VNZVRUxyUHs9Obr94fK/J4IWwFwNEyTv/QrXj?=
 =?us-ascii?Q?mS/HMlwvYEQgHLrIvFa39ApvIsEeisgsiQB0ZC31MR8p4K1v+otjNCpzQ89A?=
 =?us-ascii?Q?EUbqIMHngriHd5wbrZ/m4HDPdJO99DZaqvun9rOrpwhfUWCmFB9VkCaOSmmW?=
 =?us-ascii?Q?lKd3jL/DTVYVuFGRWUHso8t0MKcvoTQBszasJ3Es2dfXvO3HKyu3SML1z0op?=
 =?us-ascii?Q?RuWDA1B5U9YQ3kIQ47rJsogxHbMw6J/lPuBaLcR7D4vC62OclaLMvxI/Cjkt?=
 =?us-ascii?Q?pTnCSgBQ0MQnbwjohEzXv1LhfgX1Qdf/Pf+StNpuqh+/pUlwAA8SBAtkBW+e?=
 =?us-ascii?Q?5qUVztA+AITrWXDSOZM9pMuAvJmrIZAGHfMRkjDxVE+Dk96X+T3M+RHUlSxZ?=
 =?us-ascii?Q?IbcL2KBNntgcJABKkUINGccKNRC7JYkMYjGgpGiJnO5rScCFXeWKS5lc0qVX?=
 =?us-ascii?Q?UmXVjbuagVpG7IUOljesug1gtZbWXEbU8Kf5ItPgqfsKaB4ES8QGb0T6mCyP?=
 =?us-ascii?Q?k860Cn1cqOC/kJwyJFQvZc6OakD41pKpx4j6vk9Ay8Oo9iy+ocr+kt4R7tpS?=
 =?us-ascii?Q?EuQBhXUvGJkzdFm5qHGvGeWUWwKJrdjFnxuHM5kO/6LHgVQFILcVpgu8cCVb?=
 =?us-ascii?Q?kmtF4HbZcrN7m9zdnMvQY8G6ip1gnrUXBYE+eiju?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2489313f-17a1-4d5f-718d-08daa05f1252
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 08:05:42.0138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWzhRqgvrAZHtec7GSdMlcnwIBkDoqXChx1+DDdMosGYwQuBaw9DnVmDTm/MDRHVQbc+zZ03DKADocJJJpUXHtz9SGFGmGzuW3x4FIdzuZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270047
X-Proofpoint-ORIG-GUID: HyMbdxjm5EV8vxNFQpEq_AEbiOxleMjH
X-Proofpoint-GUID: HyMbdxjm5EV8vxNFQpEq_AEbiOxleMjH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-testing
head:   0f65caa911019561d71ceb70f0d1c7a965b3045f
commit: 9e8f208ad5229ddda97cd4a83ecf89c735d99592 [29/36] nvmem: lan9662-otp: add support
config: openrisc-randconfig-m041-20220926
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/nvmem/lan9662-otpc.c:43 lan9662_otp_wait_flag_clear() warn: signedness bug returning '(-110)'

vim +43 drivers/nvmem/lan9662-otpc.c

9e8f208ad5229d Horatiu Vultur 2022-09-16  39  static bool lan9662_otp_wait_flag_clear(void __iomem *reg, u32 flag)
9e8f208ad5229d Horatiu Vultur 2022-09-16  40  {
9e8f208ad5229d Horatiu Vultur 2022-09-16  41  	u32 val;
9e8f208ad5229d Horatiu Vultur 2022-09-16  42  
9e8f208ad5229d Horatiu Vultur 2022-09-16 @43  	return readl_poll_timeout(reg, val, !(val & flag),
9e8f208ad5229d Horatiu Vultur 2022-09-16  44  				  OTP_SLEEP_US, OTP_TIMEOUT_US);


readl_poll_timeout() returns zero on success or a negative error code.
Better to make lan9662_otp_wait_flag_clear() return ints.  Returning
false/true (as opposed to true/false or zero/negative) for
success/failure is pants.

9e8f208ad5229d Horatiu Vultur 2022-09-16  45  }

