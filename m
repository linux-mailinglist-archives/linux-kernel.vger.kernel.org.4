Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D325F7DEA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiJGTVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiJGTUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:20:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA8CC829
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:20:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297HrBXA023296;
        Fri, 7 Oct 2022 19:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lsHraOrEN7C5dGr44vMCCiImuvm0mYeJTv6eDsemiQ0=;
 b=Rs6JvrhZOLhUEwW+REhDvSyG80M+ChgtxcZO3BpipXC0eZXZL6sEwgIEKoiqfGCQnCJE
 DU0wt5UGiBG+HXLPkE6AtL/GUsoU3Bd7cYwrw3N9u2frU0//cMHIrhlvKOrDzoO5OA0v
 KwppDOJiHNHuH4oFtr5hlJ8hmMXOXVtefxN+Ng02lhfdQwT39QGWPNSFusCVhFh6ye87
 AMcwrCMUZbMJnyUQ6cWCPRznOVAcbytNixtmfQyvHGYqe52yhXxR7/NnZGs4LM7d4yZe
 YoMr33cKzJOj6Ukk3YDRL8Wu6FoZW/Eh30GHO+71FNwUqUGk7PS84nrrgSJYVIvo7ZEF 6g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxe3u0cmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 19:19:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 297HEb00003030;
        Fri, 7 Oct 2022 19:19:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0dpfes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 19:19:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaDab2y90EtmpHMMPXTPuAT/usyH5vApnc1esYAzCwE7bQliQnrEdzu9p7eEfRiWHZJIUfazQojR1YdL1Lqv52Y+vCEFyBqJQ0h8wmO9I3fWkaNLzmQJ1indD/D3eLzppDU7yvvaDRFCaWWIwnZJFs/q1WkEDNGIxOD4X02crpm+c2bLy0ffKL1jEyAATZbffjo/PxgxifVZI4nhAM8JeqeTrivrlg2nWCqtpFaCUsNahtazWOmgfunPlC14NAg2sDQhC3fjSo13k4VDr9P+lpjmZi/0lHXMIPZgaXMsl2wLip0OHSFsE6A1BXJJ/VL40S8O12cpHH3ILVSyfqwCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsHraOrEN7C5dGr44vMCCiImuvm0mYeJTv6eDsemiQ0=;
 b=PYTGDsrm3rGtFft6XXx9RWKXoKQQNbBJecoYmFitOmO/6lc3CNjpl0EHNlzPA5lpPy9d5OXNzjHlY4KcGtEYSDz0WXHtwPPxX7mVuWHF7s1EzEvCP4WaKcsWeuIuX7yQ5k+cOEiiK7Yq1sq+ug38CoQ/2DTP2zqx/qk4uFVb9Dog5Ajqys6JpJGGH3oIV+smWzQhlr66jSYYMzseRWF0LTE1shzIgLC+pOT9ABn8nftFatKVn9UUbMlM7oAd2MSqS9tVIm442PrfG4q9UaI+Ook0tiYYrlDj01xsauyCAtVc5Sj6A9iQMVVnu8S3ZwcYGiyglZPXnrqkuulxg4G/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsHraOrEN7C5dGr44vMCCiImuvm0mYeJTv6eDsemiQ0=;
 b=0AbcTd7rT1zgYGBfbbZVfLOimY2rTTvPKCENLuTNQCGmZbGIbMcXV6OgvSmfwWTXoapokE3gid61JHgsdcHddARdXzMfy5jZfYPiEKA2y1VNQOdwfHOI1nukbehpOEdkN2JwB5wKNK3WgecYN1+YNSmI6HwrP2+FsEGK0eQ4cEw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5216.namprd10.prod.outlook.com (2603:10b6:5:38e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 7 Oct
 2022 19:19:42 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%7]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 19:19:42 +0000
Message-ID: <56369ee0-d0eb-f259-28d2-c13d87d011a6@oracle.com>
Date:   Fri, 7 Oct 2022 14:19:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 3/7] crash: add generic infrastructure for crash
 hotplug support
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
 <20220909210509.6286-4-eric.devolder@oracle.com>
 <1a07c461-67e8-8f0d-756d-ef96fa4a9b91@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <1a07c461-67e8-8f0d-756d-ef96fa4a9b91@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::13) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1e5a9d-492f-42da-61cd-08daa898e321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvzJKD8mLHvWVSju6ObmGFnCoVx04zx3r/Uhye9lFWh+ntlcH0JgwrnHTa+m++jjurxDK7NmjH7pncTKPzbzj/JuVIEawlA1EH09oTy+k5rJmycnPs4Htged4mLbyyAY7VP27WmEYKgz+F50ayqWBtgNT2u/RB7wzRXqUc3lLnRudfivUOhm9xsNeyHGdggpJSqM0zrx1uyOz5vWmJ4HX1zEP+v43S00BAebX/RsQFXRzzxklM7t5DP7FKj9rt/ZCdVy5YKitvKVMJtA1qREOB5A+akz4Eqg/iE+A2TGa/FNbxSgxMoX1lVNYYBNjDQRUZ7Fo00SGXt8Zi+Clx4OpPaMMfnw/cB9ysiXh/cRGivilR5iKTjs7YGVjYun4u3r/btpYBZaPy49f+eOlRp+ktTGDBM9FEh5PHevq/NNdVbzWqHLnKPuTJV5gR0mGmMuEa7ISKBPEe2PgZprKmb9OZuagpHKQBX8aezLWch2j6sOZ/wXyJyxZT50OJXF6oFQYvV3Oq9cNvnQ5GASEAveZSWJTtqbypHe5f6EvEjAwMR+xkk67t2StqET/lWvKC7Gx7URcv5x8nualkXfRAYhVLQPcsQzFaR5J7lVAo+B0Qml8P+tFS0OjBHWFTXRy2q5K/Og81iSoCIGfnmkgpCc0ExN94vPRv4TlKSw0fkpybIuSH4s8t5raykz2jkUFtglky/VLowaqkas/4DIVsUjeeJDLBttsEacU9TRV/TnT25/Io7ZdB3XM3QxpGXOYQjwd0XCZPeQ0Ojqt0YLKRTYPVeIFIAYIPiP01DEDWUO9V5taFDJnfLo3dw1eI+OdoTbWB2dPHwA6PrWNgUmkFYBdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(53546011)(107886003)(6486002)(6506007)(478600001)(8676002)(66946007)(66556008)(66476007)(36756003)(316002)(4326008)(6666004)(38100700002)(186003)(6512007)(2616005)(86362001)(31696002)(8936002)(83380400001)(2906002)(31686004)(41300700001)(5660300002)(7416002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnlDMTRobmZ2OFF5cTZGbkFBRlFvVnFHdWdmT0ppUjBFSHpRRW82SDRIWEZu?=
 =?utf-8?B?UkI1c3dRZHJicVdtVXZJR0t0TXpocktiUWFiYU9FQ3c0VXpGQXBUcjBmb3dh?=
 =?utf-8?B?YVRaNjU1NzYzZmljZjBwbjE1RVNTYWZ6cEZ2SUM5L2pGcEdoNmZBV2JCRDZh?=
 =?utf-8?B?WG0wU1M5aXNTR3V3L2Q3R3czM0NRZUVOZzV4YW50MVRldG5UT2c0dlhsdG1i?=
 =?utf-8?B?UlA5dWZyempFdmtUczVaQUp2ZFppNXpNSlBMcy9yT0N6OFBpc2lwTC9rSVJF?=
 =?utf-8?B?VlhlV0lndjI3SnR3elRyeUg3QnNNZHk5aXVYdnlqK2czaGVFZVM2WlN5MFpX?=
 =?utf-8?B?ck04cFJlTWk1ZGEwZGhWM2hPYm5wdGpVMFZUQ1VtYkw1K2k5MHhFSFZ1aGN1?=
 =?utf-8?B?ZE9xRjdtSWJLVjE2SzdqN09NNFR3N2g4ZUZTcHNrWnlrYzgyb3pmSk9Ea1NF?=
 =?utf-8?B?aHdTQmpqclVjUFdVc2d3WHFIMlZOajVHN0I1M3AwUWk5dEUwZHN1ZEVmcXYz?=
 =?utf-8?B?TVpxMDVmeXp0VENGMnpKdFdRbWc4dzRDTVlQWlc0dklSTkJEd1lUU1FLN0RI?=
 =?utf-8?B?QWFBTWNwVi9rV3JDNGFZeERjTDhpbXJNQVRhc0Y4QjRrMnptenorMkhYaFFr?=
 =?utf-8?B?QU5tT2FMUDRFOXBZOXdoN0NNU0ZzMGxuV1Z2dWU0c3d2Z2FLZGpmNVZob1d4?=
 =?utf-8?B?Q21xOHczcFZNQzZHWHkyRGkrT0FiSHhhVzZtSWVDTldDWXNic1hDaUxhcjJr?=
 =?utf-8?B?bEpmSEdZekxpamc1NG1lL3lPbEVERHprai8xUlVUaEorRloveTBZWjRnMERS?=
 =?utf-8?B?a3hUYTgzd0w3Z0V4dEh6WW5WUGpOcFplMDBnWi84SGd4MDk3S3FFRllCSmpq?=
 =?utf-8?B?cXNRLzlJUko0Y0VEd080YWdwRUtjbTdpMms0cTJhQ2txbXpGVzhMSzE2WFBK?=
 =?utf-8?B?eHdwbDdIVFd2TDlJOTJJT3lpSklGcVRlL2U5OEEwMGFDMVJCbkF5ODhUL1Qv?=
 =?utf-8?B?SlEwTU8zazdwcFovOVVuODFZeUdyYXNtZFd0RnRXSnA1M1hwYVIrVGlKdXJ3?=
 =?utf-8?B?TUFMVDAwMldmVGIyL1ZMY1ZhUitTM1QyYytHUVBpT1BaUk1mRmNuY05HK3VU?=
 =?utf-8?B?U1g2dDNFSnBmT0dnUUNkNHQ1MjhKcG53UWhiT0pmOGVwWEUyVlc5amUzaXQ0?=
 =?utf-8?B?SG1NTmowNk1VbXpmK0QvMVZsYlBWWE9JVGUyQS9UMjRvelYrY1JOTkNIdmtm?=
 =?utf-8?B?bkNnaXRVMGc5REdXa2ZkMmVrMTViZVZrcHgwRkd5K2hXbXptTE5ndEpuUjhT?=
 =?utf-8?B?NDJVeXpWaDNIa2JwUkU4UXJrYTh1N1Vla1JZRFQ0Q3NHZUw3QkhPTmJ4RGp0?=
 =?utf-8?B?MVdBcGxlNUNIcnVRdG1WS2d2YlBzVURra2E3ZEZ3Q3RrZG1MbDU3Y0JJVy9M?=
 =?utf-8?B?ZTJuYXBPQWJ4elRUQmR6S01SazRmMk1tdDFaaHAya0RXZGMvdEdoMGVteEJO?=
 =?utf-8?B?QllNYXNoWDJkU2FFNGdodTNLWk53TjB6eEJ2cE90eDVCYWFUci9meSsveXR4?=
 =?utf-8?B?THdxd1dVSkR6R3kxckQ1eURxNXVwSjJZbXhnVzh1OVBUVFYyVS9jMlB4c2g0?=
 =?utf-8?B?Q0RuK2h3Y0hIYTFILytScWEvLzJTNStrZUZIVkZKQ01jZzJ4T2hwa3BNSkV6?=
 =?utf-8?B?Q0prUHhFVS9IT2svbVY5ZFdmNkRBaHFPZVI1SmZpSUQrTmtWOUJldnpVM0dK?=
 =?utf-8?B?MTlFdWZJbGtnQnFTSStYcjBxV0dqdWFheUswTUl1Vm03d3JxaHZYeGVlbTY3?=
 =?utf-8?B?UFlsN3hLNlVoTVFGV05xT2VnWklmMTJJZUF2ZzZBTnZmNTV1KzhWcjhRdzNV?=
 =?utf-8?B?cDIvTzJpbDcycFVSYWpDQ2lTNkZvbmQxYzB3c3FQY28zK1BDVE9jMlY2bWNr?=
 =?utf-8?B?UDNnV2dEY1l3SUJBZ2kzQkFuRmsyNlMxb1lwS2d2b2IxTjljaFFGcXBabGNa?=
 =?utf-8?B?bWpXT0pxSm5WMlVmRXFOUmdZQU4yc0pGMmNsbTRoa3A3TmNuVlhXNDAyNDFk?=
 =?utf-8?B?T2k0U1crTzdkRVV1cmlxSGdHenRObjlRSmplWC9iazhnb1NoS0p2amJLekJi?=
 =?utf-8?B?SnRTaDdHSStmOU56OGt5ZGFqc1Rpd05ML2M2K3BIblNMdVFSbmdOdVFKYnc0?=
 =?utf-8?Q?Z+j9Nk8oQ+1drtR7G7ysD50=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1e5a9d-492f-42da-61cd-08daa898e321
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:19:42.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWzKOK7QQsI9A+R3uEjKuaNrpAXcCFVO3/cmMaRqA+3Yxi0PuxcoQoXCHA2SlqHKxGgtLJlA8kZw0YbxXRlfWrRHBUM3vRg1tyTbqY1VviA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210070113
X-Proofpoint-ORIG-GUID: FPvCeAdMiaNpETWbVO7qBD8GZwfjv0dK
X-Proofpoint-GUID: FPvCeAdMiaNpETWbVO7qBD8GZwfjv0dK
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/22 01:38, Sourabh Jain wrote:
> 
> On 10/09/22 02:35, Eric DeVolder wrote:
>> CPU and memory change notifications are received in order to
>> regenerate the elfcorehdr.
>>
>> To support cpu hotplug, a callback is registered to capture the
>> CPUHP_AP_ONLINE_DYN online and offline events via
>> cpuhp_setup_state_nocalls().
>>
>> To support memory hotplug, a notifier is registered to capture the
>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>
>> The cpu callback and memory notifiers call handle_hotplug_event()
>> which performs needed tasks and then dispatches the event to the
>> architecture specific arch_crash_handle_hotplug_event(). During the
>> process, the kexec_mutex is held.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   include/linux/crash_core.h |   8 +++
>>   include/linux/kexec.h      |  26 +++++++
>>   kernel/crash_core.c        | 134 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 168 insertions(+)
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index de62a722431e..a270f8660538 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>>           unsigned long long *crash_size, unsigned long long *crash_base);
>> +#define KEXEC_CRASH_HP_REMOVE_CPU        0
>> +#define KEXEC_CRASH_HP_ADD_CPU            1
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY        2
>> +#define KEXEC_CRASH_HP_ADD_MEMORY        3
>> +#define KEXEC_CRASH_HP_INVALID_CPU        -1U
>> +
>> +struct kimage;
>> +
>>   #endif /* LINUX_CRASH_CORE_H */
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 4eefa631e0ae..9597b41136ec 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -374,6 +374,13 @@ struct kimage {
>>       struct purgatory_info purgatory_info;
>>   #endif
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +    bool hotplug_event;
>> +    unsigned int offlinecpu;
>> +    bool elfcorehdr_index_valid;
>> +    int elfcorehdr_index;
> 
> Do we really need elfcorehdr_index_valid to decide elfcorehdr_index holds a valid index?
No, as you point out you can overload the index value itself.
(In fact I originally went this route but encountered trouble
with locating the proper locations to place the initialization code).

However, the current approach has the advantage that it is
automatically zero'd and thus set to its correct (false) setting
immediatley upon kexec load without any additional code. As the
diff you have below indicates, there are several sites that need
to set the index to its false (-1) value to accomplish the same.

I prefer the index_valid approach, but if there is strong support
for overloading the index, then it can be changed.

eric


> 
> How about initializing elfcorehdr_index to a negative number while loading kdump kernel (or kexec 
> kernel if needed)
> for both kexec_load and kexec_file_load case and consider that as invalid index to find the correct 
> one.
> 
> Some thing like this:
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 5bc5159d9cb1..0cccdb2f7f26 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -656,7 +656,7 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>                   * segment containing the elfcorehdr, if not already found.
>                   * This works for both the kexec_load and kexec_file_load paths.
>                   */
> -               if (!image->elfcorehdr_index_valid) {
> +               if (image->elfcorehdr_index < 0) {
>                          unsigned char *ptr;
>                          unsigned long mem, memsz;
>                          unsigned int n;
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index b5e40f069768..ed1c6a88879b 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -156,6 +156,10 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>          if (ret)
>                  goto out;
> 
> +       /* Below check is not necessary */
> +       if (flags & KEXEC_FILE_ON_CRASH)
> +               image->elfcorehdr_index = -1;
> +
>          /* Install the new kernel and uninstall the old */
>          image = xchg(dest_image, image);
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index d0c2661b3509..535dbc26930a 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -400,6 +400,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>          if (ret)
>                  goto out;
> 
> +       /* Below check is not necessary */
> +       if (flags & KEXEC_FILE_ON_CRASH)
> +               image->elfcorehdr_index = -1;
> +
>          /*
>           * Free up any temporary buffers allocated which are not needed
>           * after image has been loaded
> 
> Thanks,
> Sourabh Jain
> 
