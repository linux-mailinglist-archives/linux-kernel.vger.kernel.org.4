Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060076F5F23
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjECTbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECTbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:31:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C08768A
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:31:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Hom8b017459;
        Wed, 3 May 2023 19:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=+yEEwFMMqzIFkKp0+ygKyouAuqqHcrOuZlOTNo5W/zU=;
 b=yuXLHIqxO+dcmT3orfk1ZNY8iCFmA9PEMPD8VFPLU3Az6wAPez+01i9NZQNV5QxUU81X
 PuMIhs7Xn1ir7r2FJXD1aCItPWR7OkmXtEpTxWsTJ01Vds10eObrUHZapQzp3lNFWsUd
 nFzrdBjZvoVUHJyG040FdDn9dSrvgenAn/PcWFGRi62FOeFpLu7Yp9sU82qESXoT5gky
 rmRtbC4z1KqbmO84QXZc5FB/rmqLgr5DTAcSIDLPVnF2Xg3CG8PlgLYLJ7RLvEFz4wY3
 JdhA3BCWOhMmpU6an56UKiWGeHS89GTyDdUokJWCc7QLywAHsN6zc7rsng296+HaCsET DQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4ar32y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 19:31:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HjUCP020796;
        Wed, 3 May 2023 19:31:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7j4ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 19:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTy0SyARbnSzKQ2EIJfUV7dAhwfyj7n5mX/QyrLatw+IROdcT+qQZdJyRMh5paDlv7MhHIAx71gPPfdgbc9x43WYiuRAjrl38zqR06etQQNgXjbJfKuzjubMeCL/qhVAPabg2ds9TnAwjeQFlso0s69dlyAy44iIMHc+xOK9N6q0IVIMT2f6n9x1Z4LkVDBHj9Wgp794SwdErDc4fkFeH8lUBk0y6p0Wjx480DzkTP5qB5UiHSwWMbX+qOJSQ/iSO8mNaLmW2synq2KI41oHPQWEdKQgpoTlOk0SkTVjrpU5US0M1mdvvfjeKF8N9tjv0nw3ooOK7oMCqiB0B4zM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yEEwFMMqzIFkKp0+ygKyouAuqqHcrOuZlOTNo5W/zU=;
 b=E/K3I5TyQskAasIA7BsFKlrztp3IuPCtwzkjNlJy2/OEeHoG368nFIP9+16UFXdwky3mi9e/cofImcwtJmM78QkTtTMxRKmdCxdvyCcAFah+9LbMus0R0F+djBubTqTMRqeJKJNM9B+o9bQI+h3BHL60uufDXHdFSEpju+vtLbDySrc3Y8xxxSfEOQo18gAz60BpzZOvNBv0lfcmc4tQwbwM26ctYVKpidBMY+1aGdw20DsWEAgiEMoXDPUC560ELAv5kWSSrb/5z7ZGqrgjAHIf6uu5Q6QbnlBIYnkF7iEWb465q3u+BJvTNAWvXXK2whPBuHiXdBFvH4PwxkXylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yEEwFMMqzIFkKp0+ygKyouAuqqHcrOuZlOTNo5W/zU=;
 b=njAezb9PK3qFNC+DUlFYuMX4hN/YxXZdYiFkQsAIybq1yXq0zBwNw/JC0decJ8LUvKeIrVtSpZq5NDlsPmI5rj1sYvPWBH9tIA0GPJCKI1vu3Aq7AxiGYCaj6FTSh/Hi7goIM4I4p/M0BipJt3DCmsP5KCZ3CwqX6IMUZ6CbzaQ=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by SA2PR10MB4730.namprd10.prod.outlook.com (2603:10b6:806:117::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Wed, 3 May
 2023 19:31:28 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7fc1:adad:b2d5:a1aa]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7fc1:adad:b2d5:a1aa%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 19:31:28 +0000
Date:   Wed, 3 May 2023 15:31:26 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <perlyzhang@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 27/34] maple_tree: Introduce mas_next_slot() interface
Message-ID: <20230503193126.2jejttv7kwtjznh3@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <perlyzhang@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maple-tree@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-28-Liam.Howlett@oracle.com>
 <cfa05198-9ab0-3529-bc1f-08d8035a435c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cfa05198-9ab0-3529-bc1f-08d8035a435c@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::31) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|SA2PR10MB4730:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b70de99-7639-4742-d107-08db4c0cfd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UL81cN31rZMLLLiw3E67sEUdEo+ALYPNDVcwo1O8IJEVb3Cmrgu8M3wO7exVso7qxv74w3U95/FN1aWeVPYaBFxhvkvbgjc470ZgzX2hcWZDDawYFlHliCR4dEgowTfA06NGm8BI0P4yrxL3gnoz29MPqxEMbx0Y5QKzTyYyzKIwDHb0DEpRKvVs0lN39V7cSkHjlCco7pkqdR1R50l6FrT67STLaHayNejjyje1+YwIaKbdH92NvmhN63LRavB/a4IYKEvkoT8NDiMh05Vz3Z+HkEfegihkQtTHVBD1lZQ1KlE87m1e5+q56rF8oYyTmXVlzS788mi3x78zxiCGZtzavwYVtSehoPxndNG0BdyR6zwb/PTmlLjZ3Icjq8pxRTFsE7MN3QsLb24RIZTL2UfVSWHZHy3xIrIlFqjZBzHJ7I8gcwCoEeyblcIK8JWY4bBALIIjNAsmBkMX4oCyTYGkWIckAU1N5IYyN/wEN5nfCQAPgGDus7qoH8F5d+ooiualp+e+rPWbH7zpyrRRVaMRePc1EeQRiE81PGWvC55fgj9IPTZv7S+dO+wTyfoT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(41300700001)(8936002)(8676002)(5660300002)(2906002)(86362001)(38100700002)(6486002)(186003)(478600001)(9686003)(6512007)(6506007)(83380400001)(1076003)(26005)(66556008)(66476007)(6916009)(4326008)(33716001)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFJWYWhnOXJTK0R6aksyWG10aFltK21MQmErTnRzUnVvR0srS2tqdzNuWmpp?=
 =?utf-8?B?MDBQUzdQS2lWOUtnMDgzdzNDT2VyZE9xdHBSbmdsMEhINWJiemthNWV5b1lL?=
 =?utf-8?B?YlRxUVZ0dnlYV1hMdjlEU29KOXFNdEM1MWdCK2c5YWVoWmliZ012Q0pZcU45?=
 =?utf-8?B?cUtJZktvOWNPVnVKUEhWbXRSdnJVS1V1Q0oyRExFcWh4YTlWWlkrcDhmRXls?=
 =?utf-8?B?MWpFMXVyL1g1YjVJUk1kb3hpQzRUVVd5V3RHdmFmOXJxdDZSTVJEM2hxbENC?=
 =?utf-8?B?YTkvZFV0ODBaSnhNSXl1d2haQWpjZzJ2bUtBSGt3OGM4UEhka1ZzbzVCVm15?=
 =?utf-8?B?b1MyQnk5UWJ6aWhuUmRldDhXMTg5OHBvazFvZTB1WS9peHh0MTFCaTVoSHBX?=
 =?utf-8?B?eGE4N0V3L3hKaS93dDVPVExqZEJEc2lyR3BuMFIvaGhvTzI5MHdiMStXWkNu?=
 =?utf-8?B?b1AzNmZITmVBYXdjd3VUQVpZNExLYmszQmFESmRjYXRNcGltTE5Udng3OUhz?=
 =?utf-8?B?TDhqcGVZR1daQUhSM2swK09MYXYzWUFmdkJaMHFpL3BiYXNkaUorTWpONFR3?=
 =?utf-8?B?Qkx2V2xYTHZJZzVYMDRsMDh2Q09zS0w5dVM3eGNrb1FGS2l5bTR5QkFLMndv?=
 =?utf-8?B?NzlYMjRNajY2UGVEVDFTdC9HS2gzNm5DcDdFdzdBQmh5ZTdsblR3bWZxdkhj?=
 =?utf-8?B?eFp5WG4zTTdWa3RMMUxDbzRkcnVQUC9pL3BWNkZwRHVBWjc3UG5IRmlYMTJy?=
 =?utf-8?B?bEg0YVZUSUlWeEVWenJTZlFOVDZhc1dvUjI4U2ZHaFo3OUpJNlVrdEhiaXQ5?=
 =?utf-8?B?cFAyOFBYTFo4UTN2c1JWZExIemx0V05heVBMT3prbE5PeWoxWEFxWHJ2V3Bx?=
 =?utf-8?B?UnhyK0NENEt4L0Q5S2NkQ3o0TTQrQTkzZlc2QjVjclh4eklIYW9KMnJOSklX?=
 =?utf-8?B?QUFaRDNJejNQNG12Tytheis2L201UjNqeTVISXJMdVY1ZThWeVhXdG1RK0xQ?=
 =?utf-8?B?ZW54ZDVPdzU4OWpnOHZvMStTWGRhTkQvbWRXcjNKb1pkRU5Bb3RsbEhoYmNi?=
 =?utf-8?B?UXFxZHpjYmsrbVA2RGV1bmovZWtXQ1ZORUNPZFZUZE4raEtFYWJTUGw5S0U2?=
 =?utf-8?B?Zkg2VnBXNVhSVU5CYlEzbk8xb09BYkM4MFk1S0JnUUZXOGRtOTdIOVlkSE9Z?=
 =?utf-8?B?UUtHenJZQnZyc21vS1JidDUzbElvbHNGeU5iVzVQQnBGNkZhM3NqVk5ubmZi?=
 =?utf-8?B?aEdaQmY3SGd2V0ZrcFlmejkxdTczSnZ6aGxaQjNSQjNkNmt4bVhpb1lHaUxQ?=
 =?utf-8?B?bEtqcDMvRUFpN1RpN0VYczQ0YWQzMkNDb2wvdHR1RCt5YzJuV1RteEZmZ0h5?=
 =?utf-8?B?TEFnSXd4SjhCQXNYYkNBTWlHNDBTakxMeVk2bHd2cE8rZkZCMzg1REc1VkxR?=
 =?utf-8?B?bE5KVUFDcWd6NDBhYWhqVnZKYjBHdGREaGYraDFiOWhCb1E1NVFIdmcxbzVR?=
 =?utf-8?B?akVLUFRaRFZnK2VZRTFCQjUwL0xDSHZhMGZLQ3Uyb1pwMXZSOXZ4bVRBMjg0?=
 =?utf-8?B?UitSUll1SSs3aStzQkErQlIzNElhUUJnWkYrNWQzTlRuRXZYdjd4eFZ5OVBr?=
 =?utf-8?B?TFVYN0ovTmliSW5FVHpOamt0UkVpdERLeWhZM0pacWRBNmZaVzQxMDJQTHp3?=
 =?utf-8?B?NXBndjJQWkdKRjFsS3dxenJ3Wkt5czlJdzFHaEROTUYyMTlIZTByaExmV1pX?=
 =?utf-8?B?RjducjNPbWVBNUdrblhzSWN6Y2luNjB4aDNJeUJRazFUZFl2by9MMzhwTk9Q?=
 =?utf-8?B?STV1KytzNlFsSzRDVUZYNmw3amRJREtvUE5tYzZQZElmK1NHV3JaK0VTL3N6?=
 =?utf-8?B?ZFBNZEZTdWJwR0dDYW5DejVjZnhrdGpUdjQrbUVZakRwaDRoSVpTMEJBWlcw?=
 =?utf-8?B?RkY2Q09UMXpod2NtcFcyZFM5UW12MnpNbkxUTk01ZUdjcDAwQ3JnY0N4c0pC?=
 =?utf-8?B?QUZGdDVDR3hmSVhadTk2OUxhQ0FXdlJkdWhQNU16NzNsNldMYnUzQ3pXcHNW?=
 =?utf-8?B?WkhhejlrQzNDT2pkQktoTXdFMmErQ1lXeWY2WEpQcjFaNStPT3VUanhZNmk4?=
 =?utf-8?B?azIvNmhQaE9PNUZFNVZWVGxkcStwOG5CWGdMT3UxazBCSmVUa2Q4Ums1OCtq?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bjVbcIUcvFOnnPIDJ/ckbyRptMtI72QDq993WBEjWLh0Ht01p2y8lJs19tPzzyQV8u9zRjiDjJwfH/AlmGHjRnGCTG+GkNq6A2qsV2zTAbdIsYjBSxjSkenKuC8+Dli+fObEAe2M9R3RSdjiZ6MV7T+TZ7xd/SL7fLRQKA7YwPtXe9msGJpwnWk+120ar4vrII4Luq8eorOLgRyBztddbeGgbPXbryaC8Fg9NBGk/aXKxhvlhGtXg0AjKq8u7Fe4jMTksQxyvJsljZpxejtyvVmfQAFPF0UWIOpKsM6G5iVEklpAFdsvKM25EgVMqvkRL5G+cyOnr4uYvaoDIqbh4M07vKO0sUXu7qXqEhcG1AAxW69UQfR5wr6v5M30ZY2fJSU83yEF8kWbKXLxUlr19vQjBGm/w4kbzHMIhibghhUj3ghbJhtd7sFO74BzSGieg7omvsTFiaAdFAK9pOTVEcy7fjooeh9lhXp5Oy/qDVVBK1DTa7NF4TkVDbB1HO1anzqfuYBGYeORrcoQAoBAL48rChnD1QzV641Q93c00oXCpDWgE4/2Az+GL8AlT3wYLlT1Yp/hG5x+ZAAnhcWVOnQ+6gIVTs3Vqt+bD6xukpysFEeXZSTOEg0OzqfoU7Mu/WvJufjvxNL2keue0OLcqeHaM8sV+vmqNJsEJEDL8v50+okD9Zclyt1f8TUJlShwqQHH5l0h0xVL25djbKTQdg+1TEYfElI0nfkDjzMjl7HKDtIVIMGjVa05fpnMrt+nvtRZWMq1AhgmKPspfczSwdTOBDe+WU5/LmsvZFAHD1ulcsEkw198b8STAtJs1LDul3k31/4Eo6nvMLLZNvQ70LMHa7fojp3E77CHmMrtT+fQrZIq6OxF0/PyvQIpdn/t6NiA1ZaMva7Z3R6rNXFQeWwbOEKryPjb9RKtVgTXD84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b70de99-7639-4742-d107-08db4c0cfd87
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 19:31:28.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvjSI8KETXzX0UUE7xsbIxnx5jhaFxSA5zFvSPMSxjKV7mdBZGdWWwwlZspxoDvz0q4ysoGfOBKFxwhmv8JgCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030168
X-Proofpoint-GUID: TobpIHVtVFEyYd--amSggTaaNPztCffF
X-Proofpoint-ORIG-GUID: TobpIHVtVFEyYd--amSggTaaNPztCffF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <perlyzhang@gmail.com> [230428 02:48]:
>=20
>=20
> =E5=9C=A8 2023/4/25 22:09, Liam R. Howlett =E5=86=99=E9=81=93:
> > Sometimes, during a tree walk, the user needs the next slot regardless
> > of if it is empty or not.  Add an interface to get the next slot.
> >=20
> > Since there are no consecutive NULLs allowed in the tree, the mas_next(=
)
> > function can only advance two slots at most.  So use the new
> > mas_next_slot() interface to align both implementations.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >   lib/maple_tree.c | 178 +++++++++++++++++++---------------------------=
-
> >   1 file changed, 71 insertions(+), 107 deletions(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 31cbfd7b44728..fe6c9da6f2bd5 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -4619,15 +4619,16 @@ static inline int mas_next_node(struct ma_state=
 *mas, struct maple_node *node,
> >   	if (mas->max >=3D max)
> >   		goto no_entry;
> > +	min =3D mas->max + 1;
> > +	if (min > max)
> > +		goto no_entry;
> Unnecessary check due to mas->max < max.

Thanks, I will address this in v2.

> > +
> >   	level =3D 0;
> >   	do {
> >   		if (ma_is_root(node))
> >   			goto no_entry;
> > -		min =3D mas->max + 1;
> > -		if (min > max)
> > -			goto no_entry;
> > -
> > +		/* Walk up. */
> >   		if (unlikely(mas_ascend(mas)))
> >   			return 1;
> > @@ -4645,13 +4646,12 @@ static inline int mas_next_node(struct ma_state=
 *mas, struct maple_node *node,
> >   	slots =3D ma_slots(node, mt);
> >   	pivot =3D mas_safe_pivot(mas, pivots, ++offset, mt);
> >   	while (unlikely(level > 1)) {
> > -		/* Descend, if necessary */
> > +		level--;
> >   		enode =3D mas_slot(mas, slots, offset);
> >   		if (unlikely(ma_dead_node(node)))
> >   			return 1;
> >   		mas->node =3D enode;
> > -		level--;
> >   		node =3D mas_mn(mas);
> >   		mt =3D mte_node_type(mas->node);
> >   		slots =3D ma_slots(node, mt);
> > @@ -4680,85 +4680,84 @@ static inline int mas_next_node(struct ma_state=
 *mas, struct maple_node *node,
> >   	return 0;
> >   }
> > +static inline void mas_rewalk(struct ma_state *mas, unsigned long inde=
x)
> > +{
> > +retry:
> > +	mas_set(mas, index);
> > +	mas_state_walk(mas);
> > +	if (mas_is_start(mas))
> > +		goto retry;
> > +}
> > +
> > +static inline bool mas_rewalk_if_dead(struct ma_state *mas,
> > +		struct maple_node *node, const unsigned long index)
> > +{
> > +	if (unlikely(ma_dead_node(node))) {
> > +		mas_rewalk(mas, index);
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +
> >   /*
> > - * mas_next_nentry() - Get the next node entry
> > - * @mas: The maple state
> > - * @max: The maximum value to check
> > - * @*range_start: Pointer to store the start of the range.
> > + * mas_next_slot() - Get the entry in the next slot
> >    *
> > - * Sets @mas->offset to the offset of the next node entry, @mas->last =
to the
> > - * pivot of the entry.
> > + * @mas: The maple state
> > + * @max: The maximum starting range
> >    *
> > - * Return: The next entry, %NULL otherwise
> > + * Return: The entry in the next slot which is possibly NULL
> >    */
> > -static inline void *mas_next_nentry(struct ma_state *mas,
> > -	    struct maple_node *node, unsigned long max, enum maple_type type)
> > +void *mas_next_slot(struct ma_state *mas, unsigned long max)
> >   {
> > -	unsigned char count;
> > -	unsigned long pivot;
> > -	unsigned long *pivots;
> >   	void __rcu **slots;
> > +	unsigned long *pivots;
> > +	unsigned long pivot;
> > +	enum maple_type type;
> > +	struct maple_node *node;
> > +	unsigned char data_end;
> > +	unsigned long save_point =3D mas->last;
> >   	void *entry;
> > -	if (mas->last =3D=3D mas->max) {
> > -		mas->index =3D mas->max;
> > -		return NULL;
> > -	}
> > -
> > -	slots =3D ma_slots(node, type);
> > +retry:
> > +	node =3D mas_mn(mas);
> > +	type =3D mte_node_type(mas->node);
> >   	pivots =3D ma_pivots(node, type);
> > -	count =3D ma_data_end(node, type, pivots, mas->max);
> > -	if (unlikely(ma_dead_node(node)))
> > -		return NULL;
> > -
> > -	mas->index =3D mas_safe_min(mas, pivots, mas->offset);
> > -	if (unlikely(ma_dead_node(node)))
> > -		return NULL;
> > -
> > -	if (mas->index > max)
> > -		return NULL;
> > +	data_end =3D ma_data_end(node, type, pivots, mas->max);
> > +	pivot =3D mas_logical_pivot(mas, pivots, mas->offset, type);
> > +	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
> > +		goto retry;
> > -	if (mas->offset > count)
> > +	if (pivot >=3D max)
> >   		return NULL;
> > -	while (mas->offset < count) {
> > -		pivot =3D pivots[mas->offset];
> > -		entry =3D mas_slot(mas, slots, mas->offset);
> > -		if (ma_dead_node(node))
> > -			return NULL;
> > -
> > -		mas->last =3D pivot;
> > -		if (entry)
> > -			return entry;
> > -
> > -		if (pivot >=3D max)
> > -			return NULL;
> > +	if (likely(data_end > mas->offset)) {
> > +		mas->offset++;
> > +		mas->index =3D mas->last + 1;
> > +	} else  {
> > +		if (mas_next_node(mas, node, max)) {
> > +			mas_rewalk(mas, save_point);
> > +			goto retry;
> > +		}
> > -		if (pivot >=3D mas->max)
> > +		if (mas_is_none(mas))
> >   			return NULL;
> > -		mas->index =3D pivot + 1;
> > -		mas->offset++;
> > +		mas->offset =3D 0;
> > +		mas->index =3D mas->min;
> > +		node =3D mas_mn(mas);
> > +		type =3D mte_node_type(mas->node);
> > +		pivots =3D ma_pivots(node, type);
> >   	}
> > -	pivot =3D mas_logical_pivot(mas, pivots, mas->offset, type);
> > +	slots =3D ma_slots(node, type);
> > +	mas->last =3D mas_logical_pivot(mas, pivots, mas->offset, type);
> >   	entry =3D mas_slot(mas, slots, mas->offset);
> > -	if (ma_dead_node(node))
> > -		return NULL;
> > +	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
> > +		goto retry;
> > -	mas->last =3D pivot;
> >   	return entry;
> >   }
> > -static inline void mas_rewalk(struct ma_state *mas, unsigned long inde=
x)
> > -{
> > -retry:
> > -	mas_set(mas, index);
> > -	mas_state_walk(mas);
> > -	if (mas_is_start(mas))
> > -		goto retry;
> > -}
> > -
> >   /*
> >    * mas_next_entry() - Internal function to get the next entry.
> >    * @mas: The maple state
> > @@ -4774,47 +4773,18 @@ static inline void mas_rewalk(struct ma_state *=
mas, unsigned long index)
> >   static inline void *mas_next_entry(struct ma_state *mas, unsigned lon=
g limit)
> >   {
> >   	void *entry =3D NULL;
> > -	struct maple_node *node;
> > -	unsigned long last;
> > -	enum maple_type mt;
> >   	if (mas->last >=3D limit)
> >   		return NULL;
> > -	last =3D mas->last;
> > -retry:
> > -	node =3D mas_mn(mas);
> > -	mt =3D mte_node_type(mas->node);
> > -	mas->offset++;
> > -	if (unlikely(mas->offset >=3D mt_slots[mt])) {
> > -		mas->offset =3D mt_slots[mt] - 1;
> > -		goto next_node;
> > -	}
> > -
> > -	while (!mas_is_none(mas)) {
> > -		entry =3D mas_next_nentry(mas, node, limit, mt);
> > -		if (unlikely(ma_dead_node(node))) {
> > -			mas_rewalk(mas, last);
> > -			goto retry;
> > -		}
> > -
> > -		if (likely(entry))
> > -			return entry;
> > -
> > -		if (unlikely((mas->last >=3D limit)))
> > -			return NULL;
> > +	entry =3D mas_next_slot_limit(mas, limit);
> > +	if (entry)
> > +		return entry;
> > -next_node:
> > -		if (unlikely(mas_next_node(mas, node, limit))) {
> > -			mas_rewalk(mas, last);
> > -			goto retry;
> > -		}
> > -		mas->offset =3D 0;
> > -		node =3D mas_mn(mas);
> > -		mt =3D mte_node_type(mas->node);
> > -	}
> > +	if (mas_is_none(mas))
> > +		return NULL;
> > -	return NULL;
> > +	return mas_next_slot_limit(mas, limit);
> >   }
> >   /*
> > @@ -4845,10 +4815,8 @@ static inline void *mas_prev_nentry(struct ma_st=
ate *mas, unsigned long limit,
> >   	slots =3D ma_slots(mn, mt);
> >   	pivots =3D ma_pivots(mn, mt);
> >   	count =3D ma_data_end(mn, mt, pivots, mas->max);
> > -	if (unlikely(ma_dead_node(mn))) {
> > -		mas_rewalk(mas, index);
> > +	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
> >   		goto retry;
> > -	}
> >   	offset =3D mas->offset - 1;
> >   	if (offset >=3D mt_slots[mt])
> > @@ -4861,10 +4829,8 @@ static inline void *mas_prev_nentry(struct ma_st=
ate *mas, unsigned long limit,
> >   		pivot =3D pivots[offset];
> >   	}
> > -	if (unlikely(ma_dead_node(mn))) {
> > -		mas_rewalk(mas, index);
> > +	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
> >   		goto retry;
> > -	}
> >   	while (offset && !mas_slot(mas, slots, offset)) {
> >   		pivot =3D pivots[--offset];
> > @@ -4881,10 +4847,8 @@ static inline void *mas_prev_nentry(struct ma_st=
ate *mas, unsigned long limit,
> >   	min =3D mas_safe_min(mas, pivots, offset);
> >   	entry =3D mas_slot(mas, slots, offset);
> > -	if (unlikely(ma_dead_node(mn))) {
> > -		mas_rewalk(mas, index);
> > +	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
> >   		goto retry;
> > -	}
> >   	mas->offset =3D offset;
> >   	mas->last =3D pivot;
