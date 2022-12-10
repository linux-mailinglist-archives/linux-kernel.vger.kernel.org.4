Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB876490EF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 23:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLJWFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 17:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJWFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 17:05:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E691F6269;
        Sat, 10 Dec 2022 14:05:30 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BAJ1wqo022707;
        Sat, 10 Dec 2022 22:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=voKTJi3HY8b+kugqzLW6Aeg3HVzgHVv2/Hus2dvKQEI=;
 b=RyMXl/sSwupjyRNLk9ZI9dN0u+zP/0+yZemQ38hnzGAj4Nmuz6FQZ9+fTwQIAjrUNS1W
 yRcjZEkkzkaa/umkSr4446nqMEAlHPngmf5+dF5s6eYU6RqWN/QyU2Ed3J64H68cQica
 iiEBFFJXiVfiJ/vCWTYWrM3oeXWnbbzxEU1qRzqR78fbGq6nU9js7Tv9WBFuT20E+9wu
 VG295xsAIWq/4J0LL66tsjo37qCRKyVde525NHnhnK5nBohyHt9VHvSerTHmXNVJDFbC
 AmDiiAKTX9NNexzlrielwisKn9Dx4neHdzlkWA1YoSLj7jBLjAOYAmnQUj2EM6LjSfmv fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcjnsrnt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Dec 2022 22:05:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BAJ0IfE014056;
        Sat, 10 Dec 2022 22:05:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj8ar1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Dec 2022 22:05:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9SBC2+PY/Y6IFfVdTpo+7KkDvSQpYDFxtpQtfwY2p4CHOozLn1FQyYm99C9eZCCjkn61drkLJ8U6GpkS0LIUEcKFwn+n8YZsuHyNGkX18hKDyj7BsQiXZ4f6K0SKDYxBqT0TK+yx1YKmVR2MUPe+9OJ8fniEW6kDNyvKBprYlChLKoj4sxmVLLaaB6tQwwhDULze0Bnib5+sPrrGaUF80CKFgLBwVr+Epx61lzc/F2pG2NaUhzxfZNUOt8+qqd1D32mXrBeFqmWWaCEAsdnMJXptcGvz5bM1ZuoccyYlzZFXC29xlVlYlIZJoyF2QmHH9taHblQ373jM/jdMSWbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voKTJi3HY8b+kugqzLW6Aeg3HVzgHVv2/Hus2dvKQEI=;
 b=EV/eHHhNiyVN5PpyBBMqQvXbWJMZJWPuEmS9eOrOHwx+eEQZ41Zzl7GPWz4daLm9yh6wuOa3mvXhkY8iG9+pdEsx79owWNv3cXl6Xow2dd+E/3NPQDIWpFMmkgAXjKYr6qXpA/oaDdg4b1fQQysJoxxk6xwyTLUOT98OqbY2UW3SF6HMQWnxzV9yW0CghQGY9GMnUzWfwZeVrLDR17ZB3YdBhlLSAAUq4rEdyQ22aLHCe+WAQmKF6TwA//mO75fg7OjrRHOIOEiMnJI/31renKuw/nmmWPr3Y5ehQAIZRwOig+Ly48lE0jk2QEoLGFLrr6tKcCXaiI0H1bCEi5VJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voKTJi3HY8b+kugqzLW6Aeg3HVzgHVv2/Hus2dvKQEI=;
 b=CGmBxe/fA+YYcaYafpy/g14XGoKkWD9cHhmXU1ROItQL2L1CC9ufY6x3t5tTltVviMgtGghp6qfEDT8BFOT7qmp4cWeyXH+ZTsO7ql8LkRT7aC8UayNbESlWw1UWCQPT9wL+CpzAtpElkwZUpSWleh+PdkdY0LDpqwhZ9XGN5jw=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CO6PR10MB5588.namprd10.prod.outlook.com (2603:10b6:303:147::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Sat, 10 Dec 2022 22:04:56 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::2dbb:4791:5a67:4372]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::2dbb:4791:5a67:4372%7]) with mapi id 15.20.5880.019; Sat, 10 Dec 2022
 22:04:55 +0000
Message-ID: <ae9ee90e-e890-e054-6cf9-8acadd6012b9@oracle.com>
Date:   Sat, 10 Dec 2022 16:04:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] scsi: iscsi_tcp: Fix UAF when access shost attr during
 session logout
To:     Ding Hui <dinghui@sangfor.com.cn>, lduncan@suse.com,
        cleech@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209082247.6330-1-dinghui@sangfor.com.cn>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221209082247.6330-1-dinghui@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:610:cc::25) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CO6PR10MB5588:EE_
X-MS-Office365-Filtering-Correlation-Id: 4188e681-faaa-4c1b-0c3e-08dadafa91c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D87CF7lJ7wq2R6D7qGQNrLoCTzzzfQifUwjOc7MymgAMyDKZrUqPs0LKI2LjPe81ATFpHKXNbLOA7XRuAgVswLtauDRO35eFQlQ1ZyzPy1DUn8ny3/Krwun2AN0SJQv4+jW7QDvRQVWoeaGj2oYsNjM1f1PrrNSSynloyVX03PbqzZieuifg5a7uOtFgpj84G5tFh+IruGEIhOYApb2OvJEHHfA/iLneTycJJh5DcX0Xz22M8rQA9I76Jc3D3+qrrovKX/glr50eIspDb/xneYb0L+ooesJ9A5LYmlNBDKhyZ/ZL39OM8mrFa+gFI9BUEYrXE54drf72bzjmXYL3AGRbOovYEU39/gqPZB8+N/evVh+nWTapysLwISlmUPXn5wOFDlzlHtICHLubV5f1Z2+Vu82xcCkZfLYvM6Es5v5IMCY90LblpbEYvbKFn6E97bL5AiNmRTe4GHvriefLCU9nivwlEq6g+CyNNUcMhKMIDp4tcjZnPOJ2sGeUIUpdsH/PH+gIA2QaVJaqhwRjEXcPk2ryJfPK2/60q9xrcnW8d9ItIgL/ihdY/EG6stH7U14/Y3CymWF6w5KzqDd4NcBAQbP6zRONcMFgJCVEBWeJLGqk9upUUXPH4QNxkNCxfH4uY4DzbOF7qeJoH51c57jL2+MbSMKST+L4luILJzepZwnms8mxPhqkEZPXlJ5aw3SEGZfAFcd7fWTB5ofp+9vkIWZoIjke7OfotuUoMyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199015)(83380400001)(31686004)(2906002)(6486002)(478600001)(86362001)(31696002)(36756003)(2616005)(186003)(38100700002)(5660300002)(6506007)(41300700001)(26005)(8676002)(6512007)(53546011)(8936002)(316002)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0w0UkJ1Qm5WTTEwbHNxR2JMK2NDR2xQMDFkZkdXRHNhMDJGd0NvRjNVeXRr?=
 =?utf-8?B?SzdtaUx4YmRjZVp5L2MyeUJGNjFibUdrWWZxYU01cVpuV05tdk1ZQmpCaHlC?=
 =?utf-8?B?VUxvUzFyNzhuYTc3ZWpmYkRURVJaZ1pwUEFWY1hVYzdBSUhmY29ld2FncjZH?=
 =?utf-8?B?eno1K2k3bFAwUkJPSWtzdEp5RVNOaWVLdXJDTFVaa1lCbnp2WGhZaTNkWkwy?=
 =?utf-8?B?dFpRMGNmUWZIZHl2SnVyNmdTYUpnZlhrTnBiM2dPQlNsajJIVjlTa2draTda?=
 =?utf-8?B?VllKZjU1ZmliZW04MWlDM280MVFhUFFxRXVxbFp4MnFLOGFBb1JmT0l6ZWpj?=
 =?utf-8?B?TndRZ0VHTXp6c3Q3UENEcVA3S3lnVEJTRExtOHZDVldFejJiWUp0Z1FOU3d3?=
 =?utf-8?B?Vmo2SWVSL0Q3V1lHbUJJbG5xR09nUTltNnhyWVJiZGRYTjF1S0NvQ0pYaFZS?=
 =?utf-8?B?TmJ3bDU3YjdRd3Zqc3ZCUkg1OHFvZmdjbyttTDd1UWVrNVdkenA5YUo3YVFZ?=
 =?utf-8?B?empSOHBnajQwVjQ2TjByR3pVVk9vaUVDZlFDN2k3aVFvV2RnZXF0VmdyM2xE?=
 =?utf-8?B?VmlrSDQvNXZSa20ydEgveVdhMnFJOVJveCtsaFpEZ0pqY042UDJCcTkrNVpG?=
 =?utf-8?B?SHhQckh6UWpWVmxtL0paWWM0SnpPSnk5Z0lMWHFzdnN5UkJmVGRDSGZxVDlx?=
 =?utf-8?B?M0Y3T1d6b005QnFOUUJpZ3FuMDhrZXJmUE1KQU9DYWplSjZwUFhreCtPMFI0?=
 =?utf-8?B?cVhMa1YyNHNDTnJybGJGOWVjK0Jzd2FBM3VIZE10SkE3U0dmcTZTaGpLUzdh?=
 =?utf-8?B?VjFsZkpQRVBUNWgxQWplT3BrZjZSRHVhd0ZJaFc4T1FJeXhDSmhyb0ZDUlVD?=
 =?utf-8?B?TFBNV2ZmeE5RREttKzlzbkRRQVFuNHVZZW1sU3NqSXhzMVdTMTF3VVZhY1gx?=
 =?utf-8?B?dnU0SE1rVEN3azNJZ1gwWkVZZDNqNFBhYmZieHE4ZXV6czVDTVd4VCsvMjVU?=
 =?utf-8?B?bEo2cC9qNGJUSDl1aHcwM0N0TENsVmVHSEhqY3ZwOWVxcmNGTkUzM25HWlBH?=
 =?utf-8?B?dGRxSnBMbkhnN3lOUmNhVHY0UVhLYkl0TmlUZ3BJcUJCakkxMkxkclZQcE1Z?=
 =?utf-8?B?VytwZDBVM3I2VjJXV0pwNkQzdUk3YzFUdXY2RWN2VUEzZEFGYnhTYlVMaTVH?=
 =?utf-8?B?REt2eVJtVjZKRWd1eVY2OThncXNTSjlWTmlTcXpETVUvV3ZOMEhZaHNZSVkw?=
 =?utf-8?B?b1hKakZTbm5ZeU1zMFdkM0I5RVc0R2NWWjQzUEhZUnpSakgzbHdOcDYvK0Vw?=
 =?utf-8?B?ZUZ4WWsraWRrd2RodnBaaGZiWmZJelBJcWp5eUNYVGpHRUI1T0NHY0VrZU93?=
 =?utf-8?B?VzYvZ2JLYThiLzd1cmw4Z2E3WUFzZ3V6MkxTVzMxdkNPMnJBaUtNRmJIU0NU?=
 =?utf-8?B?R2syMGxKcmlrTUpZRzdTVkd4TFg3Mll1clRtUytLOFB5cjJlbFhqVVFqRWFr?=
 =?utf-8?B?TmtnQmRkQmltbGJ6MzFhOVRwRk0wVmhRR3FCNG5sc2FKVWxmMXhsRDA3aUdM?=
 =?utf-8?B?QzI5V04zemFzU2J6NFkwUWg3UXlyM1YvSUVnNmtPYnpKTldGQWg3QmJpSi83?=
 =?utf-8?B?ZXdoSmtxYlc2aWlJRWd1TzVXZ2g2U1piTEQrY3lJcURlQXFISS80aVJ3K1RN?=
 =?utf-8?B?VlZTdW1OcHVjcVFuWm5vK0ZkbWE0Y0FxbVczTHRSeVdHU09POFd0RnRieGhq?=
 =?utf-8?B?Q3MvbFFReWJFYkJGT3JmTkZaNHR5RnhVUlE3UWFjWjQ5T0dpVG9xUWZBLzVr?=
 =?utf-8?B?NzJsTWwxTDgyUUt1b0drMmlEbXZReXJKZHRjVDhZOFF2Rnd4bDFrYlNnRThv?=
 =?utf-8?B?RXd2QVJqQXdGMXU4UEVVQ1c2MmxRMm5YK1VLSVl5dFlzbW1vMTFUVy91dFZ3?=
 =?utf-8?B?UGhMOXZLTjd0YlFiWGdHR1kwVndFcjd3UWxxbkdlT1NuLzBEemJCWGVtT2pp?=
 =?utf-8?B?MFEwTmdPNlQ2Y0Q0MFdXa0FqUnJDL0g5bTBNZ1MzbU5mTHVsVENMV0hNOFZ4?=
 =?utf-8?B?c3N2MC9pcFIxVGpJVmNUdFFINEpETnVsdTRxQnVlWWhHdVZLMEd5a2ZKY0l6?=
 =?utf-8?B?QjBmU0ZYNlhZc09ZRVpnUisyWGZOZDNhaEdROGRXODE2VW9oNzlpUjRIS21j?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4188e681-faaa-4c1b-0c3e-08dadafa91c0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2022 22:04:55.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMa4kjLrhIDxq06QkpEz75vdIXwPpT0g80YPAVCe6KCDQbe5MoLFqiw6yNWoHH3kiMiL/bhslf5oe3xf2cbRwSAYaONLmqtivQQ/AXxp4n4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-10_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212100204
X-Proofpoint-GUID: uYiObBPwFGxV3j0M8pPuAHzyjZlsOEVV
X-Proofpoint-ORIG-GUID: uYiObBPwFGxV3j0M8pPuAHzyjZlsOEVV
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 2:22 AM, Ding Hui wrote:
> During iscsi session logout, if another task accessing shost ipaddress
> attr at this time, we can get a KASAN UAF report like this:
> 
> [  276.941685] ==================================================================
> [  276.942144] BUG: KASAN: use-after-free in _raw_spin_lock_bh+0x78/0xe0
> [  276.942535] Write of size 4 at addr ffff8881053b45b8 by task cat/4088
> [  276.943511] CPU: 2 PID: 4088 Comm: cat Tainted: G            E      6.1.0-rc8+ #3
> [  276.943997] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [  276.944470] Call Trace:
> [  276.944943]  <TASK>
> [  276.945397]  dump_stack_lvl+0x34/0x48
> [  276.945887]  print_address_description.constprop.0+0x86/0x1e7
> [  276.946421]  print_report+0x36/0x4f
> [  276.947358]  kasan_report+0xad/0x130
> [  276.948234]  kasan_check_range+0x35/0x1c0
> [  276.948674]  _raw_spin_lock_bh+0x78/0xe0
> [  276.949989]  iscsi_sw_tcp_host_get_param+0xad/0x2e0 [iscsi_tcp]
> [  276.951765]  show_host_param_ISCSI_HOST_PARAM_IPADDRESS+0xe9/0x130 [scsi_transport_iscsi]
> [  276.952185]  dev_attr_show+0x3f/0x80
> [  276.953005]  sysfs_kf_seq_show+0x1fb/0x3e0
> [  276.953401]  seq_read_iter+0x402/0x1020
> [  276.954260]  vfs_read+0x532/0x7b0
> [  276.955113]  ksys_read+0xed/0x1c0
> [  276.955952]  do_syscall_64+0x38/0x90
> [  276.956347]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  276.956769] RIP: 0033:0x7f5d3a679222
> [  276.957161] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 32 c0 0b 00 e8 a5 fe 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
> [  276.958009] RSP: 002b:00007ffc864d16a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [  276.958431] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f5d3a679222
> [  276.958857] RDX: 0000000000020000 RSI: 00007f5d3a4fe000 RDI: 0000000000000003
> [  276.959281] RBP: 00007f5d3a4fe000 R08: 00000000ffffffff R09: 0000000000000000
> [  276.959682] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000020000
> [  276.960126] R13: 0000000000000003 R14: 0000000000000000 R15: 0000557a26dada58
> [  276.960536]  </TASK>
> [  276.961357] Allocated by task 2209:
> [  276.961756]  kasan_save_stack+0x1e/0x40
> [  276.962170]  kasan_set_track+0x21/0x30
> [  276.962557]  __kasan_kmalloc+0x7e/0x90
> [  276.962923]  __kmalloc+0x5b/0x140
> [  276.963308]  iscsi_alloc_session+0x28/0x840 [scsi_transport_iscsi]
> [  276.963712]  iscsi_session_setup+0xda/0xba0 [libiscsi]
> [  276.964078]  iscsi_sw_tcp_session_create+0x1fd/0x330 [iscsi_tcp]
> [  276.964431]  iscsi_if_create_session.isra.0+0x50/0x260 [scsi_transport_iscsi]
> [  276.964793]  iscsi_if_recv_msg+0xc5a/0x2660 [scsi_transport_iscsi]
> [  276.965153]  iscsi_if_rx+0x198/0x4b0 [scsi_transport_iscsi]
> [  276.965546]  netlink_unicast+0x4d5/0x7b0
> [  276.965905]  netlink_sendmsg+0x78d/0xc30
> [  276.966236]  sock_sendmsg+0xe5/0x120
> [  276.966576]  ____sys_sendmsg+0x5fe/0x860
> [  276.966923]  ___sys_sendmsg+0xe0/0x170
> [  276.967300]  __sys_sendmsg+0xc8/0x170
> [  276.967666]  do_syscall_64+0x38/0x90
> [  276.968028]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  276.968773] Freed by task 2209:
> [  276.969111]  kasan_save_stack+0x1e/0x40
> [  276.969449]  kasan_set_track+0x21/0x30
> [  276.969789]  kasan_save_free_info+0x2a/0x50
> [  276.970146]  __kasan_slab_free+0x106/0x190
> [  276.970470]  __kmem_cache_free+0x133/0x270
> [  276.970816]  device_release+0x98/0x210
> [  276.971145]  kobject_cleanup+0x101/0x360
> [  276.971462]  iscsi_session_teardown+0x3fb/0x530 [libiscsi]
> [  276.971775]  iscsi_sw_tcp_session_destroy+0xd8/0x130 [iscsi_tcp]
> [  276.972143]  iscsi_if_recv_msg+0x1bf1/0x2660 [scsi_transport_iscsi]
> [  276.972485]  iscsi_if_rx+0x198/0x4b0 [scsi_transport_iscsi]
> [  276.972808]  netlink_unicast+0x4d5/0x7b0
> [  276.973201]  netlink_sendmsg+0x78d/0xc30
> [  276.973544]  sock_sendmsg+0xe5/0x120
> [  276.973864]  ____sys_sendmsg+0x5fe/0x860
> [  276.974248]  ___sys_sendmsg+0xe0/0x170
> [  276.974583]  __sys_sendmsg+0xc8/0x170
> [  276.974891]  do_syscall_64+0x38/0x90
> [  276.975216]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> We can easily reproduce by two tasks:
> 1. while :; do iscsiadm -m node --login; iscsiadm -m node --logout; done
> 2. while :; do cat /sys/devices/platform/host*/iscsi_host/host*/ipaddress; done
> 
>             iscsid                |        cat
> ----------------------------------+-------------------------------------------------
> |- iscsi_sw_tcp_session_destroy   |
>   |- iscsi_session_teardown       |
>     |- device_release             |
>       |- iscsi_session_release    |  |- dev_attr_show
>         |- kfree                  |    |- show_host_param_ISCSI_HOST_PARAM_IPADDRESS
>                                   |      |- iscsi_sw_tcp_host_get_param
>                                   |        |- r/w tcp_sw_host->session (UAF)
>   |- iscsi_host_remove            |
>   |- iscsi_host_free              |
> 
> Since shost hold a pointer to session which is belong to cls_session by its
> priv tcp_sw_host, so we should get a ref of cls_session, and after
> iscsi_host_remove() the sysfs is cleared, then we can drop the ref.
> 

Nice bug report and thanks for the patch. I think though we should just
split the removal from the freeing. The removal will wait on users
accessing sysfs files for us, so once they return we know we can just
free things.

Something like this:


diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 5fb1f364e815..751e4b19798b 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -982,10 +982,12 @@ static void iscsi_sw_tcp_session_destroy(struct iscsi_cls_session *cls_session)
 	if (WARN_ON_ONCE(session->leadconn))
 		return;
 
+	iscsi_session_remove(cls_session);
+	iscsi_host_remove(shost, false);
+
 	iscsi_tcp_r2tpool_free(cls_session->dd_data);
-	iscsi_session_teardown(cls_session);
 
-	iscsi_host_remove(shost, false);
+	iscsi_session_free(cls_session);
 	iscsi_host_free(shost);
 }
 
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index ef2fc860257e..235957de1164 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -3104,17 +3104,27 @@ iscsi_session_setup(struct iscsi_transport *iscsit, struct Scsi_Host *shost,
 }
 EXPORT_SYMBOL_GPL(iscsi_session_setup);
 
-/**
- * iscsi_session_teardown - destroy session, host, and cls_session
- * @cls_session: iscsi session
+/*
+ * issi_session_remove - Remove session from iSCSI class.
  */
-void iscsi_session_teardown(struct iscsi_cls_session *cls_session)
+void iscsi_session_remove(struct iscsi_cls_session *cls_session)
 {
 	struct iscsi_session *session = cls_session->dd_data;
-	struct module *owner = cls_session->transport->owner;
 	struct Scsi_Host *shost = session->host;
 
 	iscsi_remove_session(cls_session);
+	iscsi_host_dec_session_cnt(shost);
+}
+EXPORT_SYMBOL_GPL(iscsi_session_remove);
+
+/**
+ * iscsi_session_free - Free iscsi session and it's resources
+ * @cls_session: iscsi session
+ */
+void iscsi_session_free(struct iscsi_cls_session *cls_session)
+{
+	struct iscsi_session *session = cls_session->dd_data;
+	struct module *owner = cls_session->transport->owner;
 
 	iscsi_pool_free(&session->cmdpool);
 	kfree(session->password);
@@ -3132,10 +3142,19 @@ void iscsi_session_teardown(struct iscsi_cls_session *cls_session)
 	kfree(session->discovery_parent_type);
 
 	iscsi_free_session(cls_session);
-
-	iscsi_host_dec_session_cnt(shost);
 	module_put(owner);
 }
+EXPORT_SYMBOL_GPL(iscsi_session_free);
+
+/**
+ * iscsi_session_teardown - destroy session and cls_session
+ * @cls_session: iscsi session
+ */
+void iscsi_session_teardown(struct iscsi_cls_session *cls_session)
+{
+	iscsi_session_remove(cls_session);
+	iscsi_session_free(cls_session);
+}
 EXPORT_SYMBOL_GPL(iscsi_session_teardown);
 
 /**
diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
index 695eebc6f2c8..5cdeff776ce2 100644
--- a/include/scsi/libiscsi.h
+++ b/include/scsi/libiscsi.h
@@ -422,6 +422,8 @@ extern int iscsi_host_get_max_scsi_cmds(struct Scsi_Host *shost,
 extern struct iscsi_cls_session *
 iscsi_session_setup(struct iscsi_transport *, struct Scsi_Host *shost,
 		    uint16_t, int, int, uint32_t, unsigned int);
+extern void iscsi_session_remove(struct iscsi_cls_session *cls_session);
+extern void iscsi_session_free(struct iscsi_cls_session *cls_session);
 extern void iscsi_session_teardown(struct iscsi_cls_session *);
 extern void iscsi_session_recovery_timedout(struct iscsi_cls_session *);
 extern int iscsi_set_param(struct iscsi_cls_conn *cls_conn,

