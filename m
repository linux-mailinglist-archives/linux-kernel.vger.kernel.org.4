Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C92D6D3BBF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 04:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjDCCQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 22:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjDCCQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 22:16:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04708B754;
        Sun,  2 Apr 2023 19:16:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332MALaE015180;
        Mon, 3 Apr 2023 02:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=mYLwk+1ZZp0CqdT2gUagUMlXO7oAJIjaz6RJgYGwlvs=;
 b=EWv6ToxNRvLKfaLDaqdIJSANQVptuD7JwU2ApSvzftlpB3B9S+xtuGo49uEpjOGzlXLF
 wwbaCbjWXyWZ9wojBuvKf4MNxz7pNSkFNb/27YZ3hvDZ6MJWq7hHGuvzCF1b/si4fcMa
 NiSk6xCUjjHPSa9zdHHhChUq64CWu/k/a2czNTtV3bPR0x5pcc5WNe5Ztc+j74fmsXVw
 hroVNE5L6gkniOQ9F2jsKUhjxKNE6aikPpJaFiMD4mzHn7hisR20XXTRYn8SA2jQNPKY
 y+EFTuYO6Up5vk7qw9K1l+A/bNhgY6asBquTcODdsBgJ2e5In7NGAaICJz4rccpJSPTm nA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcgaj01v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 02:16:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 332MoJxD027839;
        Mon, 3 Apr 2023 02:16:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptumcmvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 02:16:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDq6+tQ5RRIkPDOBv8Dt8LIrwHtkCGpfHnpjecdIhgCYrxapJsunXl62/a7dt1NwRmtDrbS1Ihgc/vB376Oso0aN0H1V+8r/s983yVR4NNVDw7LnkfcPrXmDa4Nrrs2cdk1UzxTwDON2AE6IYhTcPUPC3AbC/OPqXFtQ0k7BOYPokhXtvNsI28hp4dgKQEYy60H6eCSsIJqThEMmsmEDJR3gQdf6bH4J7j6sTeIztpCxjUvQw+cf2sO7JilKD3jQOj5AUckV5AzuDgO5eDi6NKslwRbQVIzcKsbb+RBkSB5PoDfzKp45VmWS8m13hV6QkEJy9UhpoxDh6LHQFS66Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYLwk+1ZZp0CqdT2gUagUMlXO7oAJIjaz6RJgYGwlvs=;
 b=fYbNt2nCzIiV4mjpBHpvcomIDKmWgfxws/hQOpZektbpZnx2NFFKDcyUvTN0TtSBCAUL5f2KjdtFX48NMhDGQNyNga9cjL1mxLW6enX7io+6+RB/HSxzSk0eILuiXKAPTrFRsJ3CPEbMow8vIBqee9fCkHuMlSJSqnKv25Sk3kkVDihUTfamFOWQRgwtSZuKWo81IKMnhVofCm1HxiQeSDHQmTjqEfWYXBXFdWftEAzYOM8RJ/pCx/wqF5QFRDcCtUzgfyVT0iIttCM9pn+DEhUkM16WNkKYen52cfxMIZu08AyBlUTOZcPrAOTJ2/NW6qXwJjSrnoWjU5GiTAs3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYLwk+1ZZp0CqdT2gUagUMlXO7oAJIjaz6RJgYGwlvs=;
 b=r/ShqQJUQcUFCmop9VzmsTTU0qMQPXS4uK8TEiROJZZOezLCP2e76eANDK8ES6E6h+VH1M6q0bALyLpKOUp9rrN36rfULq4z4tH22vqPtlV5vOsBVPFGlYOhd4rFHkS/JaTgQ1xzlUxPknjDTG6vhBsKhv8TZw9hYgs9UVos6k8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ2PR10MB7038.namprd10.prod.outlook.com (2603:10b6:a03:4c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Mon, 3 Apr
 2023 02:16:05 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%6]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 02:16:05 +0000
To:     John Garry <john.g.garry@oracle.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bvanassche@acm.org
Subject: Re: [PATCH v3 00/11] Fix shost command overloading issues
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zg7pvhr0.fsf@ca-mkp.ca.oracle.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
Date:   Sun, 02 Apr 2023 22:15:59 -0400
In-Reply-To: <20230327074310.1862889-1-john.g.garry@oracle.com> (John Garry's
        message of "Mon, 27 Mar 2023 07:42:59 +0000")
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0133.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::8) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ2PR10MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e31131-fbfa-411a-4070-08db33e9614d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xE6nNevnn3JhlFl+xmyQS5NsrUt5UiER4M+Ica+Pur6QkzX5cQIPzr3oHwQ8zLbGWFLIB84uTTdl+0XlN1yvhgFq1eV8/w6fl4r7Tu1BjMXImemU7QIz/mWdKNdwvUuM5mV9pUhB3IE6rNHROpLKBsZllymozHxh/Jl3hqTlwOu1F4Qqlkyq5jMW/6dlWNuVrKllM4MLbjeLtSvEYBFO/kNoK3KrSiPXrH0XkTwYMfHVV2VSZm1r9+UfhWPev+7HPfCrp7Ku4iMqw9+HFXEo9pi//6PTqVJGobVcCnNE7c371Bsw8usLKKgyRDYVkEih3tJDIAcKAzzgES847MooT7LO3GzmIz4NVMrdscG+rQjjd4ReT8sSs3u//Os1vIVn6Fv2/DmrB5llsA6IxLgU2nXPE5jvq23yQroAUZ8fusuZ83mbIqHuCDzHaGjK6FuLwsnNspMJqh0m7Dw7OoGDe6Sw6uhPssx9GvjP3PUDdZ8zYJPtvQFMZ4YrJCJ0G2tfXhi5GNegqcHuJ9hstW3z1/3iSOe8OhdkqpskVbNYhKfJYKWgEZpFiK75eUJ5xrW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(4326008)(558084003)(6486002)(8676002)(66556008)(316002)(66476007)(66946007)(6636002)(36916002)(478600001)(5660300002)(8936002)(6862004)(41300700001)(2906002)(86362001)(38100700002)(6666004)(26005)(6512007)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IOX5I7UMRX6ABUbtUbas4RA6nmtnMxmX+0lUZrVuHUUvbRHmQMo5/UKVbawC?=
 =?us-ascii?Q?vhR5P8FYQ9nfMmP3vVN7dIlRJGEmtkP3PpW4r0ogDcbR3cBMqbr4C2pg7C3g?=
 =?us-ascii?Q?iio8on3JhsxOpqKvle3O1Lc2HeuXT4KuxTJP7fMpPQZdypECPTdpiGMRq9K5?=
 =?us-ascii?Q?SkTWYk2gaxb1Ua7iRlGyzT10trkMwTI7ychsisJLzCmbDYJzjiQ26BBLaWwV?=
 =?us-ascii?Q?AuYBUsWE7D+wMs8XkzDrKm0d0zzfEc6y8k2h8/hb2DF0ICyY6KEKTvomFiI3?=
 =?us-ascii?Q?LHnT/AWzUt4Gw+0+g2qFQ/keVQjaRsUTYJQGYtvvamM4Gz0ZX3ZlXv6qxguY?=
 =?us-ascii?Q?gSvV+IXbpP0JF2PgAgY5TQJ7aqQWSVszvwlhVtef4LZQwPxyRZqqMaf0TUI8?=
 =?us-ascii?Q?1WTqT7r2pC3s1vpjve3WtYvdem4c72NpYsD5T8+9A4a4+pyrHs7MEfRxNUV2?=
 =?us-ascii?Q?/D1nO2Z70cg90gyW/5+msTlouRLbvRKM/VRX4fJ+Iz/4hjZ5uR9nyhzPSQIV?=
 =?us-ascii?Q?1v/8rSZ6dTyuE8Cb+s2K8q1CW1S9KEN6N7QemV6uJ24dS5sMtHmaY1tnxdbB?=
 =?us-ascii?Q?lh85FMU+F2BnldpPYydhzfWZcFZmess5BT5696l8jDrtn5gYIZZyCFHrtV+i?=
 =?us-ascii?Q?HYhitGEo1XGbDjZ9a127SUIl8yXUIQfQLNer9trCczVsfrrlILJbhcBsOugM?=
 =?us-ascii?Q?cMkxLjAARBAtPjzCyqTIAcvVeNGTb9JLlPttOFYQsMKhCsmR3+B+J1tqYZGK?=
 =?us-ascii?Q?q8RJ2H0UMmRzpWaAo6T9t27S7Wrr6MmO7Y9Op8Mz6LrU+oiCmDrap6TKjrOL?=
 =?us-ascii?Q?sjpk461f+nelDI6pLWfkJwPmMc3S4v9SS/33XGKdJzslCBvmPFl1GCTcD7vv?=
 =?us-ascii?Q?VuIuXEUGyzhmOhngGubgv6AVoJ2S5/9aKMana0IYTOcbhy/F7y9nAhqGZAD8?=
 =?us-ascii?Q?fm5SKui8blcOgu0npUFe5/Li2SD8aOeaYG5wxZhqj48w9emGA/Q+J60F8WvA?=
 =?us-ascii?Q?7ehuosH4zmmybbCSIrXDZRRgLgKL/PK/m2/a53omXbCHhgmQWv8e7ryPCRe1?=
 =?us-ascii?Q?emGC+justwmVHO9mugRH+1noWdoaFCSX7x87mMa6RZ39CShHUZVIXqCLjBIq?=
 =?us-ascii?Q?x4S7jn1ulhGMMr3S4SvMESxmgdOzvyazIsKuIVQCxwh02k3283HGExixOILJ?=
 =?us-ascii?Q?0X9i8EyZHFpQ/awLrICrI24Zf7oN59bgntTGv0tJQHJnpciwR6Oead1giANV?=
 =?us-ascii?Q?GCUPl/bRjF/gTeZ/vHaIpCQlRy1VmR/xEQjwL5JV8ruIf6wXIksoabRCNV0X?=
 =?us-ascii?Q?1RKRLB0rb6zwk7ZhdR35oGDoMVM3HYqn3U05Nk4NibKkkXabLd4HTWCa+qRr?=
 =?us-ascii?Q?p0Bh9Vd2xCLXmMyhv2iFG1AXXrIVv+TrlfIcYxh6tLMbuEBNs8/IHPJ6TbSm?=
 =?us-ascii?Q?Upi00YDBxr94TWYoK6OEFSf4WzRWEwPb/MViPHJf8VgUujaCYisn2rKCPkWL?=
 =?us-ascii?Q?s2IJQiisMHIgA8Pf7ZsjeCpRpTB3R/h7rTaAZ/haZaA9GYet1H88+ITrilo2?=
 =?us-ascii?Q?Vo8xQwMczl9vB+jQj1cOeBPs602RbzK/SEb0U8yTuRNYpjn51oxnQzo4Ezfz?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8pQEjFwfU0HXsMxiUlHhAy3DG8R/eiW5fVXhmnft+3rlnya9Vz2GJTWEXwTEGa8y+f3EuZeocV61SvqHVhlNL1MuNvX7+t+RZFDogYX8YHNJygN1Zv71Ap7rkeFaDqH/55/H6XqiXFzRja/ScmZLaN+JE2NISdYYkPXw7jsPcvZcQvIOsnDwDWc+2qjuAA3A1UsSL/QfCRMld3mNo/wcmx9SmBqQFa3TyCKPBNYGa0Iu5a1KaLvwv9BJejIWiCA1k10LExltSESF1V3zlUohGGD3QUw1Ua2IEqMSeBJ9miqwzeE5sVbEPHASomkRiJnR036Ltp6XIG4YsDIWOe4czT255AdWF4iYaRuby2B8fVMcASVKRngXdIi5OEUhMeqRPrw0W8EHcCJw3+Q0rHtFJKhpGRSSDMqTfLJyR4VerzTvYOw8KT0GnsPPj1vdXrvYsk0ReEzAVp8F68XYom5sTWTEZUKP58a/ehhH6skIZvGIe1OsFkyYgXTiba3YwlfMIwX1peqKH848MhztReFP6JrwzaPs2ggizSMrHd2Ziq+BQsii2PQIOEIzI0ek949rRt9xvJrnbg5sRKeb5OTzqZIyGO7xiJUuNoA1F/SblvY3lcwCG2QS3V9xnHGtXgbmJ7Z/aMGcDLKR0t4EEesqDRIcdvwR4yExtn4Dn5MrmSpyAN0/ZUscwgI1H8hf5Bvsq5kM300JgI/gljNz8qH6H78EQJ132WaCN/D+RJdaIIXcuCjj74Ng5+CtaiFgUNIGsI/1yNzi63a91PYruNFZX1aBHg5xVerxthV4TO35PKbW06rXC3zQADAvaARTaQCnwpOylfLWigvwvQWTqsW7TbQl6X4dFbF1JfpgrnQonRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e31131-fbfa-411a-4070-08db33e9614d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 02:16:05.7410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4hBm2Y8od7GJ3p6o+FNaRd+DSrMXalbggq68ItP3DlqIMl+b7yR8EzPJ8ZEELXBjncp/FEhnOqHhzkoWBwWSCJQKP4S1cgbJ/fmkaush28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=866 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030015
X-Proofpoint-GUID: nU1R23BLVjlyK-qStP1OxigNgmtGowYX
X-Proofpoint-ORIG-GUID: nU1R23BLVjlyK-qStP1OxigNgmtGowYX
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> It's easy to get scsi_debug to error on throughput testing when we have
> multiple shosts:

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
