Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDECB639385
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 03:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiKZC7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 21:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiKZC7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 21:59:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F77205C9;
        Fri, 25 Nov 2022 18:59:21 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQ2PTIg016987;
        Sat, 26 Nov 2022 02:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Re2L6tze7or1CPZdN2JcPEnjFLtZlQx+j6pt7cu/uIQ=;
 b=txJqhJmMY+c9bYZ1oHx8YsCTPXzcgabWGCGIMGfPfLqoNI8OlB3tP/XDlJA/9bM6RWWC
 Acp6+7Z5exKNxS9NND/ellqxpv8iJDzxm+LP4rN+GGhnSAezLdE5tMfqyW5KKm3rQ2s3
 U4vCqXtpglgbAwIwjCVgJDcev+3IHIPS5llm6NtVYqiHhbJ94UIJvV4Y0Pns2yWrtR94
 RHWiZulUAfMArPLtlf+1VD6DXm38x6Fmzpn4uRioX14ND4xQHYiTOzEFztw/zELW0SjX
 YaAQBzzk03WItOBb5ZIevqPE8SBkbuS9UlyIKW2yvBwQSisl0Q1LPJqeOHf8D1YgaECG Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3a0hg0ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 02:59:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AQ1XsLO009370;
        Sat, 26 Nov 2022 02:59:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3988a8dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 02:59:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0c8GZ+60IFWiqDFgYJyFxlHRdVXDwp2kf7OfDEYqEjCF9bxXzQFzM1zrBPqqd0FOsGKuaXIcCN+FwhXqSBq6eH6F3UeghQqgL6XaOZ/BYzgX5PngW8LAUNiKjg3gPXqexwuNxpJeVk+3Fsp/yyR4qd4xs4bzK/XYgEsKpwVR7qOGnZmpDugPuQLHaLSxp6hzfpCNbIozZy5+A4o0wgJKmFV5evfbtjJrrF2NKoQ7RwqVWyA2vR5FCrYSe8qY4Iz7C1391qAAG377xohVli8bPNCXp6q5h7UV9G4RlyjsNUIKDBmuCHj0MSookUUgapFgX9CilpduD1UBpDzP18yvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re2L6tze7or1CPZdN2JcPEnjFLtZlQx+j6pt7cu/uIQ=;
 b=YfVXuFW2Lzryb9sU4IDWu0Y4KycGymohXyWFiYNpgDKFhz7veiF7cEL3aro6M0aPdea37fmWKKpPdk7V2rAeTIfTCPF7Bp7MwCzm9KiNCR6Q+Iz4ZcnEERhcD6XXN85wisuu6beDY5ZpwYGmYZMSrr5WIuHMJSO06owWbRgMdw8vJK7mFZVj/GOxo+Z8Oaql3gn4heVm++mMfmv1inRQn910hxHTq+jw2mKDO6Rxc+ISbFaNFxf+CjfLEZE9/qLzMPuPHf+LSiGgAPu7jnwo6GkIpTQzH6cNqU3RsldO8urIJEamCZFvsZIlUTER6Asq36OXEQGKs00cMY3PPAkaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re2L6tze7or1CPZdN2JcPEnjFLtZlQx+j6pt7cu/uIQ=;
 b=isiFo3H1KCecwwNFZVGondzndPBwpHnpxTxWgEr15fFQhYFD8qbsTm/mjjd+ILHjTLtNwaTXYQpceFBbqFfa2jF7geJGXvf1xohYNB4VeWayciIpYf07/XUFgxjSuVFunFU/4XL3KX/9gvV/RGwD7XCkjhbqedBT86fnitCUqmA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN7PR10MB7075.namprd10.prod.outlook.com (2603:10b6:806:34f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 26 Nov
 2022 02:59:12 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 02:59:12 +0000
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Subject: Re: [PATCH v2] scsi: megaraid_sas: fix some spelling mistakes in
 comment
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilj2mney.fsf@ca-mkp.ca.oracle.com>
References: <20221124092514.32032-1-yuzhe@nfschina.com>
        <20221125020703.22216-1-yuzhe@nfschina.com>
Date:   Fri, 25 Nov 2022 21:59:09 -0500
In-Reply-To: <20221125020703.22216-1-yuzhe@nfschina.com> (Yu Zhe's message of
        "Fri, 25 Nov 2022 10:07:03 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:805:106::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN7PR10MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: de37e539-d91a-4e42-511b-08dacf5a31ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YsJml0O/d3TfX+YilVRA7CT7gJg+15WLWS88xQyxQI+lWlqHPHYRkiU2rQJuH5ElTkJ+kxHJc8y7C0vrRclln8ZH03zp321qWONXKwqA9c3qFgiSRMd5W+IP8taBt3iX69p9uEtsDorApMYTMUoKqEWGPPivqn104Nhd3vSP+oV/zZ+WApA8ecYN7bgcEjQ6ebT2Zg/6sOKyqrpGq/PtH9vCiYHTzltpLnXX1xnxOd6bl/0/nTNPJ8OFN+OEjUjBu1r9eXSlL/9jgpPj3iXLI7ZwzsqngyK+Tmdp96eEkcNugoWWb2MecE1EM3GOe/gqVM6j03uXQPiPeUIfYgJe5JUTgjGA1Oks51F0+VNzuYBlIF3ZtG34V5FloKEgd35oUkVypUgcDFZxvQfCyUvb4CpOgq+39T7kRacOGoh+hBozhBlA09AuIc5wvZK2NUz661v5e8p/sVNPcw0dctav1vcoketmidNAU6WOkDZFrEDedC8d/WImvyhQq36ovNEX5YkrkTmRi4LJ9VFwykgVV7Oi6C2gpd7ifXuUI40iS+NNl+F3jV+BIHacnycqMCoRLDLuN7IZuWPGctccsUghBi2seEeCXA7gcErCwVJpFFvpQ3ZBPJrgQT0JI/qFiS3D/cf2I6MhABvK8urPFH5mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(186003)(36916002)(6666004)(6486002)(478600001)(6506007)(26005)(6512007)(41300700001)(6916009)(2906002)(316002)(66556008)(66476007)(66946007)(4326008)(86362001)(38100700002)(8676002)(8936002)(7416002)(5660300002)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wzS8aZzTWp+Amvr2W0IoMsNRduWz7KACcJu+JVQtNmCDDSwT+x69KGV3h7na?=
 =?us-ascii?Q?1byY0t4A2RvDYfoapnkrQMoCU4tBmJISskyM5CN+f2vZnlMCl4SSwhwELNTG?=
 =?us-ascii?Q?pWfmyUg3Rz+vynrhKZSiC5DynRpZZUAKOpiUArmwdDekmjXOZug5PHbxclj9?=
 =?us-ascii?Q?00kiQCp3Q3wL2cotnaB8xnDRKR+MQb1hSEHMzVXHNADMzJh0YCxn1zmNs3uU?=
 =?us-ascii?Q?oOoCkcP0NNSLGOn16toNWippAPkZ4UQJDRk+UYZM6oNUPqYSlTMJ0V9O6Nq9?=
 =?us-ascii?Q?79Q6IpnbFh3ApiyeBh3ajEEqEL5nKWPaqozgCtSbzyn8KRATbRFkHLwc7Il1?=
 =?us-ascii?Q?TF+08aX0rRKTiDAFrmSNCREKQJjTDEw80ZkQPB1BDn9UFqPLK+J3Mw7ReDfV?=
 =?us-ascii?Q?3Y2a0lN457+km5qoeptkjntFBrZbm+Cw6JwxMWOBoEMPUQkXQXhtO2Dzc+bH?=
 =?us-ascii?Q?dD0H/l9PHMw5JQ9+mhC7XVcu+Qynmw1y2TeXAIz9Ghz019s1ayJa8JducTH6?=
 =?us-ascii?Q?bInpa9CeGtqSqrR/HlnJQFC3/YkqBs09vl894GIE46vPDftq4/0t1GBh9gs/?=
 =?us-ascii?Q?fwwcEkFKZRaQUNXC5ctbtHUSFq9+hOzGB1h+Hadz+wkNz44qF8tXfrS+xkFL?=
 =?us-ascii?Q?wEgysFlkoY2iw7bx3Sw2w46Mk66yn+jD3uiwKj94pKafuqlUvqrFcLmr8Lsi?=
 =?us-ascii?Q?Oc5XuKzWAilBr24iVOVOf6LyebgghyYlsMPyLa2s4PI9eZeCu7O9dmZ64dTq?=
 =?us-ascii?Q?tQKMxzjlk+IZQRLFj+S/zg9kdsVrVzF15Tpt6V78EJlAcL206M/xqe5Md9/E?=
 =?us-ascii?Q?AGuyU6lqsGRfAjlfeNA/e5ssD4hd4Jl+H7TT0eV8x8f4YvaRGpuSEVrkZNjL?=
 =?us-ascii?Q?N62THq5PNi6wJbflO1Tc3imfqcMhNL5/b0uDqbtd4qOIePVJFe1A2teri/LH?=
 =?us-ascii?Q?X/otexefPmlfv/L5cV7ws/pWJZp0IYdqwiC62QdzfYPtO7SumZ/eC0DTqAJw?=
 =?us-ascii?Q?GwyW40KMoTNsX3a9xFUEh3ezZ8j37lUqa98XvrNnBVM+RNTSQld7cxxCc3mR?=
 =?us-ascii?Q?0Zw20aX3E3kjE2cvlDPuv7ZSamxRzzJkmixODn+3mL+a4UhA9PuOjtnXA7IG?=
 =?us-ascii?Q?K4q3nfaqaGq+ovzSbVEYjwq6FqV23aSB/XU4sxX2O2+kFPEFIDfLZiL0iFm+?=
 =?us-ascii?Q?qgv10mi+b3N69irhPYrD5weibdWldBOMrDdRU4FEGrQzwVHMoeOEefe26Wc9?=
 =?us-ascii?Q?s/4Pr+1Ggv1JK/SRlC3bqD9cvUkJ+7+MRydNSctXVnkH8uQYrY9eqOr90qA8?=
 =?us-ascii?Q?RH3ymmqGFtXlD3LNI7tNuNlKkVEDhMboGFAHzD1rUs+NrBE+v7CvnTPYHXCa?=
 =?us-ascii?Q?wvozcJ7JQDuJGjMnlA38Y8eqXc84FUnuqY5v2HPiFtFFCBuIqkTcTheJAj6g?=
 =?us-ascii?Q?5az3mGJNklWnb5BZpxFUkYwKhi1EaF7rSPBdVhU3VuJHZoaaD8N7CM8hwf28?=
 =?us-ascii?Q?9H9p9Q9bVNIMhKYFpcF9AJtdDLk8T3peeoAVht8hHGTVdhyn6JAZMitYCieu?=
 =?us-ascii?Q?bDm5cW8Oj87vX4MIvPp9Hshs47hVeKEYJSVUe38E1yP0ty2Mq0GGEyRHgqtd?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xs44QXp+OIp0Hg40QNA67DH+Z5NexadgKBK0pezMl0xTiXT5Xl67Cj+//gtD?=
 =?us-ascii?Q?exxnr/4WEwGr5eeVajC/37DSfzqPK9T0I+i78FLXIukRW8pNtKMgJtT1rPIA?=
 =?us-ascii?Q?tVxiRonszay0bC9W5dYS+eJIhWDPZ9moiN7uu+9VO7VWxcm7ycUWrXIGgp2N?=
 =?us-ascii?Q?wwC1n1Pi71jNxcIj8BpbBELdoOFePYVPbiV/qjZNhG1rbyzN5ikMa8tI7Dzx?=
 =?us-ascii?Q?KxXmtUBOYHMvt6tUAs0ekLpeIpoZwLUYBW13HVoPj836DEHdqqFwKkkXx8JN?=
 =?us-ascii?Q?57YTYJW8dqhcVxOR9uto/8hmcBN6HrRBN8JzFgEhmY2pP/DVNUwf2Sz84a+X?=
 =?us-ascii?Q?Hmf3pVynoZDiQ5bI8vNgl9HRPqyRbHmeUsk+x3f79+AL8Zz/03rbB8e8xMj5?=
 =?us-ascii?Q?mTYOcHx8LWGLf3uQ6t+qFFOAWDTAhAx8fuhNtg8/XtxfIR1TtrUjg2wKbS83?=
 =?us-ascii?Q?jOeuulbnFnMZ2RB7is08ZjnecRPcb42Q4iIlFCnwlIqpVOt1BuLN5fESKpPB?=
 =?us-ascii?Q?hZEHUvntIdok2n1Oao6GWuPNZK6r/rrMQYzp7Mn6LBFKqz3Qo11QncE+qptX?=
 =?us-ascii?Q?PDC7IUtWvpLDlIbe3IjeN6/JxNqrsVx0+XzMZ8pfffW8odNJEUv5M6JJBk/T?=
 =?us-ascii?Q?FeVDEj3N6z+TGgVXkEfnnywkVxYEBx2A8fcNUnJZm/iLHjT7WzDZzW9Ra6k0?=
 =?us-ascii?Q?+U7BVzD/lRFhBR85LGL9ZioWbLbJYxY2lvqG079RwDloh5H/bQEehooYWQW4?=
 =?us-ascii?Q?VWODKRgc/u44+K2RkT2+f45WHcQaaZ8lVEmSZfBgeQwVZErQoxgQ0z2xDSv9?=
 =?us-ascii?Q?0/EMzwN0E4dp3J0fVghhzYV5hHc6urkJ6hlOTc0ukZOlBRxaIcc8zXDPKCnj?=
 =?us-ascii?Q?jg4JQEvkvvieI1Me7lCJrPXWpwRVvPD5PJjT7Yph/aWy74xDREzkt9kGYnNw?=
 =?us-ascii?Q?kO5suBVw5gMnkQ601y8U3Pa7c5GPa97AZdyq5EXVdMw29I+rdHjdEaLiYvYd?=
 =?us-ascii?Q?GQEsdCl2rbjJGCylHjo64crwBInURRem0zw5VQJe5X0wSAfHgvdMDWh31Htu?=
 =?us-ascii?Q?MRkOB3sd+mzohwDvIwW7120fzC/egw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de37e539-d91a-4e42-511b-08dacf5a31ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 02:59:12.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIYdnp2ApFb0/LRCqY0nx0dzvV4owkaf+TMB7ZfMKMQmhHOCeA/gVSibp9D5g9Um95gqFJOSjyOkP1oSr53KLLfcsP7qRnP5MONz7pyesMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=863
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211260021
X-Proofpoint-GUID: Q33sh9sGi-qW3-ceDmBM6qFsxzVxd5i3
X-Proofpoint-ORIG-GUID: Q33sh9sGi-qW3-ceDmBM6qFsxzVxd5i3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yu,

> Fix typos in comment.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
