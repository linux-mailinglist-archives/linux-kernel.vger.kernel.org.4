Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CE660FCCB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbiJ0QSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbiJ0QSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:18:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9EF1849B5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:18:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RGDdAe026503;
        Thu, 27 Oct 2022 16:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=R1RhqaKB/eByg5YGJqSEUBMqfcvtpBpm5w47d6fwo0k=;
 b=XdQIsfEWmx1XPi+c82Ru9K7if2boS8I3817yPLUn/dvquSs4U6Vp0rTJikFbpEAik9mP
 57Cbj/XaSfVpkdc/J4NvbMpcBz2kgmPlH886uCFLozs3pF648omnLwHqVnWvipctofbN
 CHVTxGUDeQwzP9VepmxmZvCA90NOqVAOQoCt5GXpk5e9eN0RnWMoRs+dhzCXQ+20Jpt0
 Jq3xV1ny2OzzPl22OBfjcWUWoTfzM+aUZcRN8BwttT2ux+M5XgxRlrG6UgQcynwsSq17
 b3Ow5a/DEo4G5oP1JjubRKjJM/LeMg37FCon5Gj+f89s45pO8UPEZW30NRV0PpZFNen8 /w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawrtk81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 16:17:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RGApAn006562;
        Thu, 27 Oct 2022 16:17:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagh4hwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 16:17:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmXmTpZVJBfma4minNIfCY1OuJS9wkrTJVMTwvhH/79Pa15oICUGbHgPgSgBf9p4o4OVvIwgog/0WCt1dl0YguRWJxSW/589OcJJunlhS8djEKHjQ3ieUTaj84ZgT8Qup+drB6yLifOiIJat0NmlpFhTRlUubgghKFh98IbWgxb4AOFkM5/DzPUKWZRe787ckS4ZrwHnkrehSwMIFHXYkH98xPYNC1VUJ2xvnlv5t9qH0XLelUfKwxSNXGKaQafckaT4ggxGprxs9jgDIYMMnGRMX/8EziBVbHRpqUjfUvtpVZJKEhIK/y4fkJOsa/Y4n1C07qKD8l9m8MbJSV8ZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1RhqaKB/eByg5YGJqSEUBMqfcvtpBpm5w47d6fwo0k=;
 b=L//ySCOQCMK3yO4tEME93tMwAHWF5P6oJmCpf+oPho7Z1xhV8ohjNE1Tnl01j3F5SXFyagQ2pW+9TInsTwdcmMlAyMVCYKYbVRiQWcjj2gxpXAba1nnaDwz8l3ZKj4OiIPpUgyOAq1R1K73Oym/kt/zxotYpOR8kRJxcADOX6Y4/dUH/oAr79HD9YKgYrIIIrsvYBys/BBidi1qikhGv9HNTu9H+KhCI9cSEQG5G5Obcib05dmXHmf8sNK3z80FIgvpLpLQQ9LECwnQ66iYde3ZF1Iabc336pK9nisycfIYH6Q/tiQqQ/nIxD2bxRSi2A7AUaZc1vbRaH774D22/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1RhqaKB/eByg5YGJqSEUBMqfcvtpBpm5w47d6fwo0k=;
 b=ajqTOTWaGY5INjdIWx2fPDhQfEh6RMPM+vax4Z8HLCgjtjAipY+yqxhKSXYkxxvuKMK4xxfkhUvB72gDC8v8N5iL74ZUBVjnyYFpmrkOFSqD8xSjLKas7gwYSfA+Y4fS8qUnUpu34pFnYRO4LHZ7fmZvyfogAdFQxRRvx3SredM=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by MW5PR10MB5808.namprd10.prod.outlook.com (2603:10b6:303:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 16:17:29 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::acd:f6fb:e646:9ff2]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::acd:f6fb:e646:9ff2%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 16:17:29 +0000
Message-ID: <d48fdd31-c989-e610-f9be-5c51a0a1402a@oracle.com>
Date:   Thu, 27 Oct 2022 09:17:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] perf/x86/intel: Hide Topdown metrics events if slots is
 not enumerated
Content-Language: en-US
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, joe.jin@oracle.com, likexu@tencent.com
References: <20220922201505.2721654-1-kan.liang@linux.intel.com>
 <91d8d712-f20b-0809-7272-9b16bf83968d@oracle.com>
In-Reply-To: <91d8d712-f20b-0809-7272-9b16bf83968d@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::17) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|MW5PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f957614-292f-4873-fea9-08dab836be89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XuRcLEIjPbkvBhSaYPuvSsyGJK51PGUWdWSRaIgJuv8QtHD5O4Wgp0FgMLxQ9T0V+Tv6VijwD9bJ2MT3aEHcyWUjZGWU5nPeNZUnNpXkkXc/LGrA8AGlafOUW1NdybVj6lwDJ9r3YZpiqbEj3lg4iWlQuncDzbEyKs1MzIJG5QTGaP7RijZwPMXPByPEPgrM+2HWc5O15oW7L/LBkdFc6lgZIF25W6zSampjZ94VAGyFpV7oMvVbOG8xqiuDZVLK1fUuyy4B7a7MqXYGfIcDqofZe4msT0hQfp++COIWab6BGV/i8qd+9jgdVgwS1lQZKBEYE2wJYf5vbVY4DRPw6dz0/ipCiVo8CTlON1phUnQ3es3JcqERNEb2TfFFrd5cecai/Hi7qnwbI0fgzE062RyoVy3dj+6vSfupwNbtxO35Iiycw4TOHtE+9u1QdMdUFA/o7ihj5NkFBlq1o96N5t0Ui+Ro3vnVeyDMQAzUoD5nAnngkpjwqXmqOyplGkeiHh+706lY1HDblsEP+8t5HnWl5G5JxTAymmQf3poDAh5kQO8D2bWK+hh/N8xF76q5DvCejLTm6yW6ApL9Iv/2tlEHc2MjW/tLNkeAvrCgCFFkp0QUNLHhnOY/UYfx9nf+1WUcdybvmkQ5Sg120DjgKUTBCVYbtWgCLVhwbvwWYNs45hPJ5/RKraMXs55Y670rtUzQMHgMRZnoS9Nom5GarrHdyZ/H0eSqdtXHm19X4PK6FHKvQjdPLGs6wqt+AdY50TajeUtq57zEF5UKuNtD7kmgmNM83Aig3RZJIew0OjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(31686004)(478600001)(2616005)(6486002)(186003)(2906002)(38100700002)(36756003)(8936002)(8676002)(6512007)(66556008)(31696002)(5660300002)(53546011)(86362001)(66946007)(66476007)(6506007)(41300700001)(83380400001)(4326008)(44832011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDUzWGVKWDZBOW45eTRPVVNYc1JZZnhQd1ZNaUdBMzQxTmRBR3dCaFF2VXpF?=
 =?utf-8?B?amMxbU9CRkY5bXlyNy9NcEtJSEJneGs2Rm96ekN6Y1lJcFY5a2VWTnFnYjho?=
 =?utf-8?B?R1JhczlHc25EZjV2c2lWTWxTRmtPK01ubnMrNDR0UnZxYjVEMEJ4YUJvSTJQ?=
 =?utf-8?B?VW4raTJldFpaSUs1bjg5L1Jtdm54K0RhM2tOaTU3a0RGT0ZjcEk5WHlUZGtx?=
 =?utf-8?B?VGhMM21GOVAwWU1HbjBnVWV0bVA2a2o3MThvY0lTK0haR2ZsbmdWNGZYVW1J?=
 =?utf-8?B?cGtEZXRpWU50N0hvUE1maVVtdDJJSDdNcDhlTURQNGtGRlhRQ1M5cGtWMm8w?=
 =?utf-8?B?RGJYSUVINGplMWd2elBnZWtmRXFnWk1Kc3VYVyt5OUZPU1NSSDZBTjk3RnJP?=
 =?utf-8?B?NUw4U3JhbTdjZUJMQTZDZitGRzhRYml5US9OVjFGVmZMUTRreUQ3bTFnejlV?=
 =?utf-8?B?ZlViNUVJK1JMRUx2WnFlRTZnVmZuQzYvQWpvaW14eXduS051M1gzdGF2ODZQ?=
 =?utf-8?B?c3NyM1pWQkNkOWEwVW1yRGNUeDFNVlk0T3dCMml6cUNSZHdCMGFqQXJEbm9a?=
 =?utf-8?B?US9pM0ZnVmFORXVXb2tkcTh5UUxxNk5pQnIveFI1cVA4RUdrampBamhVUVVK?=
 =?utf-8?B?Mm02bEp4K21zSUFudHJSTTlxK29tMU1xVXVVNzdyKzg5aW8vdXRlL01SWGhp?=
 =?utf-8?B?UnNuMTRtWmZSM2lGQmdCMWpxT0lMTG5WeHFCN3VqNUhEcFYzMGVCSk1NUkNT?=
 =?utf-8?B?djlYOENFZ3BqeWxkOEEvOHlUM0c0Sm1UTWRxU1ZXOVhaMEt1Q1JvK3ExSVV2?=
 =?utf-8?B?TUVtNXVkaGIyckg4UEJzVVVTQXdtcUkvSWhtYzBIZkM2bzhvRnVQaHhUMDhJ?=
 =?utf-8?B?Yi84ZjFlSXFKZlRsQUNyWm5TUTBtMWZHWGhob1R1THdPcjFJTmdqZS96V1FG?=
 =?utf-8?B?UVdDR3pBay8yU1BUMndrQ3U5Q0V0ckgxK05BYy9IMlJUN2ZTaDllVExNSFQ1?=
 =?utf-8?B?T2tkVzNCalN1MURaak12RndYYlhJbmd6bmlwMVZnKzFyODF2K0wrMjVmNzBB?=
 =?utf-8?B?MXh1M1ZMZVpEeENpaUZMWXlqVTliR0lWbnFQa25HYytYclRwMk8vVlR3elR3?=
 =?utf-8?B?Qm82cFF5azhRdmVTOVI4eUM4MUlYUU5SQjE4UExIbWYreDdFcTlFNlpuMWpF?=
 =?utf-8?B?UE9PYzM2L1RxSnA5clhOS1BTSVU2eklOTEk1aDBpMGR1cmFGZ1pvZEV3djNp?=
 =?utf-8?B?MDNMeHFIUXFqT2dNemtqZjBvaWpoUUZCaGlsK24zdTV4RFplQkcwQVdxdVU1?=
 =?utf-8?B?bkpqOWpJS3JiZHJMS1FFWm53dWp5WVM0NUdDNWoyUDBNQlh6VE4vUHhUTklC?=
 =?utf-8?B?elNIOTV5L0pTd253ZEJzM0lxUUlNRS9WcEMyZG9TbUxOTGFqcUdla0V0N2ln?=
 =?utf-8?B?Mi9YbFFRdWd3STZURE51UkFXRndqR2ZpdlorM3RhaE10WS9rU3JzSXJMUHdK?=
 =?utf-8?B?NVRuTXRNNjlJcUg1UTkzVUFoYlZLaGlpWFZhZXBMbm5CamorM1NEdHBnQ1p0?=
 =?utf-8?B?Z1lLRjRHYVVpN2tSZHc2d2tlc0VrUFdWa2VZOTYyM1ZiMkI5ZnlPQ1BxNzNY?=
 =?utf-8?B?TDIvcVloRnVSRVRzU2dySlgxUUljSlJMTlpSUDExbUZGM1JQMkk5RW0zaWNq?=
 =?utf-8?B?WkhtWFdia3UvdXAwUmRFcWROQWMvTGkzQ25HeXV2T3VaUm0zaG9OTlNZSlpa?=
 =?utf-8?B?ZkFRVzBNNmI1Qm55ZFk0cENBSDVqOE5FWk0vcWNpZ2lVcVNvQUZ4NzEvUnkx?=
 =?utf-8?B?NElIYjcwSlJvOGhISnpoZ1pIZkVVWGdrKytMK1I4dGd2WWtTY29sTFNneU1Q?=
 =?utf-8?B?RmpuSmpUTzRHTEc2Tlc2SG0zQmhDTVVCakU1OHF6dWs1M3lLREQxV2o1NmZF?=
 =?utf-8?B?YUNKUFhCbUkzRHJ5RHpBMWhsc0VhenlVcDdIU0NoMXFQd3AyVnhnOWE4U0Vp?=
 =?utf-8?B?ZVJvTVJkSE9NREhnZEJVNjBlZ3kyL3VBc053d3hFaXhIRGlmOGFYOGtNMGNp?=
 =?utf-8?B?VHBkaTJjSTZ6cmVRWCtEdzQ5RlFTUEYrRkgwSXEza3dPbStEcG52emNrb1Fx?=
 =?utf-8?B?STJJQzEzZllLeWRqMDlRNDdoaDB4TFpmbnVmYnBFUHJYc2RLcm5ETGFlWk5X?=
 =?utf-8?Q?AJZ3Xy3vbQBD7+z2PfOnDUU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f957614-292f-4873-fea9-08dab836be89
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 16:17:29.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62BW3GU98m3bESBFHw7OLN/i/+MLjQMaRk65AgAG1DVaVSKQ6rxJtzx2dm5tLzSXTRHPtNXyKMoDGgcHC9RjZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270090
X-Proofpoint-ORIG-GUID: aEYrBCiGbiYwHtdH4TBuAItLslf0XDho
X-Proofpoint-GUID: aEYrBCiGbiYwHtdH4TBuAItLslf0XDho
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping? Any plan for this patch? Currently "perf stat" will fail on Icelake VMs
(without the topdown metric). The user will need to manually specify the events
to trace.

Thank you very much!

Dongli Zhang

On 10/9/22 10:03 PM, Dongli Zhang wrote:
> Ping?
> 
> Currently the default "perf stat" may fail on all Icelake KVM VMs.
> 
> Thank you very much!
> 
> Dongli Zhang
> 
> On 9/22/22 13:15, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The below error is observed on Ice Lake VM.
>>
>> $ perf stat
>> Error:
>> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
>> for event (slots).
>> /bin/dmesg | grep -i perf may provide additional information.
>>
>> In a virtualization env, the Topdown metrics and the slots event haven't
>> been supported yet. The guest CPUID doesn't enumerate them. However, the
>> current kernel unconditionally exposes the slots event and the Topdown
>> metrics events to sysfs, which misleads the perf tool and triggers the
>> error.
>>
>> Hide the perf metrics topdown events and the slots event if the slots
>> event is not enumerated.
>>
>> The big core of a hybrid platform can also supports the perf-metrics
>> feature. Fix the hybrid platform as well.
>>
>> Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
>> Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 33 ++++++++++++++++++++++++++++++++-
>>  1 file changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index b16c91ac9219..a0a62b67c440 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -5335,6 +5335,19 @@ static struct attribute *intel_pmu_attrs[] = {
>>  	NULL,
>>  };
>>  
>> +static umode_t
>> +td_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>> +{
>> +	/*
>> +	 * Hide the perf metrics topdown events
>> +	 * if the slots is not enumerated.
>> +	 */
>> +	if (x86_pmu.num_topdown_events)
>> +		return (x86_pmu.intel_ctrl & INTEL_PMC_MSK_FIXED_SLOTS) ? attr->mode : 0;
>> +
>> +	return attr->mode;
>> +}
>> +
>>  static umode_t
>>  tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>>  {
>> @@ -5370,6 +5383,7 @@ default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>>  
>>  static struct attribute_group group_events_td  = {
>>  	.name = "events",
>> +	.is_visible = td_is_visible,
>>  };
>>  
>>  static struct attribute_group group_events_mem = {
>> @@ -5522,6 +5536,23 @@ static inline int hybrid_find_supported_cpu(struct x86_hybrid_pmu *pmu)
>>  	return (cpu >= nr_cpu_ids) ? -1 : cpu;
>>  }
>>  
>> +static umode_t hybrid_td_is_visible(struct kobject *kobj,
>> +					struct attribute *attr, int i)
>> +{
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct x86_hybrid_pmu *pmu =
>> +		 container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
>> +
>> +	if (!is_attr_for_this_pmu(kobj, attr))
>> +		return 0;
>> +
>> +	/* Only check the big core which supports perf metrics */
>> +	if (pmu->cpu_type == hybrid_big)
>> +		return (pmu->intel_ctrl & INTEL_PMC_MSK_FIXED_SLOTS) ? attr->mode : 0;
>> +
>> +	return attr->mode;
>> +}
>> +
>>  static umode_t hybrid_tsx_is_visible(struct kobject *kobj,
>>  				     struct attribute *attr, int i)
>>  {
>> @@ -5548,7 +5579,7 @@ static umode_t hybrid_format_is_visible(struct kobject *kobj,
>>  
>>  static struct attribute_group hybrid_group_events_td  = {
>>  	.name		= "events",
>> -	.is_visible	= hybrid_events_is_visible,
>> +	.is_visible	= hybrid_td_is_visible,
>>  };
>>  
>>  static struct attribute_group hybrid_group_events_mem = {
