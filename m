Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC9F73AF5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjFWEUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFWEUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:20:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209EB1A4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:20:15 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N3t2Er014967;
        Fri, 23 Jun 2023 04:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=uBzDiX0M0jMUIf3KJXOmxIHOcv0toa8irxABrAI2kMU=;
 b=Nk/rd4+xtlCnyktF5RoJmsYV1oAC1oolaWWhRlQIW3OrUbJh9WXxnyFSqOP+cLa9HAG+
 8I2ph60Rk0xvej0WKvWfvyVQDpXA34lKM/Do/sbCiyvBAbFgG9dBa4dsc8o3Phut8z15
 dEtTwu4mZf9RYiL1fyHlBlH9DyGTl9m2TuVJD69/sHNVXJgMHUEjb2GlFkMznuwgPgNT
 EVzomz8qUvJo46no6SPzpoey8z+RbLP9NSBEsgdAysvIYwpEOQFqhuXdBICq2brmYxbY
 8+Enrstvv6tdXYaObvpZSzNVF52i+K2CzYCxkNVbtz+zyzQA8lg59ghM/SLApS8bfUCO hA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etu9d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 04:19:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35N47Xqk007838;
        Fri, 23 Jun 2023 04:19:31 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w18ubha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 04:19:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuSO/CTbxKrGb8Tjq7KKFecRLu+vUnQJT1Us1J8Ml8SvHR2XEFYHv/lmR4jYsRFHwO0ufHuIRWAiOE6j5IKULNDbeFfs43gS/4AT9klis/jntsNboGGWgzlnUPo10doHNg2NJHq8QOpMILDZZ2gBsGZaKDB34nT7V9kIiJGdyGNM9XTRU1bSPRRNiHvyik1nLXMrJOc1spBpPpL6WGTTqwjvt5fpTJ9K1vghHGxNNT5W49k2Rd6uLpwkuaq4VN1Kw981j2jdQ4gB7UaWy6uNNAzgr+BTKOVpgh+FgdKJ8TI+OXccWB69Efn/gGvTUla+9njYg9oshtALEcxlUtsQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBzDiX0M0jMUIf3KJXOmxIHOcv0toa8irxABrAI2kMU=;
 b=IoayLUZ7un+TYzzf3lVK0NreMlkuD12t/Tniab354fkCb9gAu8rcVeAjXATvfQyj3mDzepifqWQDA6ElZ/HNB9LhoLZGSdAdqwt9jt6iAaLw/gy0p1AcxBSYMEzwcdfJLZMgIaiWr/TbHrsqbPyw6y/iW8YLm5JYa8J3tqY/CI9anKkWa7IROGHetFaeTxNMiJiUe3M9V50SkK7G0gLFxTOlIfeVd8nTIKAUTu2HIkqtv1MUhxPWKHb1mfCfzjH17vIDPj5P8ZIrbx8Z/NP+x3q9zXX7mvyPADXrlOTyM5xcLgaPVNZju5rezqESYk/Ij/bga2o9H/06//6IdDZqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBzDiX0M0jMUIf3KJXOmxIHOcv0toa8irxABrAI2kMU=;
 b=U8BnhGqyGOhaY22Iy8CK6Ri9oFH5tUp8md8xazmK1jwILdTEiRmTysjZ5582Ruf53SF7plNrIXK/NGKp7a/WUEvqTRJdSuaq8pfZmZL8XuBJu1dF4IExqJPGc6QrTXurWMyJDcjKTpMC0HnvwmTDEkGk/nGzsbblRKH/ppoCd0c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Fri, 23 Jun
 2023 04:19:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 04:19:28 +0000
Date:   Thu, 22 Jun 2023 21:19:24 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
Message-ID: <20230623041924.GA44732@monkey>
References: <CACw3F52k=fhYpLpvDoVPcmKnOALLkPsGk08PdS_H0+miSYvhEQ@mail.gmail.com>
 <20230612041901.GA3083591@ik1-406-35019.vs.sakura.ne.jp>
 <CACw3F51o1ZFSYZa+XLnk4Wwjy2w_q=Kn+aOQs0=qpfG-ZYDFKg@mail.gmail.com>
 <20230616233447.GB7371@monkey>
 <CACw3F52iG5bqQbvZ9QkkRkVfy+NbSOu9hnkVOt5khukNNG73OQ@mail.gmail.com>
 <20230617225927.GA3540@monkey>
 <20230619082330.GA1612447@ik1-406-35019.vs.sakura.ne.jp>
 <20230620180533.GA3567@monkey>
 <20230620223909.GB3567@monkey>
 <CACw3F53iPiLrJt4pyaX2aaZ5BVg9tj8x_k6-v7=9Xn1nrh=UCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F53iPiLrJt4pyaX2aaZ5BVg9tj8x_k6-v7=9Xn1nrh=UCw@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:303:8c::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1f2971-a80b-46f0-361f-08db73a108f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNXaY8HYpUfsGB+cMCJNEDTDng1ltzcWINLPgrQP+OZQ6RAcNOlMqPDS15AP9e4hlOZtn6H1RhBONLI0oeyvL9cyhR7qpQW25bFElDrzZhL+nHOh+n4BaGlW0XGB3ncoHNg9LsLnKgN6EAhM504vEzkx4VKRaX07J3Rnt8HkEdnQuKfd2eKY4DZCbOz9eOVTUU/x6pPzhTaqgwaxt+yH6soLo8mkS/2xiHeBSag24xQ/nvc3YH1TQ0iKUT8qZEWDW3LkxdPrw1ytJGUr7BVx9kkEbvGxjTosNUiZh+PFC2M+CXqXKtCH6EahjU3Whp8+rndfALeKVfjnVPC9sUnlqvQkbRqKJQSIppFMM/d/U0vk/DN+becxhFzsl3H+ncPD/GnPg7RX0BikHSrkxz8zxv8B1ygmMvCwCfaTeHKcikCK2Iy2pwrr8asGoz/MMHXNBHBX2K43IRZV8SKYBhFDJ5+EPKkobsNV3oPYj6btIdO+EQrsg3aNv4uAXV+HIMVDAlCuRT9sjd/520H8AZQXPzaFv/RZe2kadJPZQB9rf20=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(38100700002)(83380400001)(6666004)(316002)(86362001)(6486002)(478600001)(966005)(2906002)(54906003)(44832011)(186003)(30864003)(33656002)(66946007)(5660300002)(33716001)(9686003)(66556008)(4326008)(66476007)(6916009)(53546011)(7416002)(1076003)(6512007)(6506007)(8936002)(8676002)(26005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGUxL1hWMTZ3dytxcmhBRzJhN3g1RkdZV1YxQWVMS3VONUl3Z0NxczBacVhy?=
 =?utf-8?B?a2FVUEgyRlhmN2VxZnlUMnV1Vmo0cnprc2FzS1RSZlR1VDN4Q3FVVGgyZHhI?=
 =?utf-8?B?K2FxZnVPSGNqZTNDaHorTnNPbVJVMGRXb0dRajJ5dm02aSswRUFsS2U4NXB4?=
 =?utf-8?B?TysycVZJZXRJbnROMWdLVmx3RmVScVl5OVNxMi8ycW0vQllGTk5ZZ1hBdkc5?=
 =?utf-8?B?OGVZeWxoelZHVXdqUE9aSEl2ZVpuZVZydExQeDhaZk55Nyt1VGRGcmozVWY3?=
 =?utf-8?B?Tm1BR3IzWlhpUmdUV1pvSjAvOHk1bDUvMTBLRXN3NjBPeUh1SW5ZcU9qcnd1?=
 =?utf-8?B?N3c4dGZ4SjdRWlRzV3pzM0NnMHJreFg1Y0RVRzdQQXF4NUtRNEJKWUdZWWpj?=
 =?utf-8?B?bHZpTFdWRTY4SUtZa3ZEa0FXTlJvTHJBZ0dSR1RtSVp5ZDR3SUhsNjM3d0N3?=
 =?utf-8?B?Z0pkcXlOcFcwQTdSRDFydWlRQmFRSlNhcnc1a202Y1NWYlczU29QTFRqc1NO?=
 =?utf-8?B?bUpybzhXSFlMYWN4L0dwV21rcmV5SzhvNlFlZ2orMVE2NFdVck53N0lzOC9y?=
 =?utf-8?B?d2ovYUlDRjdTdGpRTHRUVjNBOVFHRk14M1VrOU9ORE5lY2VYZFZHMDE5OXBl?=
 =?utf-8?B?RmR1WWd5ZEkrMTVJUy8yRHZqNmRNazlvQ2dCSUtENk5VVm1VSDRoVGZacndS?=
 =?utf-8?B?dVByckc0aXlhNmwvbTZKT2lVdjg2b0pqSFhFSFZ4QmR4NXhxWDd3MFB2SHlL?=
 =?utf-8?B?emlxeUt3VEwwWm9KMWErM2E5OUNiS0RwamZsRkdKaS9IMHJJS3VNczBPeWww?=
 =?utf-8?B?S0pqSVpxZExHYk9sY0xuMVMyOUxHOGgydDhCWFkvSElPelZINHJwRUhjQklj?=
 =?utf-8?B?VUlCNjVIbWlwRHlYdXdXZXVnc2JLOUxJNWJHTy95UGlzQkVrOU9VRmtsSWRY?=
 =?utf-8?B?Zk9NdnBJS0dLc213b3lWMHZXVWp0VDJNSVhOQlJnMzZVN3IydUxuTmNHSHFL?=
 =?utf-8?B?VHJabWFKZ1JaT2NnZkp4QUIvcXFvSkx6OWJSaEU3dVRtc2FCems1NE56bTVN?=
 =?utf-8?B?OCtzUyt3WUREdnBPKzNGbDBnS1U5aTdkQVhrYldkc0hHWWliR2g0UW4xSDJ5?=
 =?utf-8?B?dVUrWm5wYm9QWlhlRUNneGtJVUpKVTI5c0dobm95NlhISFBwRlJqN1VxT3d5?=
 =?utf-8?B?dGhjRmlKNVgyUEM2Z3ZHUm9CSWdDdXV4K3JOdjB0WVEyRW9OQ0tRek1ZUVgw?=
 =?utf-8?B?bHpwWjRzSkxRSS83NmQ0WHpLZGMrZ3MzWnN6clZQeERFVWFkMzdLK1oyZTg3?=
 =?utf-8?B?eFRzeFpMT3gzNTR0WHdPRzZScG5pOElheFRHY1ZNS05vZHdCK21DdkJ6ampI?=
 =?utf-8?B?cVlGbzU2cXhNRE5NU09vYTFiTHA5cDNpcGZrTDlhZVVuQ3lldTNBSmw3bzkv?=
 =?utf-8?B?VENnMXQ3M2xITWJ5V1pFTXhlQm11UjljNDYxRWxtZlpRTDNoT0FhY0pmSE9N?=
 =?utf-8?B?SGVvaVFNRU5NR3lnOVRUcVk5NnFGZUNmc2NCUXR0R1BrekpKbCtiemV3QjVl?=
 =?utf-8?B?QWc1L0MyUC9zQlppM3JqSDAyOFVLTHF3NnZZK2lKdUF6ZkdGaXdFZE9xZkUv?=
 =?utf-8?B?dDFJK0ZwS242bzlTRHRlVGxtSnlleVVYWVVDbVBWQjMwWGh1blBjWGVzejJo?=
 =?utf-8?B?TG1rNGM2MXVVamROY3RCVTB2UWIyTkIxMll6RVV5dC8xaVFidnJSelRBbjA5?=
 =?utf-8?B?ckZOQ1hBUFhyYVJiQ2xiN21lTDluM2M2ZmhoTFZmMGhyTWRDUFZHYnUwcGky?=
 =?utf-8?B?VmsyZHdzMXgzZ0FYOUp3SWxEdGMwSHd4SjA5enJCYlBEUElseDg1SUM5WjlH?=
 =?utf-8?B?Uzd4VFR2eDFaRTc5dnJSMXBGZ0RON25hQmMvbnhUS1hiSHlwblRXR2cyWThs?=
 =?utf-8?B?dlFVQ1ZDR3dlbG9xRXZ0YTRyb1dtU2VyRmFCTVBsdGFVYTk1ZUZ0QStDN2x4?=
 =?utf-8?B?UGNqTU9vUVhacUJyWkMwbzVRTWNER0h2d0JDL3N5Q3Raa0REb0ZjT2MvaUZM?=
 =?utf-8?B?aFFBbzZodlR2UFAzck9NbmJnaDZENHVnVmlYUFZLb2p0bmszVk9aRTQ3WTV0?=
 =?utf-8?Q?ksb2NsZ5mpLxkBbHbrkzJZ53C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RzgrVDFzbDVtb3B5VUhRSEhxU3hjTHM3dzRBd1hCSlRXZ2pEQVFkdXdzMHRF?=
 =?utf-8?B?YWhTQWxQYUhCKzBybGtWdmkyUm1OTm5WM3JaWjJnSzFDb28vbXJaZGNSaWJo?=
 =?utf-8?B?Q2lkYVFZNWQvWlhQNGRhQ3R6dzVBbDFRQ2tGYkVTaFlwMzIyYUFlZThVTVNh?=
 =?utf-8?B?REgxTU8wTy82YzU5TFJPNzJiYXk0MDdTZWdIZS9XcGtNUGhGSTk1cHJVY0V5?=
 =?utf-8?B?cExUMGNSOVBQTndlcjFDSjVmdkR1bnN5RkJVWnE3M21mN0FnYjdxM2JOMDMx?=
 =?utf-8?B?M2pyWjV4WHJHL1BhdERMWjc3NUw3SGErWnE3bHdQVktLZGVhUDZUaGlOZndk?=
 =?utf-8?B?OWdYaHFMNjBiclNqakdidUt6STZjOHJ1bnU0Tm1KeUMyOHZYWE01eHIzcnRU?=
 =?utf-8?B?WGczT3prWjhCRzMxUCt3M3NDbksxclNPdXNkRDVtMW5SaGthYmxpeVZSUThS?=
 =?utf-8?B?SVV1YzUyc3h5V3J6QSswQTlneFV2dzIzMWF2aVJLVkNmdnRMUFR2TmtxaStH?=
 =?utf-8?B?RnV3SXBPaWptSnJoUGIvT1lSbndBZlFYT1A2bG10NW1SOWFrUzNCNWlmbno4?=
 =?utf-8?B?Ym5yNHFoQ0hmemhuR3dlSWdCVDNlTitqNU80MHpPVHlDUU43V3g3M3BJVzEv?=
 =?utf-8?B?V3Nvd1dvb0NsRVdFSjhjaXBlZW9VN3dZSUdmSzZ5cnltQzZMSHhwT20yeXlP?=
 =?utf-8?B?RExHcnFTd2czeGt1MDZEZ1ZkMnZZbjlMdWR5WEorT0VPUHFoM0hPVi80RGNZ?=
 =?utf-8?B?cU1kVDV0RUtmMXFhbjNSS1pHRUpBUmhpcWhRenJpWlQ4NzBZZ2Yzb3RkVEoy?=
 =?utf-8?B?Rktoc1QzWUVRZFlCOWNUaVAyS3lNS1BEaytkcms0OXUvODJPblIxbUdIbW10?=
 =?utf-8?B?WDQ4dXd5VlZFelhFVllpNjJqcHBxSi9yRnFqMTdTRVJxTEllY20wWHJQNWFo?=
 =?utf-8?B?d2xDajFwMENGMnlOSkpnb01sNzEwLzVsZDhLck9XTFMwQ3lMZW1PbXE2RzVz?=
 =?utf-8?B?Tm1tYWVxRXB3b0pDa0lNUDV0NTFJSjN4Y0ZRM2g4bWZwRnNBZFRiVGhMYTdN?=
 =?utf-8?B?d1VhOEJoRjFkN1FqVGFYRmw0T1FTaFFsM1ZudDVWcWlYd2p3Wmp2eG5NTmk0?=
 =?utf-8?B?U1NnTEFBdCtLSnkvZmZuUkF2WUxTclFTNEVBdDF2eFppQXdJVmc5Q0szT3lp?=
 =?utf-8?B?ZkpsTm01cnBKUTVVOFp5ZzBVMkxPUmt6dGJNZ2JtOThQQ0M1Z3o4anlzV0pi?=
 =?utf-8?B?M3hLL3ZSdUtIanhzd0twVW5IbW9HeTZHUTZ4Vk9tcEViM3NyY2gxSWF1VUJ4?=
 =?utf-8?B?RXhZaWZtOTREQkg5K091dGtqRHBJUDlhNjRaWEJsMEUzUFRLWGVONmJwS1hP?=
 =?utf-8?B?Z0daZHI2elIxenc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1f2971-a80b-46f0-361f-08db73a108f3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 04:19:28.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qHruFo/9anAOmx3yDKwuLRjc920JazGdb+Hvb1YE1fJVxZzeY+Wq4buf7mUVDhkWFEI5evK6g5KuxxtO4oV4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_01,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230037
X-Proofpoint-GUID: Y9amMVAm7JsUwbdVKcXZtBrZccuEVIVB
X-Proofpoint-ORIG-GUID: Y9amMVAm7JsUwbdVKcXZtBrZccuEVIVB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/23 17:45, Jiaqi Yan wrote:
> On Tue, Jun 20, 2023 at 3:39 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 06/20/23 11:05, Mike Kravetz wrote:
> > > On 06/19/23 17:23, Naoya Horiguchi wrote:
> > > >
> > > > Considering this issue as one specific to memory error handling, checking
> > > > HPG_vmemmap_optimized in __get_huge_page_for_hwpoison() might be helpful to
> > > > detect the race.  Then, an idea like the below diff (not tested) can make
> > > > try_memory_failure_hugetlb() retry (with retaking hugetlb_lock) to wait
> > > > for complete the allocation of vmemmap pages.
> > > >
> > > > @@ -1938,8 +1938,11 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> > > >         int ret = 2;    /* fallback to normal page handling */
> > > >         bool count_increased = false;
> > > >
> > > > -       if (!folio_test_hugetlb(folio))
> > > > +       if (!folio_test_hugetlb(folio)) {
> > > > +               if (folio_test_hugetlb_vmemmap_optimized(folio))
> > > > +                       ret = -EBUSY;
> > >
> > > The hugetlb specific page flags (HPG_vmemmap_optimized here) reside in
> > > the folio->private field.
> > >
> > > In the case where the folio is a non-hugetlb folio, the folio->private field
> > > could be any arbitrary value.  As such, the test for vmemmap_optimized may
> > > return a false positive.  We could end up retrying for an arbitrarily
> > > long time.
> > >
> > > I am looking at how to restructure the code which removes and frees
> > > hugetlb pages so that folio_test_hugetlb() would remain true until
> > > vmemmap pages are allocated.  The easiest way to do this would introduce
> > > another hugetlb lock/unlock cycle in the page freeing path.  This would
> > > undo some of the speedups in the series:
> > > https://lore.kernel.org/all/20210409205254.242291-4-mike.kravetz@oracle.com/T/#m34321fbcbdf8bb35dfe083b05d445e90ecc1efab
> > >
> >
> > Perhaps something like this?  Minimal testing.
> 
> Thanks for putting up a fix, Mike!
> 
> >
> > From e709fb4da0b6249973f9bf0540c9da0e4c585fe2 Mon Sep 17 00:00:00 2001
> > From: Mike Kravetz <mike.kravetz@oracle.com>
> > Date: Tue, 20 Jun 2023 14:48:39 -0700
> > Subject: [PATCH] hugetlb: Do not clear hugetlb dtor until allocating vmemmap
> >
> > Freeing a hugetlb page and releasing base pages back to the underlying
> > allocator such as buddy or cma is performed in two steps:
> > - remove_hugetlb_folio() is called to remove the folio from hugetlb
> >   lists, get a ref on the page and remove hugetlb destructor.  This
> >   all must be done under the hugetlb lock.  After this call, the page
> >   can be treated as a normal compound page or a collection of base
> >   size pages.
> > - update_and_free_hugetlb_folio() is called to allocate vmemmap if
> >   needed and the free routine of the underlying allocator is called
> >   on the resulting page.  We can not hold the hugetlb lock here.
> >
> > One issue with this scheme is that a memory error could occur between
> > these two steps.  In this case, the memory error handling code treats
> > the old hugetlb page as a normal compound page or collection of base
> > pages.  It will then try to SetPageHWPoison(page) on the page with an
> > error.  If the page with error is a tail page without vmemmap, a write
> > error will occur when trying to set the flag.
> >
> > Address this issue by modifying remove_hugetlb_folio() and
> > update_and_free_hugetlb_folio() such that the hugetlb destructor is not
> > cleared until after allocating vmemmap.  Since clearing the destructor
> > required holding the hugetlb lock, the clearing is done in
> > remove_hugetlb_folio() if the vmemmap is present.  This saves a
> > lock/unlock cycle.  Otherwise, destructor is cleared in
> > update_and_free_hugetlb_folio() after allocating vmemmap.
> >
> > Note that this will leave hugetlb pages in a state where they are marked
> > free (by hugetlb specific page flag) and have a ref count.  This is not
> > a normal state.  The only code that would notice is the memory error
> > code, and it is set up to retry in such a case.
> >
> > A subsequent patch will create a routine to do bulk processing of
> > vmemmap allocation.  This will eliminate a lock/unlock cycle for each
> > hugetlb page in the case where we are freeing a bunch of pages.
> >
> > Fixes: ???
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  mm/hugetlb.c | 75 +++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 51 insertions(+), 24 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index d76574425da3..f7f64470aee0 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1579,9 +1579,37 @@ static inline void destroy_compound_gigantic_folio(struct folio *folio,
> >                                                 unsigned int order) { }
> >  #endif
> >
> > +static inline void __clear_hugetlb_destructor(struct hstate *h,
> > +                                               struct folio *folio)
> > +{
> > +       lockdep_assert_held(&hugetlb_lock);
> > +
> > +       /*
> > +        * Very subtle
> > +        *
> > +        * For non-gigantic pages set the destructor to the normal compound
> > +        * page dtor.  This is needed in case someone takes an additional
> > +        * temporary ref to the page, and freeing is delayed until they drop
> > +        * their reference.
> > +        *
> > +        * For gigantic pages set the destructor to the null dtor.  This
> > +        * destructor will never be called.  Before freeing the gigantic
> > +        * page destroy_compound_gigantic_folio will turn the folio into a
> > +        * simple group of pages.  After this the destructor does not
> > +        * apply.
> > +        *
> > +        */
> > +       if (hstate_is_gigantic(h))
> > +               folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
> > +       else
> > +               folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
> > +}
> > +
> >  /*
> > - * Remove hugetlb folio from lists, and update dtor so that the folio appears
> > - * as just a compound page.
> > + * Remove hugetlb folio from lists.
> > + * If vmemmap exists for the folio, update dtor so that the folio appears
> > + * as just a compound page.  Otherwise, wait until after allocating vmemmap
> > + * to update dtor.
> >   *
> >   * A reference is held on the folio, except in the case of demote.
> >   *
> > @@ -1612,31 +1640,19 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
> >         }
> >
> >         /*
> > -        * Very subtle
> > -        *
> > -        * For non-gigantic pages set the destructor to the normal compound
> > -        * page dtor.  This is needed in case someone takes an additional
> > -        * temporary ref to the page, and freeing is delayed until they drop
> > -        * their reference.
> > -        *
> > -        * For gigantic pages set the destructor to the null dtor.  This
> > -        * destructor will never be called.  Before freeing the gigantic
> > -        * page destroy_compound_gigantic_folio will turn the folio into a
> > -        * simple group of pages.  After this the destructor does not
> > -        * apply.
> > -        *
> > -        * This handles the case where more than one ref is held when and
> > -        * after update_and_free_hugetlb_folio is called.
> > -        *
> > -        * In the case of demote we do not ref count the page as it will soon
> > -        * be turned into a page of smaller size.
> > +        * We can only clear the hugetlb destructor after allocating vmemmap
> > +        * pages.  Otherwise, someone (memory error handling) may try to write
> > +        * to tail struct pages.
> > +        */
> > +       if (!folio_test_hugetlb_vmemmap_optimized(folio))
> > +               __clear_hugetlb_destructor(h, folio);
> > +
> > +        /*
> > +         * In the case of demote we do not ref count the page as it will soon
> > +         * be turned into a page of smaller size.
> >          */
> >         if (!demote)
> >                 folio_ref_unfreeze(folio, 1);
> > -       if (hstate_is_gigantic(h))
> > -               folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
> > -       else
> > -               folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
> >
> >         h->nr_huge_pages--;
> >         h->nr_huge_pages_node[nid]--;
> > @@ -1705,6 +1721,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
> >  {
> >         int i;
> >         struct page *subpage;
> > +       bool clear_dtor = folio_test_hugetlb_vmemmap_optimized(folio);
> 
> Can this test on vmemmap_optimized still tell us if we should
> __clear_hugetlb_destructor? From my reading:
> 1. If a hugetlb folio is still vmemmap optimized in
> __remove_hugetlb_folio, __remove_hugetlb_folio won't
> __clear_hugetlb_destructor.
> 2. Then hugetlb_vmemmap_restore in dissolve_free_huge_page will clear
> HPG_vmemmap_optimized if it succeeds.
> 3. Now when dissolve_free_huge_page gets into
> __update_and_free_hugetlb_folio, we will see clear_dtor to be false
> and __clear_hugetlb_destructor won't be called.

Good catch!  That is indeed a problem with this patch.

> 
> Or maybe I misunderstood, and what you really want to do is never
> __clear_hugetlb_destructor so that folio_test_hugetlb is always true?

No, that was a bug with this patch.

We could ALWAYS wait until __update_and_free_hugetlb_folio to clear the
hugetlb destructor.  However, we have to take hugetlb lock to clear it.
If the page does not have vmemmap optimized, the we can clear the
destructor earlier in __remove_hugetlb_folio and avoid the lock/unlock
cycle.  In the past, we have had complaints about the time required to
allocate and free a large quantity of hugetlb pages.  Most of that time
is spent in the low level allocators.  However, I do not want to add
something like an extra lock/unlock cycle unless absolutely necessary.

I'll try to think of a cleaner and more fool proof way to address this.

IIUC, this is an existing issue.  Your patch series does not depend
this being fixed.
-- 
Mike Kravetz

> 
> >
> >         if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> >                 return;
> > @@ -1735,6 +1752,16 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
> >         if (unlikely(folio_test_hwpoison(folio)))
> >                 folio_clear_hugetlb_hwpoison(folio);
> >
> > +       /*
> > +        * If vmemmap pages were allocated above, then we need to clear the
> > +        * hugetlb destructor under the hugetlb lock.
> > +        */
> > +       if (clear_dtor) {
> > +               spin_lock_irq(&hugetlb_lock);
> > +               __clear_hugetlb_destructor(h, folio);
> > +               spin_unlock_irq(&hugetlb_lock);
> > +       }
> > +
> >         for (i = 0; i < pages_per_huge_page(h); i++) {
> >                 subpage = folio_page(folio, i);
> >                 subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
> > --
> > 2.41.0
> >
