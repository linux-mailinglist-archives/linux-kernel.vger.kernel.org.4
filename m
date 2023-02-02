Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4D96889AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjBBWWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjBBWWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:22:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F60A6A327
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:22:12 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDoDI006926;
        Thu, 2 Feb 2023 22:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9wWe9dVu5SYz0/NxzioBAWm0icKH+5a2DZ143LgvIII=;
 b=efpJsCOrZ6eYD4m0vZ/CzQU0TJycYPfW2ZiDlG66bli0L/y3xZXcRVuNmC4J+rZ8IWZU
 mTacEGW3qTVF3YyJpGSFx5fS3jpHAkXqClHFnlXG9+hz+ZhLf/6NFgoWVp/I0TLQ4Bh2
 zV/i0/HLpi1O0HKHH+1oueEM62VC3eCBJKFu785F5QqTumlkrBgS84f1MuTNNcaJ+ACy
 qAhmSKax2O29eY9Fr3kx6dUeGPLApTcJn5idcXxaAXS+tOKUIJdjF38CoJM8loG4yNJX
 yst8EZSdhgMeOCGDRZYquL5uspwo1Jgy1ayfxqePh16eSE5hik6zHc8JRW1+KdnZLqDX rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfkfe4fm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 22:01:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312L8PxG002489;
        Thu, 2 Feb 2023 22:01:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5g93ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 22:01:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgvnX/QtU1Ve3MRPT6XrV+9D8gacxBk+SpkoL7csLHXet4WG7V3HA7y8sQauUp9OOp2j8TVNC3deTU3kN8QsvKktSAYocRQWc660BlhKFRjvD1mJbCe2vfNDGTr/rw6PRjOPXZ5YKfOoFjHKw4bt9wBiEeor+elKXM6Kcqmqy0HJM/ip5/7BGfVYr42xDHRCtjFu5PhkHa1B2JW4Gv6Zvp1sSC34dSVAR4u1a0qFZAs3jgESB9t5P2ahvt++oRvixnp4x+6gPtGAgZgP4LLTK8Qk+5e6fpnuUp7I35MmiDSfuu8Agkmwv4RztTR/fnTyPBE4qJqxkDs/ezgncY59Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wWe9dVu5SYz0/NxzioBAWm0icKH+5a2DZ143LgvIII=;
 b=aGDK5EqaBPWcCqYLl5UEgysljfvhl9ZmiDMlCKW8fl3IAHe0QIvR37z+zGCprXArjFEA6l6cKWoPjH7qO136BqjoTBKo03e9ioNzmA4XZB0D+wNZB6xLfo2cyh8uZRTX7/7Fd+8h1CFwRA1kIGbLiThP/5ccd6UBQvegdcMmDt1sUd54sZSoBO0vfjfTIna32xcSzZMOrSG5NuN82+ROA2eT2N2XD2zW4Ov+l5iK3cFGgVXRBhWGMz0c2Au+X5H3hzQ2KOTKmO3FW2YDrFRX4yNlK+aFGwUgQ15srab+NQopHj2cq6y+ECm0UHgYLPctqnwvFHqz1h3hLC6UMQE+FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wWe9dVu5SYz0/NxzioBAWm0icKH+5a2DZ143LgvIII=;
 b=wM2r4j4K0sFIQOIVNnIrdgUUlTUfvs7rZy0AQWAWM9Bg8kMML+ivV5nYDN3/+pyZbW0Jy810hPEuJhSxo4yBwnrakswMYTZv3I/ZpDrwQMAs6EUcfZW8P9/kP1hXOl4kq5iyikqsBNpuF+uy+U3s9PuJoUEFIVG9JMQnp4r5Cug=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BLAPR10MB4881.namprd10.prod.outlook.com (2603:10b6:208:327::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.8; Thu, 2 Feb
 2023 22:01:02 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 22:01:02 +0000
Message-ID: <57fe17e4-b60a-49aa-4661-bf88b0753953@oracle.com>
Date:   Thu, 2 Feb 2023 14:00:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/7] virtio: VIRTIO_DEVICE_F_MASK for all per-device
 features
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-5-git-send-email-si-wei.liu@oracle.com>
 <20230202122851-mutt-send-email-mst@kernel.org>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230202122851-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BLAPR10MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: 423dcf1f-d065-44b9-6faf-08db0568f950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1H1P1RpU1CgIkJ9LFQz8TXwxGiuZwVspFCRB4rL/JtB988qcawzvPZJIlTmvbzMc0dEJV0tcUEQprwPxr3lKU+PhxL18tArqetCj3+OsCvFbNFalMkNu0emhFXR13sMLKQa+Q+o4J9O1qTjzdhxT4SxgGz9h5qAcJXdS6kzPqWD9pVA8pb8JAKhcnPC6o3zZkQHWvRfkvOzer4B0/MkfUp8xJroOudPhw1/KcgitKsSNoJ4QDahY3Con5dce7DMGJj8ZYKSfJmA49NXIb0/2jP4LAxsSxN69afE1FpgvGO/O2q1u6cYgiJ3aKD2uZdL8Av1SFoOwdVMyR/rQaTUHYqn/EG4aCyoVK2BKhJHKok/IAauWJIKmn2jxNCW3pA7i1wk0Qq1wErebm2YoTIqp/wVvgJcxLqT0sxWcR4HKvu2rTQ10QImE7XiueYsq2hb1EXXrR8xej3Jx4btEZgmcpBrti2uyScskxnmuXrMrt1GRjwkFOhSI4thPosd9BbNMFZ8e2XCDUKDM1q9DFDZ5yf7ZaJcVwJ0EhI7g18Q2+1GKP4n0CJwS1ZQ/FEI/cmDu5tR+n311HTuJMFhp2WE9u683KbtPCR9kXGnkk11AB3M6Jm1paEjFYFi4nqI9OgmE5A8Fg7POjaZVNjqd189Cj+/SBPdj7WwHbvjJG0a4XwxBVfGT1J/IdAH2fL58YOxqgoPaRdJqg6D4n6ZqKT7WBpH8oMktDkVUa1XJZh9AjuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(5660300002)(6916009)(86362001)(8676002)(4326008)(41300700001)(8936002)(31696002)(316002)(66946007)(66476007)(66556008)(38100700002)(6666004)(31686004)(6486002)(53546011)(6506007)(478600001)(36756003)(36916002)(6512007)(26005)(2616005)(186003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTVNdEQwNUFwVFl6cFlVSTVYYVlMQllkNFlwZ0dYUzFCbkJXL2x2UGVqYmRh?=
 =?utf-8?B?QWtuY2lRTzZRN3ZGWWs4T0JIQ1J3c0s4d3JzM2Z6Z3Zwa3RDU014amVNeHdQ?=
 =?utf-8?B?Y3ZnRCszL1pMNkNvQ0kzMFNrK0JmZWVlQjgweEZDUGxOZ2pSUjUwMXd2UFRI?=
 =?utf-8?B?V3kyUjh2UzBvN2M0bkFiUldEZHlRTlBPUW1YYWhvQm4yMlR1cE1aUkZMZzhp?=
 =?utf-8?B?Q1V4YXBUc3pFY3dsNTVwOE1FUHB6ZXI3bTFwWjdDWk1IRDd3bTBHTTJVOGNx?=
 =?utf-8?B?OWRpUENwOGQwVnd2YUFEdHVwallybjBzMU5DOFBPekZCNjFlMGl5OHFkeXho?=
 =?utf-8?B?eXBwQWdqS3p1YnFBQXZGT09uWmY0UGRMY3NVTnlLTzVia0dyOG9Ebm1Pa29F?=
 =?utf-8?B?ZXE0ekhEWW9ZK3hJVnFuR3RjM0ZFNU5EUUxOWmVDQVJJMkltR3Y5bE5JWlZ3?=
 =?utf-8?B?Z0dqbEgyZ0lTQmhpNHQvVjNTbHhHbVoyb3M4czN2UU8vR2FBUWVZa0F0ckdi?=
 =?utf-8?B?RXNCSEx4c245cXUxTis2VnZzVW12ejhkcHhyS0E0RDdiT3FtQmtEaTd3Rk45?=
 =?utf-8?B?aXUrSlFoTFhzQ3lZV2hNVXFGcGZlcURCeVk3Z3hFK0FhQ2tlTDRQU1pkNlJq?=
 =?utf-8?B?eVB1S3VnU0RUUFhISXhmUDM2OHpYcW82aGpRbFkyWGNvb3JjeEF5UC8vVjJF?=
 =?utf-8?B?bDdRTERaZ1ZxQVo0YVMremhJeHNveTNBNTZTRFdVWGJpL0hWRTErY2MyZnRh?=
 =?utf-8?B?S040ekQ2cHplZWxZT1g5ZFdDSGxqREJSektWN1RTV0pmOUZ2Q0t3RnllQUp6?=
 =?utf-8?B?Y2pSbDdjcGtjcHY4VHJkR2hhS2ZrK0ZaUFFTMlNGSm9seEJvdzliTDlqNDZn?=
 =?utf-8?B?b0RXbU5aVHJnUXN1OEQrelpQNHFFdTBHZUQvaWt3R09LNk1zRkdBcFVCWHpK?=
 =?utf-8?B?eEJ6RnJmRUNlVFRmVTBBSjc3S0RSRDlkcjNpMXhjejRxOXgrcGlkS09CN2FR?=
 =?utf-8?B?RDhlem5SYmUwYUZvem5lTG5jZlVsdHVGQW15OGxSQThnTGQ5WWlPMEhLOEFU?=
 =?utf-8?B?TDdhTjFoRUxpVkFqV3RvM0lGSCtLTk15dDhMQkhFNUtLRzJlYTlYdGFPdUlO?=
 =?utf-8?B?alozL1hnZTdpWlYzREsycFk2M29wdU82VENRY1FKWGVEMjdORlVqaERNNWs3?=
 =?utf-8?B?dEpOTGVFblpMdnI4bUllTFpYeEovUWJ5OXowUldvZzlQSm9KWWdYM0JzaEtw?=
 =?utf-8?B?ZUI4a2xuWjR3MmdyQUhtcnpNQ0FGdmRqZG9ZYVk0VWpqRDhmUzdtQ1VCck9V?=
 =?utf-8?B?Q1JaQVU2bndsNXMrekdyY0NKelI3bHhWbmIwd2RTRWxBZnhLVTkvY1dwaENT?=
 =?utf-8?B?RnZibzkxMnF0cDhidlhJR1ZXZjBFR2I4U2RPNkc4RzlLMkN0TUJCK3RHcWtW?=
 =?utf-8?B?RDJvM3g2U3NBQ0g1NXJOKzBGU0x2M0xic1lWd1Uwd0ZJSWtQWVBWUWJVYmRj?=
 =?utf-8?B?YjhXT0NWVTRjKzdOK3VabHFWZmlEWE9DWGI5RlplRTlkbFErZGRYcGxlcXJn?=
 =?utf-8?B?Rm1GTERhT0hCS0JrZFNROG0waUJ4WFNsUUVpbU5qVTJYZDFSNFBWRHhiQWZR?=
 =?utf-8?B?VFlSU28yQ3RERUlmRzU4QzZtRUNjYVFVNmh1ZGgya2p5OWhHemVDR2JzZ3Bs?=
 =?utf-8?B?VVhJbGZYd0dLY0h6aXBhU21SV1dpN0hpdHlXaVpxNmgxaWRxa1VCV2hzK2tz?=
 =?utf-8?B?OHZpZVhHSUJCeDBLVDhRMHRmNHQyWkNhZ1pXaVlGanhFZGxSeDNLdW16M1NH?=
 =?utf-8?B?ZFdGUDFaVytxQzY0bWh2dmtyck1HTHYzd2lHNkxNUVVZTmV6TmJkOFBwYytL?=
 =?utf-8?B?eXFtMmFGcWJGSnJLKzkvR1A2ckJWL2VtNUpuOStLSytNMS93QmNwanhGYVlT?=
 =?utf-8?B?L1g2TmpSczhyODFrdDdkallGVTd0SjR1K0hXRzViV3c0cXJ6cmFpVUdmWTZa?=
 =?utf-8?B?dlA2UXZlYldpY1M1SGt4bitDbSt5L0NNeVpoVlViK3lBTUNOQmZmdDFsdjVy?=
 =?utf-8?B?M05hZEVHMmpYU0c2bDFxUFZTdXhjVnpiOXFuU1FuMTlmZVhSTDB3Y1VtTTlv?=
 =?utf-8?Q?EJoDVKtBBZrelAIOUY2lJ5CTk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /DH4tlTDHH6yngcsMrhGvVuXXNbjI9Bf7Sdj1gp4WYlotEegjcoQHlKLDlPqSTbPteLGWRpCm0biPzx+YgeCHTTVafjZgH/xxsQR7RC7lJ0g9vDVW3e3Ada8RNlhZeAd2OWZEEHGAHCZuHo/te3IdmmK1MFBJPWuy5u6BPjB8vH93kfOyMyyXFTFlOXz+hFBm4/zlJdii8lr77LxlYVAQUUm5NrcVmETWZuxvIXI0dW6NoF1LdEY84i6dGNIoC82GLa/C3liy8Ram0fMY0L44jQBBShHo0SpVMwvPfR3yt1TSeVbeUeqm50VxqI2PCBRT1XCZ98yYHPodoj2JA/fkI3cpZWQR1vaLvsWXAsaJF2UoKdrInFi6itd4oSRVTYxIq/Ne+2VkYv7dBEpo80WAO3+ZbBPveoYt5/1PwejuZOnGIeRjVIIzbYyqJRWC3DXZpb0FJAmDIuDoeQkZd+x1NioWZIgRw7Ace1pduJQPJH/EdY9g3Bb5vcjY+bLukcXtyO/dp74+PMr4HcXUC8KJqZQMEwacnq5yYxjsup6z2bdGPT4teBSeI8F5zRanVARnr48hWpIQGuii9ono9Fk60KgpdY4DBsnrrSFXWN5U31zRXPRFHgh5vT0YFdQtM+pAszEf0xc86XEhhuEcHKhKLkP8V4HaG3vuyPI01KpuQHj6qt61ZjTjVB6pZZliW2Cd+CClNZmnr3kEUVzFJRY/EN5/XANInc60pEvSfVvle8iMRyMsrAdhVvK3F/EADNr8Y3MemzcyE7tb4MuH/Hukzn89D6+e1T0ptNP6he2vc1biVJiOmZaOzLT1b+Ua/4vV92BdP6fxq7+dC+VBcLPSyUyCJfBFZOvkfC+B+XTH+21k61bRqAp/rvLy+rQazHPz28MNq19wWhYwxnuUgPgYw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423dcf1f-d065-44b9-6faf-08db0568f950
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 22:01:02.1530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /auGOaYc9FGYceBGm5HBMvbG1DGKV5cP520/Vf5GyV95iilFWo8uTKfFhaNIBhXzwAEGoOoaDrMtfMkvUyN3zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020195
X-Proofpoint-GUID: 0X7ROxRar9p5cu6wa4l77EhDNQGlAxx6
X-Proofpoint-ORIG-GUID: 0X7ROxRar9p5cu6wa4l77EhDNQGlAxx6
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/2023 9:29 AM, Michael S. Tsirkin wrote:
> On Tue, Jan 31, 2023 at 03:22:22PM -0800, Si-Wei Liu wrote:
>> Introduce VIRTIO_DEVICE_F_MASK bitmask used for identification
>> of per-device features. Feature bits VIRTIO_TRANSPORT_F_START
>> through VIRTIO_TRANSPORT_F_END are reserved for transport
>> features hence are not counted as per-device features against
>> the 64bit feature space.
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   include/uapi/linux/virtio_config.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
> Pls don't add this in uapi, people tend to depend on this and then
> things fail when we extend virtio. For example this won't work with >64
> feature bits.
Good point. Then keep this macro private to vdpa.c for now?

-Siwei
>
>> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
>> index 3c05162..3bdc7ed 100644
>> --- a/include/uapi/linux/virtio_config.h
>> +++ b/include/uapi/linux/virtio_config.h
>> @@ -54,6 +54,14 @@
>>   #define VIRTIO_TRANSPORT_F_START	28
>>   #define VIRTIO_TRANSPORT_F_END		41
>>   
>> +/*
>> + * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_START
>> + * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
>> + * all 64bit features
>> + */
>> +#define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) | \
>> +			      ((1ULL << VIRTIO_TRANSPORT_F_START) - 1))
>> +
>>   #ifndef VIRTIO_CONFIG_NO_LEGACY
>>   /* Do we get callbacks when the ring is completely used, even if we've
>>    * suppressed them? */
>> -- 
>> 1.8.3.1

