Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89265234B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiLTO7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiLTO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:59:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B882CF9;
        Tue, 20 Dec 2022 06:59:47 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKDIloK019522;
        Tue, 20 Dec 2022 14:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YcRdIzqBo9pgyN1Btk2XZERY1fhmKWO8ajpBVBOejQg=;
 b=muDbdM0bjIzMbaj2pHuqNZ7flfgdAqk5nL/U8LNnlCFtHBd3X4+DswoqYyx7idO2meJB
 L6nRUpmWhCoT1CnBIyp12WWBM9NpL+Ih7+JPuyBNYIczi3MT52/n4/LkGJG+snuSYAol
 o1BwQzg8LVu0d0DiHQukj3r7g0VMStPbiJ5oKZvzM+2kwNjW80pkL8giddz27aBhXXr2
 vBUoh5xnPKTxS9zKANopPaJ0KvljXeXp1NOtEa6pOG/owtwUyS1IUflbZsT2SBxMI8Pa
 FqvMsvtF6OQyxQ3YGbHlx8QLhcKkQs9b8amU92r6Tq+g0C+MWcQ69/iSqdtsE/Gv0vC0 zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tm5y8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 14:59:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BKE6MIM004629;
        Tue, 20 Dec 2022 14:59:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47bfmqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 14:59:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1WM+g6h6bwewLAiDnORymZ0k3ozpcXmDx3mwcMVzztIuMPyZqTwN66/n6Bf/yDcTINPhPqJTp9K2Bl/yJyIXb7GLF6QrHW1pXsvxYWZpEUjR/PuP2S2BsKtJJDzgRHFwkjBedMDLclxhDAC8JPqdmfN9MMINnbGkONFKn/+07SxYmHuC5gqvZVBlT1GVDY5kvWbLpmmb5lTbLI7fkRVxdlGhYVC7pAb9MNigUVojL+yGwrnfjXB31WIxkvXOzeaAozCjL3sNMtfeoYp/DtgcBKvtSKkcJ5hiPYKrmN2dB00cFyO54u93LOWSRBHN1lRrBxV5TcvrLK84wq5/kWasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcRdIzqBo9pgyN1Btk2XZERY1fhmKWO8ajpBVBOejQg=;
 b=P4869/jwPMkOUpJt5tdGtgTIItxHD+eC0uvfVk1dTC2B+8DR7ZSHp2sEDHYzlu9kFUXeAovneDdeQiUJ8ZbZh32ly1T/ZzZQQoILZoq+SO/DUVze2Ny4BG70zgxgWA0azbR166f5QLu2gLNzxAL5wyg/yYiDKc+HtxisuSA+DQ8z3IboZxzkzF/YHeJjovUc7CdyY+CV56gzXYLDkYx8s+Eh3vNW/Bsq0ZIVkzV/tO/UV0kCDHa8Gsg8BcTf3J/tq1mPgDTH8IjuCRP4sx1c34IsJgzDTO5nRc/oxgKPdXcEW8GlZf0qW6gnAJaFy9meFKLsZsnS7WiHVUoWV7zTKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcRdIzqBo9pgyN1Btk2XZERY1fhmKWO8ajpBVBOejQg=;
 b=ts/Y9lP2a4FTioHE8wmTROvfopoHWVRKAI3W6ECOQi5yvBWGuqunUNo3Fl+Xu65KOmQf00liayaSsUQrXcVOaJGiPHeutJpyScTvdsz4HM/C34Um6TuB+AHMfhpnD6EofHtZso4iQEUWT8J1Hke76khVSRreTyygl+VDXXdoPDs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6467.namprd10.prod.outlook.com (2603:10b6:930:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 14:59:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 14:59:19 +0000
Message-ID: <4ec9dbed-1758-d6b4-dc1d-ac42e8c22731@oracle.com>
Date:   Tue, 20 Dec 2022 14:59:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] scsi: libsas: Grab the host lock in
 sas_ata_device_link_abort()
Content-Language: en-US
To:     Xingui Yang <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, niklas.cassel@wdc.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20221220125349.45091-1-yangxingui@huawei.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221220125349.45091-1-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0590.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 601fb6ca-e7e9-4f72-5d14-08dae29ac5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JnVFa3XrwOySPk7IXpV2uCqOKjqz+xhxE7XbW1boPMstGWzg9kJAeBA54IcfOTH4C2Lq2Un72WBfbfBZc/JZHSrFh7Q2qYKMRHpEzBuuxYXvvXH05cjQB5ihCGdh9OHiEu+Zwxl1agImccfyx546tHB4cNgLRTHixdenLvyRNk9jABGb3JWStVpSQzN0Gk3urIy11bjY4TcDiPMWJ3+7QhRDDe2CuXY4T/VXMjUBJ8n0lRNPKOZkiTWgEKrUepGIpba87qRohdAT3skIjleTADVZJpeFfaSpznmNeqxAGnB/THDlUi5vD7NHvJhD9QnTnRYMANIfgnQHHU3Jzf9CfswVV4FD3yar9b0kbNRujrPSmykdpPkOyxA+VlZcDPTOOGSO10gWMPaSxQ9+u5VyyIgJ+MxWwEsrVyrWns5su6OtvCBDtEtWwvw3l6I17hwavmr+5nCZrzrCXJrPdzB9KGmdvCox8+b/dUg/Bt/uPpPK/LKQKFwReKkqvhk2ZKjsGPF4gPGTeTC9zFYD3J0tQjMtCDyXu/iUKR+MKRWW2VISaNrXvPpIdSUodnddAPaCp36zt2pPingwbieZo640gKp02dwYKnDArD0swpeiB4Ghoz4KFEDp43rtssCt4Wx7iByLrWp/lcR3JJ6ezxyjpW6HJW6ZqmTbFCC6D7Sl0pYZn2YVUsn+gQ4SSEMV3NCB2jo2zLmdcB25iXnkhAi63iJraaugs4Og0xoexaE+86M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(36916002)(31696002)(2616005)(83380400001)(38100700002)(36756003)(6666004)(6486002)(478600001)(186003)(6512007)(5660300002)(53546011)(6506007)(26005)(86362001)(2906002)(66476007)(8676002)(4326008)(66946007)(66556008)(31686004)(8936002)(316002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tlp0V0cvR1ZJeVQ3ZmtEN09aQ1FkMHdxQTFrV0RrSUZLUEtRakVGbjRiN09W?=
 =?utf-8?B?UFoySUZrUjBqSFh0SlQ2M3I4Qit0R3Y2RDZyZENBRDQ3ajdZdFhaNit0OW50?=
 =?utf-8?B?RGJ3dkFQd3h5NGRiZENHWjFnUExWdjlWdC9mcUhkc0xHNlc3M0c2TFRYL1hH?=
 =?utf-8?B?NjVTQU81SkFCc0VXNUpwdnpYSlFicWxhNEg1QklXRE9RdFdGSWw4L3Z1MExl?=
 =?utf-8?B?eU8za3ZZMUVZV1FXNStmZ1pGaUl0dWNaMDQ4TDZLblFoVFR2S2J5ajZBYVVM?=
 =?utf-8?B?YzhibTJGc1g5ckVsY25ieTBZMHlNZ2JwdE9qbjV4Yms4YTNMbDhSdnUzaXgv?=
 =?utf-8?B?eWZRT3pZTCsyN1p0SWhNMWczOUtZT29lNXJiZE90a3lZRHZYbEtkRmVIRnhk?=
 =?utf-8?B?RStCL0lVVllKejJ0bFlPZUxaWWRyUXIrUGQ3Z1lFWGNmalBGZkxLQkpWYStJ?=
 =?utf-8?B?dVlidjRZRWNtMXpoNGoxSmw5WEFlanBZVjBFaFlGU1FDWmIzVlF6MnYxZnA2?=
 =?utf-8?B?c3dMSE5qWWMwTDdDWmpqY0wyeWtaWXVLTWM4OFJYa2hCWVBHNUI0NlRaRUlS?=
 =?utf-8?B?Szg2ejVPQnpyTjBkM0tuam1iT0VSYjduSlY0bHZUSERtbzEvUEY5Yjk3bGR0?=
 =?utf-8?B?a2lKYTJkQllTS25DSFdFNStseXl5L0Noa1pGQUxZZU45SFlhaW5pQnRaQ2hF?=
 =?utf-8?B?R1B3OWVNbnBXRmlzK2g3SkZXb3FNRDF5V05DM0hKN20rNkoxMVZ3VjUzYmR3?=
 =?utf-8?B?aUFrbzlENzBOa3NjMFNtQnU2V2NNSmFXczArRmhpZ2pIbk5XR080V0FuUlN3?=
 =?utf-8?B?NVd5blFxdC9ZOFJqdDRxYWVOcnUxN3JmLzhmcmdscjlZWCtjTzZTSjQyVVY4?=
 =?utf-8?B?U2ZkQWtaRFprektQSGdjekIzbnByc0QxRDVGa3d5SWprMVhveHhXSjJncVVP?=
 =?utf-8?B?SU1ZUE50Ukc3TUwvZVN4RHZJRDRxQTB1a0pTbytpc2JJdWlTdDdGek1nWXQx?=
 =?utf-8?B?dVNwcWd0QkJiN21JMFpRMlk5N3NJKzROWUhiMCtTRkNXRFNibW8wakpPbFhh?=
 =?utf-8?B?N3VEbVlac1FtTXZzU2FWNktmWlJ2YUxGRFFKYUJ3eVAwZ01CUXQvSnhkRUhO?=
 =?utf-8?B?MllJSlFwemVFL2s0TnVpNWtiWXZsRkVOdkNqanlVUzZXQVRCTlFDcEU2czJm?=
 =?utf-8?B?NUVIQ2tHK0tkdjNPbFlWSHNVRUFxOW4rYWwrVjBMTXRadlNhSElYaERSNHh3?=
 =?utf-8?B?SytvVWt5dXA3N2ZkdktlOStwb1FiRGY1YUJkdU1sWEE5OWFETlovNnBIaWJa?=
 =?utf-8?B?QVQ0cHpjZERaTVdQeEM5UnExZWpqN01YSlZiRk1HTHJlZ0N3TEFUbGY4bzVN?=
 =?utf-8?B?NEVvNk5TSjVLaExlWm9LREZYdmpzblZKQ1ZTelduVlkxQVBBWThrZDBNa1A0?=
 =?utf-8?B?M3kxSTU3QnVsQXhaejhPOS90S1BpQ21tT0JvSXNpTVhSR1hPYWpmRElwQWJq?=
 =?utf-8?B?UG5adkVKcjJUdGNodUNtNWtzanp4THk3RlpPRWJJMjdpT1dodGNUaytaT0sr?=
 =?utf-8?B?SnpmS0tXZTlvNUw4RDVZTFVwU3FhTWFQZnN0eXNwQm5NR2laemdUSi9FMnZU?=
 =?utf-8?B?VUdudUNFV0ZmYlM1QjRVeXlUMnJVMXNxM3Zvc2R6UTdmK3ZMd2dGVkdvWWph?=
 =?utf-8?B?RUdxK0hpR3kvbVd5cjJsYi9WYzNnc2pibjRDRG5jUWFmL3NwRFY3REZwYlJk?=
 =?utf-8?B?cWNIN25OQUVOV1RHd1FtQWpCZHgyUUI3RFpPeFkyTXlIT3U4R25HZmM1THBQ?=
 =?utf-8?B?RjBxbDFTOFRCWUQrUGRvTGpoeWFPLzhQMVJQbEpFbWtxZUxpUDBERStKVzBa?=
 =?utf-8?B?QjBwMTZVcnBXOXZMZU0xSExLQW45TnhFLzkzaGtIVVB4cG1HMmNHSlFncU1y?=
 =?utf-8?B?bUE0aERyZ1h4UU1WM295NXJLeUwrRHY0aGljYkhYeUN0S0JQNnJpMjRWVEVK?=
 =?utf-8?B?TzJXUDJCekY5VkQ3TlppSGFoUnB4dlpWU0E4NTJvbWdGNW1hV2JkTnB0a1A0?=
 =?utf-8?B?SFlkOU5QdkdzNlA0K2VPSVpWRVF4d1dEVUluZXExWFl4dHJGbnJzeDJNNUxt?=
 =?utf-8?Q?jxFgkZQAETS+sF3Z+/1Tg+ny8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601fb6ca-e7e9-4f72-5d14-08dae29ac5ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 14:59:19.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBouSxGxFCURhEzRjbSyMqsWzSJJe+jJft1unobkE5XJlWZDumbrUROA+Z/8utAuT5azsMzNHEpBEfpWhiiiRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6467
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200124
X-Proofpoint-GUID: RVDK7yXE_e3eYipk1jgVeiIaSZKcYApA
X-Proofpoint-ORIG-GUID: RVDK7yXE_e3eYipk1jgVeiIaSZKcYApA
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 12:53, Xingui Yang wrote:
> Grab the host lock in sas_ata_device_link_abort() before calling

This is should be the ata port lock, right? I know that the ata comments 
say differently.

> ata_link_abort(), as the comment in ata_link_abort() mentions.
> 

Can you please add a fixes tag?

> Signed-off-by: Xingui Yang <yangxingui@huawei.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   drivers/scsi/libsas/sas_ata.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index f7439bf9cdc6..4f2017b21e6d 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -889,7 +889,9 @@ void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
>   {
>   	struct ata_port *ap = device->sata_dev.ap;
>   	struct ata_link *link = &ap->link;
> +	unsigned long flags;
>   
> +	spin_lock_irqsave(ap->lock, flags);
>   	device->sata_dev.fis[2] = ATA_ERR | ATA_DRDY; /* tf status */
>   	device->sata_dev.fis[3] = ATA_ABORTED; /* tf error */
>   
> @@ -897,6 +899,7 @@ void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
>   	if (force_reset)
>   		link->eh_info.action |= ATA_EH_RESET;
>   	ata_link_abort(link);
> +	spin_unlock_irqrestore(ap->lock, flags);
>   }
>   EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
>   

