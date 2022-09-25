Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6207C5E94AE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiIYRKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiIYRKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:10:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349822037D;
        Sun, 25 Sep 2022 10:10:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28P9Wc2r030222;
        Sun, 25 Sep 2022 17:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=pCZ38IZzz7rpcF8MxWtwsWzZ4mTgpxCdSlWo0OIpjNw=;
 b=C1nKrhK0WurttDMsIOTqS0+iRI3dtmkSdEaoR8CVnt//444mBQmpBQ2xOds5/daK7y28
 UpH60tvgnoxxfzW5kmGhYRTX3kZfNdns6UlR5PqNqoFrWiSr1pWC5eUVYyEeoEWZVENJ
 VnIm4YtIwzYs92LBxu4YZvJ8rBq1rRICZA+ZCAHTJDFyVziiyjtbF4a+YEGZeFJEojir
 zZKarOH/0iKUUkvQv5B8ybJuBX2JoKHPnxJe2llaoqM2q6Bz24piFxooBwuFLf6NeEgO
 deoU38sHlzYchPggqMy7L2ifiEIGH3vjMtTiV1Ua4C77L6rsJkCtQFlI6ByGXc4DfPet Ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssub9xxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 17:10:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28PCHBjm001468;
        Sun, 25 Sep 2022 17:10:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpuxujg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 17:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIvqN94MM4fUrZLSitgNVwaHuhj0hFTZA+Vyox4g7IbpRu7GbdfbzGMrEyTjNNpKrZTQNva36DBKynIlZb4iaLbfHJtZ1HTA0obnO9FRB2EPb1taL48V5cc80FIRvtcDHJOJUOx4WE/S2yEhbF4kLynWrqgJsVv0IiUvP54irGPv3hO0LM8qnd1uhhP90+n4IaVpW68REcDuaOnoV4Ym7+7gYwDQcYNKbNAkdO0SCAGsJL3lq99J+PgltS/Lb0ENWPZZ2jwselbssS3FtWY2+j6LqN/4WhFPCEvfs5csYGDyvA5OgxRV9p0D2DN9s1NVC3pmUiUNRkunZwtCn8K8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCZ38IZzz7rpcF8MxWtwsWzZ4mTgpxCdSlWo0OIpjNw=;
 b=HHMILbVNyBFxR/rS6oFZuwHOYWGmBkw7Z7st32fy/A4LexwYZRzWFN5+4NCG5LKKzp/dcD9nITfLNwXqZl7PsFGesKIzCr5ZSWANPlX+Thtw/4fOHj4SMWEooOrpf3nRJ0KnEqxRO1twKSQRa+tuHePug6J0eHvErRGBdybISbVmPdQuHK19o6R7PFKznhYoJgXa7G3yUU91QB0UUEEkaF1uZiuoa+jbUkM1M2BiOR6kz/VXPriNTBxqVSnrxmeo/EPnu4s1sH2zmZvRnCwHmSeXlBg8DkBD/4kD1f9TZv35o84bzSKXW4wnpgdtn+FtD0znT9RNb94Sdowz9W1cTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCZ38IZzz7rpcF8MxWtwsWzZ4mTgpxCdSlWo0OIpjNw=;
 b=kLPLFj544nsqX/qPqeagphR4pBT/RarT6wgtZtaYWmHv+7o2k3golB5XJ15dPulzbL+AdiU1Gyr5+fOTCRbpLInvkKUOnJnjowr28Vx+9ALtvikqK9MVrb/JyQAwauk0bzbPRSkrMICFHeEIZ9x6rtFL9Q/hIX/4IJf0J7nXdeY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB4891.namprd10.prod.outlook.com (2603:10b6:610:c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Sun, 25 Sep
 2022 17:10:27 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%5]) with mapi id 15.20.5654.020; Sun, 25 Sep 2022
 17:10:27 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: pm8001: Replace one-element array with
 flexible-array member
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czbjqt1r.fsf@ca-mkp.ca.oracle.com>
References: <Yyy31OuBza1FJCXP@work>
Date:   Sun, 25 Sep 2022 13:10:25 -0400
In-Reply-To: <Yyy31OuBza1FJCXP@work> (Gustavo A. R. Silva's message of "Thu,
        22 Sep 2022 14:30:28 -0500")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB4891:EE_
X-MS-Office365-Filtering-Correlation-Id: afef5fa5-c10f-4592-33a7-08da9f18d7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Bg9+Na0H4KodYrP6Q4Zgz4mMDecbDkeGLHn06ch3u9UIvnDPE0Ooi/V11C6HvpCL8mU9F99AKozmFfTBInQrDQGQg6bpS8XFWg79g1pEH8hxm9yCKWLvM3sQWOzSUv4PllEOJsbW1vmNgzOPcj+JkCPdu+v1/GtlSGrSnAPG+dJFNHBEnLYi23Mxfoiwj//NudOS2jYhRV0e7TG+8zuMyqTNuMAwBuh/9axwKmZBpB6Y1pDucsZ3fI7ukEXnkpx0/kA5EJkhd7lgZ0qzxKxKdilZmQLNuXkKc83L9dzfI30qWTy05005NKbyanO+fFDC0nJ96oguv3IaWhe9WwJcKzn9O8/pRdWiLAP3P7ZzouB+SbAlieQ10b0nZVA6MunAclnSKZxfOTGcn3JghhxzeQRt9fFByyaQpq7kIM68PX9VFrHtylrPwi3TuL8A1GuYlOfBZNfZTgVs3JurSelOJLI41643WhC0fYtYR27ve1R4ugI0ruYnQSKfglMcD9qOvE4RADyqNkoX8ttP+jFHabtYziKO61T16OfuO9O1wOa5USjrbfyk4L72XryWpus3Ns7D2sbd/vnc61pWBrRQ+XI14+bG50t0+AlpGHPsSMbwxT4erpVZONDX1XiJ05oIvipDWg1+3PZB/b5zWL2BsweJ/Rxl78uQIZ3mWcGeDUyvJ4vvaTq9ZyM4mzHTI7I1mHXCTxnQlcCbm1M7d7rpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199015)(5660300002)(36916002)(86362001)(478600001)(2906002)(6506007)(26005)(6512007)(38100700002)(316002)(8936002)(4326008)(41300700001)(6486002)(66556008)(66946007)(66476007)(54906003)(6916009)(8676002)(186003)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wCxecsN6jytkDKWlIvGI40Pt4iL8l7T9TXH4DvhAvWz+g8gGZKTS0AuZLXhP?=
 =?us-ascii?Q?huaLaL+cLWUYVVnkE9Oo0zAo5XeXIuEAfAIHJGxFZpoR512coynKe3+NV5rS?=
 =?us-ascii?Q?g7xk1MDFOFS3Q85DHK4B4y1RRo4QKyXDFIiiz5NKjc5W06tSAet4Fg+GeyWU?=
 =?us-ascii?Q?JBmAtroixWSXBAMPjSiO4Jgv/zHgHLjQuxl3fofoe9IC7F+EOS6A5L0nZ5oZ?=
 =?us-ascii?Q?ldURQ6x1DW0xGPXuGP7kP629Y9J8bZ/jtTiuVoPHN7oiR/ROPsytKjURypJG?=
 =?us-ascii?Q?uBu9rYAorKR0zqjtPiE77ZdNWxc2y/ZKZcPx1vQ7HJSYSepP5M3ZiATjDdoi?=
 =?us-ascii?Q?PpqIbVHOmiOHUm1uncLj4GBLAoNltVipED0lrXVvqbutbJfm2KsoETlzipv4?=
 =?us-ascii?Q?BdlkkjYIishJq297E33e+hskiSj0gvdxrQW/+3q5+A3ibAw17hNTba1AhNNP?=
 =?us-ascii?Q?Q07+xm0DGL1MZjWuCl7yONWDVBr57G/ssFnQQ3r5Wv1GinYoTl0YN6kzjrPR?=
 =?us-ascii?Q?PHmWQgXLworBEuaUj/VjbMY99E2KzgWPt6XqM68vK/Kqi2CyTIjW0rKbnb1D?=
 =?us-ascii?Q?53o3mSehj1UTr8ChYwH/aMsvLRwaG4yJvoCfPZcfF5ZhGqM9CXsnWI+gorsb?=
 =?us-ascii?Q?w8avX451idK5pAj47em+ZIZbqaX6HIO1fv1nVW7UiAjPKuynSzhc6zfTQp1s?=
 =?us-ascii?Q?vQ8PtRpU76mlMNZ6Z2qWFkj53WOJJzsX/9eFTs7vDac3i8ZMwY6PlsURZx8x?=
 =?us-ascii?Q?sYPU4wRqRI4NvwAS5RV7eVJXFZtDC9qAu4y0e1rhBcnGAjKl5qtPtA1eCiER?=
 =?us-ascii?Q?QNS0+Dce1Aa8XzaVhZN5vRgPQMIwRnYPP6ORwsCal2pUJheJZpXvz0mi5jcF?=
 =?us-ascii?Q?fM3/mkbaa3xTgXss7iFfCe3/5NpLKeW4tzPJn+yi/fHLpIFOVLmvuNHkeaQi?=
 =?us-ascii?Q?RV7GG7PQ12HsQpdVi8AFiEGYMWAydsGeVvwId+leusdjA3I2APbU+bLWOOWM?=
 =?us-ascii?Q?e4h1aFRMYBciibiBcRkL4T74pdVFtm9SBOSavKfV/FeiIfHGYIe7T9OnfE+p?=
 =?us-ascii?Q?sBX5usFy0AL52fHjUM1lnxzlN3o5Z42nsJva4pIacsvhkJYFabvOkoYEP2Pf?=
 =?us-ascii?Q?jl3hHsfhPuAY6HiAvYo8a6nzBYpbt7vacxYV5qQv3E1t3aNB+fvW0IGSKYEo?=
 =?us-ascii?Q?0eYlGE7p1Ox4uwQSkpHcJ0kjMALJQxnTw6XRmdsytcrScqjiC3JCpQSde4Ro?=
 =?us-ascii?Q?ONaAaU0Zc1RdAdyR1AMqa10HXwvcz76pzbwvRqHjXmDO21Rt+fUUaLyUD4uC?=
 =?us-ascii?Q?e0mShn8RwcBKvHTKlTXe2QnMjA7QWe4kELpSzDLKI3cRj7Rq88HkuiweGsS6?=
 =?us-ascii?Q?EEzSWL8Rismr3w0T/OCyYgD8cGjTYM/Jn1ob/4cT6tbnaQ1HiEFIB+EOeOiV?=
 =?us-ascii?Q?a4JEZRE9gCUT7Pxal+1lVgeXis6m3CQUCcv0uupkEk3XGsTv8DaNF2Cx5B7W?=
 =?us-ascii?Q?NrDAQiBdD3s7obxoDbkR5jtPuqxTpTeIBB1pvmlQ/MDt0AJkt2mRDsIM80bf?=
 =?us-ascii?Q?Yx932do8MVJOCzbqXIXQK3xkHQTWLk/4N1f/KhMHi6tVE0SBdX8koCala+cg?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afef5fa5-c10f-4592-33a7-08da9f18d7dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 17:10:27.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPsV5AoVP6qnC/2Ii/kogsgoIR0nywkvr5hgBcVVTnclAGH+VnrCNU/PUWi4vQd50FwLc0XbTV7BeT5whPc/XTp0n6WYyFAI2pQu7vwj/7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4891
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-25_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=660 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209250125
X-Proofpoint-GUID: kBCQoSrtx74uL16oIAwv8NYKtWfx5KVk
X-Proofpoint-ORIG-GUID: kBCQoSrtx74uL16oIAwv8NYKtWfx5KVk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> One-element arrays are deprecated, and we are replacing them with
> flexible array members instead. So, replace one-element array with
> flexible-array member in struct fw_control_info.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
