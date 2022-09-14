Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FA35B8C27
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiINPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiINPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:45:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359306B142;
        Wed, 14 Sep 2022 08:45:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EFfSv5018787;
        Wed, 14 Sep 2022 15:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=NpQcWWAQLXlP3bHjOekDOc6AuhMbPz1QIK3Wco5nBig=;
 b=1KeejC36BCPmgHbXPuoJhRBT9xrRcv4OXtBI/HLJdF7ETgQLnpiucZXbqh1UQw8jt5qe
 XbrmPd4z85Ch6VcP5zXO6r74EFo+011ixTA3k2Vsy3xDHSkJKTHndPOs5rYlX++ZU4Nx
 xx3+OkU8VC/pHFEp38xL9We6kHme4E5ymvJIXCONzE9FLGFevnbz9mO9nsH9V4IfOdRq
 B2rMvXHyzZ4c2s5WpRr9uzG8GNZRpMknloCai8/PZ9M1L+AnMk/nMsfd87XUCetLwNAY
 vlkgvnTD9AD2QqnEWUuWrhANOhJS5hLXYNkXKSOhS7Jl/i69AQ1y6+QPES7u2ERukVSV Qw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxycaqyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 15:45:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDZcOW006549;
        Wed, 14 Sep 2022 15:45:23 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy2b3a9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 15:45:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwDja+POg4MSxHi92vAP43DjVfGSZyJAoM4xMbJJZhPlhUjkdTfCNxsmlx7bKaMZQew680AgVS0kWOlcCz3xegiJ1EXtWIfGCvjI6GkTpy+G6lKm7x9oa6u+U9mYbSFzgItC/dGQwOd20Qdxvvs1ImXUC0GL84qFIwud3Ak3PEpVEYSAnKYHyoRssh7JB1F1cVZOSjN5kar79/6dp6mk+02sem+3MXKIo3Ad/M0+8HE8a0cIvtj+QdlogKbVPuinzDTzc0zK0PGOOFimHqPTHfaHvjOUk8hWALfDWkUGj7jLNxnaPHscXp881FfyQyaupTAY5V1FOc+8ZIM/AE4wdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpQcWWAQLXlP3bHjOekDOc6AuhMbPz1QIK3Wco5nBig=;
 b=lyO+rQwOBepjOK7Bg5taXmXl6nfCbgbkhlbxk7rUMv56BNoPnYxAUOmaVUyBkHyu+gtsHgfjDDdmYqFzk4wGa+S4uM+K9gIgJKeq68kMasyIcx2VtJeGV8XNYW4U50M/Ejn5I5tCGffmnYDdAvEBrayA2aQR1mKOtEcrAHtozbyUNcU3riW2uhuUi+Qfo0OMCmPAzuiUj4btlEFawakOtFXEdUNbNprqrT1pUHXTfG+L9v2JNgf1u2ApHkDy5n/Zs0GekxvYZ84NFeIkeNI+5yd8zYp1ZeVgx0SnrS1SK8vyvt9eY6ftJnWPQS3g8wMw0xtGm7G4uQJpg0Pva0v7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpQcWWAQLXlP3bHjOekDOc6AuhMbPz1QIK3Wco5nBig=;
 b=aTwFubtHvFDHaCzk43PwSMrlBFGmpy/DawzCfdUzBfc4Hpgg1wx4NRjIo/Og7B/WDKIDxsoqtUZizdEEGK9Pc20B4T4IgBGQ0kvAMVcjWXozwpsF3eHVAV7AaVWWEGZ6LnXpNt2qCSUBYbtbLxmN71pU5HYl5wAQFLFxBWvTqxU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN7PR10MB6524.namprd10.prod.outlook.com
 (2603:10b6:806:2a7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 15:45:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 15:45:20 +0000
Date:   Wed, 14 Sep 2022 18:45:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, phone-devel@vger.kernel.org
Subject: Re: [PATCHv2 1/1] media: imx: Round line size to 4 bytes
Message-ID: <YyH3ASYQsgD7i2Yt@kadam>
References: <20220914173236.3040f3a1.dorota.czaplejewicz@puri.sm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914173236.3040f3a1.dorota.czaplejewicz@puri.sm>
X-ClientProxiedBy: MR2P264CA0047.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|SN7PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce61486-4331-44dd-d9e4-08da96682137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vePNPYC0CXYVAvtro6ABNi0uMw7/Gs3WwSjSc7ky6BhPGBF50a+T0kNH7gzVTXeHvLWsTIuHpifs9rX7PwfeWbLe50vKV3Ib+x4/0rU0hxhD+ezU+JpLjNVvDftjuGfI5TIB9s9k9y48NvrRUn78IXi5NbNFBMAqDfZAr38fE3X68KZoSmsRCjShEA3vJRhGTJNOuF9OKny4vzdaQs1LV/GYq8K1nu/rrezgUxNyW/529ncrsVLlSwzU7erHfuda9Is0m+H574LBaThBvlga1bPvxGMmUQ3x4YN44oEFFkZynorqtoxIvis+TIvci9srxGQy23dEKpmrBTra6jOb6zrapf0FS5Yy1clb+QLraubYiySsDbu/b2IN2yV3ZKhpYF5TrjvqLHJgw4vzdssB6UnVYPTs4SiuCvYCSQfs5T3W962x7xU4NojPgqQGnOxPU1SKC5gqoGKV9+a0YYkOPP7w5sjLgfusLcMev5F1ZBKqsvgseY7bRTWFI/PfWUo6tUwg9qWedKXk6U3WEeCCKKYtL+G/F7uu34AFBJWgSfn86t9JwaXIAt7zCwRvNIPbqGcztfEdXlYuV4yaM6Wh0hmJvjfWLYDR/O2udm1KPMSIpxDlsxrSrkn/usksV0zBUJl3DMiTNUAwkl8lfYi1dtFwAzIK+wKiUYScJqHphYGEtriN5Uqr9NWjdzGF0V+4CeKg4XKaX6mDJDELaS6wJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(66556008)(9686003)(186003)(6512007)(66946007)(86362001)(41300700001)(6916009)(4744005)(5660300002)(6666004)(8676002)(316002)(33716001)(66476007)(478600001)(6486002)(4326008)(38100700002)(44832011)(54906003)(2906002)(26005)(7416002)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ZGu5UfeG+tJAJPn3NFQlZ+rZhtPWojCpkNXSDklUu3R4tE9Z3gZk22wiWym?=
 =?us-ascii?Q?8drzQ7p0fTW9rpap2dsqqG2BTtc+Osti9S8pv0R9VF6ftM2ykEQcYjNOnUSY?=
 =?us-ascii?Q?B2VY+QARopzC0tmOMOAjDblTVAszeeU34bN0L6QMgX+KZVQAxH0V8RJc9nor?=
 =?us-ascii?Q?C8ekgd1fZozfDIe1uN7anQ8y53MOdbwiOT/S5oWoyQE/5n5C6ru50RUKNFBH?=
 =?us-ascii?Q?GCJZrm+yNH8klvGyjXuNYMNAYBbQHptEX/zCgk8mk7dyvXf1CKYvS9JyHGVF?=
 =?us-ascii?Q?PEUMzx/NFzWs16tAtRq99nkWgS5U5qXHFcw0r+XLZsS3sLDgB6cdLUxTFy2+?=
 =?us-ascii?Q?KIB9MMf3y4bnAfPe4OFpQOjb/rofDShgGOJGVqKwZZ4EdAM0seXgoN6EyvEq?=
 =?us-ascii?Q?qNSOVHpSLDWkLOw5Xm3/BM1h3qIfjSKoUxsEBsWE/k1jKWUENEhGy95A2g/P?=
 =?us-ascii?Q?Z7YT5J5fRT9sCY6whWxgK6xRHzSd+GSV+9/46162R1asufnoluM8Tt/P+uaZ?=
 =?us-ascii?Q?LfVUbz/SJeJxxGH7W/hPi1PEiaegJ1evDDR1fbtWGBwtBJ13SuH8r0F+gd6J?=
 =?us-ascii?Q?azUXoZsPdmB9r9Ms9iTMvgwER84H8ZgJw4aakJAkqMFjQGA0ehlLznZfHp5n?=
 =?us-ascii?Q?DEONQm++TMnlOH5Um1cJqe2QEWys9v7m/9S3M3qO5ugMh1cIXWDVs9BKeWz/?=
 =?us-ascii?Q?bi/twHu+kncNBmPxDkNPH1Qd281h0VtMvj5GD53NNgKXFq7thPGhA3mRQaa4?=
 =?us-ascii?Q?aJ2wdh3pRgLYGVFUbmz/qW18pQwdgG5CODa/bXW3BxYw8rYQnzuuUYtmB6zt?=
 =?us-ascii?Q?Nh3j5dMsEbze6yqgOQQF3Lo4oHZ8arQh7PsKeFuPkteRKqemDmQYjMcUmqHP?=
 =?us-ascii?Q?iUkASWA3AaqBQKGcC/8Nl6cekxftd9x0cB1812adptI4C4TwOlYkXE0Ur3Wj?=
 =?us-ascii?Q?txRqipab2yosekR1PK2jZe2zWdO9UFju9jvwBWn+5Tuz1ZT9Va613ovA5LcB?=
 =?us-ascii?Q?NtDTTWJIXAvMU+YCwkASOmaMCjRbFIXSi5FYMAQ3n4se4uPp72i36soN5sKy?=
 =?us-ascii?Q?pilaOUQt50sxuNtOB3yVQ8sfGMSqpapwADB49s2TlNpQKadKqoC1yCkLIgPD?=
 =?us-ascii?Q?yjz38C5UGFR2oKi3F8u7z/Y0y6WS5Kpz5DEFcqyLe9Zde+T5Kpn+VdPdDfD8?=
 =?us-ascii?Q?GNYGIp1Xr0g6e5wGrvKSqmWHQbEge+3M1ZBDSPcN7zdFm07KWK6Ryau8z7Aa?=
 =?us-ascii?Q?svXUCMx9aIAZR6CzL5xN3ukN2yNNaakvtIrUnDc3JE8Y6b2Lsa+AA6XYdGo9?=
 =?us-ascii?Q?JNQPjJ+WQnawYf5QlUNZKPncK93EdCo/JU2XgGrTvh7s5ApfQ517XjnPEik7?=
 =?us-ascii?Q?EvAPop5e1FE43zAVKgqGvEokdtOzeDb9TOgAL7wJl39G5VQ9n4/LcS4aOQXX?=
 =?us-ascii?Q?wAuRKSWMVfFxbSx6Lf9rVn0s9xo7+8VH0MQHqfekR+Yq8F8VlRbi/wWQwQw7?=
 =?us-ascii?Q?hhrF9+38aMiX5+QiO41fiaKOnwXu+nA7PTgY2eUvwIePG6/4sx6pzH5uspsc?=
 =?us-ascii?Q?rlxq3AH0OfHsmJ5V5f7B7JxLpvCfHdZF8+DJUqDr89Fx+7uSTQKA9MZCqUzC?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce61486-4331-44dd-d9e4-08da96682137
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 15:45:20.7701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+r4qVO5axUeE87xObpZ5Vc4M9fVu2+UShU85IS5+XF4g1T2iBHoKKv/bpQGHSQTXVYimouT1/QzbukYqQY4mdQp935/cwhJiFi+UiFl9xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=995
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140076
X-Proofpoint-ORIG-GUID: UpPDD3VKu8azdMRKmpO6cjtxIRZEWka0
X-Proofpoint-GUID: UpPDD3VKu8azdMRKmpO6cjtxIRZEWka0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 05:32:36PM +0200, Dorota Czaplejewicz wrote:
> Section 13.7.6.13 "CSI Image Parameter Register" of the
> i.MX 8M Quad Applications Processors Reference Manual
> states that the line size should be divisible by 8 bytes.
> However, the hardware also accepts sizes divisible by 4 bytes,
> which are needed to fully utilize the S5K3L6XX sensors.
> 
> This patch accepts line sizes divisible 4-bytes in non-planar mode.
> 
> ---

So do we need a Fixes tag?  Was this ever working in kernel?

Definitely need a Signed-off-by line, though. ;)

regards,
dan carpenter

