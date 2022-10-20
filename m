Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8042B606800
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJTSMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJTSMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:12:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AE84E609
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:12:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KHxn8Y001181;
        Thu, 20 Oct 2022 18:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ItwcE0GcAfVlalbHUOFapyiTPgVxtYuPo08DHa4C1Ew=;
 b=SH0uA7mQUh4VF4n/rCp/TR/swbGlADNLjwdJ+8PxniSusc3TiEtDR10ks62ajfK/cvHi
 isoh4EwMS+J6rrPQeb5YNaPsk5PBOI4zj40xHV+8dG1m0d5Or7CGdHusZQCkr9aiWROE
 UEgvY/4wYzngLtVGqwzhwgbPJPJRDxR+D/9kaws3S/3yrT8Hb4p6Xr/yyYcRHr+XpclD
 mUu6oqpjjcJiTSec5n7Fqooy+j4sShID2XXocjqwIwCw44ba54NfsXKwlJt2mhUDae0D
 PhMxJKP/U6vKgdtMxIBNC8QKxPHDY4N9cAaE5QpzQbnk8W6KQo7d0hnxuAcNNVlv19aG eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntjagj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 18:12:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFWu6D038639;
        Thu, 20 Oct 2022 18:12:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr2gd4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 18:12:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws8eBbpbAjY8Q4rKFB7Ic8avkJVEj7AVSsk8xZfyxj5mZM4nAlIguZ6mhDlH5Tn7iu78M3oBRsrlIYqjsn4oIvWu+IwnZTXsf7IUy/NwEznrwSQ+HWov2NMRaZ4u+UsmHuov8CEGz6QOsX3lf38PZeKAXqGMTHsqogw1uF5EUuiI/HLjyLxSa8iQ9VyL8pKjFGGrhXUFh6uQD3glrTJGkhaev8OYEhtduQIXCEIU5Q9CwUwYzvqYe2gcVTVAmmFNryRJalMMHW9H4v1MYoKpehbmlzV4+1UYDzMFkep5X7mCEDzhKAc8rGQomYByucQf+qs9NVFe0ygum84S7/TEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItwcE0GcAfVlalbHUOFapyiTPgVxtYuPo08DHa4C1Ew=;
 b=RKWVgbZR5OB8a/8CNXGsPtUotVyxd8pWiErOwtQ8Fh93pdCrq/HcbBoxN94NKi7zVZYTrY4nktRRnE11qqV+cyVETcwKoUxjuEVhgEpJP3m+FthoAztmsN99YSgUvhNV4QvEmtAA0TZ15cs5phKGucpGdb4ViNfamA7EFSiL1Nax33Bm9azo3JOOkM5d4S42fXnxtxVrTb28yajxS3wHK544kDciZutM3992bESHhUW0rTokUnLoGxjv4M7gTXH9M1cOQnaU8M5q6mq8hslCRWIuaKKyvhUim0O4FUy3SH/XuBLj1LTGoEVsFVJhnxl0892V6eQqlZteYi22+s+pjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItwcE0GcAfVlalbHUOFapyiTPgVxtYuPo08DHa4C1Ew=;
 b=OPwZ5fznLoXUnpH5lvDPUS7XBc4NZVoJyyVr6RNNKd1Mqz/MgPEoPQldyq7PMjSphQU2gh8IwkxfIQfyr+BdT+FUcmnYvALogcDFusMSspPkPY3QNItpkol1Du6drs3rNlW9qVfVGLObf/+60UlsQNikxI3SEkJn64lIfIP97N8=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SA2PR10MB4778.namprd10.prod.outlook.com (2603:10b6:806:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Thu, 20 Oct
 2022 18:12:31 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 18:12:30 +0000
Message-ID: <86529a16-6358-ad9e-7ae3-ea1580db015c@oracle.com>
Date:   Thu, 20 Oct 2022 11:12:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
 <1666137032-28192-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuDn+Y8OEw6uK+FC0oOOd6+kj0EXS4Fm-+54GjrqY3_Gw@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuDn+Y8OEw6uK+FC0oOOd6+kj0EXS4Fm-+54GjrqY3_Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0011.namprd21.prod.outlook.com
 (2603:10b6:805:106::21) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SA2PR10MB4778:EE_
X-MS-Office365-Filtering-Correlation-Id: b0627be8-f4f0-4d92-10c2-08dab2c6a751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xb/PLKHnpeYTVOo+oIqY+N+hzbN8Lj2AVxRSuvx0SoKtOaNPJ7XIpgTxdfy3JcBHJzAuEBcdBpE7Cs0S5asjsPVyHFW5oy2XxolApKm59TAMX7jGrGI3AmGxD6eThL+QTRJKrAw33DQM7eaTCRJEdjR7Ki0T3cOcVnNdHUJcuAKooWW1kTZQXxQNf0n1obWMguvMsFGbWINxSLCtGqPUaNpBTrhtJ5WYAODt98dFLJT+BHhG/kp14kn8UsAv2qtl2uqiNq/PTVmCCf+IaWXnLU44VZBw6CkwY5tWZT5BqjkJ4slfq5L08fusO1eDekWGpYZVXwFKf4ewTZzJLY4yAtlbX/TOozur9PB3FYYix9rJ5J53lrBEUWE5qsDbZpfeHBMKfdRuECy7Yud7skXvOTZi/Gka4WYqWa+i9SGhnrwTJsAfLK0mVkSDeWyLwh+jj+QhBZX7DWfZMRDhIw/iefG0KuSYDNfizajbLc8XkEZ2ULvJqGOuvWE7llt1hzdUW/E1D2AvkJxNCw3VfvUY2dRFxrSPIMxuYdmczAqaqxlSjbwz+tsQ9Kr5Q2kSpjg2HfMM/bFD/lBYNdOvxC8pMBT19VQtOzU1cVC050pfgJp4+8Kb+/2252t1L7KZpmfedgl/s9LljwjJaEphxcz3cS78UN4oP5wP56URjGdU/HC9Rnk9MTYFs9qNsN8VYIGoSFSPagapVDOYZnGzCJ/yuzU3PiHzGArZF9pP+yZE1263C1TbM1CS8yOzzhW9jSH8HK4A405OH/0Ayja6M1T3oQKiiAhLiZA3ZPA671ZaBqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(83380400001)(36756003)(86362001)(31696002)(38100700002)(6666004)(66556008)(316002)(110136005)(31686004)(5660300002)(53546011)(2616005)(186003)(2906002)(8936002)(66476007)(6506007)(66946007)(478600001)(6512007)(36916002)(41300700001)(26005)(6486002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWNHLzFJdUxab3IySTFjWFo0TTFXOEVlOGZ0UXE5K1RFWUlDeWJieEQ2ZG9i?=
 =?utf-8?B?VnRLOEdGUzBxWkdWUHNnMTRoRGsyNEV4ZDgycURpcFRqbnlETzd5Q1BYLytM?=
 =?utf-8?B?S2RHOTVOQkc4RjRCUUdqUFhQVU5ydzBhdFBKK0dKTVRKL28xdGMyZHlqSVA5?=
 =?utf-8?B?Z1RjLzcyRlFJYXNDZzdTS29wNHJsZXpReWN1cWNzY0ZpZE9hd1NWSUlsdXo2?=
 =?utf-8?B?ZVFiUlczQjFJbkI0ejc4c1gzVDZVTEVlbkJzV2V1VFoxL2NsVGlKQ29WL1hD?=
 =?utf-8?B?V3N4N1BUcTJvbDZtTWpsdnV6emhyU0UzMDFyMTlDdmFnWlMrRDNUNThDL0x2?=
 =?utf-8?B?ZlE1U3hEUnhEWWRZcW52YlpUaThneWxaTUJkMUlORHdueFNkTEtGQzFjNmV5?=
 =?utf-8?B?VE5yWkxoMjJXWXZpdjNNU3JoMGhFRnJYWE5LZ3U2UENSL3NSOEo2NnlvVmZz?=
 =?utf-8?B?MnhIUUF3WGVSSTVGQk13UTlCOHFmWXZiSFJFK1NLVWlDVjhpWFBOVEJ3c1VK?=
 =?utf-8?B?cXNGMFVYanhUekdKamdvRE9VN3JnM2NYMktUM3BSMHFZbU1SVEZXcmt1V2kv?=
 =?utf-8?B?WE92TWFlTUtBWVBDV3NFYUZ0VVA1ZHRlOEp6VWUwWWdDWEdWQmJpeFQ5MU1q?=
 =?utf-8?B?d2UwYis4ZTVya2NCdGQ1ZmdqT2FUaWxFUU9jcjlEZGlDamZVd0o1a3FrVzJI?=
 =?utf-8?B?OXhmV3JKNHAxUHRhVFJIdFBrTkt2cFNPbmpISm0zOWwra3ZoREdXS1dIc0VU?=
 =?utf-8?B?QzZuV1QxNkYwTVAvWVdzdTdEaWc5VW03YlVoTmZNWWNWTURPM3BhdmNab1VE?=
 =?utf-8?B?Q1JMWjlPMFdQTXFtdncvT2pQMkNtWDJFcjNndklic1NOQnE4LzZ1YWhURkwr?=
 =?utf-8?B?S2xYRmV6cjFNMXNWMUdtTVUxYm05azd3SHd4enY1S1hRMnk1eDFZMytmSUNh?=
 =?utf-8?B?WElLSnYxeVR3Y05lbnRBajlqOEtKZHF0K21PeXVhUkRrQTNGQkZzenZGZDV2?=
 =?utf-8?B?WkxHd0lTRGpVN0hXMGtGejB0ajJ3ZnZsYWtsTGJnWGVlZjhBcVNETTgzWTR2?=
 =?utf-8?B?Ui9Xb2dOWkxVRGhKK1ZvcDAvQXN6ZFMyNnltNldOckdEMDA2V2hEN25PdS9U?=
 =?utf-8?B?ZnBRdUxjSlRPcmdXcG9zdGF6akNnYWNQTGNuUXlCRWJoUTVUQkJjK09jNlJE?=
 =?utf-8?B?ZnJLZlNhZGUrWXdDTjRGdzJBb1QyMGowaEw5Sml0WUtLTzE2bnc0Y1ExN2Q3?=
 =?utf-8?B?djFGOExSSFlBWGt4ZG8yMGZjcWlzbmh4YVFnTUwvUSszZjZKbHk2bTJZS09Z?=
 =?utf-8?B?d01tYWdzYTJHNVhJaW9veE5YM2h6M1RUNWlFN2JlLzEyTk9wb1pxNmRMM0Nr?=
 =?utf-8?B?V29RWGRJZXgxWEJiK2M3L0dwMjdUTUZkMWlWellQaTd2MFhTQWJIcnl4OXJt?=
 =?utf-8?B?VjB6T0RnVFpkbEdsZXBZK0pXVThZVWpnU2xyeVYzYjN1T0E4RGNEOXZ4R2pk?=
 =?utf-8?B?SVpiUEUzQ2VROXQxWU1MOGtpMFNKV1pZMFdkU045bWJWdUw4VFRBRklaTWsw?=
 =?utf-8?B?WFJ2V1pBa3Q5UUl6ZU1US3Fzak5BRHFHckxUUlRPOTF5WFcxU0dGWHF1VHAz?=
 =?utf-8?B?R1lVOUNsckNnbm84dUFtUklSQXFvNG84QzV5N0lBWXZaeHg2N29TbkJaQmty?=
 =?utf-8?B?RXNHZkc1SStFeklSM2txN1hnN3pZdDQ0QUxISy9OWDRjWS92Wk5jSjl6ckxo?=
 =?utf-8?B?ZWtLclRUMUJjRXovRlppKzBhSnRkWlRSWXd6RWMya3J0VGo1V0dqMVNGSlRK?=
 =?utf-8?B?YnlFUVVNak9STVk3WkRrOFlwamZWcHBTTTRoN0NtL3ZoTEY4WHNEM2p3RG5r?=
 =?utf-8?B?MmNQYVhCNEhOUUJqVWxtRkN5V1pCYTlJeFRONW5lV0dJSVJQUUJXWGNmck1S?=
 =?utf-8?B?akJiRlNhSFRNOFdTcndxYVVXR1VmcGVQTzRIN3JJT0lGNmdEaGRlNUU0N1Ru?=
 =?utf-8?B?MTQzTHJDZDlXUzFzSFhDRzZJTjk4OUdyUWtxRTQ2K1VsNjJXeHVVd3JML0s5?=
 =?utf-8?B?UWJjR1NBVHNzSTM3a3Njc1BMTXQ4WjRhVzJvTWpuTElTbXRFTnVWaXZheUN6?=
 =?utf-8?Q?+dUSz5SGVJQWMbrl2sbyq3tor?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0627be8-f4f0-4d92-10c2-08dab2c6a751
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 18:12:30.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44K1KDcNZtQUG4wJiCsWi3qZN7qn9/tnnwe9CsR8lDZzGfFFOH89QKtN7e1e4iqHNdfw3ScD1i5IF0bvAoe4Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_09,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200109
X-Proofpoint-ORIG-GUID: TcdPgVVCaylgsaXtOJcTRsGet5C0tygU
X-Proofpoint-GUID: TcdPgVVCaylgsaXtOJcTRsGet5C0tygU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2022 10:25 PM, Jason Wang wrote:
> On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Live migration of vdpa would typically require re-instate vdpa
>> device with an idential set of configs on the destination node,
>> same way as how source node created the device in the first
>> place. In order to save orchestration software from memorizing
>> and keeping track of vdpa config, it will be helpful if the vdpa
>> tool provides the aids for exporting the initial configs from
>> which vdpa device was created as-is. The "vdpa dev show" command
>> seems to be the right vehicle for that. It is unlike the "vdpa dev
>> config show" command output that usually goes with the live value
>> in the device config space, which is not quite reliable subject to
>> the dynamics of feature negotiation and possible change in device
>> config space.
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
>>    virtio_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>> $ vdpa dev -jp show
>> {
>>      "dev": {
>>          "vdpa0": {
>>              "type": "network",
>>              "mgmtdev": "pci/0000:41:04.2",
>>              "vendor_id": 5555,
>>              "max_vqs": 9,
>>              "max_vq_size": 256,
>>              "virtio_config": {
>>                  "mac": "e4:11:c6:d3:45:f0",
>>                  "max_vq_pairs": 4
>>              }
>>          }
>>      }
>> }
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index 566c1c6..91eca6d 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>>   }
>>
>>   static int
>> +vdpa_dev_cfgattrs_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 device_id)
>> +{
>> +       struct vdpa_dev_set_config *cfg = &vdev->vdev_cfg;
>> +       int err = -EMSGSIZE;
>> +
>> +       if (!cfg->mask)
>> +               return 0;
>> +
>> +       switch (device_id) {
>> +       case VIRTIO_ID_NET:
>> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &&
>> +                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
>> +                           sizeof(cfg->net.mac), cfg->net.mac))
>> +                       return err;
>> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) != 0 &&
>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, cfg->net.mtu))
>> +                       return err;
>> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &&
>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
>> +                               cfg->net.max_vq_pairs))
>> +                       return err;
>> +               break;
> This makes me think if we can reuse the virtio_net_config structure
> other than duplicate it slowly with a dedicated nested structure
> inside vdpa_dev_set_config then we can reuse the
> vdpa_dev_net_config_fill().
Adding Parav.

I think for now the struct vdpa_dev_set_config has just a few fields, so 
it's not very obvious. But from what I understand, the 
vdpa_dev_set_config struct is designed to be built around vdpa 
configurables, without getting it limited by what's exposed by the 
virtio device config structure, such as virtio_net_config. For instance, 
there could be possibility for vdpa user to specify the size of MAC 
unicast or multicast address table, which is not defined anywhere in the 
virtio_net_config. I think it's important to match such configuration 
(which may not even be defined in spec) for src&dst vdpa devices 
involving the live migration.

-Siwei
>
> Thanks
>
>> +       default:
>> +               break;
>> +       }
>> +
>> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
>> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
>> +                             cfg->device_features, VDPA_ATTR_PAD))
>> +               return err;
>> +
>> +       return 0;
>> +}
>> +
>> +static int
>>   vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
>>                int flags, struct netlink_ext_ack *extack)
>>   {
>> @@ -715,6 +750,10 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>>          if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
>>                  goto msg_err;
>>
>> +       err = vdpa_dev_cfgattrs_fill(vdev, msg, device_id);
>> +       if (err)
>> +               goto msg_err;
>> +
>>          genlmsg_end(msg, hdr);
>>          return 0;
>>
>> --
>> 1.8.3.1
>>

