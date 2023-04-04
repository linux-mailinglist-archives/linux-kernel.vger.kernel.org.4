Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3206D6873
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbjDDQKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjDDQKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:10:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3DE1708
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:10:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334DwxS0022729;
        Tue, 4 Apr 2023 16:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xN3VgN5ZJPoph7/SRBO7uwGMJlcH1dkL0HA0+NWWe+I=;
 b=EQ1a42l6AMfEC8O6R8wGSwUOX3GyzVBYHTY+EyDSyjyAwd/tvsPyEk9R2+sxVXbLD/cK
 5x9pZwaESgBAVpDRCzfUalWWW9WymSkMutLN659jaw5kt7Nd45com9mx142FNYai55lP
 JtCu+h4V3jizVE2TmsCMtrNIL/kWSvthhzdoglTzLtcHNG+Wesj3Rr5dwJnW/RHXSBef
 g1lVUYQVwgejlzVtIp2+wghQWmUflU6owGdY6X+BTz+J/AxHU4A2DmafguGOqhh+K4C/
 4MlxwRzoWg6zvrq27Ahczfxr4SwhoWS/sNA/5L3XN0RYhQZhKFGcHJPUh/8Zw7JE7GXu Ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7tx6wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 16:10:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334FpREp013829;
        Tue, 4 Apr 2023 16:10:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3g39s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 16:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXzfFh9i65LMV+pqKXX5RUQWf0eokawxTMM94jJ5CTe5zksP/qNntE3OjLkctnHrMG11h0msBGxzZjeiSzhYP9wsMBIwgCITDPXIHfeYojvSBtjL7vP5wsXLC9AeC49USzlzfhQJRGy2YEZrPwB2tTXVCLTikUAMv+ZgieF0DfaR78UhEH3cp983WAgd0/PRhUEWDthnj+H1PyvdvmNMR0Jv6HMBmbQmhKbQX6eV2YKYEjex3vYT+zxBOAUpsTO0l2OzbSQBBUZjzzzISvUWaZFOqp0Wo086oPQ1BH/izMIIP9cN6WM99z4BGs+jvhVxYD7nDEPD/dMVHB39KJhC/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN3VgN5ZJPoph7/SRBO7uwGMJlcH1dkL0HA0+NWWe+I=;
 b=iHotRV54YIihxXgaRteIKHqOREc49KFMNcl+BXvL3gtVmiKGXAoxZAYokMkWbWTmp4YsQrlKsFHGZKAC/H5R3m23ykb70iTSr+/L5sr5bH/xJleuGAXabeZtYFXlIf7/VypY4lUl2Bc3tFyuNgZlZYuQx88b22ufdBGxP++wyAzCxrUs85/0y6A7rC5En9BQRS65f3cNilypsrxF8caFbNiDi9ni/9UjWFV2yemmljuk8mn1qcqsDN55L7thbYJHQf4kmO0AZYEYwT3Sc4kDS30NSDv9QomcSt/j+w84ppNnj7Gi+VeHtF+aZxq8ufg2bOEuHXt6SWe/4B+nUB/CPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN3VgN5ZJPoph7/SRBO7uwGMJlcH1dkL0HA0+NWWe+I=;
 b=xRg9wtkGe3wqVC4WygUxfLuoQ0a5dopyIWbLAzUQ8oA2m5n/Y2oIoxka2h97C3jRs2Z46qa/Hp3/goBm5zQQKLmI6fduIUCMwJEIz2tZ7vGLq17wNONIMPfklNvyEqiLzz2utFMTZCuPeP6GkRYPMyBFktIx0v7E3inuE2Lbkjs=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by IA0PR10MB6772.namprd10.prod.outlook.com (2603:10b6:208:43b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 16:10:08 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 16:10:08 +0000
Message-ID: <31cdca26-f0a9-3776-bf90-39e97662a241@oracle.com>
Date:   Tue, 4 Apr 2023 12:10:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] sched/numa: Fix divide by zero for
 sysctl_numa_balancing_scan_size.
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        peterz@infradead.org, vincent.guittot@linaro.org
References: <20230330150757.547423-1-chris.hyser@oracle.com>
 <ZCxDICwfUojWTGr5@chenyu5-mobl1>
Content-Language: en-US
From:   chris hyser <chris.hyser@oracle.com>
In-Reply-To: <ZCxDICwfUojWTGr5@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:610:53::19) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|IA0PR10MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: b0188a6e-24f1-4880-1c9a-08db35270f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTuhRsQlWwGCZ3jSHB49QDgPkM0cZAxKQiTp/etJTFG/D9C/6qdeKFeFmvtlFG64YAaPS0B6AblcirUbf3boSXyRNTDAyNC+HXYNSTxx1dREKju9KaICTi1ITzTzFdkJK8YnfZo0lcopcoeZv7x8cSGxHKTSmuD80JkX/DFTNf2B58telGsqYXc2bol37oWrg61t/jmG2fKeQl7up8SRJwXZMLroIx/qQdyZhSFcuUgzeeHeefr/j/LXqX9xxjAww94Vy6QOLF9zdvCKS4sZZp36WpjNXrQSzztMVDfVjKCV716XXILqEf6WjIzUthzF9EKg9XEoqBA4M4a7zm1pPudxYEyql+EyTi1RMbVw7rPcPjcAU47Tu40FvdTuv0PC7T7WGTTw1Uds185jh7ZWq5Z6QoKlMljJusCGuxO/Jmt59Oo7Tsu2pYNsjBtVQsLFM9NYpOdQSukojB6rP5VW5StE8V7L1Gs7SjUCBu8gENIHSxhtdgHIj3OhG/L1ceJH0j0l9buZopSVUXjyHhSl/9RgGV8d4jxhx70ZxrmWog3wlOFiPKYNd4vFaiCf5rERyPz5imvjeekfQ48RYRkWSzgX1+6NaT0magCekMkvzqlERrGWkn7UscK7u9VU1ZlkJFpwol4Vave9sjz7lLCEc7SQbegTUpIi1kg7jI9+xqjEh0343lSbmd81xWHWNF5o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(31686004)(53546011)(6512007)(6506007)(83380400001)(2616005)(186003)(66556008)(6916009)(4326008)(66946007)(2906002)(5660300002)(8936002)(8676002)(38100700002)(26005)(41300700001)(66476007)(478600001)(86362001)(31696002)(6486002)(6666004)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3RUeVNXV2llbWgvUjBraSsxVEJ0bFZRdWhzZXhKWkdoNThram1LcHgwMXY2?=
 =?utf-8?B?NTRvWEpDWGpCb1V1cHVybmtldFhkRUQ4d0JidzcvNzBpcUtVZS8zRXkyNVAr?=
 =?utf-8?B?bFM0NE1tdmMxRTV5cExadXdqdlFIZ25SV3haeUtTdVlSTlBhdWgrcGVBKzB2?=
 =?utf-8?B?MW9zZURKdEZqelQweDhYMytQRk9BRXBoWnE0L1VPdHFBMG9OZjljUXNqMWda?=
 =?utf-8?B?T3d5bGZXQS9FSFdieXB6SXRCNFloKzZpL0NOa3o1RWF0R2t4YVl5bjBLTm1w?=
 =?utf-8?B?QkpMNms5T0dEdFZmdExvcW1RcURDcHdLQVpPNnRhUEpHNkpnS21EcjN3MjNT?=
 =?utf-8?B?WFNLTXQxMnllM1o2cU5SbmhkNHpXaFRTY2ZIL0RuN1ROZ1dFQUZndnNHV0U2?=
 =?utf-8?B?RjFEZml2SkhxdkVGS0ltS25JQVZlM1lyemQyWFg0ckNTSXRyN3ZpL284ZXph?=
 =?utf-8?B?bnoyeHdQMlpuNjJ5NlV0ZkF0a0RQZ1RnSWphMmhXZHdGVGZtVHQvNVpHeUF0?=
 =?utf-8?B?K1JuRjlSR2NoRXRlaGh2bHhpZ1ZqVkQ0RTFJYW9HWEVHM3psZmF0OExFZDlV?=
 =?utf-8?B?WEdteWxpaTU1MFcxOFJVSnlPbkN2ODR1cnJvc1NKVzNhMGJWMkc4VXgxK0tM?=
 =?utf-8?B?QUtkck10aEpKdGEzNEZtdk1lUGdpSm9laDFDeFh0czB1bWppb1pUbUJwc2F0?=
 =?utf-8?B?M3Zkdk9sbVRFVEMxTnJhd25aemlockQzTy8xL1JGNUtJcUpLZjMycncrdGRr?=
 =?utf-8?B?Zm5IZHYrNjZGQzc1M1RKYzQ1VmkrdFkrakdhM3dZd0NEWmprNnZxRjZpT2Mz?=
 =?utf-8?B?bkRWTUg2RURwNE5FbXdiakcyOEFlcGFiWkJ6S05pR0NQVUdrRWxJRjhCaGk5?=
 =?utf-8?B?MlphRXh0dk4rUGVNNUhvN2JFZStiYkl6V0RnbktOQTg0NUFLcWJlLzdCeUg3?=
 =?utf-8?B?NWRnaXR4aWZ4Wm1SRW4xVFIyMC9rM0Y0SHFHMVI2Smg1c3p6RWhKM2FKdVZy?=
 =?utf-8?B?MVBSdTVhMXVmNFFNejVaTzgwUDBoZDJjRncwN1dKR0plOGYxK1lmT3JyWVlw?=
 =?utf-8?B?N2lkbGpkT0FZRi8zblliS1pSNHFBZTZGMjgyOGZKZ0xBSHdoUGpTK1BPUVA2?=
 =?utf-8?B?TVZtQUZmRnlEdDExMU5ncnQzY012TDRkOFhwYldsbWZ0S2NGaHBneXNBVWZp?=
 =?utf-8?B?K21WNFBEQVZnZUt5a3V2VlNnOC8zYXZKT1UrK1h2eEt3MjY3YmRyR1FWZXdV?=
 =?utf-8?B?YTVKYlpzcFNYdlFmUm5rZTJ2QjFxd1FZY2NKdkp5OVJnSEUwbGdiQzBPNjFa?=
 =?utf-8?B?cW5lemJMMnRaalhTcURCdE14Qmo4TitSRDhpSnRHNCthdWVIcjJFaVJ0RmZq?=
 =?utf-8?B?ZlFMNHVZQ2ZCYkhoZ3J6TnQ3NXozUUM5cWE3YlFIdThMRHEwUzJrOVNTTzFj?=
 =?utf-8?B?OW15dk1wZVA3UkdxNXN5N25Ma1NCRWxEYVhobVVJS212cXFFVFlSZ2RkdFYx?=
 =?utf-8?B?TXduNXhMVDdyMG9ER3B0eXhhaVhHUExPWk1sb3R6Qm5zekptTGFEalpaTmx6?=
 =?utf-8?B?RzFRWG5UN3l6eUJPeUM4RCs4Zy82R0RabUhQcVp0N0lyaHBQOVJrS3hwVTFE?=
 =?utf-8?B?RjMzNzlZTzVCNE5YaGIwUDNibFJRQjMyMlc1UjBxMkZQUVFlTFN6QVhrdjRU?=
 =?utf-8?B?K0Ryc0grMmJwUmJjdHhKYytpUXJKU05lNTRaWThRUWVzUk5uVExvK3RoRkNY?=
 =?utf-8?B?SzdnRUNRMFhsMFdwUXlpQk1iZ0QwbHBkNFZrbUFUTFRqRTBWUzV3WkRCcHFy?=
 =?utf-8?B?YTVFNnZ0MnI2dG1FY0pLNFR6amxoZ0hZNDlmRkxFd2VrMUZOd2JpU1VuQllG?=
 =?utf-8?B?Zit6YllSS3lqdzhJRHkva3MrNVhFMTdJWW5EVVRubkVDTzg4QUJDM2w0ek1G?=
 =?utf-8?B?amNqcm9LNm9nRlNUZUpHY3RnZlBZZW04UjhJa0lmV3QwNWNtdk9SMWVWUm5l?=
 =?utf-8?B?TlNZMDVwOVNsNHUyTW1tL3dsbGFJOEp6UXBqZWZKT3M1bldkRnRSdk9CQ3o4?=
 =?utf-8?B?WWViRHFralkzR1ozRGpXQzNXVFZXcVYrL3dIaU1XNnV0ai9keXQyN293V1Rl?=
 =?utf-8?B?ajdpenRnNGNtY0xJRE1DNFNZaUdHQU5XRkIzWDF4UEt5RkdrTUN3T0R4R1FB?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JB+m8CWYsfixgiXCEiYxcsjaX4vfPonKffJhWZQ8viiHJiktTRHGYf44WxWkb1gVVnANC5Vbyad3zG3/zPX/TZXdnVfUQn3UgprxDqd6DbBhiteWu8yh9XT5smQX3WbxSXsGwe00+1XEZr1TkWOLlfy7wmDLEr63kbI8Jv7GBlh30/gE98nRUXrWP+ZBSNwTDCHmC2ooTsNjKPcVm9tZUaQYsx+jjs8Q5ru7hCdVXJfE+HtRyr63Fwzk9HoaVZ9lHnVk9dHbYIAWgaY/9U3iTf/ICHWNHSCBulwYbejCyutoGJr9pryA4ahmBPoS28oebfCGG7JIhna+H83xJlKUoSkKl/VhsWyfmfbLIU69Ghh40fSTwacjhQlfTD+5/1vV/gcRrSU10I8Oudw1rIcPBvM20Pnfc9uGff1R9hxeXRYeFA7wJGvFW8QqpZZKB/BdMPYntmCs9iC4y9VmghPGFAXbmnsxiyDQHzmOjZsxWMl4ngrtBjg57zLO6FuiOAOuKp0UELqeLp5EExV1C9fUktvTPwrlKLHU8Usq0uFY8KoxKhVEAk8gPpPFdd68xw5fX17C6IYYyBoG8jm4XZdY6ZeN3+RLkoEksi/PZj8di5Xqs3Sti6ylbJQvOjfBjHyCDstjBLO0ce17/B+MgouVwrmV+jnK+Y0VQNjbdlkkZ1AauQLMgFjybYp3xFJ6AyiRttmT+Djly5xyNs6nf5JgvYeLwGvioEqmRU6Pod8NV0rAMjs4WAcVojr5X+3AwowisczbQRv2JKe0NcYtSYmcTXdxpSwU/lrHKlQSrFTF0YPJQZP1hewJj4rKacOVw75vetl9eyWDcxaLflVkELJ8QTDTVYgRNvNxNNiutveS2vopvRURH57+KLcY+xlbndxC
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0188a6e-24f1-4880-1c9a-08db35270f4c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 16:10:08.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBcuxYqvDayzobdK7OpPN/+5lkjiJZOQs4S15Y8+FD0Clpnegg/1kdQf46yaHbqBbJMETxnYy/NzX0gHdUXgqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_08,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304040150
X-Proofpoint-ORIG-GUID: Mh4n7epQTryUHIZ22xK5Nez6ZYPBFah_
X-Proofpoint-GUID: Mh4n7epQTryUHIZ22xK5Nez6ZYPBFah_
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 11:32, Chen Yu wrote:
> On 2023-03-30 at 11:07:57 -0400, chris hyser wrote:
>> Commit 6419265899d9 ("sched/fair: Fix division by zero
>> sysctl_numa_balancing_scan_size") prevented a divide by zero by using
>> sysctl mechanisms to return EINVAL for a sysctl_numa_balancing_scan_size
>> value of zero. When moved from a sysctl to a debugfs file, this checking
>> was lost.
>>
>> This patch puts zero checking back in place.
>>
>> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
>> ---
>>   kernel/sched/debug.c | 52 +++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index 1637b65ba07a..b5fc7e250128 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -278,6 +278,56 @@ static const struct file_operations sched_dynamic_fops = {
>>   
>>   #endif /* CONFIG_PREEMPT_DYNAMIC */
>>   
>> +#ifdef CONFIG_NUMA_BALANCING
>> +
>> +static ssize_t sched_numa_scan_write(struct file *filp, const char __user *ubuf,
>> +				     size_t cnt, loff_t *ppos)
>> +{
>> +	int err;
>> +	char buf[16];
>> +	unsigned int scan_size;
>> +
>> +	if (cnt > 15)
>> +		cnt = 15;
>> +
>> +	if (copy_from_user(&buf, ubuf, cnt))
>> +		return -EFAULT;
>> +	buf[cnt] = '\0';
>> +
>> +	err = kstrtouint(buf, 10, &scan_size);
> While testing the code, it is found that there is a
> kstrtouint_from_user() could do the above. Not sure
> if it is worthy to use that?

Let me look at that. I think in general, replacing a block of code in a 
non-perf path with an existing function is better.

And thank you for looking at this.

-chrish

