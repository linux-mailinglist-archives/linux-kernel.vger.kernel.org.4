Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D1B632898
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiKUPsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiKUPre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:47:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0994BCEB89
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:47:18 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALFaStM030862;
        Mon, 21 Nov 2022 15:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+SRD4lD9uKPkeelSxvKG9p9kOUbVe6YiEXNNCW+pVgw=;
 b=b8NNmbn2sLFeUiYNVMzSa/7SWYqsXmXm6yh267ocyst1/3jQQSj1zv3PkWJHXH4jvSnD
 Tr6gGruVIAckkAm+EMcvpZEWPFNCHqhxbS2iFVkcTn3G8wwppuLGx7zpoAwh1vhB2aBe
 +KeSL4w33mwP2cDLM/c7DSjPZibrITAOxK7zNV7iKWRJFJ0WfOGj7jtuZ4DEnSRBYGE7
 JklP3J9ba3cQ5+EUZPN0NYr1OIJgh9+gB13FiHWnDO7IIZkS9WLaw+dRIwQ36TyORuyr
 f2tKGMhBw5qEz2JRLtJ5rcXLsZ7L35HjAT59J1ghC1P/QL7B0VAms2pYzDr9nNLg25M0 zQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxr99n17c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 15:46:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALFVZDR038843;
        Mon, 21 Nov 2022 15:46:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk3vkum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 15:46:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEMv0pbklsVs1Zn6APTllJjyVNSmuJB7aesPGYuDpOyrvSmDDzFXnm8nHDWxXFJ6lDPeU5IJNsS2waBe//Ql0nWt99WrPinYunPErjSNXguSjGwSQrj7K+42gPNvJETdqR1RBYbk7dhDddDcjIJHffaQmQw0SZ9IVjatRrp3HgSWQV24yLhPNwi3/nr9EukEAtyT3ptaIfBrbpCBjaMd7k9zTagEEyqb4/C8zaxPSZF3PpA8u6xZcMeJTcDtj+ngg/MkCzEXSPRNZaybVu7/4J1E4tGyX93buLz+OYkc3LSYR6McdKMhimyBCjFRv35afL+2+DZm0d3S3Z/0uM6oZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SRD4lD9uKPkeelSxvKG9p9kOUbVe6YiEXNNCW+pVgw=;
 b=SP4jw4oWShPXm6GT/8OvT+Rt5BePaA6gbVal03LbahcRF/r4z5ROA/arygh5ajOZRKq6aOX64l6z7kzq9TQeyg5Ea9aDcC9sEt+tkoH5jhnnhd2czi2aWKkI2dWa+hzGBTbsYwYkS5wg+5CFfjhDnlnhlf8HAEObwnuz82X7SH9uZ+xL00MSSb5KSJ7c/ZAllm/yrQWRmsa3znto7JW/fyzPP8QW0xheH5U30OpCOU4AMM/fhXIhLR6otnCfENXf5vcTYA3DMazVIlYo4SNnjmkQKjlSZtRm2E/wB70wGpTvZG2/ODser1GDy4FHgglrbxjb4SA6hfHINOQagvngMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SRD4lD9uKPkeelSxvKG9p9kOUbVe6YiEXNNCW+pVgw=;
 b=xe6sD+aWprxPLhiCUf8oIEu+KS/GJT4h1+1CcGBTa2dNJOXmIMamiv27t6446/8zCu+bEisgyYgIfetJNl/6+/rydSGimH2ymdw+QXSkBjuXzMBdJCeVewy7i9lWx+sid9WxTskaZblbjvqOkBr3DsZ7q+aVvcELw4H4Ff9Gr50=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6182.namprd10.prod.outlook.com (2603:10b6:8:89::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 15:46:07 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%6]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 15:46:07 +0000
Message-ID: <03ca2e41-28d3-c546-4347-5dee7b7dca9b@oracle.com>
Date:   Mon, 21 Nov 2022 07:46:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH mm-unstable v4 10/10] mm/hugetlb: change hugetlb
 allocation functions to return a folio
To:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com
References: <20221118222002.82588-1-sidhartha.kumar@oracle.com>
 <20221118222002.82588-11-sidhartha.kumar@oracle.com>
 <380a57f3-d705-aedd-a0dd-6dab8b9f8e1d@nvidia.com>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <380a57f3-d705-aedd-a0dd-6dab8b9f8e1d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:610:57::20) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 8486c9ea-dc21-4d52-72c9-08dacbd78017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Byy82zlI5ZNzAiH9k8ZRVSNDCKkNW3E3Xfs3uI4um3JjQZHGnpOohA2wUKtDTxXeJf/U9pPJfCIbJ3Hp12smudR0U5+L93BGj+BBGm1D7cKu1esl3V5zkOxvQRr/pwDYTagMJHB3XPNa8qLiAA4rX35hkpzmuNflGfMQ1rJQNgHed/IG5qW834X73LltveLadmmQlsBQyrn92RZ1Yk9ONnozLKt7Zlns+SCsSchxjuJgOGyk50bf9+bxqZmy7WOdHwd9fyGz1rdPy/Nm8vRUMt7MNtVzSeNH7OZu8U4K92JS03G6A9uZEyR4rzluDApUoMqfCQqgVaoZd95GnJpBdxIsJ80C/vEOhbcx+dp3N9QUJjfr0s+8mKl4Ly15r4XZEkO454p1impvkT4Y4T5gDsdNX3qrGLxQ90kDJCj9I+MIsmemyGOzPHEPFXh38u0ki6hUNlqzVsS2JgFQ+1AElBQeG4oaZK2xBS8P/HfenQ9uksbIoqSHZhs6b2wsaeBYDCNnA9mryv1h2GRDgtlQYeCLwzncMfZQUd926Mf/gsBxLWn6Un9RrYTEygwtEbI+Ls4J4wYi7wjWS97TS5aceF9i/45JyguaughkHcWUovqPWhhoNBHBLpnAh5mvfMP0QvrQSsLEJHVLgtQvVWZGqOo4VTh61GKjZdIotf5fPy6iKtBIst4BtMzOVlShcieynGA49oYjHVx5jcNGvxK8Fr8MeV3O9nB3UjtK9pWSly0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199015)(26005)(38100700002)(86362001)(31696002)(6506007)(478600001)(53546011)(6666004)(5660300002)(8936002)(6486002)(8676002)(4326008)(66946007)(66556008)(316002)(41300700001)(66476007)(186003)(44832011)(2906002)(2616005)(83380400001)(6512007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEpwV3c2Ulg4bEIvZXdNcGkzQjJ6TGQwcGp0MGlOZys3T3NmZUhKdEhFY0FZ?=
 =?utf-8?B?VXdybiszU2tWYi9GU2c1ZTNpMFRsZjRGMjJRVTd5R3NxSXdpMUlNUU5KYk9i?=
 =?utf-8?B?blRNUmNpNTN4blVLellTVVpFWWMzQlJqd2EzbzlDbUZuZVg0UTUyRVVybUNX?=
 =?utf-8?B?MFNhd3FrVmNBOXp2YWdrbjN6WktualBwNU1rYmhJNkhtUUZEdGM5VjVlL2VV?=
 =?utf-8?B?SmRiOEJOWXMyOTUveENaNXZ2OTFyczArUHJXWXJvVFRyVDZIMllpRUJubnhD?=
 =?utf-8?B?QlNTK0l1Rmw0aHFJU2U4Nm1EQXU2NGtSTHc1R1lVOUYrNG5tSXkzWVlWTjBi?=
 =?utf-8?B?VGhqL3llZFpOblF2d0pBZUlVWUJHdXRlVC9XdkQzSjhWNWVXaU9tR294YVdl?=
 =?utf-8?B?TCt6cHpuL0RyM2R1N1N4STJlUG4wUTBzTTloZXVlSnc5N1NoTmRCZ0lNdVZQ?=
 =?utf-8?B?SFhVMUZFd2JXYTNtazdFRUZCTVVmdHYyMDk2V1NOOFhDcitpaE9xZnFDRHJa?=
 =?utf-8?B?cnFjdTNtb3hseXE5enI4MlRwVk1jY241VVIrZEtQVzk2Tm5OTVFrM21wamNu?=
 =?utf-8?B?aDhUZHkvOTJIeW1NenJhcTUwRXl6Tm92OGR3WTQzdzNLNno0RFZoWFJiQjVr?=
 =?utf-8?B?TEE5eXNwd1VhSEtEemh0Qzd2eCtOWGh5LzVkQW9NMDdBMUR2SThtcVBRNit3?=
 =?utf-8?B?MHUxQnNVWmVZblg3SzNiVktpL2JmT1Bqd01pdzZwSlI2NTNYWEZzMVg4bzN1?=
 =?utf-8?B?dWtnV0V4bXl4b3NUNVdGMTJISVdvcUg0TDlSSmUydFZBaGtLVDZRWjNLWXEy?=
 =?utf-8?B?K1ZLNk5nSktDV1hFQ29wVEI2T2pNemsxellleXQ1VGsrNkZEV05VNytzMWls?=
 =?utf-8?B?UGtBS2RaK0tmaDhCemg4M2ZKR09zdWJ5U3RzRjNYaDNSaVdNL0hKczNQcDB1?=
 =?utf-8?B?Z08zd1NNVnBvZzhKOXQ5ZHpTY0RoMDlFTmM3bmdGd1pKVXB6VVdaUnNta2c5?=
 =?utf-8?B?c2Z1K3pIcWV6YlFXdjBBajFvN003L0hBMzJSbkRDZEpWNlVBR2c2NHd6MEsy?=
 =?utf-8?B?TjU4S2FqbHhUWEZSYVhvcGphNWIwUWxzVmNYUEY1MForUXBWQXZZeCtSTHhF?=
 =?utf-8?B?NzZCY2hDSzA4elNUY21XQTdNQ2J5UTFxWUhaWGhTVHV5b2pmTUx2N0YxazZ0?=
 =?utf-8?B?aGJmZEdiVFU1a3Y0Q1UyaEtPbjlYc3NvRzN0ZjNOdy9GUlFVTW9jb0lQWjBD?=
 =?utf-8?B?MW94WW9vOVIwUHVuQVprQUZDckprWFpsU1kvSzlCUzh1czUwWCtueTBSb21k?=
 =?utf-8?B?dVBpWkk0OGtiWG9rekx6QTRGZGUzK1pjYnhIREJ2Uk41RERzQ0Q5MWJDQTJR?=
 =?utf-8?B?UGIvNUJEd1ZEdE0vc3kzMWt0b0lLLzhnVzN2RTlIbmM0V0tTL3BzVlcwL0lu?=
 =?utf-8?B?bTBWdnpTcHZCSTlGV2EwRnEwUEh0RUtocmRxNlc4ZytMZUc2WlpmOGgyYUJX?=
 =?utf-8?B?MVdreGpBdXBNeUFmL3FRRHlkMmR0SnpDTnMzRG9lNkZMcGw3eStTcXJCY2Z3?=
 =?utf-8?B?VVkrWkVNYkpwajV1Y2docldXR3VVeWluQTlLV3dGaGpJZHlMKzZUa0RuNmhq?=
 =?utf-8?B?WVpSbDFTNFBMWW5oTkhEVExNNUxtcm9DUkFzNUhzeG5vd3VLQUZLL29YUVRP?=
 =?utf-8?B?Mm9MOFQzcU5mdm9WVms3WnYyZ2hsbU9VMXNiWkU1emNJVXAwTFJUTFJvbkxW?=
 =?utf-8?B?elFtbzZadXgzMVF3RU5neFJTazZjLzAxM0dtUUJtVHROcjdPc0RTYWVWTEFF?=
 =?utf-8?B?UWY0emRsKzFFN1JaQmxJUGF3dkZjeGdEWG5zdmVoT092RXhON21YOUdVWWN5?=
 =?utf-8?B?SFdtYXJDcmpGY3hwdEQrQkxWYnViYVdqcUhISFplQk96L3kya09CcU9BNFla?=
 =?utf-8?B?V0VEN09LY0RIa0Y3MWRBc09oUmdsN1BIL1BCdXR0Ti9pcVNwTGZ2VXJ5RER6?=
 =?utf-8?B?Ukl2RXZZOFZvSGhtbUlYbC90d3pZcjJScEY5ODI4dWpZSVBOR0hzM2JhWTZT?=
 =?utf-8?B?UktrVG5EVFEyQUNCa20vbWREa0MzNlpXQ2tZRXBYOUN4RjV2MkUzbGVXTVdY?=
 =?utf-8?B?cEJmTmZvK1lyZEVGZmtRNXZTR1lnZ3NJampJOXc1M0FzUmJyeG52MHlFMWVq?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U0pnQ2wrNTNERU1SS25KczNvT05pRWY1SURzZkFlNHZ0NFQrRTNtUXp3WUhl?=
 =?utf-8?B?T0I0eDd2S2xCLzFUMmhHUXRHQ3Z2eDhwcVZZYWZ3ZXd3UDcrZldjM1VJUnNU?=
 =?utf-8?B?VUJtWW8zNXR5OTdmdUNCbWVYWGJRRkxDajVwQ3YzUmhsZnphQXRpNnc2TDMx?=
 =?utf-8?B?MzlUQVNhK3NabWlXcCtWZ2s5S2ViSXlMNXRIVXE4cERXcSt1dDhRTmpLbHJl?=
 =?utf-8?B?UkMxTFk3bWV0TVEwN0EwanhoaG5Hb09UVkNYYW5QdWxwY1ZyZEtqN2doaGFm?=
 =?utf-8?B?MDR0RnVnMU0veE9OTkNyY1J0L3lQVkE3VExRcjZRWkZ1NFdRbHNsKzU2bkY4?=
 =?utf-8?B?WHNyUHZ2ODVJbWMzanBJZmdjeTNsS1k4cWZITGhRUnFPamFsUURSajJkMU9H?=
 =?utf-8?B?WmZBMy95aGk4c1ZZclh4ZFRTSVNRbDdVSlllRUhqUkhQbUxSVUEwTHBheE54?=
 =?utf-8?B?THI5ZUpUMmlIUm1Ka0Uzc3pRYXcrNmJHdjhDa2lyRmxRS2o5UnJETXprRHpz?=
 =?utf-8?B?SC83cEN5c3A0d3lCbUdLbk5rNnZRMWFLVDUwVjJCSHJPL29Gd0c3b3Zua1lW?=
 =?utf-8?B?ZnFqR0ZsZGRNQUNEU3UzOHg5K0pvUGlaNlZaNkE2VnBmQWxRZVRnUURhV2N5?=
 =?utf-8?B?TWplZWwvU0VUN1N1WmJ1eUNnalQ1b3U3Z2cvVmpBTDR3amErcG9jMFNiSCt1?=
 =?utf-8?B?eWFkQXM5SnFucko0cWp1WC9zbnM5U3Jyd3lpRnF3RHNXeWVpVjUyQ3lKS2xZ?=
 =?utf-8?B?V1JMRTYyQmNJN1ZWcmNyQXd0ME5FZWhEVC9CQSs5VTNhODVXa1hJQWo4NlRK?=
 =?utf-8?B?UHRTUFlNNjQ4TThQOWxlc1g1WFQ3bHpWSzMxQ29ObjFMT0Z6bWgvUFBNVHB0?=
 =?utf-8?B?a0FRYitrclBLM1E2WVBNUWZXT1lUUGJ1MzAzdjZob0t6Sk5GQ0ZRYitWdzYw?=
 =?utf-8?B?MERqd081bU1NS1M1N0FCQnZrT2RkL0xqcmR0UTRvT05vQUhFcVZWMzhIVzhS?=
 =?utf-8?B?bWtLbEcwTGtHUDdKdzlxTms5Y2xtV1RCS3U0M1Vqa2liWTNobGdLRnJ5ZGpm?=
 =?utf-8?B?VXl0VlFncXU3b0U1Mkt4bUdnMDUwdUs1Vm0rRVR0ZHdIREVuTkhBekhIbmd3?=
 =?utf-8?B?cmhmTzFjOCthbUZKMFVmbmVucHRBVDE4UHo1T2tucEQwVEZabUZMNWhFOXRG?=
 =?utf-8?B?dkdDcU5NSFRZQjVCaE9McjMzaGRYd2N4U3E0NGdiWHRCZk5RbnRpNjlKYmR3?=
 =?utf-8?B?QzEzWUc5YzZYcmdJRzdwb1RldlZkcXcwOEg5UFhmSzVaaGJYNnY5V1JvcE9P?=
 =?utf-8?B?M2FPUER2TzVBOHk2V25QZ2pHMUEraDBFa25CVzJCNnpVbm1EN1hzYWNCOWhu?=
 =?utf-8?Q?eiXCo0TeMw0Wva8nrc0Vki9NAadGu5gw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8486c9ea-dc21-4d52-72c9-08dacbd78017
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 15:46:07.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OIK0da3hmQanhYoWvsDGeDdRImEHySMzDHRdbEociQDgqkzn2QCpOhf6qGNC/m+dqDm36rDTMCbYc6Lg+lVuSlUMthJxylT/re/lmuqsDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210122
X-Proofpoint-GUID: JkpSjUnRrD6jerWlJhGSgTV1uncKjX2_
X-Proofpoint-ORIG-GUID: JkpSjUnRrD6jerWlJhGSgTV1uncKjX2_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/20/22 6:31 PM, John Hubbard wrote:
> On 11/18/22 14:20, Sidhartha Kumar wrote:
> ...
>> @@ -1950,7 +1949,7 @@ pgoff_t hugetlb_basepage_index(struct page *page)
>>       return (index << compound_order(page_head)) + compound_idx;
>>   }
>>   -static struct page *alloc_buddy_huge_page(struct hstate *h,
>> +static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
>>           gfp_t gfp_mask, int nid, nodemask_t *nmask,
>>           nodemask_t *node_alloc_noretry)
>>   {
>> @@ -2009,7 +2008,7 @@ static struct page 
>> *alloc_buddy_huge_page(struct hstate *h,
>>       if (node_alloc_noretry && !page && alloc_try_hard)
>>           node_set(nid, *node_alloc_noretry);
>>   -    return page;
>> +    return page_folio(page);
>
> 1. This causes a NULL pointer crash when the user requests too many 
> hugetlb
> pages (you can probably guess how I know this, haha), for example:
>
>     echo 50000 > /proc/sys/vm/nr_hugepages
>
> ...because page_folio() doesn't have a NULL check in there. You will want
> to do something like this, on top of this current patch:
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 629bb044f063..ffb0f052bbff 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1987,11 +1987,6 @@ static struct folio 
> *alloc_buddy_hugetlb_folio(struct hstate *h,
>                 page = NULL;
>         }
>
> -       if (page)
> -               __count_vm_event(HTLB_BUDDY_PGALLOC);
> -       else
> -               __count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
> -
>         /*
>          * If we did not specify __GFP_RETRY_MAYFAIL, but still got a 
> page this
>          * indicates an overall state change.  Clear bit so that we 
> resume
> @@ -2008,6 +2003,12 @@ static struct folio 
> *alloc_buddy_hugetlb_folio(struct hstate *h,
>         if (node_alloc_noretry && !page && alloc_try_hard)
>                 node_set(nid, *node_alloc_noretry);
>
> +       if (!page) {
> +               __count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
> +               return NULL;
> +       }
> +
> +       __count_vm_event(HTLB_BUDDY_PGALLOC);
>         return page_folio(page);
>  }
>
>
> 2. And also, the tests should probably be augmented to run this simple
> (but easy to overlook) test.
>
Sure, I can look into adding this type of test to Linux Test Project.


> 3. And finally, the basic method of replacing page with page_folio(page)
> is not sufficient, as you can see here. So I'd suggest taking a look
> through your series to see if you are checking for NULL first, before
> calling page_folio(page).
>
I will go through my series again to check for possible NULL dereferences.

Thanks for taking a look.

Sidhartha Kumar

>
> thanks,
