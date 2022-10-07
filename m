Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245EE5F7E5B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJGT4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiJGT4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:56:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42760BEFA1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:56:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297ICG88012685;
        Fri, 7 Oct 2022 19:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LmjAQ/hsn+rUWRFgFiYJ1LC1sksTgsyVyyCgi4Ny6vY=;
 b=vpCE7JpsLlqYn7Drn5ms/Kje805MiA/DMZqGJTrzq9DrnOvR5jgxty+J3fHEQwWpgnm/
 dFvUh7fAUdEl1PiLEMV4AezmCeATXp0KIhSBy3zpAA/FCjtcTZguPtj/GoMlNHuGMW5G
 oHphg+tgBz/l8FY1TUzbjg2UWXgNGl+c/tk3f80orYpHExgivONNIwOvTrYjNmAKjqK6
 11ncZpPDNtwIF70Yw0s23U/HJXIpGWmGwcSpbJQQNgEuxM94J4/9adS/hITdi6cj3BjW
 twC2sLmW25BN+ggXKXTuRHgeJKuPOMchOAnUc6TShzLYIFVI4+k2qjeU53MzsnIc0LjB lg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxc528f9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 19:56:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 297GipPC030076;
        Fri, 7 Oct 2022 19:56:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc07vh8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 19:56:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOBi7qSc9c9wbyYdsKN0f+NMuwjL0S87dThSDkcAVt+FCPy91/c02erUjt95rmtuOf6Rua4shPPnx+qX6rcQKMHmFrt21KzLqj8nb1CvGNuxPw/HUxEyFs4DH5hMsjp9eJymI0H8JcB7eXLPQpS+ERVk2mzW2MO+1AVYMnv+9AngVK4Hi7zk7aSk5Aw5IyBKqWxuOM66nCaJO15OVPoMbipAn4d6ExHHBCamO/4XRT1koUS3IIBJlI1VBCzjz7UZ9FHx9yJZpKi66vDta+eSLTUPU+okeNRjVHTNWJZIUtPup+YIPdXWHTu4jmIWOlGCvZbH6tm39W1K+Kr7yNGjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmjAQ/hsn+rUWRFgFiYJ1LC1sksTgsyVyyCgi4Ny6vY=;
 b=aukUzqUagkmle++JNg1cfoD+bEdqnqIBIIkFpeMUlTatugWn7qBOrMUTPgbwkNqW3nPS4iKEpCqyB69xXgo257w+br6PCUW7+zo7mz+Xn2XTSxbcpSnk/+TsQxuPSBTUm5EXxJC410jOqrzo2NTgkhDfDbXLdfV6omqFZ5WnWchD1Up2+d9lfGHMmnyIV1hivdoQbDdjyOer140fBH+Wb+W6pQfear8vKzEz+CE5P4bPytxE2nMKRyclQLWy2mf2FVFaba6Wpiz8rOgBtZgpzrGhekJSpy3f6/34ROFObjsWYFQB4WtZhRzSMqCNZ4UwfPxlOgaHF9EtHTsS3ryQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmjAQ/hsn+rUWRFgFiYJ1LC1sksTgsyVyyCgi4Ny6vY=;
 b=QyylX7WfGzxxQDPeQg+f8ed8GIpWcHasui1LbTPLk4JCaPXH/OYADMl6uii+O27Qc4TrCX36Q8mr2g//ypiUIcxqw7FKktLSv8jwP7aMfKWK+/WFscGQvLllzLBUG5oCVjSUiZAvcEulMZUb4upuMBZlcBfR9Rg7MAzfphjcmVo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5310.namprd10.prod.outlook.com (2603:10b6:5:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 19:56:05 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%7]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 19:56:05 +0000
Message-ID: <eaa66d39-a92a-4f5a-2c24-d429c85042dc@oracle.com>
Date:   Fri, 7 Oct 2022 14:56:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com> <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <a2e0b554-2ef4-1266-cc3a-fa5a28049131@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <a2e0b554-2ef4-1266-cc3a-fa5a28049131@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0100.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: 7652403e-b8c6-4315-4cd2-08daa89df80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfY9i+L1ti+3wKPAm2KP9PZHXK/hhTzly7MLwcHOnixsGtHNwoHQUKlrda6CbkmuDlqz9v8DhgfxaRy252gVTkd2rEWp5q6GuOSPp9d0LnE9pQ9ZKtA2kJSe9bmkaeZaUVj2aaLy4fcygJ1N6B2urZ77M+RqTiSWa1oCi2hVppR+nw3NFNQKLo0xA4wS5mieZ63LAAQztHt1zYSYdRcrfP/V2sacD3EVjaSlx2n+Yw9Hjudoty6w8E+SCL8KHSvHGYpBm2OwwX8iFeY0aJPENt7MMp49RcnODWY6bDD2wC8VNhL7tJcSSTE7piqycrfZDzIlnQFvie/7Zf1iHTPXCb0EDEoQCrLNx8cpGP+AzHZQGrc+WcNoy/8XgUBUArMpakvcPVHXM9NiIK4l9LvvFbwCVCtzuqZ5/4mguhjkKHJzAf0F5vQFFOEkeyCXkdu9M09Pto33QMU603lVsq+unyNTsJyuwp1UakRAE3aU53fjDwrL8bvjynibN7DUx71tcn7bDczKNh0UvVJF9Q12o+3MqnzTG78/pXrJsWEuSSVpGFu2W3N+6S9I/wUtWHQoirIgnUyUYtDDA/tNv4IvY7mAQapEKtHDAQVcdwF6z+uFczwv5EeCihoTuwOrMCKXvxNV3uzNlJM3jSDXnVH0+4fWokcPpgny1wQRYuSo2pItX8NsEExYrgh+gfS8fz6tNV9Jd0zZy+neSXhrDA20A4gHK64CA0m6gZQLon5msZLpCwj1d4RwfvA2sltCTPnQhF6ftJoAEewzpwyGyEEl6T4xjbNWMdwrRe/9fTkTDmLlfNWn9SCxs/HwOGy8nUEnd/Ajkpv7RAwbelTiNZ3spmJz9sU5sjZUq2Hdil60GqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199015)(186003)(66946007)(41300700001)(2616005)(6666004)(8936002)(31696002)(36756003)(2906002)(6512007)(107886003)(53546011)(110136005)(86362001)(6506007)(38100700002)(966005)(5660300002)(316002)(7416002)(478600001)(6486002)(31686004)(83380400001)(4326008)(66556008)(66476007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHY3eitUc3RxbzlPZ1laTE1vZjR3TnlwRGhHaU5wYWl5eXYyeTdYU09pdmNn?=
 =?utf-8?B?amppOXBva0NUc0hqMTQ0Vi9BaDBxaThNSGR5Yjg0OGg3bklpNkJ1K21JNVJh?=
 =?utf-8?B?MmswSGJXTXlCaXFQZVRvOEYwV0loMWdHaE1kWHJtTDVLaFllaUV5alhkMmxK?=
 =?utf-8?B?UUxaUHdtUXpEeTJnaFovTTB4bkZPOGRaY0szK0VZd1IzMFFVRWtDeDlFeHl5?=
 =?utf-8?B?SHlKaG9sbU5vQ21sTTF4d2F3TkU3eGg1WWNTY3RjNjZWcG5aQ1YxU3I0SlFm?=
 =?utf-8?B?T3JoOU1TRXlqaFBmdnlGZVBFUGxZOTZIMTRPczk3UnppeTJLSFpMZXhUUnU2?=
 =?utf-8?B?ZmpSVHhmV3pBVjZzeEZLK3JUaXBwSXBEUndRN3pGRkhaZlkzOEgzTG8xalBF?=
 =?utf-8?B?MWgxMjJOSkpkMFN5eXFDL04xMFhSRVBxbm5RYytrUkROdWVUYldid1oya1hm?=
 =?utf-8?B?bUJpeEJrOWFMOUtIMjJYQnVERmtrUnczOFJSZW1vcUw2ZzBFZjh1dzU3Y0Uw?=
 =?utf-8?B?OTlsV3NxQjQ5T3RzUVNGVHIvcUtpVmRtNEdQK29LLzdLVkdEV2FRL252Wkps?=
 =?utf-8?B?VmtJVXoyZmRCcDdtV1grbkxQWGpBcFZOcnNFVDhyR3dVQmliRTdMaEdudVhk?=
 =?utf-8?B?cjBtZVhGc2RYU3NaTEZQYlZZZWhQNDhjMkowM1dWSXJEUUwzZHhuMDR4dXB2?=
 =?utf-8?B?ZGZ3U1BSRVVwdDUyUVJmRHkrMTBXQ0NZcTYrZHUrYmMxQzBURTNsOWtRcmIy?=
 =?utf-8?B?aVJVOXl5QnBGNm9sV2p6dHpuN0VYL1RJSkZFZUpCT2pvemJtM0llMW1RR3kz?=
 =?utf-8?B?UXk4OWdjRUQ5aXkvWEFYeko1ZW5iMzFYY2RHOEN4TjBsMzkrcHBXNE9JeGwx?=
 =?utf-8?B?a0s3S09XQnNKVEZlN3cyRFlJNE44S3cydjkvQWdZNHEyZ2JsMHlYOWVqeXVl?=
 =?utf-8?B?VTNwd2t0L1dIT0JqenRLU2ttNnpNMEM2V0RHbjZSMjBXalROTUM4Q2RGcDJJ?=
 =?utf-8?B?VDN2Qi82N1pzcWFYNkdvWk0zVDY3bFZ2d2o4MEhyK1NFQWltV2hHekNGUjNK?=
 =?utf-8?B?NWgzVU0vbEw0Rm1jN2lLMlRuN2ZjaTV3V3VCZ01OR29PMENnK0RxcWtEYnh6?=
 =?utf-8?B?cVRWWnRBVXNHSjFFeFdQMlE4c3A3NFpBQ0VXUEwxdFFTRDVIWjlvUm5pYlVz?=
 =?utf-8?B?bk9RdEN5WkF1c3BndGQ0djRSbmkrVlRPcy9tb1lvT2ZKSXBZUlJpQnhhdENs?=
 =?utf-8?B?MGYyRmVMVGNCWFZQQy82NTNPRWZURWxuSzNKSEh2dlhRUjU0dk1ILzc3VlNZ?=
 =?utf-8?B?Nnp1TEx6NFNHQ3Y5WndkazBWRnBLVGxvdUFhNVVkUGJwYW5IU05Rd0VSTGJh?=
 =?utf-8?B?aG12SDBXdndsOVoraVo0QmV2TkNGdEpLaEtwWWN2N1pmYUNMU3NxUUNkYU1s?=
 =?utf-8?B?WnN4TlhzZ05oREIxdW84Zm5MVzFvR0U4TGhVZDdvKytyTUdWYmwzRWRBNjZx?=
 =?utf-8?B?bzlUOGF4MUM1V2sxdUswZVQyTm80RTJNeXNzaW4wTmVzeDh4OWFHYzJ0cDc3?=
 =?utf-8?B?NDJ0VjlleXlHTUpPTGZzTzhDMk5VYURhMzhLQTJTQXpXS3VEb1NoZTA3Y1JW?=
 =?utf-8?B?TzhvMDh3MUhGN0JYWHpOM3JFN2hlU0JDcU1sUVdIMkV4SXEweVBWd3ROY3hh?=
 =?utf-8?B?TmRHOHFsY1QyRTM2dzkrSTNWR25qQldhbGR0OVlRMXF0NmpmSGl3OXpDTXdl?=
 =?utf-8?B?QXVGYkJLN1d2bHlibnJ4aU1zWVUva0JvY21YUnZjVG91Z213MlNLQnZVMkFV?=
 =?utf-8?B?RHEzUk82dWRzLzZZbFBjM0ZtdFh2NTUrMU1XOXRJNE84dG5KUjZtN2s4SVRq?=
 =?utf-8?B?YVNBN2NvdWpydVBrL2RkRW0rWThkUFphQXlCK0d4OFVMdzlrOFpFK2V6NW9t?=
 =?utf-8?B?MjEya3ZWclN1WTdtWU1HQVp4RFQ5RWF2eThyRlRqK3N6ekc0SVh3eUpxUSt5?=
 =?utf-8?B?NHVlOVBEdHdUcThtZjRtYUVnK3ROdHM2QXNUbHRmbTBZaEMrc3JQMHRpQ3VC?=
 =?utf-8?B?endkOVh1U0ViR0xqZ2dmRXVxdHZndzgzK0ZZdm0vNzVMejRrSnJCa1pjWU5M?=
 =?utf-8?B?ZDQyZ1JwdmFsY2hyQzhIb2RnZ2kwUXpUdjdmS1VzK01UQy9JcDZCWWpkbk1N?=
 =?utf-8?Q?kQ6Lwrtv410gKO91dx0o0DQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7652403e-b8c6-4315-4cd2-08daa89df80b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:56:05.3511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cudy5XFeo+iW/4+zcTSnjDypK2QnkFrwvG6ugzcmoyoouFbS6G/ipj150yXjC5nRmtEmXPVr0hOAoabWZawWk6+MX1LQwWg4zHweteS+tds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210070118
X-Proofpoint-GUID: p3eraHrfrvXNtOIs_wv6V4mTWodoAlVv
X-Proofpoint-ORIG-GUID: p3eraHrfrvXNtOIs_wv6V4mTWodoAlVv
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/22 02:03, Sourabh Jain wrote:
> 
> On 30/09/22 21:06, Eric DeVolder wrote:
>>
>>
>> On 9/28/22 11:07, Borislav Petkov wrote:
>>> On Tue, Sep 13, 2022 at 02:12:31PM -0500, Eric DeVolder wrote:
>>>> This topic was discussed previously https://lkml.org/lkml/2022/3/3/372.
>>>
>>> Please do not use lkml.org to refer to lkml messages. We have a
>>> perfectly fine archival system at lore.kernel.org. You simply do
>>>
>>> https://lore.kernel.org/r/<Message-ID>
>>>
>>> when you want to point to a previous mail.
>>
>> ok, thanks for pointing that out to me.
>>>
>>>> David points out that terminology is tricky here due to differing behaviors.
>>>> And perhaps that is your point in asking for guidance text. It can be
>>>> complicated
>>>
>>> Which means you need an explanation how to use this even more.
>>>
>>> And why is CONFIG_CRASH_MAX_MEMORY_RANGES even a Kconfig item and not
>>> something you discover from the hardware?
>>
>> No, is the short answer.
>>
>>>
>>> Your help text talks about System RAM entries in /proc/iomem which means
>>> that those entries are present somewhere in the kernel and you can read
>>> them out and do the proper calculations dynamically instead of doing the
>>> static CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES thing.
>>
>> The intent is to compute the max size buffer needed to contain a maximum populated elfcorehdr, 
>> which is primarily based on the number of CPUs and memory regions. Thus far I (and others 
>> involved) have not found a kernel method to determine the maximum number of memory regions 
>> possible (if you are aware of one, please let me know!). Thus CONFIG_CRASH_MAX_MEMORY_RANGES was 
>> born (rather borrowed from kexec-tools).
>>
>> So no dynamic computation is possible, yet.
> 
> Hello Eric,
> 
> How about allocating buffer space for max program header possible in a elfcorehdr?
> 
> mage->elf_headers_sz = kbuf.memsz = PN_XNUM * sizeof(Elf64_Phdr);
> 
> PN_XNUM is part of linux/elf.h (include/uapi/linux/elf.h).
> 
> Refer below link for more details:
> https://man7.org/linux/man-pages/man5/elf.5.html
> 
> Thanks,
> Sourabh Jain
> 

Well, that is an idea. I'm not sure it is the answer yet, but if I do compute
a value, then that value needs to be checked against PN_XNUM so it still results
in a valid elfcorehdr.

Thanks,
eric
