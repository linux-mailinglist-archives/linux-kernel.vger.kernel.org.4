Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546045F1BA6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJAJ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJAJ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:59:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B3EFA256;
        Sat,  1 Oct 2022 02:59:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2913CSpr008408;
        Sat, 1 Oct 2022 09:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=x3+DvA4ZSOjQ94wDne9ZQIeW08Ug3IirjFiyvEQy5g4=;
 b=yE8UTzmeIKN01VZyyVXJMzvxrd9UAwpBaZhe2fmheU98U/qXj2nsNCVXYU3p7y93YpGA
 lvyyxTLFerGXmojgVcvhm6EeVTbVryxLrUst07ZPgxovw+rztqvTPxO58gUJTvAX84ts
 Dg3Kd5WLRYni+RLSwAjvYTmV1iDdebhTTAl5ZVAsbTpf3kyfF8IdrQtXv9/fhXS16ALN
 4nFPKq/bjlg4S+RVScjTevRysLAV7wGKAVlKLREcfpLpQNrnIb11RnK7N0e4yeJS4Ptx
 70rqgQvKPjUdm5c9HUrwW6wnK4u4Q2A5mzl/uEV9f8PBlOr9IoP4J+nV9xo2FqxkJ434 dQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdea0e0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 09:58:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29198LrM003505;
        Sat, 1 Oct 2022 09:58:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc07pp0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 09:58:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iA2/HrX27P+L36hB/jk/eNvaKjGiHjju17RqTkRF6/xtpJp/eGmRkoKmUJAwXhA2kLpRnto7lORsqGUWlZFrGt3uW3BU7+BRBueEAJosnZY6YCZ3M1J22Bee+EwCuN8x8xZu8Oh28BDsLuAIw+dPlA1czUFNsfOtp7JF96FPn/tQQJKHrCl+iXi1mmq2CZ3jEN6H4qbWIBR1heLnwjE3khy+vLGELQHGA2OPNRbFtX47YdjKCw3GNc1rtyDfLXP0IlzHqMOb9TqDvPrXrmzUKXoiS/Lx0x5xGDZjHPqrZd9sAjOamrpe/zlpEpbmUFdgG6hVuECLOC6dPlG+5NvZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3+DvA4ZSOjQ94wDne9ZQIeW08Ug3IirjFiyvEQy5g4=;
 b=oWd75mX+pZdLdPTHjM2b/eIP7TLsNTd0r2J9S+c1ATUDvovSMoW/KKBVdA7JDH7Az5vfkXlduvVcAZ5u5myhsQhR6C4yt0eHKl9JHCXUuzevGryi3jI5xgkv2DKYSueBlU8DYHAl4Y9eNspavS3qtSIujIH6ex6if8sNv+FpSChN4RQmCNgp/e31hFT6m0wqIlAVjYx982/ZBf4jK5oxhgjQUBU0nzdPAHH4GL+MfxGV5TpYLmdF5T6yB0J+LlrqcS1SE/7PsGtQ8YRH9XlYmAuoQfrjgvjUD7qtwbGGj5zuqI2ifDGD1H5MlhmYRiptCnQpxLWg30KfzHfVeIK30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3+DvA4ZSOjQ94wDne9ZQIeW08Ug3IirjFiyvEQy5g4=;
 b=oJZsRp5GTIenoYNreM2MA56RNKXrjFNO49+5JMT3nonq9p19X82S1RyWx0QqiKXimE28MjWNTvLQNRjjTgB9uQTwLnGWEHwxdT5GCF+RCehj41qFh30xSAVgWS4khvz1HCdKyCTXQsBEi3ToY7H5Is3Nm0k3lKI8d8cRVDDOrnc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6311.namprd10.prod.outlook.com (2603:10b6:510:1b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sat, 1 Oct
 2022 09:58:53 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%6]) with mapi id 15.20.5676.023; Sat, 1 Oct 2022
 09:58:53 +0000
To:     Markus Fuchs <mklntf@gmail.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: Remove unneeded casts from void *
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1tzj25q.fsf@ca-mkp.ca.oracle.com>
References: <20220928222241.131334-1-mklntf@gmail.com>
Date:   Sat, 01 Oct 2022 05:58:50 -0400
In-Reply-To: <20220928222241.131334-1-mklntf@gmail.com> (Markus Fuchs's
        message of "Thu, 29 Sep 2022 00:22:42 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:d3::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6138b1-bb98-46e8-8e48-08daa3938c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jV1lP0iA88mKS+R3kEn/NtpmLXZb64oFZx3Qn7QM+XipVpLQyZbW/tVipvleHCp+9VsSgjcpM13buDpUbBtG6YvrgSW6IWZJD9ZwMnJO4OLpgkvudsc20DABQLm5NQQNuTxlaQNHAOtyCOXBf6B8oi8BgGIER7XcXGEmKkWjemVZ8PcBHC9/gOomIKQsPwnATpWCIJqoMBE2jztA22KiQr/hIyloh7FJfbj/6L7XJq10VPvXd3c/8DjavakYSygGmfZt+5FuMhqSSyZ1kOVtlkSa1icjtshJpTpV9dEBxFkTmuQJTTJxedyHQpIsCW0kmyTLiAj2v5mxng4UdcK/6TJitAYz2L0eL9Rn1bk9+M0gHQ5gwF7riXEE8Noz6Om8Nh4KdxlUu9HHA4rrLV2/qrOVnXCjk+pMoqW/JjDgc7ezMY4KH7cwLR8FJbj45XuEEmAkf6xgu83ib1afR1D20Ty70dKx4LPcioJQs/3vFZ9qaboEkgMMslrrERWpcipcJcPxBtPVEYddXzHvSRauei9yquzBIT3szgws8ZwsXxpYIeSNipWlna8/e8DN33C8wjaLqvOqYoVk4WwO8VX/y9DKFbkmhYfbpRyZniXGAGIPogCruajsgb1jos1NqWJaDADpjf1lQbydPcPey3xeXMaFjbx3/kus+fOGUSbTO73l8L/NRXizTWZmOl+R60amVCdnl+8zIXElbLGVgGBLiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(6486002)(41300700001)(66556008)(66476007)(8676002)(66946007)(5660300002)(6916009)(86362001)(4326008)(38100700002)(558084003)(8936002)(316002)(6512007)(26005)(36916002)(186003)(2906002)(6506007)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O+kt8RwfSV1iHY8dQEm5TFbc3f7IZd6TgI+ufrvxH9qehKEiuPDsp+ow641L?=
 =?us-ascii?Q?LXYtE0JUQWBTeWYxe18shdplnrRr7hHpeFWtOduVc/gqZhydx/BlzcSG+Jgj?=
 =?us-ascii?Q?7vSW9qIdfgmHqZ222dw2oSk31C11pnHCUgo+UQ/m0Nwd/engiqqAiiD4PpBX?=
 =?us-ascii?Q?D8p8kBKmIcRL2043OCx/p2lkDRBGq6wzSIwT3P+oGb6c0b55NpSKKRD/cJxO?=
 =?us-ascii?Q?BzmE1TyaYVgxVWaVaL+X2tchHMDdzuLp9frCjUbVW/KQSI2F7C6ASFFQIDfA?=
 =?us-ascii?Q?OgXRXQ5bTKZd4LGOBPspdGBlI6zQ/zfL8mcAbOqrF2f1rxpW8j7fAdQuA8yM?=
 =?us-ascii?Q?W3gWvOxlX6rjCh5xfwN/ae+VTJcJjZu+60LkiRKlrTWUbxCkvRQbN056JmK6?=
 =?us-ascii?Q?QxdcO1N2g2u48gfesc4jFRw9JQKbkW4zl8gLW8Qm/0ANGtoFHVc7n2asICUU?=
 =?us-ascii?Q?bpdELWgnh68A0BAVBCNa0tkrRn/zGiIibbF/E1G9xIqKFHR+KvohpJ+18rNP?=
 =?us-ascii?Q?b/xKW/rOy5RtgEJvJMYMesw+P3t5Ba27t/TXMPuwC58igoQUWwiODrYS86oQ?=
 =?us-ascii?Q?JrbDokTO3fK07HPvVHsEGqErraQuig/pdjf48IZGCYoXjmhxs+IAGTri0gsV?=
 =?us-ascii?Q?LzEuF8M9BbHGmMFiUzB6m0h97hFL0wgfUQBrJMHvJTljWvU4EEatpL76lwiD?=
 =?us-ascii?Q?t+R1C1u8vo2T2bQopCqzQubKW7uupJ3iMdU1RKh9QmsvZaEdunE0VCp8imVP?=
 =?us-ascii?Q?4x5bym4T/z6mamkuhsCltPrAu291fu5J7wTyqqWmU9bZXCb9KzVaBzlqw5n3?=
 =?us-ascii?Q?RHZ+2Nvs6ditPF8rYf1xai5KtVjjMEawrWNVgHkNFxywxMzOV/R8RnbWaZxC?=
 =?us-ascii?Q?r726SIJn2mW4e+rwFc7c/vGfhMlP4DMxrb7zhjoJuN6SP4yy3joRlPZ4LJJF?=
 =?us-ascii?Q?nXBhUpACEYVSC2/5Xl+lZk9hktSmXdIzf4qvYqUY+txXhS+ItA5bMwapqccC?=
 =?us-ascii?Q?n+CofYRDbzzvWhzUsIONRzax3JOzt0f8cGYM4bumgLTFFdbbA0lQLQYIn+/4?=
 =?us-ascii?Q?DGN9qotwCubzJPWuxA2NUzY0WBzQAmnrG+4j37iSxRl5IB2vPZ50jVDJSxv1?=
 =?us-ascii?Q?qKWKFmC912fAxlzkhZcfIFUcyjv8tB2HLyXtqRmb97IflBHX0azKNL5KdQiD?=
 =?us-ascii?Q?zZIjRpip6gTOWDRe4HyjtKPpjJAYqI9seIHa2nTY1Vz4PHAnfazuxJRH/Muj?=
 =?us-ascii?Q?VXdfq1it9c9kXeq6Yl5/8A1Z7dWt8Ep6CRfvel3yxaBSEzhDtdpsCfRjrGc2?=
 =?us-ascii?Q?qaTohFYDv1YtvDwxIHwVCGIQv/4aWKAiOb95PGXGtLvFyns98s8hS8BzXOyF?=
 =?us-ascii?Q?WTyD+rYLbQVEwixiMeOPGRU4pDVY7zGKN20S+7HUjYDPIDhHOYrgq2u4vuXC?=
 =?us-ascii?Q?ezUqHA+fIoPmJjv/aPMJ4P+WuhRb5y363U0BJcq/UXAe3OIIT7TsbnQqwO7d?=
 =?us-ascii?Q?JAihxK6z7NXACgOL+HidqxywdSCwjx4/Ro368uDJKrrMJbi3fKi+fgy6N/Cy?=
 =?us-ascii?Q?vxF0uq41WDVqp0c5OFyfMOObo2mqgwvDVPPhsQj+lrG6BzYk6FVs+zJiTgl4?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6138b1-bb98-46e8-8e48-08daa3938c13
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 09:58:53.3832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0m1jYcXgNW3+pDHYw6nQYOe3h60sHwb4xbEEpyYP/ayG/HncFIeNNnFFIjHXraDZlALh16anK1cMSZmdGXBOVqxrlmNQ5rEEZW1ssi3Yu2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210010063
X-Proofpoint-GUID: 3o4jTodSqu2ShAJbjdCTb83Fuqaxgnin
X-Proofpoint-ORIG-GUID: 3o4jTodSqu2ShAJbjdCTb83Fuqaxgnin
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Markus,

> The end_io_data member of the "struct request" type has type "void *",
> so no cast is necessary.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
