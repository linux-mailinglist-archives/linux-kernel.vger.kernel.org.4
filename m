Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330AA614F91
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiKAQl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiKAQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:41:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BA7B2D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:41:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1F6BKK004310;
        Tue, 1 Nov 2022 16:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jY9WJXM/rtyUK3etsuCp+FlEEYxrQfE53KtFq+hMZHA=;
 b=u7UW9vCJW+ChZWzADbYgLLAC/cNmZ8FOvE4V/xr42ssGRCYR8HSZwJAZ6q9Pha7uAffU
 Jo+YA62J39MSX4BRxHpWoDZe++dV7IWPXVbmv0/nXWI2Svbyjb/VUEjyXXNKgfWxlz8s
 rTgyMllkRQ97x5ToB4uJSq8IiDrCRxLA62dMlzZZpSZq5tQkgj+2aQR4QeNDHvmQj71f
 IyPX8LDjbW8ZlY04IfEkSxQeDitphYXxzbgGqwvPP2dhb9r7Sogv+SD8gbtO1nHj46fp
 7zIcythntQayU9BSZDa0x2wT0ZTePpue3CqGOlzCrokyltq0DKbqiVxxWN6Y9l5rpJl/ oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty2y7j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 16:40:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1FbppJ002955;
        Tue, 1 Nov 2022 16:40:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmap699-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 16:40:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmpN7SVRzHAXXG/wV/zwcGXHjSC7WC3/imd2Ch5pOHVH2FDKYrl6COY7h3vtFraNWFPa2tepXdz3Hwnp4Z5ofMzNFeTd94apyHzA9jnxhvbTDSDq7UNpJB4JBbC1mz5k6y1Ax5v4JhNT9+IziaMSc2dOfNTTPqBK5+/SLEdyRUXyKXs7TpL6rEtLm7DC3Q9HISinrOO0OMcqmpZNpZk3WofpZmC9gq2dKY2BbDdAr7GTFAFRsNS6BrjlT2Cup2BOtD7a2FtsngChIM6xLLGVUbXVS8FGNZRPsyVi5151GPzV/5ZVXNo3aX6Qg80wDwcwNyTJojesPKpEdeF/1mVKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jY9WJXM/rtyUK3etsuCp+FlEEYxrQfE53KtFq+hMZHA=;
 b=EEN3DzbIgmPtHfFym6hDTd8ToRmBQTDAEXUylDUehVUQn/EI7QqD5qQL1ssjglDsAIvaDMvqXay7WJpvHFiIKXMGMBpmafyUY1CTF42CDwiRFLyEfXjPVgjWE2qQxGcTuivVGVHyxBhhck7q2IZ2LzLIX1vei3uDUc6d6YzE6Zu2kHHLlsz3YBZgQpX4tWhoUZuAyfXiqIbwXawEiKy5Sb1qeiRCznbIgMg0R7y/RtCseQm6lh0Sbft8HTfSWSRtBmMXAFaeHK6Xsrck+fZvNoXJHyMPTgTSaWMqaOuoI35NyQLZ/tAGvKvS7TGAZsPoSgKfp1zT0zo6phyzGJg/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jY9WJXM/rtyUK3etsuCp+FlEEYxrQfE53KtFq+hMZHA=;
 b=pP98qFquuwZV6Q41pQn5bScFl97GrwodefvOqcBeFPHZ2PH5+nfMWvk6N69el/hqh6S8u24dzleqoAYW9iKb6xG/9nRxs5saRAFdNddtgKuMrDNdItUmR8+ci6SCyEU2xstfDUEqdaDcmSGwduaf9hPmpEtF+Vl5nvi7aA8uJd4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6658.namprd10.prod.outlook.com (2603:10b6:930:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 16:40:52 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 16:40:51 +0000
Message-ID: <596b78f8-1630-5379-0b6f-8666a569ad8b@oracle.com>
Date:   Tue, 1 Nov 2022 09:40:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/9] mm/hugetlb_cgroup: convert hugetlb_cgroup_from_page()
 to folios
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
 <20221014031303.231740-3-sidhartha.kumar@oracle.com>
 <Y1/0IOuAyu12/C9o@monkey>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Y1/0IOuAyu12/C9o@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::27) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e8fbb0-52a4-48bd-e07b-08dabc27d633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPKb5LQmAol8HRsY/W7NwlU7p/9rhGhXGLNWZppTvcqr3k0BfQlfLtSXVVDFmuchq2KrEnRCsRJnVYtymhcJHClJhwERedvs1VKevyGUP9Qj0iOeRLnpASvEUCgfrofAliYo654ggdiG1BOzhMr3Md76LxCXP2acaBaCNR69TTGmKNcTtGuFMZbQT6to1qPpyCOuG/ovnFW3NBwrIYtq/jffQfbJUYvMHSaDN+uaK51sjxb2qo/m/fkZI0B8VSoF6iK6mi/rQ6TzQqq/t85PVKsRSUBhFSgCAbyVp/7ismm3/FeHeZHilSZe0SFbfxLQZZXMggvduBBzT2bONZyJH0erYmctpNcesnLFUXtBUkG2qlhTBD9kIj3ig3kpQAttQnH/VzAl2vyG2/T74f1RDEzYbo4PqD88pfUU78YVyYzUaciLU0KTDXvokmQLZqSq3RZcw+riLAryGHo88DqlCJ+POYgfYBlckHYESyMcAEOLXWCWwH4rY5J1snG2P73pKr66I8jf12J+mf64mD2E3BbcyVOrh4oc4t9OkeTk88hU2fNbT3cPzcDAP6awUrecnn1ndehqDEbtK8NqGkcWwqE+iRcuI9wmp4RylByzriWaRq28sV8IfQKm5iFRsVFY0Z3LTOL4skbfTzifgAaAmRR/shxbiRjMqjSoGmuOZwPuN0KglYMIZj3Sj42MRQsGGZ/pZitbW9Tlt1wL90V0Jo13KyGClaaUAvR+Cbim238I8eyvMh2iQAdhVStHkdRJkA6HgD1ypzaY0rMGAsp0HfdUO/r+eRSQgmmCKifkbVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(6666004)(6506007)(2616005)(6512007)(186003)(53546011)(26005)(478600001)(83380400001)(2906002)(44832011)(316002)(66556008)(6636002)(66946007)(37006003)(6486002)(66476007)(8936002)(8676002)(6862004)(4326008)(5660300002)(41300700001)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym4zeVA2Z2lkY20rSkFpZ0ovTmtmdkpzRG5mVWpKV3plSmZScHNGc0h3N1Zi?=
 =?utf-8?B?Snp0eFhZQll2NVNlZWF6bVFCV21vTzIzNkJmZjVzYzZMcmwxdkl5aEc5TjFj?=
 =?utf-8?B?SDBJMXFLK2wvWklybVJhcDNxd3h1dmUzWEMrV0dvSUx6VnRueXdpNUhlLzRv?=
 =?utf-8?B?T05ELzRvdU1yS2FkOWkyVzg3N3AwKzR3MnA5UmxpbzBXQVR2Z0ovbWhIL2gy?=
 =?utf-8?B?d2JVTTNhc2dwMzBIMVNXNWEvVXVPK1M1UjFTZFF4cWxFSHp3MFVVY1Q5UURj?=
 =?utf-8?B?Yk5aemc3eHdCRFo1VUxKSTd2TDhwWUM4NTRXeEs4WktrMzhlTUhRUHhScUh4?=
 =?utf-8?B?UWpvUkErOG8zQWsyUENjbWRuWis0ZUh0TFBScFA5M1g0aHRrUVordGxJNHpR?=
 =?utf-8?B?WnRQSXc0RFVQSDdOTHJUU0l3Y0g5TjhhOFYybjJ3RXFQNjBFN084QnozWjd3?=
 =?utf-8?B?Wk9RSUxkSTRVREhKdGxSRkNTQTltY0l0RTB0RW4yQ3pYVlMvSlZ0UEdtOExh?=
 =?utf-8?B?aE5GaStXV3hPbi8rZlBjeGgrQXhlU3lpaWVFWlVhY25TM01sRk5XKzlGMUlm?=
 =?utf-8?B?ekRPS2plUmtjK05LTzh5cXh1VVcvMktsaXFFUzZvYnV3bU5QaEVETGdBMGRP?=
 =?utf-8?B?SzUvRHZESHhGTkV1ZnZ6bzk1MnBtOHJDZkdVbS9oVHpCNUxVcVJJbnROMzJE?=
 =?utf-8?B?eDJMeUtveTlTSUpIODJpZlRoeE1Md1EydElTT0s3Mjhrd1lxczZoeXByT3Bn?=
 =?utf-8?B?akIxTzQvZ2VsRGxpSDgwa1VHUE5pV2RTVS9KQ09xV0dydC9BY2hNbjhIOFNh?=
 =?utf-8?B?SGVEV0Urb214QTkvTmJQUGxkOVBXQ1FONVBkaVNjUGZUeE9HMm05bTc1bjRu?=
 =?utf-8?B?blJkbTVrV3FPZDNseTQwQVdjOG9qL1p3TVk3TGVhZVBhWk5ZQVdXazZ0TlJr?=
 =?utf-8?B?a0FBdEk4WnNrWVVCZ2ZCQXdrM3FnbXJ2V2tQbnBWYjYwYjlYRkZuUGxjMGlv?=
 =?utf-8?B?b2FTelNhYWNIVklvbFJnMGtsUGd0bXFiSDBPZ3hTdFgyVUVoNXB5a0NvcFA1?=
 =?utf-8?B?S0dQNDRWNjYrMEVuOENPSElxZVVJRWFGdVZJaEJKeWdvYUxOQ2oyM3dOMUxP?=
 =?utf-8?B?Mk9Tc2ZKUS80S3pqRytGUm11c2dOby9yVHplNVV0MWMrdWpYTk5hdFBXbXZs?=
 =?utf-8?B?TWxOaUNzcmp5eUZMR0RIT3o1dU1hN0dsd1JXM1dDSkRVaERSYXNlekMwb3BB?=
 =?utf-8?B?L2Q4TGRjRGNtU3ZGQ1pNVHA3UXlTQ2hTV0NCNXFvSlZhWG01cng1Z1BSWThM?=
 =?utf-8?B?ZG8xVlM5amFhZjdKWVorMjYyaEw1Q0JXK3dGejhzb0lMNkRHN2QwK3lwOXpG?=
 =?utf-8?B?N3dGZmExRzJXQkxJalZHRk9ZTjBRMUkrMHhVaVcyOS9GRkkyaFNNTm5KUFpF?=
 =?utf-8?B?NlJIZ0syTVQxb3EvSXRKTU5UT3J2VGJXOFVzWFNwYy9nQ3BSdFZDa3JSa2Mz?=
 =?utf-8?B?OXRqSTNsQXY0N0hEbndXN3YvOG14TXRIUkZrMHVOTy9HS0dlN2NQVlM5VEhY?=
 =?utf-8?B?cnFyWTJUdVpUc21ZRmdhd01RZS9KZFpTNS81RzZzaFJya1hqM3VxQmtkRytt?=
 =?utf-8?B?UGtKM2ZKbWp5TEs5ZGlsTGlXVFpIc09RVmMrSTdQVVJmNk81VUpjNDA4NFI4?=
 =?utf-8?B?TFFIejlqdmQ3S25PNDU3UE56OWdVWWFjZDdiOUVlM1RxNmJtQzY4dkR0eFkx?=
 =?utf-8?B?QU9yMTRDMTRNdHRnKytQZVpWb3RKUENNWGx4bHE3SHFEL0hBVndGNi9HQXkw?=
 =?utf-8?B?K3RSZGJSTGhMWkt2STRTdlc1UnEzNjVtTXVHQThoZlJqQm5qbVc5b3JsbnNP?=
 =?utf-8?B?a1dxWktta3hyQ0ZOSG5DS1ExT3RhZ1NrTkJSVG9GZllnRXhSeC96QnU2bVVu?=
 =?utf-8?B?cHRBa0tkc0JhemlWb1U4SUNzRXlHZ2YxejRyWnJMaDlwbEpTNUlZUDNkd1JD?=
 =?utf-8?B?Y21sVnFIR2dnTlRIVVg3dzdUOCtnYVp3NzkxSjVjQktFSEM3bC9RNlNDMCs2?=
 =?utf-8?B?V2JwMDZRNUVEczlHcGZtbXdjeXNKVWEyVXJHS21EK0JMdjhTUnZaK2luVEFN?=
 =?utf-8?B?aDd2SnJPRVpiTVlCRjNwb1Vha3JBNS9OSXNOYVd4dkJ2QklMYmJXcFR3WHFE?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e8fbb0-52a4-48bd-e07b-08dabc27d633
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 16:40:51.2628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcoZOm9QAkFSKxBvEKv3mfDycfvJtyE0KAwS0HiqbODzKZi37ZaMV/8DudyzFYfsZAWb8y9HopcjN/AyUXp6dn6ISI23TVf/hNXS19qllbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_07,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010124
X-Proofpoint-ORIG-GUID: OXtfB-2N7RFWT9oPG9QrVgFzgFQBVfWG
X-Proofpoint-GUID: OXtfB-2N7RFWT9oPG9QrVgFzgFQBVfWG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/22 9:13 AM, Mike Kravetz wrote:
> On 10/13/22 20:12, Sidhartha Kumar wrote:
>> Introduce folios in __remove_hugetlb_page() by converting
>> hugetlb_cgroup_from_page() to use folios.
>>
>> Also gets rid of unsed hugetlb_cgroup_from_page_resv() function.
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   include/linux/hugetlb_cgroup.h | 39 +++++++++++++++++-----------------
>>   mm/hugetlb.c                   |  5 +++--
>>   mm/hugetlb_cgroup.c            | 13 +++++++-----
>>   3 files changed, 31 insertions(+), 26 deletions(-)
> Changes look fine.  However ...
>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 4133ffbbeb50..bcb9bfce32ee 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1434,9 +1434,10 @@ static void __remove_hugetlb_page(struct hstate *h, struct page *page,
>>   							bool demote)
>>   {
>>   	int nid = page_to_nid(page);
>> +	struct folio *folio = page_folio(page);
>>   
>> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
>> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
>> +	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio(folio), folio);
>> +	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
>>   
>>   	lockdep_assert_held(&hugetlb_lock);
>>   	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> ... there is also this a little further in the routine.
>
> 	if (HPageFreed(page)) {
>
> Should probably change this to?
>
> 	if (folio_test_hugetlb_freed(folio)) {
>
> Or, is that part of a planned subsequent change?
I will be including this change in a subsequent patch series I plan to 
send out this week.

Thanks,
Sidhartha Kumar


