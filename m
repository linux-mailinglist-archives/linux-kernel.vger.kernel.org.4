Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535745BA429
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIPBzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIPBzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:55:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820F713F6D;
        Thu, 15 Sep 2022 18:55:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FNnFqp013537;
        Fri, 16 Sep 2022 01:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=SnHO15QjOnEElQWEUsZN8hidkT/LrbviWDzTQBrQn3M=;
 b=XHNi0Swpa7iQIJJK5uh7PpRTPqYb3l1Zp8KpK3hXc5ILr9+loLr95n4Iz9cHZq6uOeel
 eewZzP6NbtqVVxJtEMlEh2W+StP9fKI+n5NLTRnVxvd9qbGHQ+pfJ+/HReQZVDgy2M8P
 bnbOVCLx77b/BXtHUKtTnBhn2leC/HvpTQ94k5kOhcUo+pljUxeL6Fhip7h42DOfJ388
 eswVfk3AxNfQE5i4BMVq74stsSFjfVRbKM6szBbrrGjazTqzPUO0EvHlvJLl8Uf1DaWw
 SmATWf6DnpnPQeeWMSNafeYhJ5iO+Hq5K+iTwyDJ1LUBQeLNY+yGdxCWS+33njarJz80 HA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xbs5v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 01:54:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28G04PIu019689;
        Fri, 16 Sep 2022 01:54:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8xfdgv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 01:54:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIKwAWnhrHlSH+f1rr9JnT1WUUSDfV3b4aIPY7WkX25UZ6TjPBr4r/ZEw3Uj+F0cqMbL7B2dSaaYcarjqIQnxoEo8lPJUGPvgm++S4Q1DNSn9mcBWBf5h9hssHu2YcViYDfKam8HXHwOfhvB2KbmvmZBAoQrKVliwrl6xRcMyVI+frroEWxzA2f8t+fR/APUMBK3gpPAENWD9Md4EErrCaQ4hLzkqkG2YaPxrjEq8zsazwVAPUtNW0NKJPUhKnluoH8LsP62RGaipWM4tOAyFnact7CecY6DJromua+crTCLa2R8x5VP9maW8RShjZw5RAh05lC+JppEP5FzichVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnHO15QjOnEElQWEUsZN8hidkT/LrbviWDzTQBrQn3M=;
 b=fwlvz09ZBDlrTjzxU1fxJtCJK7D3bs8vU0DczWak9TgHHWjaFmK3Q7SwASKWt7NZBUc7Mo1826/HxrlohyQqBXbxXqW2MTcg5V2myN+EwZxuHmNTtc45jpiCFA7s9BhjlsBilUC++2ZmcAPNg5BgmgGlwihZO4ZvXRjCiql1KvfZkgiV3c1UjoiJOhVd+4s8ZROzwQHplIu7+zPkgLCH8eW/ukEFdQSS8AyLRJy28giuyANtRyHWfEDZg2qbCgaaCjTyhNRCmYez7frPiNKJ4oZWk9prdUk2J9vm+imGJZl2bKuFZ4W6LsWPqiOsqRn+/lk3n+f7Sg0A9HNLzzokWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnHO15QjOnEElQWEUsZN8hidkT/LrbviWDzTQBrQn3M=;
 b=tRvD4a7vMXAIcyTnMix3l39l5wXtN0/ElVLuHy9tE116O/rKoH7mjnSqZNkOUajsU6DtgPcgT+273fAQuYjiLlxAX9v7M0ZhOuP2ere+OAus/kDE2ZKRsZKz/AT6MDJZgI8S8KhSyAorIaq+UD10Z46U9l4InKdTh9x5zgxvBto=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB6013.namprd10.prod.outlook.com (2603:10b6:8:ae::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.19; Fri, 16 Sep 2022 01:54:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75%3]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 01:54:53 +0000
To:     SEO HOYOUNG <hy50.seo@samsung.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com
Subject: Re: [PATCH v2] scsi: ufs: add a variant operation in struct
 ufs_hba_variant_ops
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czbw2ihu.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220913075407epcas2p1075426e0ef45b6969e50823d59c374d3@epcas2p1.samsung.com>
        <20220912193703.102267-1-hy50.seo@samsung.com>
Date:   Thu, 15 Sep 2022 21:54:50 -0400
In-Reply-To: <20220912193703.102267-1-hy50.seo@samsung.com> (SEO HOYOUNG's
        message of "Tue, 13 Sep 2022 04:37:03 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad6e104-2d77-40b2-f068-08da978672ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFR4INiSlVOPf2rv/+Hg3+tbD05wwKhOQQL4hKgdeaP+XwfjtmXAZ8LK7aCJFUiZkLX/l95XagaDrBaatYDXKeqPAcY81ny07ik1MwgHDGL4S7+3kM3ttCrBaqmKHTS6Ah0WuY4RKze+xzKLgCCNRHwD7FAs9aWYhFxsCO/8xwH+Mjk2HJMoLTM8JCp/tpkMea6/ZC2l7RYyxFEt7w17Rah9KAOYNhNsEpT1i3kTRjOBtYfCYtQ9A/KYQT3qAie/gFp5AcJF+cqzPgYvECfBR9FLnGBHzk4NaIRP2YpPEAGgMM8kAwJzrePqFNvd0gYb+6X6x8Dpa5ArnEfdMQ8XkUCbmb+Mmc8eYZMO6ErgN2Z4aoD4KITUfBIil0Tzq4gzFi6tf60AhS8i9SeRuxkS46iwqqrOOkO7Ty9FS6H/fjPxgF+oNxMFc+lscOE6apUyMIwYwAFrsWHdUFsbJ2k7OGJDuE1D0uVhp4BWBUsoczvKqIoccszNjI+ZrBomKJ+ZyyhcKn4rtwQ4Tpa9op3dHyh8sWNZnFOG30nMs2y/dHLkIv0y1Urq9EadqxWBnUJR8KaVhJclLkO4tk+G4RNU1n/mp1uXkQA/1F/4E0eHx52fK34445Gi5VklmePc8cub4VEaHNiSFJuQJ5u2KwaGzJIee1KlbF8UOL4Wrow2POutUePM/JtKrYcuqxyIJosloamQXbSPCQYFRp67p8HRnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(478600001)(558084003)(7416002)(2906002)(316002)(86362001)(36916002)(66946007)(8676002)(8936002)(6506007)(4326008)(6512007)(66556008)(66476007)(6486002)(6916009)(38100700002)(26005)(41300700001)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xy38+C6Mv0HGy6SsmwP8KvxEZIChBNC6rx/jg7y9gUqVaM3g7lnYd/JPk9c/?=
 =?us-ascii?Q?49OAIinxe+6Q65YbKYmijUh7sTjuoNjIzsDyyzQ2NSvpz2gWYPJjg1KvSj9k?=
 =?us-ascii?Q?aY9K+WOKjd5nnp+nGyHyuwuKdup2PouQp+p8mNe+pXuNlxHCg+AG3uYDharO?=
 =?us-ascii?Q?rjGO8Yb+bay2R4KwFdlygxD7wkzn9PLAErgUw3jUH8SNdhb0FqafhbnfzhlL?=
 =?us-ascii?Q?Hn6deaSt76H9uYyswf/PWHdPMrm5/tG8qHF6aoZlMSItPy2G8NCC84hW8DqX?=
 =?us-ascii?Q?4Mxb8tXQZTZDH6JYsNPtm8IhqlnD+lfzoNGzwIi8hKjoV6SI1ULCY4eSfFeX?=
 =?us-ascii?Q?3UaJOF5/29juSrg2l/MLECSR8IqYumSG6OtCEgiHqnCRXK/scUYc2cPNTg1H?=
 =?us-ascii?Q?2Go1gDX9vtzpSzUJU0qJtG32MMXXKRsvhTctRgONuCs8OWVPNJOVXa5/ZrK5?=
 =?us-ascii?Q?YIu8YA9s36iEY6wrUYNbyKr8y58BsHdkx3JNAW2xWAEfpEk/M+a4O2z/3tfu?=
 =?us-ascii?Q?hx7gze4GZuUELSpYDNWZZYwM3E6OgaHUuOoig8CLNZDHBsAfF97uNSEh/D9T?=
 =?us-ascii?Q?NhQ1oOzLey1Q194MfBjRuSB0bHbuSI9mSthdcEO1s0aRVviMCFd3eTblr14G?=
 =?us-ascii?Q?X2PH/BV+lv6KxP9+/3zASw7H3cLziUAn+M72o5fBqtdifsQ7Fs5KkPTrhhiM?=
 =?us-ascii?Q?rNHknn5JPFWefLPtn59joHmPeP99nZdPfEXsf2UOAkK1tYMQgTg4zwuRKZGN?=
 =?us-ascii?Q?Hefl9zwBcOMJkPkO3NmkU94b5WmddA8rlmwlWoDFYBJ8RhGx0P7JzTuivhyQ?=
 =?us-ascii?Q?aGsmF2Pk8MoqNh6XC9rtYVjqOvgZ1QLYymxAGRdLMDnXPEPWgbKFC8kxokqJ?=
 =?us-ascii?Q?s/bZ/33dxlzjJ5ceKfIjsAqtBbsboBHvZ+qxkJxRe6u/flaD90jNpIBw2WY4?=
 =?us-ascii?Q?9skeaFA7m2EjKeOMMcml9bDH32IxWxhrZztMo6z++b1zePjMopgxnAv8Y+U/?=
 =?us-ascii?Q?hiIwyq55Km2OmkBx7tXoAZJjc3FPhRe0hQl4wNBPSg1oc5j+Y/KNBXaMl9HP?=
 =?us-ascii?Q?GhghPxgqJdx7KbZkcwDcPdKNh2Ul3/IDsgJLrhDK3VrfbNKN6cP/V4DOaFmQ?=
 =?us-ascii?Q?8AcNul33mF2NxQv0zXeHDb0cRK+KK1dn3+iKeNKMoY1XHgY0E9m+eORMNQxE?=
 =?us-ascii?Q?QTkVRVwcDDn2kW+6htVSZDVofS4lLRZuigGiYJyHOZduuI4oegO9vEU/sS4S?=
 =?us-ascii?Q?Ueep2jLfPGRQ1+ZZOZzHb2bdxZSAJXmLNakXaV+nQRYf2SqSDf3mvs5+k8CA?=
 =?us-ascii?Q?hia5KKLS1aicyrcySsTh5AdVuq0lDzP/IgYyw939D2sI48eC2cMWVa7yG4gs?=
 =?us-ascii?Q?TC8XKmchVbk8fz2hJHgng8iEhbNq5Nobz+4zvjwKodpJ2hqZ7xBmzxCfJBlX?=
 =?us-ascii?Q?fq0h3P+C0El4VodDYy73DB+gtTmTmHRRwCsZFzUwa66kjgICF+r/MEnEytxu?=
 =?us-ascii?Q?wvB/Y58Ls4R1jHnAd8l6jZA40k+xAUkWD8H/PNHoB/jxj6PdwFFRBTpI12yt?=
 =?us-ascii?Q?gIBo5Dqux11bGqwnNaiZJ0YU84mBpbtEnas7vTc0eM1A+EHTVOwpTxLrAW6p?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad6e104-2d77-40b2-f068-08da978672ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 01:54:53.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl02DApuEmgtEqCpltUa1cjXQ1pWy3Tk/LiEkhifwzhmhGvaIIoERZHRWn+DIk2ayg3bpNyF8XJJGrZvdK1OQdjODw+1nwyEEwrgfo9e0Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160012
X-Proofpoint-GUID: BoMFt60prbkgWwYckY5ych4yNYf-BxED
X-Proofpoint-ORIG-GUID: BoMFt60prbkgWwYckY5ych4yNYf-BxED
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Seo,

> +static inline void ufshcd_vops_check_int_error(struct ufs_hba *hba,
> +					       bool *queue_eh_work)
> +{
> +	if (hba->vops & hba->vops->check_int_error)

Uhm?

> +		hba->vops->check_int_error(hba, queue_eh_work);
> +}
> +

-- 
Martin K. Petersen	Oracle Linux Engineering
