Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE9D70CCAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjEVVlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjEVVl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:41:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAE5E0;
        Mon, 22 May 2023 14:41:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKOTj6016139;
        Mon, 22 May 2023 21:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=O9RS/Ntbn7BTAor4ZAR5CrMu6YUs7wvYz7pfj91gEQY=;
 b=xXgynlQ2UJz8l2xD1RWFJAzZF1mrKFav5CU0vkQa1CSxZvlriB7PQ93BiVkLXLfzJt1H
 3+uztSsx0O3NWHNT9QDUWZFC9yJmU0AizbgOor+4L5H0ixewWIgjgNf//Oc+MI7jxTqI
 2oiqipaX4qP3AS0vEQt36adf9f1bDmTnnH/qvjJCkSgNpTBMhpZ/u8IgCWzNF+4TQcfz
 bE2bQ3FT/IdQJ0gKzG7zk2i2eEgKuA5tQtP+VWT7rws7E9j4Ziu/2pZXvqAN0NC6zZ6C
 1fB+o96x9I7LWHdVV0nBRMUZEMQpDXTfJB4rgSxmL4mnMxMTJZM9Ht90rW36IkNpSxyc uA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3mksbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 21:40:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MJiPqv012877;
        Mon, 22 May 2023 21:40:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7e0ya3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 21:40:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4RpuY3nUmY8DXz6rfbXBUGbTGOSuAPofIRwGNQhtuuBgAd9nrCKsR1u1gF2CSclFRdBBEiZGLKgrnFI5/shfmuxPa/gJpYWsMnYkNUuCleDM/xVZelIcfSGVEJQZF63qYefzjZ4KKwSscKiAHOF5VBv9FZQ0y5fBtQC98gBGxLhB3L6LqEN2DMUuA6fIccc2IabsknKuvKfsfj1lZooqivbpcAdRN13QZAVngfACNdSQ6kQC/eft0EO1AVFPZIiH6yg5YxvAxWtiG1r/cp7CoGsai8FpToLAQ8DFWcPWUobc2c/izpl6hwO7ozrh4YQlJBcuLsaY7ILKFfytyoqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9RS/Ntbn7BTAor4ZAR5CrMu6YUs7wvYz7pfj91gEQY=;
 b=K1DaNbaojSDSJl4ZcwnqBAeSlPkwKURJHz5wiCAOJrtxvjj8aX3OZQ9eVJyX0ChBiMi+LCrx/h6o6TI6UgNtVHDZgonDBaj+OOqy2JGwEbzbbGT1XZ8dsksSqPLbiwJc/IotAO7Ovrs8y2f/0jCIsoVGL3APFr4c/2Z51sI7HdHXxwUHYTlwcOqEA9/Ui/eJMJl1XHgev7Row2QDPz41fcP5SFYSmDgVr4TMHfCmdH2hc/mhLJ3Q81qCeI2AXGJsM3nlN3CPvoqUa8RhxGudt7z15D7wW47QrXh1Ug6I1NCidY8XsrNrVfJlmtIv8ftP0bbSPoQ0JM/jxB7/JFSJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9RS/Ntbn7BTAor4ZAR5CrMu6YUs7wvYz7pfj91gEQY=;
 b=b/RSAOxpEh+J0iaE7Cpq2gicIm6xy4BRwbuuiOPG+dKyZVcIwlDcoGZgSlLMCsXDk5tejFWi1/MC2e4M8M4O8HRqBMKf8z4kFdB7Ngp18pguHjywmOlGOFdNtOTbk5okyupwT7OOlI8v7bW3HtqyFqMDXCnB+Cye60gQV0CiPfY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5925.namprd10.prod.outlook.com (2603:10b6:8:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 21:40:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 21:40:55 +0000
To:     Yuchen Yang <u202114568@hust.edu.cn>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        hust-os-kernel-patches@googlegroups.com,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: scsi: 3w-xxxx: Add error handling for
 initialization failure in `tw_probe`
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mt1wnixx.fsf@ca-mkp.ca.oracle.com>
References: <20230505141259.7730-1-u202114568@hust.edu.cn>
Date:   Mon, 22 May 2023 17:40:52 -0400
In-Reply-To: <20230505141259.7730-1-u202114568@hust.edu.cn> (Yuchen Yang's
        message of "Fri, 5 May 2023 22:12:55 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 2411cb94-816c-47e2-f467-08db5b0d390d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zoW0AtNU7QmPcvr4ix5a3REDLr29f/rIpYBk+yF29My+zhe6diHwQpzSxAvvnSGPjZWyz92KbQ2lS88YEMA/Azj25f/qeU/6ELgviqC0SQlce60UVjTTHQdyxmUMQnowGkrz4Na7kOYy3zax7dnKip7M47eZxGdoN2MOcikzvrT79is5aGj/K4grXEAf3Xofbus9KPexH3M4i6LkwBYFBBbTG1oYAdEHnOJ40DkuyDe++tTtsTOotJsPsBpIeqZw5mtkViYOZYhoGLUnX6DQoscY6eLx8XHIw+daEeUxNywEzxV7tjoPJWJwJfM9v0lYEALD9ErAtFy5M7rNVPHg65VQ7xUfdUmuIVJ7DQQW7KI5kJ1NJ3wfMQI5sPM5RT2luUwL+j4GqtlT8ghEqjonAIs6Hp4b9BoA3jhBQycNZ2OdFfMcGwpwAAQ/D/hk15kfpD8/zcI7iqsb3V1wqNCaofOXCpvrl/VGjWlZf+F++I0e0Zc18jCMhTHEYG/PtIArEHxnYb7CWMy7W7YjVMCf3duzeilgTer4bywD8640rXfBIx6gSPGY132VE7a9GbuSkLWgFVkdQ++61HppQr1sFb8XyFjxYXpVPyZq4pD6Ui0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(8676002)(8936002)(5660300002)(186003)(26005)(6512007)(6506007)(86362001)(38100700002)(83380400001)(41300700001)(6666004)(36916002)(6486002)(66476007)(66556008)(66946007)(316002)(478600001)(6916009)(4326008)(54906003)(4744005)(2906002)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6yu3y2OSKbQ5NtTkNH/kuDxRB3B6UhNUKP1dJ3A3mvB0uq+epO1aUeK8kYTF?=
 =?us-ascii?Q?2vbHXYMYCJ+CUsUniWKg1V5vM7IUt4YXrYjdvTEcFT74Rg3LGRUPI0pecMEC?=
 =?us-ascii?Q?5p3j2cLuO9xvfhkm0iC/bFjlN6PgydQyh9pO+k72mregQ11vQpbipGbs9ZOU?=
 =?us-ascii?Q?lTStNg7sqC1PWYp6Iz0Fyznw8A9LnTx4MhSUzncVfh8s4f72c8wL/RoUbA/G?=
 =?us-ascii?Q?JaF36NonShlDsGxpLPnCYC9XKqJqJjF6Y2MjvhWp+i1tALmkqEYl0E0zLs++?=
 =?us-ascii?Q?rjUCjpcYy29nYQgu4iXBpwPFmH9aZIcnnapMTGoqa3gPRArMUNBx94bq/dHk?=
 =?us-ascii?Q?fxJmX+PYnSnzNMzhEHvZ7lPQwTGU25JIskdFuWZpi4h0suNFXNDGL90+62vy?=
 =?us-ascii?Q?SM9vDRB19AtbEf8io0TxIdXGHYuwFaOENYNQlee9TO0JMZcP9XG88HefiMc+?=
 =?us-ascii?Q?Q64VTBxn1F7FPwgs/nax82eBmtPq4zlshYtXp8KB53hv4XXjklc77uWRLSeR?=
 =?us-ascii?Q?bdKHFCC0NsCTHH8R8AN5+JKzgdcrqW6u8eRdrlbXzyJp0K4zDaRUKvzybiHS?=
 =?us-ascii?Q?ka95uZRoucuQyP/jvEKKQwMkp+vtTaKtIAnS/ByNDVX24PPTkohvM0BDJNyA?=
 =?us-ascii?Q?7/qPAiJng0JXs/vkbjS+pgZIOj7w41K9S55xjdVMudn1AZibmm1g7YeGCFfz?=
 =?us-ascii?Q?lp4MoUZoINb2IAkDupILcmWiZAwJs98op4WFb7uE3EwNtJmg0L/tkkDea242?=
 =?us-ascii?Q?6E1Rx5i9OAaHtpz/Tr6ivJlL7/yjNpP5OfAVIwINJOVCiLCP+rzSyOb5Z4rM?=
 =?us-ascii?Q?1seQoHk+xtlsfYWzekS3EacMlKokngNdI8Fsq1pnMkD1+8Vne7IsfbFJp8MA?=
 =?us-ascii?Q?PEFc374QkzWIlYut/hpqUgO2GEJ6FKCWeJqFTjBpgpO7I2g0IggIwTKDtk5z?=
 =?us-ascii?Q?Y7pk1OXI94qTMIgS2zllMEZHMk59KK4bYZGE1sKdbvbPPUh5JK82B80znvcX?=
 =?us-ascii?Q?bEarINDqXgHw0CGNIxYvc5k+sAa3GnjTi7faXdZ9H6YdaSH3Y7U+7ycXyoo7?=
 =?us-ascii?Q?pHRV8xlVdiWd3/yU3KljQGA3KpTcyGUsAvErMzSB8rqhmxBaJEqDGBq+aVKC?=
 =?us-ascii?Q?p+ATzHUjjsTMiHtqnbJuvNi6LpL0IGTNY/I0M7WUq5mnNI5C/2cjUtKze5kW?=
 =?us-ascii?Q?We1aHure07bUvwEQ/cYuB/HTe/Ist5JP8ynlxyHkWn81bY40TK1pDOZZbK5r?=
 =?us-ascii?Q?H0D6HCSrNiK7J0RMe475vnA8mQdMnADYheE/KDcuq+JbLXdZt+c27VHnoq/0?=
 =?us-ascii?Q?jW2TkuLgXbOwzImhj0DCJc1xMTooVRu4hhZ2SXuhGqukUmtBW5C7fJ6AjcHj?=
 =?us-ascii?Q?AMQqOEl2DYngqiABGzkOsJp1PbRtFpulxO0uKEipXLxb+Zfny5/ZhJHQnJau?=
 =?us-ascii?Q?L/9dviVt8bpsoq931FRKA8yhqlswUi75aZR+erWamV+/oBMWhFae+c5tpU+d?=
 =?us-ascii?Q?yTtEZqkr9PtoZLF6LLdE478GE95tLKzbxr3yuzysnWEz4nYqxsupZRbyK+Gx?=
 =?us-ascii?Q?f45rDPhHY90IIsCVm4mSqu4lD5Tnf8kbB6YbDQjZm4/8q7L1tmiaiQuX/k6X?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LHiORSRTEr4zmVtexAKoeyA7AyxJ2BmY3IUr0acVCEYCKN1fe4WUXlXnsUs3?=
 =?us-ascii?Q?bYUv4O+zAPjNfIOkp+VEGLYopVl6Ih3E5vECEcTBtLqYGvRkGdNuLsLLBe+j?=
 =?us-ascii?Q?wB8ncNzSTMBNGMs2kZxeBKMj6YtD4bhJdWeBxq8XGlBnEoVaUmnw1m1K3NVM?=
 =?us-ascii?Q?qKoVLlZnC8vaGE0S40g1xHq19RE2i94xxAVnjciOPX8mbhk9UX6jTdt9tzII?=
 =?us-ascii?Q?u9MXn4CPn0ydyS/384UEltbwNcBzqtWYDbzX1xAVroCN1aLgOXSFda0WXVBm?=
 =?us-ascii?Q?Ox44JwCl+vdlbdXlfkL8Ln0VEhKiahhMY0/PjiVeL/Jkw96uCON5Ukdt1qTY?=
 =?us-ascii?Q?kXEV5M5ZPRMH64GOS7OEVYBSSialP+8nXRQI7FXeDXM2OA+mg/SxSNtin5NN?=
 =?us-ascii?Q?+Wmz+kuwEfXQ2L8EPoyXkkgBCmWmJEe0QXJOODJCQahjHiCZOQ6ltGUpYhnR?=
 =?us-ascii?Q?lGrERddENsW0V59/jKgo29Hyq7OojHiA2PD8xE8WCii5hAWC62epcpC/mTUz?=
 =?us-ascii?Q?RzZyFRRxJEnE05MDjBxloWiJtNOZ5uoKHh/pWBM6P8EN7VWVLy/s/rmexYY5?=
 =?us-ascii?Q?/iPqt83JSEH9j4H2fI8IkMnrI0tS0wOR7704xyr8uvRrkEPyZ5U70fUgXxgy?=
 =?us-ascii?Q?PQfEl389POsP0k3lWB3jGX+loJSuCSCvU/iYItwYAyP4oqe++nhbHXiRLI08?=
 =?us-ascii?Q?wSITmbwQhPn8MgUdNyqO9HHZz/U0bOFi5Rj6RpaWNyQu146YNkc1Nqm3ZVzB?=
 =?us-ascii?Q?/62QHgWcVh7qYiFTaXXPcrYTD34algu3c4r0SwVFITSTpj537t/MubK45XsM?=
 =?us-ascii?Q?zeRtLZhxxWxnwT91actwkkezhuN0WvhifrVv/UFJdhsptHMt40UwR5yEZfRd?=
 =?us-ascii?Q?+hnaxvNWeJ8UplSLH1uDfxTTNbD+LtL5oCAzEvC9kCJMzJZuw08AO4FMa/4K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2411cb94-816c-47e2-f467-08db5b0d390d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 21:40:55.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9f2plG6Oh3O7Mse+ubwFZc9Hg1zknFGMFpxx4465BTT3vOFh4s2GduV/mG/AJSq10w41q2TUi0+dkToSqpnkLJcS65WSRs/Zhov718ke6wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=637 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220183
X-Proofpoint-ORIG-GUID: L4uo7SL0hoAGRh5suScg20tR2iebtyfr
X-Proofpoint-GUID: L4uo7SL0hoAGRh5suScg20tR2iebtyfr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yuchen,

> Smatch complains that:
> tw_probe() warn: missing error code 'retval'
>
> This patch adds error checking to `tw_probe` function to handle 
> initialization failure. If `tw_reset_sequence` function returns a 
> non-zero value, the function will return an `-EINVAL` error code 
> to indicate the initialization failure.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yuchen Yang <u202114568@hust.edu.cn>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org> 

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
