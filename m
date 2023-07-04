Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A676474673B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjGDCTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjGDCTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:19:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05379E59
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 19:19:12 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3641wrYO001163;
        Tue, 4 Jul 2023 02:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=acVUUtdvEafB8asOYi+z8tLBBycbtmwz36dgYMAV/DQ=;
 b=Nsi9rca4x2Ej2mbYo+a5CD7dhYhwSKnRzrTJ1u9v/hhSjjRgarihZvI8+JnAjNbKRAa4
 jUCm5TzHBJz4fMVDl4JoKIVNNMl+DwKclnAyvX6/VuUCCzFN2u2kw9Nty5+2SCSc5bz3
 o0F7at5uBJnK72GEY3plmcC7E/TVcw0tymrzaNUH4LbXO9STWLnOtfy66wsW/vdn/y7+
 RJoSYZoC3/w/jQUem+v9eFuF0RCp/EeIWGLobRbCXIJgD1E2KwtiYLv39fklURWclI6C
 p6SD9jBgtwEPVaogdhKxcQEh0x9yGhzASzefxhMFnpFhtnUaFGpx3xwkVGTNiC8Mk4U+ UA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjajdbqx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 02:19:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3640vYli020850;
        Tue, 4 Jul 2023 02:19:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak3skpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 02:19:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7q+pFy7MYbL1VE0d3CXTPxUgw1FFxFi+wIi/9km/GGhVFicymICytQ/WynnKZNGJ4GzpmuxF4D/IxdFnqbTgqp0iVb93D2kzgyEbJ+dzuFl5PZ8GirSHzsM4MhF1ePcmGw3ZijlKCqwmaY36Deq+hObCkykLPDfebxcRisyDTaiSbRVzq6/V11pCt+rXb8LtfjwR8JxSAMBUYLS9trko/yqXtIQsS3lbAG9csYgnxxir6Fo6SCFVDMmHVEBGbaq2FNOgKUo/6sshZu8tnSOHjrbdxxJESB0EcNS42oImy7paL1qEUT4hgWaFFK2NWiIXFvt9Ea8s2m+MjE/XCoD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acVUUtdvEafB8asOYi+z8tLBBycbtmwz36dgYMAV/DQ=;
 b=S6MPvjr7nAEpBblD+cFc47QcAcdsYHbLWoxA2yMXVAwBfqyFBh6JOBl+Lbo0Y5M/25kCibCpXDPBc6kaWiGtnvxkEetwJBw5NTdsNAomFMNXKrduM5wAL9sr+ymaX+51xC7/N4MYAK/nGubPXMGxeeJrXVMTlsv/2YKux7om3HM6fiOXR1+cc4gRCtRwgz1z+W9l3dqGRYvAQB3ldYoESd6pjKNdDuN1w3AvDPRq/pql1kJZo/zWHUs7hCTh05CoqZbvN1hroRhuBQOQIsIYN8kvqa3wdA1rRSHX7oBFvNfAF839Fd3UWh3YDNaBgDw6HQ8GUGVLLzn5TFTxa2WQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acVUUtdvEafB8asOYi+z8tLBBycbtmwz36dgYMAV/DQ=;
 b=eAJ/GAGaDlQX7RLvjx81qWpYem8aXkRM6rq6qnKfdR0lfkecX7WK1OwTFeMGircnBfpPEM/pOmryUizNx52QMRRM5p3kWAiIvAHquhZcIk6WN5eM9C/pObjsJw6ljL+56uRTspz3X3mxUfdo7snFkr/wtuOKisWDz9fQvVH8xKQ=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6468.namprd10.prod.outlook.com (2603:10b6:930:60::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:19:00 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:19:00 +0000
Message-ID: <e32f52b1-a983-d569-4645-a6eee2ccd78b@oracle.com>
Date:   Mon, 3 Jul 2023 19:18:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] mm/memory: convert do_shared_fault() to folios
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
 <20230703055850.227169-3-sidhartha.kumar@oracle.com>
 <ZKNaVJCDH7ac8SCu@casper.infradead.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <ZKNaVJCDH7ac8SCu@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::27) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: ec793856-9dcd-4832-9078-08db7c35076b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iG+Z9YIme9/yQRg+cArEd22DZcGc0gf4E0e/RhxCeHQXc4bSD5WKCa9Nwo7V6/tWcdQdTkPxS2IPj2wR7XQ16E1RcDBG+QdVxTdS8/e2Fn/QBopMwLiHyX9+A+ZgpZ0oO/0Yr+b6y9vRhKh1guhzwGROpHXLxu6StJZxxDgLyu6s9OnC4hcS1m2TIeY+k6xYhkIg7ut3yA7Z7LONXa+YuSA9W0XatVkAdPhqLmcQQOZD6QjDHd3EmPmRPmP6wbW8YBOQmU9xY5qc5XXWNtK/jkFRhIFwisDQghNq3Cfs824zqKm/c4O/MjHA1b170ld1aCeNaJ6eKQeZ4dz8QXWRTHAY/zULwY7xpR+XagYtjs+NT5maXs40WiQThnc5Cf3KLJeskZz/OQzs5G0fiGwlK14izt+a4aKwFvdvptF+hUCQBF+B22lnlWdntAxPSpI1TmQewwUh27/5clCtZArJnzYvnJ30fU/v2jQJpnHrZvJck+HbGZN/BaGYBesYxdLdgTl9p0mzOMqOtsRMQGijQ0QBrFOZbU32LrHpXHoPOJNKQiW8SIjQ2BHUOIwjlG2l7732sjiSOk+xbOm+bHngmk0rSah1Q7/68PWMP8NQoYnD82fD3EQT0p29LGL7oegzoA9YGdfg7n0lZxl7SZWNpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(36756003)(86362001)(31696002)(186003)(2616005)(478600001)(6512007)(6506007)(6666004)(31686004)(53546011)(6486002)(316002)(4326008)(6916009)(66476007)(66556008)(66946007)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEpNSW9mT0VoQWN4dVNrQjRRSWVETnNVS3RQQjFEU1hGU05XSTVJVUVzelVH?=
 =?utf-8?B?RC93UXpZY3JDRE9WMjl0SU16ZURRM0d5RmZEcTJmLzFGa3pPTXVjOWFxSUly?=
 =?utf-8?B?b0ZmMGlzT1MzcDdoYmZrUmV3Q0NUbUZPS1FuakVUY0VvS1R3NjN2QUhQSFF4?=
 =?utf-8?B?aVpHMzJpck5PbEFxQXRCRUNXVjE2QXhuanBZeVRPY280QTNZTzFLQ1Ewd1FJ?=
 =?utf-8?B?RGUrall2TTlvcUhBZThsbEg2VnN2ZTk0bW84L0VRRExXRHJObUlTTkN1Ykw2?=
 =?utf-8?B?TVBzNDNvbHRnbzFQVEc4dFhUdFRJRC82dG5LUHFyRmRYZmhNOFpYTUtXdk9M?=
 =?utf-8?B?cHpoMjNXeUJpS1dVMFhHanlkWWNDemVua0hXOTAvUWQ2Q3RoY1g3cVd2eWUw?=
 =?utf-8?B?RjhOOE1WYXBHb2Y2YkNJc0tiVitaTG02UlgxYnVHSHRoY1JwZms0Q2ZHNm5Y?=
 =?utf-8?B?UzEzT2lHdDVPRElZV2lDNzlwRGdRaEFxMXBOaUhVKzIzNU9mTkVZT3Bzd096?=
 =?utf-8?B?NUcwQ3JsaDgzczRRbU1oQWNYZGFKWFlod2Uyb2RMMXAyUGlmNENybitHK1Fo?=
 =?utf-8?B?a3kvSHI2emQ1a00wekdxYm1JeWFFcGEyM1E3Vnl4ODBVMWY5Skc4RGkwSjA5?=
 =?utf-8?B?UkRVaXZGOVJXSFlBSnNMZWppQTQyYyt2NkNDdnNRRXl6aUtnVG1lTVl0VldD?=
 =?utf-8?B?WktEczdOaHRpUjNHbVYyUDdhVW1lUzZMTXMrYlFnSVRzYzBZcVB1STAvak5Z?=
 =?utf-8?B?bnc0VC9qOUFWUk1uZmVEcjcrZlUrOWxsalZzWklycC9naWREcm5kellvbUEx?=
 =?utf-8?B?QmpJRnpUMTNJNGZ2dUlSS2xnVVpBTWgvZjNWL21xN3RuZk1qWHh4bHRxQ2w3?=
 =?utf-8?B?cWZLS1JCZEFIY0pqaDhyRzlpMkVXZzBMYnVRaU5ZaU54eC83MlEwNGhERWMy?=
 =?utf-8?B?NmFnUWJKK2l2a1gyUG1UT2RoMDlncG14REY3bXRLejhmbXZCWjJjRmtRVmRP?=
 =?utf-8?B?VExHQVU2TnhERm4ydkZtbjVYM3pNL0FVeHE2djYyK3JPWFo0Q043YlJGQ0p3?=
 =?utf-8?B?WXZNR2s4UnJKKy9IMlZBMVlyaWZYeEJkVTBFUW85S1M4VXVWQVhwUHFVcW4v?=
 =?utf-8?B?WlB0aFNMMlRDRElJcURtRkswTTFHMmMyZE05UVFhRlJtZ1ZqVzMyMHZ2aTZy?=
 =?utf-8?B?T1VpZEU2VE96VGpraEJZZ0JQcktnOXdla0cvckhlWkR6N2M3aGJzWWtPMG1H?=
 =?utf-8?B?N3RlY0hxMEs2RTdaR2V2TVJDenQ2VW9uSzBvd0t2NE1ENXlwckNGMElRdnBW?=
 =?utf-8?B?b09HRVBSMW9ONTdzNEV0ZDkycHkyQ0JoamNEcGR5SWFScWpDMzg4aTUwaXVP?=
 =?utf-8?B?TS9sd0I3QjhCekxKUElTUHBXQTZhTm5BQVpGYmlWSklRSGxDTTFyZUJjWVcz?=
 =?utf-8?B?NGo5SzFhS2preG9HU2x4d3JCQ1Y1SDhudFZSY2dwQWljN1FGK3ZkTm9HNnRG?=
 =?utf-8?B?L3pwUTBxNUZjMXJxRzZxbDFQSUJ5amtSRExBWFBKN01XaHIzMEFTcDc2a1hX?=
 =?utf-8?B?ckJvcmFSZDZRZHFUOHhDUGQ1U3c4OFVFSy9sSTJuR2FEbndRbU9nTmtabXlo?=
 =?utf-8?B?NjZ6VDYzUzJ0MDFCeU5pYmVWZDByaHlpalNzbFpPUS9USmRCVTdJeko4aEtN?=
 =?utf-8?B?L3VRVFgwZG1GMkNuS3RobW4xcFF1Q3I0QkF3UW1iUTdHS2UrZ1lYeEUzSE1o?=
 =?utf-8?B?WERvTFdsb0xWRzFjSHRNeXV2bDZDbHkzRjA3R3QvRlowTmp4VUxIY2RoRDlF?=
 =?utf-8?B?bG1lWWlUdTVsczBsTnQ2NXdXelYydGVFaEwvVysvcWtic1E3bkdtNVBCK0Ry?=
 =?utf-8?B?Ti9zeHVJMXRTM2U2dWpsWWtSOU5MaHZ4eVJUam9CWHY5dnJpVVhYZXc5cU1P?=
 =?utf-8?B?TG56ZmxhSmVocjZlWDRYRDhvYmtUVGxXMUJkWUxTUE9GYU9sYVVTaTBaMFBw?=
 =?utf-8?B?NzFCT1ZhRUxYZXd6ZjRKZ2dvKzVrb1pEUnRGM0dxZ1ZEamZNV1ZtUjNwSUtz?=
 =?utf-8?B?NkVBZlFkRGdmdDBTSFpUVC9oRnZBV0h0WTR6N2pka28vV0FLRTVieFZYSlFY?=
 =?utf-8?B?cmwwWm5XUWIrTTdsZzdxTnRMeldibVhoRkZBMTBucEs3SXMzYThFeitiV0V6?=
 =?utf-8?Q?FHnIeyAOTinEpNKFYaenKUY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G5nN4A+im4qPOmVFwg4eVtIltp67c3XHRdRfGWxB2LPx2w8rFKCyCrxZUmkw9HY6Zv5qXERYXxz4TllXvgD+3j4JwKxKKxq/m253iodqfpoe7WgrzmSd1u7ZRJDSSwyE6IY7E5etF0P5trZHcg9Fcf1FxhTOQyzlTU5sxsoMRrB41SRlMYrDWdfUPdM7eFXl/q2FD7j0UmRNyqXkBXdTTah6CJZnqrCI2o0T8fDj35ka1Wcg2Kr6StND5WWMZ4IWXZhn319rVVl47Ges6tlEVz5k0LGU+S4bVa+ZISTVgqIcFarsS1KnJxsl8c7TyWBbl2ey13H2rG1qepVNJhdbHApD8Wy0kp6ZjogPKhf4lKtPSC1JFWxBb8D3LYKre7HZd1vngqkfyYqiI2+gu4nxkyFkzs0Xn6ncu/JQozGNP0s2nmNI3snwCDT+AuRlHiNKbBTjr8E4a6oKFc16WtLdXW6Y7oYRGJIv9jqFXbi5P93QGOUN5ELbVJEH90eadZdDLGI+pwAfRdToF31SBe6EorNFpCQGoGMyhiXDsH7OmwQkAoPrJRiY2mAL6iCsJvG0EGr4XXnftI2MABtJFqIRldwxhDANCEj5gAW7qa7srwT+i6MozCHfgYJVLMGhQUYT4YoQrBKDhwys7Jd8EJn30W6+JgxkL1Ov51R/lDwvm98IMLtX2EA7wtCCUrrdKHYA4alwoaH547Yo+2OlPI3rONEGH7gsFCu76UE33KDnKU9zk7oJ119idRqqL4fPSm9w1rW8IIxZrwfGkIGDGCMe4W834mQwiAgzB1KbciycoT56Vli0QKnbTGk9t61ReXQ2nSDQMttj7YB4fO17cgpXpDcH5M+tyQ5Nzu/6o/9qqUhRh5i91DRF2e/vpX/ZWksr
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec793856-9dcd-4832-9078-08db7c35076b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 02:19:00.4919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMG+ASk+1AxD2cUoq4u+QmP0DQD9fxzFNokvDiaiCTTteTKIwNX3R4CgWY22M+KTShdwFLsEhP6JbDBfNk6RAw9hkj8diQUqmD8S2fNnqVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_17,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040018
X-Proofpoint-ORIG-GUID: LnUoQgG976eEEtt4S6BKg3LNZ0gIS3nx
X-Proofpoint-GUID: LnUoQgG976eEEtt4S6BKg3LNZ0gIS3nx
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 4:31 PM, Matthew Wilcox wrote:
> On Sun, Jul 02, 2023 at 10:58:49PM -0700, Sidhartha Kumar wrote:
>> Saves three implicit calls to compound_head().
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   mm/memory.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 93480e846ace6..33bf13431974c 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4594,6 +4594,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>>   {
>>   	struct vm_area_struct *vma = vmf->vma;
>>   	vm_fault_t ret, tmp;
>> +	struct folio *folio = page_folio(vmf->page);
> 
> You can't call page_folio() until after __do_fault().  Did you test this
> series?

I thought it would be straightforward enough without testing but I 
didn't realize the initialization in __do_fault(). I will test and 
incorporate the other suggestions for a v2.

Thanks
> 
>>   	ret = __do_fault(vmf);
>>   	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))

