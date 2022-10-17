Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84692601CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJQW6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJQW6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:58:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FAE82847
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:58:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HLmwDw027010;
        Mon, 17 Oct 2022 22:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Jn2UPmvtnFXf959zNr+21eFMaHfryYkopTlA/J+5bCA=;
 b=X6xggCi4RDwJykHetEDAeKcWFhF5u4JDZRSwUmLHJ0+Ct1gtrfI/CXhSww4itdZ0wTNl
 9Npr1nSGDt5ImA9r7Zpnd/gdTVQpHjKgHcvGx7KhnX1CCVnXL+uTwtVjGiezhS6dQ3Lk
 J1bTNNE3kIVkvfrj9TBOXkgscmJuICqW6hZ2v5Fr54YYRg1EHkxjHt4Z87yu452Hzb59
 3+s+CH2ItS+qKWar/dI6aDn93Kt2QnblWBZJzp84RPvzwtAJZOTK6O5pq9zCbXCLLqrq
 VanmXGnPwOTGoDQZ59ABNcV8yd5/2GSTEXaVyZ/3QvXw0KIpxXtSINAoytbIS0ANhzdz bA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99nt97v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 22:58:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HKwGiC015918;
        Mon, 17 Oct 2022 22:58:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr9j9b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 22:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6cv5lhJcoIFR71cdwNvmHqhA3yZ83irRGI7ApIiySDMW1I3J8IEwfGnWcMpH5GJUB39m++tpi+o3BX3Lf8oah8eypsh9MdIhkMW14JJ07B3jZtomu1tvGYlWccc/ElatjbBT2SWup9ZZzOJN0xXeJ9bb07VrPFOOd6mzaPSLCd2Q6SyIps1ZEHFkgtYu7qrhEfH/P9pzLJGv/9+JIfcJLCEEJPdCpbMC6w91XIKsSzkkoYWtOeyzd8gHa/eJwVymmGQhh9/S31kejXYnbXEkQPsJZbWeMcj0EJ5VLga4t9NnvEqFZpu0zvIDtHa+Is0QDUb/iS8554VUtVv6p2aFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn2UPmvtnFXf959zNr+21eFMaHfryYkopTlA/J+5bCA=;
 b=SclhhUX0Rk+ipqPGQZ+TR8LNBjIoEF8Btg8To1kONQDCDP7VjqLdVE1E9pkj88evT/pAZs1s9ScDkaTpCXJZL3yfDID0O22lyJNI4OltqYSqcRr/3b2/B9U3/p3kWWFuYteRPQvt+zHbMg7eK3BSvk5XIOFT4yBtB/SxVEGFSeRpWdNXDYlEPZBPubPjcUC6wDVYES2o0RuFZjBd2gD7Qbg7WxzIHwIAbRn348LFFGjemIj+f5vEKWppFn1z64xCdOuXssBwh75zZP108ZHUDPrpbAw+jPsOSJQYIb4BrGP/DZdqoxQxiUwccW7xbw4/NFULmMP0v7YgZSOaJHHPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn2UPmvtnFXf959zNr+21eFMaHfryYkopTlA/J+5bCA=;
 b=RxBar0Sq6cjVUCN+JIB+NsnrCGm1WAA+sBoQ1FJOgec0OW83BCdKcHD7MSwFneL9VP8DTLs6fdVyXZtluVSsoTvy/F/jk1uL3PQpvM8YTLYpKSZ26FXdCXyD8PVVjYai0Bt6jzrSFjqHip2L12lowIA7LMJhDo2CQfmuZzTHHZg=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH2PR10MB4277.namprd10.prod.outlook.com (2603:10b6:610:7b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 22:58:14 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 22:58:14 +0000
Message-ID: <4f76d968-3086-0280-48fc-fcf250f11c67@oracle.com>
Date:   Mon, 17 Oct 2022 15:58:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 0/4] vDPA: dev config export via "vdpa dev show" command
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Sean Mooney <smooney@redhat.com>,
        Daniel Berrange <berrange@redhat.com>
References: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH2PR10MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 22092aff-c65e-4fd9-c5fc-08dab0931244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5Z/mLd7dCGnEeJPzOeH9raZdsijHAW9TKv8qv62Cdq59nYw8jlPlSS42ZigT4vVKSjSsmyWcUd5MzZJFeEj3Ov/GjQcKhEibofs233SKTD/eumlTG1Qxt7qt3TfsFaGVaBKg4Deo++kD3puaLE4N30q1Qktgp3upqeWQeU6JWDlpMgcPnC2cAv9Ai10vTHfFjQ8FKLL7PgcSosIUr8pF/aOzgK4KO2NNdnLp0PyBIRX26ZLNJyvvrdUDPlwLet4cOZXuUpzNtwi8++QA33bz4Qj01Zxn0c7YwbSde+wkY7+YTNXG6VjKbSZDO6OZOiZryCSTdxoomAzyS0uaBoRnjEsYLjtOWfQRYqv0KEjXuqYH8tbF5wQ35icD9atI62s7CFFB6H3RB0WDWgn+E9ZFdKhMEEhguQc4MP3DzE/+gTBEN1uJ0Hiwf9Mr631I6R5mGKC0j96Y+ZPodbKLe9KQkXIyQka+zSp63D+nY3if3UiY3mvpffAc3ZMrDzfkIhbx1k5p3wAKa63RAikXcYRXmKxmlHO4518jVUAlwgRFag6MJOKxjE4qGA93DPG8al4gT/AaWim+A+KywAftT970dufx5838Lbl0PRbKLOBKlG+EZfeDj9udtAKiSUyK0oTcJ3o4w+0/2bk8V1R8zg0b66Wd5MK99gQNsib6rc4sTaSrweinSn8iMTm2GZnoTK3Jg3s2OYwf15VC5wP0UY3wl7AyrBkovky3SYf0zfQI4tTUA1c2QzHC436VH0uF5yf3GrJp7SkQsW05Lk3QhB3s9qS8D4DUlM2g81IG4k1JbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(2906002)(31686004)(5660300002)(66556008)(4326008)(6916009)(54906003)(8676002)(316002)(36756003)(66946007)(478600001)(6666004)(6506007)(8936002)(41300700001)(6486002)(6512007)(53546011)(83380400001)(26005)(66476007)(38100700002)(36916002)(31696002)(186003)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDBLSXVOZGJLY1g5aHdSb0dqQ2NiTDgrK0U1Z2FMSTNycTdEaTFNbTVPSjBC?=
 =?utf-8?B?N3JCRFRNcC9BdDJkUG1KM21UbS9xck00WFYyY1dpMXFDQUN1VFhLVHNhaVEx?=
 =?utf-8?B?K1UzUlkwTXFlbklKSC8zRHJBQ3J5Z29zM3pkTjVXVFVPZ2tpSE9KMzZobDQv?=
 =?utf-8?B?NTlRQXhqMlppcjJ5WVFaSHRwWEkxV1RQdjR0eFFNY0NUQ3Jxa2xjWi92aG9Y?=
 =?utf-8?B?VWh5RFhTamdOVHM0Q3NVNXNjTXNKemFqREZ4dFpuYllNNXB2ODZsM0xDYTBG?=
 =?utf-8?B?NHJBR0xzVndQOVBEUW9Xam96SHhnT2p2Uk0xaGQ1bHZqS3MrMk9PL3QvOGc5?=
 =?utf-8?B?bjJ4aHR1N1IySXRFNWxRbjNpT0U3MGhYZlNmN0FiTld4Z010OHRIQW1QaHpq?=
 =?utf-8?B?a2srT0syUmJSbGhmVUI0ZWlQcSs4K2FiTGdGZEV3MWRpWkN6a1o3M1FUTmNw?=
 =?utf-8?B?MGVocmhOMjh6WVJEckZNWTVSaDNMRGJ6MzBlZm9tT2pSU0xlNEVTOCtMS1dl?=
 =?utf-8?B?dFpuankrOFpiZzNoemR0UWV2WU9zcEpwZmZ6SUlYUEpsZmxNRzgvcTZ5dmlq?=
 =?utf-8?B?eGVvRk9rNk9Jc3F4RzMzNHBvTHZlbC9QUElrblY0cHN6bHdwNGllb3Z3VE1N?=
 =?utf-8?B?NjIwMm14aTBMWENyNFBJSHRKRjZXUTd3QmZFUEIycFJnMDBOM0VmZjBMZ1R6?=
 =?utf-8?B?L0RaZTJEcU9oK3NWMmNob0t2UUxRU1dXQVhpTEVSV2dreTlBQTNqV2xjaE1K?=
 =?utf-8?B?cHFMejdqUGxOZDRnZzVMTTIxdTBVVHpVaDFaZnMxemNtWW1mUTBGNmdqNzZp?=
 =?utf-8?B?dExOTzgvOWVMbWJjYVpkUU04T3ZzRFpCWnBCSVErR0E1YTNKaTNramhZS2Ix?=
 =?utf-8?B?UEZwY3J5NDFhSVFmNVdkcnFUSG93QjJYbzhnN3ZIUWZKOGZFaEVEbHBybTdY?=
 =?utf-8?B?SW14Y05hOWZhMDE2K2NTMVM2OENYL3FVcVdRTWs0UmRwSUVOd1NlOFZ5TUdB?=
 =?utf-8?B?a3ZUSDUxYWVES2paMVVCbkFyaGdURWlwQXFuOUdMTGJ1MkRDcHdkbU1mVk16?=
 =?utf-8?B?WWpLbENtdHNmMkRZQm13NVRqRWJHSnJ6MldodU1PUEhmblJVSE8ySXZISU1X?=
 =?utf-8?B?ckwzSlJwOWprU0Y4a0VncnZxZXVjdEtJck9nVHk0MTh6SE9lNE9UcVpqbUZJ?=
 =?utf-8?B?YnVnWENSWTNrSVN1cWxZRmJhdFcvNGw2SlBLVmExRmNSa3liRnlCTG9wQk1r?=
 =?utf-8?B?LzBrMnJWR2ozSnQxRmI4ZlRyNnN3ckExVjAvN203cHQzZDkzS2pjbXZKY0ly?=
 =?utf-8?B?dGxUNmk5KzVSTEpXTmpqTFVmbnlhemZrRWoveTZxdVZFMStOdkF1eTltRWdz?=
 =?utf-8?B?T2NZTHVoVkFnSGdyNUpmVkNPekkxc2Flb09vN2VZS0ZSclBGQTBoVTBOQWpC?=
 =?utf-8?B?MTdIcmZiSW5VNHZtditMYkNXMGl3T09CZ2ZFQzNpSVJMcEZMdlJzQXZmMFU2?=
 =?utf-8?B?QUtUQlIwMXFka0NzMjJoYUhOUnNpdDh1cHcvSVJGV2REek9rd1RjdlhXd1Ar?=
 =?utf-8?B?Y0hWWnNaWW9nOGFtRXhjbmQxRDh3aUVRUXFIYXI5aGpRMnJQSEFjeWVWUHM1?=
 =?utf-8?B?MU5QcVptbDdIZGtEVSt6K21GYUhqUmZIWUNnTGtSK05vRmZSK0QvcC9Wb3F4?=
 =?utf-8?B?WlcwdDBXK2FNSTU1ZElRZFU0aWcvVjBha3NuZzlUUWNUYk1JNW5vVFUzRHJF?=
 =?utf-8?B?bmhwZGxUUDBxOVNyMGV1eDAxcGZ3V2xLdTgrM01Pd2kzNlRFREJPdzloUmJa?=
 =?utf-8?B?KzNQQ0ZRV1pkTEVuTk5BZTJVSDQ5V2UxTjRhSlprY2c3akcyM1lXQWJiWVlm?=
 =?utf-8?B?UE5qWFR4NlR4U0svSzUrcGxRVDZhcjF5cE4xZVVoN3E2OVpwb0JIOE1lTENR?=
 =?utf-8?B?R1pNLzZ4VEdYbzlXYURXVk9ZcHo0Z1p2VlhmQWx5enVyQlJodWVOQ0tDTTNI?=
 =?utf-8?B?anJuZ3hTZWN2d3dzb1NxOWp3elBpMHFLZ0l5enZPYXo2V0l2NFh1QjNOMzRP?=
 =?utf-8?B?bCtaMzdHWW5LNE1ZbHJwZ3FhTmZ0SEN0dUVRRG1jRXgzNmlVMmphY3lMVzFs?=
 =?utf-8?Q?B+5gACkctDPekSqueQb/caxYw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22092aff-c65e-4fd9-c5fc-08dab0931244
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:58:14.1399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yR4P0MMe5JUuZeW9PuCCQLGRSB1hCpJGH1NMGcrgc2nbt2CWggk/c1eyab1JNKmVkEdyMoQvExiSlivm00ISJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170132
X-Proofpoint-ORIG-GUID: V0YBgQnB_5svXJLvAyFo07ZvfZt25--f
X-Proofpoint-GUID: V0YBgQnB_5svXJLvAyFo07ZvfZt25--f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2022 12:08 AM, Jason Wang wrote:
> Adding Sean and Daniel for more thoughts.
>
> On Sat, Oct 15, 2022 at 9:33 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Live migration of vdpa would typically require re-instate vdpa
>> device with an idential set of configs on the destination node,
>> same way as how source node created the device in the first place.
>>
>> In order to allow live migration orchestration software to export the
>> initial set of vdpa attributes with which the device was created, it
>> will be useful if the vdpa tool can report the config on demand with
>> simple query.
> For live migration, I think the management layer should have this
> knowledge and they can communicate directly without bothering the vdpa
> tool on the source. If I was not wrong this is the way libvirt is
> doing now.
I think this series doesn't conflict with what libvirt is doing now. For 
example it can still remember the supported features for the parent 
mgmtdev, and mtu and mac properties for vdpa creation, and use them to 
replicate vdpa device on  destination node. The extra benefit is - the 
management software (for live migration) doesn't need to care those 
mgmtdev specifics - such as what features the parent mgmtdev supports, 
whether some features are mandatory, and what are the default values for 
those, whether there's enough system or hardware resource available to 
create vdpa with requested features et al. This kind of process can be 
simplified by just getting a vdpa created with the exact same features 
and configus exposed via the 'vdpa dev show' command. Essentially this 
export facility just provides the layer of abstraction needed for virtio 
related device configuration and for the very core need of vdpa live 
migration. For e.g. what're exported can even be useful to facilitate 
live migration from vdpa to software virtio. Basically, it doesn't 
prevent libvirt from implementing another layer on top to manage vdpa 
between mgmtdev devices and vdpa creation, and on the other hand, would 
benefit light-weighted mgmt software implementation with device 
management and live migration orchestration decoupled in the upper level.

>> This will ease the orchestration software implementation
>> so that it doesn't have to keep track of vdpa config change, or have
>> to persist vdpa attributes across failure and recovery, in fear of
>> being killed due to accidental software error.
>>
>> In this series, the initial device config for vdpa creation will be
>> exported via the "vdpa dev show" command.
>> This is unlike the "vdpa
>> dev config show" command that usually goes with the live value in
>> the device config space, which is not reliable subject to the dynamics
>> of feature negotiation and possible change in device config space.
>>
>> Examples:
>>
>> 1) Create vDPA by default without any config attribute
>>
>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
>> $ vdpa dev show vdpa0
>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>> $ vdpa dev -jp show vdpa0
>> {
>>      "dev": {
>>          "vdpa0": {
>>              "type": "network",
>>              "mgmtdev": "pci/0000:41:04.2",
>>              "vendor_id": 5555,
>>              "max_vqs": 9,
>>              "max_vq_size": 256,
>>          }
>>      }
>> }
>>
>> 2) Create vDPA with config attribute(s) specified
>>
>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
>>      mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>> $ vdpa dev show
>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>>    mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>> $ vdpa dev -jp show
>> {
>>      "dev": {
>>          "vdpa0": {
>>              "type": "network",
>>              "mgmtdev": "pci/0000:41:04.2",
> So "mgmtdev" looks not necessary for live migration.
Right, so once the resulting device_features is exposed to the 'vdpa dev 
show' output, the mgmt software could infer the set of config options to 
recreate vdpa with, and filter out those unwanted attributes (or pick 
what it really wants).

-Siwei

>
> Thanks
>
>>              "vendor_id": 5555,
>>              "max_vqs": 9,
>>              "max_vq_size": 256,
>>              "mac": "e4:11:c6:d3:45:f0",
>>              "max_vq_pairs": 4
>>          }
>>      }
>> }
>>
>> ---
>>
>> Si-Wei Liu (4):
>>    vdpa: save vdpa_dev_set_config in struct vdpa_device
>>    vdpa: pass initial config to _vdpa_register_device()
>>    vdpa: show dev config as-is in "vdpa dev show" output
>>    vdpa: fix improper error message when adding vdpa dev
>>
>>   drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
>>   drivers/vdpa/vdpa.c                  | 63 +++++++++++++++++++++++++++++++++---
>>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
>>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
>>   drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
>>   drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 +-
>>   include/linux/vdpa.h                 | 26 ++++++++-------
>>   8 files changed, 80 insertions(+), 22 deletions(-)
>>
>> --
>> 1.8.3.1
>>

