Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05366672CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjARXkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjARXkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:40:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FAD62D30;
        Wed, 18 Jan 2023 15:40:14 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILmwmk016941;
        Wed, 18 Jan 2023 23:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=kBlytlZ21HuZnvYpGiEwlnBZlLESPd1HqEHW42gaiQ8=;
 b=m+cSTfEtkrSFV4u7JV/KstFnLP1XDuGFfmLZFgkbBDj4XGNxRpB1g+THK6draM8EDl+A
 ELEcPu2aVfgsK9O0LyzHDbNAjNfQVRF8bx1LJNKgL6GYl0GE9wdryJfT2lYn5yZTT6LW
 vHLYDH2UQDn7z9uPrg9fKP0TCYPaK30OnP7zc41eNjLAMFKG/flJWBcpPtNmRvVWueRi
 BzqU8Rh0f3jPkSLAtVFs0oaYB/nncZXuhfoF/qezD1vDk/NoMjRT54i8Vm4Syv9oiim8
 vyBWuYZ0UutobcqXTaSiNbkfNJXwXCC9bu6wSpbuWH6Z3mflJSYxWoX/XFkbbBz8R79p Xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaah0dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:39:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IMg7DK039640;
        Wed, 18 Jan 2023 23:39:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2tnb8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:39:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qxypbeq94IbliGOwUvbQEEhith/DW4jxITsU8Hod+i3GkTX9FGqV5NEB/+Y7OqI5agcO1Naj/Hc5Cd7z5yoKu+o88DXWXl9FsFxzLzHEry8sIU+YI7XCmD2gOmQrOzHj5WmjsK4vk7Tf0QFPM9yKnWq2c6hDO3OrZyob/Gf6d0563OUWqhvVO2GWaT5SeNneG2sAy7k4gKZ4pU00/aEBGZlGOrnpj5MMru4eZu/2mIg2KFbl1hqF4x9HnqD/tunsbsTRvLmLf0viZGmyogYSjeUINs+qOdlRXPVDtd+Xy+qDPU112wxhtrAhyrMXfC9XDRYJrSgmQffjM/2auwpM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBlytlZ21HuZnvYpGiEwlnBZlLESPd1HqEHW42gaiQ8=;
 b=ncG0RdEVZ5hOGTvWBqByfXe6wy6yA/kZV9Q9S4KvTxQNVXxy3UIRWxt2ikizYXDckt46PjOHM6eB10fJTHJgRZP6YJtqHRPkCyYYjXxwYgD5r0R5Byea8s3QdqT5obb/lPPrY+K8c/3h8/uMoGEhG9qwYSXUVrD3n4gLpV9TbsP6lS8sA89yzyC7stE6EZ+gDIyc2fGhEg5eT4t4eJMJvwSS2wSNIPUSf2ohAgsMYhzpxdDZcrqErGn9AvNVSWqguvOqhsaDiTnPcVSY7/Vv1Gh72weGLEqGuFucGvi9sPleAoOpqFKxO/DEUlRYmIe+FtuVpDxxI6wg5TT26gStWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBlytlZ21HuZnvYpGiEwlnBZlLESPd1HqEHW42gaiQ8=;
 b=tS91lupQrFUgCYDWECEOvNwt74vWbITIFII5UDs9c5XqxSHvmE+W0UnIsAIrLfD0QUo0cG8MG9UeGnURKdNhQHQ1QubXWxDyq5vX72BbCsyEC+ejjCn2tcI6jZs+6G7t5HkClOhfpqKhNOq6WGlOpfYHLGQm8QzATpSIHfuD/UI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB4212.namprd10.prod.outlook.com (2603:10b6:a03:200::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 23:39:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 23:39:55 +0000
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        it+linux-scsi@molgen.mpg.de, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: Demote log level for trace buffer
 allocation to info
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edrrpg3o.fsf@ca-mkp.ca.oracle.com>
References: <20230103150438.45922-1-pmenzel@molgen.mpg.de>
Date:   Wed, 18 Jan 2023 18:39:52 -0500
In-Reply-To: <20230103150438.45922-1-pmenzel@molgen.mpg.de> (Paul Menzel's
        message of "Tue, 3 Jan 2023 16:04:37 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:805:66::43) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BY5PR10MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: a9754efe-f671-47a7-f83c-08daf9ad4d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nZzCZh6IKo1Lepf+jDn0PI6uwQuT7oKdcVSH6REKl2AiwhwmmuSdFfNNXkpeVDOSwlXx77cVGHXmgiKOxFJLbMrCS6HzaLkzm2XzsHVSiV2e9IbJ3z4nfrsa3RjxOb0T1RaQA1ve8yOvzYKmT+FgmUNgKozl4N+odJJ7CA2aq1+k3U6U6AxmD0IudDc009OwhQ+OVfd+5B1uvv/KnvQNlG+XzSwSTr7u7cyBkIvEZOJfletvaTM1i2VGuGHhlqnZsWbwBWakyetkDMc8wwcRY8xV0nrybd+K9ueE3VbhzR62cyDXbhKCQuCqUI3amqtctVO9Uf+B1k7GR4vBMADDe4yi/HuVtYFEWETfKM62zH3UTms5CN1yzO5ZojzqG5Nacez3WRVfA+Ejnouk7hj+rZwRNkiQDxCUCsItRobDXgxYmcA46Kd0IxhaC7iq1OhKvVV3ApRgejvkaEPkit196Wjmn1WweTfTRQMW+3oinsewrUvyqw+1KKs77tGYZNBbHodG/XfbvFNezNzni1WhyF093AVrLdJvfcgqDG4Cu3qOPjNOlLK9sS3JcmAiEt3JR33jXcsk9smcs9/OcLl3cyZRyFK8QozY341P6eg2OFBNVyXf3nE4X8sR316y6e+CXonVimbZoUqo3fk2GbvidMDF83SV8qjbcSz4vF6QMg9L2NwTSZSPAKJO+9yOhdN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(83380400001)(5660300002)(8936002)(41300700001)(4744005)(6916009)(8676002)(4326008)(66556008)(86362001)(2906002)(66946007)(66476007)(38100700002)(6486002)(36916002)(6666004)(6506007)(54906003)(26005)(478600001)(6512007)(186003)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3y20cDlED8M/A67wV0w+isp9AVaZO7LlF8sLhnaxCqIx3J9AuNDsu6cq1h2c?=
 =?us-ascii?Q?leokQuwx176QK9LqdCnBgTkro8pAq+UgFGkjcJ/hTpepHiwDpzCby5CbNjbj?=
 =?us-ascii?Q?sskMyhuTYw6Js2eJ+biZs7eVTgdP+Z12ZFPYnvHi5e3JShaEcqZvDBIpNmCI?=
 =?us-ascii?Q?2irRvdKBro+1rFfK8uot0pfvIguw3zet/HL9oTgRyl49vc5dnr1YSnuF+kCs?=
 =?us-ascii?Q?iRoNxXaThgVrw3/CUGCPZFWF1oPAfYpCHRem9e3kbZPQ4kI1XCQOtSaN8Hzt?=
 =?us-ascii?Q?Beind1UzqfO7fnj7bWs/4rsdZv5K80PEtY11/qEEVCrcFQVaJ1zPcoVcepGL?=
 =?us-ascii?Q?B8y+VrP6Mfq1XctFc9UP726iJv358CwPEoY3Ai036gAkTEt64C2trjv0aiWU?=
 =?us-ascii?Q?v95bJyM183LBJghY30pxK071n60eekikMJoTZyKj59JlBo6ZamE+gbcKYkiz?=
 =?us-ascii?Q?G/mcYWbn93DMrX+YDR//1QWVZ+3+5JuaPCcoYY6YkVCxmrHJwOP6Pc6oszGq?=
 =?us-ascii?Q?qbgJQhoXtWTooHV88utGQHVaGTadBSxa9dt9k8YaWHYNKbSBP3ylxAk2YClE?=
 =?us-ascii?Q?zawNVlgMPA+GBkAXDPvR0U3wDk45JCAHNqRiTUqnh6EO9p0OcOps5xCmH4o/?=
 =?us-ascii?Q?qBs7yAb/htVoJc7cl3EKI0I5jgx1GDt+oeOANcYXxveQRkickHcVTAi80Zn3?=
 =?us-ascii?Q?Sd/uqKVJVIAqfMOSyzGG6nVQCG2MXHEiR3zj6wzoPbL/r/wb4xIN72kmpD/1?=
 =?us-ascii?Q?Izk8l2/m7LUqoO702ZXP4uSBGNZY2Iuk2uFcKx0WiivxROtG96M3Ifl8G5wB?=
 =?us-ascii?Q?vg2pNA4qC/1rKFNEz0YXhAGiNMfOMqqqV6x4sCJLkxEpegw9XkRNBIwGYfel?=
 =?us-ascii?Q?GaXVhRBnh8PMq/oxmVjuWUscMmsUwzGTwtk9dY1uMnZ8eFg3b7R1Rk8YDyHG?=
 =?us-ascii?Q?I+CQOn+HtC8/Q+Bc7ghnVgd2kGSbZsq53HV6V6Qsd9VjNke5YJR5Yz1+D1iD?=
 =?us-ascii?Q?x6Kn/cLyUqpAM+BhnSff8Lj1xCyK+33+yanYXE9NzpxSDQsUjzNV9P+pF9tV?=
 =?us-ascii?Q?YlIsCp4Vvqv/fz8oVVU6dWBLDQka12L+1AXtGAfVC/EtdZD7jCzDSUgC7oPz?=
 =?us-ascii?Q?+IdueBZ5iWDyxgnOCq/jKYKQBlXk0N2VvD1Hw78UlMx9U0obq6MIz4OPHCDK?=
 =?us-ascii?Q?svnQeWbb7hhhWS5CKEPIvzyLk0mHpHycdj8IuOfnmv7LEJxRbPJCcig2kJbJ?=
 =?us-ascii?Q?dG/UDsALJi6CxGqJj71X7NWmQqOmLfxlTrF9Lc1XLwqnU1/vGNjz4HDE5SLf?=
 =?us-ascii?Q?6AT6mgbua+kLh/SLp4ZWKRMoCchMrMgBqAYgRrfGppKa8+symgiC9C2i1kyt?=
 =?us-ascii?Q?wlJ/IEPQFLYGWxk4amLsj2pwqfPKypcTXu8+NPytLJSFKrMtBSjNS1ewM2so?=
 =?us-ascii?Q?k1Md5iJDOvyYBLXlkMpYDLIDGpH/ZjxNp4x6AisSe6elfJW6CPOJZuAsqXST?=
 =?us-ascii?Q?x920xjcC8e18lFUFNfsnaGqdZzsq9Sl21fP8/9sawMw2LvW0M3/A+C+VgahS?=
 =?us-ascii?Q?46PEuBhdTM5Lhi0o5UbF2JiKNp0H7luV0JA5yX+aQi+er2Ee8xPZDIseIa2Z?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0XDr8wcfJGomnxexmhn0FxF7MnDZEBmJqAlKPJz+FqWu2fK1UOySN3prxrlH1+BEFQuy6tjAiKtZzNBD8pb9mXKQSroxE0abK3ajR5EL4z4OWh2m3smhaMxLINKoM3Q9QqeSWMrL5cCgrmxTJJeR6Ujxs5hE5dHtCNx7ZpBdWg3zvov805wq3OPHBdtUI2Q74cC7qIs5g/2wduuvK16B3wY8zm0W/V3dkUCHehVtC5UjEFqlLKmae0o1ifwe1MJEXRr3sSayUS4Xk8r70bgLUfbZcCHccCezZGjP4xx+TF8sryoywfZQUKNT2a970j5ueyl6bsXhaZ1+/UGHF99BdSYFSoJQKfVg9nUrGmInVQVRc+NDv6wDtIVNSWQyzn9oUn4a0JJ/41fhB03zSpjjWL69LA4vUCgiN2FiVd+svA2+QCr0fF7PpURRduV2ZkSUSg3tjRG720DHQ1TSZej9cKgMP0fl+sKais6wbvxORx6hpxR8siUZlgQGHmA5Yi0YjL17QvKGE5HU/lJPZqS2DkKifelS97NhHfkOLBEjBEVYc9EzgiNxEb0XPkigMpXOosXh/j+nrv1tdaSappV/FM37GnlRnUBFMgnQS6KRv63LnFQrSzIl57mRYcpmgOXkGpF+79G+DMHSeZ/P0GCcLQRr3SajKLsTNbU+TNAa75A7B2J7nDR9ZwqXipANG+HktJ0wBPdVQPBq60zKXxAufLFcH7n278JmeLbQkWAQ918DTs8ju+jEUP3tlWwMi9b4/laAF9TaP+dh+Vc0ezZlBQCohryv1++F0W0odmk3A5vvfUExiFQoBH7OV4vUu0795BADf0TlxTrUMWMyWGue9Vk7wS7ImB7UlO2NWlBz6GsuAK0njHwA34hcVc6Bm+Nw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9754efe-f671-47a7-f83c-08daf9ad4d65
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 23:39:55.1876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNveXVxmJqp5ztHozzHLdcv2tkoT1PHrCqOdG2wu9Yqg67Kt0uyQmHOigIiqTHWdDO0O2oXpT+PRFrSCYoV4Gk6La1OhQ0ChZQ/hivBkq5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=912
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180196
X-Proofpoint-GUID: M0jiN03Bsdj82if_M4SuHsUdjC_E7-O1
X-Proofpoint-ORIG-GUID: M0jiN03Bsdj82if_M4SuHsUdjC_E7-O1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,

> Linux logs the error below:
>
>     $ dmesg --level=err | grep mpt
>     [    7.647675] mpt3sas_cm0: Trace buffer memory 2048 KB allocated
>
> This state does not denote an error condition (and also no warning),
> so demote the level from error to info.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
