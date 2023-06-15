Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4587314F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbjFOKLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjFOKL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:11:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4A71FDB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:11:26 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F9AV1h015397;
        Thu, 15 Jun 2023 10:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8dJALJ16Tn81vy7rqSzsB/VmIARogu655OQ8W1eLjgw=;
 b=Ga5zb6xTToOTmo7q5EMNXea7MWIyGrSKTm0k/SxTCkmFnzAXKPSjVY9CyUZ6Dpx5Icqn
 XJDXVk4YNLjdvPD1L4RTh6zvaVwnv2w3bV8kJuNzWpHEqzUg3dO4gUvwHTiO9mSakj/Y
 TNztztultVuSh/UYpxxeq4flbLcnLVDNZzio/8xO2FSVGBkAFlAFtNYc0CRIyxx5W+z7
 lx+ha9oeOMIN4Zeh3Lx/qwqYSBZjGLwAoV5h8bXFgArgiwxYpwcTfWFyxA8GT92+b4R1
 kX9gRZsDoGUxVwVvojNhtW09uBN0C5KfB1/92lR03jvi6arBLsHF1WrS5lChnUrmxeew jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2asjsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 10:11:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8tZXI021679;
        Thu, 15 Jun 2023 10:11:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6qudy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 10:11:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqwdLBIOqLDLau76/aE4DVRJrvPCaFUIIwHYtQeU0iU/sSjk3CPxgnbecAKRUz12L49F945ZCsuyLThKKSUTV/d42lUfk4HaNO6re/XNYcCNee9stpiGgoVUCY2vS9Xd9cNxrRMmGdtvhPUNKPoxXX6j5CrpUueO4K5jhcOhEFfkt1DziWZuP8qFfMxfxL4wbY7LCXkJtLItz2Suk8XFOwsQqt93lm9phM/n1nSJ0Frv1ni5YoB84ov3dBT5P0uEJZGFHUhXkbcvvbB59oiUf0lTRexCZrhgov4eWDkDTFF04day4T9vHDSciP51/0yGnZHyNHV+TQhhrDx6eTGWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dJALJ16Tn81vy7rqSzsB/VmIARogu655OQ8W1eLjgw=;
 b=RGRHZIanCGGSo/satiVrT65U4eGS2Ev5T4uu796g/I8wKsPsGTbHxFo1ItvpLcwO7rXjhkm7t4CtilfrsBdmvEggF6o7d7nYSMsG0R5RtCMOrccOxDZ2MnBpp7h5+1c86R6vpmIbQ02+9DMDsg1z4hRoNIsGYa2p1qr59+WODBoz1fLf+tlShUV/ZTXPMX8f4+yGuBwn7CrDK9f+30sWYHKwmy+yt5PvhvyOVght33JpTUyVlb3ZtXOPCmPWf7E13AFET+wCC44qftxuZVNnAd+7e7SD1ppa3OI4INMUosQjyTgcpTshMQyaPW/FN6VMtNBAUk1LJ3C0nt7cmOHdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dJALJ16Tn81vy7rqSzsB/VmIARogu655OQ8W1eLjgw=;
 b=OHn6YknysTwkT1Gnhu3uZZcswa6FKjiNEdEP9+R3k2XlNjvVvEVS4y87ULNfzaXzrf9OSHkYiQrgoo8/Y2B7SDRQvHVQD7mm+TSUmPedd7fo3U+43QczxK5F9Ka2m+vZDRF7oknlasW1mNehDPMrmTlzITWthrYIOu1OsG2agMk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5727.namprd10.prod.outlook.com (2603:10b6:303:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Thu, 15 Jun
 2023 10:11:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6500.026; Thu, 15 Jun 2023
 10:11:13 +0000
Message-ID: <568df53c-41a7-94d7-6662-f8f7c72e5178@oracle.com>
Date:   Thu, 15 Jun 2023 11:11:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
To:     Robin Murphy <robin.murphy@arm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <ZDk83vpIarQ9jWa7@8bytes.org> <20230613105850.30172085@kernel.org>
 <4f9184c5-e6a2-08da-f44a-3000b6cdfe35@oracle.com>
 <198a73b0-d7c0-57d6-5ef9-4e9dddb6365b@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <198a73b0-d7c0-57d6-5ef9-4e9dddb6365b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0070.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3a9e69-7697-41a2-6f46-08db6d88d950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7CJhusCnkqrCjYF+TGqNYQKTrmjKkyXWwDIVZiPEa5U4hFzOIUlC5C3HwuP8DQVW3RLDTtdL67ECpyEhf1rmHR76zZDLbDYP310V6b18TivTJf6pfaz2iSwubmDniOe/B1kDE/hzOEtCydkEkVxH8DvP3zlcTo7lO/rERviX6Yjvfb7EfCpX9zZzFv+RE+V24m2g0xKXN5S+k9Ptp+0bB1Dki9PW9B17q9o5mXU/pRjJHKIIqVZXzoucrbaY7u1/RwKFM060z9E9cIK81d06pMyukgPPeF8uXZJVwzGnHZC5R/Aqp5wX7jjlbfdBWnoaJ/xNpnoeyhXf8ZQIQPAHvfgryxonU+pAEdk/20Y91ZKXzGXEfdjE/M5ioiYrR7jbXZ1g/55I5Wsv8dzgmMPdkjZslqI2VNS34zFbGFBpH7V295vB93Xp1WgW/qFzhqILBcodzBfJ5Pcj4Jwyb92kvTyehApHuSO0haFYQty2/lDUzLzxJL0vzr7FrW5Q8jHeicMavjFp6blTQ573diQrBIjR59oMCtNh+KaBEAAEzU3QPsfn+h9hK2ipHVUsK0UNsYaZjxPekB6WG03lGWX0YRUKUSYIxLkCH/GjUH9Ycjft7QI+6KckLzPyOYSNMC/0yfRMP2FikYIX6k2upk0r5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(6486002)(316002)(36916002)(41300700001)(2616005)(83380400001)(31696002)(86362001)(26005)(53546011)(186003)(6512007)(6506007)(2906002)(38100700002)(36756003)(5660300002)(8676002)(8936002)(110136005)(66946007)(66556008)(66476007)(478600001)(6666004)(31686004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1VKU2hqNUFEY2VSdVpQWmx3WHJSSC92QTR2TTF4SDA3NzYzUlByd01nc0s2?=
 =?utf-8?B?V3lrOGp1WkxzSjFwK0MrdFdNNzY2amlENnNvSDFVL09NU3pRb1ZQUnNKeEFa?=
 =?utf-8?B?M092TW5wMnpmcVFHNTYvbWJ2bzhMa01tbmp5N3I3NlRGM3RGN2wwcjB0ZThM?=
 =?utf-8?B?cHFZaHh1cmNyeXpONUZhSk1YUjl3d0pWWmpDYi9GUkdMbmZ0QzU5MHNmbjZu?=
 =?utf-8?B?WDJOejdPUmJ1M1RkOTBCcVBlRkV1WnkycEdtbjNIQWRiR2N4QnN1Tm1taDQx?=
 =?utf-8?B?RmQ0c2F2eTh2VksrRWx0ZkQ0SEEvd0dpTGN6ZkRWTTE0YjRSSGE0Q1dUVnFU?=
 =?utf-8?B?R2M3SnRUSlBzejA4YkNYMkF3QzNKdkwrZmN0Qy9ITGlMc3QxODEzeDhwMDBp?=
 =?utf-8?B?T0lOSVNFc3QvMHVZaXdiN1FWZVdBellkODJPWVB0YnJxdThTaXNYLzdTTURB?=
 =?utf-8?B?M1pKcitLRk0rZm1qbzFiTzJQOEtrMCtFaFFLcE9FdDNhRDRVeU9zWHBTQ2Zn?=
 =?utf-8?B?SHlxQmQ1RTY1WDNiWEJ5di9lMnlLb3JvUDdGUGthdjVzOXl3VmpOdUtFTjRj?=
 =?utf-8?B?eDkxYjFzYlVmMTFSNm14eGVlSVViMHBKaTVFV25BN0Z5TTNPSytuRUlyYm1E?=
 =?utf-8?B?T3o0U2FwdzFUY3hFZ0tpWlloZjEwTkZwd1ZYODdWVUo5bFBCaXgxNGliNEJO?=
 =?utf-8?B?OHFwOGNPQ0VVaE1XZGNFUi9vZlBaVzVtSmxCTHNOclRHRXhFOGRyaHd3Z0ND?=
 =?utf-8?B?NUhCd1pwZG5RUFZYMlRtbXAyMEFKY29VTi9IQ3hhS056eUpMVi84dmRLQlE2?=
 =?utf-8?B?K0U2S2laUzhYZjMzNEhBU2VVTlRvZXI1MzZSTTVsa0dsTm1nbmdiREZsR0wx?=
 =?utf-8?B?L2Z3OWMyS1ViQnZJSzREaTBIZFhWM05vcmNDOFZ0R1hSS1dhNjZkWXRmU3Vo?=
 =?utf-8?B?RWZTcUhwU1Z0c3FHbUFsdFpRbXJuQ0hJeFNocXlUS284OG5TT0FBd2tJTXpT?=
 =?utf-8?B?eG1lN0hEWDF2dEJHYXQvdlZoM2s2SGhWb2lCWkdtSU43Q3l3K2llRzJPcDla?=
 =?utf-8?B?WUxYVXdvTVMvYkI2TVNsVG00cmVEL0JMeHUxa24rd1RCNkpKbVZUdndNcnF3?=
 =?utf-8?B?ZHBlZUVnOEMyZVZXM1kvSW50NmlEZ2VQUlBkVE5mQlM0NmZaTzBCY1ZuVGpw?=
 =?utf-8?B?ZjNYNzR3ZnRqV2pWdDZrWEpRbVRvNlBNZ0pTTDR4NnM0eENydFlTLzVpd0VU?=
 =?utf-8?B?NkprZ2s3eHBWREd2MFN0K3NuTTh6eURTWnJmS3ZnTmVDV1dZanlKMjBrSy9u?=
 =?utf-8?B?YXU3eHVNU2lLWGRuZWIxcU4vNTBlclVwbU9ZWFJ6TXFEMnpaNGJoOUlEZmc5?=
 =?utf-8?B?UnlHeFA5S0F3d3JzUE5QWk5DSHNNUWEyVWJwYnd6WjVqNmZwdHN4L0N2K3hm?=
 =?utf-8?B?elNUVHhtK3QzM3BVRFl5ZWpFVEtTWDJMaXhmUEMvSTFhWDEwVytyTlI5K2Nh?=
 =?utf-8?B?cGVvWHROdUd1bGU3aSt1U2hHYUJCK2dGY0k5bW54UWNmMUQxS2F2Z3hBNGZM?=
 =?utf-8?B?cUdGeUxMT3pYeTdkaDYyLzFQRkY5VXkzSC93N21LeVNyaHdjYlZxa0JZcWl4?=
 =?utf-8?B?UndBZ21ZTnRPU1plL1IrcThvcHFQWUlzR21ZdlNXenlBVmlBZkZuZEpoNFNV?=
 =?utf-8?B?ZFdkZERhYXd5ZitYVnhYcUdnaktzTEo2dkhieG9iR3Y0ZW5OL3ZoaDkxOW5V?=
 =?utf-8?B?aWlnRlkzQWRIUVQwVFBET2dydUdCMlVHc2plOVl5V2hwaEg4NFAwUTN4Y3hU?=
 =?utf-8?B?QVBSdDU1Z0pCZjBrcUJoa0Ewa045amJzTmd1amhSZUJEMVloVGdqMk9UNTE4?=
 =?utf-8?B?MCtiRWdqaWFaOEpXMjhRaktlZXN3UVMralhEeTMvQW8xeUltSnNiTDdrVmwr?=
 =?utf-8?B?eVVhUEdrVzdETTNURlNrKzFUMGVtVzZ3aTFwRk1zMXFLOW9RbG9yUW9IaytP?=
 =?utf-8?B?UzJOMEp6Tkd2ZkU2SktsVjErTW1uelhERjVkMmZyR0lyQkxzYXE0Z2VKMHRH?=
 =?utf-8?B?RVV6M2JEN2lmYmhuTzRVTWRxNGdCVDk2V3BkZFlRWllEa2xqSEgvY3IyQ1hs?=
 =?utf-8?Q?+aCb625H6L6mfuFKqeSAb5U3K?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ei8rS3lqdlhORk9IS1ZRcjJ2K0w4a01Pa1JnZmsrNUkyV2FnWGJlR25xa2xE?=
 =?utf-8?B?WWQxUllUa0IxYVhnSUpIV29IOUJkTDdJNG5TUUpLd1R3Q1c2Ylgvb0d0MEhm?=
 =?utf-8?B?VnY3Wk51MmkycWk0ZVpQcThySHc0M0JwR1ZLUzJkVjZOV0xuZUkwM0dhd2hn?=
 =?utf-8?B?QTRGY2prOHhmYjhaeWJibUg5Z3BlZDl3Wm1nZ1NmbzFUdGNzVktxblQwaVpR?=
 =?utf-8?B?emZCTnV4UTAvWUF6SWZONGZ2bmJtUUI3ZXNER3E0bUdqeHRxR1ZIaDBPL2d3?=
 =?utf-8?B?a1BKUnhHQ3pWYUhvdlZBWWUzV2QvNzNtdVJRVnJSNjJwRm52dDJjQ0lOcVNh?=
 =?utf-8?B?UXl2bVgvMDlPajM4NnUwYVlVTVhFRm55S0dZWW9SZEdoaE8ybE5meXNYcWtn?=
 =?utf-8?B?YTFOblJtd29veHltc0h6eVhjTjlieHp2RDJSQVMxdDdpWERtT3dXZThMbzBC?=
 =?utf-8?B?Rmo0RHlhS0dVb0lzS1JHQUdHd2kwZWNkRkM1aUpVZHZCVnZIVTdvYnp4ZnNt?=
 =?utf-8?B?Y0svVGJwS3pNSys3TE9mS08yQWZIVy95MWVaTTFid1VCUVk0VEdpL2J5bXVD?=
 =?utf-8?B?S2ZtZUlZaHFYSTJOSk81K25rdThybFVwVU9VbFNzRk9xS2ZLUHprbDl6U08z?=
 =?utf-8?B?OU9odGlTbm0vZ3B5Q1F2c0I1ZC9uc21hSnRsUytvNHpteW5KaDRTZlFWdGlI?=
 =?utf-8?B?emdjTFF0T1VXNjFzOWxwT2dONm8rYUlnbnZMV3gwTGkwemFMSjFLWmtzYXo2?=
 =?utf-8?B?eDFEMjZNdWN6TTQ0OXV3R1I0bnFOVjJlYjJsbHNpTkpmWVR1OEg2TUVzTkUr?=
 =?utf-8?B?bTlObkI3VmZXYnhoZngzT2w1aGdENWJMWDZPTmMzeUlDbUJjQ29yVWxHam5Y?=
 =?utf-8?B?eUxYMHRoOEZraXQyM09oM1pnbGdoV3FxL3p0anVrN3lUN2dmNnZuZ1dtbDNE?=
 =?utf-8?B?c0xTazZJK1pIeEtlYkFZVENVQjZXRnBnTkF4T0V2M1VrSkYxUUVOc292SVRa?=
 =?utf-8?B?WkI2NlVyUXdnTDM4WlZCc0JKc0JNZmhDUS9FeWd5QU5IQ0VxWndtQTNpQkZs?=
 =?utf-8?B?VXVMTEFNZjFPR2RrOFY4NXcyUGxKYWp2TG45Y1FGMlJnbFZSRmRTMXBVN21E?=
 =?utf-8?B?NURzMDdrTkIvN2lMNEFLdVFGalc1dVg2Q1dpYmZ6WWRKZmMxZ3dRV1BOS0ln?=
 =?utf-8?B?VVdhU0ZOcTZ6cmZHQVFldVVqVHZialN6NVY5QXA5NTZuc2gvR0V3dnFFSkky?=
 =?utf-8?Q?q6NT6itMy70zscy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3a9e69-7697-41a2-6f46-08db6d88d950
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 10:11:13.3706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAh0gQoBPt3YeUUdqrQ2RPT+mmPqD7d2GkQ+sjS5hSnh0S8xHkG8UK7ALuHiXE0uenbbR+HzMwruVLW+87Purg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_06,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=550 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150087
X-Proofpoint-ORIG-GUID: NMG5eBQJViD61vaxn_B7enbhYPgFvwDS
X-Proofpoint-GUID: NMG5eBQJViD61vaxn_B7enbhYPgFvwDS
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 10:04, Robin Murphy wrote:
>> Since we're at rc6 time and a cautious approach was wanted to merge 
>> this change, I doubt that this will be merged for this cycle. That's 
>> quite unfortunate.
>>
>> Please note what I mentioned earlier about using 
>> dma_opt_mapping_size(). This API is used by some block storage drivers 
>> to avoid your same problem, by clamping max_sectors_kb at this size - 
>> see sysfs-block Doc for info there. Maybe it can be used similarly for 
>> network drivers.
> 
> It's not the same problem - in this case the mappings are already small 
> enough to use the rcaches, and it seems more to do with the total number 
> of unusable cached IOVAs being enough to keep the 32-bit space 
> almost-but-not-quite full most of the time, defeating the 
> max32_alloc_size optimisation whenever the caches run out of the right 
> size entries.

Sure, not the same problem.

However when we switched storage drivers to use dma_opt_mapping_size() 
then performance is similar to iommu.forcedac=1 - that's what I found, 
anyway.

This tells me that that even though IOVA allocator performance is poor 
when the 32b space fills, it was those large IOVAs which don't fit in 
the rcache which were the major contributor to hogging the CPU in the 
allocator.

> 
> The manual workaround for now would be to boot with "iommu.forcedac=1" 
> and hope that no other devices break because of it.

Thanks,
John

