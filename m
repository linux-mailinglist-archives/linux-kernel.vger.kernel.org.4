Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37566309C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbjAITmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbjAITlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:41:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE6339FA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:41:34 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309JdI2n017393;
        Mon, 9 Jan 2023 19:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=sL4gEo93sxvedF1yvP9a+tpsz5csI6nDk2jFEnXtjcc=;
 b=2wy00NDAhRGfa82AXnMDHI2PGPVRaBNHS64elP4wC3gsVm+1NhMAz+1DYEjR6QLTYYVg
 gKUUaeYJAtWUnQ8ub0xqz8Jv6iil7d25xP6OUXmp/OKzoJM8e9DeBQbBheD2TJ3OtGal
 lAieizZNiA/ROkRQ0KNW9r0srBgtUL5opxUfCD/FIZ3p16U1gbN5PhABmC1s+8MnjcEu
 oKNLvUBCWSEJfe8O4WvjbqQ/wMg7jVjUkku3AirmbGN+hoDLQdmwAweOCzl75iRYHcLD
 3RvakSoQrFvp2qyWoGBP07+RQbInN8eO18lZqjAk/zKWq5k8e5LSN4Io58GB664bqbFi 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n0s89807m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 19:41:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309In19q004444;
        Mon, 9 Jan 2023 19:40:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy6afbf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 19:40:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm5D267VhjkgYDvW9PL4cHF0o37LWNuQCJUbZNyZmqwleTXQkNcBVxcwSkGgAelnwWBLJYdk9MFPlqNmIsVMGIRHYAOs1jYErcEd+gSOvzl2hu7r1TM9vksyAmo3BZvs4hLvrf18avsRJd8YBJwKdvRzQvxfrS4A4N3+qUtguhmTL234oEGsOtDTpqid1FmIlAJBtEsWdM26URwVo/McOAAAijYZEuavYN6QCobEUcDw5QRWD2ntPRKT3tvuj3v6UHjzauyB4T0egXDieFmxpkWXfyEejxvPd/m0PlJ878fstfmxF9i2R6y/YMM4uPZCzJF+pMD8k323OvkH8wcodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL4gEo93sxvedF1yvP9a+tpsz5csI6nDk2jFEnXtjcc=;
 b=eTPJajZC+rGhbSmnkfmrTIM4sMVSq1OSYfVlXupBvAWjpEsWVOxyOkM2vbYjfJhfPc3C6fwNpmIeee215jfj2lTMXJ+6lQ5JIpt6Nki60iTIhiPZnpXyDMfxtyuHnEuEY9PZ2pArw8EApNgXolL0AjhHHqCG4s3eoJBTPU0ahhXwPXYIy6ezy8s0jo5P/Rkux0PlJ+iwQJtFh9UvzSgztrNinuEl/EpHFfE13YTyXmXadVnGC0cI8ypO1eHkbHlgrqPnQaZ7g3plBJZnhzlDd8fsF7VTHlhNbkTo/M+TyWbt0U6FJrm14KzpwbEb1uNGVqR6NK2ttesVBnEqHeYPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL4gEo93sxvedF1yvP9a+tpsz5csI6nDk2jFEnXtjcc=;
 b=UTo8ZoaeOa0VtqKZt2w01QOLRBMUtAx7NyPmyJ2lnlH0g/LtSItXDMlqMkQ4Aceae9apv1gtxjhS7m5I/wDz5qRMy6b729DDBIi4BQq08/pjcYaka5SoMElEQVVDsm5SRiTUyEISMnL3b568ctWsmjXECKWCVR4Gum4vNVj6U74=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 9 Jan
 2023 19:40:56 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%4]) with mapi id 15.20.6002.011; Mon, 9 Jan 2023
 19:40:56 +0000
Message-ID: <3c85676b-ded2-3941-6c57-5b11397cdd81@oracle.com>
Date:   Mon, 9 Jan 2023 13:40:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v15 1/7] crash: move crash_prepare_elf64_headers()
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
References: <20221209153656.3284-1-eric.devolder@oracle.com>
 <20221209153656.3284-2-eric.devolder@oracle.com>
 <09567e13-c5ed-d1b9-027c-9340fce6a0a8@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <09567e13-c5ed-d1b9-027c-9340fce6a0a8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0122.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::7) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB4654:EE_
X-MS-Office365-Filtering-Correlation-Id: d91e8227-234b-4ee9-3447-08daf2796cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12da7uQgNMaWzRoCwn2HQkZvLwVJGnisqguyhe1xclpor4a+K9C/jsRnB4kNhxdc4MN8PNCUR3aZfa2eiBGx7l5hVp6LztXWDjP1GATdMbogSzsWURDJtMtEnJzmSwRPQ4e+8ALfJmm9RFExFRiplJpw5kr0yq+J9sgmnl5Lp+LVYNEZj1P7SYzr7BAw+dDu04qiSMjxpMPW6CXY4iXaWgeRsksO7Z9/5ETsms+m5dWoUlskctIzuj/ngSQPmka5FtEGQds08KLukfA6c0IEEnpYC85+0y41iXk/DWavfUY3bUGKm9XJWiB6hKxa2Cu/ef7zSjUJketK4rKpX3r8i0RorMA8ppfoUt9pZnbFT8Vxh/wrsonHurSe8piYPEuAOqGrsexbqPpd6NMsfssnKSqXx/dFp3MtQicFjqjWcqng2gLKOzzRZivTJxG9bGNbS5t5MLXRF4t4lN2Y6hP7YR8/5j9BndeQxG3CFR6h6zXMR0aGeyytDwTiAk88g9njcaN5/Icfd6W/KkmWV0EmWKh1ZeaKBLIL++kq7FRlyp+/xsJjg2eOP5027espA7HebW/v7UEqRLZEBgffYoPNjuuOmyQvcvQXubNcD7VS5Fg9yU8MhX15yc2pQm050PBgflvcZGlJdD71eCBMaAKewI4regwgIwCoCK69VUApNl1qrhR8QXiUjCda+x4B4WCVNtDMRGjH+iZR+LGbpy0+D1MRR7WAEN/aDfBvaFIV0OY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(36756003)(31686004)(86362001)(8676002)(66946007)(66556008)(8936002)(4326008)(2906002)(66476007)(5660300002)(7416002)(38100700002)(31696002)(83380400001)(478600001)(316002)(6486002)(41300700001)(53546011)(2616005)(6512007)(186003)(6506007)(6666004)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djJmSktUYk50N1ZBL3d3SDZpUmlleFRjRlpRTGxYanlxa0RoZEVzYVpYcFdS?=
 =?utf-8?B?YnMyZjBOM2ZUTlhaTEIxMlc2ZGtGR0QvOU9US1p2UWo1NXYva1dkanpQMHNL?=
 =?utf-8?B?NlVUeDdkTjdWTTczMWIyMVZZNzkxc2d1SWxtQTVWWmdoUzZWdGpCaUZXSjlo?=
 =?utf-8?B?dFpyREhXcEVuYVZkaHliaWtBV1ZqdnBxdk1uZ1VKb21ZbjdUSUhaRHl4TWNK?=
 =?utf-8?B?bkVPOFgwTnI3cVE4RFVOM3FmMm1ydERwYVB3TjUvK3JKRTlTWTBjU0doNFRT?=
 =?utf-8?B?eXZQTklES0JQWHU1SnRPd2lqdEVZTjJQWnBwb3psY3ZxWi9zd0ZiSHJuaWtT?=
 =?utf-8?B?bm5BZmZDL0lKcStELzRMT2lseGkzNTF3SE1yUXo2Zlk0bkZCZkZWais4WFFa?=
 =?utf-8?B?RnVUWWdUcXFGZjl6ZGh3V3JmdkhGOWZhUERENGtzNFR3L0RzOXRkSnBPVWlT?=
 =?utf-8?B?Sk5hK0paSU1ETWVuN1hEQkRsTmQzRG43dGZlNDRqbEtuVm1LbWZtL2lXaTNR?=
 =?utf-8?B?ZXJyNkwvemlqY0ZnUDJ1WjVqRU5UY3J1d3hhbGVldUloSldLa3hIQUc2YXBD?=
 =?utf-8?B?dFdvQUJiSWM3TGw5ZHpReFBwcWxJSktMa3laWUowU2R2VHpUMGlTVlIxVGJM?=
 =?utf-8?B?SWJEVlBFcWRvOWFwdXhmYXhHdVhTUGV2aldyL0hxUFVKVnZGcjFhNW04Nktn?=
 =?utf-8?B?UDk0VHNHSzRvM01LOFE3ZG9SODhhWXlsSUR3WHIzVG5aZlhDcmJjWlNobFkx?=
 =?utf-8?B?Q0cvelhUM0RpUERxcGZFSDgxTjU3V2VYRjdIQUFUK2JpbnhzMnR0OERKL1dK?=
 =?utf-8?B?MU43bFVFZ2JIT09LN2t4cW9ieklHZ1lzeEd6TzJWQk8zd3lQemlwSFI3L21s?=
 =?utf-8?B?RmNmNlVkMS9yUnlHK051YThpa1dweDdrRzhHT0c5Q3VYcDJkYlMxQldyWFp6?=
 =?utf-8?B?ZkVzaU5FNTYzcVhzSXlyQzJHbzVyemZZQXJESm1uZmRBMlJCcjJuVzd2WU9I?=
 =?utf-8?B?WUFFRzA0Q0puSnVUVGFPY3ZuWjJHZmNLcGpsWEx1V2tNWXB5clpLVTFDdDJz?=
 =?utf-8?B?WCsyeDZScndRSTlhbm1Yd1BsSVNLM2E5QjZ2QTJqY2dJRU1MSlZ1SCsyUGZr?=
 =?utf-8?B?UlBBcGFqNzl6UHg0dkYyeWVKQ2xQM3ZmbmNmYVE5RnI3cFVGQzZRd0oxUEUy?=
 =?utf-8?B?cVREN3k3eU5hQ1gxZ2NOc2hxMldBcVJCbGE0bGlMd0dUMTBUWmR2T25rUnpO?=
 =?utf-8?B?OUhDWFBzc29lZklBNzRqUXd1OXgyaVVST1A5WGllVUlsdGFRQmQybWNyOHIx?=
 =?utf-8?B?ZW53b3RHQ1BjcUZvS09ic2pYMEI0VDlpbk4rdHJxUHczdjB5bHAvS0gxZHd6?=
 =?utf-8?B?VjdYelJRQk5BSVAzb2NLbXdkYndpTXdPSkcrMEZrbXhsN0xHV0V6QnZvbkwx?=
 =?utf-8?B?NHd6K1VBQ0xlblRIVXo2aHhoNmtpQWNHZ0lFdk14MlY0aStaY0hOWW1vMjYx?=
 =?utf-8?B?UjlrQm00ekd1UDVyM2ExZVcvYVJCYU0rTWFCeFk2L21hZEdta0VSVWgydCty?=
 =?utf-8?B?N1pTSG5GN1RyOXpDTkNKN0FBQ09yRmVNbTZaQlgreDdNSWt2Z3ppb293WEM3?=
 =?utf-8?B?d0pmYmlPcVNWL1ZNQ0hqTUhXQjVDaE5FRzY4K1dOVWVCMXBlWGh5eEk0TWg2?=
 =?utf-8?B?eFFPUnNRL2hLakR2a0xHMkxncFNFWDhlYkpUcTdmQmVhd2RBTm9RSkFJUlEv?=
 =?utf-8?B?K1gvMWFuc2tsV3RIdnppMVVnaXFCZHBLRmRZMjB0V0J6NGtULzlucnN6WVRz?=
 =?utf-8?B?Q3ZxWU1ZeUZ2K29SYlBrMzcyUXlqa3NWNlJJWUxwSHFqczIyUkx3ZWdJc2J4?=
 =?utf-8?B?Mis2SUIxTC93SldVMEpsSEtmakcvcjdWa241WmRvZXJZNlRVUnh0VUdZeitT?=
 =?utf-8?B?eTFpc1FRdVdQMEgycWFJeTVRV0M4eGpSdnBtVFdVOVRZNE5DcUZPY01rY1ZB?=
 =?utf-8?B?U0NUdVlNUnRNQXIza1U4UEFOdmhUWlBJRlNwZHhkSWZWRWZLN09BUlF2aXlO?=
 =?utf-8?B?K0VyRlh0UFhNK3E1MWY4aVorL1dpMVNBbFgxNitNY3djTklvS3ZaQ1VqblVw?=
 =?utf-8?B?U0hOS0o2dE9uYTY1TnlmajhHc1VVeThWVDg1bTJub290NEZQeTJVN1ZEUDJx?=
 =?utf-8?Q?oDN/fJeFR6/1B1lnCAGsk7c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UzcwdWpUdHFybmdUYnVRYTMzZU1ZeDJCQkJGbmNJdVlwUENERmNzdWprMUxI?=
 =?utf-8?B?c3dzZnRzT0t1Tk5qNDgwbk9FcHp1NkF5VzJvQi9HdDE4RDFCMzRZQ1BLWUdO?=
 =?utf-8?B?RGFUbWozcmdIbnh0MnVHc2paaE9UVStDZytiQUZuV0hDYWVBL0dwTFlTMk1l?=
 =?utf-8?B?QWZEK3FQTGozOC9MV1FjTm1IVG84Vm9DVEVGU1F6SUlUSEtvaENra21IaUE0?=
 =?utf-8?B?K1o3YWExTjJZczc5Rk03UVNoQWc3RWdQV3lXd3huMEY3NEhrY3hxQ2Z6VHlS?=
 =?utf-8?B?NGZEMURkaGFFemswSThrenBaSURHaGxQSi9Lc0NUMi91VWJHZGVtQVJCd3VX?=
 =?utf-8?B?eSs1OUE1N1FrVnVMb240aUpZemI1dThncHYxQ3Y5TmVLWml6YjJWekc1eHN3?=
 =?utf-8?B?R0dwek1Ub2NGaGZKRERPK2kvaUZkSWEzQlZBUnk4TEJCcHY1emx1L1pTUXFh?=
 =?utf-8?B?U2FtT2pqNUxkYXcvUU9KTmdrcnNBVWllcm9WTFFiRDVBYURZbDVvcCtOdXRQ?=
 =?utf-8?B?S3VFcXVOclp1OXV2b1FDU0FCb0dRSnRQZTYxczZVdkpDQXBDK1BiNlowSnI2?=
 =?utf-8?B?bHFXeGI0c1dpOUY4STQzY1FiempYQW5ZUlh0d3pRNVhkeDNKVnIvSUFaUGNN?=
 =?utf-8?B?RkdIK2tqcUk5ZDY3NnUzKy9BU3NXN0pCbDNnZE5NanZiNDh1S1l3Yi9MOUtq?=
 =?utf-8?B?U1RONFBHR0d4MkRGdStrQldYb2h5OWJFc0EvWTJzdnY5UitsbjlmSmFKKzJ0?=
 =?utf-8?B?OEJlOTJzMWRWR290Q29UeDlISkVOaDZ3YkFrOXp1M0Y1dkgrWDUxUG1XbnFi?=
 =?utf-8?B?YmcxMjlOYm1QcUZOeWhJUEhVdVVHNkU3cDRlV3lMdlJQdGFKancxRENDa3Nn?=
 =?utf-8?B?WDBSMEN2eVNTKzVub0djeWdSSFV2N21XdUpkTis2TUhFZVh1R1NJdzhYODFD?=
 =?utf-8?B?bDlYVWE3TU9pWFE3cFIzaWpQVWpWWE1zQUxIcTl3VVJRM0hMWmV3Q2FJS0tN?=
 =?utf-8?B?R1VaMTRnSmpCdFAxNUYzbjRLRGV1OW83LytlbU4wc0M0RkVTMkNqZ09ROFo4?=
 =?utf-8?B?ZC82UjdIQkk1b0prRlJEK0FIVjZaUWpLN3dhblRDYWI5c21HU3lSblB3K01Q?=
 =?utf-8?B?U0hWWkhFTDB4MVpzQ2I2MlJmVjRVZnI2OTFGRkVyUDV3MmdvOWJzWW1IVjBo?=
 =?utf-8?B?azRHemdSUGpIRGRSSEpQVU5xZUxDOU1KTXR1eENraHV5Z0hyei9Wd3BLUDly?=
 =?utf-8?B?aEhucTJVRU9TN2dRenlDeldwaW5vZmhzUUhWNmwvTnBUam10RCsxek16T0tG?=
 =?utf-8?B?TElXZnR2bnNCUHQ1ayt6YnVoSEgyQWVwekZ2bjN3WWlqVnNFWjFQQlBCSnBs?=
 =?utf-8?B?aDB5RXZuRGdiQ3M0ckNNQVFtK3J4c3ljVHpMY0JRVzh5bVozeUZ1b3F0MHRi?=
 =?utf-8?B?Z1d3dE54SEdiNWI5eE9LR3l6ajE1TUprVDhuUU93WXJKbk1RYktMM0VDMGNN?=
 =?utf-8?B?S0hxV3hEbTF1QUpNZ280cGswMmwybDhTLzFZdFpuMnI1TitiRk1rVkhhOEdF?=
 =?utf-8?Q?ZzqCu52tpjHRZIRpJFDXVHNLI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91e8227-234b-4ee9-3447-08daf2796cbf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:40:56.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwZicrE/MvOQYRaDEiczxOIIgBcbQGRLCxTN6rcts/a6axklxy57VX3mG1REjoNjrBBJHW7uU00Gfx49ed1Ucv++wpFBPFrpmZfptVnEiyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_13,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090139
X-Proofpoint-GUID: -jMecQXlOjIf2XybcQx6dBaTXvtVkgxu
X-Proofpoint-ORIG-GUID: -jMecQXlOjIf2XybcQx6dBaTXvtVkgxu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/23 23:05, Sourabh Jain wrote:
> 
> On 09/12/22 21:06, Eric DeVolder wrote:
>> At the outcome of this patch set, the crash_prepare_elf64_headers()
>> is utilized on both the kexec_file_load() and kexec_load() paths. As
>> such, need to move this function out of kexec_file.c and into a
>> common location crash_core.c.
>>
>> No functionality change.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   kernel/crash_core.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
>>   kernel/kexec_file.c |  99 -------------------------------------------
>>   2 files changed, 100 insertions(+), 99 deletions(-)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index a0eb4d5cf557..46c160d14045 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/utsname.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/sizes.h>
>> +#include <linux/kexec.h>
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>> @@ -314,6 +315,105 @@ static int __init parse_crashkernel_dummy(char *arg)
>>   }
>>   early_param("crashkernel", parse_crashkernel_dummy);
>> +int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>> +              void **addr, unsigned long *sz)
>> +{
>> +    Elf64_Ehdr *ehdr;
>> +    Elf64_Phdr *phdr;
>> +    unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
>> +    unsigned char *buf;
>> +    unsigned int cpu, i;
>> +    unsigned long long notes_addr;
>> +    unsigned long mstart, mend;
>> +
>> +    /* extra phdr for vmcoreinfo ELF note */
>> +    nr_phdr = nr_cpus + 1;
>> +    nr_phdr += mem->nr_ranges;
>> +
>> +    /*
>> +     * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
>> +     * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
>> +     * I think this is required by tools like gdb. So same physical
>> +     * memory will be mapped in two ELF headers. One will contain kernel
>> +     * text virtual addresses and other will have __va(physical) addresses.
>> +     */
>> +
>> +    nr_phdr++;
>> +    elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
>> +    elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
> Seems like above function is out of CONFIG_KEXEC_FILE but some of the
> structure/attributes like crash_mem and ELF_CORE_HEADER_ALIGN are
> still defined under CONFIG_KEXEC_FILE (look for include/linux/kexec.h).
> 
> This leads to kernel build issue when CONFIG_KEXEC_FILE is disabled.
> 
> Thanks,
> Sourabh Jain
Thanks Sourabh, I'll look into this further.
eric
