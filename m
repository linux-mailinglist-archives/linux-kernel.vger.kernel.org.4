Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591255F0F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiI3Pjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiI3Pjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:39:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC7E1A108A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:39:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UEADFd010439;
        Fri, 30 Sep 2022 15:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DxlxclNRvHhgxImncrjQlWxNMFqqaIjC/pJi686znBs=;
 b=EEGJmigApWdJy9hoS97nGuKc9bn9lKixHthapIkxI9PKp3qkABldtNaUfzkt6TXf3P+N
 JtOLy64jX58ZTSv3P0Yv/Kt5zSDcGkFGMPaKdANo/ExrRbdCjnDPR98HEytk81VMTy9k
 Bt0RAA8KFC6CQ/dstzC/kLYOEv6W/eYJj4pkHeS54vVZeOvbzWGuMz6PlELCfFb93pr2
 K8x78+ZwuzttYIhQAQzhfzo8Pt9fDZAqB8PBMWbQ49CvBu8WRYyU0UskMzkRCOfDM0iK
 W1A8zSvnkiHCKJ6HiHTK5CwVXYTr/ykzo6kzrlkyXwaOX2E0R9hbqvEKMDarccavw94+ lQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrwr49v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 15:37:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28UDgsS7004868;
        Fri, 30 Sep 2022 15:37:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtps90u3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 15:37:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R77SRiVnWO+MfnknPdEjuV2kLOMptwwuKEl+QIZcF8ruYCUvmDIPt5jUa+9/ZM2e4VefUUZ5c1F4Gb9MsGhGufa9s7KiBH2HhcCU9IJaIQWtpEvcemrMmC3D93ch3C1QyiMY8Wy/Qps6e6xAjWkl/QFQpGzvFlyqKxhI2oq9giOqusbpN7W13dtQGAIgWd8mw7T6lrRXPgAxrV7jRfKqDiKggLkFFlwIZKVkS8EFOrY2dqvpixcWHqc5zU1aLk0q7VHXzYr4lmA4zHP5opGTvYqsWJtUyxLhAQXX5nN6IZvWYWi+e3UaSgY4nAXhQotWYxz/m1v5FtdPrGuhLqfU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxlxclNRvHhgxImncrjQlWxNMFqqaIjC/pJi686znBs=;
 b=P8ZCtagnPIQAyQdMo7BT8M9k8LmjMMTUzrFo189TUTJ5XwQyz6l2gZhAFnS5N6Xy0iMj3jcjtqt/dqVnf2mX2OCNqYTDUWgGHrKHQbm/wvtvlAOfAzvI3inrYF1N5/YNHGXMn4a8SV+cF2FK+RRUpTZ5J36vucNmPD57q+XUp94CcUFz0N+/Z6jTfBVgDiWS6gVOXMK1oyXc/aSwzA/5T31dUgfZCa4csKzMKSFKN7NFNVh9pZzQP75xHd8mkFB6/Nlsinu5+P1tixmXTN7qOqHs0R9oyF33gF+aeSADKdsvTYGtRt0MvKWXgrFdW7serYSuKPKmTYwZ9RZ5/9XEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxlxclNRvHhgxImncrjQlWxNMFqqaIjC/pJi686znBs=;
 b=Ogmzq/SMj83vQ2oS8z8/uN72p/gn8bjpt8MJYTC0VSxp70wQlrzngodbGMLDEbbci6wrIxZ4qiURdGEW+LT/F2t1hpLNA5I3i/iSM0BWyMKRBc2eKWhZqCCNNrbLjaTFtpkb7ocU2uNz7/gcoDbLJjmsX0wduUGBWUMqReRvqpE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5054.namprd10.prod.outlook.com (2603:10b6:5:38e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 15:36:58 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f633:11c5:8ca5:eb40]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f633:11c5:8ca5:eb40%7]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 15:36:58 +0000
Message-ID: <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
Date:   Fri, 30 Sep 2022 10:36:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com> <YzRxPAoN+XmOfJzV@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YzRxPAoN+XmOfJzV@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::23) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ee2bf5-1007-4b67-f2c2-08daa2f99c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dj8r/g5EL5njAAgy3vAa39Y8xEyqN3Q5Zrgc6ERgaE/mxh3OrISKuFVSVrZ/35I80nIrVRCUq110Wqk8KCI9g8Ts/gJo20rrOEery5yKTWJ2fnmnwhjxTasWph4kDAJeMoY5Y4Bcg0iGo/rlYvGKAv7A1f3lhZ2vauBiCtkXhpcmwJx0DXSPpTCA6g4Ya6oygjdixAVa2Ywohs+7hUiPlH0fqCPIeffoDEKYGMo8f1o42ToiNaqfDZbREBVRpI7SjlAaHx1gLJq8X/stHN7Er1vpJYex8nSHcYM7BIbbo0KrY/CeRcI5SPse5RkK+81Gj1D0liThb2MKk2eiirmbPeVMRHoak9L0U1ZCrTvv7q/Hy4s3vZN55MLxJtMYPphTuvrD3tcrIic6H5i7lzCrIh2ym/wqGAEL2S+TpFD52QSwNSlBsGLjzSrBoTmB9dU2YYC4V9xF/NLkF1N+vvMywP6AWWujugGwbcGoSaERDJ8D5+y9oLj+gBIelwbx0DdxpByouA5STcmHdEOZLFAOvN5UT/1NAJVoY4lG3+g086k0ajJqs0vesXdkPnGbjbngTR3MMSSn7rhkMYoWGJ7HnG2+hnwfAgV8wfAeBGihBeH3UCTcwOdLTI+QwVdPnmmYV6WFK/yuEKU6Dz2ZI1IIK3HfA5snrhNHhDXP9Kvgpj1htudciCsHmIGY3ewiXeKGKxSm6ksRPOnLI6q5B0A75XVmqt1/dWbzGVdGApkf59TK2zUTwRULegV/IEjpXLWkdQKO8INOQpdBFLTt/ldxshmYbhKnvVIe14U+I74K+EXC3ghk8n/ZYccM05hF9xvIfAXRkXqR676BkXz0ZZcan4PJk6ixnVocJf9iDPRL0WXjXHEoLE4oDOoteyaTdyV9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(31686004)(2906002)(36756003)(66899015)(8676002)(4326008)(66476007)(66556008)(5660300002)(66946007)(7416002)(316002)(8936002)(41300700001)(6916009)(83380400001)(186003)(2616005)(6666004)(107886003)(38100700002)(86362001)(478600001)(6512007)(53546011)(6486002)(31696002)(966005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3hCSGtOUnFYOCsrN3N1Q0s0L2ZiRkRWS0FRd0NhM2hOSGl0TzRtclB4VWpZ?=
 =?utf-8?B?bTd5Y3NrVlNxVHFIY3VxcFZHbWR2MnAwVDJJS3oxVGRTbng4MVMxOE91eXZO?=
 =?utf-8?B?MVVDRzBnazNnSFJRU0p2NjhPTXYvZjBkdHpWTml1MjdxSFEyWjJTbUVQVWEv?=
 =?utf-8?B?K3RpYVI2dUJOckRobGFjb1RPME12Y1A2dlVsOEkvSkc4NjhFWnM0ZUhSMG1p?=
 =?utf-8?B?UGl6SHp2Mk9scTdvM3NNVFZNVmR2U2ROM25UVmd3ZEZIZXVWQlU1clBTTjJU?=
 =?utf-8?B?NDVmbCsyS0J6Q3hzTnB3NHlTYXVMdFJ1RVZLa2FMN3E1emtFL1dLRFl5aVlF?=
 =?utf-8?B?QjBBcG5PT2RMYnNJUHkvMVd5cVJDMDZHRmlzMUtTS3FUWmpOcWo5WUE0TzVC?=
 =?utf-8?B?QTdqcTZDcUhvNDBVNWdYTW43L2t5OVhtOU9HSm1qQ0NsVWVoZXhRY2M4emky?=
 =?utf-8?B?SjlTS0I3V0FuYnozVFB1d3RlY0NZenY4VXhBMmN1UDduS09mZkNreHZUWkNW?=
 =?utf-8?B?dUdHUkZhZ3p1NTRodjRmcWxBZmZOY0NYcVZzOVZiME91Nnl5bU1GODFRdUNV?=
 =?utf-8?B?Zk9zWk80d3lnTHJLQ3ZubkJBNkRxMkRCYjIyM2MvUFQxcUtDNDFzRWk1T0hi?=
 =?utf-8?B?ejhWQTM2US9CZzh2SDJvUkF3MXhEY2IrQzBOc1NQS3I4Nk8yaFg0N0dRVVF3?=
 =?utf-8?B?QUFETFIvalZQTGYvZVdvQldKOWdSb2lXbmNKL0F6c3ZIbkVlWlhaVlBFREc0?=
 =?utf-8?B?Y2oybGNrN1pxT3JHQ203bWRZa1p3V2dxSzhvVEpEL1BZT1dEU0ZSVkVLYTg4?=
 =?utf-8?B?RHoxa0JWWU9OZVVKME1BQ3lITzFYU21zajg5N1dHelFnb3hGVWp5QW1EUTA3?=
 =?utf-8?B?VkdSNlBnQUNBZW9CTHlVRUdiM2c5SkYxSjhzUzRBUk5IZUJyaVJrRTdUZngz?=
 =?utf-8?B?RVJGNUxSc2MyRFFkV2lQWG5WUmFjOEhYb1VJYzI5bzFaS0xWOHQ2S2JYNDhi?=
 =?utf-8?B?SW8xNWFwOGdBeklDTzQvSWxSU3FtV2Y5UForMUNVVFBqQUxIVXkyVzVYNTBT?=
 =?utf-8?B?aDFYTWpOUlFRV0tGbWZUb2NONkV5L1d3MXB1M3ovSTlDY3FsSkMvbVhzNkFW?=
 =?utf-8?B?cGREY1UwZGFNbVVFNkFZelZIajQzN1lnZjVpVGJGOUV1U3ZpblNrYXBmemNi?=
 =?utf-8?B?N2VvL09BenFZVHBWa0RwcS9uYWZLeDE5RW9jSW9JNHVnZVpRMTRvOCtCdEVO?=
 =?utf-8?B?N1NseHVmbWhGN3Z3dzNkK21ORU5wUnVaSGRyVXcwOW5KdDlJM0lrT2p5Rytm?=
 =?utf-8?B?T2lPa1VHWXRleHhkU01JQkxBdlU4MUdHWGlISTI3Mk9lYytNaWtLNlNPM2dt?=
 =?utf-8?B?ZkRUZVVUSEdnZENjU25PeitVUTRmVm94RWprckdSREtYekptYW5GYTlhZSt0?=
 =?utf-8?B?RzBMaVFjMnh6VWVwak83eTdmbVM4d1ZrMkthdG1MUEVjejRKdjdyU0ZTMC8r?=
 =?utf-8?B?aDl3d0VVT0FjdjZyNlYrSHdrRE9Vc0cyZDRDSGJFN0lZUDZFRW4weFpjOWVL?=
 =?utf-8?B?U3pHK2FXOEhQei9UYkF5SUhBU3JLMWdBYWZmWGVka2lYK3MwMzBtODNVNGZ5?=
 =?utf-8?B?NDJlR09ZdElDODBCK2VYbXJkamNxUEluWko2RmNZWllMem5sNngzVnU1M2pl?=
 =?utf-8?B?R255THlGU0U0ZFNocWxHL0VtTW1MSzUxWE50SG9TZ3Q4SUVVeDFHTmxxSEN2?=
 =?utf-8?B?L2lXaUdzMkZWS01zWXIyeGs3SVhqY0NxY1dwaytVam5KTk5QdS8waW1zeHFV?=
 =?utf-8?B?TGl3UkdLbnY1YTNnSHR4d2hXQ0ZjNzBVaHNoYk16My93OVBocDRVRFZkd3p1?=
 =?utf-8?B?SWZpRTg4UkhjekZ3UzFLWkZIdG5LQUc5bzlmT3lyRGoySWRtWDk0MzE1N3hj?=
 =?utf-8?B?d2FXSTJnUmVsencyQkhyRm5RMEsrbUtiYWdTYUxKWGszUjJnWWJMQkx3MFRt?=
 =?utf-8?B?YU5jTU92cnh4cDdDTjNVRnJRSXE2MUs2dFl5ZWVBRWYvWWpiMXg2bExjUlZS?=
 =?utf-8?B?R1RtSmVmM2t0bVFpU1VDQmM5Q2c4dmFnNWFWZ1VpdEw4VnFRU2k5VXUvcisr?=
 =?utf-8?B?NXNKYXhyN0FjUHVyeUV6VlpudWFrQVNyR1hVS0ZVdDIzb3FvdURpdGhMc2dy?=
 =?utf-8?Q?eG2X3m6UQmSE8W2T4HMsy6o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ee2bf5-1007-4b67-f2c2-08daa2f99c71
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 15:36:58.3972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqhUjnqX+TNkS0GqaRL3ilRsls2YVrC3IWRih3xLtRcL/fOqHS8l0yUso57zO9vQNuVVxZ3isSgInfDZ3BRzTvc5w5ll8XFWGHJ5ilaMwjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209300099
X-Proofpoint-ORIG-GUID: ffJb4f_w1lEfxkpApBgXTfuMDQtTZ8Xh
X-Proofpoint-GUID: ffJb4f_w1lEfxkpApBgXTfuMDQtTZ8Xh
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/22 11:07, Borislav Petkov wrote:
> On Tue, Sep 13, 2022 at 02:12:31PM -0500, Eric DeVolder wrote:
>> This topic was discussed previously https://lkml.org/lkml/2022/3/3/372.
> 
> Please do not use lkml.org to refer to lkml messages. We have a
> perfectly fine archival system at lore.kernel.org. You simply do
> 
> https://lore.kernel.org/r/<Message-ID>
> 
> when you want to point to a previous mail.

ok, thanks for pointing that out to me.
> 
>> David points out that terminology is tricky here due to differing behaviors.
>> And perhaps that is your point in asking for guidance text. It can be
>> complicated
> 
> Which means you need an explanation how to use this even more.
> 
> And why is CONFIG_CRASH_MAX_MEMORY_RANGES even a Kconfig item and not
> something you discover from the hardware?

No, is the short answer.

> 
> Your help text talks about System RAM entries in /proc/iomem which means
> that those entries are present somewhere in the kernel and you can read
> them out and do the proper calculations dynamically instead of doing the
> static CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES thing.

The intent is to compute the max size buffer needed to contain a maximum populated elfcorehdr, which 
is primarily based on the number of CPUs and memory regions. Thus far I (and others involved) have 
not found a kernel method to determine the maximum number of memory regions possible (if you are 
aware of one, please let me know!). Thus CONFIG_CRASH_MAX_MEMORY_RANGES was born (rather borrowed 
from kexec-tools).

So no dynamic computation is possible, yet.

> 
>> , but it all comes down to System RAM entries.
>>
>> I could perhaps offer an overly simplified example such that for 1GiB block
>> size, for example, the CRASH_MAX_MEMORY_RANGES of 32768 would allow for 32TiB
>> of memory?
> 
> Yes, and stick it somewhere in Documentation/admin-guide/kdump/ and
> refer to it in that help text so that people can find it and read how to
> use your new option.
> 
ok

>> The kbuf.bufsz value is obtained via a call to prepare_elf_headers(); I can
>> not initialize it at its declaration.
> 
> Sorry, I meant this:
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 8fc7d678ac72..ee6fd9f1b2b9 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -395,8 +395,9 @@ int crash_load_segments(struct kimage *image)
>   	if (ret)
>   		return ret;
>   
> -	image->elf_headers = kbuf.buffer;
> -	image->elf_headers_sz = kbuf.bufsz;
> +	image->elf_headers	= kbuf.buffer;
> +	image->elf_headers_sz	= kbuf.bufsz;
> +	kbuf.memsz		= kbuf.bufsz;
>   
>   #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>   	/* Ensure elfcorehdr segment large enough for hotplug changes */
> @@ -407,9 +408,8 @@ int crash_load_segments(struct kimage *image)
>   	image->elf_headers_sz = kbuf.memsz;
>   	image->elfcorehdr_index = image->nr_segments;
>   	image->elfcorehdr_index_valid = true;
> -#else
> -	kbuf.memsz = kbuf.bufsz;
>   #endif
> +
>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>   	ret = kexec_add_buffer(&kbuf);
> 
ok

>> I'm at a loss as to what to do differently here. You've raised this issue
>> before and I went back and looked at the suggestions then and I don't see
>> how that applies to this situation. How is this situation different than the
>> #ifdef CONFIG_KEXEC_FILE that immediately preceeds it?
> 
> See the diff at the end. I'm not saying this is how you should do it
> but it should give you a better idea. The logic being, the functions
> in the .c file don't really need ifdeffery around them - you're adding
> 1-2 functions and crash.c is not that big - so they can be built in
> unconditionally. You'd need the ifdeffery *in the header only* when
> crash.c is not being built.
ok; I've overlooked that scenario.
> 
> But I've done it with ifdeffery in the .c file now because yes, the
> kexec code is a minefield of ifdeffery. Hell, there's ifdeffery even in
> the headers for structs. Ifdeffery you don't really need. Someone should
> clean that up and simplify this immensely.

ok

> 
>> Currently there is a concurrent effort for PPC support by Sourabh
>> Jain, and in that effort arch_map_crash_pages() is using __va(paddr).
> 
> Why?
> 
>> I do not know the nuances between kmap_local_page() and __va() to
>> answer the question.
> 
> kmap_local_page() is a generic interface and it should work on any arch.
> 
> And it is documented even:
> 
> $ git grep kmap_local_page Documentation/
> 
>> If kmap_local_page() works for all archs, then I'm happy to drop these
>> arch_ variants and use it directly.
> 
> Yes, pls do.

I'll check with Sourabh to see if PPC can work with kmap_local_page().

> 
> ---
> 
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 432073385b2d..b73c9628cd85 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -205,6 +205,17 @@ void *arch_kexec_kernel_image_load(struct kimage *image);
>   
>   int arch_kimage_file_post_load_cleanup(struct kimage *image);
>   #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
> +
> +#ifdef CONFIG_CRASH_MAX_MEMORY_RANGES
So I think the use of CONFIG_CRASH_MAX_MEMORY_RANGES is not correct; it still needs to be based on 
the cpu or memory hotplug options.

> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
> +void arch_unmap_crash_pages(void **ptr);
> +void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action);
> +#else
> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size) { return NULL; }
> +void arch_unmap_crash_pages(void **ptr) { }
> +void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action) { }
> +#endif
> +
>   #endif
>   #endif
>   
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 8fc7d678ac72..a526c893abe8 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -395,8 +395,9 @@ int crash_load_segments(struct kimage *image)
>   	if (ret)
>   		return ret;
>   
> -	image->elf_headers = kbuf.buffer;
> -	image->elf_headers_sz = kbuf.bufsz;
> +	image->elf_headers	= kbuf.buffer;
> +	image->elf_headers_sz	= kbuf.bufsz;
> +	kbuf.memsz		= kbuf.bufsz;
>   
>   #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>   	/* Ensure elfcorehdr segment large enough for hotplug changes */
> @@ -407,9 +408,8 @@ int crash_load_segments(struct kimage *image)
>   	image->elf_headers_sz = kbuf.memsz;
>   	image->elfcorehdr_index = image->nr_segments;
>   	image->elfcorehdr_index_valid = true;
> -#else
> -	kbuf.memsz = kbuf.bufsz;
>   #endif
> +
>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>   	ret = kexec_add_buffer(&kbuf);
> @@ -425,7 +425,8 @@ int crash_load_segments(struct kimage *image)
>   }
>   #endif /* CONFIG_KEXEC_FILE */
>   
> -#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +#ifdef CONFIG_CRASH_MAX_MEMORY_RANGES
Again, I don't think CONFIG_CRASH_MAX_MEMORY_RANGES makes sense, at all.

> +
>   /*
>    * NOTE: The addresses and sizes passed to this routine have
>    * already been fully aligned on page boundaries. There is no
> @@ -462,8 +463,7 @@ void arch_unmap_crash_pages(void **ptr)
>    * is prepared in a kernel buffer, and then it is written on top
>    * of the existing/old elfcorehdr.
>    */
> -void arch_crash_handle_hotplug_event(struct kimage *image,
> -	unsigned int hp_action)
> +void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action)
>   {
>   	struct kexec_segment *ksegment;
>   	unsigned char *ptr = NULL;
> @@ -513,4 +513,5 @@ void arch_crash_handle_hotplug_event(struct kimage *image,
>   	if (elfbuf)
>   		vfree(elfbuf);
>   }
> -#endif
> +
> +#endif /* CONFIG_CRASH_MAX_MEMORY_RANGES */
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index a48577a36fb8..0f79ad4c4f80 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -27,6 +27,19 @@ extern struct resource crashk_res;
>   extern struct resource crashk_low_res;
>   extern note_buf_t __percpu *crash_notes;
>   
> +/* Alignment required for elf header segment */
> +#define ELF_CORE_HEADER_ALIGN   4096
> +
> +struct crash_mem_range {
> +	u64 start, end;
> +};
> +
> +struct crash_mem {
> +	unsigned int max_nr_ranges;
> +	unsigned int nr_ranges;
> +	struct crash_mem_range ranges[];
> +};
> +
>   #ifdef CONFIG_KEXEC_CORE
>   #include <linux/list.h>
>   #include <linux/compat.h>
> @@ -237,19 +250,6 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
>   }
>   #endif
>   
> -/* Alignment required for elf header segment */
> -#define ELF_CORE_HEADER_ALIGN   4096
> -
> -struct crash_mem_range {
> -	u64 start, end;
> -};
> -
> -struct crash_mem {
> -	unsigned int max_nr_ranges;
> -	unsigned int nr_ranges;
> -	struct crash_mem_range ranges[];
> -};
> -
>   extern int crash_exclude_mem_range(struct crash_mem *mem,
>   				   unsigned long long mstart,
>   				   unsigned long long mend);
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 5bc5159d9cb1..f6b5d835f826 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -622,6 +622,15 @@ static int __init crash_save_vmcoreinfo_init(void)
>   subsys_initcall(crash_save_vmcoreinfo_init);
>   
>   #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +
> +void __weak *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> +{
> +	return NULL;
> +}
> +
> +void __weak arch_unmap_crash_pages(void **ptr) { }
> +void __weak arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action) { }
> +
I was asked by Baoquan He to eliminate the use of __weak, which I did. I followed the technique used 
by other kexec infrastructure.


>   /*
>    * To accurately reflect hot un/plug changes, the elfcorehdr (which
>    * is passed to the crash kernel via the elfcorehdr= parameter)
> 
