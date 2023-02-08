Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160CA68FAF7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBHXNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBHXNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:13:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3BDB3;
        Wed,  8 Feb 2023 15:13:33 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318Kwkng021714;
        Wed, 8 Feb 2023 23:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=B/ADLa/EKKQWRqY8vBp+nsVxqFliIDMuOb8B9xz03bQ=;
 b=rhtCGJaTNlYLSNYmy6+PQaNYP4/TUO/7KC2dpl5lGSHx0U8Y5hmkaJAJ1AysKCNjIbG9
 YljfVwDnLRje2fl9DqSPAwRiJBGtAz/vrMbVWwNErkuous76Q//mSyOP1awRWqwY/v0c
 K+Eel1MQUFLKeuGb68EODhT/dKjG00HlK/gqVZsHevkXX6YDIle71XhSqaNDeQaT1Fg/
 CFXnY7maIRexLDqnacz7yP2gjQ2I4rOL/SNVbVZiEhbqgOktMjIR/XEaj9i0rB8lJpY/
 r3Typsh8Ltm8g7Rsyh5V8Nfh/R5rwrZrCt49r6jX2r3+eAodn13iFvWCBDNdaR+dATtR nQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheyu1k7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:13:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 318LPGg9030788;
        Wed, 8 Feb 2023 23:13:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbcetqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:13:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8jwxiWFPF972mY2aXXK0uN5bte3XZ7qhgUfyrSx3XmtJkDf3VsHxzhaFFpzYF2t3XGSPiArx+NoRPhkILoSTNSoBxaLVE+TsOTyE/1xOv8iKYN+SdGgeTbHKQb1whY5V9U78NrKaSEGCPizyekszwBA42ZRcIYPo2yXy4iljG8JpLIqYwylhwxhwZ9GHc/8MOsaWBQCe58LHsNG54oDuzDyS9bZys0DxlHxadtNspgcN+O3P67tPN0BYIPu15ZaCobPDoGKufeOTkQyz+j9seFlEFSSGCbxawFujsm3Zo4PnOu48r3ofYBOu2qrmMxsCbRCjvlOq3W/x/FwVQ3ETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/ADLa/EKKQWRqY8vBp+nsVxqFliIDMuOb8B9xz03bQ=;
 b=Tff7mxihg57L/Xley+raVYxnxCXz1VS/vH+oAjhy8u4hCUGQ87Re6gc8uB9PukcPv0f7od7skVgFaQCLmlRvyPhlaClOt4yo0FJ8BSpfRJkU0svaEXVv89BLqOcgqwRphC72ggfjx7OKEI+74tpE8vUjRDkIn8gER94L31YZYbTr7jiLh4uFpBfEl38pASUUzgFCeXorIJ5VEuhcWP+IWHE2U2WQCDSc8Bd9hgQu3XdHgP3DysJscAYaATzBZPe1iw+xxlCfDwmtTwrDYrUK7LtJQUOI7zmSD33MtZ1Ds3ExAwED+vYo5R+06X/xBuWOi98lZXTv0zBdGQVvkyLWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/ADLa/EKKQWRqY8vBp+nsVxqFliIDMuOb8B9xz03bQ=;
 b=VvfEG3WryLxrLUcuvj0uTq8cfK8d3WyHsW5Jm881dYQzSLhS1/xkXmuzDr9wIg9x0Ev/soEVSKzIGdGmccctey6B8bC4KPZdVrguHFjxugnw79vFoboBBKCCJVX5kSDRm+yYaixHyLEy8fkywSdeG5k8PpLq7H8NLApr9atK+oE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB5381.namprd10.prod.outlook.com (2603:10b6:408:128::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 23:13:21 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%4]) with mapi id 15.20.6086.018; Wed, 8 Feb 2023
 23:13:21 +0000
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 28/35] Documentation: target: correct spelling
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfffzr7c.fsf@ca-mkp.ca.oracle.com>
References: <20230127064005.1558-1-rdunlap@infradead.org>
        <20230127064005.1558-29-rdunlap@infradead.org>
Date:   Wed, 08 Feb 2023 18:13:18 -0500
In-Reply-To: <20230127064005.1558-29-rdunlap@infradead.org> (Randy Dunlap's
        message of "Thu, 26 Jan 2023 22:39:58 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BN0PR10MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6255d9-801f-4570-6963-08db0a2a122f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFyzv/s55enh1skz3FThyDFqXz4rRqV6qKj630tS5Fbru4HC4p6dhKp+epOqliKoTWcLBZMhO4pFhEgA3q7ZpcgORcGgt0U/Gh+uNzpXna7Pia26A/NYM3gZIp+OXeYkNgNuXN0jth3v4nmds17S0T+GYdifdElmY1+g2/inWbyyKi4tLry9fflZ9BGCxb0tTg3c+OkF177YDkl61LgrPirUkkL2K0RmFigQwIlv1QB1VfncDHTF4Wj7/IXJdRMXrmMKb28wWf5EYLOjEaGg68sjRrvBDzjKYi5LumG9tuf4ZltLyvyUFPUlF8EiWwjvG1BiBpk5MMAm1nkF+VMTSOGu/y7SOyGjgC3Ynrwnu2wo/f22zYueXwDpKjMvtZFFKZYhJCkwB9qjqwBy/CRLvKInFz/3N34CjZON0B4ChbllyFGbXAWzAVP7CtkMwvQg2ZixbaqPBuUbvXeUmJcHWTwqAdYxNjxs35jG7my5t3VhYm/XxalN66U8mfMH6nnqjolB+Tp84ZA69prUsuiTOJxn7yPQBJCVfQo6qVpL8sexKHnwh2zDcdYtLs1FvlzeKhLA3oBgqYBJVkfrGvmugFxoo+Q4djwj09UUm/od4UtiJQ8XNjfH4t4XoJL6W8ADQbyDiNJKf1v1uhwKa4CN9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199018)(38100700002)(26005)(6512007)(41300700001)(6666004)(36916002)(186003)(2906002)(8936002)(558084003)(316002)(6486002)(478600001)(4326008)(86362001)(66556008)(6916009)(66946007)(66476007)(8676002)(6506007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bkYzrX/yi57OAbvWCPRCiscR2BbpaYDhdyAICO+17FwSOAp7zgX8LDX61x1y?=
 =?us-ascii?Q?WJcBM6GZBsfirF8Qnq6O5uixdc3FNGb5q0s2C8g58cgSOIC0BHGgzdTfTXeI?=
 =?us-ascii?Q?JKdlvLZqczj8m6aotGAhk9UsMoC3fUpIScaY0UJRkuRyb4W+yXkpEae+nuxa?=
 =?us-ascii?Q?ONY5urjpveUu8ijGKrY083LArgx+8r07gUa8nq/pS2STehYyJ9EPyIxGA/WL?=
 =?us-ascii?Q?tax0LPm9aLk0TV5Q97tJYfnIECu+gUV01QY/PEo4hP+FIQKV1NuoeOMSqOhm?=
 =?us-ascii?Q?ysMmA7NM0zkj0oFiE+1dxX3aA6hfYOt76yT4vYuaHxmorUzM5u7tG+ONVUJG?=
 =?us-ascii?Q?8RDEPwEN38hs7lFrIvOgWpOq5Ao09WTLucK7eTKqCfGJ+pe8qyFHPvv7H/Wt?=
 =?us-ascii?Q?FleY9z2WkasrRbARJH4oAp1UJXyXv2yOvL9ldnbMFEnJ+1GuUQde+aCMWvJQ?=
 =?us-ascii?Q?5QyVIIv8vrtpwwMm50NA8KMdyXr0wXUcwonqlsSZGFJsYR01dk24HDo9Jdg+?=
 =?us-ascii?Q?j4Gf/CS/pLDiP1gam9TWy94ghQxq002w8A3g8IDNkPVVBGklT8JxaiNrxPIu?=
 =?us-ascii?Q?1j1th0dNj8JFJuEZIphm7z6bQgcA88YW8jCQm0oPmNOHpgGUBWuEqc2Pr8DJ?=
 =?us-ascii?Q?zikKN9oRkc8rOd4YD9R5kAaxR2ibEp6dc25JeudzhztrK0gPz5hnFHwjBxLh?=
 =?us-ascii?Q?Npyb8gPpmETHc58MLY/w8uHuj3Amkp5OQlysQR8ouN1hFogLElBHL32fFzUw?=
 =?us-ascii?Q?v2lHgDR2G2pOdc3OLP25sBklC+B8JpRp7cO8E3UTJPr+GLtOixmKX1yA+VMY?=
 =?us-ascii?Q?bJkPfJGBamNmny+boByfdp/VgKlMEIeWpMfeb8jnfi71rkwrPJr6aU38Rbbi?=
 =?us-ascii?Q?sEvqwlm4qRI3TJdIpEy1nMfJYc0BLrorNP4AMGtSq/pFmLNFNR8P3qx9q81O?=
 =?us-ascii?Q?GHsmthddRzL1XD92XtMQNfV0XT1LJcIJK6mcFD1HUoku1tfwpyYGFttvuoKs?=
 =?us-ascii?Q?y42sNPS367XihWN1ETw5KDcWCLHfL7BXhLA416Rk5usvcQ16NqEtZq51Z5vL?=
 =?us-ascii?Q?auQJ7svrPqmUJ+OSVnWmLU2A1Cvn2A0Kz67LVyQMzF+HMPjJKOqzCzBNXR2N?=
 =?us-ascii?Q?ruqUe9sQAD2747lgH/pLgqBKRblfKCWVigvIgHfWVsU7IR/MfUyCFTUHlWzi?=
 =?us-ascii?Q?+Qov2l3ddETggEP4h75eJqmUj2XWtCeWtr3BAwdTAF5AodPdw0mS1w1gThxT?=
 =?us-ascii?Q?z5+lop+bRiVrxf6exk+pZjmz3uCx0uy+8wL1p3XC+8jUDTItbGzG1MUsDmzU?=
 =?us-ascii?Q?W7dTi94oNW40DyRRvv74vJyCCjxwJvwxdoUXjCKHuf1dFU5FF9afN/613Z1L?=
 =?us-ascii?Q?Sp/ZRZ/EtijCKZwYkWnETdfm6TIxPV/kSAkXEvm1qyYWaPVTjpn44xQAprF1?=
 =?us-ascii?Q?BILJLnF1nGsvwM/aMgJ06QOcO99taCcsCtoSHhtP6qwOMxReDlQRhB4q+Dkj?=
 =?us-ascii?Q?Q2XKsoPtFnLSDQ6YXKPqW2HMGYeZV/SAzxJslKqpVsuZ2gLCXdmGWwMHeNqN?=
 =?us-ascii?Q?qGvZ5kZmiQ3NsFAIv1mcpST3EETnpEo/Mz9YYeKrvegG/KiEfHBHGvU71YHl?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gk0grp9PzIJoJN5kk4FWDFIJGDKTPTybgq5GeiZRfINnHy2wX13mQ0oskDkP6EMnVwwBH0ef11AoVxAndxC7sIqTmpmR9iPFsIAio7suJWqjoaf1Qonofnt/ZNbcaIrByaD4M9hm4ii10EQmqLtHAohMy46xduJ7pepUExQrtqhA5u/jF9DzJWrY0zYeFl4MAuuwEbv/7fvMIBbTQ9w52gu2cS+ve8xWUapnmPEIctJ1omIFI28A0U5lcG2Ul6wLcKmglj6oYnWZLEUCAXdTk2/uWqsEnlKwWltfTRs1ZuZjQj1TZT+lCflJqYccwPVeek6FUI9rLAxFxjGLgTfqkGWOnK4U2em7913Y96KpX4pY6/pbUzVq5Zwdb74mJolAGICxP9o6T+uD28G+Ob1T4YXP6c5R8nS/iigSEE+wD+SMx2iitqJ1W9AioC0U/DBL8hZmOA8jRElCaijx4BjbVvVdEtKzZw79szKU5pSEratJQ7uv90RRFOtiFlK15Ar+kdjDQnkF4dm1vs4xNFnpQJALceFYH5qXy/6SCmUT90IrbelFHhXIOODaGQIzLHjM4lnEMLP4S3lLd+9lG9pJgAWcfKIhvW2lbjkOWpja8YJml6DamLELp+YTxij6W5GbXfsx9X72yz6p+oO3HJpv/IpliEMRe0DYOADIqb4HskAotdVw39Yp65k3Qzq6ybrkDM5sjcNxEjIOgusx3DbLE9FcMq/KcXdAwOWLyq/NaksDqJEWK5xTT8ZI38WH/MolFshHeksLsa98RyF38m1eEICily4MrX0OwKNhb+CSJaUcHfTk8fO7hrEvMCujYYKp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6255d9-801f-4570-6963-08db0a2a122f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 23:13:21.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDhOCFYvKoUt2t4sTkCBv+P2Flz8TDm+oeWFCBkxBDb6jct0Oaw+8DdiEWxW1Od+Y4jzqiHvFNoLx9mOTFAm7QnzveINakUEXNgEoRv5Znw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=743 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302080197
X-Proofpoint-GUID: HLPZXbdZQ_ynZGnMvUByht6vAfdikNkd
X-Proofpoint-ORIG-GUID: HLPZXbdZQ_ynZGnMvUByht6vAfdikNkd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Randy,

> Correct spelling problems for Documentation/target/ as reported
> by codespell.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
