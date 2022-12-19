Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467F9650E20
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiLSO6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiLSO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:58:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4DD5F53;
        Mon, 19 Dec 2022 06:54:06 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJDxSlR020236;
        Mon, 19 Dec 2022 14:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=H8NHwTxQDTK/Y5SxZmd7ttAGmr97pIordqvMZ/0uul8=;
 b=de7csfdj+ViUVISILUkwebvkpRYk3YHxrEYRh3Ubk3Yxrh5xFe2RObrG4J0GWDxe+TkR
 OfvBr6E8eDMdY2nYYqojx2thVM9MH+wVUjZ1lyaWSSLl4gsJutvPZF1UWms9wkge/mqZ
 RO/v9MHjTWfi+ExY4jsDlU5rE5YbqcvVztE3gd/rnu/NWesKGipNKZXO5Evdk11BaiGr
 nRMyfsIJSV2HC6NPKl+NS50WjJYEqAunaSpmyEceANcMFXXgVXxieXZtj6WisI7Xqc9z
 O9V/ZBHroj+zHICtbzBW0jlOa3M22P42wxLbOuxCVVHZeI+8PKU6Lh1jCXE71ClvOC5z FQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tnb1rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 14:53:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BJDK5fS006534;
        Mon, 19 Dec 2022 14:53:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh473uhmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 14:53:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ir3Re24GhQvgkcYPnx6iNLQujxce4YX+9y2ALxzj+oPSY8diSbQ9X9gWyttAf/6BYKBEHem1hrVYvbFvsVafjqj/TEYsmqnQ2GIHOS4/AvtGYnmSxEuSyBuAGsdffV3dDvj7UBaCxG6b2S3UPzzyYO2Xgx+uAj9s4drNqlQnaFrhUHnvSmYYoQs+t5Ztk62OzbHyn2kMXoZ/YKG7cNfRjgz78+7BEo2pKtuLP+TBZqbL+1Et/A2/8JLF2KqMrrrIx8fq6tetxGYOqF8lGLVW1l4nallU53sVJ1erZur/WT8ZB+TVU/r+sNG3E5klnMLBdi7NejzOHjSm/6yK3ga7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8NHwTxQDTK/Y5SxZmd7ttAGmr97pIordqvMZ/0uul8=;
 b=HrHX8oWbF9EcI3943UmOFn717wruc2Zi1+BA2kLzRWgUFO5I/JX8MnldBcDs4aadUEMCMrUlHK+XgXHMNfPJ+EoEV/rdHuGh4OkMHelFLochk2TLkzC8bHLXYkTNoOL8n9HxVAYB8ir3Iz962J/PdW/yVpNl3Meu5TaOwSGedv+y801QMVkga24sx/q7KGTkDuuAXPp6V0D61xlv4bg9zVNAb9KhuF2js21V36ONXbIcLyTN/ubwfc2qETWRdZWzxItBCZphVngMbV6XF3tWmnDHOkk87rHQOdg2dDXVE88gH+TVysPcdyn0rQlFKi1pgppxWrj/c3z1LHeXl6BKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8NHwTxQDTK/Y5SxZmd7ttAGmr97pIordqvMZ/0uul8=;
 b=kE7CMjlxEOaAbag+aYgGSdxQA0JH3yduM1I++Lk3+B70QRJCCuV2c4Cqbz6uILeOJow5xUzAipaWvFKQAUH5ZIeAYxAPfE7g5GnxG+6Ae/Zd+y7RMAJjQaF7iUiukfbzeRE9HvXJ6Le5Z82HIMwKivLQ7y4FeKnxknWCBXgtNeo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6195.namprd10.prod.outlook.com (2603:10b6:208:3a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 14:53:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 14:53:37 +0000
Message-ID: <9b8da72d-f251-9c1b-0727-28254d7007c3@oracle.com>
Date:   Mon, 19 Dec 2022 14:53:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V2] scsi: libsas: Directly kick-off EH when ATA device
 fell off
To:     yangxingui <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, hare@suse.com, hch@lst.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20221216100327.7386-1-yangxingui@huawei.com>
 <565fcf28-ec53-8d74-00a3-94be8e5b60e4@oracle.com>
 <f15c142c-669d-6bc7-f9b9-c05cc3df1542@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <f15c142c-669d-6bc7-f9b9-c05cc3df1542@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e85d4b5-4ecc-4593-d02b-08dae1d0cf5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1dZ6LWwWUEBHUF6oGxrnMn01f5z8LVey0JTbHkco6jXzWvq9x8cTxscBipbu2Rn5k5S8FghNEaQm6nshvbvkbhODpA2FY9qzJi0hUvnh6VWan7QF47a6fqYMzkleXcANQ3mZ2PNSWWpJAS26SnIw1qcnXWNbhYYusBdYMWiyQi5Pb7PqPYuUlHM8Hkkfl9rpO7IY3ZjGPpCEbrTiU0awCYR7WjxuMLfTaU2vsEry6XWPD3gVkXdr3PGNxQmDyk1rHbMAt2DsmZ13+bKdP8bQMBOCOVC1bDCRZ3joCUKAwjWlwuKk50Ybmti6CjkNZOo002cq6OFNbM+YKr3nAmdfokE/RUo9YZ8VMhQclJcJx4z2bV5n3FwwRVMzwe8bqxEDw4R6l2ZioSwKmkwZJ+kPh+uPD5LqTD9YFXaR96h316XXF8CFh3YC62uCX43c7PEkGns/JPeC9yuRGHzyw1NAUIAFWI6W6kgg7WXpelYt/UJ3YH1h+WjC3nS88XuDJs8Ns5ihMjOnYBld4aSBjZ/5+qZLqpHEnbBlkyo2Lz2k2YNeZGXDfx7k8n3NhbS5+MmOcIl8BZyuZCkAhN1TRWGk2pZXzXx1wOoN9sPYuE0XEL7lEiGqOqg+PWbH4ZZemv4kqMOMy9r8xG/s4P0du2zIZ+gw0O5BtpWK2bv/tk58YG/80TX7ixMvf+ECR3iU46LyqXVsD4GIuwAQOaEYwRsp8s/MNwj6vMpqJIAgeezSf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199015)(66946007)(86362001)(66476007)(31696002)(8676002)(4326008)(66556008)(316002)(5660300002)(36756003)(8936002)(83380400001)(2616005)(41300700001)(6666004)(6506007)(6512007)(53546011)(186003)(26005)(36916002)(38100700002)(6486002)(478600001)(2906002)(31686004)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDdLWkhNY29xTmJDTUNhTU5Td1FBVkpvZ1ozOTdKSDVMZDhrSW5hK1dsQzJL?=
 =?utf-8?B?NEpyYXpCMjZZdm9WOG96MDl1Nlkzb2ZCNUpYd2l6TjVPa3BMMTZ3RmQ1VE5L?=
 =?utf-8?B?RFVXMkd4QUlaS2doZ2dkanJGL1ZrVS9qZEYvVDExTlRHd3RUeHdSUmFRclQ4?=
 =?utf-8?B?TzZQZ2lPSGNMN3d5U0ZLV3lHVkN1M0JBeFBubEtseVFTNHc0Wk00YVgvem9Y?=
 =?utf-8?B?K3lBNEV2ZHpkbm5aVjR2MllLK292L1MwM3IxTlhwZlZGNGVBeUhXWHNQRmxG?=
 =?utf-8?B?dXlHNS9COVF4enAvVkZzSHB1VjUyWkpSQ1FJMHRyQ2hLUDNiQnJmR1VoTitm?=
 =?utf-8?B?NUNzd0NoaWcrdW9iUjRISWY2RkNGQSs0S1FYUGNTbWZyaU4vd280MmxINUVM?=
 =?utf-8?B?aVcyR2hJbW0yb0NIVzlFNzVpMFRtQW5nS1dPSHJwd0Q0L2ZoUWJQOXlCZGgr?=
 =?utf-8?B?d1UyUUxPbllrWncwTFpvUjhmVjUzNnFJQTBQbTRKYjhVTUloaERrSFZxbS9U?=
 =?utf-8?B?L2VHWEFwZ0U1V0VQdTB2MEVwcjJ5aHF2YnRQb1d0cHNsWEc3UGNkQnpYZTlU?=
 =?utf-8?B?dkc4eC9GTWg2SG9WMkVPWlNUS08wbkZHQzduY3VxM2k4NnpyRUxPZ1lqcXBH?=
 =?utf-8?B?ZUY1cmlKazZGdHJ6aGwyOFpHWFA0R0RaMWZLZlZaSmlOclNvMHQ4RXp2YTJm?=
 =?utf-8?B?OGJRb3ArNWJoUDYraHE5MmhCS1lINzFlcUJCQkowbHBPbEp1RGRkYlE2cS81?=
 =?utf-8?B?bzZpVkozUU1FY1NrZ2hrVVJJL2FOK0dMRmpkQ0NUQ0tYM3NLZEd5NUtlYkF1?=
 =?utf-8?B?VXRQQWVsUnpLSW93TlhZZE1ZNkExRGFhaTgyc3RJMUwyL1dmUkczemVYWVpG?=
 =?utf-8?B?cTN3WnJqa0ViODQ3a1JwKzlmNnpKQXVsNzV3SHgzblAraGZrLzBtTEtHM2lZ?=
 =?utf-8?B?bUM3OGpTaXB2NUlNRmZrNmFraWxVbnVLZTUyOFBFL2RhREdLT3ZrY09EVW5C?=
 =?utf-8?B?c1ZmVWUzaEUwaEFpdGplVnhmZjllL213aXJHVUhNWVFFNXV5RWo1aEs1T1do?=
 =?utf-8?B?dlRROUNveVdIT2RlSFBEWXFXZlRyMU5nZVZZdDVqaitxdDAvN0FzNUI5N2hD?=
 =?utf-8?B?YmxsMUhsbTE3UkFSZUhDNjBZQmhQeWtZbmdTVVlkSWxqK2pBek5GcWoyOG5G?=
 =?utf-8?B?MmFiTlZ4L1hqMS9QV1VaWmgwTC8xNllYcUQyMzlFaUNsdlgyNnkxVXVSOENC?=
 =?utf-8?B?RTJLd29XbDk1MERwMi9BZ1pxUE5JZDNqUjhwOUFLcVBCeURwbjVXREFZRStq?=
 =?utf-8?B?V3ZlWjBOMFRqOXNCQVRYcE54eElVcGFZMmxjRWhMKzUxU3ZNV3ZVeE42bElp?=
 =?utf-8?B?L1dGS0xHRjdhU2s0OXRJekdBZy9yQmxldUp1OWRUVlVOWUkyQ3FFVUZaOWkv?=
 =?utf-8?B?MTBKMVFQUXc1MTh5V001bDljbTlhZ3lJdzJZaHYzU3pzVjY5N0hVeUlvY1JJ?=
 =?utf-8?B?L2JQbUJIMTJQdHk4emtvekxJbW1yS3ZxMm5ZNldVaXN1ZVpUTTFhTEhLYTM5?=
 =?utf-8?B?RjJFR2lWbWFyNnNwZnlrYVJUQnViT0NGdlZQQjZBZ1Bmc05rUnZvempOMy90?=
 =?utf-8?B?TmVKRFMyT2c3K0U2NW8wdHNHS2haY2xHd3ZudWJ0TVJ0ZlZMbm95VDRJenZj?=
 =?utf-8?B?RC8wK1BGaTdCN3FnRVpzdndSVVVOL2xVZ2ZiVDNBY0FPWll1SnYrNFoyUEtY?=
 =?utf-8?B?dUFnVmJrT0ZGVlVWNDVMSU9uM0hDVGh5aWlISFl4Q3VkTlRkZmtKWGJ1N0Ri?=
 =?utf-8?B?VmJHQjBvR3hMclpyS1kxdzRvK29Cam9QaWIwS0txZm5vMzZLdzdYb0tidXE3?=
 =?utf-8?B?OXJOa2I2T2h3d3lhTmp2cnB3UmM0MWl5bVZFZC9yTERaaFFYQnhYWnVQcWFP?=
 =?utf-8?B?OE1RWHk3cU1rQ0xzRjkxQ0kySXAzOFhXRnJsR3g3UDJkQWJCcXlPUERHa01w?=
 =?utf-8?B?R2hMM012cEpNeGI2UXB5R3NsWWNXdktvZ0xSU2lHeXU1V3EwcUxoaTJUSGNr?=
 =?utf-8?B?VzJnQTVkaG4rdE5mVE5temJsRUxrVjZXdWlaMTJxeUdFdWo1dFBBY1ZYblJR?=
 =?utf-8?Q?BHDMGmWMEuhXxeEC5MRb+ZyA/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e85d4b5-4ecc-4593-d02b-08dae1d0cf5d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 14:53:37.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dq0AwHNJNVa9M7GXkmVnYOxeow5dXOPxrLw32NG+ahqRUVlLLRH47bTSc9y6rJnA2c8l5iuJ1wowwd+nSVLWmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190133
X-Proofpoint-ORIG-GUID: iUFSTV0rQJaFtDAeEf3NmFhKxytZN-bl
X-Proofpoint-GUID: iUFSTV0rQJaFtDAeEf3NmFhKxytZN-bl
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 12:59, yangxingui wrote:
>> Firstly, I think that there is a bug in sas_ata_device_link_abort() -> 
>> ata_link_abort() code in that the host lock in not grabbed, as the 
>> comment in ata_port_abort() mentions. Having said that, libsas had 
>> already some dodgy host locking usage - specifically dropping the lock 
>> for the queuing path (that's something else to be fixed up ... I think 
>> that is due to queue command CB calling task_done() in some cases), 
>> but I still think that sas_ata_device_link_abort() should be fixed (to 
>> grab the host lock).
> ok, I agree with you very much for this, I had doubts about whether we 
> needed to grab lock before.

ok, I hope that you can fix this up separately.

>>
>> Secondly, this just seems like a half solution to the age-old problem 
>> - that is, EH eventually kicking in only after 30 seconds when a disk 
>> is removed with active IO. I say half solution as SAS disks still have 
>> this issue for libsas. Can we instead push to try to solve both of 
>> them now?
> 
> Jason said you must have such an opinion "a half solution". As libsas 
> does not have any interface to mark all outstanding commands as failed 
> for SAS disk currently and SAS disk support I/O resumable transmission 
> after intermittent disconnections

I don't know what you mean by "resumable transmission after intermittent 
disconnections".

> , so I want to optimize sata disk first.
> If we want to achieve a complete solution, perhaps we need to define 
> such an interface in libsas and implement it by lldd. My current idea is 
> to call sas_abort_task() for all outstanding commands in lldd. I wonder 
> if you approve of this?

Are you sure you mean sas_abort_task()? That is for the LLDD to issue an 
abort TMF. I assume that you mean sas_task_abort(). If so, I am not too 
keen on the idea of libsas calling into the LLDD to inform of such an 
event. Note that maybe a tagset iter function could be used by libsas to 
abort each active IO, but I don't like libsas messing with such a thing; 
in addition, there may be some conflict between libsas aborting the IO 
and the IO completing with error in the LLDD.

Please note that I need to refresh my memory on this whole EH topic...

Thanks,
John

