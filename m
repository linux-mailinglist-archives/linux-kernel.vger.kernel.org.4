Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4110623178
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiKIR1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKIR1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:27:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFFC2250E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:27:40 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9H83Kr008999;
        Wed, 9 Nov 2022 17:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : references : from : subject : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LjXpbo6yqjv9+iLmisGk2PrtV5e3hSqCk6xfg3sZ/jg=;
 b=LDn+9shFrJYeRCAyqpV4Dg32cVqAyZXV9+FHteprhgArTcis4+OV3U/KLYwVzeEMg9GS
 ScCu9/KYSit/5nW9k9esfLVo+k3MWkSO3Yue2YGlkqSSc15OJP+dmJmU1LyLclzR+gY6
 To7eCCQr3Q30ACg/qiN/v9BjN4wfiel9BcaK+hzvq9TU5+wgrwTRqUoPvz1pIldbriqO
 sK/CZNQAZ7jeuZYYjCpadd7rA7CnzmGTy/aIoIbcCw37QDndIZK0MsWt0bvXN9IqqMkV
 dzS6FZ3Chk8iyIfd66vZFLDfBF8SXBXvv6BQqi39W8WNRxCnxYaUnMdg+k60/X/hlki/ jQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krgba01we-54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 17:27:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9FoEAP040128;
        Wed, 9 Nov 2022 17:00:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqhreme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 17:00:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C758SO9nwL+dlq/KV/8iObMP4rVlp4NEdJvrFEIQ41xa2XedlxcFPN+CTjwE6Bu9RGxIdk8FOfleMAXLnwQ0II0rq4V2O4y+ZPqqvs8vOGX45sJubv/W5VdC6DIXu2C1oLxk42uM3SThk4wL0QEtA1CxMRTZjl42rpV1rmGLiZ9PmicO0+8kSjzIADlxOw22Qkr2yplTkkmDbqWVGrkv7xB7N4LHXyLb32gM6qwBvolsQZIhamWISc7IpmCQV7bGZEBMGjFid2Pp5hAVZNC9aY+LLXA0ecjjwqbOx0Rdc7+0CtS5v9On4nRffmWuS/+HAN15TzrFnkYVHjGaJrWasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjXpbo6yqjv9+iLmisGk2PrtV5e3hSqCk6xfg3sZ/jg=;
 b=Qgppd88kvSBEAGiX54DuzJQn7DQ6wrPPoI2HcnpX7l/V7JJ76ZRqJZiZbvNiYIcxH7Dw+9P8PHyKa4Ckv/8rDoGFxHAUshH9/QSkXhbra8TjJDkDsH+3PCoHyttH5DSL/lHBPJcC5A76IoL2n05qR9/N/jmfVYpYFIjz0RhaDJoXxgQs++sOnFSzQA0U9ut7Hgk0DIKBDsGCzlGnVKxq7XXT4PYju/YW+IyLRG0JOI7F1PKdqN/zSkghlyu/5viZ90WhIkhP5CJAfacOHYrqCvpmyCMtaWEblpNYh5aI2oh3PpraiWlV25qdFsVY/yF+j+YAeidRqzjBK341yYlA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjXpbo6yqjv9+iLmisGk2PrtV5e3hSqCk6xfg3sZ/jg=;
 b=DXYP+GhI8TB4YGproFJBsRUo91UEJ7hJY2Nu8ITFloBBsGnTgX5mtpNVQYYFplrxF9zeXmzw0z/58SrmF1QWowiIa4Bo9YpEWM6VMoMrRwGoSp8SNQTTMktSZbQeu18z/lgFZG4Gx/t4Yu2B8hKpMbt4l+9kt15JjqYDXXftcIY=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB4229.namprd10.prod.outlook.com (2603:10b6:610:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 17:00:17 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%9]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 17:00:16 +0000
Message-ID: <0493ebb4-a0d1-efc3-b725-b6494f602a37@oracle.com>
Date:   Wed, 9 Nov 2022 09:00:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>
References: <20221027205008.312534-1-stephen.s.brennan@oracle.com>
 <20221108154846.11584119794413c7682280fc@linux-foundation.org>
 <Y2r8kFZVZP1ou1qZ@MiWiFi-R3L-srv>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: [PATCH] vmcoreinfo: Warn if we exceed vmcoreinfo data size
In-Reply-To: <Y2r8kFZVZP1ou1qZ@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:806:6f::11) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CH2PR10MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1d753b-a977-477c-6226-08dac273e02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3+LZjhih0QmoPmeDzP6plvQs9Fxmh0I1OTnvluz+17/KNhspPTOm+mOkVLFlBEaDQ2kM9hLjwXDgzlP7vJzHuxgusL4ET+rAmdqhohwU0yrAi9DakcNqzS3hV4/4RJKg+PqUuRIBDbncQSvYRdrP8iJ8KfBFaSYyVS9ocB/lYyD8w61Ji/Wvh/cOsyD+X/f/0kd7ujOSUnhWdK6gRqemiWyoMmhI4gGdU/US2lGZa54HQRoUiETrnbg93jo+MnPuVm25hdDgVL182RVOHZzmTZLaoYxmopdD6hb/stRIhjdFLE/FVZUSyoXEM25bSAZBU72hkw2MeCNH7N2Jk7UQ+N/8nNGl3f3cydOj8Fw+bp6IgOAAtfMsewC09cWM3XK9IkMrO4g9Ww6EsXq/jQQFDHhoBBDGZBxHk8JOBM4rA2UPZfvuh9km1zmEJW4tZgSHREGf0l96do8H0s9mfBJ3RE839ZhuGkx//13hKmrTEVop+P+DyNlSr4b+PpnO4b5QwfBmIFEhXxDQXA/ZZHEGaSjJb9tQLJPxzcN665bTn+LTB+QpNdBEIjfmuRYwtnvXT/eo01G1AIbtkYOIf2iENgjqTYGYr/8ilpHpqTW/ZSI0nSdZyPXvkexb2T/SZrs2e/DVB13zsKY0WnNIcYZUf4g8HlMlTiusRDBl+eMn+MQRVLUSnmNFWGcD6OqhkViVOq47rLdCEoH8PNKdjfuLzBGbELOHTqyjNhlVcz4hbQPn9Zcte6AGBVN+5imOQjipJqsWv7vXN7nbp+EGpvMQ+uIHBW0ImNVgymqieX9znA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199015)(6486002)(5660300002)(478600001)(83380400001)(38100700002)(316002)(36756003)(4326008)(8676002)(110136005)(2906002)(66556008)(66476007)(66946007)(54906003)(41300700001)(2616005)(186003)(31686004)(26005)(6506007)(53546011)(8936002)(31696002)(6512007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFpJTUZWTGJOeHBiU08zb3BpUnpMMVRLb2hVQ2lKZm9pcERCSWdhR0VpTUMr?=
 =?utf-8?B?V0ViYXJnMXVXNmUyd2xKZUswWm5rVElkclFSbWJJUjVPamVyd3NIK1hUTHhS?=
 =?utf-8?B?ZXhmSDhkQXQ0MTI5aHZlVVRMRXQ1MGNXZFJneVpmRk1lWkFWU05GaHhnT1Z3?=
 =?utf-8?B?ZS9sWi9lMUZYUVBlTDBFTWl2QUhvNUtGWkVOZWk4L0wyWDByRGJLNG1GNEZI?=
 =?utf-8?B?SGVoclRpY3YvZDZIdzROMUdHRjRkWW5kYmFydVowYllGaEh3dWcyWk1vTFFT?=
 =?utf-8?B?eUZJTkZZQmJBRU1sejRla2svOUpYcXRzRjBYSkpYNGQ1VkgyTDJLTmMzbFN3?=
 =?utf-8?B?emF5S0VFTDk5dmN6Y1pTczFsVnFqdENDSzlhVDArYWErM0N4MEhDYTNPMys5?=
 =?utf-8?B?V3RpSDZzNk9uUjRKR05wcHl5NXdKZkhQWEdiZU45VmFIbTREZUxkSVRuRWRp?=
 =?utf-8?B?SndibGIwN01JeDB1V3lDWVJPd29RWitMR2pHN2kyVUtVSU9HZUNCa1JFczNn?=
 =?utf-8?B?ak0zOTk4YjRRUkFzMDFRQWphSVZxeWZzaW9Sb3NObERFdTUweEMwRGFadUFW?=
 =?utf-8?B?aUNIRnlkRUNpWHYvSTFkbkxEVzFSVExrUzAvcHI2QU1xWkFqcGhWU2ZlbzFz?=
 =?utf-8?B?bjU5SjdRRll1QVlMT2wrR241RkwvWG9TaGlsaUhRWHF3bHBNRWFFWWV4R3hW?=
 =?utf-8?B?ZzgwOXFSV0JQTDJSQ0llbkhZc044R0dxcU9kNEQ1elIyWGR3c0QwYzRrc3pz?=
 =?utf-8?B?REdpS3RFeHpNbGxTVU56MkVoeWkzYkg2eWQ0QTZNMVFQdjdweDA3R094anpV?=
 =?utf-8?B?MkNzNzVpUDRPUWt0QTNqNzhRM3dtWUNTdUUza0RmWG5nU1I2YmtpM1JubHAv?=
 =?utf-8?B?N0RLSGcyOWxtdTFPdmg2RTRpRjZITEdUNyttOEVhL1p2VmRWc2IvVWM2aUZK?=
 =?utf-8?B?M2NFWWtYR2pRbnJudDByQTFEaUE5d0ZrazNQZUpqTy9EeTlHZURRaUtmdklo?=
 =?utf-8?B?eG1XejFlQS8xT00rRXF3WXlpY2p2UDFNcVRSNkpoTW5zL2FCeko2VFRKcTFN?=
 =?utf-8?B?dWtVRXFCUi9hVk1HZmVTbUlMYWF3bko0LzZGVlpDQUp6WHVwaTJRY09ORzVl?=
 =?utf-8?B?Q0h4ODc5NXVaQS9abFJRL0NTbDJkSjdLSTFiN1Vsa2F4WXVTdENwckpLVFFE?=
 =?utf-8?B?ZUtsdEhGb0RUdmQxQ0xVUUJGYnliN01ScE01NnJkazdRbGtQczZRNWV3NUpw?=
 =?utf-8?B?T0R5aTIxYXlZR0pUa3huQVVFOW83WS9TT0I1OHROOW1YWGR2dVZnMy9wVXlz?=
 =?utf-8?B?SjFvRXZ3c1VWaXZvUjVud2ZETDJ0SjRlZ29rZTk5OUlZV0o1WEdiKzgzVkNM?=
 =?utf-8?B?ZTliSFR4MWwrWEZlOXRWUlI2endqU3MwaFYyQ2txZ1grckNFSXBMSG9yVmRW?=
 =?utf-8?B?ck5oM2NBajg2eG9PeG5wTmV0ZndPdWVrYWV0Z01FS1NQOWxBS2xzeXRLNlpr?=
 =?utf-8?B?TndhYjJrRndCYzBpNU5rUXQ0ZnhNRmlrWGVIRHAvQTA3ejhHV1ljdlI3d1lz?=
 =?utf-8?B?cHlIblk4eFVDQUVzWlRZNmxXb2JxYVY4aksrdTJNYVBnRi80N3krOG1ic0hj?=
 =?utf-8?B?N3lwUXRTMGF6OUd4Q3ZUM1YvQzhHSUp4RVh2YXVUVUMwcEFUTlh1L1JpTVlm?=
 =?utf-8?B?UEQ1QS9razVnd3FPMWpPYVg3cTVaQ2EzVWV6ODNUY3ZRYWtLdzh0T3pSZDNo?=
 =?utf-8?B?RGY5ODNqNnlMSzFXZjJPUnJiNmhLdTM4TzlPUHBiTUdRREs3eldzZ3hGZkNa?=
 =?utf-8?B?MmQ0QVlueXhySENLYkUycmlLZlhaY2hSOFNERHZLRE1ZR2VzdFRDenlXWHZh?=
 =?utf-8?B?TlJKZzN3dUN1akZWQm4rNG1RYzdSa0I2djNDTEFPSk5ad0hQakVlL2E0N3hq?=
 =?utf-8?B?NHJ4Wkpub3AzSGZsNHFXc0RjdkIwa0pKSk82VGlkeXVybkhBVzF5R1ZIZTFy?=
 =?utf-8?B?RVJ5OExyV1FtRXZ4MlRXelVJMGFHbHVyYnl6MVBzK3dYQytvNUVZcG12YytV?=
 =?utf-8?B?T2krN3hXbVVPNEh2RjlyckIza2pqVmlNb3FyTGkrYXZveUoyZ05GRnJMSXVt?=
 =?utf-8?B?cjZhdElqdTE3V3NNWit5UXZYNi9aOGhvVW1CVkY2RkxLRnRkbVJwUmU5R0I4?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1d753b-a977-477c-6226-08dac273e02f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 17:00:16.6606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoFpzYHGVjfm3uawLqccF6TcXD8QYP2lmryvzpKfvyy7hfTk+Xg/fG906c6oNqnschcz5qRcEahTKy8rIUf5imA/3K4c8Ntnn4+oDsGNtD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090129
X-Proofpoint-GUID: G_xolXzJrZHD-ReIVI8uCBnjVpJPslU1
X-Proofpoint-ORIG-GUID: G_xolXzJrZHD-ReIVI8uCBnjVpJPslU1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/22 17:04, Baoquan He wrote:
> On 11/08/22 at 03:48pm, Andrew Morton wrote:
>> On Thu, 27 Oct 2022 13:50:08 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
>>
>>> Though vmcoreinfo is intended to be small, at just one page, useful
>>> information is still added to it, so we risk running out of space.
>>> Currently there is no runtime check to see whether the vmcoreinfo buffer
>>> has been exhausted. Add a warning for this case.
>>>
>>> Currently, my static checking tool[1] indicates that a good upper bound
>>> for vmcoreinfo size is currently 3415 bytes, but the best time to add
>>> warnings is before the risk becomes too high.
>>>
>>> ...
>>>
>>> --- a/kernel/crash_core.c
>>> +++ b/kernel/crash_core.c
>>> @@ -383,6 +383,9 @@ void vmcoreinfo_append_str(const char *fmt, ...)
>>>   	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
>>>   
>>>   	vmcoreinfo_size += r;
>>> +
>>> +	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
>>> +		  "vmcoreinfo data exceeds allocated size, truncating");
>>>   }
>>
>> Seems that vmcoreinfo_append_str() will truncate (ie: corrupt) the
>> final entry when limiting the overall data size to VMCOREINFO_BYTES.
>> And that final entry will be missing any terminating \n or \0.
>>
>> Is all this desirable, or should we be checking for (and warning about)
>> sufficient space _before_ appending this string?
> 
> 
> Hmm, once we really reach that point, truncated vmcoreinfo should not be
> useful for later vmcore dumping and analyzing. As we can see, the
> arch_crash_save_vmcoreinfo() is called at the end of
> crash_save_vmcoreinfo_init(). E.g on x86_64, the phys_base,
> init_top_pgt, etc are very important for memory layout analyzing.
> Fortunatly this insufficient vmcoreinfo page won't impact the normal
> kernel running.
> 
> So, the current change looks good to me.
> 
> My further thinking is if we should print the truncated or first skipped
> entry in the warning so that people know better what's happening, even
> though whatever we will do is to increase one page for vmcoreinfo buffer.
> Not strong opinion though.

This is a bit nicer, it would save us needing to figure it out from the
stack. Of course, regardless of _which_ line puts us over the limit, it
seems like the response is the same: increase the size or remove info. It's
just a matter of how much to increase or how much to remove.

I'm happy with it either way.

Thanks,
Stephen

> 
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index a0eb4d5cf557..8ba4dd90694d 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -383,6 +383,9 @@ void vmcoreinfo_append_str(const char *fmt, ...)
>   	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
>   
>   	vmcoreinfo_size += r;
> +
> +	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
> +		  "vmcoreinfo data exceeds allocated size when adding: %s\n", buf);
>   }
>   
>   /*
> 
