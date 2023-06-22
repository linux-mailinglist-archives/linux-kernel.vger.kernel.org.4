Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B6E73A57B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjFVQAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjFVP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:59:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7321191
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:59:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7pTR9025384;
        Thu, 22 Jun 2023 15:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=88OASTzvSHuB5C7ACMdbD9yirGED7lYMP4A+A82Ug5E=;
 b=kEbp9z7NVH4hs2X5Ef/H7nnmpyBz8rOftQ39Je9DceUvtv2RMvQMk+YeGwRWte07gBwn
 nXpxzdIsts9y0wTv3F1/6pL9qRz4XbocCOb0jdCn/mVYIRq9jzTTbHKEsmBlTV2pPdmU
 C7O4+yUx4g8WBbYb/8UebTUuZlTGFj5eZ8gkxK+wPgnBrCVJzZppbE0HMVOsD/5KMzTu
 wSnZut4lJSA/x+8ajsJvuW2wjoO4RjJxouJaGUdUXMKf0j6gFxIlkvmXEuz0VEg/7L4P
 4BsxTCTkrF5ePfcYMu7UnH8ClCwHsrWv8wRpBvs6tMouBcHKssyJEAn3jCQ6f7ZS11UA cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95cu23d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 15:59:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35MFp9LC007762;
        Thu, 22 Jun 2023 15:59:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w184p2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 15:59:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiPRtCg3LIzbKM2dic3bClRiI8/yblGuFGUU2ozGRSb2TXCEVhvjLFiJy+Y1vMkrCoiYsPoKODhJJ8tVp8o68Fq4moMiGddJmvO9vt26fC6dTehM1+4cqaCy8yVlW1Kl1Q4jwvEgrmCph8e3MzqBl1VBuoukbLJNioMWnRVj/Wkp44qx9PwRTC7iPOeVra7BwLlgoSROYd1G0SMqhK5LXHyIup1oV+eB7tbBM1pPsk/P9hZSqJ75A8Xl4pb/KSlYSc7hhjQqYwXlKZp5r6ZTpZmYZtoJ3Qagw2LsF0PCVVTME0Vin5PFeNbaPzIFluWfn8ztr8B+LKnTYqFOZasrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88OASTzvSHuB5C7ACMdbD9yirGED7lYMP4A+A82Ug5E=;
 b=GzBpcsm5esChWkR6PydTrIGYP4KA3qV3CdHz5UJndYDWdUe8Lcwx0mmw0ueuW1viBF26TbJZHrW+dg3Jv5EdOYJ8zNCjl3m54/6QJ7RTE/2o7oW9lbUkR4FZ2tsw7g1n4FNHL8gDXYHyDgasKXxZw7RwWbu2iCuqrclHl2H6XomJIcAsSiHo4BCiOxGo46nIIitm/VxiiE7aP0p63YWKhApEK5CwGp2+X4i6fTAx2jxvhfVFY/T081PyLPQEg9bEzBHzD8wNxjD0zArrbddupxP6qe8AB27maFu3UplbP2WsHkWBHev0HXGAdI/lScmpLuts7E2OCOyGWlODTCo5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88OASTzvSHuB5C7ACMdbD9yirGED7lYMP4A+A82Ug5E=;
 b=Cs6pOVskNlDo/Va6MbyDe7/vgs+pRfpA/jJLjrzXxv4sLgaeptZQBiZmuj271EF/XTkhNJrx0zaJKAn1WkGzhsvd1MMIhwNwq1qvZC2L2/7GN/w0VbccAqagUygyP/CEIYV0Yfqg+/WnFnDFyGL++qyhYas/2N5iM5GubDr+g1U=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by IA1PR10MB7115.namprd10.prod.outlook.com (2603:10b6:208:3f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:59:41 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 15:59:40 +0000
Message-ID: <fdb94432-a14f-32c1-3e75-697924f76f25@oracle.com>
Date:   Thu, 22 Jun 2023 10:59:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fs: jfs: Fix UBSAN: array-index-out-of-bounds in
 dbAllocDmapLev
Content-Language: en-US
To:     Yogesh <yogi.kernel@gmail.com>, shaggy@kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
References: <ZJNDT7ro6OA4hYM9@zephyrusG14>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <ZJNDT7ro6OA4hYM9@zephyrusG14>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:610:119::22) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|IA1PR10MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: d33cb251-8668-49ab-3cd2-08db7339afba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwNDXgCTd3w4VLdY9GVTkwYbhSRHrQcitkcrjSmFqiUfsfU8hr9+eZWYeZVLSP1uhY82odo5TC4oT+2R/+lMNqGhvHLYnnwFlVLu92mNc7uAOcQ9wqWwW7vSnf3+nFNAT3dxwJHoVcnnnzV+/s4kEoGP5u6RnIOFZoHMGGBLzOvbyb8ZZm4n9a+gdVxw8ENuDhFbCFnP/ZA3v2PsHkdHe6glf6zc//AbeWAptdDLOTaM9+bYGu8HFh412hTbEiGFU9GqJHkXIMpETeZKvqs5XEGx5nT20GVM9kv2FaUPG5X6snVPBa0FWmalIeXx69ml9/hUwauYOR2g/2WVYBos/IBy/0g/zSI8vi0rLB+P5xsaXy2W6U4lgbfFiFVaWf2w6H8CRQm/FX1Mf4jj7oSN2M97mfO0gvs+U+LziNhoEYg/iTqyyT258FW3T1I4Arlh5awx7yA5NsQSrtt66MK5i8WYEl6zBrlq7ogTb5dpsdd10R73/dtI+W6MbXrdjq5VSn1d/fzv167A67NTAqfMv3e5t5mwTXm83WuEjhItjOeumTB1t3YE3u6j5iLeK3GI4vp7JyiUTE56SUTbTO1E8wvJ5dhR8eNyDr9njGSghPUU6VhHag7XFzvYqh2/C35QrLaZywRO/y++BogU7gaznMnHXzfX3dT7LkDFiwwZtKLLetCiV9n7R7BKfxP1kpQeGlBkFHyXk7Z2uPIsDt2vjoB3wKomtZE1PKsSqBHjdYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(5660300002)(36756003)(44832011)(8676002)(8936002)(38100700002)(2906002)(478600001)(31696002)(186003)(6486002)(6666004)(2616005)(86362001)(31686004)(26005)(6512007)(6506007)(966005)(66556008)(66476007)(66946007)(83380400001)(316002)(41300700001)(4326008)(145543001)(145603002)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUVlbGs1U0cxcW5HeVgva2tTNGV2RW9xVlJtLzlxbEp0aHlBUStVTVMxYSt3?=
 =?utf-8?B?VFR3Q1c3VUxHaWZERytldm9BcCtwY0VocGpKcE1SRWNvRXV3RjBlaHZ3Rm1h?=
 =?utf-8?B?VmEvUHZHOG5BZ2RHTERyU2pwNGo5RFE4dHVJdEhTVGZVaGdyQ0Y2dVpyMVVD?=
 =?utf-8?B?eGVyaWNEa0taTlVycEVRcXBHbEdSdHRwNFk5eHlwOW0xWlNwV2l5OVhHWXVv?=
 =?utf-8?B?WkZ3UERoNysrUS81VDF2Mm5PQUMya2dTYVM5alJUSlcyMUs5Uks5TUh4MEFk?=
 =?utf-8?B?K2MzRWdNeloveE1yR2xtYWY5VGpMVXZ2aTlPZmZEZUd5SXF0RUVrNUljdTBs?=
 =?utf-8?B?VW9CZm42TWZHYWNvanI1bmRzNitTckMya21ZYkxnU2duTkxmWWJyUUEwalcr?=
 =?utf-8?B?MHdBSXYrWUd4MHFWRWQvRGlLMWI5QXU5UGpGbXd1SWNPeUUxMWVBV09OaXpj?=
 =?utf-8?B?SmVwaEJ1c3FOajBEMllIMTdydW0raGNyS1c0Q01qeWxLdFA1aExXUk1KUldK?=
 =?utf-8?B?Y21aWXBSN0F3RVdvdXh5dWlRdmwrcG0wN2p3QW03V1RuVCtrWjFXR0wwQ2dG?=
 =?utf-8?B?RnRqWVlvakNlaG9RclRJVHIwZk1wZzFlWEhERk4weHNhdzlXc2xwK3U2OGM1?=
 =?utf-8?B?YlJJNnNxeEw0NUVRdDVacVhQNkRORXNUUXVGSnFRMGlUNCtxZnFESjB3MFhw?=
 =?utf-8?B?NmpndmR5YitMbnVvWkFlNzVHOWRDQ1FqU3JwVlFLeTMvaFBjWFMxREpLRGhk?=
 =?utf-8?B?dmRPVVZ0TGJYQURxK0JKQ1RkeEpkUTVIUWRxS0pqdFg0bjQwdnJrK1VmNGFs?=
 =?utf-8?B?djYwd0pFNHUwb21tVU1RT2FmYzVKcVVIL1AzUTVzdkc0M1daVVZXRFBMS00r?=
 =?utf-8?B?THRIT2k1NWtYL2VueE5INitrSlpkNldFT3hmSzhodDRGc2pJR1pKSWdHV1Na?=
 =?utf-8?B?aUJRWHIyKzdITzJEV2NLQjY1cnhmSHpCaEFmZ0lMOGg5dlRlRXhqbGtqM21x?=
 =?utf-8?B?QkpOZStxSXZST1Q0cC9NSFBCWjF1Y3hFRlRpWk5rSkVRcmlhUS9xcWJhWEVo?=
 =?utf-8?B?VXFTTkgwcDNFUmMyM2xWclpoYnl1TUdEMGxDenN0bFRGaVF5UmhwYm55Vkp4?=
 =?utf-8?B?U2NrV3JVOWlYSkVmMGRxK2NiQnBLU2tOR2Y0REFXeGNCUFJNbk94NmlocHVE?=
 =?utf-8?B?aTF2b001UHN2dEtpNThkZXRYbnIyT0hlSDhrM3JMWC8wTmRnak95aHhTSjdp?=
 =?utf-8?B?VUlGZzZNTHZ5WXRoaDdtdlRlREdOOTdkck1RYjFoWGV0aXVwV2FIY1dQVkt4?=
 =?utf-8?B?MURKU2hlQXlObUZSTGdMRlFDN2VKUlJxeVBUS1U0R3NGUWFNbmE0TEYxVVdr?=
 =?utf-8?B?VUJzTmRvSE44WHhlODA0TXl4VU5jVmorYU56UlRiT2pydGpUbEtwdVh6L3hU?=
 =?utf-8?B?VVZTY3R2aFNya2k1WldRcFV0V05ET2tVdTJOazBYZ09xa2FLelZBN0h5N0xM?=
 =?utf-8?B?NGlDV0tmU2lkaURmRk1tYnM3RUcrQUk0em5TanNCcEd6SWhnaXJQRTVYdlBY?=
 =?utf-8?B?WHI5WnhDVmtDZ1RjY2gwalV2SlhaV0g1eFd4aG1uN1pUM3U2TCtSLy9hWENL?=
 =?utf-8?B?a2JyRGczeXhnTHhXRHBrYUE3Vko4VVZhL3Vyb2JYaTJPa3Vma1pyK3JkaUtR?=
 =?utf-8?B?RndFN1p4TS9BYmkzRW04VHFWYUs4bnRWNkkyZWFpTm9XTlpjU3VnUTRFb0VB?=
 =?utf-8?B?dUY3cjhPdmtRdzV6OVJkdUNvK2pSMllWWmJrL25qT2drUVRqM3c3S0pjWm8w?=
 =?utf-8?B?WjU3RDBVRkdqTWFDcXNZelFaS0M1YlhGa2dKS2RQU1hCWTdKZ1VMMmljY2tQ?=
 =?utf-8?B?YnVEYXgyTENsOGRPd3ZmWGRzWDhFUS9XTnBoZUpRdExvKzduWThIZXVNenU4?=
 =?utf-8?B?Q3kzV3BrMVRKTGxqVmVqLzNBTWgyRzBZTUp5NnRJY2h2RlZPd1kzRi9PdjFt?=
 =?utf-8?B?eUdCZ3NXVkdwSGdjLzkrTDNkdE5MTU1yL1ArdzQ1MGFIcTVjN2pwL1Z1RVpu?=
 =?utf-8?B?aVFib0w4UXNaeEg0K0xTVXQ1bUdGNEFSOWMzMXZOUmVZTUJjNm9BNFMyc3VQ?=
 =?utf-8?B?Z3NYMmNiNDJvMUlLck15Y3JEWHZXMWloTGI4alhJcFd1bXZ6YlBqZmc3NFE2?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dldLSXRiUld0dS9JSEpLeXlFVlJtc1JNZWcxWmZEWU0wN3Nsam9SVlBJT2ty?=
 =?utf-8?B?bDlrTWlQczF5OXhmQkJWcVUzaXVKeWVVQXJuQ1RJQW9VMVF3SjRzOGVGWEwr?=
 =?utf-8?B?M1F5R3pNSDBiYWxaSlJCVmFodlR6Uys3S0NJRktLRkF3R28rY2h0cnhKK29N?=
 =?utf-8?B?Y2tHWHFKTmNtcEI4YVNHSVN0bnFTRFNSOFVvYVhyT2lINmtLRmp5cnBsYThq?=
 =?utf-8?B?WGRmMHdoOGZjcnMwc2E5MXBGRGZOYkhTOGlERDdid0hjRlpnQngvYTQ2MG5n?=
 =?utf-8?B?RnEvSDNPMHpZcm1CNEJDQlJ3WGlNOFFSUjYvdmVkZVBqcE9DRW12NWJVQTJy?=
 =?utf-8?B?UWhBUDczWFBxejlmUkpkWnVSbFVVQU9yS0NaQjJvR3B4eTZQcnB4aHB5M2Ra?=
 =?utf-8?B?MURPVE5rRUVTa3FLckNNZGhUQ2J5UVBhTmlBZTdzRWZtWUFrM3VzR3Nja2Rp?=
 =?utf-8?B?d2N0WkJncDhBSlNqUlI0NjgyNVJnOTVpZ2FEQXd5ei9VR2c1bXlrWmhlTTY3?=
 =?utf-8?B?MFI2eGxBc3QxTlZuSm1PR2htMmlBYWE2c2JpYmlPK2c0d3BUc1VjaVVuRm0r?=
 =?utf-8?B?YjlRZ0EyVFpQWkFqQ3phSGRrUHMxRXZSaWFIclcyZXZhZ0xhaE12YWZJSWgv?=
 =?utf-8?B?QjdRT0JDWm01ckp6NS9hbFkzRzU5aHBGb3p5dXBFamRqbnduZ21nK1NMdC9P?=
 =?utf-8?B?NitRL05salQ4cFB6bElZL1ZZamhkaTR5RjhaS2N0WEEyY1VWaFdXK2VZQlc0?=
 =?utf-8?B?YysyaVhLMVVoTmpkRGFteGpSWTd6SFljWEpBS2ZDS3plUGpUaTQ0RjZPeXZu?=
 =?utf-8?B?bjdVVDdzLzBpUVZaNWw3RFIvZG1Zd21MaG15bDhYVlRuYWc2ZTZtRUR2OUFN?=
 =?utf-8?B?R2lTa1ZHWkQwRERZd21scjM3aXVNUXlab3k0N25DQnlRU2ZtbGVvRFVtWk5k?=
 =?utf-8?B?ZW9FWHlIdk9DK1dWbUZVVGwwcW5kbmFRQlA1VDBBYWFaOGJBMlhGNmE4MGJP?=
 =?utf-8?B?WUlYOUVvVEZFS3Q5VjUrY0pDTmtBa3dsTkZPVzlSeXk2YlVhdWZxZlNPbmEz?=
 =?utf-8?B?N3lXSVFGYmsxK2U0VFFQT1lHOHZ3SDdJSUdpbURLREMzZU1FY0wzVjlZemNI?=
 =?utf-8?B?QXhzN0dKR1BKdW9vRldZNXpYQmdLb2o2UTFXNCtGNnczeWREMStIaXdaTzM4?=
 =?utf-8?B?ZUxwb0F4bHRndis2NGhsdGlZMnlxUFB1VncvQmR0dGNOWGRrZ2JkUExNZkZZ?=
 =?utf-8?B?QUlrbW5KWFd1NjdmZ1pRa2pIVDdaUkI0ZDJYYVJxNEorQmZld2FuSTRCblhz?=
 =?utf-8?Q?4VYO5cijCtUs/FzUYFnLsDTWFeh4SYV824?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33cb251-8668-49ab-3cd2-08db7339afba
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:59:40.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZB/ZC6EleWePKtiO2c8g/56oT4X5GvRyZi3MTdfepI96aGYwzXoMZ3Q3kh7s3+gpfqwejeSxRImQM6y+cGzlzvskwGHzMpGQQwMkty2jblE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_11,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=439 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220135
X-Proofpoint-GUID: rK_nbW4C4P2g78RQRxDLn0C1ZxsgSSrK
X-Proofpoint-ORIG-GUID: rK_nbW4C4P2g78RQRxDLn0C1ZxsgSSrK
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 1:37PM, Yogesh wrote:
> Syzkaller reported the following issue:
> 
> UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:1965:6
> index -84 is out of range for type 's8[341]' (aka 'signed char[341]')
> CPU: 1 PID: 4995 Comm: syz-executor146 Not tainted 6.4.0-rc6-syzkaller-00037-gb6dad5178cea #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>   ubsan_epilogue lib/ubsan.c:217 [inline]
>   __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
>   dbAllocDmapLev+0x3e5/0x430 fs/jfs/jfs_dmap.c:1965
>   dbAllocCtl+0x113/0x920 fs/jfs/jfs_dmap.c:1809
>   dbAllocAG+0x28f/0x10b0 fs/jfs/jfs_dmap.c:1350
>   dbAlloc+0x658/0xca0 fs/jfs/jfs_dmap.c:874
>   dtSplitUp fs/jfs/jfs_dtree.c:974 [inline]
>   dtInsert+0xda7/0x6b00 fs/jfs/jfs_dtree.c:863
>   jfs_create+0x7b6/0xbb0 fs/jfs/namei.c:137
>   lookup_open fs/namei.c:3492 [inline]
>   open_last_lookups fs/namei.c:3560 [inline]
>   path_openat+0x13df/0x3170 fs/namei.c:3788
>   do_filp_open+0x234/0x490 fs/namei.c:3818
>   do_sys_openat2+0x13f/0x500 fs/open.c:1356
>   do_sys_open fs/open.c:1372 [inline]
>   __do_sys_openat fs/open.c:1388 [inline]
>   __se_sys_openat fs/open.c:1383 [inline]
>   __x64_sys_openat+0x247/0x290 fs/open.c:1383
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f1f4e33f7e9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc21129578 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1f4e33f7e9
> RDX: 000000000000275a RSI: 0000000020000040 RDI: 00000000ffffff9c
> RBP: 00007f1f4e2ff080 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1f4e2ff110
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
> 
> The bug occurs when the dbAllocDmapLev()function attempts to access
> dp->tree.stree[leafidx + LEAFIND] while the leafidx value is negative.
> 
> To rectify this, the patch introduces a safeguard within the
> dbAllocDmapLev() function. A check has been added to verify if leafidx is
> negative. If it is, the function immediately returns an I/O error, preventing
> any further execution that could potentially cause harm.
> 
> Tested via syzbot.

All this code could be made more robust, but this is good enough for now.

Added to jfs-next.

Thanks,
Shaggy

> 
> Reported-by: syzbot+853a6f4dfa3cf37d3aea@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=ae2f5a27a07ae44b0f17
> Signed-off-by: Yogesh <yogi.kernel@gmail.com>
> ---
>   fs/jfs/jfs_dmap.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index a3eb1e826947..839f1b67485f 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -1953,6 +1953,8 @@ dbAllocDmapLev(struct bmap * bmp,
>   	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
>   		return -ENOSPC;
>   
> +	if (leafidx < 0)
> +		return -EIO;
>   	/* determine the block number within the file system corresponding
>   	 * to the leaf at which free space was found.
>   	 */
