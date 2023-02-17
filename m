Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D606569B1EB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBQRjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBQRjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:39:12 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB6D714B1;
        Fri, 17 Feb 2023 09:39:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NR3Iqt3hGlFdushbChAYVaKht1oEnou1ON7UUK4osX5u1WvevI7GnFIKmz+kHpKxfc88vWYEC7WlOoXjQJUb2yDVGQ3hDB0MISR4ZF/NH7diOg4KzrAq3lP3sR/fiyEezpytzdVyHxjPayrXKJRBdQ3ybP1Qu4h80PpX4P1kirCtZ6e19TQgnudF7I2C9vXvReD22c5DeE3+V00xs8NhfOBpQ4Kzko7HlwVAzt7xZeywirR0UW2lEUuTpsuvipxKMdasVDYSKZJJCC5O+wmzq6N0sYCa9BGRlH4OMczlbJIMzTiRrBpGjIkhWzttDFNJ3F8rTqqPuhktIc54miViug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H77gbb84LkThEiXJ87YctDuXkUzG2cji0c6ACnI6rCI=;
 b=iYnWghEWku14tNI1Dq/ZYpoHkCF+fg7B6Fo9efcVUyADaSTafrVvmbQX9ahfYa18YtgVLrdGcGAjOZ7iz5IewraS9yvLoBsn2f9w5xJKVfoHkbj67XxwdfnL03cBEq3RGdOpPDi+M18J7BLCSuIAglJ5ml2U48E4zFKm3msclmA3QbFnUIkHgxxehZWRuArULAAfWS8CQ0M2/2J21c0FkdeVjIvE5YskYSgl8OAtUavfAcuOb1elNSiG4m6neRhoud2Auky1zSDWrlgbn2v8CzmA/qQvDoi5OrJX1eY6hZTCymblBmAe7NAC1FBGIAJ2Juhc8vNTlJZJBwRT0nq5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H77gbb84LkThEiXJ87YctDuXkUzG2cji0c6ACnI6rCI=;
 b=4rYnj/JtMwXOeHplXyXqOyUB+q5QWUgOrPB8HpsMJdQ1eFfPO3oiPwTPq5LUAEwebU6naAGs4AkKvo0e2je4kdH7ynI8ARXws8mh0Yi8zR6XCwH6ExukNmAYceRtqKzgVPHGrY/A1mY5tv0/oJgT9Kffr2TGbybTJTKpCzs33TM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 17:39:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%7]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 17:39:07 +0000
Message-ID: <5a7cb1e1-1cee-431a-485b-55913a5766e2@amd.com>
Date:   Fri, 17 Feb 2023 11:39:02 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [RFC v2 PATCH 6/7] x86/resctrl: Display the RMID and COSID for
 resctrl groups
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        reinette.chatre@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eranian@google.com,
        peternewman@google.com
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
 <167537445137.647488.9039585071837467840.stgit@bmoger-ubuntu>
 <0b42ee96-32cf-b929-6033-7898821b54cb@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <0b42ee96-32cf-b929-6033-7898821b54cb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0258.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a1304b-49f3-4348-9db2-08db110ddead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFPvXIJz7vCMA2/dSgg858HlJLjzau4YUWY/ixW06I1la9ff7BmRdEs1xr/X8DmJRSDyUbaRY3RclPtP6nzsAhRqQx6UzWRpRA367Xs5QO8BzDflh8HwXOeDvFpTlTjXdiYwguWIFdu68CC/nUEb3kVZz9/Ngy0gGZhkps68oKKznnZwVE1bzSEdXwao1lA8qPPv9u8mhWjWPL/ZblAWb9Usg46Ae7DCaHnJBBtG06ocq3IijvEIS2umxYyxnuC5/XEklcKZ9I/kCdYSpUPYrGT4VUq1nTxEQhzRne+ciBH956P+CJoLzuSVofBMg+INyZ3/Is8/VPb3sIYEuvPCv2yUylAn6nFWo/TkzEFjSU4avOTNWn1KMNncQzzVG6mgHWVjkwXQXkx2XvlYNEaOtJx6hcAOKjE+VBgiFrIeeUCNeUaylB/ahHPNfhznY7mGFI7DS0WcNd9Q05G2mbYh68EaEMi8hfJtD93qFaz7aK3UR3F2h284PqFy5PgwxCMFzupZytJUbsGQeXK79D93tV8tpHKBC9RmcWfU88OIVAuN17HotMAbxCKM6NnAIqvH9r0nvXQSkNDexacoR9aW76L3Af2EzKYjEqgwF0T2T4Ng/Qt9gpAtwjCSoHayhNztSjqlf2XW1+PMUbUqzai1dQBPSKH5J77Nyr+8O2Zu58rZodc1MJ5zYsGubFHHwaeU16OhJ+ZMmgocOIR8ENZZcVykhoeRSYmLqAS5s1nXRI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199018)(2906002)(31696002)(38100700002)(31686004)(110136005)(6486002)(53546011)(6512007)(6506007)(186003)(478600001)(26005)(36756003)(66946007)(8676002)(66556008)(316002)(4326008)(66476007)(41300700001)(6666004)(2616005)(8936002)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzJpZC8xMS94T0prZDYvdFNubFBPeUdqQ2l5ZDhrQnBac2RRN21RYmM3d0wv?=
 =?utf-8?B?ai9wS3o3TnhQRkZSMllDY3liR093R1h1eldzYytTVWlBYjVwaDA4NHRZUVRy?=
 =?utf-8?B?d1JJNnppdzJwQWkzZUk0SWtRWHF6UC9acE5pd1pweGhaTUppMXp2Qm43TW9l?=
 =?utf-8?B?OFZESUhkR20xMG83ZTFRZ3Y4eU02WFZsNlAvbFlwT3pjS2RCYWhMaUprOTRR?=
 =?utf-8?B?bDhQOG4yMkpRVG5uSEt1WVQ0V3NxdDlBTlowQkh2K1NVSlZQRTFBVjYwczNv?=
 =?utf-8?B?eGRIb2lJcFYxN2xicklQT0JVclc3aHZISFlYY01rb1FvU0QrSU1QTXhic2RG?=
 =?utf-8?B?N1dwMW12cDVwTERIdE1IZFkrbWI1aldGMWhYL1RITVRxN1lWVGZ0ZjRwa05W?=
 =?utf-8?B?ZkpFclMxeE9FbmF1dkQ1MExIeE9qU290a3lIUzhUc3JhLzVCdUEvRmNHaXNQ?=
 =?utf-8?B?ZUV1OW54QTEzOXgrSjRXWktlL0F5azI0RGxpZ29PV0hrQUM2Mzg0Z2s2WTF4?=
 =?utf-8?B?cXVCblU4K1dXV1lpcjRkQ2ZhdHpSM3R6bzMyRDgxOHF2SVFUVVNJcHdwTmlH?=
 =?utf-8?B?S2M5NXV6UU1QNER1dEhqTkNpSjNNVmdWQ1dsQ2xrZEk5aWJRekFFQUFEN3hQ?=
 =?utf-8?B?c3dkS3hXNnBGRHBYVVk3UGZFeEdKT09GRHRLbmhPRGI5dCsweFBXNG0xNlJv?=
 =?utf-8?B?TDBLb1BIa1B4WXZOcTBkWUJ2bFZjc1JVd1VDdzRvNVVDMFlVWW9rUlFieFpX?=
 =?utf-8?B?NStMZlRrdlkzUG1PYlgxd2ZYNWV1ZTE5TWhPdDdlb0ZSdGdFQTkrOUIrNEVJ?=
 =?utf-8?B?eFdWbDAxNFlzRzJSOGs5THk2N2NVOSs0bjh4a1k2d244L1hJUzE2QkZPYVpM?=
 =?utf-8?B?T0Q3OTJtSVFSQldrYU9UVHpqNkFEcmlwNFBrN29aeW1tOWtQaDdoYUUxeVRS?=
 =?utf-8?B?dWpOcVpReGZ4bmJZUlNSdlFhVVR6Vy9mc1JWMWs5R2ZlUWxSZmtYT1BVR2Jv?=
 =?utf-8?B?ZnhSZGZzQzV1K01rWFI1YkhCWGRNaUpCQ2RHZndLSExSbjh4dFloOUxKZk1n?=
 =?utf-8?B?RUcwSld2cnJxVUxzSzlHR2VvTEorMEI4UG53RzY3RWV2bGM5Q2NrQ1dqVXNy?=
 =?utf-8?B?VndiRDZ3Qm1MSTNJOUFjQ0c2YzlWVW1oUGVNOEJlZUwrT2RaRkpoYUNnQ3hH?=
 =?utf-8?B?cVUyYkZ2bEZiTWJRNTdBejFIR3NsaWRaZDlOMVc0QnVySE93aCtLZFpDSEpV?=
 =?utf-8?B?MkdtMDZXUVlablpoSWZpTGh6dmFmZWIzRElManNnYU51MnFSRFRrWmJ3V29R?=
 =?utf-8?B?cTVITUlLY3BETjZOc0Q2b1pDUjB0UDk5N2NzSW1mMkNWT1gwVFV0ZktLMEtp?=
 =?utf-8?B?TFVnb3RtWVI4MlR2OE9BQXM1bTlnZmJqVmZGTXFPSzQ2ZGhpVzJSWnJpeS9P?=
 =?utf-8?B?cUhCTFFTSHZHdXZPRWV4QWdRSndRa05TVkJzZFhIQ28yVFFCaTAwVWpOQ1o5?=
 =?utf-8?B?WGVadk5ROGJ0RkdVcEN6aHh1WTNxMlkrNTdHTjc0TEhFZ3czTDU2UFpNVE1x?=
 =?utf-8?B?WDNFd2ZieGEwaDZPTVU3QWtkNCtDVW1IZGZkMDNyS25HWThVTDE3MjV1SWsr?=
 =?utf-8?B?TDF2ZEZLV2YvZTV2U0MwT3lOTldjN3dzRitab1Y2V3JEMXZPSHVrTUJRK3ZK?=
 =?utf-8?B?RmY3b2R5ZXRXYU1BeE5Sem5JV0J3NmJEUk1FOFpIdUdZYnhKS2lNK2FLR0tR?=
 =?utf-8?B?ejUvYTZnSGdSZ05SeUZ5SXBvM3kvZGN6UjNFTFlOZmxYWElHQ2hHZnJLR0Fs?=
 =?utf-8?B?TWhJV2RmemQ1YnhvUGc1cisvc2kzZGFCUXE3d2pMR3EwcXo0dEkyMDFuNTgz?=
 =?utf-8?B?KzNxVFlTRnI1aFVhbzVTaitPcjM0TGRsWGtHNjdVR2FoN0owOG45Q0l6K20r?=
 =?utf-8?B?SEpkc0ZEdS9mRHoyckMzZjhlYStMWjN5SWlIeG5yYmt6c3VDYzBWaEVETWFD?=
 =?utf-8?B?YUw0QjNYVVFSZXE4Qnoyb0hEQWgxKy84Nks4SVhTNnovaEJHdS9iaDh4dU9a?=
 =?utf-8?B?a1BhbVcySjZkaS8vMC9iSHJra1BwdjdSNjlSOFQ3bU5vR2tsWnBVYjlLYndM?=
 =?utf-8?Q?Nn8JRpudRWEhdb8zjd7Xj7tkm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a1304b-49f3-4348-9db2-08db110ddead
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 17:39:07.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzmmwuLwkE7bXPsOtu4AYOL0PM9V8IeaVWeMBUEqYSnvBqq5TchnjEBg6G/ZCMnB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/16/2023 7:46 PM, Fenghua Yu wrote:
> Hi, Babu,
>
> On 2/2/23 13:47, Babu Moger wrote:
>> When a user creates a control or monitor group, the CLOSID or RMID
>> are not visible to the user. These are architecturally defined entities.
>> There is no harm in displaying these in resctrl groups. Sometimes it
>> can help to debug the issues.
>>
>> Add CLOSID and RMID to the control/monitor groups display in resctrl
>> interface.
>>
>> $cat /sys/fs/resctrl/clos1/closid
>> 1
>> $cat /sys/fs/resctrl/mon_groups/mon1/rmid
>> 3
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   Documentation/x86/resctrl.rst          |   17 ++++++++++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 
>> ++++++++++++++++++++++++++++++++
>>   2 files changed, 61 insertions(+)
>>
>> diff --git a/Documentation/x86/resctrl.rst 
>> b/Documentation/x86/resctrl.rst
>> index 2c013c5d45fd..de332c242523 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -321,6 +321,15 @@ All groups contain the following files:
>>       Just like "cpus", only using ranges of CPUs instead of bitmasks.
>>     +"rmid":
>> +        Available only with debug option.Reading this file shows the
>> +        resource monitoring id (RMID) for monitoring the resource
>
> Capitals Resource Monitoring ID (RMID).
Sure.
>
>> +        utilization. Monitoring is performed by tagging each core(or
>> +        thread) or process via a Resource Monitoring ID (RMID). Kernel
>
> s/Resource Monitoring ID (RMID)/RMID/

Sure.

Thanks

Babu


