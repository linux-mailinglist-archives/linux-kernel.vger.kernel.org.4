Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF50705CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjEQCHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEQCHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:07:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F14F30F9;
        Tue, 16 May 2023 19:07:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJxwom020535;
        Wed, 17 May 2023 02:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=8lCZFzU60EallCnNVZ7daw5QAuW15JvvpYVq2OTb+Ug=;
 b=ZfiPCCUILeKuw5GUUCkfnfve/Kn7Utr8D02ETQzHWuX8UKFj8hXCve4A2Tbc+XGMxBDY
 eGk2J5o/59jVK2J+u8E+vWn2dCFa8cJpL+qMTUKtOwqfEMLbvDThE5ZISVqyjyXocB2h
 QPW4JZFsm+XtuMX+LlklkKPTGO4Xkon5x1rFUIXlXJyP9TwzfS0yvLUvRvQFs0YdmpdM
 40dpSvI7Hd0ggK5Uo0WYDW/emLsvV/3ewAU1QxM2742D5I4GOsxn3exdOOR6AL4/brxV
 qMBhN+zaAH5los8HgLJ9oSiO2m8p/9OE4LBo9T0+E+9SacRWCvFcXPCgoA9SdWCZvKvi vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1524p4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:06:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GNJgAO025017;
        Wed, 17 May 2023 02:06:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104trvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT0jf/+uSjrid6JOWwgYRfrtjSg7DPTJPtnw2CgVZCgnN5tCGcfvcJukl0VAgvWiJPKo3xeF1JDsft2AIs4YhdbTTyF5xWitPEQlBI5iYZyj8WsusF+EJDcP1BHaCwzm+hOIcNKII1kJXMlPbreNvLvfthDnblybKhxY8YLyFSm10oOhFUWGv0Zwcirgc62tJEfqr3edjpVVitOTqUwFr74TleAUVcmalx+0Yeq7d5INas9fR/W0PL//wVCL4PgNo0/vCAnsFKlqzRowgJfsEUUqhrhBPRvXZ3EAr3qYy9blDsfBbfC9gMhlcvnY2nW88oBGJ5Glo6GIIwSiv8D/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lCZFzU60EallCnNVZ7daw5QAuW15JvvpYVq2OTb+Ug=;
 b=Q03pcLL7RNx/ZrSf81aKMoIr34iNZLft0GggSXDbTNFUqqczGiv2axC6vFJ7+nvjpHBcvqjAtd688EOV2aXjPyO11rtqdzcR4e0e4HYhMSzxf/VOdZsc+eYAhyhXrd795RQ13Tih/U13WrXyijIpC6I8JiO2LGyW+wbBmxeMnkWNrFDY6oJTwqyFqsAV7aVQ7Szl9HIvLZYD5qiMo8MFQh+AK443I6ALRc5239WSH6QhZFaeTbQr4fbBR+6e1n+3hUsgPb6TsRfZVxNyR4IYyIOxfl7QfDrRj0wLDzHYSSP7tiYkqnQI8VH5ApUQ8dmcaTJBYVhHun2aremd1cC9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lCZFzU60EallCnNVZ7daw5QAuW15JvvpYVq2OTb+Ug=;
 b=bbv82rodKCbwP/wNXl1lOO3pk40/PTQf1JldknGTqVWTZnbGafMUWs45E67zC+3TS6GzCS6Ry8qQDM/eDdGN/AJl5ugel8y8M+vkWrmDEC2DTntJwLLwVd5iAzGIlK3Q/Pvh0tu7yUM5wOwp69qKBdhsHDs+FjBokknazMGxJx0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB6279.namprd10.prod.outlook.com (2603:10b6:8:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 02:06:37 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 02:06:37 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
References: <20230511123432.5793-1-jgross@suse.com>
Date:   Tue, 16 May 2023 22:06:23 -0400
In-Reply-To: <20230511123432.5793-1-jgross@suse.com> (Juergen Gross's message
        of "Thu, 11 May 2023 14:34:32 +0200")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0153.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 3735435f-b0fc-46c1-beeb-08db567b5873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61zoY9S/ugrKMjT+vat9zXOD/PZ2NPHo/KJlY3S3UDgweF++Wfnm629vjOCZAgPtVTFZbezRW+KkLlWHuRVShkc/olpID9xRBZ6rb6N0V+L2s7EFnxf+XpXnyPhIaCyenXy1PkSXgxoKIGDa1U7W+Uw6XZ+nyMgHU6iLcz9wsFYBC1xVrj5kPWTbtwz6pFRYfioUmqdxjxQOl4+5eYdRgwySl67UFApoNAZRPVyaXVHRVfOh/YGI3wmUKjG3ezAjUguni2jRsWKPaMxlWXjFGl0gZeG0q5JEHYLaFVz0qg6RBbzRP9ituxvURaz/Y25j5RUvaxx7elFqbI6D/XqfR9nS0uJjfnLmxt2qCqa13ScYH39E/eSZdMMflIdJbvpKm8KZX7ypCDHOGAKu3TNI/905PkMhSiXo+5z8j4u6pOTmgfy+12jaLYanfW1nXpoU24GCG8e5jwoTgJJvELWJBiwLbWtHdJnBXu69WTpfswFazJqoMlK08Ndofrv+U0yQytbei2cVWiYqm24n4WxfavwVZn0xOdEc2AyYZq45egS/sOjnCC1Ct+M0iR0iBWBl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(86362001)(54906003)(316002)(4326008)(66476007)(66556008)(36916002)(66946007)(6916009)(478600001)(2906002)(8936002)(6666004)(5660300002)(8676002)(4744005)(38100700002)(186003)(6512007)(6506007)(26005)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CPXxLOtNqygWc0rZR11ubbWLb11QmANoOUjAvsS6MEUKuafMVftbIBKbod0q?=
 =?us-ascii?Q?uwSQ4bxpGGwgz5HZbBUsPetjr6F4WDyuw9o5SkTwQWh+DIv884mdYu55mbrv?=
 =?us-ascii?Q?qfZx4P2DBaPaFLkhT37F6LedQx6ILFvaGQrOlQmiucRI4T5W6S/06SD+lMI7?=
 =?us-ascii?Q?OLBzYZ+9AA9aFt98ylm7YXku+kpkoiaCG3Ed28/LYz3oZUx/eMTCaceWfCf1?=
 =?us-ascii?Q?hRxtZf2C0pTK+Sfvba9iIRmq9n99bT0GOVg6kky2hFt51VQovzJnukclM6Db?=
 =?us-ascii?Q?GLcK1INz/4AVTO/7dE4TnHUW8xtN7ayUKgu/9DJ1IT6fLvtdKAy871zsvBuQ?=
 =?us-ascii?Q?I5kG3XP1/ouJwHRMSp/fQkzatda3WcSYVxRXL33oKHwl637tFwgEl3g4zMXx?=
 =?us-ascii?Q?5QUB0TYgzzfwse7fgNKcYDfbsn7VwjnVAa/KR2wjZCcbm8WkPmIvASRqjJ8S?=
 =?us-ascii?Q?gvx7tlPLRCWllbtwSWZEoSslFJZGzcTJ0VpHeZk3Hyc3hKne45NFKNhE1SAZ?=
 =?us-ascii?Q?sK0LvvzCxhe+LITy4Hx7J6mSEvAhuVJFgsUwXAwLzZzwvpQLpzBBgChuxhKd?=
 =?us-ascii?Q?+vdqf9MgyWWmmb25EsyQdsu4tYQgP0/eqZmbRwyjUgUoYQXiYSWEQeqLocil?=
 =?us-ascii?Q?LWsR3l+VHGQPraDRQRWsDUP1O1bQqLuJ2spRO8s2BUyZ9MY5DCuOfFowLrIa?=
 =?us-ascii?Q?fqIAT3JKbP5ccjcReFVD6IgU2DXWdstIQKuobgdMqCXCj4pX8GW967QKfXnG?=
 =?us-ascii?Q?IxxKP+4OrsZnX/EyZJFCXVCpb++2llgg3HUgdcv2Cfat87Lal7/Yu8CjOUe8?=
 =?us-ascii?Q?9jy3BVllP6+T61+M39cVE/lQvFYQW3TwCHP+b2urIgbYzh0dJ8Afi3kwvDCd?=
 =?us-ascii?Q?c/Vyuj+IT06sQUYzdNQ8iNKZjLnOUimwOupdr8RfeovF54PpqdjRj5VxzkLg?=
 =?us-ascii?Q?dgfMAsPpZoTrjRURkTB7Dg9rxjAhi2EEKUS43slGhcdFtWxIPe3LUnrPLk18?=
 =?us-ascii?Q?rVuQKTl1XwcjDHlRxg3MRuzS/8zxc5RkrS1nZYtzpUFuRFHGO8CbdtYD0EFQ?=
 =?us-ascii?Q?mME+jOX9V76dxlI4FV0XJd4lUMhGb6FaivU2VoKTLu5kuDYE39CQTnWvFpoU?=
 =?us-ascii?Q?eJfnLil6Rt4aI6pLiDSmn5lVPJjSAY4bN049qGSAGBKRT8fQluPHoWcE3B4a?=
 =?us-ascii?Q?A6P5HoMNMNj+izrFhmeV3y+MS+X48rkje1iKCxEmkQDNvojYuzJKqEtuwmjQ?=
 =?us-ascii?Q?flfua4LpLz9vYivL+WlupiU4GjCpUyH6N7w1gEyJmhPQVf5/G4kUd3yO/4QQ?=
 =?us-ascii?Q?SlLyX5Al37UvVF7LY+wPJu0xZuTHsHoBDCECe0xQVeUSsfaDmSdolXnWYySP?=
 =?us-ascii?Q?uywPm+txFtDligDRi1xRs1PmEqd601vMT4pYT/A6ctZjrFN86vh17d95FGlH?=
 =?us-ascii?Q?fivDacEV10DHtsGEIR8FZjWPjGpTLXUPKOK3CYkagaPB54gp6xxMra7d/tdu?=
 =?us-ascii?Q?OfnW1UR4ISz0E2eQQ66fzbywWnAU4BClmQBkZP4NR/AxkrYisBTZQhZ21mvA?=
 =?us-ascii?Q?Sp8BPNOUqqltQUTf44Q9NPiw9tSqwSZnpd8KD7q8kSDHlMR3YTWjEaWmMIbt?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mh/GsQwz3Mzugdim+z1iUPI+M8jrgtUaBg4QbxxFUahEpj8KcKK8F+WiF2IrTigUckcoBzS9BUFCdm7/SPJPEaJpQg8H/fKQFGByJb5GGdxEQEcva1ymMPSGIXBWPscHhUpcQpbiKdaa82m+2CQxzi2t8AxCpi44S9g9RS7sZG1B7D6oBu+KPvAORn5UBDV5xYVMxE6FNJS4d2YIXCrnUgox7P7IOY1KVE3qoCeYg5rXRfoVH+IzOYPPMxHLEsdppBHExaXRMB+ZFULRRiltrGWbcR2VWQgPqveop2YgVwOmHXkLHnE21ETvBvOkgLotgtMqJqZVoGUTvL7oKPD8QXMir6wvFF5QYNRPnAzm2OCRJyCh7m7UXV+od9rDA2FihxWbFEJWwcytZOBlJevL/ID7tC7ETG9MMJUURnKXnvmFJh0ZL4ohvVyFurE2GyCWFHB7Fg9/mrlqE0Lrdy1wzl6SWdjZDI4dgIOgAn4aZpwnXt7+THxlzh4qOJTTUymi+pcTk6Jr+7lCu3xz/urbQsEBofuubixj2/mNnOq45go+BSUUGaJ7Hyd/fe/EpJPgvTpeIPh7sLSmNV5W2jUDTDrHud4oQ1qQaXY1kN61vQqSCWQUpW5mK6S5mPmq/hkxONOa5FIZFrbKn26WmCHa3ZdOBHN7PiX789u0lJoD/Ggpp1NbVBBniERtSFyY4gLaN95GTTltWxHelQqecMydZ/1QX3w9P9wNZbtSaJJi+upB/avr/YRQeEtfs9tUm01FvfYUmRtAj3nfJnaQ3KOaxRmfAPxKTb9zXAL5RYQo6m6GRoUIXm/s1l4bTE3cb0c5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3735435f-b0fc-46c1-beeb-08db567b5873
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 02:06:36.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNjGh/WTHGEPi41XJ0riFH4iduSjvGyALGDTwrqN6yT/5b2DZXeWz/cN+KKv4auRr79SqL5GvTTBWu3must9WiZVzJLPck2qAsUlckDCJB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=687 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170015
X-Proofpoint-GUID: SN3SD6_FJpzxTsITdVjVnXpxQcep0Rr2
X-Proofpoint-ORIG-GUID: SN3SD6_FJpzxTsITdVjVnXpxQcep0Rr2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Juergen,

> Some callers of scsi_execute_cmd() (like e.g. sd_spinup_disk()) are
> passing an uninitialized struct sshdr and don't look at the return
> value of scsi_execute_cmd() before looking at the contents of that
> struct.

Which callers? sd_spinup_disk() appears to do the right thing...

-- 
Martin K. Petersen	Oracle Linux Engineering
