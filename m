Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B5963A33A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiK1IjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiK1IjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:39:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D141DF42
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:39:19 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AS713xw015044;
        Mon, 28 Nov 2022 08:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZvLI1sYW0lnKUUMXt9FLvRwAcQsLZwEmayGK3Oca+Uk=;
 b=hHulr4wu04loeQ7PGlZCTRG4EvSJjWwI2rEV/f//P2ezjywwqJIWJvmnDWEH9E5f2pbA
 QEf32HlRfuGR7n7EAelOzbV8Q472NvoD3ZRZtbTYC6wCCZOAnBT7veICafmdkp6jYws/
 MBEkJ9K4GKkdY8PGWKNPn2wf09GLHS59mLMdGV5oLef7auf3olkkBZf7mThmAVKNPnhR
 Tnnwqe7vO0nEF3tBUk6TnQzOaf1+28EnyjD+a0hVNqdzPdA+i47hc1ZeZld69S3uG8XF
 NXD9wxzbyIm3wL0VM3+ZvSL9R58UvRcAsdJ5Pk5qj6gUkoN+jFvYLXK3jfeJ0Our6hej AQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3sk5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 08:39:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AS6GxYN010047;
        Mon, 28 Nov 2022 08:39:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m4a2ef2jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 08:39:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meXbTGnqlUUA/TBqsMVeYslEW3JSOqbrqvJnWQLi3MEj2fAU/6swKD+25AkiIZ9x//FF5lf5NDiZmbU75L9SUdekDXFdUswAaW9DJ4bOmxlJr3gZqLSvoGu1wmyjs+ajH80qgHC9s1kTTkSNAiSEJmK4rP/6h/C7cJlRcRCp6AheLTjd6zEbGqWsLNFxnA8ASVIhuKJ7Ov0RteNhQ6qtLuRm0haJ8nyYhP6fBYF9pTFQNcfxLitTrR3fRtPtJgE2AKqq/fi5bXd8WWjqaA/52VhvNoevCjeq/9gIGrz/tdlMu0d/v8bFmkNu1f3QrpOJuIALK8/WGCeyeIAK3NeGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvLI1sYW0lnKUUMXt9FLvRwAcQsLZwEmayGK3Oca+Uk=;
 b=e3Q3FLEVcd8u0XEfy24wLxUFQU+zc/JwN1cjpupJIh0EbqmvcVbiedxhaoV4a9T84Qat0P3DoQjD2iQXcqc34JwklYGPeEt8UuM9VbNr/DdjRCcM0jAbgFd5T883RRgfiNFjZLO+i4DbmAbz9m/UlY4O3fiyvFKqTaL9DnAIYKr2ga+Z5KJnECuFAR8y66qHU4sgydHN/+YzE5P0MY6hb1D+uVjBuYtfRk24lxzETnwrKKch1Fn1+UYzgCXk7/JK40h+O/zhz2l/8+sQj7u/ER0wW5RfN9r7L2WAoyMDVMILlwUqrgpCrQw8qphBNTwNJqWMnPl1ob8skb9t5G4WBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvLI1sYW0lnKUUMXt9FLvRwAcQsLZwEmayGK3Oca+Uk=;
 b=W57I1CHjVdDMyk2tYLImenhRqOzUDtX4T82eNONbyUEfQiU/BC7QsKiKvL9JsCvKS6iUhKc7LFUwjhvhQucuzAT4iafv7UB0bXxx6JfdOWVMD/MaqVOCvNKdY6l26pBREIFH8QAU8PDE+KwGF7EKtzwPMgGW1MATpUU3XzGDfHM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CO6PR10MB5587.namprd10.prod.outlook.com (2603:10b6:303:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 08:39:02 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::1717:5a07:63ca:fdab]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::1717:5a07:63ca:fdab%9]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 08:39:01 +0000
Message-ID: <82e8ce27-0743-59bf-fbe8-a25093167451@oracle.com>
Date:   Mon, 28 Nov 2022 14:08:51 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] vduse: Fix a possible warning in vduse_create_dev()
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     error27@gmail.com, harshit.m.mogalapalli@gmail.com,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Guanjun <guanjun@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20221126040000.775914-1-harshit.m.mogalapalli@oracle.com>
 <20221126181822-mutt-send-email-mst@kernel.org>
 <8253ab3f-b4f2-ff60-7e87-6455c9c10dc8@oracle.com>
 <20221127113416-mutt-send-email-mst@kernel.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20221127113416-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::18) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CO6PR10MB5587:EE_
X-MS-Office365-Filtering-Correlation-Id: d2eab9f0-929e-4d0d-49b7-08dad11c0029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ws0WKsvmbl8lYcYKezwLRqs5K6Kj+1surUF3v8bpcIxtOqbGc9COmOfqQ/VS2o64hU5E8MQf4sTrgpNnhhIX9nzgLZgJyQyFPtlkjsiKg99XddvSoEb/xJDrMSbMyl4PKxkDAN+H6YlU2ZGAKivjCCvUNe8fKPMkzDx1SD0XwCul6j+k6UapQGRKA/MWzLLBiuY8QVuxWZNnAWXJo2d4hzHtag/FzILqKMmASTaeE/QmCSbyVEfbeIrqOghkvk0+kvAf+MGcFLcKcVsOl7HlMA9Mmlvs0wEBwgc80iXLrbsqSsSOqbWRuY/3VUQNDBAOCObieeBie+1J+pQXvXbg8TTK5v7kfp9GSRBxocV0xl792+RJChE/RECV3+si5ean+M/dUFar9YOrZm/fVb5XL2bT2tY6daq5CovsR4UA+QFmyvh3+6Af8qDOgTp7hE5xqArkC1lomoq+Jz0IrdlSCb9hJHJya1wX7CpVEIU0qG4UnY84GFKfa4hFDvnyoVbcix6hf5YsGMB/wZXEWa278yKJgwotfbHm3ILW7uFK5VmgeLYHuxYKosKse3goarHqHvU/EsATXy4i4RRhy5x8en243BF0Ah1sEH8i4a/oTn/+4gkPfL3zXGvcVZ+Lj+TuMb6r5Nr+yG2G9DRY0tYfoqq7ppKDqjNJHHMHe7W49zXLJk83LuNBYKpiUkuONGQKET+sqhILcwdRkJ4yvrrcFFq5To1sAF7mV5g2CCNVjEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(186003)(53546011)(478600001)(6486002)(2906002)(36756003)(26005)(6506007)(6666004)(6512007)(38100700002)(31696002)(86362001)(83380400001)(2616005)(316002)(8936002)(5660300002)(7416002)(66946007)(31686004)(54906003)(6916009)(4326008)(66556008)(8676002)(66476007)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3h5bnV3NkNnbnA0ZFBpMk5HMktUOHQzR0xLR0NGQXEyODVibXREUFo2azhk?=
 =?utf-8?B?SHd4c1pSVzRGSEp4S1RySHltYW9iRElBN0Zxbmk5RjlLWGVrWXRsRk90a0tZ?=
 =?utf-8?B?RnI3akJqK1ZIcnBMREovcDZoT2tDNmMzQXRPeHZ4Nyt2eDFycmtXY21CTXRX?=
 =?utf-8?B?MjR3Y2hWVCtMTFU1Slk3ZVhnQ1JiOUVaSmlFWTEwWG50bzRhM3hMR2lHejFB?=
 =?utf-8?B?WkZaMXcyLzdJTW8rSm92NnN5L2ZWaGErQWRBWWZ1Mldra3VUK1FlRDRVMjVN?=
 =?utf-8?B?Q0RubkRSSHZYTUF2ZE9ZaHZneDl0RFJTWkxqQnlVYkhUZTg4Q3FDQnFUeVZB?=
 =?utf-8?B?TUx3dnlXL1VJZHlsdHJlN1dKN0lhVnZvOUtlMUlzRmRDc0Y5V3JXbklyem1F?=
 =?utf-8?B?dC8vMFRvdm9ZQjhuWnJPQ0RybUlETVRsRnRQeEpUUFdDYWN1SE4veGlOck5Y?=
 =?utf-8?B?MVJ4RFpScU4vNThhUEg4by9iTkhIRTV4UDR1NGFLVlR5cDFOSlFDZkN5Snlj?=
 =?utf-8?B?eEtIMTlyUFBHRG9HL3NwNFhESTFqNDNDQnVlYndVTDlHdTRxWTVWSUF1aXA4?=
 =?utf-8?B?VGxiQ0lhQ0hPRUNqYngyd3Vrdy9ObEVqOGdkSlRRZ2hKUXJZQmdqdjNJTUhl?=
 =?utf-8?B?R1phYWdoMi9uV2ZraSsreFpmUE9xUXAyVTBsbzRGaDNMa3VZMkEyVCtoMC9V?=
 =?utf-8?B?Zms5QURwRitZMXVOL1NwSWovejhHQzlaRjB2N3k0dDZQTEZYaDRENnRBNFl4?=
 =?utf-8?B?d2VCcllZM3dweUtEYUl0R0RjTnRORkxUNnRLOHNFSHFCM0pKTEJJZWV1Ky9m?=
 =?utf-8?B?Q3pKcFdFYnhnV0hldE5FalVjVG9LUEllT1JMa0paWVVBeG9FWXRsUUJwajU2?=
 =?utf-8?B?VnRnZXhNQ0IrUjdEUVZqU1VlUmVjenpwb3VmYi9NWkNuNmJ1NFY3dFJwWDQ4?=
 =?utf-8?B?Z09sVjBrQ0ZMZDY5Rm9jTzFpRDNyQXVwMW1YMGFGZmQ3WEp5UG5OQUUyU2tm?=
 =?utf-8?B?cjNrMjRCaUROMFQreGd0MEpJRWE4bzk5STVXNGl5QjNVYlpIKzFza3NLY2JS?=
 =?utf-8?B?d3dxczlhK2VEc0dSSk4zU0ZaN3F6amlqV3NONDNzYVRMYXRrd3FpNGxSQXVW?=
 =?utf-8?B?WlNLZ0V0a2FnZlBkcENVSFJid1QxMVA0Y0ZzS3U2UlZmNFp4djhNcFgyQXlj?=
 =?utf-8?B?aW5VWjhmL2NYaW0rU0xvbkQ0anN5YmJtaCtaK2ZWd2MxUnJBTkxXZGtMVU9i?=
 =?utf-8?B?elJOWTB1cEtvTHdiTXFvcHlYU0RqK2ZERlhQZlFiOVEzOE04Q2FCMVJoVzFv?=
 =?utf-8?B?aWExd1loQUNwWGZ4VXZtWWdRcE1LQUVsS0FNdXNzMm9KWWhrWHpYdkJ3ZUgz?=
 =?utf-8?B?dG1IeGszRHpBbUNHVkYyeTRCTmV2Zmpjb2JrUnZPUTBwNjQ0L202dDhlNjlI?=
 =?utf-8?B?QnAwR2hkdUd0LzV4ZVFvVVRmQjdZdDJoVm9kY2UwR0xETGUzZ1FQTUxuWkUv?=
 =?utf-8?B?QnB1MmZoQUNQN3I5Y1NLb3dnMkpLcGFHNUJkUEd1N2pWY3piaUNGaHpJZFp6?=
 =?utf-8?B?bUhSeXAzMk1hQWNVTFdGMFlmTmh5T3ZHRWtPRjBFZm1NdnhXOGp5akNBRmtR?=
 =?utf-8?B?RjVrTFZlUTl4eTV1Z1BNaFpycmcvTkdBWCsvWnFiWEM2eHlXTWpkZjU3OTVJ?=
 =?utf-8?B?blpGdU9abksxMXZ6QjVYQ090ZC9qRHp5b1RSUlVDd2VKYlVWZ08vWlZyUndU?=
 =?utf-8?B?K3hjUG8rQWdydGY3MUpqOUVDclQxcC9BTXIwMlhLbTBqUlhMeUdmRlhjem9o?=
 =?utf-8?B?U01GVUgzUG5QV0xLLzlIRGxUdHVJdHd2c0R4ZVhMeVlCdTB4amNYRmIzaVVn?=
 =?utf-8?B?Z2U3MjNBVzdiaHYvYnJXdXJJTUMxS01zdW5iQ1lQa1dOc1ZHb2pvakUrUEp6?=
 =?utf-8?B?VEFTYmU0UGx4bm10S1RiaFFZV0JaTHB4bVU1Z3pGQ2wzSFJLelNxQ3dZZUhM?=
 =?utf-8?B?Y3VoMlpYaHA4cTFxQ2hMUyt2Z29hZDgwU1Y4OHdFVTdNL2dSMElaVE5oamRZ?=
 =?utf-8?B?MHI0S2tTekJnZTdKRFJISjBsbmVpUFBWVncrSTRMMExQOTRIVysrVVpHQllB?=
 =?utf-8?B?TVhNL0tuY2RuTkdXTmNGMWIweE1seDJWSFNxSS9NcHRHM3VPZm16c3BXek9Y?=
 =?utf-8?Q?oLy0vSMpyY1xurtaqBPEqVU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WjA2THdIZ3dZQXRYZW5ZU0FpMHFINE0wcW5JdE9yaDl2VkdQU0gzYk53Q0Z2?=
 =?utf-8?B?SGExMzg2RGw5Tml5U3hNcXFRN1crOVZONG51ejZXQ0NlOUtHV2lvUDRQTzcw?=
 =?utf-8?B?ajdoOHU4MU5Fb1F3LzFKam1QOFlSNS9EdUJwQkpaMzkyOTdLVThUVjI3UGJP?=
 =?utf-8?B?dmJod2QvU25nRVArc2ozUUVjQVJPdEFNcCswUVlyTlVudUJURE5WZU8wVkU1?=
 =?utf-8?B?ZWlNQjB4ZlJldmJiS2YzcCs3YnZxTG1WZnJwN3dQTDk4Ykd0UDdQZFRKcFlj?=
 =?utf-8?B?c1hBRi9WdDFXNkRpNDBud1ZpdnpLR25qS3lvaXpRNFZISnIwemRoM2h5djky?=
 =?utf-8?B?UkdHSVI4R1JkTVlkeDdkVStTU2RFRUdndkVtVFVQYlYyOHk4em5PcDBNb2Rn?=
 =?utf-8?B?cGcvQVR2aFovdE9QYk9DRGFsNERieHgvQU0wUm04cWlVenRBVmE2Nkwrajdk?=
 =?utf-8?B?bXBNTWh5UGdOcEwzbjVaK1RxdjJVZmVYT2hLck04MGNwSnJtRDA3WGJSNjZG?=
 =?utf-8?B?YlBYb1ErSFRLU2ZnOFdjdDJTdStSdjQwZnhUSWlXUkVtZExTUmdvVS9pR1FE?=
 =?utf-8?B?MjQzYnR1YTRjU3NxYWVKS20yZDZmMHA3YTV2WkYvam83NVVpSzdDU0JveXlX?=
 =?utf-8?B?d3QxblRYcTVJKzBHMUhGdDh3Vk5lbHVadFFKZisxZjlrek9KbTI4cXU3bjJk?=
 =?utf-8?B?dHl3V2xVeUlOTjJUeUFFTS9iS0FMVFJoUnhQcWorMk55cFVVK3I1KzhpbFov?=
 =?utf-8?B?cjRuUEg0T29pSmdEK3U2RHcxRkR4cGxHcGhtWVdIMlB3MEdlSStSRkJUSFVp?=
 =?utf-8?B?VHJlSFF1VVJDNHFkTGpQdVZjMElLWGtyTm81NC8rYlVOOWZ5ekVSWjBFdVll?=
 =?utf-8?B?NU5KMkhwTWNQdkh4bUlJdW1ubmQ3UTZrUkVlWDlVYnZXaThzVmRjTWx5bkxE?=
 =?utf-8?B?QnRIY3EyK2IzNjZ2dGdKTEhLcWk5c2dsV2d0Z1NkVDU4K1ZZVWx1QkJLRzZV?=
 =?utf-8?B?bjUyMWk2eGZOVlBnQ3M5NmhtMGFwSHhGWHFjTlkwaisxdXdPbXhOYXRxTit0?=
 =?utf-8?B?amNxS2NHd21oVlU2RTQ4QnZySzNXZ1pmZEtRSGJISndhTTlEZWtPeDN1SnBX?=
 =?utf-8?B?MGRMZ290SXNxZmE3WFM4Y29FeGtDL0ptSzdwSFNSUERUKzMzbG5rZHV0WkY1?=
 =?utf-8?B?cC9sVzlLQ3o0VDB5MFBkN0tLSnRDOWpGM0Q5eXJoVi9xT3lURGIzV2tTaDBW?=
 =?utf-8?B?bWY4QS90TW9SemV5L0syeGtveXo1cG10NXd5NlRtcmFiYm1GaEFsRmpoT3NB?=
 =?utf-8?B?MnNIMmFKeHpIcWhlNmJYdytoazJsUVNwTUpJNFM3cDNjWmRYTWZrbE9hbHps?=
 =?utf-8?B?ZzVSWWxGTzVwY21hTEloVWhNeSt4UWxORUQ1SlRMcjFycGU1TW1vYWg2Q1lR?=
 =?utf-8?B?c0FHamlwNUhpcldGdFZvaGl1dGVnWU1HTDlJWFpXN1FSOENBRE8rVmVZM0xB?=
 =?utf-8?B?NENzRXowcnJSZmNpWUR0aXNCT0pEVG5WSEdsa3JZdVpyVHB2S1ozblhIQmxY?=
 =?utf-8?B?WVZ3Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2eab9f0-929e-4d0d-49b7-08dad11c0029
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 08:39:01.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EC60u5CllMGSp2T6eVUEpJlSpOzK32ZaP31tkIezLRmTIgvcSPWW9Yn8QrCM4HB8z8dHFbjRYrCOjvlAUtRVQyWs/cC+P0ymXKYbjZUwEhgCd+Qd/qOHJITnR1RSu9Vz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_07,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280066
X-Proofpoint-GUID: _19gnE7k93ICScz3Ljiplj99qGL_AngI
X-Proofpoint-ORIG-GUID: _19gnE7k93ICScz3Ljiplj99qGL_AngI
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Micheal,

On 27/11/22 10:04 pm, Michael S. Tsirkin wrote:
> On Sun, Nov 27, 2022 at 08:16:24AM +0530, Harshit Mogalapalli wrote:
>> Hi Micheal,
>>
>> On 27/11/22 4:52 am, Michael S. Tsirkin wrote:
>>> On Fri, Nov 25, 2022 at 07:59:58PM -0800, Harshit Mogalapalli wrote:
>>>> As 'dev->vq_num' is user-controlled data, if user tries to allocate
>>>> memory larger than(>=) MAX_ORDER, then kcalloc() will fail, it
>>>> creates a stack trace and messes up dmesg with a warning.
>>>>
>>>> Call trace:
>>>> -> vduse_ioctl
>>>> --> vduse_create_dev
>>>> 'config->vq_num' is user data as it comes from ioctl, which is
>>>> assigned to 'dev->vq_num'.
>>>>
>>>> Add __GFP_NOWARN in order to avoid too large allocation warning.
>>>> This is detected by static analysis using smatch.
>>>>
>>>> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
>>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>>> ---
>>>>    drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>>>> index 35dceee3ed56..5e9546b16165 100644
>>>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>>>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>>>> @@ -1512,7 +1512,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>>>>    	dev->config_size = config->config_size;
>>>>    	dev->vq_align = config->vq_align;
>>>>    	dev->vq_num = config->vq_num;
>>>> -	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs), GFP_KERNEL);
>>>> +	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs),
>>>> +			   GFP_KERNEL | __GFP_NOWARN);
>>>>    	if (!dev->vqs)
>>>>    		goto err_vqs;
>>>
>>
>> Thanks for checking the patch.
>>
>>> This is insufficient - the real source of the problem is that
>>> vq_num is not validated.
>>> The thing to do is to validate config and limit vq_num to 0xffff;
>>>
>>
>> 1557 static long vduse_ioctl(struct file *file, unsigned int cmd,
>> 1558                         unsigned long arg)
>> 1559 {
>> 1560         int ret;
>> 1561         void __user *argp = (void __user *)arg;
>> 1564         mutex_lock(&vduse_lock);
>> 1565         switch (cmd) {
>>               ....
>> 1584         case VDUSE_CREATE_DEV: {
>> 1585                 struct vduse_dev_config config;
>> 1587                 void *buf;
>> 1588
>> 1589                 ret = -EFAULT;
>> 1590                 if (copy_from_user(&config, argp, size))
>> 1591                         break;
>> 1592
>> 1593                 ret = -EINVAL;
>> 1594                 if (vduse_validate_config(&config) == false)
>> 1595                         break;
>> 1596
>> 1597                 buf = vmemdup_user(argp + size, config.config_size);
>> 1598                 if (IS_ERR(buf)) {
>> 1599                         ret = PTR_ERR(buf);
>> 1600                         break;
>> 1601                 }
>> 1602                 config.name[VDUSE_NAME_MAX - 1] = '\0';
>> 1603                 ret = vduse_create_dev(&config, buf,
>> control->api_version);
>> 1604                 if (ret)
>> 1605                         kvfree(buf);
>> 1606                 break;
>> 1607         }
>>
>> we have vduse_validate_config() being called in vduse_ioctl() which is the
>> caller of vduse_create_dev(), so validate_config() is not necessary in
>> vduse_create_dev() ?
>>
>> Thanks,
>> Harshit
> 
> OK but I don't see vduse_validate_config checking vq_num.
> 

right, I have added a limit of 0xffff to vq_num as you suggested in V2.

The reason for keeping the limit as 0xffff is the max number of virt 
queues is the size of vring buffer?

Thanks,
Harshit

>>>
>>>> -- 
>>>> 2.38.1
>>>
> 
