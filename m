Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC94B6155F3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiKAXMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiKAXMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:12:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140391A4;
        Tue,  1 Nov 2022 16:12:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1M3w4k008148;
        Tue, 1 Nov 2022 23:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : references : from : subject : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VkIbyvWwmbnj/B3DsoogfaBnMNzGAXR5v/0NjEM6KvQ=;
 b=TMXK+zl8n+PtfF3RAo9Zz3DzSRov/ynd6Jy6irgsGWVxQsMrYYgJP4WSEdCo1Idve5E2
 s3fxQhRpNj5MC3cO3zdP6QrfGYdtPHEdyiGK7TNLQ8j42mrrMujcm5d6gCMdbyghYhTo
 3ZW62jbLIQq4zkP+4MofH9qzaVSTVth25kNNU7V2GYlQcBQpGt61TSn5esLd6GffpW5q
 Xz0Dt6OhXUmFi0VyD1w3T/AX+NvB5j+enj0U78otuJszGatu/fwG3KjLUopWC/nq+8xe
 Q0a/zoDSpl/7r8x/bUSVqDUynfrhQ4xiy3J95o9ls36W7C117TTqkO9FNjk3iHvSLbtN nQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkd7uba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 23:11:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1JeE6m002908;
        Tue, 1 Nov 2022 23:11:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmb01vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 23:11:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noYuJCqM2JfTZry7RbyNXUg8vOSp4Df+h5iQ548iJB/kJ4ElJ8TqFtvDGrPCbds6qwQS+xfu3/Wwxc1n8XpDEEeoxz4lsf5VYlXNmwokTA2ZiPZ1YSyk8XZ5YX/bGb5rG+BTKsOsimUlTbOZiZrKfuszRIUGSAlZB5EeU4rbZVa+5xw92KpL4Er4doIj27almxAt7ZBlpTMNIS9byYkg2fyT5GuZfCIicHlNJqoTR5FtaUgv3cgzCFJoCxPbSLbGitWQII7dUm2L3hJwGCsTJqTaCim80zYT+rks3eAN1KL8kX6aJTyAdpOPU4mHaoK3v7o/PeJ2nuHs/MJsqLdd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkIbyvWwmbnj/B3DsoogfaBnMNzGAXR5v/0NjEM6KvQ=;
 b=eQhoHuBfjWZ2rOIr4nd/H0U5j/E5RxkMbxfWt43n15WZewocZ3vJ+z371PN4b3nNGyHQdtMjp5ELagcg4AxQTeW+ydPNrGfP0/KusYhMXjPw1CinYwEF7mijWS3D6Fwd3WQ/SgbKI8NKGlH9mOvsEitk3JrQrCHZ3yUQ4FLQl0bJHrtSHD0OloQMYNSM7wFvwK3yLGrbtLnYebxYboLiDS54xWrmxsHEWshfr4H0fTfN0M+RvXllBUvC5WqSfX7byqBMbvC1RgXc3nCqIuGdyjuuTzA3USRpb8h6SB2m/i6/h7kcyc52U8++SMqI0+Sn8QLl3CnFziqQBNCX/oInjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkIbyvWwmbnj/B3DsoogfaBnMNzGAXR5v/0NjEM6KvQ=;
 b=mWEweNL1kst+Rp6M3wwnamk4MWQwk3TctXydjypyePhLPGXSdPw9rOTNAo7cYKxSk+dYX80VtLGGoS3JcPdTLGkzNQ5ijICdjjQOma7yem/i3E3BHFdof+9wjA3Z+G63rApqCbfPL6oCDIJW/n+SQd8ZRfU55U/W8O23iP157/g=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by SA1PR10MB6614.namprd10.prod.outlook.com (2603:10b6:806:2b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 23:11:45 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::dcd4:3c82:8227:3fd]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::dcd4:3c82:8227:3fd%6]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 23:11:45 +0000
Message-ID: <94c03150-11c3-2a58-b01e-2467f6aa62dc@oracle.com>
Date:   Tue, 1 Nov 2022 19:11:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <e91af3c8708af38b1c57e0a2d7eb9765dda0e963.1667336095.git.christophe.jaillet@wanadoo.fr>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 28/30] x86/xen: Use kstrtobool() instead of strtobool()
In-Reply-To: <e91af3c8708af38b1c57e0a2d7eb9765dda0e963.1667336095.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:806:d2::14) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|SA1PR10MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae1dbde-4baa-4b4a-3102-08dabc5e71d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfwMYWPK6fPk2absjhGdxEeL+aySGus9J9zr1Jrg0WgfXa5syPSCMMCEHfHiLUhT3WHyJadrxms3QrA8jpcPGYdRgLcOSyghdreWvobysyge07Po01f2jAmitiOxPMpm+uQ0u+V8dFjNuTtdDLm/lWzNvU1ow+n5PBFB4sPzajp5MImPmgwvVGXX+EpInRM4eCNdpBlkiF0KT02R43aVeK+Lg5qhdsQIosbRZujHgqs05Q6K0Y1Q97PSOF5+J6bhEftO4cjT8GC1K7WRQ/Z0gofDtV55+1bNC8+J0l8U6Ziai7Lf4tE1nZH4XTltEWKDlErCvJh1gh4V/aySj28XoiVsTycx6siMP4knzl2K90r1/95cF6d4V1FjAQV0qo68oQV4g2nkZys19PsGkB/O5ON3bfW/zs0xrrYI0snMrfFuyUxkOM+gUSmWRQEbfnTgkY9854tfcHwSG7qdWwPB0Zra4Ep5MsmHJB+74V3NdVGNS5JWW9BFa5zQnko6ECpktbNvkZqEh3JIlYO9KAOHG4uuIs5jttdeTDKuz/KN9hmJLZjRzOhyVwNxCpDGOCzSnDUPyn99uimCDG+VfIZzMPlXYZmia7cH+WybWUqTd1da4S+K/OdqAAqVxtP+BxgSaMMcMr3fO9f3Cqwcb3ENWy9GEk716/i9rYb4iYOBQanK5c7thPQZQf1DCVMdSiOn/VxlnwliInB/U2mAmGbCcGuxItjPuYm0z8g0xe3rfAXWOz2QYkAjnwoc2SscXLzwQUWh1Ej7Po9xET+k8gVWLuw9ryzc/W2ZhtzBnWNG1ghKggN0zB1UVgkpKZqkG0R5sX7TTJnLac01XcXLC9ojCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199015)(83380400001)(31696002)(86362001)(38100700002)(5660300002)(7416002)(2906002)(4744005)(966005)(66476007)(66556008)(26005)(8936002)(6512007)(4326008)(44832011)(6506007)(2616005)(186003)(110136005)(316002)(66946007)(6486002)(53546011)(6666004)(41300700001)(8676002)(478600001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVR1Z3VaMlRnSXd3bEhSQVVYUVZmRHVnRkN3YWRNdlkyRGd1UHYrZW9vNWR3?=
 =?utf-8?B?OENXeGhVRVd3dkRuMW9Xb0VCUk5adDVOMzZ2UEVHZVNwYjhsTm9XNTc2OUZl?=
 =?utf-8?B?VFA5c0MwT1NxdU13V250cEg5Qk9OTUFCcHYvMEZPNFFKSnVhcUtLRVMxQkdB?=
 =?utf-8?B?dGx2aHcxR1BiOFJFU2swV25jZFFWY0w2L0ZhV3p2UmtkZS9sdGdkR2JIcWVh?=
 =?utf-8?B?UVl5S2NRTTNaQkU4UzZkVW93REpvMUt4ZkVwQzhEdCtoTW0rZkh6MUFOQWtj?=
 =?utf-8?B?WlFvcXU5eGZGMDlFZThCd3FZNjQvMkJtTDFwcGhPOXhhK2xISkpoSXhGYmxT?=
 =?utf-8?B?MEFSRVBRZkZvYmpDR1ZMbFo3REVTNjFzaGttU1lMYndHbTlOakNPS3Y4TkNH?=
 =?utf-8?B?aGJLVFVIQk1xR3lFZ3Q1aXZlZkRpVkFzL1NqZUFkRVUzcTE0QmZJdmVOckJI?=
 =?utf-8?B?WHJVWnRpS0xISFJYcVdXQ0t0MkJWSHhVbGF2QzZlakNCOUM3UjU3dWNHYU9H?=
 =?utf-8?B?YkIxSWk1RjVtSnBIUTkzdVg5V3dBaytaWmZiSjFMOWdJVUdUdllwK0Fub1B4?=
 =?utf-8?B?elFMbXpDdHhBOU9oOUpjU1VqTmltRDNOVFlVRmpSd0NaVlV2cldQUnFEakhM?=
 =?utf-8?B?VUlVc0lOS2Q0aUd1UzlBOExXUkQ0clpxaDlhdjVpek9zZjBINDA5ZzV6M09x?=
 =?utf-8?B?R200ZnhCMzRTK0ZPemRkdzhaN053QXJWR2p3a3RSQ2hDRFI3cVVuOWdDYStu?=
 =?utf-8?B?bjFPNzZzT0t5TlNQSEJjWW05TURONHBrMisyU0NLeGh5a2xnQUNqd3NZU0Rt?=
 =?utf-8?B?cnpsQXBpRDNxSFQ5M25penZza08zK0hnZS9XTThuT09aSEdWRVoya0NDclRP?=
 =?utf-8?B?eVVTSWJvU2NCRkc4cU9WRkRWcEsxb1pKdWtHdkdrWng4cTJDYlYwODNZRHBV?=
 =?utf-8?B?WDNMRnJ0SFNianJhbGFKSURVZlVsb1g5WVVTM2M5UlNtRjBpY0Y1ZTJNUkRh?=
 =?utf-8?B?K2d3aDBhYkZUYy9CNWN2SVArd050Z0hGcFZMR29FdmU5QWtXSmdlTVg4bHZJ?=
 =?utf-8?B?Z1laUTgxdzJvS1c2ZzRLQlpsbm9hSXc0V0dGYVNTa1p4aGlaenErTHZNMlRn?=
 =?utf-8?B?V0ZLYzZ5cGh5aEU5WEhSV2xBUlNqMGxDWUwwdmxvNXRIcnlDeG9hSmFyWHFw?=
 =?utf-8?B?QVFnRmpUdDVxQi9sUDJ6N1hzZmhqZHI3aGVJODZ4SGx5THdsVkpvY01hTU5m?=
 =?utf-8?B?SjNjNjQ2L1Z6MUxkbXRKTGRNZ1N6ZXhIK050VVZmdDJPL093UnNjNXN0aW0x?=
 =?utf-8?B?djVkay9iUVdDWGd0Y29mMmRIeXRhRHhOMFVRbWhvdVV1VUFvMTl4N2g2NVRk?=
 =?utf-8?B?ckM3bTNPaW9hM2V6NG04dzlxRWwvekNqMXdNcEVabzJJQTVrTUpSWGUxc0sx?=
 =?utf-8?B?b3pCRi9sTVV6eG42UDhxUm9IMjdKcm1mK3BlTW43UVJKQ3d0MnNRRXZiMjAv?=
 =?utf-8?B?aTFqejQyamFxNkM5Zm16TCtTMUo0OC9LamdLNmtLWVAwVkxkSTU1enRQSVJE?=
 =?utf-8?B?bVNHQkJUUDI5WEFBejJyWThrVXpEZHhrOWlWZmIxam8wMFhNV3hPK2hXU3ZB?=
 =?utf-8?B?RC9uQVhUaytjMzFQcVhwL1pWS2pZenJ0eWR4RFpzNkJSVElYM1pNUHBOclpN?=
 =?utf-8?B?Sm9ZM1ZiUW5aZS85OGY0c1pLUkRBU3pQbXR1OWg1RGZFeitNSkhFdHQ2ZWlD?=
 =?utf-8?B?RGFLbDFPb25UUlZTR1l5dVI4QUhDbisvdUFPU29wSmtzdU8yK1prMkQrU3Y3?=
 =?utf-8?B?NFkxSjlYYnF5TmhXSDVUdkxMRW52OVJzQjZLSG5hWjhRV00rdk5wajBuNWZ3?=
 =?utf-8?B?SVdkRzdVTFRiUzNaajdiUDdyZm0rWnFsVGtpSVBERWhrK0h3aks0MUlCMWRt?=
 =?utf-8?B?ZEozclRPdXVmZlczZTNyRW9XalNCOWxXcUlWVFVGalFnbTl4NnZaVzFmY1Rs?=
 =?utf-8?B?VXlObTZCQTZuMmNzZUNWOWlBZlJjTVk1bFdsL2pieVh4elplRE13eGZpYTFr?=
 =?utf-8?B?cGJPckNzNVJsQ3E4QUcrZ2xZazBFZGtYUi9HdDJSeVVTTDNTSXN5NUo2eEph?=
 =?utf-8?B?MVVWa0ZubFNFMHU4Um15aERLclNQQUo2UHdMa3R3RUQvR2xybHpnUFcreUpY?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae1dbde-4baa-4b4a-3102-08dabc5e71d5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 23:11:45.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhGV7axF58ViYD5521buUkRCvwY0FTiOaazSYZGqzMDjtNa0vuS8BN4CdFjpjhiNAvSugfsNOEyFr66gtzpQPlNjDVICAuXPcoDmYYYenh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010157
X-Proofpoint-ORIG-GUID: W8ClTMnEASx3Bm2NObXqcC4GNYjEHk-E
X-Proofpoint-GUID: W8ClTMnEASx3Bm2NObXqcC4GNYjEHk-E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/22 5:14 PM, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
>
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
>
> While at it, include the corresponding header file (<linux/kstrtox.h>)
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is part of a serie that axes all usages of strtobool().
> Each patch can be applied independently from the other ones.
>
> The last patch of the serie removes the definition of strtobool().
>
> You may not be in copy of the cover letter. So, if needed, it is available
> at [1].
>
> [1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


