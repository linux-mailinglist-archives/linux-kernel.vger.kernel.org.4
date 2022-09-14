Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0AC5B8AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiINOsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiINOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:47:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043B16B64A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:47:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDYV6l008391;
        Wed, 14 Sep 2022 14:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=EjZP+/dbXctNC1WGBhbTa/cB0cxfHRSxA4TfGqIXrhM=;
 b=s4mSJxibB/lGPsL9uinqsBIPtefTQgCSKlM7Nkci/qRjDcdL/Mv6Kk0IaN7GmDonglv6
 DltJo+9rHEVs/I5gUpBzFYn3B8dewGWbiBRsNNJOdKMbfh8cNG9gFB+sCUDpZ+UHKqi+
 YP1DIuM54Vr7A0Llxmt5bk/8WosJqm9h8tRK96Fms6RELPddwmacnClDLTVrDzhStsjy
 6QbiZiD+kOlmROE6JPybetw4O7wgWSvUpWEg4Sb0HGxb33TvPwBqIU812fj8Gyl553ES
 UC8fua4CtU++txiajiHMi8Xb5SxEeDdvSNMgCcyyNYMcADZDpzTdJzoLWJOQktF/oYW+ rA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxycaj4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 14:47:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDZcaH006552;
        Wed, 14 Sep 2022 14:47:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy2b1qb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 14:47:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFGEuHKSezySOd+5/8J8H3RYUq78zPTJfI6bFNtNQfl2LlxYe0nJZ2+yRKz24Vy0JvL5CMyvx4h76OIX0q0m2MOGSpOrZeuz0L4zQbab8npRX+7tx5i10sUL9n3Ia566t6Zu7rTOW3zY1nxA/9bjhip32GerrnPWvkfwf2Tv1u+NJAJs/d9HMLrjzvCHZQNVufhuvIdkcbT82BrS1Bpn4yHqCAoGBFyB00yUwgwhpC0yb5avMfiAj0eQUTsqn2HIkV3wm3ua/x/6diPkbeMfykCVD1xN92nTj45cDv+mbOYgOq1ntAr9U1wws7PVRytFhRktWn6IcyVXOm1fxbS2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjZP+/dbXctNC1WGBhbTa/cB0cxfHRSxA4TfGqIXrhM=;
 b=hdb4/wdabwCGUB+4ow0/kE6cWx2bhMNJJTgzld6KwmL4/EOokrlDs/l5U9BGn4ZhB/6/PMCUQ04wmrzWJlBLwRbaMjN/VLlSCxRlQTpILNZ0L+L/XhWCQRYt8I+YWc2JgGRgB+mmw2AeLx8z22ujqyXKUV5kdoVSSKknmwpZHZ/5ooyJfxtIbxp+Q0YdnikM6ena+dRvGqzBzNtmNp2QylVlKEs1no0SfhlegEqYRoatX7Bmh/IRYWYX4I5BCNkAEiWzDxisLq7pEOIPuXyHrWs6T/jDHTFt4Eks08qA+/L/MuEJrgUXfIPYG6jWzhjKQRJNpObhmdbNFh/4KT0YDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjZP+/dbXctNC1WGBhbTa/cB0cxfHRSxA4TfGqIXrhM=;
 b=z0OxZe1Mt2sZtWVoPxTAaNqZZgzfw8ucsPKg13OsG4t6sxP3W/XUzOgkhrEIJaRTabRvfnHWWvhxZyBWx9/L5xdihiEv9raW9u1AtFoULwdTsdOv42OAFIB0w2+PLpHbZBw2GJ9UUfsdVkhWWIWafRGeuixZBzUL8ybuSeCySB4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY8PR10MB6729.namprd10.prod.outlook.com
 (2603:10b6:930:94::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 14:47:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 14:47:49 +0000
Date:   Wed, 14 Sep 2022 17:47:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] staging: vt6655: Cleanup and rename function
 MACbSafeSoftwareReset
Message-ID: <YyHphle3DXIlIftH@kadam>
References: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
 <540a684266610f7618b3ef6000d4699d065c8e6f.1662890990.git.philipp.g.hortmann@gmail.com>
 <YyBXp9x1LnBkku2g@kadam>
 <9abac5a2-e070-501d-ceba-f227a081bd4b@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9abac5a2-e070-501d-ceba-f227a081bd4b@gmail.com>
X-ClientProxiedBy: MR2P264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::36) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CY8PR10MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: d200f108-2c2d-40f0-b9ef-08da96601852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5+VwAHxnE4SQ0XtpWaZ06af5JKpYrJGvu4zq/JhvvMOKK/j+IVdsR+mtPC+d68rGqy0GRhWA0G3Fnwh0GSGsywOAQXuGyXF3nuzNQ14dRLq7GEOSE1fPShEUT1d8/h0NOXdeCxh+ZhkAB4qcCfVeddKFzbbOp7o9lYk49U0uKqP25Jb8P383SI80RC2KDXx6Gs/Yq8iJ5tFXprJabldDR2eUJirb4Pvh3OrCKM2mCNV0v4oPMz5TG7dYerayC5XEWCTAcXn6bmWquJHXqmVTpRBhzYcPZEh4K0JY1Qpj7zdbeQflKa55be5rRldXnaIfDdwSHgxNd7P8adsOIP4zZM16H3YzDUq5g+Ohr3ZO61i+SVCmkijXE/mVX8Cu9a/C+0myOV2Z2GuLB4XXjpgvzu/6IckJGH4Buspooeg4rP+PE5NIGV1uubQWcYyFIDrKT4Gf4W1OUjLIVLmme0/HEj2CXJRn/bHMwGkPmAle5Qid1HaKrJ+czP9Yc9c+8OxtL+/1WJKDrixNytuPh4dGXERdrT6vAh5+cZRbz0fBHY8lIb5TU7uNLgU/r3/78opH9whi0ILKIL2JO2/4DDonfikWT+KFFQD6yBfKLLPodFWEURG8ZiSGp/z75taah5180wGrD5877x3tbYHjA4omfdpP9zI2LvuxiA2ylgXWq6vRI/tfM1m6dENniTVfU/dQC9MTL+eMXdF9nPJpeRWFwlWeuUCHFuCYZV/EOw+tyUHauT94hhAg56WKhhJhrlL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(7916004)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(4326008)(5660300002)(6916009)(66946007)(33716001)(6666004)(66556008)(38100700002)(8936002)(6486002)(8676002)(186003)(4744005)(9686003)(44832011)(41300700001)(66476007)(86362001)(26005)(316002)(478600001)(2906002)(54906003)(53546011)(6506007)(6512007)(145603002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AcFraK0AtlaHtRx8QtM1fUNJCQkQmO3BEzg5uhN+fr0jlYCdT4vXj8DpqNXw?=
 =?us-ascii?Q?FYPElrOQmNimRX/PnHs31HngBQgkSms3W5J2NxagrGV+EwHGpGAVPuSr0jCo?=
 =?us-ascii?Q?t8dg6GBGztCxdYu/v8RxPMGgt0SU9knQvT1i0r/iWmY1YJYklKXRRRmlFp4s?=
 =?us-ascii?Q?VbiLWwmCjLWpoqMhlyMDVQFpOsbvOOgihdcL9CCm1pRpykAqtgaEJCfnlP4i?=
 =?us-ascii?Q?v5eaKx2GKnEwGV4S3zzONeNjAU/auWP7NZSBJqXlFGtCiWsaWxkiFuSBOpjy?=
 =?us-ascii?Q?9lD7ngWYZr8C2Lc9Vvaj66FYKluQKMUC5N7/9LKswATX/he+Bm+IZmlPjFuP?=
 =?us-ascii?Q?1Pb5lj7tTj8sZZKo27BrR+7SlxoeQMehNUTZakuL3PA5wtlSst0+ZqJCCQ6D?=
 =?us-ascii?Q?eo/Lh6XtDW4HJMHvx44RF5OrEVfy2aqQ5CshQEiaFD6e40tjnibL035VF6TO?=
 =?us-ascii?Q?EKzaFsp80/rQSJ1B6QNGPiH5oEAcsv038xmOjwfYDLkg8qvp4gvAMWAee3aw?=
 =?us-ascii?Q?ZssbRXE7r2/Ssh6N3MlKQWDA+K1mMLglwDl8/6uxzISromhv3h8pMY+zyb+I?=
 =?us-ascii?Q?jfUwER2hzGLFwKyorX3U/Oi1zxRx77PuINqQHeChikEypEPso9MtPZtOV3hd?=
 =?us-ascii?Q?ov7KhZBOVFWz8vPufTq9a8uGuRfsYs9fP2a2CxmsA46u+aurtx0bwaM6Csht?=
 =?us-ascii?Q?XKgkeuv1vAtwQw0zYw2NJmDecY9LHWGtzn0wAmw5YDCst1/rFUJ07JVRAjq2?=
 =?us-ascii?Q?f9HC+6Jh5FAHPaS5wqWn5oK5Yk9jq7T36w5+RJlQiIdplX5ZGljjmJYJ8hv9?=
 =?us-ascii?Q?6pEQ+IjjEmiVk15334FWFPl5+MzChHNuODjT9Gll+0IVvO4MZ7CBa12doFxy?=
 =?us-ascii?Q?24C9yZNRXE6eJvPakArG1T9d62zR03kB2EXvctCUUfrWhjH8UHJUzFQM4oTW?=
 =?us-ascii?Q?Ig0KPY5nK0RCwTg7+YcpQ/8V3GiEx3VNqL3vs0tTCjuxnfhkmitYs0DL8nm3?=
 =?us-ascii?Q?Ksgx31nWL8bTI9FeI2R1Ule8E4I+QqyZ1UGvZNLZ9smQ0In8I/6lwazsOFa2?=
 =?us-ascii?Q?UCEgfeZmm/CwbyGV1DbvAmlqpDzjH/R2dAelwhc3GdbzUoLmvQkarGrsPR9H?=
 =?us-ascii?Q?iZHxrc1VeF8BbZKwXU1TUgu9UDdv5k96agJ+iloABU7ICRdqtYzMHpemq+Sr?=
 =?us-ascii?Q?E1Oh+uYtYxmuKpWHPIcREW7QphDj5zWPDCMhXAW2guCWrRX0jSlsuAnNccOE?=
 =?us-ascii?Q?l+3B4wpCi+Kog6ZlNybF7VAPTdOov1ieQxO67L1HMnjAHraRGJllfc6cDoga?=
 =?us-ascii?Q?4UWp7XXCbKHJBy9T1Kl031lGunOWD09TV8uPezpTWdya5dM0vv+WYLpenfvd?=
 =?us-ascii?Q?8SAK5erg94CakqubSlVcuNVmVQqHSG7NKPCV3gws0XZO3FPJTJHLr0OedCiv?=
 =?us-ascii?Q?Cqzn698E8dcATn45opZJeYEVYRye8qhF9jY9aFfeXEU7cH1kREWSENd5cFMK?=
 =?us-ascii?Q?oGB7NZnlokwWqqOgrBvGbHgelqp7m7FUbZTcpziZhcC3dbDleTvnbWioX1kb?=
 =?us-ascii?Q?JbEdtBNyWEgda3iTn6Kbs4XIbUEn0WyQUznSX11l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d200f108-2c2d-40f0-b9ef-08da96601852
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 14:47:49.7479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAKOYBNPDwju3ghxMuSBzWbsNFE6GdUY/NgQx4tuGaJApPPmTY1d0lFqsXcg2jj144EPdeKBcgnmXrayv5DgYirXoVS9tn3i2VtS5x8wYcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=528
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140071
X-Proofpoint-ORIG-GUID: StC_EnpmtRHnsSOrIxWqNPpyZLftz9d3
X-Proofpoint-GUID: StC_EnpmtRHnsSOrIxWqNPpyZLftz9d3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 08:26:04PM +0200, Philipp Hortmann wrote:
> On 9/13/22 12:12, Dan Carpenter wrote:
> > On Sun, Sep 11, 2022 at 12:46:04PM +0200, Philipp Hortmann wrote:
> > > Rename function MACbSafeSoftwareReset to vt6655_mac_save_soft_reset and
> > > abyTmpRegData to tmp_reg_data to avoid CamelCase which is not accepted by
> > > checkpatch.pl. Remove return value bRetVal as it is unused by the calling
> > > functions.
> > Please don't mix this kind of stuff into a patch like this.
> > 
> 
> In the past Greg let me know that I used to many patches for a change in the
> same lines of code and that it would be easier for him to review when less
> patches do the same.
> 

It's some kind of an art to write patches that are easy to review...

regards,
dan carpenter

