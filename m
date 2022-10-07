Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BE15F7E08
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJGTeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJGTeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:34:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90320BC60E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:34:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297HrBaZ023296;
        Fri, 7 Oct 2022 19:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wWc+DiGTm2abnmcOL1KStoddl+AJ3wQYtsCMujSHhHo=;
 b=QRodZ/wDgeKFIZPmqZDiCfaxx4zcm+ttgFyRwDfwgYlnH8lrRpFybCi1VCmGgpzfhq/2
 aEZUI296jyX5YaApbuoDdNfYWanvU1KeGHxmbtJkG2fXK1H6zu2XfGmGeaxcAptHPfwf
 eBfUCRE460WGZ7/MQjyA9hCLD9i7z8UGOUvUHDItm+TmGYJ+UNL3w3/n9ByWSbIfBF/T
 RYltf/8ZxrpD5XE4Z5oVyt7PG7zMy3/Asdlg5ueRU1XL8TvOBDIzkk1J1aZGE6cXIuvc
 5HFSQErt8uczoJvFM7jywKYuEBZYR5hvR4LB3XjlmNv+SEBNZ87PI4N4pkQARP4M1VAn vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxe3u0dfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 19:33:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 297JHQkD028324;
        Fri, 7 Oct 2022 19:33:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc07kbxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 19:33:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBbsvu72aBeZiZZn3qAixk1Y9Q4zLlpRlRLIsWpyFMd2wC7qyVNcz8M/2WadDvrKSHO18PNqR9H2Od0cf1UaAa9jftXJQqKJiQbBYm9+Wd+98nEbZaJC4CeXGZUl29LesvFqekSWjdEN/gVrd+C3R2on7buIhUwA5i9G5XHo4airDg/AgJMshh4tWqfiBpxyLaOtmVUrPPyr4BLBz3hP/ieDD1JJsNc9pYxKde4cuMI/i5gvn3+2GnqtplXRmIXnjmAk1qrqYOMn4HNp7ZFRWv6MfzoPm9lUY1D5hYG8cOFJceBu5FRgwFgj6XKdRoAfUxUUCGLyOF7FybGTKjATiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWc+DiGTm2abnmcOL1KStoddl+AJ3wQYtsCMujSHhHo=;
 b=YMZN2TsZCithUrpxXRW6lUfsflLhfUZTe1hEu0VS4wHU6Yv3A+THmph7pKQM1i/eiYc3F7YKqqNePA1vVenqU0HXfvIYtriuHSQgf49f7SkQFfNmjt/uIOhfqlUjWo4A9KieBoMm3AnUSs1ASzfCEXyLZ60zGhmegQz64jok0jpWrj2h17oPdyZJ0u2yHkq0joj1CrFcaY6k5UJo3OzV9Q6eETpkQKlRErMQA2D1V8/J1sw73jsp7pt5I4km1noWujBP/3oMyg9lCWsaCT/4M6DZdX+Cz0u0hTcN/8dV6gfiGTO39dFvG9rdkYuBctL55touSR8BLsW34CEo8mDDcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWc+DiGTm2abnmcOL1KStoddl+AJ3wQYtsCMujSHhHo=;
 b=KvPqz5/18UExYlVLibI/oyrwZZcwbIcwmO7OIJK9eM9hWKUrkcht015Vi6QWi61AtMdI58DsMUXqSFAFPKx4nXMUxn7Ik8Q+zOXF1R0l7bfnepwa9H9j5j0lOlVytETLf8kt3VlhLavD4m3WEIMP83/y2HBwKplfeF73LZNSr84=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5006.namprd10.prod.outlook.com (2603:10b6:5:3a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 7 Oct
 2022 19:33:25 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%7]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 19:33:25 +0000
Message-ID: <46e0908c-a753-bec1-68bf-a58a89798056@oracle.com>
Date:   Fri, 7 Oct 2022 14:33:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <78100f92-afd7-52b6-d5e5-17eb2de72a9a@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <78100f92-afd7-52b6-d5e5-17eb2de72a9a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:8:54::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: e8392cbc-b315-4812-9a1a-08daa89acd40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjTzQNiGuYwPC1Wqlj1sM6+u4P6KvQN8dQu/y6Q4CSRzMH9mwfo3kZpkT6Mi3dy5y7hw6rg+6TiyyNNpqKkdzzaqjjsDKZeoQHLqJuC9yvnh0T/ag6UXo5R3V6tgOG5MqG+vlcRUkqgHUbYp6Zg0Ac5v/+KKivd4AJvGV5ntAD0/FIlTLxv4bpOpiPC1X4WMKF9Wl1A2zOO7fsR+uIlPEvzkrkapHinKuZt430XNK9Xl2buaUgEQTG24aBqlEjsNIR33kcAHGPov6eZ3sSmNKPsK9LdKhoU2h96JzuIGrSxWoPDZ4unTEIaoLpIWP/cadY9Df1UEER3jo8+/p3ZVTHTVDOuqByjgawUX3v1PSIlJIcS0SsNNtqWpDhMy8QHF1oh2Yabx2cQPRjzMkJWGWpDdgwfxuM6GChjPDq4lZZal4DpTw2c3N5erLZ1O68nDm/9HKyYpnk2TuCM2DIRZZ+PVKAWxyQ1YEySS2zYyKeJwB5QpT9Ceot6JdTujzNAGKYewcCy21Un4MzkundWPbAP0LytbTFoldab7vvGBV4nXtNbipX8RpkR399EFewQ4T2p7CbmlcXepBV3fKIKpgn+jFXZfUn0BnmeM2rAtdCap0Z292RJcmXZN5+SwoRFx0DReIc1BMjXNAb4fnnSs2N3WtwKqzTZF7A7mVX5mVi1LChdd4+pxygpNg1AjOqlOgzugVhOdZRlc8sM+7CsZ9L1ke95F2iMcvs0Klp1yyBje9AZmzfEnk132G2bASIpZmhGJEive2M0ksl8MKJy2sds9QgE+9H/obt6PpQh6iXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199015)(6512007)(5660300002)(31686004)(7416002)(31696002)(8936002)(6486002)(83380400001)(36756003)(478600001)(53546011)(186003)(66556008)(38100700002)(2906002)(86362001)(316002)(6506007)(8676002)(107886003)(41300700001)(2616005)(4326008)(66476007)(66946007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkpwSVM0K01UMUQzdHh2VVpxZ21aZEdCbzdZQVhjcU1nUTh3TUwwVm1MUFdP?=
 =?utf-8?B?ZCtScHc4OXR1Zm5Yamh2WFVNVG0zcjNoSHdsVm5pZXJtNTVWSURRRjhlOFB1?=
 =?utf-8?B?SCtvNU1XNkxoeDAvNUtReUhqZHlNM0ZRcHZTY1Z0ampsaDIrOG1QdHFqRmNq?=
 =?utf-8?B?a1RCOU1ETnFlcXBXQmJlNDFjN2dKS0MxNEZQdzFJUG9wUDFDM1dQb25COGxw?=
 =?utf-8?B?dnJ1cCtCckJvRDVFTlMwRkFGcVd0QjJHMWF2Q1hWanVjMTVoRko3aUtsQzNs?=
 =?utf-8?B?dExEb3JiTDFDOGJnS0NIRnZUNzVYNUlFbUY3NHZmUE1rU1oxbjNlQjF0NURh?=
 =?utf-8?B?U09FaFZVZ0FYSWxxUEpFekJoSzRFcVdrNXBpR2lhMWJZcDM4UG1ja0taNm0y?=
 =?utf-8?B?a3UrMi9laCsvblVGMTl6a3JCaWVrZEFiVFkxVDk5SGdSRUtQWEhvVmIyZzBB?=
 =?utf-8?B?ZEVzVlBURENPYXhYUjQ1OUR3V0dDWDBYS0h4cmJjTkhCR3ZGcXpHY1NiMDlw?=
 =?utf-8?B?cEJ0ZVJjcWQyQWtDNkxURmtEZGFuYWUzZDI3RHlvRUZJeEdaOFhtUFkwRVNE?=
 =?utf-8?B?RElzamt2aFg5V2hsTFRJaFhYNkxXeUJXRXpSMzVZbWdkZEM5WDVua25lcVkr?=
 =?utf-8?B?UDZQLzk0NlZFUXZIaEh5LzBCZXFBTktnTzdWUVM0eE9EMUpXTVRyNUtQdUhX?=
 =?utf-8?B?V3RFY1BNVlhMR2tERzNja2FRSjRGcmFNS29veFBqMHE1WHBOck5xODZiaWVj?=
 =?utf-8?B?NXN0MERIcUlXUG5CeTFRekNXVTBBOEhvb0E1d3EwL2Y2SjQ2THh2NGg4UjNB?=
 =?utf-8?B?RGt6NlFLa295eGVWT0Y3VGFkWWNUQXJMYVNDUWdDbGZVbjNlSXlXWm1lYUNn?=
 =?utf-8?B?NmU2a1E1eFdJemI2ekN0VW9uL3lqS2oySzArUzhYeFVrU2pXUjY0ckZOUHRm?=
 =?utf-8?B?bFNNZGpRN1prUTZHTitNdHg0WXpWMEtmSG5zb0xMU0l3cjFzRStHdFFuVDN5?=
 =?utf-8?B?MEpVSTZzbUN3VE54UnBrSzFpbDF3b2RBNm5PcktKUXkrZXdVM0Jud3NqTk12?=
 =?utf-8?B?R0Zic1I4N0EvVE9zWXdBeHA4VlNyT080S25QOFhjMFZlc2JuNmlzamkrWEZJ?=
 =?utf-8?B?NGwweXdQRXJQb0FZMGhhVUhIUmEwQWEyRDhjZ3FPeTBxNkdhS2xOKzVpQndq?=
 =?utf-8?B?aEhtSlNLcDdNbzMxMytWeWNzNXlLdXdveUs5MHZ3cGRGRHkwMnRIdC9DVlUr?=
 =?utf-8?B?TzhQdmlHWmprN0J2dXVmSkNFRVhQdnpiSllEalY2dzVOVU1ndmZyWis1NDBX?=
 =?utf-8?B?ZEpoaXpaaHBNOStpbWpSVENhLzBKdGlHbFNxdUpEblZuY3BuNCtrTUxJcEpT?=
 =?utf-8?B?UmpJUEZIR0dNb3ViWGFKMnNHLyt1Y2NINUhpN055WE9ENFZHM3RqWmJmNEEv?=
 =?utf-8?B?RHpqSUZZb21xbnlyb25qTk0zTWRzVTlubUEzbDB1YmxWU2Q2cSs5TndQTDFS?=
 =?utf-8?B?ckUwR09IRFgzQ1cvcnI0dWNZUDFXUTRReE9VSmxNZU9Xenc5MzNBREcyZktJ?=
 =?utf-8?B?SUJOMzMxOFpabUNYMlVrQkZrY2VVMlBjQXlIdlhjOTdIekFPMUsxUzU2eDF6?=
 =?utf-8?B?TWQway9DVEhURHRKNVk4c0pKc21teER3c0VXYTdPbTJlWmFrdHJ5MEtHbzJy?=
 =?utf-8?B?dFlkNlo1YUZVZGJ5blBCZG9XMzFFeklEanhQL3BHb1VBR1hMeTV4OXQvN0J0?=
 =?utf-8?B?OTZrTkpxNzdNYTI3cWVENzArVUd4eVNSb0tsUGt0MTlRdk8xT2IweEYxbk9R?=
 =?utf-8?B?M2dMbDd5VE9aQ2tMazF2QkxvSkZqRGVNZk9BWCtkdVoyTmFaUjNGK1c5YkVz?=
 =?utf-8?B?RWMwbUtsMWVlcnBpaFdvZnJXb0VJZW9tUVV3NFo3clZiczZVbGtMOGo0MTR6?=
 =?utf-8?B?Yi9Zb0txek00ZTJzbmNtaWhWaEFOSzBPSDVoZjc1SldDOEhXT0tOOEd2b2t4?=
 =?utf-8?B?TE51TVB1VEFuazN1TWVOaDk3cmhBSzk2MDJncnQwMkpoK0cyY3huMU9EUC8v?=
 =?utf-8?B?cmhRMHdCU2ozWDFOajFYTzVQM0FpaHhUcUhXRzNhbG9FeXBySnVQcnBMWnJU?=
 =?utf-8?B?U21TZXdlWnFlRjBwUk5HTzNxejQvQWc5eWNMemxmaU43akZEemtzVnRYc3Nh?=
 =?utf-8?Q?X9RLYNjdQxrTpkaZWr2Fbjo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8392cbc-b315-4812-9a1a-08daa89acd40
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:33:25.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDQwHwUNdh6hZgko8CW6LmMOiPxgoanvL/0CMWon2VmaN5PWevfHRH+wLXWIuJk6o8d9kQBoqt4ymHQqseoTtXYgYuMPhgsHdxY5Wf0MNJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210070115
X-Proofpoint-ORIG-GUID: 8wXWaYuLUIb5lFDXSafxOYE3XH5fDsxg
X-Proofpoint-GUID: 8wXWaYuLUIb5lFDXSafxOYE3XH5fDsxg
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/22 02:06, Sourabh Jain wrote:
> 
> On 10/09/22 02:35, Eric DeVolder wrote:
>> For x86_64, when CPU or memory is hot un/plugged, the crash
>> elfcorehdr, which describes the CPUs and memory in the system,
>> must also be updated.
>>
>> When loading the crash kernel via kexec_load or kexec_file_load,
>> the elfcorehdr is identified at run time in
>> crash_core:handle_hotplug_event().
>>
>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>> generated from the available CPUs and memory. The new elfcorehdr
>> is prepared into a buffer, and then installed over the top of
>> the existing elfcorehdr.
>>
>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>> the need to update purgatory due to the change in elfcorehdr was
>> eliminated.  As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
>>
>> With this change, crash hotplug for kexec_file_load syscall
>> is supported. The kexec_load is also supported, but also
>> requires a corresponding change to userspace kexec-tools.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   arch/x86/Kconfig             |  11 ++++
>>   arch/x86/include/asm/kexec.h |  20 +++++++
>>   arch/x86/kernel/crash.c      | 102 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 133 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index f9920f1341c8..cdfc9b2fdf98 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2056,6 +2056,17 @@ config CRASH_DUMP
>>         (CONFIG_RELOCATABLE=y).
>>         For more details see Documentation/admin-guide/kdump/kdump.rst
>> +config CRASH_MAX_MEMORY_RANGES
>> +    depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
>> +    int
>> +    default 32768
>> +    help
>> +      For the kexec_file_load path, specify the maximum number of
>> +      memory regions, eg. as represented by the 'System RAM' entries
>> +      in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>> +      This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>> +      size to determine the final buffer size.
>> +
>>   config KEXEC_JUMP
>>       bool "kexec jump"
>>       depends on KEXEC && HIBERNATION
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>> index a3760ca796aa..432073385b2d 100644
>> --- a/arch/x86/include/asm/kexec.h
>> +++ b/arch/x86/include/asm/kexec.h
>> @@ -212,6 +212,26 @@ typedef void crash_vmclear_fn(void);
>>   extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
>>   extern void kdump_nmi_shootdown_cpus(void);
>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
>> +#define arch_map_crash_pages arch_map_crash_pages
>> +
>> +void arch_unmap_crash_pages(void **ptr);
>> +#define arch_unmap_crash_pages arch_unmap_crash_pages
>> +
>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>> +        unsigned int hp_action);
>> +#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>> +
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +static inline int crash_hotplug_cpu_support(void) { return 1; }
>> +#define crash_hotplug_cpu_support crash_hotplug_cpu_support
>> +#endif
>> +
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +static inline int crash_hotplug_memory_support(void) { return 1; }
>> +#define crash_hotplug_memory_support crash_hotplug_memory_support
>> +#endif
>> +
>>   #endif /* __ASSEMBLY__ */
>>   #endif /* _ASM_X86_KEXEC_H */
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9ceb93c176a6..8fc7d678ac72 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/memblock.h>
>> +#include <linux/highmem.h>
>>   #include <asm/processor.h>
>>   #include <asm/hardirq.h>
>> @@ -397,7 +398,18 @@ int crash_load_segments(struct kimage *image)
>>       image->elf_headers = kbuf.buffer;
>>       image->elf_headers_sz = kbuf.bufsz;
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +    /* Ensure elfcorehdr segment large enough for hotplug changes */
>> +    kbuf.memsz =
>> +        (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
>> +            sizeof(Elf64_Phdr);
>> +    /* Mark as usable to crash kernel, else crash kernel fails on boot */
>> +    image->elf_headers_sz = kbuf.memsz;
>> +    image->elfcorehdr_index = image->nr_segments;
>> +    image->elfcorehdr_index_valid = true;
>> +#else
>>       kbuf.memsz = kbuf.bufsz;
>> +#endif
>>       kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>       kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>       ret = kexec_add_buffer(&kbuf);
>> @@ -412,3 +424,93 @@ int crash_load_segments(struct kimage *image)
>>       return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +/*
>> + * NOTE: The addresses and sizes passed to this routine have
>> + * already been fully aligned on page boundaries. There is no
>> + * need for massaging the address or size.
>> + */
>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
>> +{
>> +    void *ptr = NULL;
>> +
>> +    if (size > 0) {
>> +        struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>> +
>> +        ptr = kmap_local_page(page);
>> +    }
>> +
>> +    return ptr;
>> +}
>> +
>> +void arch_unmap_crash_pages(void **ptr)
>> +{
>> +    if (ptr) {
>> +        if (*ptr)
>> +            kunmap_local(*ptr);
>> +        *ptr = NULL;
>> +    }
>> +}
>> +
>> +/**
>> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>> + * @image: the active struct kimage
>> + * @hp_action: the hot un/plug action being handled
>> + *
>> + * To accurately reflect hot un/plug changes, the new elfcorehdr
>> + * is prepared in a kernel buffer, and then it is written on top
>> + * of the existing/old elfcorehdr.
>> + */
>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>> +    unsigned int hp_action)
>> +{
>> +    struct kexec_segment *ksegment;
>> +    unsigned char *ptr = NULL;
>> +    unsigned long elfsz = 0;
>> +    void *elfbuf = NULL;
>> +    unsigned long mem, memsz;
>> +
>> +    /*
>> +     * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()
>> +     */
>> +    ksegment = &image->segment[image->elfcorehdr_index];
>> +    mem = ksegment->mem;
>> +    memsz = ksegment->memsz;
>> +
>> +    /*
>> +     * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +     * memory resources.
>> +     */
>> +    if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +        pr_err("crash hp: unable to prepare elfcore headers");
>> +        goto out;
> 
> On PowerPC, while preparing the elf core header the memblock structure is used to prepare program 
> header for memory regions of elfcorehdr. Since the above arch specific hotplug handler gets invoked 
> when memory is marked offline (MEM_OFFLINE) which is before memblock structure gets updated so on 
> PowerPC the above handler may not work for memory hotplug case.
> 
> Just wondering which data structure is used to get the list of memory regions while preparing 
> program header for memory regions of elfcorehdr on other architectures?
> 
> Thanks,
> Sourabh Jain

I think your request to report the memory block address in comments of patch 3/7 "crash: add generic 
infrastructure" cover this scenario now.
Thanks,
eric
