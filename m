Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BFE70D4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjEWHZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjEWHZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:25:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCF0109;
        Tue, 23 May 2023 00:25:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6E9n3018884;
        Tue, 23 May 2023 07:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MLx1/vIUWEMIoitYxBaG3qvOzVefDqHIUp8jGBcj1Hg=;
 b=XwYqMfUJyLV0Oy55IYjYeQ0uVjL/z71JuNQI9anDSF2BFYFYYF4YSk56YudvktELpKYQ
 GQuf//Gn8dvgfvkKhshKxyebgqaNortkI+vKLHSeQzcdJvs/l5AlMRj9zx2jBkrqBQqS
 9qfolPNlRhtP2cnMJmAKz8bvqp4fQFElPddQ7rzpQOKNYoZbHEhgBz9ZizFFEJGXEsWQ
 td6+4rOKWrnJ0VHF2mnsJYXC3pw4uqYENKmBDxNid8lGg6kTeca2Ve2xTr7BoKtZY1tX
 jXesChO7ZJMzGqIhInWRCEoQqFng33VspUjZNzIKbmXZW3ZeepQ9oR+VIpktg8dYI2+o GA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3qme59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 07:24:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N7Mt0l027122;
        Tue, 23 May 2023 07:24:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2d6tgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 07:24:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpZRp5s7TTOHXjYUYhhSDVXIqdvlG9aVXGron1JQnKt4qduQsHqZOsHR53uXtGmtItzaapZBBg7ylt0Z0Fj+0amHdwBXzQ2MCU9U75nKJOfhmC65xA35ysgHgFB8MY6YU7jaPkWugg4mUxXJ6Hjv6txRxVh2k8riod6o4PQuWe+9dB3ens5F28GEbMo2Obf7wcAYm/N4noDWwFH25KlTclp2q0YfxwF5/IJjIGV6E9XrlYQGZCf8mAninY8BShoVpfG2UC7QD15Kr3C2RKYjM41Uo74MaItplwyTQWwg2Mss0Q/3pUhDsmdhfRkppDHZ+FO1HB9UvgETTyjAzp6Elw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLx1/vIUWEMIoitYxBaG3qvOzVefDqHIUp8jGBcj1Hg=;
 b=DrkKaHA2Boad6Dwh+QFYBeUDRIqDh7OAUlvciR+Vo1Q0FLGvybQ/j0hV+Whbmw1/E7PAe38Hpa20gAF55QJYQxeOFqvQIVW1aIJS9XMVeCYA2N5iJorRGpzoeOOa5jsYFdCPebe9+AhQJGDKfya2wcbgbjnzDVPgR+m5fM1HJboFTDo55SWX46aqAeVj2+x/7o4pTufVZUclU36BvTKlPOz8wyGaBKca1Z+G1D+R1UiBA14CcFAt67uCoWBarrsERfsJgrov0GWQVJpHIet8Y/pFj91gc7mKS4AARAdkt/3gU6cuPV29JlJqnumMkn7e5Ezt0+D8G1O32Na7mACuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLx1/vIUWEMIoitYxBaG3qvOzVefDqHIUp8jGBcj1Hg=;
 b=CW+YQbvsJE3INdZHbYGoOqu19MyXv9/m1nMeUHLPpM0EIKHX39eB08w7QbzpsdMhzppoUQ+VO8JC+U48P0sruVdQ9EUTBzDlBauluCOs/fKx4dBDWGKb0CEHVQ2n3RxUhpnBlhbyl2930ck90AKkHbON4jeVUKZaYXIEbT+Y0nI=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ0PR10MB4560.namprd10.prod.outlook.com (2603:10b6:a03:2d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 07:24:38 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 07:24:38 +0000
Message-ID: <056d3f10-8e27-bfc6-8f56-8bd344fb7f11@oracle.com>
Date:   Tue, 23 May 2023 12:54:21 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 5.15 000/203] 5.15.113-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20230522190354.935300867@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ0PR10MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b99d07-94e6-4315-ac73-08db5b5ec431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHPeeNmKESls5y1SI3Oe3QafEyB5l/hGtacNGLZh9TpdIYa5soucTOtdZp0Kl/HyNADL4X+mw0k8hn5gxQEeqkXcYv3x6yZ0Fc0hD1Yj75B2Vpvrra6I4A11ei3h5AZxuFlI1hbdo02DHRiPHpQGgrKj7C1XG7j8ygON7zVtALcyB9+J0OZbW4RQHP5WD9VWNmHz/C704Ihafuj1xGSacrelPph3qxxzO4Hh06vRwQ+SUDoTkQZUeMLmhkDExYsadqPnfCxJLs36y4r2Sj9GE1HIOsR3P/BeACoFUoPedDa8Sh7MskSrh5uq9s+wFj66+BbZd8YXssBOSJafTsBN7h4QlqQHz2PrmnfLtQPYxz/GWZGrNB3GaUJPSxom7XIvmXkhPtfWUhym51p3L8XV7ipTIa794aSm/ZcaOJo00vDzP7tt6Imw9kRs4JawXrG808nTnUDOw6gqKDKaBsJqLo1U4elPaWfS6tkIrjhssym0zV1tcx6rNdk8ZeqTJWDGRtPfp6XfDCoiciy3jEbSNWoYDHyD30nRn/ptuqPNmtvw6gReX6TdMqRm+xQndnB7yffSzibnQSUP3GL6+ZzRQ9HlRVjnVH0dT/nXSwsjFjSevUn2O7htMYgrdoeBAd4duuxkD51HY7n7nevwkoNatw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199021)(8676002)(8936002)(7416002)(5660300002)(186003)(6512007)(6506007)(107886003)(31696002)(2616005)(26005)(86362001)(53546011)(38100700002)(66946007)(6666004)(41300700001)(478600001)(66476007)(966005)(4326008)(6486002)(36756003)(66556008)(316002)(54906003)(2906002)(31686004)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnJ5cWRzajgweW00VzVOczlJOGtFeXlxREpYdG8zSGZQQlJEWGh2aUsxYW1W?=
 =?utf-8?B?VDhwQzZEME9RVW9HSndCWjdlUW8zQkVscjNXMEVSWGhheEkzS1Mrc0I2bHBG?=
 =?utf-8?B?eko1cFBKck81QmtpTTdWMC9nUVBpRDhsQnl4T2NNaDlzYTFoS2FQcHRPOHlz?=
 =?utf-8?B?VmFaMEN4dVV2RmJDbVRrd1JEazB6VEVqNHh6WmlLYXFRdjNadWlFZGV2QVZE?=
 =?utf-8?B?T2RKUHJRajZVa1RaZDhueGhqdEI1NDVCMmNPcndzT1pLUUx2MG9KbTdHanFa?=
 =?utf-8?B?N2RmVWxmRE5VWGdoNFFMSkwvdFZzYnpoNDdRNkxnWUx5Wmc4RVFlOFcvMEZO?=
 =?utf-8?B?RytId0loaEJSNytyYWp5SXlFdWxiTlNYMjJhdTB0QzNza1UzNHpDYzByMWk3?=
 =?utf-8?B?Rm03NGVvUnBISzlET3g3U29obklld3B3Zzhyb1cyN0JDQnU1VUVRZmRHWDNL?=
 =?utf-8?B?alAxLzYvaHVsaTB5QnpzalE1a2c4bFJkV3IyU2U4MFBKMlNEYjdKc213MWNM?=
 =?utf-8?B?MVBEN3hFb1Z0czFrTXcxb1IweHNCWk9qRGw2SDhPV2lWTTlnSEVwQkViUEZi?=
 =?utf-8?B?akVwaFpma3JJeCtrL0p3V3ZUR0VCbEtDYWhtYkQrZk9Eb1hjeVVTOG1vbUtK?=
 =?utf-8?B?eGxJR2QvMktpZDJZTzdkVFNGMGxicUtFZjA1V1dFSlpVZTBCMWVDTmFWK3d0?=
 =?utf-8?B?WkRjVXRPR1BlSjZhamhZeC9XdEt4SS8ySjJTV0ZDOEFTSklwZDcwa3ovdDVR?=
 =?utf-8?B?Tlp6MkRKZFlqbUdvRFVtTWtuZDFqVGFJdkNaNnYxS2dSRVgwQlF2L3dNek1i?=
 =?utf-8?B?N2Y2Y1hiUWw5Q1E5RnJKWjl0V041OXhhWnNtM1B5eFZOR1RpN1JQck5kRFFz?=
 =?utf-8?B?MmJxREVRQktOSG1UZEVOcndNLzBQT0NJOWNtTlE2dGRRbnAyUit6elFSc0xZ?=
 =?utf-8?B?ZUdXaHk5cUZ5SVJ3UUY5dHo4dFZCdUdOVXgyQjBCaWI1TFh4NkJLbkRBZXhB?=
 =?utf-8?B?aWZvRVBwMzErZHNJaUoyOEpUUUFweDdkSDg4ZUhZVHRSb0pROVZXcVE5VVgx?=
 =?utf-8?B?TXd3dGZaa2xSbGdhZVVFaHZMMllYWEJ5Q0tQd2VlbUlaTlhDSVYzZ2RiUTNG?=
 =?utf-8?B?WHlodlVSeEU5dDA4VGdwRVRUcDdETThtaXpDZ2VCRU5WRytsaksvZCt3S1ZV?=
 =?utf-8?B?dzdSUFQrL2RzdDVKa0ltVFZPK3VSZEJ5bHNlRDJlelA5NEZuVzZOcmJFUEpu?=
 =?utf-8?B?citpYU54dk03NGQyRkVkNE9VRE93cmRaaGlzYjhhUkoxanI1VTBDMFIwY0dN?=
 =?utf-8?B?ejMwZUxiS2tmbndjbER0ekNGNmp0Vll5bnhOVkZRZzJMc09NSlBYMHp2OWVU?=
 =?utf-8?B?eVFMbHU1cE1yN3h0d2owUXUrRWNWbWZINS9ZZ0dPR3hpZWU3SHd0UkN1WEtZ?=
 =?utf-8?B?MmcyK2JTTjk3MUR0OUpEWXRGNGlFOE80QVlTR3NxOXczN2d3VlQ5RDJMS3FI?=
 =?utf-8?B?UWNheTFYUWZ5eVlBNGVNZTd2SFFObnlVSTNhMDhSRG5oYVRENURxMFZGa2pP?=
 =?utf-8?B?RzhYZnNYWmljRjZHb3EwNTdaZzZyeTl2SzFXcVBvTjBaVWtHVWRaSmR3WGs4?=
 =?utf-8?B?K1RqSW51V2M5OFVqWml5TGlMVkdBaVRDZE1ZeVZCOThYclpDY1BZLzFsN3RG?=
 =?utf-8?B?Tk8zTXUvVkkvRnFuN2xlUlRWSmtFL3c0RzlxQ3lBRnU3S1VFbGp4Q1RQeUNp?=
 =?utf-8?B?S3MyT3UrWFVIeUFGdkovU0YzZTJaekd5NDd1TGdwY2V2TEplVHZsanAyaGNN?=
 =?utf-8?B?R0VTbExUK1NBaTRSb3puMnFnc2htN0J6YzR0YVN5dG4yUWx3TWRyaG9VdjI4?=
 =?utf-8?B?Y2FuVXA0Rm5aaUppWVJ0Kys3c2VvbnVWYzY5MzNaay9rRnVTQXFmUEJXdGxP?=
 =?utf-8?B?UTdlRGhZMGVRZTFjUzd6MXc4ZlYvNjFyaFBmVjAvTnNWTENSK0lqR3FiQkdQ?=
 =?utf-8?B?TVJGbVp0UllyVG1xVkdsY0hEekYzS0p2SnZuRno2MU1qZmh2UWRia3p2VjVL?=
 =?utf-8?B?TVdJOVFHZjVCaVRhTnpsYkszSitYbitXZ1d2aTBGdFAyRGVaWU8zWjJRYnNj?=
 =?utf-8?B?VlhQNGNTMVIvSWpkRUZLVWxCalUyQmNTZGI5RDhjbmhMODVpUHNia05xem5W?=
 =?utf-8?Q?3VQhx+nk7b9H0x4ndTf6rk0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Uk1kb0VGZ3B5OHlBOHA0ZkQ3VG5lb3FvNkQ2V2dKbWZhcVRaVzlJMEU1amhS?=
 =?utf-8?B?WGZuWHJzVVlvanFtSkZLQmJ4M2JKRkhlYytsS1A3cWhzdzJUOEVTR25aQmZi?=
 =?utf-8?B?VmY2N1BPZ1ZyV29nQzltU21WUFdJdC9OTzdNUHZoc0M1VnZJM0JhSytkSkEw?=
 =?utf-8?B?Q252cEhDaTFqZW9BZGVJcnZDTDFCcmdsWUNFTjN1clI2Vk5hOTh0WWR0THJM?=
 =?utf-8?B?Nk84cHR5anpEa3ZuWXdXU1hRTlZGQXVwcUlwRmI4M0wvSEw0TXRXZGNVMWV0?=
 =?utf-8?B?Nko3czNORjRmTjVQdEpnUHNOU0YveitJTjZQcUZvaGF5S0VZVXJTbEdlb2dm?=
 =?utf-8?B?TTJDaFVZSTVQM1IraVRNbzlWMklhZU9WaFN6ck5wSGRJNWtvc245dGltNnhx?=
 =?utf-8?B?dkM2NTU5MnBJTlVXUmNwQkJ6VldpaGdUakFBaGtsUnJnZnoxWlVRN1AzdUVG?=
 =?utf-8?B?QmVRaUVzWmxXdFVoMzlMTGFLK2NsZ3QxczcybmxXRE1SemdBQnhzUXZHNTQw?=
 =?utf-8?B?KzFrWUVRTlBSa1hiUWdZaHB0cXBLUWx0amg5T1U2NlMzM3BoRmE2TGNKU0cr?=
 =?utf-8?B?K3hEaVlDczU0Nm1oelc4YUpYaDFzSHVYUElWWnU2RjNpWll6d2FtdzdDYjNt?=
 =?utf-8?B?RVhQQlpEaFFJZ2ZldENob3FUSWt4anRQdUhPZW1FZ1pla1hVK1NEcGxZb0Ji?=
 =?utf-8?B?SmZNQU5wc3lpUzVTdDk1T3FsME1YZ0dEVjM4YlN6V25iWDJ4UWlRUTJnejFG?=
 =?utf-8?B?eHZsMFBZSXd5bE4yR3VHU21HYkR2R2lYeGNOL2FCUnF5RGl1M2RmU256OTNT?=
 =?utf-8?B?Q0I3ellUNEJBMUc1RVE4V3gxdWNOb3E3Q0tOSjc0Rm1QbHhRVEtEQUtKR1NK?=
 =?utf-8?B?dDJwL25MUjNoOW44R0NuMk5QU0tvMk40ZmQ1d05nUjNUQ2JqbmNsb2NmOTFN?=
 =?utf-8?B?c0haR295VXNFeCtES0FxOU4xOWpkakVhVVE0MnpKUnpnbkZVV1NVZVN1SzNq?=
 =?utf-8?B?alVIeGxTL2JHcGRxMFlLR0MxNVVDTjcwOHFYM3RXSVE5bkxZQmUwRHJTTFdi?=
 =?utf-8?B?WEsyYlR1SDRmODBpV2JLV200VUVXa2xoTjFSRXBtWFVwLzZzR0ZiODhDckxN?=
 =?utf-8?B?NS9CZkRyQm1YWmRrYUNCZUxJU0ZBN3psSHNDWDJGWTgyYVFVdXNJUzE0WWt3?=
 =?utf-8?B?b1JudGZuMXgxMmV5bjJWRjdKUVNRTkVLU2NzVUo3WldFQk4zNEZLYXNTNGls?=
 =?utf-8?B?SmhIcmRoZzNSZnBGU3NwSUV2NlVEMUhqODdyTlFHd2dhZFNXYkVUajVYOWdH?=
 =?utf-8?B?ZFVORHhJN2pLMlpxd0VQV29BQTczRVQxcHpkNWxNMDNLOTVva1RackV5eVlu?=
 =?utf-8?B?dkFQRG9nc1Z3YjJjTWUrSUs1SEdIM0IvbXhmYnRWRUdXTXZKSFVEdmlCMktx?=
 =?utf-8?B?RVN5SmdaT2FwYzIvSXUxTEtlU0dkeGNBbDBLeDIvRGJlaWpHWExmcS9pTzV4?=
 =?utf-8?B?MXpQZURBSmtVeWtPbGI0RmtyN0FqMlAreTFUVkxVNEIwYkttOUQ4VkxLV3FB?=
 =?utf-8?Q?nbaFsaSwxNhKkj/vuxsLJPK/lqVdt7XZz6D9PSW9xaUKxe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b99d07-94e6-4315-ac73-08db5b5ec431
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 07:24:38.2862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlDQV5HEpOyyw2cyE7B9BScxCBmfESHg/4j8K/IKsecfCI3oaJOLR3Wc79r8yfxwqs3Jq1HbZGTRuzs9978Bx2P9Vs+FQ8chrV3ewZsztJpI24InQOpbgNNx0HrO21nM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230060
X-Proofpoint-GUID: AQsvc78uKVCa15r9uZgkj2HMB3H-AcYo
X-Proofpoint-ORIG-GUID: AQsvc78uKVCa15r9uZgkj2HMB3H-AcYo
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 23/05/23 12:37 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.113 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.113-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
