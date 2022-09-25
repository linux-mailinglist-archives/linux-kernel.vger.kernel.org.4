Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598D15E94AA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiIYRI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiIYRIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:08:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EDA2D1D7;
        Sun, 25 Sep 2022 10:08:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28P8cmZo026635;
        Sun, 25 Sep 2022 17:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=BUdWxFfQUxZgcteqOPunmt0plXBbyJ4qAx8EXZpVhac=;
 b=nD6ALRRITqhO/g4xC6gB4Q65uH5JCkx4ik68uxOfAFVz+niozKMGntkAkqkCdaWoZj0S
 4wSodvQz42KoCBSBVNvOtqXYg8feivbxTiJ64ff0OdtTdWjqawfoA2/ku7BEKKjWuv6M
 tpDfwlbAg3IUv6tIG7e0dZjWTPwPRzI2dwgonKAFjTZWmdi1vitwCxEn/PKxNfq9sR7h
 jEF2F3s8/lxacHOWUU4meI2jA/zdzF89x98RXgrKSIKMJLWJG3k6JAGPhAVgqWG7gI4k
 IYwDH8bYwnCuPOhCbtpgJSeTX6txZDBkZU/eiAIl+No3iV7NPzXXnDVoykyzm46KogfY jQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstphxfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 17:08:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28PCIu0F019882;
        Sun, 25 Sep 2022 17:08:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvckct2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 17:08:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZeVlrHt7h70no2z0Ox/7UmXQJT3unSV16NmONivSEw6CMm6JWRRGIZRoUFASmMCrAp98LSJxVunD9YyF47EWVkSl+epTJWgc8LuyOWxMOC3CvWE7HjyRyytbWmOzy0i8EFzzjKYyi4pnacxzqtloF7C+9Nwy4sA1BSpgFDhQ4QR/ODYXjfvaU8shp/p32WNOmN3m6GFwKL+teoSjDL8e2qPqlyiL+z4ISEAkFRx4T/tIv9HXgunoXzwimqa51BMsEpF/BTiRZNWTt5K3Ksul69ThHBdt7QiauaDPH2sCs6zSY6QrQOiX1EkDlqAkfrSFYRQI65fHHECGJAuUe5lPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUdWxFfQUxZgcteqOPunmt0plXBbyJ4qAx8EXZpVhac=;
 b=hrLtVxeRe4GymQq/iDA1v6bkCtz8DC1heO/D5Ptb0O1seEQdkA1g1Jl8apEAP7moO5hsPjmNb815wC6t399KQ8ySrrYo/kGoVXemRUnXIMfcfS7QUAKwRpuzuqcbop09f/+zxT0y2UYg6FJ0IG44SVfGTERIelb67MLHhm6FO+y3dX1L0C74xIUTb3qDsszfKKJMZGYcVXkvj5JpIPVFP8SzreB5SVZR6U5jH+E4YxCOIHM9Sxv0Dwv/etjsTvbUQ/OzMx6/1aqVCP/5XmMrw10ocM5iT+lgkwXcITuSKupRvtTgtI8apFe/AHysttD2SGnq3nXBK36OigtzOoBRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUdWxFfQUxZgcteqOPunmt0plXBbyJ4qAx8EXZpVhac=;
 b=vgWO4aU0DuWc2/8ryfzTEnkW9ToTw2ILcjHdJeTwoax0r1KLHsLCR5uE358BhBSn8k0oo54CjwrPDeFErbo1k1LC9F5m0WM6YojrHtLaeMe6DcTFv5v5BVmaipO/xSxFuc4xtGUn14AdxIeolX+8C+Ii7uueDhdDhTrpXD7xuWg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB4891.namprd10.prod.outlook.com (2603:10b6:610:c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Sun, 25 Sep
 2022 17:08:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%5]) with mapi id 15.20.5654.020; Sun, 25 Sep 2022
 17:08:13 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: 3w-xxxx: Replace one-element array with
 flexible-array member
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1illbqt5l.fsf@ca-mkp.ca.oracle.com>
References: <YyyyvB30jnjRaw/F@work>
Date:   Sun, 25 Sep 2022 13:08:11 -0400
In-Reply-To: <YyyyvB30jnjRaw/F@work> (Gustavo A. R. Silva's message of "Thu,
        22 Sep 2022 14:08:44 -0500")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:806:27::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB4891:EE_
X-MS-Office365-Filtering-Correlation-Id: fab1fe45-6b1d-48b7-ded0-08da9f1887b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTM5n+FHmNVsYd7JbuPRu3eHfAQJbm92CCrfjeT8x8DNtHKTtTGOmm0SnF7q0NqCrzmwa1galXcGpiya0FcsqZ2zamawSo515NmtZljP6VZOpBwm5m1A9iQiFSkF6VIUhmVAlxqq9t2NVj2bv6qJBh4wEg2enV7yHaE5mEH5u5uybMGnr4ciz4lgkq8OMkK8reO1gG3e1UnsbQD5S6TxPIyw3Epe1+IJm+ymH+x8vUERWlFB/LhbFQKot66ae0+uv0PBm3Hd/EbnPxpYm3tWJbZU150NmZD5TDutUAiDeCbpx+RzgfORC/V4b3xxIEX+nnniSF23zBpy+JbP39tpJAVusRXE4zWni7gtw4w46dgALw6QjYJzAxIKleR9EQU54WjxggDX2svo+BC4h97b7S841C+yzmmE7Ai+eq2eeLd5Ry3EjQrKdepg++2UVaFzH559ytIFez3MDtd5O3MfG3/9EBShxRDSnxVzQGRojTi7zYJxKAGjY2KuWCwV8VfIbnARKugcSY6VdGjMJLauxoqxz3eESVn+UCrniDhpzkVJ0jYK/cJpSlfiJwTkTXNMY69oZJiGyDaTH0ylbJeJ5kGiySk78TPWDH05wz5lkqHnvUKboI94gh+B4xoTCzGPjNpe106nvu5Voi5WmqBa+mt3oEklSHMazw5EWhEvpLZB2S8AlVQCADW5R/OvQapl7OPycghhwaIH8Phpl9Vdog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199015)(5660300002)(36916002)(86362001)(478600001)(2906002)(6506007)(26005)(6512007)(38100700002)(316002)(8936002)(4744005)(4326008)(41300700001)(6486002)(66556008)(66946007)(66476007)(54906003)(6916009)(8676002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EVGrkCst2UdYTTYvXkBxMxRUr89Oosah9usZEGFUYwiT9lTEDnPuBKzqQ2UO?=
 =?us-ascii?Q?DbtQfdGg67LBXVKMAPTKvEimsia4x6RzNuBQdu3fDxRwBVRV7GA3ECOv+MKP?=
 =?us-ascii?Q?JUdm8f6oUZJYhbAGuUW9pL9wlWGcGN+nhJBtEHSYs+VE/MpObodm4zzmpDHp?=
 =?us-ascii?Q?wF7nw6gCv4rLG16E9V/79aZbszPyNO/0pR/fduFwamqHi4GRDdzOapmH9dfX?=
 =?us-ascii?Q?bGAH2/WHlZfSiRQ5t+Ujy7k63HBHfxMBMEmV3+fPpdiRf/NyHSkzuBjLOr8B?=
 =?us-ascii?Q?8noE05oZapDTS8b4yjB7mR6dWGbMMpFTfb6L1SX82bkkL09HvvWfqH+kh2x0?=
 =?us-ascii?Q?vxWXKoA2FEUJfL9I255/RZ6zeIlfTyO9Gbigu4t3BjldyR6XNx/yOIerESBB?=
 =?us-ascii?Q?+PRP6HBuy+A5PosR/jmg80KTKfSJ7+nPGAmRUZlfF5ELXFRZggcKOAV/b9qi?=
 =?us-ascii?Q?95pGUuMcvjiHOwWG8AlRwsytT3dABNvh35vcrwzfsIMmuqS2bWUzXFRPoFz2?=
 =?us-ascii?Q?lMjaNCP27A95VMmo5FO1zW4Q4PNywbg6wkr9WmzBddaTHIsZJ+McgUO9job5?=
 =?us-ascii?Q?RhZ18Ip0mBzIoZhWwhP3ExhW2GHlk4yxmR13w5s9+kyRQTO4MvfVGLv+VJa+?=
 =?us-ascii?Q?HNS5dKk4sjtofQQnqmwK81Y8TLNW/xstmZkfp5lhan9eAcLXk4qg3SyQ1C1D?=
 =?us-ascii?Q?tOzlX+/PCyjJeuNYK/sBL+RJWs3B3XJh7sm7lDzjjD5uZC6H1EkNe/hEJRf1?=
 =?us-ascii?Q?Ag8r6QZcXiLT+F69V1ry3xHOzsk4tNRPvjo6c+qgVANiLuuYyQyxsXm8sDjw?=
 =?us-ascii?Q?uTl+QwyVjigaHcLUerlyR4E61wIdxGdsHdH92qZrCQfs60ctoe8ytPoHvThc?=
 =?us-ascii?Q?koome648H02bDyhJTs3U4pXpSA1Uohm7q/6D9iq9sHg80ZWnycWmWRijBtg+?=
 =?us-ascii?Q?vcB4sWaRatcndPZauUb1e4A7VlSBGP1hx/kG+AeRALjr0//+lRCHnb4G8gg1?=
 =?us-ascii?Q?AWjFBs3kH7xQtuNOHTh+RdAxTk7zgTv2FCpBIX/mSLDct9HdNUPFdUnB+PG0?=
 =?us-ascii?Q?Pc+v6gVmHMz1uJL8af41wTDb8OGwuW2yBTWGbTo0iE5oV55cNyAY+HmbePoE?=
 =?us-ascii?Q?HYjSe+V2EWYqnllL4+kSNX0CnxjT+Ys6d9g/UBdlmvZnbMbPQpwA07CGzSLh?=
 =?us-ascii?Q?RXqbMa++/y5w2KGp0l79c3XuPJrHZIcAX7rgLj6kfF3QixaF4B1HXDTtG4kT?=
 =?us-ascii?Q?MhFyREDvP313+ln/rDdDwBmLF3uvo1AMVRV/igz422uG40+bL4FtlMDNQiq5?=
 =?us-ascii?Q?P44PbeLtxO12zbsJoYzkCbr48UCCVoVkQw5zP2gWQZw285XjWlakzObWivJE?=
 =?us-ascii?Q?d7Nh+SVZ8khif/6MM4E9kRN+EBx5JOBA6kq6POjcmE3i/4EEoN6QPhXZT+lX?=
 =?us-ascii?Q?oURs1v70SO9qTGh7VbinF5SOCfn6VYxz8JGwUbk/8dDJ/420LskqqanQ/YB9?=
 =?us-ascii?Q?DuqIWq5KRkHOzwnQVImMwpyHsADCKjDZBhKZrB0ixHALXniVhj/6PnxmhMXA?=
 =?us-ascii?Q?W0iVPyVpAqjF9v6LpMmVABgrumBv5Cr10ej1tKLCbT0NTo36PnFLEAFNEknB?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab1fe45-6b1d-48b7-ded0-08da9f1887b1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 17:08:13.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfTYcJTQIPBQK76vdaQpGiFxZWmKj9ObF0JvOpJ8auzw2Ytzzve9T8QpgFIblkPVKJSrtT2blJNHxrnKs39sCjJBR+OpsO3D4TK09414WFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4891
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-25_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=781 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209250125
X-Proofpoint-ORIG-GUID: RiFYBwjg5h-lECud_zQcbUWbEjzuRVE5
X-Proofpoint-GUID: RiFYBwjg5h-lECud_zQcbUWbEjzuRVE5
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
> flexible-array member in struct TAG_TW_New_Ioctl and refactor the rest
> of the code, accordingly.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
