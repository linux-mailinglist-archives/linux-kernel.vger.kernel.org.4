Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB56B124F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCHTpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCHTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:44:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B1BC082F;
        Wed,  8 Mar 2023 11:44:03 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HiW8T009740;
        Wed, 8 Mar 2023 19:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=mrXBm3GVEnqiRTGM/QkD5o2F3ZHIRAWiGoWsavUqzfg=;
 b=YJrd7yvWsxlCRxDTJxe93HbhuGae6zuw4c2ZGmXqDpwwYuzML7E9MZpBANC9DBjhMfPK
 oSXKVlUF3HuX5RFdyqB4Sim4mPyVTCit4B4yp3+7gOp6FuKPMrHoOLTE47pH2fMZPoce
 2z+BJtN52Fs6bac6g8jXskojzrS5kgjm4myqH7qJV4BCWuZajUGmN/Hzkh3ml6ZY1WaX
 zx3k+N991PjW5tsDeLB00lcIQNR//z8EdRWiyCdmaJhK8+uuDt8X5Ub1+BNhabur1ixr
 PEtVEocJKz4I3tQM3zRYrmCvpzse0G2AYE/6FsEmo3aVtFrNP0jjLly0RpejZTUsgURB nQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn95cdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328IAFZh022310;
        Wed, 8 Mar 2023 19:43:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fr980s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1c2oQPmalSp1I+tyN8JsxgTWkEuivEBm/THW41SqGp8s8sJp0Pu7cy2bHDwyG4HNdGWWG2qAmax84EwunIe7N1ftsh4Yc0+lqd4uuHSNvVWFZdX48yfYgomeQkjEqT1CUTtP5qT9q/ytuu+DxtRU/1mnShNWkxKdzil9T47ngseAvHVnIHTL0PtVEI6xxZglTytR+rT5YkNHOiOM0wSvbjCZkzUhxXuD8bJ0+D9Z+dkRXU4zbVWpbtomHeTSyHH6s3QMCii67zXHGH79ovzmMLuzgyhYysI+Wj+dejVN/908S2S7atASwH3Y1o3aXmYVSz+znPjFRzpXOahVQ4lRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrXBm3GVEnqiRTGM/QkD5o2F3ZHIRAWiGoWsavUqzfg=;
 b=CbQA17wEBq+Mh3Vr6J7ie2HarYHo727Ux3YW6ErY89lwDlfiUaieXP79h8sMcOOBD20UVeisTU+Z2YORzSSWSB6+S6oVuGg+Ly4p6RSXGDt3L9/KPQAxXFcx8LSE7+4uDplaS8KfS9DvfD5LRycyuQ18qli+XULgu27WTPrOtVsq+NLtQrLhT7/Mxv/gR+gOSQ8J+PA4sncVerSN/MPiY23FV5/7Hp3i4Ixsznf8DaOT4GSI/JoGTZQrCkwRwHaCfVpQukcnrKJGYGmskdaPU1c0WnuY+UrvMerqWekR2ZQ9F57CyYin6WHCppotfR4UvAo0+fjnAgmGv5lD8mFOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrXBm3GVEnqiRTGM/QkD5o2F3ZHIRAWiGoWsavUqzfg=;
 b=Fzl7oxtamCznqUMZj1LODADdxSvXAMsUoELm/h5eOHf8dpo/2wYA2yvv18OXNfLyKSbw0bMqjSioB8PiZox8zvH1LHyUOv59P9PzcOP34CfTIaMfHd3nEJgbqoKlqvATmw5+HAz6dl2VClOHoE0La7e0aUi42cgDiNxDUL1IX+c=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 19:43:56 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:43:56 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/18] mfd: da9055: do not cite as modular
Date:   Wed,  8 Mar 2023 19:42:59 +0000
Message-Id: <20230308194307.374789-10-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0134.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::26) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f450b30-5fbf-4a26-eef4-08db200d7487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVo7Fibp/u7WlC9wXR3d+R4TYP+cC8ABGrZP6TGtdi+MbdzJbWy0gjhRlmXq3i25u1uMoAZUObjHIuyDPVv/43i34E4vh7liJWtvSUwRuihLubERHHw2b9JAZXQSs6XkFhqUtoJJol1na99BSQkj1hnnDYU00IY4oLMhktHVKwrSUjZcOGbPP/g+eNwHT5gspz/jugcIX3pA2wmw/eUvQyORr9vfZfiPg0faLJ52qpGyEMub5F0LY+szjmtT823ml0t2fp4KcYd1Gi8mdTcclXQUg5LrD7IbYS+bgfZc8bfe2tDoMBGj310yCOuU0nm5kI13VBsAPz3sX+Sxefkn+g5WdKAjxiFz4luIy7JFXrBaKJFISxt5ALocWZdzlZCA29hPk+rPYgE7wdnHaRtnngEq9v9sZr7GlQqmcmHJvd932nnToiNfzqTJtQvNvod2zKHRvGyNiZ+90/v1TYWkea336FxQ1e0ghhoPabjcdG334gsTmXe1w2lqf37AdKu1p4lEuUPqkU7aV64WcojY6ZDNB/ChMYyotT/6dQFcaF9McriUseGnjoEv1ruwRU4ee9C7+d0RR4zX1qveN2zvhjQigY9ua0qNJhsYTkYivRxHqu5aN68K1s2kd4duzyvE/5IWTZgwzVbEmS5dGgocRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(44832011)(8936002)(6486002)(83380400001)(4744005)(5660300002)(186003)(478600001)(1076003)(36756003)(6506007)(6512007)(316002)(2616005)(86362001)(41300700001)(38100700002)(66556008)(8676002)(66946007)(66476007)(6916009)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gO1Xf35tVbc2j9u3oMwTCteJoEsxJexCWRalwV7B9uttvQsxRFh7PmJ5xIN7?=
 =?us-ascii?Q?r5KnNtlquITbySgq1c2Tzlh+WhqGUaHzM1lx17UgniqHJXV4sU1H0EvwrAEJ?=
 =?us-ascii?Q?aIWfntGew+nUGqg5EMiiNy1zPaA8ulJHkDDCsUoQcZIZXU8wz653QtVOhggi?=
 =?us-ascii?Q?XqCcXjfqvVykfKA+nqiLHDBfD1z13e4GPvnPRgDFxIQuJN8CA/i4zkPEN8BM?=
 =?us-ascii?Q?UhQGxkk4JLzLsFfcUckMkDSD2zs5WcPSKrTDc7pCbK/LQWb1f6EferdY29tK?=
 =?us-ascii?Q?ec2D3CJnG7hyAgDqHJvRsSdD3akjyP4S9VYSthhfBfUADKU/IW021Z9yBk13?=
 =?us-ascii?Q?4ojo7aEqILeukhT4Jd893g5l7mc7G0Ln1M21NhmgMp0fyqxGdkuPVJfGJWll?=
 =?us-ascii?Q?Jk/x2rVKSCQM/dTalMg1jMq1Zm1ZlROzmCGJy7zLTLseA0N2uQnHeDeX/JYJ?=
 =?us-ascii?Q?WJo6VW6mnvlVbztmwuX0kfNSnEgSkUCqhitbdkOwx+hV4dCYUJa3QwnNhKqa?=
 =?us-ascii?Q?L5OXFn/EiA0916Ks12ARqC3FCTLUmW5V5LWeLseCJ+ja5SShSTKu0Bc2Z+hh?=
 =?us-ascii?Q?tE1nVrxRblTxUh+Z0EGoloeVba0MnrufFc85NY6gcWrbEpc0BDkt7ghXAjmR?=
 =?us-ascii?Q?uXP+9s0H7Ft8aOproLpVp4OV359lBwWu0Muc4K4h8x4ynWM399Z5xkP+ZIOO?=
 =?us-ascii?Q?4biTEY6mLkUVqy1gpUlEGjH52BGMNzkoNvXsb9KVZJV/nRcqQJYEQI6NyHoJ?=
 =?us-ascii?Q?Y3VNQ6138821gveqg6r7S7chiHITMuop8PifqzhEyca6Q1lrJuy04QF37tLJ?=
 =?us-ascii?Q?RNuhMdVWQNAo/3uXtjU/Eq5X46zdfukzzEFpnB8Vc9ssRjVDi6vqJDFNaaGv?=
 =?us-ascii?Q?UHex8e728D9UZx1C7ba4O2EYwS6tauLo2PK0F1DM2SD4n36EVnHKR3V9SDqZ?=
 =?us-ascii?Q?qAteCSGRyQpzc5ocw+138ftGPpPehSrEJLzIffVB0fXiuxSC5nof7C4zeEfW?=
 =?us-ascii?Q?bSYfOYjyIs6K052RiN+C37qhR+nJgW+li9qfyxMuXA8DCJN9eFlflAxZf8cr?=
 =?us-ascii?Q?HYRXyNTiS8z23ZcRlAGV0QqBswZuZ/UTF2oXBiA+73Nusk5TRi1+1kAxn+t6?=
 =?us-ascii?Q?vAgm8RuynJoc6ByhqR8Y0R6IJ1anLcVsTEzF+9XwipKoQevw6WrBQX9knugY?=
 =?us-ascii?Q?TjGeoPS/d+/L6s/BmHNf2TuhGD3elkWV+7EH1hiMXr503rO/Rbmz3VqaKuQI?=
 =?us-ascii?Q?r4z8Z8lsabnDUpmZ6IwHGMd87nvUPVLY71iwJdQlrzMKVtLbjAmDHrIG6xzc?=
 =?us-ascii?Q?oUiCkaDGkm8qJTPTgEgUcvlHcjWVS6RLk73IbhTeUkP7b7nfmNhOMkuSmEYE?=
 =?us-ascii?Q?sFnZcm4sslIQrdL/skUGFZ2XvjgOXqfJ643WYdi+mxA3/az6w02ZvZ/j/w40?=
 =?us-ascii?Q?O5FKxMta2QMwQGpUsOBKYDJbXgEBOVPWjd8MkJcbxPjObi25GC16x+pxamjQ?=
 =?us-ascii?Q?MiR6M7wQvSpAhP9+3BF/6dUncSikA4iZv80IxM2AQ33yRmh1WC80C3HSjKAl?=
 =?us-ascii?Q?9q3gv/WGXVMDpgJL4f1p3sLt72hgtJSzuwbdORQTxeCjx1+gZkDu5cF3+Grm?=
 =?us-ascii?Q?uSOR1BDqxcX3xZzItXsQDhM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4TQTYkyI4pXY0MQL+e6gFN5QlE8M+FsL1VgMDErny7BtwS3xAE1R9UOKKneq3JM2PcVaFAGCKfYky4dw1ovZHCNZIP8D9Pwr8tP6N+Y+jH/bteT/Sa+ytYLm/Lkepba0f3rOk9cvQYWq09R7+RRcxNOJhN3u8xV7WOl9lClOa1bYNvaazVSCtVhqszsj+LDeyl2uDkrag68p8Ylov/H4mhAQV/hWVSTK0iBKs2/m0m0Wi54pynsUsaF13PtC1BjQgewGBLRYHhJTjLRN9zi9zG+WFVyP2ahCpRAzmInWIG/FLv/2I9n8t6b4QUg8xj5INuZxgEf+mVft17aj0ZWPdifATgDXXkSzJz2IzU/3/6Ndo8qr0yJxOxDsFx709r3T9Ft4VEgSOTzPSWLbE7VKbjowT3MetoJ67fHfEBQ8WgXDKNKowE0sHOHkl/SdZcB6WZU3uHlDYXsx7vgmAYBVriKjxgTcUTFRog6pziOFJBBNT/JEEyD0CtRClMeyjDdQ2ysmNUQERwQQKkULaAabgiKUQvVx7YpVbq3tPuEnZ71M70mAtBZYtZGpQHcDb1xfR4DRsGm10eql6MPTnjU/QVy6YxCCJ6K1PA4NJy2BKRnV9cWkXefO20GlYFF0PADmNLynivpfPwxzPEYBb1Jbsi6nYu6VKB/PVEZABCa41BlJYhPAbBXUHBOlHa7tYWZVXHZf6PkIoE7yOBwp7dPttJone3anEqazgd2EFpGlLtavxIdZN59zkmpZhXcUwyIRAFjUdd5TWjo5iSmONs1qgWIueY1fbClBMsngBOv9zqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f450b30-5fbf-4a26-eef4-08db200d7487
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:43:56.5567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVyPuLTZLzk6R2H1Uxt1nXD554MPDwpJqhnUpF7ybq3S6uj6jg4EORnnOFIhp0aIY+/dZA8oJzS5ogIZ0lVXMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: J3nbz95aaXEqPRD6RR2GP65cDpXI4ehU
X-Proofpoint-ORIG-GUID: J3nbz95aaXEqPRD6RR2GP65cDpXI4ehU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver cannot be built as a module, so don't suggest otherwise
in Kconfig help.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Lee Jones <lee@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index fcc141e067b9b..6d32348bdb809 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -353,9 +353,6 @@ config MFD_DA9055
 	  Additional drivers must be enabled in order to use the functionality
 	  of the device.
 
-	  This driver can be built as a module. If built as a module it will be
-	  called "da9055"
-
 config MFD_DA9062
 	tristate "Dialog Semiconductor DA9062/61 PMIC Support"
 	select MFD_CORE
-- 
2.39.1.268.g9de2f9a303

