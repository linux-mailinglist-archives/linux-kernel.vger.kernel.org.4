Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB267371EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjFTQmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjFTQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:42:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D80519F;
        Tue, 20 Jun 2023 09:41:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KGDuMR014678;
        Tue, 20 Jun 2023 16:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fFCe2+EpZVBDCqR5YxxbyuHoJWThFIsp8K0um0B097I=;
 b=t6ALdTL3xk2QF4IbBV/RyhEX+RZqB+JvNfwYBq3M5xQkek6U8IxG82OFrRCLrLpU1RZ3
 XGL/Ai5JWPOrEi0aGZKjQyhBjXsBpKS0U+EZCdLo5NDOYwFBRvi5cV07PwkGQ5pEisCK
 d9i+acQ0ouNjz1VVQyZPVK/mYy2JnYNWff69WnHpPuGzG+1zcPCd1Y2nchwnGPR9CvO2
 jqDPNqcWvYybMIyiFqURf7s/VW21HzswURDGBDOiVo/OmghNe8AOXbltzHSmXeu68jOz
 FHkRcmutZeqV77S3IrIpmyjVZQG9WHKtqXEiYvZUvHeBsa7ISD2ZbmOZ52myH4/manEA Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etn9c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 16:41:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KG3Lhe038681;
        Tue, 20 Jun 2023 16:41:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9394us3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 16:41:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot1DfaWEXhWgVX7tzLtvZdWbzBOWg2uaf51hzR1a0xbF1jJ982bLBEhqt2caQqGtiNVqBKsWKElsAi0k/m27XI7e79M+X66S7B+jMRya1SfSu9kunEBbnGKEyj4P0UJ2kl8QQhj5a8KhRH4vhGiIz4OJywzy7Auq0dNsUqMP7Ugt6Ei/w7i/tv2+0PVU0k17AKDm59ho1uKfSA/3xsRF6GX8YrmPSc3avmTHHjAlpAVLuY9X5tqDuEe8vFQsCXvRkQd7DfWnVcHgG3RsnoNuKb8WLg+OD37RewmcqucaG0vWmIUs0hW4XV7sClDmOLamtWiAsUqSzJDr0/06tV9teA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFCe2+EpZVBDCqR5YxxbyuHoJWThFIsp8K0um0B097I=;
 b=PQNDoeVCC35qD6GKT9K0gzOKaR5L5ZwnFKQygEws3K08zF4NyfvlW9wSEvDVdS/UC0XaAD8z7i4k9fkvir6YeWNzR7SXr8mxPpkm+j3cmOh68/z8BU2MfTushXbtQc5JOu2D3+VdTg4+dAYGT1+TNqnV30qyeR61xqm6Yv6zHE1AKblsu49MjsbOOfN7ZFqHaDsghCqpp2fEvdYHMt7tALF2OL4Bgs9+1Lh9HiHldtY9xPsMqXZxV8JhG2jxuqVTgWuPpy0iDAbHm9gEhW3zOgc4AzyFVK0nQSur6w8aCuBjak04kvy/q3OY9WJHYcnz4ifK0FanhbibZM5E3Gwpmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFCe2+EpZVBDCqR5YxxbyuHoJWThFIsp8K0um0B097I=;
 b=OGRo6+A1XvFk6GpewzwiQBHPapA5QTSIXbo7fSZ/vl6eH91kPQ3TPkjmVF2wjGhLS7lsCijOyDDtCJKvTVPNbv2c5ZUk7ThtefGd1fZB+ohXyNbkofWBjJ0qVXSSBbirjb2q7hGb/Y68POe3EZeS+5RynxUIRWSvRJBDuFt+VEs=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA1PR10MB6520.namprd10.prod.outlook.com (2603:10b6:806:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 16:41:52 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::59c4:9f51:3ccb:bdef]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::59c4:9f51:3ccb:bdef%2]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 16:41:52 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     "Shenhar, Talel" <talel@amazon.com>,
        linux-debuggers@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Inquiring about Debugging Platform Drivers using Crash Utility
 for Kernel Coredump
In-Reply-To: <f8f62216-ffaa-2f4e-ac5f-7dcd86e80a84@amazon.com>
References: <f8f62216-ffaa-2f4e-ac5f-7dcd86e80a84@amazon.com>
Date:   Tue, 20 Jun 2023 09:41:49 -0700
Message-ID: <87v8fiw0fm.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA1PR10MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: a1cb6ba1-6f3f-4f03-af72-08db71ad4033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Knu4VtSO/t6CLquUZrq3Xe8ozvsZbPnyrc9AUYf4b4Phwi5tQ8xEIK57fqTfmkIE9YQTyM4Xfebh78l5Lnp80pn335faRreTyZ8Wd/Hww0hbLFKvQsEmlGF4XdB0exyNj7tjMdD5Y1ER330lIBjTYvRbBFWBwpLlvn8BhHGWfw9jCnG6KWcVpdipE5PuB46FgWRqHzr74nLxKdut5VbWYmT4FoX31cwnkcR1FGlPzkD+9QR/4pIJvFhgwDRjHaRV0ED5JVTDYKDls+XHDrpH2Rol0AanXcTGdopvaoc9iIseUtCZIrPPDQ9MysR6gz+duKE1bEGW8FCDau83WukRKChuEWZwLmLsOYhireJr/XnBEfXOqzVYqf8C7hnFeTV4rBMhDT2hLjxes7LznfoA0Bt8MXX47ah3bRHyiPz9a/uZfdy73lF2fS6FW8W6gUTwMHVqc2i1lDmuaKTq2UcTHSaURsZQNh5o52uiIqZw9J7EksqvSPEbRBhbmu5e1VZsYKuys4qSTQOcP3Is/G1nobOcjDW24tU1rBAVqGU1gju0RKQU4SOs0PB/APTSHyd7LSGYzqRty8fYRtD7c7/IqWNqacsgnn8UljYvAqH04ks=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(966005)(6666004)(6486002)(478600001)(83380400001)(186003)(6512007)(6506007)(2616005)(36756003)(38100700002)(86362001)(66556008)(66476007)(66946007)(316002)(41300700001)(2906002)(5660300002)(8936002)(8676002)(66899021)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFpBa0VLUlAzUkxTT2JqSkRPU3YvSG00VnlkQ3JUQi9YOWdxNFdFaGVNY2NH?=
 =?utf-8?B?MnlraE5kY0JIMkgwYVJaMEx0Q1pyMGdMUzhaVmUrWURIK1UzcXUvVmNNU1VQ?=
 =?utf-8?B?ZXpobytGd3JjM0RvUjhiU1ZMaGhoNU1vM0h1Q3VRUHBHU2NzbnBNQS9PMzZX?=
 =?utf-8?B?NGpGQ3p0SXFmTGNRVGhZT0Q1YW00T05UNExoNkkyQ204Y2phQ0VoMmhXQ3E2?=
 =?utf-8?B?U0lyZCtPYTl4K3BtM1MwS0JpRzRLUnZyRm9pczdHYlVLTkFWTUFycUF1aXY1?=
 =?utf-8?B?SU1LZGxxenY4TURzUCtOWmJGeHZ6eFdTYjlqbnJOQlZpd1lMQlhqY3M5MkJr?=
 =?utf-8?B?NkFDZm9Gc3gyMzB5dkZnWTNDYmJ5SkpWWUNYV0NDeXJQYVVRNXMwbUZvOHhj?=
 =?utf-8?B?ZkF1d1ZuVGhTK29TODBJMElMK214djJJaEg5NDF2YytRMFNsZGIrblV6RGpF?=
 =?utf-8?B?YkU3dDkzb09DMDBaWk43VFVLNEdpMW1JWW1FeFVWL1NTUHFMRzZsNkkvMHUy?=
 =?utf-8?B?SXJOWVFpQzN2MXB0bTFGaUlWcWRmd2ZEbFVFcjdnRDkvVXJ6VGZkVllEUmcy?=
 =?utf-8?B?Z3VFSUpVWXh4dkJEN0xyOUhsa2tQcVFBQVg1LzhNd2FwSHduNkd6eW9OT0pB?=
 =?utf-8?B?Y2tiL1dvTkVOV0NobVNDb0F5cmJpUjNlUkYxYWRIZ0NlMjJiUUhUek9nMVJy?=
 =?utf-8?B?VXdzenRvZU16Q3pzZVVsa1gzelpvREh2U3Myeit3UzJNcjQzYXlaWUo1Y29M?=
 =?utf-8?B?Z01tTVF6Wk0rVHo0dnNtNmRwT1RrS1NZdXVHYSs2L0ZSM1ZBK0p5eElQNHhH?=
 =?utf-8?B?U0l3N25FekJsOHVlRDNOL2ZsM2JDSGY0OW5rWDlVdEJTTCtDMTVXeDJ4b3pz?=
 =?utf-8?B?cEJYb2JNbGJNWDE2SVhXVkRhWGd1QjNJd0F2ZHpXSWpWU2VVYk45V2k3VTla?=
 =?utf-8?B?S0pMcjlrbUlLbCtuL2YzaHRUeDNBcDZtYUdleCtMcGdUWkxRdCtIVy9xM2Fu?=
 =?utf-8?B?L1FPOWQySlh2ek5Tbjh3bHFXcWw4azNNK0MvMGVkYVNZNUZ3K1hVTE5DOWkv?=
 =?utf-8?B?ZXRYdUJGZGRKWm9OTXNJRkRLUU9Pb0FwWWJPZU03bjQxVnlzblVpVFlGdmFt?=
 =?utf-8?B?cU4rMU0wcXJNY3NpS0lLa1hNMEFmVjJhT1d1RXVjWnVDclJwU0hQNSt5SDJK?=
 =?utf-8?B?bnpqaTZDZmtUVGZPUWdpMUlIOEZKenpuTWtORXg5QVRSek5pRDVwQlkzZzF5?=
 =?utf-8?B?VXZ5Ty9CcGZpZXNWY1NYc2VaQTZFczkxd0VoUXMzYUpNNzRxVEdlMmxFcis4?=
 =?utf-8?B?Z0RmWTNrM2dhNkNaeTdlT1pDQWVDekZ0cUhHTHh3TEx3NDQ1aDMvQUE1aThD?=
 =?utf-8?B?MThaQVVteEwyUGVuK0NzTUZORHBsNXFsSUdhRzJ4dXkxSnFTTnRDbndTV1Rx?=
 =?utf-8?B?U3ZoQXlZQVhNUHRkQThpdlQvZDl0QU93QWVSSGFNL2hXNmdMWkQrWG9mWThk?=
 =?utf-8?B?OHNaeGFkN0dIeUYvbHZxYzlLdFJZZW1GeHBUcWZQR2l4eE9jaktSc25ldFUx?=
 =?utf-8?B?SUJWbzZ2ZndGNmc2L25RUDlpejl5ZDBFd3ErZUY0djBIaCsxZ0MvTDhFZWVK?=
 =?utf-8?B?dHhkcmxDRW9IM0VmNUpRclRIMklnOGZxMGk3VWNaN011VW51ekV2ZVAzK0xV?=
 =?utf-8?B?YlZiMzJWckVMcGVBMTFZbUtMQmsySFA4ZzU2eEozU05TS0ZzdnNKWkhjMC90?=
 =?utf-8?B?dUFaUldtMzBJMjlHNnNEMHBqZjNlZGxoR05qOGtkM283UnBkVjFhZCt2Sm9k?=
 =?utf-8?B?SWhUczE3MHNkdTZxTGM5N2tjRDFXTStxUGZRb012Q1gzNnlmY0kvR0NMU0Ju?=
 =?utf-8?B?bmlCYWpuOE12bGFZRi9JL01ZMDc0WU1tbzl6UGcxV0dYVzIzZ1ZuNTFuOVRC?=
 =?utf-8?B?ZUhqSU1PdHQvVHBWSjhTREQ0V1VYOXhuZnFhaDB6a0dVTEd5MlZabWZpUjVo?=
 =?utf-8?B?TldnN2JGWkZRQzlWclo0OTcxaWhxTUp1eHBWdkFHTFF5OWtndXdRMkl5emhK?=
 =?utf-8?B?U0Q5OTVmLzU0MFdXd2FTVmFJcWxkTXJIeTBxcFo5SWp4YksycUo2MzJSWVcx?=
 =?utf-8?B?RGV2bjcwYm1zM0NNaDVkNlVaalF4SXRXc1ZRUmZnRWVUMlkrTlJiY1d5T3gy?=
 =?utf-8?Q?O6c/nZTvb3K8fXfifgVVNZ8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KyWM0ugbrOtDRrXvj06Olvw64xuJLU9X5KNm9+BpmAfZWpScRpsCfNA9QpM53vnmGcG6fnQnvUe9aqTuUAKymvtenSgnXEk2DwtgA/MkcAAmMnXeRbji7HQaYtzG6Vhoz2GyObGWNld4AmbJSpG1rzgXaINsaowcwDH4dtIJYqRtwHjARDWTV+S/4Cm2rLEUYXmGxgczoKP8Hngh15PZmmflYhzVhz6kRJgBrXcdSWLo9IMYSowHbyk+BxEfvTU1mw3Fd2KBh5Q54rqkbXsDsNeiB5CpZf/N6Qk5eezh8OJkbIYuoi3hmEU/tqXGA1vBXLLQd4UnIva8o8kzosChJc1/wYiTh7mt5c5lBBzDzv988Y79oRGUVTm4KVQKYpPqHEjVbRMkFJqpr0TDNVeE31ZVzynjzMA+ivOEGQx56iMZ/E+eCsx1Sk05aVrvL40UrjmgpwLDttG9jejbEgbuiafKxFASnbUcpQTypnR4ltrigQRLvNItJG8skCrVlxdRlzcf/TqDL965N1Ga1RMxLHZmbo0eflaZamYI3TH78++rZNXOthnrdu6ySz2bm6NzbMhmfWcEl1zvH83gKNXc+osRHfbCE+IH4J7h4J/Q3MdKI0TvQuI1J7tfcAq0JqyzXKETnzfNpVkIFPP87JRSn/elVOTgiPvglq8j29/crmdU2y0IkV607pfpGlnkJ8ktw8Xl7wrDR/M7LZRG9rKEYt82dd3XEICT4Mt3CoPW8I4yX+M50oewzjEM4kMADJiKC1urhDgQnS3ntBEUMFHgdwQPjwYNKULVinXFqukvYVg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cb6ba1-6f3f-4f03-af72-08db71ad4033
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 16:41:52.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kEU1ikeSSS7UdLcxck7r/XxPOfYLb+EIpteyMj4/Rai/KkhHJAMpRrnrCVb0kqWMr12MrPKWyfXJAWikhr+VMty7SkDWaIw4xJhMX93gqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200150
X-Proofpoint-GUID: nbBPAMNiECAKgZg1V4uYTP1oAJhwDGZI
X-Proofpoint-ORIG-GUID: nbBPAMNiECAKgZg1V4uYTP1oAJhwDGZI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Talel,

Thanks for the message, this is definitely the right place to discuss
these sorts of questions.

"Shenhar, Talel" <talel@amazon.com> writes:
> Dear Linux Kernel Community,
>
> I hope this message finds you well.
>
> I'd like to use crash utility for postmortem of my kernel coredump=20
> analysis.
>
> I was able to collect coredump and able to use various operation from=20
> within the crash utility such as irq -s,=C2=A0 log, files and others.
>
> I am using: crash-arm64 version: 7.3.0, gdb version: 7.6, kernel version=
=20
> 4.19.

You've definitely got the hard part done if you've got the core dump and
crash all working.

> My specific interest lies in debugging drivers internal state, e.g.=20
> platform drivers.

Please excuse my ignorance on your particular use case, I haven't done a
ton of work with device drivers or ARM-specific ones either!

> For some hands-on experience with crash utility I'd like to start by=20
> iterating over all the platform drivers and print their names,
>
> However, I am finding it challenging to get started with this process=20
> and I am uncertain of the best approach to achieve this. I have scoured=20
> various resources for insights, but the information related to this=20
> specific usage seems to be scattered and not exhaustive.

Crash has some excellent helpers, as you've seen (irq, log, files, kmem,
etc...). If you're lucky enough to have a crash command that deals with
the particular area you're debugging, then that can go a long way.
Unfortunately not every subsystem has such a helper command, and this is
especially true for device drivers.

So no matter what tool you use for this -- crash, drgn, or others -- you
will not be relying on a nice "list-all-platform-devices --name"
command. Instead, you'll simply need to use your knowledge of the code
for the subsystem to help you navigate it.

As I said, I don't know much about device drivers, but what I've
frequently seen with subsystems is some struct with function pointers
and maybe a name, then a "register_xxx()" function call, which would
register a driver or backend, which then places a struct on a linked
list of all the drivers or backends.

So a good place to start for this particular question would be to find
the global variable declaring the list head for your drivers. Use the
crash "list" command (it takes a good few minutes to get your head
around all the options, but it's powerful) to enumerate them and print
relevant fields, such as the name.

As an example which isn't driver-specific, you might want to look at all
of the slab caches (struct kmem_cache) and print their names. They have
a field "name", and a field "list" which is a list_head. There is an
external global variable named "slab_caches" which is the list head of
the list of all caches. You could iterate over all of them with:

list -s kmem_cache.name -o kmem_cache.list -H slab_caches

The "-s kmem_cache.name" tells it what to print, the "-o
kmem_cache.list" tells it to use that as the struct list_head linking
the list, and "-H slab_caches" tells it that this is an external head of
the list.

I assume a similar method could be used for your particular situation.
Then the "struct" and "p" commands can be used to interpret data
structures you find.

> Given the collective expertise on this mailing list, I thought it would=20
> be the best place to seek guidance. Specifically, I would appreciate it=20
> if you could provide:
>
> Any relevant documentation, guides, or tutorials to debug platform=20
> drivers using the crash utility for kernel coredump analysis.
> Some simple examples of using the crash utility to debug platform=20
> drivers, if possible.

Unfortunately, debugging resources and guides are rather thin on the
ground, and usually there isn't one tailored to your particular
subsystem. If you haven't found one, unfortunately I don't have a
particular resource for platform devices. Instead, you'll need to apply
guides from other areas with your knowledge of the subsystem. Also, rely
heavily on the built-in crash "help" command.

> Any important points or common pitfalls to keep in mind while performing=
=20
> this kind of analysis.
> Any other tips, best practices, or recommendations to effectively debug=20
> platform drivers using the crash utility would also be greatly appreciate=
d.

One thing I'd mention is that: when crash has helpers that are tailored
for your use case, it's definitely a super power. It makes doing
debugging tasks a breeze. But when there's no helper for your particular
subsystem, it's a lot more frustrating to do, as you're generally poring
over struct listings. Unfortunately it's a bit difficult to write new
crash helpers.

If you're familiar with Python code, then I might recommend Drgn [1] to
you. It's a Python library which allows very natural access to the
vmcore's variables and data structures. So you can write your own
helpers in Python to explore the subsystem you care about. You'll find
that many of the people on this mailing list are quite familiar with
drgn as well :)

Good luck in debugging!
Stephen

[1]: https://github.com/osandov/drgn

> Thank you for your time and assistance. I look forward to hearing from yo=
u.
>
> Best regards,
> Talel, Shenhar.
