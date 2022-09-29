Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5ED5EFF28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiI2VP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiI2VP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:15:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8F3C843B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:15:55 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TKTSGm022884;
        Thu, 29 Sep 2022 21:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/s2Gmcf8m73Ll1WOoH22hMHVSoa5vMf33isZVj99vv8=;
 b=M4AA3S/uGUusSptCkXGyLDgziQ7VRXyiPd8P7fGi3rkuJv1dt1+f0ImCQgFOmGd/FOv2
 l3ZorxCe2vNJ4t1y4ngCnVdpgfDOUEUNwjTXGdDftY75QP/xa7IWiI5Ra6O0AkGonLgL
 FdTqLLnkuLIYqWo9HZsZ4HBsBKU4KNRoR8fEoPX9dYleKdmpL7Qpy8m20UcP4iCBLy0X
 wQh9+3lVwy+FytLT8Nvi2W7KGHkt1Az20ruCDLOXA8heakPF8B2oMJnh/c3KWQQvNGTI
 HtgVBg8MfAlyREZvcR7RYPOhLbK61c2gHHQa13eZIT+WEKaKaGvtqt6RoBX07K5ZgaQH nA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jstet6kk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 21:15:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28TJYgGP033592;
        Thu, 29 Sep 2022 21:15:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpv37mx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 21:15:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORTGP1220++4YOQVgD+AsMNab1DkseN+T9QgItKi7d2BlHmhHKFaYf8+n1513SSHlrvP9WD01YSRc7lOmqTcvyk9cubXAhROqB4plHnqVcP8/7+ixCh6kcKFjpzvBig+R+RhTxVLCiIO8iF7+yRg+PyhBJ+ugH2KjyOeDuWV4HyZzt4yX4EC5vE/GS5pzdYYZUkJidcpTvdb1OyvWgZuPMRQmRauT402Y01HoVCU8AC3gGB1BNNEidRI6ghluJENcx5NNI+3r0GdIzX/66jgm4wezRn1J1HAZXHB89WjxpXchX1FKu+R95Rf307HDOagnkLIeRGzRVyHkKu+G88DUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s2Gmcf8m73Ll1WOoH22hMHVSoa5vMf33isZVj99vv8=;
 b=EJ0Yv9uppapSR5HUReWHB7xbMKgBvT2mBgQK5OCh7IbcMquE/sho6KSBDeE+iPEm9cw4xfmC089SLYo20zp4TFdy7gzIdbmYk8+6RqzmQchu4JKIvf6qoFQ0J3ZUHjSaRDgTaY3Oz7+afV/V6umAUEkK/6krlmYhqITV5V++B8mGTjDg4uCZMr+ftwJkL3L+udhZdUfhOwqk8lNe5OeoIO0ClQdApr8PX0qisnPN6/hFHLz6BIdWqB3VVGKSysBE+9SwmKmgLLUMmsSOi2fBKF3UTLTBQrWpvXnn/+ETbhNHInG5OddVmovy1HErl5eev0AK0wzNkSITFYPW919MkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s2Gmcf8m73Ll1WOoH22hMHVSoa5vMf33isZVj99vv8=;
 b=T2U7S6nP94nS5107cQt82hMnCcUza5YzioxZ56gafwqlBSTEYfqUVZoIKw++ABc30GlUSAA2b100DHhgAe5mQvbpzTfa9On1dPplbKWixlzv1M+g7kYArptTUcdZe/sK84mZ+qW7GKFvaH587BH+FGHporIgc7dLtV61ijeDTRM=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 21:15:30 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::3f0a:50da:af84:7a35]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::3f0a:50da:af84:7a35%8]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 21:15:30 +0000
Message-ID: <f2778291-38a8-457f-d61e-0f9f7d401075@oracle.com>
Date:   Thu, 29 Sep 2022 16:15:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        John Donnelly <john.p.donnelly@oracle.com>
References: <20220929180413.107374-1-longman@redhat.com>
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <20220929180413.107374-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:74::20) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4722:EE_|SJ1PR10MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 2547aa02-0223-46cf-c171-08daa25fbcc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YE5MCOsKfsrnhsg1JosJLIotVeLgWar6ZPcGY+fJDRDzHcvv6nbN5NkwtCeXxb7lsaMVeT//CstUasxotD6lD6d9Y/M1Ew2fohj0jvfAsPPhjK/ftIPGR4qsIln6L1qPEghVQl6HNO/KV1wZ9HSrpPk0siB5sS3+qteBuOyewF4P/HoGYttEVB1JAuVCqF97ojuwO2PlThbfNvFRhaOfv8XOXIau8mi/1SSJQudLhewPlbnvIkGXwQzKBv6rPjVRXVbZZBl+kFrljfEU0cf8+uEKBN6mA17EqhsBQGLV4Im/mDBZrohZt5jCLLlV+Bd15C7Ww/UoTJ8f+sIoM8WBH+TEGQvSVMIl7ZSPAYB03c0VIkHfVehAsMenjoyUfkm165I19/8W2AlNCBmxcaxofWWkeI57buqWefCL0tDmr2KOo7GSl01s05Hp4Aom6GMa6uyD6YCJItf2Yiw1MxTGP8mQJuxTXc7gn05EprjTZHduU9r/vkiTyPIHKJO+DzcIbmOAsQNYzXIn+aQ4SG6rxy5ckBiuDIIaqZCr95yEMNL9sS8HVVSf5vQ2mJiUEhwdv826KJTWBUj5Lsk1/cHha3w1thqq/xnc+VCf+EexrjUc6N5Pe2AtAupaWOHtD3qpQDyznSU3c9cDljzyr8CLca/yppV/CxPwIlqo3mVak+flpsJKdpPCauzVgEIlC3c4WeF1BoTleo+bDLeQKuhc3UitHLuiS7Bm8ncQVEeZJrBeLRMAY9TLV+MoFRiezUNjS3R693cyvYzE8Jn9jmsHWo46VElPXLN4b5WBX2/70a4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199015)(83380400001)(38100700002)(6512007)(2616005)(5660300002)(41300700001)(2906002)(8936002)(478600001)(26005)(6666004)(53546011)(6506007)(107886003)(66556008)(66476007)(6486002)(66946007)(316002)(8676002)(110136005)(54906003)(186003)(4326008)(36756003)(31686004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2dHWUtTRGlOZWNMOC9hNnBDa3VXOWo4Tlo2OXJwakRjNUZVVUcvZ3YwNTky?=
 =?utf-8?B?V1NEVkE3NnlpR21HWU1vZEpQUERnKzI3TXpvWWUzb2RFdUp2WEZLaHZSS3hX?=
 =?utf-8?B?OEpkUjJPSVI3OXVIRkxEa1NqU3ZlNm92VEVnUCs3dFVxb0g1Kys0L1ZPREFs?=
 =?utf-8?B?NDJQTmJ4UUtlVm40SHkrMjdHSGdES0o0Rm9mTXg3K3lHWjBGQ0lCT3pYM3hQ?=
 =?utf-8?B?Z2tYTEJnK2d5TXdrK2JPUG1Xc1RRYm56b09kdVZkMDhOS1ZIcExLcGR3STFo?=
 =?utf-8?B?TzBxY3NDVzhYSXpkOHBwOGtlYTl6R1gzUDFaeGw1L1ZnWjJuTkpHbEVvUngr?=
 =?utf-8?B?SjBKK3VVQmN0MkovUGdNOVlJVlNsMS9nSzBxUWdheHlVb3hrSWFuZThLWXI2?=
 =?utf-8?B?ZkJNM0MxbWFjZmNoVHM2bGdBNHFBZlcvN29jQzNPdGZoYTRGaGwyZmpFTWtM?=
 =?utf-8?B?aHFkKy8xUE5sQ0tYaTBKeVZOQmh0OGtBODZTa1ZvTmJ4aDBHRFlpd1U4K09r?=
 =?utf-8?B?VFRGNTVSOUNIN2dFZS9IQWludDE4eHgyZGo0L0N0MUJ3NTFFcjFDN3B1QnVM?=
 =?utf-8?B?L0hUVzkrL3pLOFhVOEtsWlZTZlRQMjQ3dmlBVk9CWTJzSDNpbCtneU5qYlpl?=
 =?utf-8?B?QWMrbEl5SzdTVUZ5eXVGYzNlclp3dVNuVEV3UkN5OUNRT3lTV1NvNURuMGx1?=
 =?utf-8?B?UlNNclh1ZE8wajhDcERheml6Ti8wNTlDaFRNOHhCVlBicWlPV2dBN1p5TTVn?=
 =?utf-8?B?Y2RBT2lUQi9vZ05ZcjN2bDh3ZGh6Y1l0azAyRVVmckNtaWI3c05SajlodTFS?=
 =?utf-8?B?K0JWR01UK0dFVTI3VmNmZnkvZVZXVWNISHRlWXQ5TG12SVRKYXk2NUpuMTJh?=
 =?utf-8?B?bzZSSkRmL3MzSmw2TmZVYTFUa1lXNW0vbE1kUi9weGxiYWJySkx4SWhISDJo?=
 =?utf-8?B?cXFjWjAvREh3TUEvVVdkNXRoOHFPUk9Od09RVEozYWdYZkpNVGZpSTdiMkFi?=
 =?utf-8?B?S0NlSVd5aEVVTFphZWc5bWJEbjVmcE1BSS9VcTdyR281KzZwWTZiS1RSamFN?=
 =?utf-8?B?cFdqNGtySFlteXVzaU1NMWcvZkFMVDdnbWgrekZsL21PUHlHODMxYlJTN245?=
 =?utf-8?B?MEJMUFJFU1E1L0RIR1Urdys5UTBrbTlMOXp4WGFsNkFpazJQa2ZZaUxUaUpU?=
 =?utf-8?B?cnVTMVNiV0g1VHJsWDRoa1hQN0EvdlY5OVBJa3lpK0VYblNZdnMrdXN0NVMw?=
 =?utf-8?B?dHZIVFpCcVV0UnB4ZE96OGhSeXo2eUk2ZXM4eU9YRnRoVDl1ZzB5dVIyZTRG?=
 =?utf-8?B?K3hUUndieEJ0ZGpZeVdnS3dtRkFJNFJLbG1LcE9SN2doSzNuZkVHUWc5KzQ1?=
 =?utf-8?B?UDNtWWZiOTYvbDBER01qRmFGYjl5RGZwT0hHUkRNU3g0N0FYRVArY2Y1MFFr?=
 =?utf-8?B?Y3J0ZjBYM0taRzJvL291RSttVGVWYU9RU1FZYlJGZlpTb0FjK2hvRmV3bHBV?=
 =?utf-8?B?NUdpeEFqVys5MExHR09kaE00WTd6ZUh2S1BIcGlxODZIeW9mcURMMVRveEN4?=
 =?utf-8?B?MHdnVkVuQXBmUHcrWWE0YnJ2OFArQi9MVkQ0M2NBam43R0FpZUpXaHpuMFRB?=
 =?utf-8?B?b3hXZzBrV2F0bWVQWTlHeEsxUnVEbVRpbnR0NlU2Ui9PMTlKbnliMUF1ZzVV?=
 =?utf-8?B?L3lMTkFBMTVvVElmZS9FcU80TlFuVmhqbTV5N1lWUjBVSTJXb1o1T1F3SUdD?=
 =?utf-8?B?NGJkN1VGMWNVaC9MeStOa0FEdTNvd2VBWmtzbjJhVWMvdGVHckhWVjM4NU9Q?=
 =?utf-8?B?ZmEwbkt6WStaRlo3d1FpZGdxNkREMG4wZXBpeXJvTmd3QWhHM29leWlhNGJv?=
 =?utf-8?B?LzBXRzhSODExbmVWeDdiYzlySzVLcjFGUWFNcXgyUi9vQU80MThmQ2JJejMz?=
 =?utf-8?B?ZjErU1VPcnNzamlYaklVUlVwOWVoblREbERlUXNQQXJSU0hBRWZVU25sQ2cr?=
 =?utf-8?B?MXNSTFpDS0Z3dlM0U3JtdXFNOXJvQXNESXZJK2lRQ01oaGtVejRtMENaenZa?=
 =?utf-8?B?Z1dJZVZjMFNsU1RZZjJJN2tKZzB5b0piVmphYXk5c1V0T3dhaUZrZzBNNDVU?=
 =?utf-8?B?ZDI1bXhndWZ3Z1dTdVRHYUJSeGlicW5ERTg0WmNJSGM0YjU5WHhBQnoydmZT?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2547aa02-0223-46cf-c171-08daa25fbcc1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 21:15:30.0316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mzvOGbSiazAkDa8VeeHcOCB7zkRVb7wkRQcBdzUOUMxZFVlb1FEJ2QBtejT3eH3LrxWu01QTjz1FHyetmseyFCVgeFKjjt4v2jDP1SG3fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_13,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=990 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209290134
X-Proofpoint-GUID: a_tElrLNLHcTX0E0Jt95BNCtfHaiirEL
X-Proofpoint-ORIG-GUID: a_tElrLNLHcTX0E0Jt95BNCtfHaiirEL
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 13:04, Waiman Long wrote:
> A non-first waiter can potentially spin in the for loop of
> rwsem_down_write_slowpath() without sleeping but fail to acquire the
> lock even if the rwsem is free if the following sequence happens:
> 
>    Non-first waiter       First waiter      Lock holder
>    ----------------       ------------      -----------
>    Acquire wait_lock
>    rwsem_try_write_lock():
>      Set handoff bit if RT or
>        wait too long
>      Set waiter->handoff_set
>    Release wait_lock
>                           Acquire wait_lock
>                           Inherit waiter->handoff_set
>                           Release wait_lock
> 					   Clear owner
>                                             Release lock
>    if (waiter.handoff_set) {
>      rwsem_spin_on_owner(();
>      if (OWNER_NULL)
>        goto trylock_again;
>    }
>    trylock_again:
>    Acquire wait_lock
>    rwsem_try_write_lock():
>       if (first->handoff_set && (waiter != first))
>       	return false;
>    Release wait_lock
> 
> It is especially problematic if the non-first waiter is an RT task and
> it is running on the same CPU as the first waiter as this can lead to
> live lock.
> 
> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more consistent")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/locking/rwsem.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 65f0262f635e..ad676e99e0b3 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -628,6 +628,11 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   		new = count;
>   
>   		if (count & RWSEM_LOCK_MASK) {
> +			/*
> +			 * A waiter (first or not) can set the handoff bit
> +			 * if it is an RT task or wait in the wait queue
> +			 * for too long.
> +			 */
>   			if (has_handoff || (!rt_task(waiter->task) &&
>   					    !time_after(jiffies, waiter->timeout)))
>   				return false;
> @@ -643,11 +648,13 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
>   
>   	/*
> -	 * We have either acquired the lock with handoff bit cleared or
> -	 * set the handoff bit.
> +	 * We have either acquired the lock with handoff bit cleared or set
> +	 * the handoff bit. Only the first waiter can have its handoff_set
> +	 * set here to enable optimistic spinning in slowpath loop.
>   	 */
>   	if (new & RWSEM_FLAG_HANDOFF) {
> -		waiter->handoff_set = true;
> +		if (waiter == first)
> +			waiter->handoff_set = true;
>   		lockevent_inc(rwsem_wlock_handoff);
>   		return false;
>   	}
Hi,.

Are you missing


[PATCH 5.18 87/88] locking/rwsem: Allow slowpath writer to ignore 
handoff bit if not set by first waiter



Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
consistent")

Or is this another regression ?
