Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997F5739453
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjFVBOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFVBOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:14:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB01BF4;
        Wed, 21 Jun 2023 18:13:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LKdEUX003641;
        Thu, 22 Jun 2023 01:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=FucvdGW2SrfYX4pPm145KWeR3N1M8E3IIgzHFoJMiyw=;
 b=aaC8tXY81vpJrqG/oxhfejBvCyli1H1A2ze8AVcjqBLmpRR3gBqhBJJMr2gIzHJTPuF4
 vi2VA896Iyug0ynQYMbwFYzB0ZfALGrWtUX7nqE3z04MBHEtyxK5TbXdpFZwWc6W4l/G
 egUkuJUqX11b/ijGCW1BNgA5PxgnyuRpX6IKYEH2SKECNN3dgMst2vUoy/ChA4UabD9k
 S+KnM+IUlaG+Ud8ydkTCpxB6vsD5BhJj4LEJdIiiP2kKr2WX35mryfSFQWG2QfdjdvlC
 asQnPO8PgZrXok2tqYJXUErvs8CmmaiihFwYY4/EO5mQi4VTzHT3OSzcKr5cueFx60I2 Fg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95cu0q5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:13:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LMhqDK033019;
        Thu, 22 Jun 2023 01:13:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9397s4cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BV5kEzLD9TNG6KorsJ322mZVu4jgjG94ZpdPBdLube2pvLLyP9BFrzMst9W/cMQSo7A4etIycQXkFSIFCKs1megBen+Av6f6aZJaBrVxWrKqtBS3I0Azx06/JxOJFNs14kCiDWlO1l0ytJa4twAtuByYaODnyNdZXAUSdU2FffPzDmMC/iSwmKGmaTeSLGEFnSKrAHr7z76kKn9v8zupHOcFJbwpGK9GNNsGR0lZ3TiejwP/n45Y5GgfCsuMh6CBwH3LIBpcEm6mFUiEjexkj49CaTou9KKQi/7YsY8uzAVylG6QoDZl9V3jHe9WjA9oi+WqpCbZ2z68/1q0OxXR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FucvdGW2SrfYX4pPm145KWeR3N1M8E3IIgzHFoJMiyw=;
 b=PM/X4HX/SJ1as2pZlAl41A3r1QWphGwoQuhg5Cbn81WCLJ1gJOFt0/x+X0wCNm18spv719lBmhVH57095oZstDulJBdHrONC0MYcQnIOInNcMtQ69p7V1HHUAgs/qzxHJP6DnCfTmUVLuN4T5Rqi6dtnmlCBhEivDp0n8NcGbiNMvrlwzDOwrfmFJrc92gGzWhHoTzSijZ/n4S+Jolp+SfOSoz0DkOv/BhsXErAkbRAQLk2Ni0MLQZ4gW0fnZdffR5+zpg6sWZA+odOag+KQxZtleEDVk+nHn+V/vrusIofsZIchfDG0+nbP/2ADf48CrgLEXZWvPSBDC5g2ZJ4dTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FucvdGW2SrfYX4pPm145KWeR3N1M8E3IIgzHFoJMiyw=;
 b=v0Vu6vmuoO2pOOvxQc9eV9DkN75oJOWpNOcmnjX4EQ8u+ngulowFRXZan78n6wIYe9umX7ykbq/0rF+7yZUxCrq8RyJ4gSbnxvONb2oJHwMnrx6jD0LeZLoe6AP1ZBSnLhH+sEReqgizlE38TBqQs7WNwQ2OJn9A8twgRglb5YM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6554.namprd10.prod.outlook.com (2603:10b6:510:205::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 01:13:19 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 01:13:19 +0000
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bodo Stroesser <bostroesser@gmail.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] scsi: Replace strlcpy with strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttv0qoyj.fsf@ca-mkp.ca.oracle.com>
References: <20230621030033.3800351-1-azeemshaikh38@gmail.com>
Date:   Wed, 21 Jun 2023 21:13:16 -0400
In-Reply-To: <20230621030033.3800351-1-azeemshaikh38@gmail.com> (Azeem
        Shaikh's message of "Wed, 21 Jun 2023 03:00:31 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0121.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e690837-75cb-4214-858c-08db72bddd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAc4Uc2sW66XkyKPJjy/+JQleyQUIm6xnCShI56NchV+SdLkJeAb07SEMFV25fkzInvqjkHnsrXepS+rIm1bhwLiNqzFNPaETlCCwnPtENLhiCKAvYY9x+GG6ZCnScPUDIf6vy5JY7G9iwGnYgD1/pwVSAf+mh19DBuyfbVWbtGlvsTRvTeBn/0DKUa5XVUuxBjfKdWvzKEjMxFM25jBYIPSXG//CqzUlRU06entqL8AF7ivbejt8EsEqX+Tp7bfbxXyd2NoyyyW4dBY3MZTtxUIBBeOAPca0q4m9Zc6qoFVUWtsdSAf92Ou7c3hxFD6bBGg/I2VdjpH5OKJ+Ecs+jpVIEwDEpWJOQFFAfs7Zcq179TENaSStQFZHVjSiMOVbM+4im9TiqWO1lp2C+gsSoP1sYImny7rbFMDIFEk1cjlvnDrqGI9jTr5Tiy77L6wuhSmXWUa8qwIOSWhax6SeUfZggYREysQ68zJ5/QU90hUpo/JgzKVSVpX90Azwt3+fIZA+ZuB9hS+fnZIZ0vZu58MKsL8/zAEOyS0E8cPydLEkUnFHQjZIeuEC5PN9HBwklqou7/baWYMofilr23Rda50z2B4zu/3gcM8z6hBo4GncawBTRJZQDRRVC/+M9B6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(66946007)(4326008)(6916009)(66476007)(66556008)(316002)(4744005)(5660300002)(8676002)(8936002)(41300700001)(2906002)(6486002)(54906003)(86362001)(478600001)(38100700002)(6666004)(6506007)(6512007)(26005)(186003)(36916002)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RYtEIH2+vF3doJhMZo+2D52EgkDyMMpPdHp2PP0D9jylKG1Eq8pWvS1qNoX7?=
 =?us-ascii?Q?hULSxC29xt0VEEvUYQ1psQjVVKmtqEL/mZLRhh/aD1ju5JTYLTbFiRXwmfKC?=
 =?us-ascii?Q?t+Aib+WgfQV1bj8aGI/itDRwhWzscXtUteJSVjG1I9+p8cJ54UirIAH3zf55?=
 =?us-ascii?Q?5jKtHhaC+5rCBFPglVduMJgLbrX4HpYe/JMHnQUSoNPDMONUElIweVgevxg+?=
 =?us-ascii?Q?z+ElUXT8z/Sl2efQCLUl+Xn9dS9nFB4Bawi6WsM+wHewO7v2zaABGls7ZmQN?=
 =?us-ascii?Q?DRexjPJaw6KkIzXGUxnXSxo8p1xTjDp9Zx6GT5eDblxRp2m74ToHOotZdhk0?=
 =?us-ascii?Q?zUQyRh02iwwrONAKppxRgbV2y17Eff1pkh8aB10/9BY9KTTskGLkwISzjNXc?=
 =?us-ascii?Q?sfZr3D4nPOTyPwTHvIq4nRH3MlWBrgOQ+J94AO3+2NUGOFdO5/p1lchic7ai?=
 =?us-ascii?Q?ruZ+4nje6lb8hUConVPLRlv6+Ee1fUwkU2u8hehzEZpE5JAh1SdnLEZOQd5Q?=
 =?us-ascii?Q?m9zemxwJPxGMqbspgiIasrOl9wmI2tHC4AIPOQycEnouBHnx2fFPRjAgP+zt?=
 =?us-ascii?Q?2Cs/kOpgD9077ABdl3kztdMl3ZCcpyjXt4Q5hcySxW1jsPxTNB9MngKzhir6?=
 =?us-ascii?Q?x7K6OI7sWkXjkwdDZFfkzvR7sUZoNqJKPgoUfTrdD0VJ/A0KNUev40Dsa1jQ?=
 =?us-ascii?Q?6bypLjmszynO54R6RUCZT1n1A2BCRr0oRhltww//6G9EYgU5cOjt3fBhKio4?=
 =?us-ascii?Q?nct/IC/1BgbmWuRWKi8bGV0kqJSY6V4K0+qPoK7Cdy6rNW1Zz7kA/JWBGWLn?=
 =?us-ascii?Q?9yFDqPsnnlZeLN+4EmIQpTPasw6pcd13wUk8f1fZyD7Af4iTx0DszJoYleaK?=
 =?us-ascii?Q?C1tZQk4cntirHmPuIi+sLVuQR33/ji7uRerard6vu2OwFeUZvfTmaq86TkmG?=
 =?us-ascii?Q?GA2/ieTYApKbbHRmiRHdObi7zEJgztlo91e+UzNli6wudy+mY0Eg+pe7mnFn?=
 =?us-ascii?Q?PYQuY1iDOh8cuEiu4dyWRnK88zTBtRoO/8bfoFdS78Gynn3w7sJavYJq1uGv?=
 =?us-ascii?Q?efdkppJ1d1vWbW2RPFEQbYyaByrN4aRIQD+9/IvKe2SrotOhUkZ6vq95d7oE?=
 =?us-ascii?Q?j86cuio3W7hAARbOKZyYnTnbtZZdzNepsOpUAwiovGZaLWWnCkGGsxLdR3G0?=
 =?us-ascii?Q?idRtpMxUg3Dh16w5EyPNPC/IK/LrVtbioTZ+4PxBLzk0dko/M/2WIFn5kGtj?=
 =?us-ascii?Q?WWtu68kekIkDYIyF7HGF5fq1zxDK/MUvg1X63DX7sX2dXS0ejjbIyZ/GRnOu?=
 =?us-ascii?Q?kTyUWkeIu6XnMCL22iX6cmtlhbgAze7OX6gKNX9s3dTX5l2IaNVn5QeQTAt2?=
 =?us-ascii?Q?N4YyJMM909wSx7esJ/75qL3jEmSl5XJZNwrES5h4Q/4/oEP7Kjgu2r3ooyqF?=
 =?us-ascii?Q?vZvA12SD/6rvQ1ZRxwYCGMLU5ssX6K5EpiTFF8UBe/5PVq0oAyaRqd/qBf4b?=
 =?us-ascii?Q?uqwrGD1bLm/+ucYHJsC9SG4N7gcSBJF7Mf89bofJmS0rMhN4bC3Qa66kU0vI?=
 =?us-ascii?Q?2dij4xCDHinTr1npkkF8fsbHWEXlgL6gVp/DBxgomuIpTOK0LTtvyLyrXVt3?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /QQKKnxOLru5jHI3oDnJl67uGSjcbFqWz3fHe5DZmjiy+nbPX1SK5aPhq74pqZALXOKS5Q7gm+1Jv1OEUuMe3b8Cvldji7dQA4GRohsufqtvOhV31UH/pY/1ZqtX1y3i3DxPqK9dPQNqFWDyDaz9T/7KKVBovnR+nShjCcKOPbhMbYmxSHtrKZ8cwou7Yo0QZQeIpXFU5jSSiwRMGLjJenEslqtMwpmJTGpslPrbiGWTfq3lI6MkxEFz2PpSbMoH6iz7JPijNl75Wc0H+qUYZRsEv45tUV+C7Qnmsp1hYQr62OJZswDvdykEsuZteQF1rG5EGd39qmj77cMeFbc0R2nW2Sh9oJk6wSunz1IF07fw8ZnGMv/6ukWtEbehvFy2eZorRKU/XtRDLDh4E/nQQhX3jdAu634xgDjfIJCyQByhzRm1w/3IBkeWCFnUTw7x3WTdvEmph0bRR2slO0rSqwaVoEaCHI6aH2mwbiXMan6w8emLTrbPxkv0NouyspP7u2fPEnQt4li83tqkH+R+iEKX51FXPfbdzYQu0XihXxFPE4UPnLUy6M4Fze6tNpJC9VY6vKhCgKcHJ/kpWtRcWtMgDuRIQ+AAMjtAZHROgqZ/3gwhos//4gd9ouXrr4N1hU25Og1C1aSTyRX+PtO4NG406hl8c0hqESuU9qZ3GDP/hOIR6LhrIxJtUulu6K87N9uzgbXKf+meglXfxMUgRRVEu9cm7khQi69ntOy1kGEZxLLv9XcYFp14mAEWLfeiRYb8yaqKJzG0pzjvtoMFR53C22BYE03FohvZCmTgmS9kiM5wGCSa8DiCCDTVN01DRU1jYyeRXHs0OeW9KVYZgA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e690837-75cb-4214-858c-08db72bddd16
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 01:13:18.8790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siiMfr8p+a3m4chI65JETVvrf4EG8biajfmj9qIgeeDQmeifRtC3JaoLvLehJ3/MbPsBZ9i8L6pEtcBu1myk6Wh+N37SPUUg/FQIV2bejO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=540 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220007
X-Proofpoint-GUID: rxJS2tbFFkiv2l3wQRhqc280E6rBP1vG
X-Proofpoint-ORIG-GUID: rxJS2tbFFkiv2l3wQRhqc280E6rBP1vG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Azeem,

> This patch series replaces strlcpy in the scsi subsystem wherever
> trivial replacement is possible, i.e return value from strlcpy is
> unused. The patches themselves are independent of each other and are
> included as a series for ease of review.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
