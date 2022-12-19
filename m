Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E67365094D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiLSJYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiLSJYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:24:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B94DBC9A;
        Mon, 19 Dec 2022 01:24:04 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJ8R4Nv003408;
        Mon, 19 Dec 2022 09:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Xo7QR4orHeL2SZcD1kw8IbmLB4uDUJ8xDvQQeNR6Hhc=;
 b=hzPXjYmrMPosxAXZe6nNYlfyAp2OXgPV+XzqHALjhiIRQG0OeG4JZQfA5uGXnJBkxWpd
 t24ssktezW0NFCp1yPmZWytv1l5J/v6amAu+UXR6SnUaV1FED5+p7deUTVGlRjsgC8Kq
 IxtCUNV+z1dPA64D7bIWqgp+NxQolUR1b6WdjdLx8EVi8NLkdl3BkETlyNQhbyaYXJUV
 ydvCDsatUmk8hyA3RZd+kBvXnhJQqJ1kgmJdfMujiR9o39eUG+rs/IUzI+nJcBMMMyyP
 nEgrM7ZvLRKExKM9xF4djbT+mV/zLe0QiatPReZ+oIA6aGOS5ZA3gLo153aEGrkqDSTL OQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tstdyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 09:23:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BJ8F5Cv006850;
        Mon, 19 Dec 2022 09:23:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh479j798-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 09:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0cVWRVRjHwbgROAYbIf2JKvnYMPT0T/mBNinCZW+zj56rSx6S0LpzPmu7wP7AGVu5WS/2UnMxQPG2GaA8tF10I6OapGS4WwZvpkMWJmkkCQhURpC72XMZ96Dtvmzxn3yaNmCNepz34aGv1+NcCgCTfk8joohw5tC83fSKmYJGKFPv6CkIiYsq8GUh5LHMz7AERKaTQzAx8U+giy4FfWd4BG9vsJ0Uk75WApPYPEhHplN1lPi6C6n6LtNq62UQMSlRdTk2eed18DI7H3kU2FlycisbE8jRPiNwwvz7gz0SjvkRiUhcftAc/8oNuO5CxEbE7FbFhSiO7iCi6Dy2nGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xo7QR4orHeL2SZcD1kw8IbmLB4uDUJ8xDvQQeNR6Hhc=;
 b=Mq9kJ6GPmDDsu0kVGDj7zQgtOJt0xCV6l5+Jp6ZfJlVHkHC9kTHgKRMs3eTAalgbQnx7j00mwaewl02a4pi/R/Ma/5P7p+pFlaIaaXL7QY+r4H/9h9JHwqhYOB9PkpCp5Tp+pwm6gynOI8ZBcot1nDKgRTjBZnkaptT03o7EfalX9ZgRHT4EZXNCHSwW/HaqOl5MkCdhD2E2AcVdNg6WtVAkPyRyLbRfKE1MdE8B2g+GctbUePm1sjljbiY0S5F/gU5GpaoRdwdO7yHoOd+ijOSVKwGw3Mgcc0DDKUMwDqkXhn7obr43SA2uOyAghFdqmH0kJKQTpBhJXfCzkVQKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo7QR4orHeL2SZcD1kw8IbmLB4uDUJ8xDvQQeNR6Hhc=;
 b=n6wIKdfKGmdCeVbgE8qCsIC6WVimuF/nsXZXn4L1Mj3lNr2UJnwVIamcPGgwfoPMfr4SPiUwFBfgNytOhx36z1+3TSK52jCpaFR2uQC8QZuYX6dPWIjMeZeNXRJGvMrIAlgcpJi0HaizPnthLyzw2WSvvTqJf4ZHmSEo+aA/6r0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 09:23:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 09:23:08 +0000
Message-ID: <565fcf28-ec53-8d74-00a3-94be8e5b60e4@oracle.com>
Date:   Mon, 19 Dec 2022 09:23:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V2] scsi: libsas: Directly kick-off EH when ATA device
 fell off
Content-Language: en-US
To:     Xingui Yang <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, hare@suse.com, hch@lst.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20221216100327.7386-1-yangxingui@huawei.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221216100327.7386-1-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: ed17a9f7-cfba-46e8-03cb-08dae1a2a45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLbTh1v/2hFQzObjOcqJ+7p1CvPrTYwRatZERCYSjbNDm2X3amYJzQ9+twJAsWbRktvX0VR4e1rXkweP7kNtEQNObLr8P0zFrkVqs2UYOvZkoUBRAFEeaMXUsRhOD60VUF9noarHgs5KS4c8XbmFWTdovN+oG/XBY/T0ffDd4p1vXRVGRtFRpw62tKCeY1ooQY+OIoRS5udt8C269nXIHRlDVHY8kZhXdMP5yab/a2afI7NkD7S59hGxFhzQZkKIov1yFpBsh8OwCdvgQDn1istt4mfzPPUzsvF/p4zNAZkoJTfuE10AAEh2Fyu1AakOf88IQY5e1AeHpgspQsNYBIDSmn8p5ivTIORMwso69cuAMjdiYUD1MqiAMGRpycklmBsXUthj6f4rSim3llOSZqV7PP+yECYabAeQNRpmc6hEkZnHgsbVZy+OWetdHsOionlCry9jYU2Bh3eu1Iv6NkxR60rvOZjumQCROdTNQfgGhHrU7P84upAT8V2EYH/ivfk/Z5Tvnq2WQ4va6uEnUskAZDpIlSxc6CzkTCit480OISevBJT8HtPJZZSAy28ILLOLf2Wn7WeROcbvn4hsYPPcx6ccrA9S8djHjU97mPdA+CeSGLOw8etlEAV2PxE+Ofy8lH84bZ2uckUQViVYF5XKgkqvhP5S1Aqe2q/ouY06qvlk12qpCLwMOZFqcWo5hVFALllRJ6mvrw5VoF6QyiWhr7mLY7nS51h0FUJ34KnXDei16CFya0JE8pLBCLFY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(31686004)(8676002)(5660300002)(7416002)(4326008)(66556008)(66946007)(2906002)(66476007)(6486002)(966005)(36916002)(478600001)(6506007)(6512007)(186003)(26005)(41300700001)(6666004)(53546011)(86362001)(31696002)(83380400001)(2616005)(36756003)(8936002)(316002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDd3c0J0TWF6OC9PYk1CTnJpTFVSZmFiMndsWjZzb1c4a0hwS0VDb3ZwNG4z?=
 =?utf-8?B?UGZCNThJZkxLRTRGRmpEVFcxWENnRHFkL3JlOVNFRmsxaWNLR3ZZM2FKc1Fs?=
 =?utf-8?B?Sk45UXlldFBVU1lOcXlxMStMbFYveUNUNkR5NERKd3VhZ2FYbTlZTm1INUhB?=
 =?utf-8?B?cGxPTjRKa2oxaldMQllTaHZ4a2d4c3lnZ2NrNU1NbmJRRFQ1bk1OLzJJVmsv?=
 =?utf-8?B?aGlYQWJWbnkrRmM2bTFrZGtkb0JieFZUazJpbUxpN2ZzWmMxSGNQV1ZRRG9w?=
 =?utf-8?B?YmhwVmh2Rk44NHRWUjVzR3dZY2IyMmFqUjZHbkxKOXpMVENIRXlHaENXb3BS?=
 =?utf-8?B?d0d4VWhSUS9UTXoyQUk4TnIxeEN1ek50eWEvc0ZHOTVNZW1acVVKZUsrams1?=
 =?utf-8?B?MSs3cUhVWWZ3dThROGZUK3FkNUJjL3laREdxMzhERnNJVksrK2w1R3h2cnpQ?=
 =?utf-8?B?cjVzQ1BSMVFVdVRBWlJFM1EzUnR5R0dhdW5jMjFlc045N0hPdTdPK2wrUlBl?=
 =?utf-8?B?aVc1NE1OdXhJYTdZNVFhQ1NTOFQ5OTkxSXVKWm9UZThhWkVibXJMUmxLUDdl?=
 =?utf-8?B?THBPVitiMGFScXJVa0ZHcUFKMU1DVzk0ekczM1Nqc2NQUFllNmNWNU5MR0d5?=
 =?utf-8?B?OWM3aTlkeDlTZXlIWGQzTDRZNkhBZHZ0UWlyb25na05mci9FZFVJSURSdk1u?=
 =?utf-8?B?SG1aZ1dVMVNkSWMzME1qajdGT1JNQnl4eFJhM25CdWRuYTVxRDZiK2VSRklk?=
 =?utf-8?B?NmtWemVFTkt1RlNUS20wcyttWTU0T0JiVU1iaFpmL0tnYTYwR1lzZjBWbmRI?=
 =?utf-8?B?REdnWEVza3R3WXVOYWFpa3JIdEJRUmFsMHVzUmhoRm9KdzZBbGRqbzV6U2lT?=
 =?utf-8?B?cXdqc1Flb1VQSnFSMXNFeHBpSDdTZkJra0FMWGVLemszTFFhVU10S2VydXlr?=
 =?utf-8?B?K05xNTBja21xb1l1c1liNjBLN1FrOFpaTk1HbUZNRHdWT05IZVU5MUtrdk5t?=
 =?utf-8?B?amFGU1l5ckhHeHgrMlc0NEpDbTJvaDFQTi9HSDg0TVQwQjVnWkhjS2lZOW9v?=
 =?utf-8?B?Rk1Xd1FUR2xUbUZDQXRuQ1ZPaUZScThXc1l6bi9vSVcyS29rcm1UTjBOanhU?=
 =?utf-8?B?OHdpNUF3cHRzUk0vamxpQUZQaGZIMGdwMjJyUE5EV3hPamNyT25BeDJodFo3?=
 =?utf-8?B?bHdGUTlwMzFkTGYwOWUyVWtUT01EYXhpQU9qQVQ3WUlDT2NiRkhvT3FqMElt?=
 =?utf-8?B?bUNnRVNob3FXYktxRjM2RVRRcktScnBITW5EZm1SemkzWlhyVDh0T1ZXV0hw?=
 =?utf-8?B?YzFmNTNMWmdwbGJFRGVLamVLNHRza1NmN3Q4UGh1elNVRTZIejlWTVlWdGlu?=
 =?utf-8?B?SE5sajA1N25rQUpDOG9wWkkvSEkvdjZkeFpvNkpZZm9OcTlqZEZNdWpmdDUx?=
 =?utf-8?B?cHg1ejQyakROUVU3cGo5cEp0V2ZaaGRUdk16ZWorcE5oMy9xK1UxbGpjSkdN?=
 =?utf-8?B?NmNjdEd2YnBxeXM3NWEwMWhYUHZscDVMZW00eU1hcWUxRnQ2c01oMjBXdi9N?=
 =?utf-8?B?dFZJYlFpZDR5RmhmSUc1c0lCeUhmOC9wcjdiVTZXYmZNL2N3ejlSa0pzOUlt?=
 =?utf-8?B?RFNyWVd2RHlkS3ZORmhVR3VlN0IvL0Q5N0s4QlNaVlQ3VXloVVVaVGtlOExQ?=
 =?utf-8?B?cVZTbm5XWTY3RUVJYUxqdDJUNVkrQWlLZHJ6UFRSVW4ySSs1ZzhEK2cyaWtH?=
 =?utf-8?B?YUpsQXJIem5scmR3b2Y1NXN1c2F3QU9Ock1xUU5UREpsTE8rV2pINFhqT0Nx?=
 =?utf-8?B?SG55am9qQktXZnhldE9jVG9CT0pDcmxZVUNVQ0lHV1U4Z0tQbEVnLzYvMmFM?=
 =?utf-8?B?S0k1OWF5TUhZRWE2TkIvcGEvbVhma2d5N2tUbTZic21zT2VzUnJuZlRmeEd5?=
 =?utf-8?B?cTZlVE5jSndrUDUwWGR6WDdROFVvWnlnWDZxcDcyMnprYVBiNXdoUW5MSGNZ?=
 =?utf-8?B?MGJMR3VWUnEzbUNwZ1EwREpMUjNOUEtoTGY4dDdYWnU0RmEzMm9NQUpNN3A3?=
 =?utf-8?B?aXJQZnBNQmd3WlVUQzMydDlvM3VNNUY1THJtcHJIV2JnMlplMmY1M3Z4SWcr?=
 =?utf-8?B?WjdGNGlpMllIdzBDTWNmR203M2lIREkrUHdFd2oyV0pQeWZTclJiOGc5aXI4?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed17a9f7-cfba-46e8-03cb-08dae1a2a45e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 09:23:08.6967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyawhX828cl83Wq3RvcFmR/BSZ+IB82+artnQFW3QV0EgHXsLKRHr2GN5pPhDkVipHbasUYKwJz57/vzgdy70A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-18_13,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190083
X-Proofpoint-ORIG-GUID: x6wjCMK8UssQd5GbOpzY0gD1zlNNTfHa
X-Proofpoint-GUID: x6wjCMK8UssQd5GbOpzY0gD1zlNNTfHa
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 10:03, Xingui Yang wrote:
> If the ATA device fell off, call sas_ata_device_link_abort() directly and
> mark all outstanding QCs as failed and kick-off EH Immediately. This avoids
> having to wait for block layer timeouts.
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
> Changes to v1:
> - Use dev_is_sata() to check ATA device type
>   drivers/scsi/libsas/sas_discover.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
> index d5bc1314c341..a12b65eb4a2a 100644
> --- a/drivers/scsi/libsas/sas_discover.c
> +++ b/drivers/scsi/libsas/sas_discover.c
> @@ -362,6 +362,9 @@ static void sas_destruct_ports(struct asd_sas_port *port)
>   
>   void sas_unregister_dev(struct asd_sas_port *port, struct domain_device *dev)
>   {
> +	if (test_bit(SAS_DEV_GONE, &dev->state) && dev_is_sata(dev))
> +		sas_ata_device_link_abort(dev, false);

Firstly, I think that there is a bug in sas_ata_device_link_abort() -> 
ata_link_abort() code in that the host lock in not grabbed, as the 
comment in ata_port_abort() mentions. Having said that, libsas had 
already some dodgy host locking usage - specifically dropping the lock 
for the queuing path (that's something else to be fixed up ... I think 
that is due to queue command CB calling task_done() in some cases), but 
I still think that sas_ata_device_link_abort() should be fixed (to grab 
the host lock).

Secondly, this just seems like a half solution to the age-old problem - 
that is, EH eventually kicking in only after 30 seconds when a disk is 
removed with active IO. I say half solution as SAS disks still have this 
issue for libsas. Can we instead push to try to solve both of them now?

There was a broad previous discussion on this:
https://urldefense.com/v3/__https://lore.kernel.org/linux-scsi/Ykqg0kr0F*2Fyzk2XW@infradead.org/__;JQ!!ACWV5N9M2RV99hQ!MwAZFXXIwuP0lv-kuUIJ0ekUiGBWlTBhU3oQjyOf_yuP1rHDJb8UKMzJjndXNQ-W1PQGJXzgc0bQUsHh4NGh21EOc50$

 From that discussion, Hannes was doing some related prep work series, 
but I don't think it got completed.

Thanks,
John

> +
>   	if (!test_bit(SAS_DEV_DESTROY, &dev->state) &&
>   	    !list_empty(&dev->disco_list_node)) {
>   		/* this rphy never saw sas_rphy_add */

