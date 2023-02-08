Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4144C68FB77
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBHXqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjBHXq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:46:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B331C32B;
        Wed,  8 Feb 2023 15:46:17 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318KwvO8010929;
        Wed, 8 Feb 2023 23:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=z71PJj6LQ/99s+2k74zSKMrj4wbjXblyqblI2cySuYY=;
 b=SkMobS/Y9gyI/qYxW6HZTvjCeysGc4sacqKej94RPS+NjsWwFAsZ2V8VwmVsnIyGSiyi
 5gpn32ohgMVIGvw41kJzYnkIOd44l95Xp+npPQ+wTv6DOAnIs9wDlaao0tZwW/BaFs00
 aMtsvZxzamdHF+G427tQs2Tl+60j0h84haG7L0A9V2t8YGlVByT+wNES+/UjAzgZkuVl
 KZ8nZokm7Nx0fS764McieIz2c7rribaGPqIpy4zsRTNb1iNCN1ojsdUmPobMoQw2+zDH
 aK6MMRoWsCy2RluefRSy0SWdxCqZKWRmsPATmE6p/rgybtvv3TGNEC/NmI/g1Mp2Gqh9 0A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdsjmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:45:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 318MxFYQ036311;
        Wed, 8 Feb 2023 23:45:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtf0jw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:45:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjMP3BQAwYjKjWENv6TL/kvvbvdA4iIIlxXtVWf8bOpdte8d09h0McwV1d9uGtNxQevvkIvPuEpOVx3TSlAnJsfQ5JERXj1oPEqpRcqAphBoc5JvWL5XDHrN4h1Y6zp5tHzFX0s3XSg4WpHYYoYzBsBtfXPmoaOXCNcxfEQef6NKuPr9UYLuHeOdiJNuPuXLaDJlwUCawmRCikT6CKFJeo9+9ecXmoi4uDD+uIpAghKsIJOCbK+iVsmT7c3E+aotCUPDZnWmmB8bSbYDy2vbUHFNjQM2J5QIKoxmKzAFu6XvyUOjA4Mtvi9Obe1Ctt06u5mIaRWfqfsqGS83zGtiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z71PJj6LQ/99s+2k74zSKMrj4wbjXblyqblI2cySuYY=;
 b=SlRSvZWieZJwYNKX2uuanjJvBdwEqhv8it+2zsfJwrAFtDjh6yigDWW4ytIqJxyE2Z4lBmZFEwHSlfddIMucBdz/e2Ln0LoY+LNisi0lOnmwE/3r5DBpbAKkeZniRp2SsCOZGQ97x2Mry0SC3/iWVQvpUwR61OcZXC6kOOrCW7mixNUmyBUGT98MNu4saNXD+dexjj0tAAK94zun7FdHxpdOLq6uOQeYWNKjrmgdbhNN1andvtEGN4TDq7gD0ViUkhqXSjAvbjtW1djwLxDxC48smzZoxjoWdtNk37thEw+du3iA5wnDBQdxSWyheKR5MZBN37os6Rl+rtRcYjdPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z71PJj6LQ/99s+2k74zSKMrj4wbjXblyqblI2cySuYY=;
 b=NVatG+HuEguotn9nmSL5EbuFjotdyNwSZ1r/yW3515NMHvCASssC59/3QfznFq48L3sBA7LJQ0YVKLcCKXHAOsTwZc7kKE9YogJQkdjfDS4qlvqT+U3V6cafmLJvYfg+P/K7nQAxaIkNQJMavWkHWDruhepRgJuST5tddxBwOhU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB6219.namprd10.prod.outlook.com (2603:10b6:208:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 23:45:53 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%4]) with mapi id 15.20.6086.018; Wed, 8 Feb 2023
 23:45:53 +0000
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mani@kernel.org>
Subject: Re: [PATCH] scsi: ufs: core: Limit DMA alignment check
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkm3zpp8.fsf@ca-mkp.ca.oracle.com>
References: <20230201034917.1902330-1-quic_bjorande@quicinc.com>
Date:   Wed, 08 Feb 2023 18:45:49 -0500
In-Reply-To: <20230201034917.1902330-1-quic_bjorande@quicinc.com> (Bjorn
        Andersson's message of "Tue, 31 Jan 2023 19:49:17 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db020c6-f372-4b03-8d99-08db0a2e9d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9P3XLx/rguJbUETFyw7z4izRp7PKSCqCR9fB3XKE5SLQcSGPbrOItfWAVhsRyFdBkC7zctIQKGCifhYhBze4j+W83fAMlXhqfM1MI40OvIIZwvHY/4oDlU1GcyeDEpOgV8ihv9h3reySFS+UFap9abX/J85ItB0O9Kwq5HOKxaoUFXumcUtShatyPK8tIgmI3E+iGBplDoXLAdYbXApPOXsYraaWsnDXe9blliUXhRVhPCWNG380X2wVGT2eh2qEho15pwTTpNWj3y1S5WPrDSi9d6vVq/2dZ8vda2tw68LZtfRMorE8y+TCe9sTNQAdK5vP2fHNmMrb2bsxXFGwi3j3qZeJR0s1sS0jguOv3TG66/8e+UWKz4uyDlKQyX7pSvmIZcMwU55oaa/gQeyhF/Uy0AngV1DLmz0YRMRskJ+ptc9PrDx0l2MBLL9leKg23kTUYMPHJsR0IiBGEFPapmt1MwI1eLcefzdlXVjSojJJfJg2eNINmZ1C4QfTvCqyE0onAIx8OZ66BpF3aD56IhjUaJClgOgzpcNHuov0XBlI5hdqTEIdHy6w2IHGo0KsPnlT/fT9YVPCEbCkBw4JqbPzu0yjVs9uaGlzfsnAj4nTvQ7wSiJVxxfazBSyzZ/GfiBFhtq5/zjD6EMmyAhdjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199018)(316002)(54906003)(558084003)(36916002)(186003)(6512007)(26005)(6506007)(6486002)(6666004)(478600001)(8936002)(38100700002)(2906002)(7416002)(86362001)(5660300002)(66946007)(66556008)(66476007)(41300700001)(8676002)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QRey84M+V7n83BktzWRpC5iT9bx8dvXwTE7aqQtKVwsOkRM6BIASh/VD2E5G?=
 =?us-ascii?Q?/Kwmc0EjShjPlo/WL6RK2jmfnf894q03qxyim6u0046vPGo1KsmZQBODl69n?=
 =?us-ascii?Q?hrCMi8ONYDwjW8SNawfu2NjxrDKjzv+B3R4AnVYu1O6ZGQ/PDM9QxQa0pfSG?=
 =?us-ascii?Q?GdsXUC5OU5Eyfj4MoPhDXhGpak5fAA0opnFrwvwk7xmFtPZdWRZYYHlfdAOS?=
 =?us-ascii?Q?IKSeXte0/JrCZ8tox1HHvNsH8JspcLtN0XL6SJwKsR56L1j0Ys2Dw8p31j4p?=
 =?us-ascii?Q?onwIX3FX8W4PxTbjLjq8FtSBO5GR6lwUU/xg/lNIA4TPOmtTkB7UBzICGbuD?=
 =?us-ascii?Q?Gn0JwryGtOyD4S2Y3SviPLq6VthXUG7Ed1hKQ+7r+TvshrbgS0qnh7b5o6h5?=
 =?us-ascii?Q?G/77LXohpjVSewlCBn/7p97fJM4jY990130jWmQvBMC4Qk51YiGcMDQ1ROtM?=
 =?us-ascii?Q?wtKx13JbUse9PMBa1z2w6vTzX3S1lPDSG9/xZiLHAldox8ldWx6cd1iI/jUg?=
 =?us-ascii?Q?yGviwjVtjyrqhJ2fZpGHeA8cVKODVrmJ/rb6EPLc7EbFy6qXJ99ZBNftoOV2?=
 =?us-ascii?Q?NtvvsP333eV2orZJhmYEOOdlxtzeUHInrCdyuFEwXW0bm5zZHtfpDyeonuRt?=
 =?us-ascii?Q?MFvLon+S7CrsV/qtpTRT8Hm2fzaejdLEKIuABRiJIzCbL2UxMnHNWcV2OW/8?=
 =?us-ascii?Q?CECuRmA7RY4+JH+wnjU+Zk/K/YjY8WLwEhjL2/nwDpPHYZEdR5OZahs/rLhl?=
 =?us-ascii?Q?m/6J0rEYus5gHr2lVuZ2hgERIeU25zUKu8/Yqn5hh4vurgC3epZR+5cf2XbM?=
 =?us-ascii?Q?PjvEYIPfXyvX3vAij5iqNcKFRtoFKQVWOLxYPK0vh6KNohgSLZEibjr2SWsK?=
 =?us-ascii?Q?CypeukajeK5Qf8nJEPRn3j/hpRGsqLN1Sje5L0DhYQyUKU8SIkoQgHqvOb/5?=
 =?us-ascii?Q?WYNhM0HBJPG4KvLWLMp2LUZMcDJFDvrXK3hkwTzpbFcjof8gWfYhZMCTmO+8?=
 =?us-ascii?Q?X2K/95GqVE/kePK1ME2ardGyvr213oAP0p4VL4iBwr1/qXHN9ZIkz2yBttSR?=
 =?us-ascii?Q?upV9FQibB4Df6RPwACvax+wGCqOF+JPOVrPTmv6R/pOceUHheoMm92h7CFKB?=
 =?us-ascii?Q?q+r0KPxwzbKkSjCRcvs80CgoBlpDzaR+Urbl6WVTHfucWX3OPL5e22L6aSFg?=
 =?us-ascii?Q?m1qy2FlVh7lDCy/5nD54qse9vMhdXNJng40sK/fuD8DsT1wiIxuzO1quau7z?=
 =?us-ascii?Q?Toml99KQyjY5dMFypBu1gBSMwmBMc4HzXpZDwhzWjW1ZtF5/49xKBxQywGO8?=
 =?us-ascii?Q?B5xTDAtk1exui6rmvvNzRrWLFA/YA6j+fAIOXESFX26YNZAQCRqewXcUJCqW?=
 =?us-ascii?Q?NFSSbx3po0T8wHIQcG0EEC+mMYdiCZHSOv4VnLgXfu+QF4CtxYnMFUaxS8pY?=
 =?us-ascii?Q?GnAajcED6k81dTuy7VnLZFcDBvu2rvCa1omu5w1DzmtXq1WtKQ0jJoDvJt8e?=
 =?us-ascii?Q?6W6xSbzUngn1JlYvUNo8Zx6+VN9YjGQ6CW33wibLC0LKSk/89cBSb1sZBgo6?=
 =?us-ascii?Q?xg1Kw+KYQEn6OaQxBLHXiu/9JA+S3Ta41JWHZiH3ErvbvzztCWE4KjsTTQGe?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?C2Ys8tEMV589FSbh2avVzjXPnYNlqEGVTwZhEc7tT40Aq/wtOaMjr0MTuaDE?=
 =?us-ascii?Q?lIkPjBp9X49VF5PVZmg538yhUOKUC4VkVF+QUWdYds9f2mgKBro4wBR7HtnA?=
 =?us-ascii?Q?08hH7upJMm53AJZFXkFagrD3onBsWOL3pe/GrBfZmT+YLIJ5VIjazKTg1kGL?=
 =?us-ascii?Q?ZFOAMt8vGmk2LTMHTtJchfaZL9NMFO7GEELkWZxnfJpfNAAh7EorJgmxM36v?=
 =?us-ascii?Q?zjz+Sn7e3DRSEo2c7pbcy++w9Wd1UuUjVuWcu5uzU0g5h3OeUvx5tNWRKV4C?=
 =?us-ascii?Q?1hlNb+8z4jE0SoswDalJ+/2S+7929FvEKVBDqk+LmKpizrCjU3RaFtvAGbX9?=
 =?us-ascii?Q?zxTqAnm9Jw4RLJ3dVUDHrMB1L45bHNJQFiDCT0fhenc2Q1o6USaL5uHD748y?=
 =?us-ascii?Q?R9+ojkmq52lrJNwF3CdARaODY62KNtqV4hWa86sz8UBoWLj9AYYQRGqJqYOP?=
 =?us-ascii?Q?EBeNESjMj7+c1ebSoOIQpjf3YOGKtdFQ84KkUe/W+vgm1AUVn95e4y4pmcVt?=
 =?us-ascii?Q?o0NGELp08kA3vqNboJHVCZ4hCGzRZ2FQguYOmtsa6SWMeqdDjmf6OY2Pxp3F?=
 =?us-ascii?Q?CDPHiX9znvAklEfsKTRiK0SiO52hCclS8rSB++e+TUJWgFZ0EAbhLNTq0vQs?=
 =?us-ascii?Q?qX536390YieyqWWIRH47eB3jdOS/tKfTFiB42YC7y9yvAjERyAU3IiBX8EVJ?=
 =?us-ascii?Q?kzz/XVv26tUrt5+ayId6jU5jdn45K+qOa7j/6sjImfafca8KJRrEFShgly9d?=
 =?us-ascii?Q?CkeLH4M0MRzJTN4Wum3vjkO3dq1SCAiwP49k3N0Bd4CdpUZ25RTpKYvaW6AR?=
 =?us-ascii?Q?Js0t0/7ZU3ww2Djg+rH/DD07LiysQffmfzbzG+fvPGuh3tJFNykzLQZhNFhx?=
 =?us-ascii?Q?8Xc1c6tDErjtOqEZ4C8mCmb6vAs2c9/PnTXcbXbcthijtvMuHjYbpxb1exBD?=
 =?us-ascii?Q?8K4JOLRmfKys3CSSwziIAqHqoMXQihoioqiRMLvJWsVZy6ZEEs+L+YNbq5XS?=
 =?us-ascii?Q?g7gN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db020c6-f372-4b03-8d99-08db0a2e9d54
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 23:45:52.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgdqqjMAhWdYuX7aLSaRyaWzJy8pD6/2o6oERutLLvSs1o8GJTjrYF/uA/X32QxHoLMIJzZFm0KS2oD22855A9/l2lYEKD9OPv8CV0K/6uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_10,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=925
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080201
X-Proofpoint-ORIG-GUID: MBOTznLSoXLP9hlnn0I7ldp5SJ-WTy8M
X-Proofpoint-GUID: MBOTznLSoXLP9hlnn0I7ldp5SJ-WTy8M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bjorn,

> The three DMA memory regions allocated for the host memory space is
> documented to require alignment of 128, 1024 and 1024 respectively,
> but the returned address is checked for PAGE_SIZE alignment.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
