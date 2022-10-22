Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574186082DE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJVAbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJVAbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:31:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0342B4E98
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:31:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LLDq8p005623;
        Sat, 22 Oct 2022 00:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ieNfhkBw0kOyN3x8+qyyQNSq0cmH0q8j0Nw8aUukvwI=;
 b=x8Rv23wMG3FYudZ7C2nNdOiC+XjKhzNoWGusmWTtFIgSZ1X5mifsU4HjiMMkrspHKY5m
 ZqFdiv6qm3mnI2CVSnlx8ZpiZgI+CZJgSGhEyuYnTfNNn3SyEUqQWUExZv49LUMOKyDy
 iSODc4FeU3LnpAp1SdWHAOUZDU+QYmXL/9/k8rlHpzOs+4DcLzpe/V/Xda9Nl1pkHTYN
 0zNNJujF87G4hxnOUAzYNUuXu/8s9wjsD9bWQB+XNF7Uj0sUudq9aNBJDjW+HdAbXd8q
 4bLOq7M9HjhPSIzy3mOnB+QZpIA6EdqToS0SycGt6T3LeXkkF0HHblTnrsA14mB+g4UN MQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtudd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 00:31:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29LLZsTH007322;
        Sat, 22 Oct 2022 00:31:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hre9um2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 00:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SY1foiSw/8tfNeXD20naRO7utUj5XuDuxv3LOK7xUDBjxQiT9oKDYgG2lcH/U9NVpEHQVehVmHLM1IM7uoKehxT4vAB7HxyCnIRjIWoRo0Q8yIBpnCrBpNMRQ+Qd/kZsNC7oke2ZD94VUN/Y5bGgEGCzR+k8CmlQbqat+Z7RRwED490q1Ykv4SMqAt7S+2cbypimJdyPAWDJTGxUPxcoAPD3DCJKnEkhapZdfPiQVdeg2KrsY9wazYU94bdPIRs+lid3qfPUamjc2CoZ4+Jmpvh+7cK1elxlLxoSx9iI1oD0u/Du03ulM/mocRagmNDhBUaTGr8Tc48k2/dbiZd8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieNfhkBw0kOyN3x8+qyyQNSq0cmH0q8j0Nw8aUukvwI=;
 b=k+QefmPgM5QF5843TRD/xgoL3G3bbJ1t7t9HJD2lVv2OpWfd2L0ZOVPCUNtQ04BX7gymchJm432yfv14SktNu02JuLlZwcuAUjjUrVNmrx/y8NpZ/SWVuxHBFN9GRjzYX/sLUeJZtIjj4JURFmBcFIeY2nOZMG7wEkMsHdX6Q8hVkeLefOWdNiXFzkTwlWbeVYrotDDtKpfeQzI0I815V4QkNm2yK85wbA5SjnsmGTAfo7YyMLMokVnUlCdgzNI37hhEXUK73+ig7FBWAAJ3Xb5CmP8rhctzhUFpqLzvtnIqvd6Ij3cA6pnq1XQIgWueii1DdFMZN5a0qJi6ViD1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieNfhkBw0kOyN3x8+qyyQNSq0cmH0q8j0Nw8aUukvwI=;
 b=Yr8RMvBZ5ew0aGtKyf1lRxbISiWzDVK/QGVwLZCXhOzycoPda3KRm2Ol4ICbuC6xmmNh95c3IXw98cS8YTgo+fxZCCC7xBBUCa17i+pkGgmJlj5uNBXv+jf6nBjvuyH+cOvpZlECsxMjmWQ4ESlo5BFK6sPgAVa0bTIOLjYx7CM=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sat, 22 Oct
 2022 00:31:28 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Sat, 22 Oct 2022
 00:31:28 +0000
Message-ID: <e96aaf49-96cf-2722-7c16-ec9eccdaed14@oracle.com>
Date:   Fri, 21 Oct 2022 17:31:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 2/4] vdpa: pass initial config to
 _vdpa_register_device()
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
 <1666137032-28192-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuT7O1xLrB9=eYHAtuHYdwbNXxqtC+Mh4qkWSkLM+QTjg@mail.gmail.com>
 <68312622-0206-f456-146e-e242e36be04d@oracle.com>
 <CACGkMEtjseNBZ53x7=k79X8q3wogtksFPPC7NG2Uofj0HSEq+Q@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtjseNBZ53x7=k79X8q3wogtksFPPC7NG2Uofj0HSEq+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::28) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH0PR10MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe03f3f-6034-43f3-7ffc-08dab3c4c264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oSHmG/7FI0negx53KbpY4DwOl2qhecXRjwn2xJ4dgpyUOlNcfx33pW8TevbUzxtIYJRaDwMnW7Smes4BYp/BCi5cn94CeRSdPFM4D03JTJPxrqM5UqrGQsF30+QkVdudMKWNs7neiP8RyI1LdGnPzXG/kwpp+6SerBNCle3Cbf1J1XO3iN2gCqayuc+HClT2sBuLFf1D3riV1uy4fN1Sv8R3rM1Fm+gyRCGt/q7LL0e82aof6UD6SUbWyDxzpiPrcZamGVE08goPkj/24XV8bWY7e6KmTg97V+TQsKs3ExlZmkFtI62WdYjHMjy4MQL6ztK/E7UN8p81L2j+ElgheTE/DM+zCsC0GO/m8V5Zsz7MiA96Uh2IbfGj5t5qIpyGnx/CMCPUP1u9s4jBh8kFxR8dS+dcHNEZg0cPVtwyNKi3zBOSNOBzEj6LCxY4ZmLqdNCFOl+QksP1iRRkP0gEoQ0UhFEWezZZp4KxRW9uyCKmCWciK6DMihbELjGEJhOGTCDhwDRbHejh6chC+tlTOCYQ1O1iTZt8INyclA7KBi5/ceXlm200TRdTb38YjQC8yqPDMpouDFy6Pj2cXn3kf6umKnENbZVvQItjQ+4y+VMNULb+DjmZNr7AgGKr4btdjAYgNfCfZCPF3IbcGWR6vE/eZ6Trfrblpwcip+0zEmkLbEJ/yHYthEkNR6o3CC1TIJtUEMZWcQ/mQujcRXXVTgpEX47jEyMhPJK5LaP9JJ/0s7AU1lMvMNRW3lTZ04HsW2BGYp+/+P5kac3kRqH6OHx4c8g9gqHXStqn3QJW+Tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(31686004)(36756003)(478600001)(38100700002)(66556008)(41300700001)(6486002)(86362001)(83380400001)(66476007)(8936002)(31696002)(2616005)(186003)(53546011)(36916002)(2906002)(6666004)(6506007)(5660300002)(4326008)(8676002)(6512007)(66946007)(316002)(26005)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjI4UVJ2a2pMZC9ZRDhxaEhtc1ljRHg3SVhIQXBUaWxOb1kvVkdFdjRtV09V?=
 =?utf-8?B?bHJyNUQ0OVYyL25aZ3N0QnpCblZlQkhUbk5hUjlCVmwvUjhJZS9MR0Z2Sk1M?=
 =?utf-8?B?eDZMT0VRKzQzeUVOS3Nray9CS2xLbDM3T1E1L1pLUGJmZmhxeEJmWWZmZnpS?=
 =?utf-8?B?b04yT1h4TlBnWjJ5VjlsM1JZemw2MmI5Y09mNFoySllESHZENjlnKy9meXdN?=
 =?utf-8?B?T1BicEpzTytlNWF5SUZveXdhQmxabkg1dmZkYWozR05kTjcvbmZ5b0I1YkU4?=
 =?utf-8?B?Z3FYdGZBbHNYY1dZQ3BTb3dKZjV0T1B1d094TnNqVmVlY2lkMnNvMFFqcFJH?=
 =?utf-8?B?M25pcTFSRi9RWXIzNGFXU2JVcHNFV08vSHN0MFpqVWtpcHRlczhFUWRCai9q?=
 =?utf-8?B?SGhRMW05VmVmOFh4OWZ2SVpJSDZyTTVoQlFLUGRGQ2IwVHhPL0VUWnJFNEls?=
 =?utf-8?B?elZFeURpTWFKN1V1aUJWeEYwZVdCNGxsRk1oYUxBU0NGeHdFR3VGOVdXQ1Bu?=
 =?utf-8?B?aHVVRHEzUmcxRjBKcHhMVXRtM3U5RlJQREZnT2dLQTgzcVdmNWdHUTNqb2dm?=
 =?utf-8?B?a3Z5TWRhZHc4ZEppQit5blZya1VHaklrTWVHbXV5YUtXVXQ5Zjh5ZkFkQWpF?=
 =?utf-8?B?SlNQc3U5d01nY2M1SUxvQVVzVlBHNjBaVWRhOXg5bFVTM2tTTjF0cUVwWTA5?=
 =?utf-8?B?TTFZeHNxSDNiYWl3T0p2ZmRrVmplM1QxOEVPbnBFZmR2WUUzZTA2SGloN2dr?=
 =?utf-8?B?MldkREYzVDdJTGN6YWVPTmp0WFg0RWxjQTR2QTJnREVYU2pwTUVXbEtETncx?=
 =?utf-8?B?K1BMQWFJSFRSc2lGT3BJTDhlV243VlR6aXo0dWhKOURYbzNCOVE5K2NlUHFn?=
 =?utf-8?B?TXJ4MytzS1lMWHhtMTBzMzVyc2ZuSmFMTk50bjkvb1JqRk5VZGI4cU1DaS95?=
 =?utf-8?B?TW83c2tnMFhwcDFibkltZkhySHZOanB0SFRqY0pPV2pEczNFUUNkc0VmbkFt?=
 =?utf-8?B?N2Rpai95R0pRMzdIcGIrSm0zUmt0MUY5cnNIeEMrMXJpaHA2RGVuRHhRTGt1?=
 =?utf-8?B?WHhHNTMyYkIwL05ZY1J3VGxxUWlaQkZrOWl5VzZ5QnpFQXNFS0E4S1htOXlB?=
 =?utf-8?B?WlBWbWhrb3ZoMWlLakNYN3pYb3JWTzZXTlpueWN4eU5qRXd1RnlHWmdxcDJk?=
 =?utf-8?B?L0tReElPUGZaQnNyR1hQUzhNeDlweWFaSk1CY25aMTRLUUxCUkNtUStBMnZI?=
 =?utf-8?B?dFlvOGhNeElzSzh4dU9zY3M1c1hwR0FsTmZJN3RhWUROdjZpcHEvY252K1hi?=
 =?utf-8?B?dksrY1NZdGFrd2NNSTg5VTJXMlpiV2lDbDdHTko0UHZuTFRLNzNJOXpQcExt?=
 =?utf-8?B?QUFuUjloY1NzU0V5WTNKSnh1Y2NSOC9scDFzVlhVTEsrUEVzYjFtTVR6eWZN?=
 =?utf-8?B?S00wNHhSNzB6Rnh3MHlDVWNlWkVFZCtTaW5DZ1FsR01yZDJCU0F2NWNaRTV4?=
 =?utf-8?B?U2xBVm1VYW8xWG1za2VIdHNHTGR3QWlEUjhicXJTNm1YZnVBL0hPZytCZS9y?=
 =?utf-8?B?MjI0NlVzaWxScG1nZE5mcmlzNVBlbGpnMzFjbk9ScjR6S3VJM3RTUXdnUjds?=
 =?utf-8?B?bXM4WjVYWXpIb0JQWmJWbjk4MktSVGJXS3ptT04zUTdHMXU1aTRlZDlBbkIy?=
 =?utf-8?B?bFhsbkROMENrWVY1SEx0OFJ5U28zSzU2S3czM0ZtajE1aDlaWCsrbkl3UTll?=
 =?utf-8?B?WVZuOWprclRNc0M0Y0dhdUhhUWlrWkFobkkzL0hIUGdqdzd4WUV6OGdPTnc5?=
 =?utf-8?B?QTFrQmc1dHNsMVVQb1RxZndvelJEenJ0Wm5rUExVZnhUbVRLN2JrTmFTRmtM?=
 =?utf-8?B?VTBOdElTQWdSdFp4TlowTWs3NFJhMGNIeHFlZ1drdnlOTlZLZ0lWWFZyK1BK?=
 =?utf-8?B?RzBzdktLN3I1WGNSU0FSdDI2ZFVWYU9DR2t0WVpORTFQRzRMcFJxVXZHRldU?=
 =?utf-8?B?TDBWOGtJSDZMOUtSNjFlOHAxOVoxaFZPazkzVWtuVHNITUdLSGRLa01haldp?=
 =?utf-8?B?aGY3RFVDOXIvS2ZrZW9QczVhcGNxckJjUTBJWHpSd05pWm1IbnMrS1FhaWxn?=
 =?utf-8?Q?SqhDA24e2B/bBlQasgkaddkzC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe03f3f-6034-43f3-7ffc-08dab3c4c264
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 00:31:28.3916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EGsf9xhmkoE2S0k8HKv3FSSaKhcK6juSM+xZmvhNzgiyTIOy2rk+G3l11YJR6XYbJJW5R9DlwrHIT/0HYYSbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210220001
X-Proofpoint-ORIG-GUID: tIKSEdtVZXo8hKZIbsSCGmBOVEPyPyfs
X-Proofpoint-GUID: tIKSEdtVZXo8hKZIbsSCGmBOVEPyPyfs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2022 7:51 PM, Jason Wang wrote:
> On Fri, Oct 21, 2022 at 2:45 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 10/19/2022 10:20 PM, Jason Wang wrote:
>>> On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>> Just as _vdpa_register_device taking @nvqs as the number of queues
>>> I wonder if it's better to embed nvqs in the config structure.
>> Hmmm, the config structure is mostly for containing the configurables
>> specified in the 'vdpa dev add' command, while each field is
>> conditionally set and guarded by a corresponding mask bit. If @nvqs
>> needs to be folded into a structure, I feel it might be better to use
>> another struct for holding the informational fields (i.e. those are
>> read-only and always exist). But doing this would make @nvqs a weird
>> solo member in that struct with no extra benefit, and all the other
>> informational fields shown in the 'vdpa dev show' command would be
>> gotten from the device through config_ops directly. Maybe do this until
>> another read-only field comes around?
> That's fine.
>
>>>> to feed userspace inquery via vdpa_dev_fill(), we can follow the
>>>> same to stash config attributes in struct vdpa_device at the time
>>>> of vdpa registration.
>>>>
>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>> ---
>>>>    drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
>>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
>>>>    drivers/vdpa/vdpa.c                  | 15 +++++++++++----
>>>>    drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
>>>>    drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
>>>>    drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
>>>>    drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 ++-
>>>>    include/linux/vdpa.h                 |  3 ++-
>>>>    8 files changed, 20 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>>>> index f9c0044..c54ab2c 100644
>>>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>>>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>>>> @@ -771,7 +771,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>>>           else
>>>>                   ret = dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->index);
>>>>
>>>> -       ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring);
>>>> +       ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring, config);
>>>>           if (ret) {
>>>>                   put_device(&adapter->vdpa.dev);
>>>>                   IFCVF_ERR(pdev, "Failed to register to vDPA bus");
>>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> index 9091336..376082e 100644
>>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> @@ -3206,7 +3206,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>>>           mlx5_notifier_register(mdev, &ndev->nb);
>>>>           ndev->nb_registered = true;
>>>>           mvdev->vdev.mdev = &mgtdev->mgtdev;
>>>> -       err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
>>>> +       err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1, add_config);
>>>>           if (err)
>>>>                   goto err_reg;
>>>>
>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>> index febdc99..566c1c6 100644
>>>> --- a/drivers/vdpa/vdpa.c
>>>> +++ b/drivers/vdpa/vdpa.c
>>>> @@ -215,11 +215,16 @@ static int vdpa_name_match(struct device *dev, const void *data)
>>>>           return (strcmp(dev_name(&vdev->dev), data) == 0);
>>>>    }
>>>>
>>>> -static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
>>>> +static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs,
>>>> +                                 const struct vdpa_dev_set_config *cfg)
>>>>    {
>>>>           struct device *dev;
>>>>
>>>>           vdev->nvqs = nvqs;
>>>> +       if (cfg)
>>>> +               vdev->vdev_cfg = *cfg;
>>>> +       else
>>>> +               vdev->vdev_cfg.mask = 0ULL;
>>> I think it would be nice if we can convert eni to use netlink then we
>>> don't need any workaround like this.
>> Yes, Alibaba ENI is the only consumer of the old vdpa_register_device()
>> API without being ported to the netlink API. Not sure what is needed but
>> it seems another work to make netlink API committed to support a legacy
>> compatible model?
> It's only about the provisioning (which is kind of out of the spec).
> So if I was not wrong, it should be something similar like the work
> that Cindy has done, (per VF mgmtdev):
>
> commit ffbda8e9df10d1784d5427ec199e7d8308e3763f
> Author: Cindy Lu <lulu@redhat.com>
> Date:   Fri Apr 29 17:10:30 2022 +0800
>
>      vdpa/vp_vdpa : add vdpa tool support in vp_vdpa
OK, I was thinking of something else for e.g. support legacy driver 
changing the default MAC with VIRTIO_NET_F_MAC provisioned. Then it 
looks Alibaba eni_vdpa can only be provisioned without any config 
attribute specified, thus unable to enjoy the other benefit from the 
netlink API. Since it's kind of out of scope of my work, I'd like to 
have the author of this driver (cc'ed) to make decision for it.

-Siwei
>
> Thanks
>
>> -Siwei
>>
>>> Thanks
>>>

