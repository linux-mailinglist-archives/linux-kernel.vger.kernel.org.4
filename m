Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C84B6BDF58
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCQDLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjCQDKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:10:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C84B6D14;
        Thu, 16 Mar 2023 20:09:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H26PA5017660;
        Fri, 17 Mar 2023 03:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=sgzLx7jLpigManQwntP4iPhu/PCsqy2Z8sMop9gAVZY=;
 b=cKnQWZ0c3ulHkCBse3RfhKpFPFi8wLfNOy5v00QfqmLMDTECMVbqGEv5CilYdo72poPL
 WvrFlPGgBasRgCiekWqUYSzOwXFkJ4jjGhTNFwNZCOtHdqcAYvTXSJcwFDy+ZAOdKZa1
 z1+Z8S9aYr+EKJKHgGAZAclj1yQHtQfsnaZk1fzO+OxBblrHksGJIk9CFM/WW2t/g7Ma
 lA1duVGNOkVO/JE9eyE4YdR5mo+SAMJIo0nIX9wWOdaAqfZNoxIHUr7xi9rcH/PCn+U+
 n84MNxsSrHNi5Gb8EvZft7XYCF4WuhYlpYAMgTaa1vpioi0iFdLFjyTYvHcRpl0v55js RA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2atqte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:08:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32H0fgbf020457;
        Fri, 17 Mar 2023 03:08:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq476r55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:08:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaL+9TCQwpj/zk2tlLma5133cNVMfscnToMY5nQ9FH+h049gGByUmQAKHxqjHg0YmZeXYdYEaKEQks0GmK8+cXzss5TOQIPnt7avhdchYquhTYrYpc+2Wc4Ylv8T3TLL7xfLygM2SDJ/n177oLczSrCHLAgPeYfhOtm8tY6qKH/UQdUMTkj6OZd9CU8bIhNb/hstQhJwIPNk515F42j8pCr1Yc7kUOYDetOeL7+mEQj7UrBkSjNJGKWarhG8FrBnRozOG0M+bwknpazMA51Xyy7wJBhgwfBFf4KbwUo7zQkG3vm2YwzCzCan54u3Ln2hSEM6TUDWI4mDG9cd8mEw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgzLx7jLpigManQwntP4iPhu/PCsqy2Z8sMop9gAVZY=;
 b=Y1xW51uKsUAZWzYF4+12Plaa30G3x+042W+VwODBOH6VhF1VPLsnfAeeE/jd0dHuV93rOSZO9MNp0Jbu1KF3KNkxYB1JJ5OO17XhypiaGZ/kG/Kk+fpckDaOxoBS25IzNHIyeqDgOh3xWg9VbWCKLJAPF9Pka+Zr6MW5xH5GEVxISkiYRb4HtfNrIjoWZ9GnP7TGUXtj+uc/HupXssl9pTt9zg23zXTf/fgh608SkMvvbTI6eCw8LOj2qpZW/8kqMH4vduExqW7XTKmKrLPi1QYmTXCnJmgmZFumWAT/tEFuY9Huwqp8WohMxXldDEeEtCSk/FmF9EbdYBmlnrs/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgzLx7jLpigManQwntP4iPhu/PCsqy2Z8sMop9gAVZY=;
 b=KqQkwY4P6N3rZ1+6fwRxNAu9Lmz8pTAtJmQR5XJ66GviS6t4v1TKoLa/akY3SIIaWlPuEjRvEeMioGgxmX1zLox0OVqZzN4qj6p57oVMbuWlxBB4rgjjXccNKaqa4GHBV5Le6dj9dgtEscY7Z5kQ0/qW9SKuakQO7Wmx/ZYCNVA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7119.namprd10.prod.outlook.com (2603:10b6:610:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Fri, 17 Mar
 2023 03:08:36 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.031; Fri, 17 Mar 2023
 03:08:36 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v1 1/1] scsi: fnic: Switch to use %ptTs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a60cyt03.fsf@ca-mkp.ca.oracle.com>
References: <20230314145813.66112-1-andriy.shevchenko@linux.intel.com>
Date:   Thu, 16 Mar 2023 23:08:33 -0400
In-Reply-To: <20230314145813.66112-1-andriy.shevchenko@linux.intel.com> (Andy
        Shevchenko's message of "Tue, 14 Mar 2023 16:58:13 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0035.prod.exchangelabs.com (2603:10b6:805:b6::48)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b2fcd2-19be-4f69-0769-08db2694e5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZGFTFeDGwkYkU4z3UNNB0Ljm5tJC9Kn7pj+kWv7BuU36jf3AHFXh8z8LIEhWJnx5V8qjzLu65h872vQwQasVMhQPTaxeK2Ci/E+V72OSKOnVxNl4H7qEhfqn3BgFu5xnbsGZ67xEnPh3duZPTKiDZa4EUVUCshNZYfbdfUG1sKPuzyt7w19jg0OSsZNLy3+/SFiqiNsafkVAFXv7e+OPjXO9PmBsvG9hvcDiumB1tBuej6KzzKUeYyYmyiKmTA7FB7GJlLbVfLFLnONi5L481Ti7UidC9waoOQHh5ncz9Idu4iRk6/NcwqNHI5qBQgyZf0swo7sNX19/a9zY7fPtD0AExlK67egqFpCKCfv6oLhzJkS+6rD4YKs5086ruXDL7/7XqgzqUMtW7eBiGTyLCCE+N3euqR9C8g5XB7u5WG8yJWMsv3YhUddOqFM+oNssLwZnr+bK0zm7QnHVrI0/x71q7T0NZrYBjowjG5zapn822yRTTXnW7pSLK3D7UpDemoPRBm8Glh0h2tp617Kw8C3yfWnSQ6G5WYgz9LuqdtMq3GJ248mVJs5n1NvqIz1PNsX3BlQxWFn1jZD/UgdxrReSojQKTrt5G9IZ6HSSMlds4N2o71avTgNQtoOttIkU9M/3Qzrnh5SiJ0fMAXX8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199018)(8936002)(54906003)(41300700001)(478600001)(6916009)(66556008)(4326008)(66946007)(66476007)(8676002)(86362001)(558084003)(38100700002)(26005)(6506007)(36916002)(6512007)(6666004)(6486002)(107886003)(186003)(5660300002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?My9l6bUP/3/HOhxloe5TMXpz+VWbY5BbBZV3itMsbEcqv8ypSJQxUgqeXIN5?=
 =?us-ascii?Q?BEKtO4QQKri0rivGTo619wcbSTmrNQL5R2NSk9f+A5uw/Mxb8otZDtgr9Ya2?=
 =?us-ascii?Q?rmzzuKzXMJrPuxnhrQLZ1QIis/50Kib+4CZoBShd3KO0GB61YwuGqNCoFRJN?=
 =?us-ascii?Q?i75CeplOyiupOcjCHujLl6x8yFApXDWwE1DqRBGGMt6COi2baj1NUqtNZXq5?=
 =?us-ascii?Q?SZYzPQI4tUaq8yaOixn4673r6tdDWJihsYNK6353rpeD/e/O1IYoSWi8KWU7?=
 =?us-ascii?Q?oweoW+9MufeRbrtaQFHZA2vZNlA/CSt/mRusdGoRXL6o3d7djb7TtAJowbjQ?=
 =?us-ascii?Q?49MKrZAPsv7Dk6AYzep9RLKCRnw9yRRVgJ8I2AgFrKeyTFnITWyOELAMAxdQ?=
 =?us-ascii?Q?pQt5T4iSbfIpXn7Rl5dwU02HyRXA9vT4Qh3171SQrh9FVU6fhy7i/Ur0dz4i?=
 =?us-ascii?Q?wINdiaKhey48N+qQbOAJw2o5+8Zr4oMf3ySRLcZmBOlB+zwZ/hCN+SI5hUie?=
 =?us-ascii?Q?srcEglGyLjrNhsOjJGQbs42z4JNzQU8IPLmOh9LLfdNGvBAk96G3IvYeOGuX?=
 =?us-ascii?Q?aq5HKoLLi2YoY0l3SeEAmGINQAkDfXeHS1c5TDLEBnmsQBnDgSJEJPLCTSW2?=
 =?us-ascii?Q?T64FtBlUyBdKJVUTKgAhZ9OaxnXi2+sdeWZcIKXhrU6wKhBlHmU0q5/qVG8x?=
 =?us-ascii?Q?/dP1cWgFHXf8U6EvIqUCoPKLJFDuvj7VpN1EgqvK0GNDxkL7kGJRiAAaZp4K?=
 =?us-ascii?Q?QhOTNgqqZXSk+r2wzbJcA0bxAUAzdUUtD8CkWBlX5Ox9xLdQE8KKUVtX6tT3?=
 =?us-ascii?Q?L6AsLhKhz+Q/mgdQMXr+CiycXvCXZm92qteEzqs3KLcxS9H+bU5ATk5NCd2Q?=
 =?us-ascii?Q?wVCm0mbzXk4ofVnWYZFU8mZNWTzPvM7bQDEs6RUwtx0siTa8DfaGFJ7t7h0B?=
 =?us-ascii?Q?wYYF74dqnqoFbAPvh0BpMd8qT0IV48isL/orvHQhaWMaWR6thOYDKnYiDPNx?=
 =?us-ascii?Q?POKQ9HoJXetUwSSntPyzwMFFjRmZwPGjM5ttAL5d1WmTQdwMAX/h+ytdyw7F?=
 =?us-ascii?Q?F+5MJb+Pjza7rgOg+TMrRkxAgo1uD9Q3zMl6XIoSjnrqH4NRYxJjUNnwCua5?=
 =?us-ascii?Q?752IKvigaM/m1lB1YwC317OKoBYnSx2dk5kCdIsZv9GiYTR8d6mL7pa69A0q?=
 =?us-ascii?Q?rTjO0JyNHCmytfUOSuB9Yyy5dqinuQxop1jf1jrTg+8z5v8KpkbxS8ggMyPM?=
 =?us-ascii?Q?NMZFyzysL6stLNt9d+4dNnqdFgU1vA0nXugf2BNg3iRXyycfs8CWaGaLXy2M?=
 =?us-ascii?Q?Sx/3stbVdbGSuYtKMWC2l5OR/OdfAa6z716L/CDlTK9DZyPoHpNF2HP32TVX?=
 =?us-ascii?Q?C55zk+uGeyQhrKWu1eGxLUYZBmNeMWaM5Ct3Gx9d//ATT+60KgPJAPLP9YWZ?=
 =?us-ascii?Q?stVGaumgw7U2vwBMxEVhZJ5hR+2k53Tx9uRPd5aXFJfneJxHblwbGLmnDMpP?=
 =?us-ascii?Q?UoGzX/Ojf5KPcMtm5JZ4Lj19WeP4Ga0S3fdhCRxWwhBYDa1YDYRt0oDpt3Lm?=
 =?us-ascii?Q?JW7WqkD1pSppBehdT/thQKo+LpQ1tSGrI1kzCmB3ouHpTnfHnJpVOKydwKtM?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u0Eg0KA8LSLaPJXk4d/g+BJgOsN6NUyyiY6Bdk8jtAbgMINt8MeQsDCtv8aTgfXQs4IF3rBE6ChGpbXCnTWUaQaukjuhzBvGpFhkOCWJgibbGAmctabIuBtrjviIaTWUu3Ep83NA2bV3geiC0RqL2FxDFjpdy4TsJkgNqLOakzhKojk1D7hQEooFDsuBVsaz62RqBrKn5K8skQQho5Yw8eX9jCZoXYViabymwEp646xdPMulPVG4elI27seI8m0W6ZMrQyRbDzzP5dDQFllXqbaSjJmMCBu2ZijG5Jj1TlhVthWO7ApDxaZWgIpaxt4+W4X5gn+NPFM8mn8ouLlj/B0fX0clVOSLi7wrSum7LsK5idEA7ecTQQmOhA6GL/RPZEk8CuTvQtx25wu/vGKgABg8TxlYN5vRm6XAJHPf4DzUgpHpK9Z0N/G+CpZ2zyrDiGzpcQAfo4gAJiVcqu3tGx/SbOlRldWkKNPoOzOGpbudqq8tBc2Y55l9DzDqI25YPlpmih+1GWcUzEqEnzsJ9dG2z1nx9ae6OLSTwn+TWqTqoK90Rkggfc17cXhX/QaBTLIcBIhp/lDsK6mlW0girHovJl1s+nCSpOgiAs5PgENMtxnH+KhjbU+cEngOB+tD/zHxeVtnO2SvbbqI/6v71/rMmi8YKoR1zVlKFfwVhWishPTkkipsy9ux6Y9HwoAEgJHtrrDzC0zwMz2ff0JBBG8+u0Wl2Uok04ykRGm6dgzRG1BlyhH1FZ6LsFLm+frK9GGQkcM+o2xieg19Ue2CQE7V61Ev8NInrKQN24UTL7am8Wg8crqnxwGXJVnDAr2AHa1U9lQpYNA328fnxLykFgncC8Yt5zR3i0oDyeaRGjGzl+dPHClNgbYLEXS8m6eF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b2fcd2-19be-4f69-0769-08db2694e5f6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 03:08:36.2864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fvi+/S0zZTlr0SILXEegypdNppnHtE1f04uD5RiA8SXgcJS0LOFJuvLokINw2LlPNOyIzcX40TCX7UAJHkxRnQcwHjLXLb0O59q12fUp4Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_16,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=666 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170017
X-Proofpoint-ORIG-GUID: VEmo9yoI0L9b2P1G6G1KHdanawE1VSb7
X-Proofpoint-GUID: VEmo9yoI0L9b2P1G6G1KHdanawE1VSb7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy,

> Use %ptTs instead of open-coded variant to print contents
> of time64_t type in human readable form.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
