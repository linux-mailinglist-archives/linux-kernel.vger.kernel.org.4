Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC2E738BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjFUQmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjFUQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:42:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04A11FEB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:41:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDAf1j030186;
        Wed, 21 Jun 2023 16:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NqCzDCmq2gdicWb9Tkb6NNaxxqhnF0EqB7Z6NavRRPI=;
 b=N5T403O7OZgm7VWaC9bwos/tY3Yx3JWho/YO26TdWjML+i60dCy6BGYFWaYJWmYFb5h5
 fCZXGXII3YJbYK3blZnOxQDw2Seq2gKKZQeWyEKlwTzEWOr15I3YaOXhQ6JOfWVUbyVk
 bd3iIFPnGcSf5aqr8UhW3ovBlLp9tbAFSzGl/A73IhsxSPd3LQ1+92XraTYkjl5DmhD0
 CmiXSfDqEQH7LaRhB8+Ve6eZ/RmU8ht73qGZOrml/H7Abkgc0mgloinC8UG/D9jN0vVs
 L7UKo4MJRBbuj/dZ5XihV9wubZpYeELMeolJDhnSs0VcIrZzv1EQbrERyoWxeHwNB1UB YQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etr0sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 16:41:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LFXbBn032948;
        Wed, 21 Jun 2023 16:41:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r93978j64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 16:41:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFCgjEuCx/55kyOlNStCikP4z0ZbFT7lmOxJjeThtAGa8lyeI8G5PnDZ27S6z1noEvZ9553MwAxsuxYGZFuicNG1jllIiB4hcFVou/h6GVAvfebDWMegvYu0n7g/O1Y0Ap6BYaVK4ty1lpOzo33OoP0yLxEM1m93q2xsP2mjhZjJtBCqyQ96RNWSe78+ghSmxLS5IHx7rJCdJvLkhGVbvz6iJeq9sKjQgwN6WXpfuNNxFHADuC0LmDYKTQsgOwVU0MOFxmG0VprsbtI0Yzc2QAIhiJBIVD0kJACXZbNPvE1bcQSQ94V3eWDwV42FY+GhFXWdvq75lixnAPLP44cQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqCzDCmq2gdicWb9Tkb6NNaxxqhnF0EqB7Z6NavRRPI=;
 b=OrandQOzLeciR8Ju3lLIZ196ndUeqLS+xiZILmk7DONtrNFkvoxFMr9hHV5l25cix5K5ce+fcvPb1ZPtiqQ6xk6D61Z+O8G2Z6vSmGMejCCoZw8lsIVCdQKkfUaAg/GvUIpGkZTb/qWxFhkBRinhFdlEQVTwarbeI2tIv0ikA5THkoJjiKi1yBsdUApDzsr52LOlwt8YNvKKVCCvfqYDgq7EpRa6OG1ly/OiB/ZTN8Cz8MnoWJw0SzYTCSRORewRpv0qPEE7NDYyeXqciaboxP45mrRLFfWkUtrNq34GOSAprJbh9+2rWUiKUkDTTeZ30JtahzC2nNu65cKXrgH7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqCzDCmq2gdicWb9Tkb6NNaxxqhnF0EqB7Z6NavRRPI=;
 b=N2gT+IY6dt408KMs2m6IlHhlAl42xX2c0bS4LlpIJhYUgfE1I34bYibxc4Jxlu017pw8JTB7pUaNXZ2B26Qca1tDHSXa1IzDANEJGUEwLrVNljU3Q3W/S4yOKWyvLaJqug3WGZz9uvy8RvPKFgfsI0y9+Gq8QexZtpc57CkCElM=
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11)
 by IA1PR10MB7539.namprd10.prod.outlook.com (2603:10b6:208:448::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Wed, 21 Jun
 2023 16:41:29 +0000
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::dbf6:6295:1780:4aca]) by SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::dbf6:6295:1780:4aca%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 16:41:29 +0000
From:   Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "zhangqiao22@huawei.com" <zhangqiao22@huawei.com>
Subject: Re: Reporting a performance regression in sched/fair on Unixbench
 Shell Scripts with commit a53ce18cacb4
Thread-Topic: Reporting a performance regression in sched/fair on Unixbench
 Shell Scripts with commit a53ce18cacb4
Thread-Index: AQHZmltYLRrf94uAqU6ZfNgQYN2haa+CsM4AgAZ3AICAALi9gIALqS8A
Date:   Wed, 21 Jun 2023 16:41:29 +0000
Message-ID: <E0B1B4B6-8281-49AC-AC77-4920D209796F@oracle.com>
References: <F4B69136-C13A-4449-9005-4BB0617E60AC@oracle.com>
 <CAKfTPtCBQJYfFgFhA6=364onup2TU1hrTxJYJA5OiSJ_ECB0JA@mail.gmail.com>
 <7C9D3ABF-E878-4B75-9ED6-AD6EFB6243C5@oracle.com>
 <ZIlgD36syo5nGoZI@chenyu5-mobl2.ccr.corp.intel.com>
In-Reply-To: <ZIlgD36syo5nGoZI@chenyu5-mobl2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7860:EE_|IA1PR10MB7539:EE_
x-ms-office365-filtering-correlation-id: 711c1087-fe56-498a-ef5c-08db72765d2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /aWXBJGEmJOLzk5bimBEwFAlO4VeS3Lq5Kgkc0PQzb1mTxUGkRDkXEwcQnEhj2u5+zIDTXvrHjGe5T8lVxb0IbLJf50ZA1ufsta1evy/vOE8O3aBeHqW0B7D/vDuPkngQDS+rP2FeyX5gs6nwn3oHpYK7YlYZhmYJ0j5mA9ekMIcwLvlrbsOD75IMK6wDoMnMjrqi3XG/7JManuF2LFFCxBlELtuW/7NVSHMbRXbgvytnyfS/5LxGs93Gyr5m5jO+K9fh/P5QntWT8ttW+dKrroJkYWJfMgL+cZpQ6lPbygYLE3ZcIy+VSMLkM81cfIds6MFbFFUK2GE5jPK3fFx0Y2/cQk+eZReYOH4UBCZtlqWdhmsHhMVIPG8KGHvqkcPSbRtASzwgv4A6oky4F5EiH7Na5JhVNHfXnvqDs+Q40AvKrVh9RP8wn6vwAKHUEBR55q3CJJBwM2g/HqxeZmMTDj+mVFTlBWshwOymmjX9VpplskXfi5wnxaIVxArx7UgFIuJephv+mFhVLTcxYPRugP8ppGw4GaZdVvZTV2rXsv4aJx/sX44Ygg0EMn+cQPn0AA3rRyaYfxQ5TX/nWsCautoCoKFM3SZNyqo91/cK40lk5C4MnRs2387+uD0+y9JdYa6NtKnovS5WcqI81DkovMXnvpLyfmgyq2+iIJvovo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7860.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(38100700002)(122000001)(38070700005)(33656002)(36756003)(86362001)(71200400001)(6486002)(53546011)(6512007)(186003)(26005)(8676002)(6506007)(8936002)(44832011)(5660300002)(478600001)(41300700001)(66946007)(316002)(54906003)(76116006)(2906002)(64756008)(4326008)(66476007)(6916009)(66446008)(66556008)(19627235002)(83380400001)(84970400001)(2616005)(98903001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0FPZDl3enFsWHRBTllwY1pvdDFndmpDZTdqYldzcWIxZEJRbXp2SHJaMXM0?=
 =?utf-8?B?MDA3VUd0YVFEZ0JKR0Y1VUZJYWgzOTEvSGlZRXhQZUtUY2dNZXlhbUx1QU5y?=
 =?utf-8?B?S1BQSG5ZcUl1YmdmQ1FtaExTRG5nOC9TMHZ0RDVFOGp3UXVobTR5Wlh6SGFL?=
 =?utf-8?B?U3FzeUF3TGZsMXNSVjFkRmNOZVVrdVZoZUhTSURPUmxCWjRlMllNeWxQZDMv?=
 =?utf-8?B?WDJOYjNCMGN0Sk51bTViTmlrWk9XRnNtNjFSck1DQ09xMUdGVUlnTldKb1JE?=
 =?utf-8?B?YmhkeStJVDMvNVd5VC9HNGlnNkM3MVNOREdiRkVDQmdmWDA1Vm5ZZm55NTE1?=
 =?utf-8?B?Wm5WeUw1dS9ZM3FISkNJV2h4Sm9FUWJlYURWbUt5NVFBS2FkTm92WWxVWTcw?=
 =?utf-8?B?a0pSZE1XdmpIa2RxYmdlTi92S1l2VG1lZkc1VWJOTEtKZTlIQzVkVFZsdHNw?=
 =?utf-8?B?dGJxVURJMjFMZy9JTnZMdDRIUjM3MnhSZVdLQk11emlNVnA3TUFUWllLR0pv?=
 =?utf-8?B?Wi83SHBCYWhMOHVsUkJtVUVUSDZFbXNFUGtGZGYrb1U1LysxZGJ4cmVuY3Vq?=
 =?utf-8?B?Z0JPUFlTUDQyTWdWLzlDZmNOTTl1ajN2d3FoNHY0bDBvZVNZUkhHREVwcG9K?=
 =?utf-8?B?NnJyY0duaW5WczFjZzNDVmc2djR1YWd5RnlQdUNtUFN5b2doekFwZ1hjQ0tZ?=
 =?utf-8?B?eFRueFR4MVZaVGhoVGpzTnVWdmhMc1d5eGhSVW9MdkxyemJENEZHQVh0UDVW?=
 =?utf-8?B?NkdhL2tGNVZWcThmemc2Z2J3WktGQ0doeE01dG92UG9oUWhpWHJ0bFM5WEJp?=
 =?utf-8?B?WVBlV3dVWEVJaVNYZmR2eERVWEplQXh5dHZXMmpiM0QzQ0RSYk8vdkI1RVNY?=
 =?utf-8?B?Y0k3ZElZeEYxVFgwWXQzUXRNSVBuVUVPTTBWY3dFRXB1MnBLTGRWbGxvc3lI?=
 =?utf-8?B?bXZVSnVadW1uMEtCMGErdEt2VnUxTG83ZVV5U3dtYXA1M0Z0czVnRGtZaUNm?=
 =?utf-8?B?RDFqaktzeVdZRkpZTVJUL3EybXJzR0t0bVluRVRSaEdKbXFQamlhMisrbXkw?=
 =?utf-8?B?dG1ranJqSnZOZkxqbDA4OGR1QWZtWDRNNkZITnMwZytpWEJFWEFrM1VBR3Vv?=
 =?utf-8?B?bzB2Z1VvVXdvT2l4UHBRekNBdUIrQWhmMlZIbFRRR09BT1laN3A2alo3cFBE?=
 =?utf-8?B?NUJpb0tQWXA5VXFJUFJydjBVNG55dmRCay9yRlc1ZW0yc29INXUvZzE0UVVW?=
 =?utf-8?B?TnpZSXloL3E2cVV6NHVxNE9GU0lTUTVDSStBbTUrbGZwWi9KVFdjM0ptQk4y?=
 =?utf-8?B?clBoajJpdDhjNzlkVGFoNVlzYkFKQzQ4TlQ5VmE2THVIMlJjejd2Tm0za3Ez?=
 =?utf-8?B?cGdXZmd2Y2krUWwrbnBEMU1LZjFaN05pd3VrdVUzTzBsVFoxaVczMXRreUZp?=
 =?utf-8?B?QVkvZkNBYnAzSHRtbklmYnZjSS81WjJseDVWS2ZhaWY0SFJzSVNPREZnalpw?=
 =?utf-8?B?NkMxMXJrbGlPdkNHZS8rK1d2djU3dVBTNi8zOUdiTHE3Q2VtUHNjRXdla21n?=
 =?utf-8?B?V000amJzZkY2Rjd2V095T2krRG16aVZNSFJPdEladFlNd043VVp6S3VoWVow?=
 =?utf-8?B?ODM0WDFFek9uWDVueWdCNTh1dVEzemdnVGVXUzFkNi9XcThldDhaSEhYYk8x?=
 =?utf-8?B?ZDRFZFhkOXlEWlJscFdKYlc5M3pwRnllZXlWSFgxc2pWZTVQQVRkMGRxUnV1?=
 =?utf-8?B?T1V5L25rUmZqVStxZ2ozcVl4KzhxZWViaVordTZrTGoxS3JLeHc5aWdod3ZM?=
 =?utf-8?B?L3ZVdnRPVzd4ZWliaEJKZkNRaXgwWHY4MnpyQ1ZoMnJ1c1B0cGhsdUNYaGdX?=
 =?utf-8?B?N0V6aXZGUmZFdGhsd2lOeG1hYXpHTGk2NWl0ZjRLekFveGhGRWFxZEZ3Mjk2?=
 =?utf-8?B?RzByMHNtMEVJam5QTUxwemxuNTM5UnpxVi9yYkJLck5tQXZMYlZiMUJJTm1E?=
 =?utf-8?B?ZzYrQzB5R096czlQWW1iWWx0NmpKSjQ1OXNLOWVXSVB1TEtNRkR2dEJmSVU0?=
 =?utf-8?B?a2VRNkVRREhycXlxNXdiMzFEWnp4Ylg4ais0bWtkaVF3K210OUZRUVp0cngx?=
 =?utf-8?B?WjhVQ0pzRzhWN1Q2UTViZHZlWi9tRVdUeGoxa3ZVdU85dzVOOVMrUmdNK21Y?=
 =?utf-8?Q?m5dxpE+L6Vptyb973/Xn34E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CD0EC3F5DD5364ABC451AAF37425E3B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fF0EG9Bqa02DWf4ZVKN1PBFB1WrUEemopLY4hk6l4oLcsfxrHHBQ6zC+UiDXc0efuLPO/S6uT0xj3F2ZluWbpYDTA3uIBaf5MJE/9/VMRsLyOjOSutUYM290FNUT2qzSGRK6SrtTN9AYRTGmZAqeLNEr0acaH/ZDqF+XC/u/gsI70q6SRT7aYULVojCW5Yk79yMXQi6vAB7+HQgsgp1yQLrLI2CKS9p2CzTSdaNI1Kj+MOR7lP3lcpARrDnDmVCYTDVCg30bKb3D/bYKRKiJxsg6nm76NOHEuSqg9NfGIs+8v1v0CNoMnEmMTkYitJ0OCcAT4UcoNjNJqbg5GOLUuOEKI08G2MJC06HbJ4aV9J633JUq+RPqqHOhxssy+IeR+xy3XCMNXrBWNcGg8uJEmfx1GqnCtf+h9vSzv2zXUwyM+dpEQ9FJOFqfLbzolKShqnQd6S6/IBWJgzOgrUSJturK68moNPB8JYR9yHFWhzwrHrtg/WIao+5IbmiUlgpXu5vTGGQUWMOOxshMoNN/Xu3xCjEehmOCUTQ5kihLLNuYO292El2IZJEWOAZCkDjTa/vdUALoKxanx4YpT7/H6jlTMeS1U3vc09ZjrKsQ1F4TFMe0vXhK9qn/ZubRrDksukHwItXh6Un0YfcnwDcl86xZBQoPjNOII0S5p3RWknsTC54QUflVck/tVbKDAx0/Rg3eZFp+3zZC5K2GwqyZHsIPKnFqfEAkidyqQkiWs4d9WJXmWRDTbKmHH32v3Sr3I/XFZlcLE0UrdJcKecQv2EwbWG//3RJzdZHTuP1vtF7zCAx087z+zzDB+1/4RSZOrnx6s5CgjN25z34yNxc7L8oDnQY7cG7ZTnfvbIrdPN1Nh/g0M5p0jF2hdL+7FwjhTqOWWvKKswGPwJzUBtjDiNXxpBWHeFhus9MpYujQQ6U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7860.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711c1087-fe56-498a-ef5c-08db72765d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 16:41:29.7843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiGpSbaBT8XJ7C1lOsR+xw+k9IQxyi1bhH8alqKpJu8B08aOw4E44OPXDWkuBQPIK4yVLmN0s+uFKA06gjuk1vUp+HSMyX2xxqqv9UGu9QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_09,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210140
X-Proofpoint-GUID: dfF7l8n5TQ-xdIHKud0evFnMavcVURZQ
X-Proofpoint-ORIG-GUID: dfF7l8n5TQ-xdIHKud0evFnMavcVURZQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hlbiwgVmluY2VudCwNCg0KPiBPbiBKdW4gMTMsIDIwMjMsIGF0IDExOjM3IFBNLCBDaGVu
IFl1IDx5dS5jLmNoZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjMtMDYtMTMgYXQg
MTk6MzU6NTUgKzAwMDAsIFNhZWVkIE1pcnphbW9oYW1tYWRpIHdyb3RlOg0KPj4gSGkgVmluY2Vu
dCwNCj4+IA0KPj4+IE9uIEp1biA5LCAyMDIzLCBhdCA5OjUyIEFNLCBWaW5jZW50IEd1aXR0b3Qg
PHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPiB3cm90ZToNCj4+PiANCj4+PiBIaSBTYWVlZCwN
Cj4+PiANCj4+PiBPbiBGcmksIDkgSnVuIDIwMjMgYXQgMDA6NDgsIFNhZWVkIE1pcnphbW9oYW1t
YWRpDQo+Pj4gPHNhZWVkLm1pcnphbW9oYW1tYWRpQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+PiAN
Cj4+Pj4gSGkgYWxsLA0KPj4+PiANCj4+Pj4gSeKAmW0gcmVwb3J0aW5nIGEgcmVncmVzc2lvbiBv
ZiB1cCB0byA4JSB3aXRoIFVuaXhiZW5jaCBTaGVsbCBTY3JpcHRzIGJlbmNobWFya3MgYWZ0ZXIg
dGhlIGZvbGxvd2luZyBjb21taXQ6DQo+Pj4+IA0KPj4+PiBDb21taXQgRGF0YToNCj4+Pj4gY29t
bWl0LWlkICAgICAgICA6IGE1M2NlMThjYWNiNDc3ZGQwNTEzYzYwN2YxODdkMTZmMGZhOTZmNzEN
Cj4+Pj4gc3ViamVjdCAgICAgICAgICA6IHNjaGVkL2ZhaXI6IFNhbml0aXplIHZydW50aW1lIG9m
IGVudGl0eSBiZWluZyBtaWdyYXRlZA0KPj4+PiBhdXRob3IgICAgICAgICAgIDogdmluY2VudC5n
dWl0dG90QGxpbmFyby5vcmcNCj4+Pj4gYXV0aG9yIGRhdGUgICAgICA6IDIwMjMtMDMtMTcgMTY6
MDg6MTANCj4+Pj4gDQo+Pj4+IA0KPj4+PiBXZSBoYXZlIG9ic2VydmVkIHRoaXMgb24gb3VyIHY1
LjQgYW5kIHY0LjE0IGtlcm5lbCBhbmQgbm90IHlldCB0ZXN0ZWQgNS4xNSBidXQgSSBleHBlY3Qg
dGhlIHNhbWUuDQo+Pj4gDQo+Pj4gSXQgd291bGQgYmUgZ29vZCB0byBjb25maXJtIHRoYXQgdGhl
IHJlZ3Jlc3Npb24gaXMgcHJlc2VudCBvbiB2Ni4zDQo+Pj4gd2hlcmUgdGhlIHBhdGNoIGhhcyBi
ZWVuIG1lcmdlZCBvcmlnaW5hbGx5LiAgSXQgY2FuIGJlIHRoYXQgdGhlcmUgaXMNCj4+PiBoaWRk
ZW4gZGVwZW5kZW5jeSB3aXRoIG90aGVyIHBhdGNoZXMgaW50cm9kdWNlZCBzaW5jZSB2NS40DQo+
PiANCj4+IFJlZ3Jlc3Npb24gaXMgcHJlc2VudCBvbiB2Ni4zIGFzIHdlbGwsIGV4YW1wbGVzOg0K
Pj4gdWJfZ2NjXzIyNGNvcGllc19TaGVsbF9TY3JpcHRzXzhfY29uY3VycmVudDogfjYlDQo+PiB1
Yl9nY2NfMjI0Y29waWVzX1NoZWxsX1NjcmlwdHNfMTZfY29uY3VycmVudDogfjglDQo+PiB1Yl9n
Y2NfNDQ4Y29waWVzX1NoZWxsX1NjcmlwdHNfMV9jb25jdXJyZW50OiB+MiUNCg0KQXBvbG9naXpl
IGZvciB0aGUgY29uZnVzaW9uLCBJIHNob3VsZCBjb3JyZWN0IHRoZSB2Ni4zIHVwc3RyZWFtIHJl
c3VsdCBhYm92ZS4gdjYuMyBkb2VzbuKAmXQgaGF2ZSBhbnkgcmVncmVzc2lvbi4NCnY2LjMueSAt
PiBubyByZWdyZXNzaW9uDQp2NS4xNS55IC0+IG5vIHJlZ3Jlc3Npb24NCnY1LjQueSAtPiA1LTgl
IHJlZ3Jlc3Npb24uDQoNCg0KPj4+IA0KPj4+IA0KPj4+PiANCj4+Pj4gdWJfZ2NjXzFjb3B5X1No
ZWxsX1NjcmlwdHNfMV9jb25jdXJyZW50ICA6ICAtMC4wMSUNCj4+Pj4gdWJfZ2NjXzFjb3B5X1No
ZWxsX1NjcmlwdHNfOF9jb25jdXJyZW50ICA6ICAtMC4xJQ0KPj4+PiB1Yl9nY2NfMWNvcHlfU2hl
bGxfU2NyaXB0c18xNl9jb25jdXJyZW50ICA6ICAtMC4xMiUlDQo+Pj4+IHViX2djY181NmNvcGll
c19TaGVsbF9TY3JpcHRzXzFfY29uY3VycmVudCAgOiAgLTIuMjklJQ0KPj4+PiB1Yl9nY2NfNTZj
b3BpZXNfU2hlbGxfU2NyaXB0c184X2NvbmN1cnJlbnQgIDogIC00LjIyJQ0KPj4+PiB1Yl9nY2Nf
NTZjb3BpZXNfU2hlbGxfU2NyaXB0c18xNl9jb25jdXJyZW50ICA6ICAtNC4yMyUNCj4+Pj4gdWJf
Z2NjXzIyNGNvcGllc19TaGVsbF9TY3JpcHRzXzFfY29uY3VycmVudCAgOiAgLTUuNTQlDQo+Pj4+
IHViX2djY18yMjRjb3BpZXNfU2hlbGxfU2NyaXB0c184X2NvbmN1cnJlbnQgIDogIC04JQ0KPj4+
PiB1Yl9nY2NfMjI0Y29waWVzX1NoZWxsX1NjcmlwdHNfMTZfY29uY3VycmVudCAgOiAgLTcuMDUl
DQo+Pj4+IHViX2djY180NDhjb3BpZXNfU2hlbGxfU2NyaXB0c18xX2NvbmN1cnJlbnQgIDogIC02
LjQlDQo+Pj4+IHViX2djY180NDhjb3BpZXNfU2hlbGxfU2NyaXB0c184X2NvbmN1cnJlbnQgIDog
IC04LjM1JQ0KPj4+PiB1Yl9nY2NfNDQ4Y29waWVzX1NoZWxsX1NjcmlwdHNfMTZfY29uY3VycmVu
dCAgOiAgLTcuMDklDQo+Pj4+IA0KPj4+PiBMaW5rIHRvIHVuaXhiZW5jaDoNCj4+Pj4gZ2l0aHVi
LmNvbS9rZGx1Y2FzL2J5dGUtdW5peGJlbmNoDQo+Pj4gDQo+Pj4gSSB0cmllZCB0byByZXByb2R1
Y2UgdGhlIHByb2JsZW0gd2l0aCB2Ni4zIG9uIG15IHN5c3RlbSBidXQgSSBkb24ndA0KPj4+IHNl
ZSBhbnkgZGlmZmVyZW5jZSB3aXRoIG9yIHdpdGhvdXQgdGhlIHBhdGNoDQo+Pj4gDQo+Pj4gRG8g
eW91IGhhdmUgbW9yZSBkZXRhaWxzIG9uIHlvdXIgc2V0dXAgPyBudW1iZXIgb2YgY3B1IGFuZCB0
b3BvbG9neSA/DQo+Pj4gDQo+PiBtb2RlbCBuYW1lCTogSW50ZWwoUikgWGVvbihSKSBDUFUgRTUt
MjY5MCB2NCBAIDIuNjBHSHoNCj4+IA0KPj4gVG9wb2xvZ3k6DQo+PiBub2RlICAgMCAgIDEgDQo+
PiAgMDogIDEwICAyMSANCj4+ICAxOiAgMjEgIDEwIA0KPj4gDQo+PiBBcmNoaXRlY3R1cmU6ICAg
ICAgICAgIHg4Nl82NA0KPj4gQ1BVIG9wLW1vZGUocyk6ICAgICAgICAzMi1iaXQsIDY0LWJpdA0K
Pj4gQ1BVKHMpOiAgICAgICAgICAgICAgICA1Ng0KPj4gT24tbGluZSBDUFUocykgbGlzdDogICAw
LTU1DQo+PiBUaHJlYWQocykgcGVyIGNvcmU6ICAgIDINCj4+IENvcmUocykgcGVyIHNvY2tldDog
ICAgMTQNCj4+IFNvY2tldChzKTogICAgICAgICAgICAgMg0KPj4gTlVNQSBub2RlKHMpOiAgICAg
ICAgICAyDQo+PiANCj4gVGVzdGVkIG9uIGEgc2ltaWxhciBwbGF0Zm9ybSBFNS0yNjk3IHYyIEAg
Mi43MEdIeiB3aGljaCBoYXMgMiBub2RlcywNCj4gMjQgY29yZXMvNDggQ1BVcyBpbiB0b3RhbCwg
aG93ZXZlciBJIGNvdWxkIG5vdCByZXByb2R1Y2UgdGhlIGlzc3VlLg0KPiBTaW5jZSB0aGUgcmVn
cmVzc2lvbiB3YXMgcmVwb3J0ZWQgbWFpbmx5IGFnYWluc3QgMjI0IGFuZCA0NDggY29waWVzIGNh
c2UNCj4gb24geW91ciBwbGF0Zm9ybSwgSSB0ZXN0ZWQgdW5peGJlbmNoIHNoZWxsMSB3aXRoIDQg
eCA0OCA9IDE5MiBjb3BpZXMuDQo+IA0KPiANCj4gYTUzY2UxOGNhY2I0NzdkZCAyMTNhY2FkZDIx
YTA4MGZjOGNkYThlZWJlNmQNCj4gLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gICAgICAgICAlc3RkZGV2ICAgICAlY2hhbmdlICAgICAgICAgJXN0ZGRldg0K
PiAgICAgICAgICAgICBcICAgICAgICAgIHwgICAgICAgICAgICAgICAgXA0KPiAgICAgMjEzMDQg
ICAgICAgICAgICArMC41JSAgICAgIDIxNDIwICAgICAgICB1bml4YmVuY2guc2NvcmUNCj4gICAg
NjMyLjQzICAgICAgICAgICAgKzAuMCUgICAgIDYzMi40NCAgICAgICAgdW5peGJlbmNoLnRpbWUu
ZWxhcHNlZF90aW1lDQo+ICAgIDYzMi40MyAgICAgICAgICAgICswLjAlICAgICA2MzIuNDQgICAg
ICAgIHVuaXhiZW5jaC50aW1lLmVsYXBzZWRfdGltZS5tYXgNCj4gIDExODM3MDQ2ICAgICAgICAg
ICAgLTQuNyUgICAxMTI3NzcyNyAgICAgICAgdW5peGJlbmNoLnRpbWUuaW52b2x1bnRhcnlfY29u
dGV4dF9zd2l0Y2hlcw0KPiAgICA4NjQ3MTMgICAgICAgICAgICArMC4xJSAgICAgODY1OTE0ICAg
ICAgICB1bml4YmVuY2gudGltZS5tYWpvcl9wYWdlX2ZhdWx0cw0KPiAgICAgIDk2MDAgICAgICAg
ICAgICArNC4wJSAgICAgICA5OTg0ICAgICAgICB1bml4YmVuY2gudGltZS5tYXhpbXVtX3Jlc2lk
ZW50X3NldF9zaXplDQo+IDguNDMzZSswOCAgICAgICAgICAgICswLjYlICAgOC40OGUrMDggICAg
ICAgIHVuaXhiZW5jaC50aW1lLm1pbm9yX3BhZ2VfZmF1bHRzDQo+ICAgICAgNDA5NiAgICAgICAg
ICAgICswLjAlICAgICAgIDQwOTYgICAgICAgIHVuaXhiZW5jaC50aW1lLnBhZ2Vfc2l6ZQ0KPiAg
ICAgIDM3NDEgICAgICAgICAgICArMS4xJSAgICAgICAzNzgzICAgICAgICB1bml4YmVuY2gudGlt
ZS5wZXJjZW50X29mX2NwdV90aGlzX2pvYl9nb3QNCj4gICAgIDE4MzQxICAgICAgICAgICAgKzEu
MyUgICAgICAxODU3MiAgICAgICAgdW5peGJlbmNoLnRpbWUuc3lzdGVtX3RpbWUNCj4gICAgICA1
MzIzICAgICAgICAgICAgKzAuNiUgICAgICAgNTM1MyAgICAgICAgdW5peGJlbmNoLnRpbWUudXNl
cl90aW1lDQo+ICA3ODE5NzA0NCAgICAgICAgICAgIC0zLjElICAgNzU3OTE3MDEgICAgICAgIHVu
aXhiZW5jaC50aW1lLnZvbHVudGFyeV9jb250ZXh0X3N3aXRjaGVzDQo+ICA1NzE3ODU3MyAgICAg
ICAgICAgICswLjQlICAgNTczOTkwNjEgICAgICAgIHVuaXhiZW5jaC53b3JrbG9hZA0KPiANCj4g
VGhlcmUgaXMgbm8gbXVjaCBkaWZmZXJlbmNlIHdpdGggYTUzY2UxOGNhY2I0NzdkZCBhcHBsaWVk
IG9yIG5vdC4NCj4gDQo+IA0KPiANCj4gDQo+IA0KPiBhMmU5MDYxMWI5ZjQyNWFkIDgyOWMxNjUx
ZTljNGE2Zjc4Mzk4ZDNlNjc2NQ0KPiAtLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgICAgICAgICVzdGRkZXYgICAgICVjaGFuZ2UgICAgICAgICAlc3RkZGV2
DQo+ICAgICAgICAgICAgIFwgICAgICAgICAgfCAgICAgICAgICAgICAgICBcDQo+ICAgICAxOTk4
NSAgICAgICAgICAgICs4LjYlICAgICAgMjE2OTcgICAgICAgIHVuaXhiZW5jaC5zY29yZQ0KPiAg
ICA2MzIuNjQgICAgICAgICAgICAtMC4wJSAgICAgNjMyLjUzICAgICAgICB1bml4YmVuY2gudGlt
ZS5lbGFwc2VkX3RpbWUNCj4gICAgNjMyLjY0ICAgICAgICAgICAgLTAuMCUgICAgIDYzMi41MyAg
ICAgICAgdW5peGJlbmNoLnRpbWUuZWxhcHNlZF90aW1lLm1heA0KPiAgMTE0NTM5ODUgICAgICAg
ICAgICArMy43JSAgIDExODgwMjU5ICAgICAgICB1bml4YmVuY2gudGltZS5pbnZvbHVudGFyeV9j
b250ZXh0X3N3aXRjaGVzDQo+ICAgIDgxODk5NiAgICAgICAgICAgICszLjElICAgICA4NDQ2ODEg
ICAgICAgIHVuaXhiZW5jaC50aW1lLm1ham9yX3BhZ2VfZmF1bHRzDQo+ICAgICAgOTYwMCAgICAg
ICAgICAgICswLjAlICAgICAgIDk2MDAgICAgICAgIHVuaXhiZW5jaC50aW1lLm1heGltdW1fcmVz
aWRlbnRfc2V0X3NpemUNCj4gNy45MTFlKzA4ICAgICAgICAgICAgKzguNCUgIDguNTc1ZSswOCAg
ICAgICAgdW5peGJlbmNoLnRpbWUubWlub3JfcGFnZV9mYXVsdHMNCj4gICAgICA0MDk2ICAgICAg
ICAgICAgKzAuMCUgICAgICAgNDA5NiAgICAgICAgdW5peGJlbmNoLnRpbWUucGFnZV9zaXplDQo+
ICAgICAgMzc2NyAgICAgICAgICAgIC0wLjQlICAgICAgIDM3NTIgICAgICAgIHVuaXhiZW5jaC50
aW1lLnBlcmNlbnRfb2ZfY3B1X3RoaXNfam9iX2dvdA0KPiAgICAgMTg4NzMgICAgICAgICAgICAt
Mi40JSAgICAgIDE4NDIzICAgICAgICB1bml4YmVuY2gudGltZS5zeXN0ZW1fdGltZQ0KPiAgICAg
IDQ5NjAgICAgICAgICAgICArNy4xJSAgICAgICA1MzEzICAgICAgICB1bml4YmVuY2gudGltZS51
c2VyX3RpbWUNCj4gIDc1NDM2MDAwICAgICAgICAgICArMTAuOCUgICA4MzU4MTQ4MyAgICAgICAg
dW5peGJlbmNoLnRpbWUudm9sdW50YXJ5X2NvbnRleHRfc3dpdGNoZXMNCj4gIDUzNTUzNDA0ICAg
ICAgICAgICAgKzguNyUgICA1ODIzNTMwMyAgICAgICAgdW5peGJlbmNoLndvcmtsb2FkDQo+IA0K
PiBQcmV2aW91c2x5IHdpdGggODI5YzE2NTFlOWM0YTZmIGludHJvZHVjZWQsIHRoZXJlIGlzIDgu
NiUgaW1wcm92ZW1lbnQuIEFuZCB0aGlzIGltcHJvdmVtZW50DQo+IHJlbWFpbnMgd2l0aCBhNTNj
ZTE4Y2FjYjQ3N2RkIGFwcGxpZWQuDQo+IA0KPiBDYW4geW91IHNlbmQgdGhlIGZ1bGwgdGVzdCBz
Y3JpcHQgc28gSSBjYW4gaGF2ZSBhIHRyeSBsb2NhbGx5Pw0KDQpUaGFua3MgZm9yIHRlc3Rpbmcg
dGhpcy4gRm9yIHY1LjQueSBrZXJuZWwgKG5vdCBmb3IgdjYuMy55IG9yIHY1LjE1LnkpLCB0aGVy
ZSBpcyBhbiA4JSByZWdyZXNzaW9uIHdpdGggdGhlIGZvbGxvd2luZyB0ZXN0OiB1Yl9nY2NfNDQ4
Y29waWVzX1NoZWxsX1NjcmlwdHNfOF9jb25jdXJyZW50DQpBbmQgdGhhdOKAmXMg4oCZc2hlbGw4
4oCZIHdpdGgg4oCYLWMgNDQ44oCZIGNvcGllcyBwYXNzZWQgYXMgYXJndW1lbnQuDQoNClRoYW5r
cywNClNhZWVkDQoNCj4gDQo+IHRoYW5rcywNCj4gQ2hlbnl1DQoNCg==
