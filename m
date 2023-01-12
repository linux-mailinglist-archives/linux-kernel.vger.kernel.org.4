Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC375666A63
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbjALEhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjALEhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:37:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1051A385;
        Wed, 11 Jan 2023 20:37:38 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C2kWSN020666;
        Thu, 12 Jan 2023 04:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=If8LR1GlSkqswvfQoncDX0k/wCy24ZULfidEBaMASug=;
 b=PQzzVjYE9lzYu/eEVVa8k8ensKVzmVIz/zKfk0b7a+IXVZi3cLgR+Ac4sOMfJa47Poub
 qfMDHgiX2tgtJDJUsMYljdH+4KaJvyUZC52HH4HbVhYswCVGmz+2cynZ+3001AocrLKQ
 2T5M9VjQjrE7W6Wbn6fRSZd4D7OZswIxdmUboz67XIfXc49T2QubtKUCXAyU9pgl6A2U
 OrQDDfHBpv/lWFWAjgve1qQJQGoOMaMNY85NGTWMGON6MmcvGSGxG7xymJGIQO0FuGB8
 F4qLJShgFB9TzQZOxh9hY4GG9grvUdfevFIWzSFdVe8XuziqdXvT2pR7jIFVWQP8YIJd 8g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n27nr87a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 04:37:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30C2RaYI016171;
        Thu, 12 Jan 2023 04:37:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4q6ffq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 04:37:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2jr6C3tTPqb0vyp0wMspdxsJLrVg7lf0eLb0lPYZvjnC2pSdX4fehBnpN+zrAe60hsckhqWGXYUfPGrZYApIB9X1i/WdnA3hsmDLyIUDPuoZYbGHS2ecjWB5WkknkkMXC6lVUUSb00XOFwWPyqMkgybQk+rIzsKobBLSXsnlN2m/ZgAc/ODC3kHAe7i63EL6t2yTlY4BT6hMzK1uQM6EDvWis5Da67B2XOJCdG5T6f4vX9X+4djkXasz7WbrxgXzbaU4BjHu3R5nyuGW3cZaw6f/5biyfuMKcWgYoY0RBJgbIgiZsLAAACceksSbYx3kPjH7UjnKr+ldttdxlL0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=If8LR1GlSkqswvfQoncDX0k/wCy24ZULfidEBaMASug=;
 b=ffMfviY+C4dNUAexWstUrTPCtsgxkTEEcerSna233eygH3t2EtvFsrNhjGHiyQi30xMYtMFQtDJ/giEPv+r4QZrKsShHZ/CK6yanDSdCupQH57NxZFUtiS71clarJYdYyFG8k8i1SOBJ6ptQr6v5HIvIoXE0q7HENo9dGkukGGKrLkDkf4m/82vcSgD3EIZwcqGzion447zl/4SFupWUCAnfwQ/uNZA4jgdbqssWCmZnaNsS4mQc+1yC64R2mmyWqfotyIATMK25l52xounTG2IzmvRUy6D5ii0Qrs5gf8qRp/+FxdCVTzVVpPa98aE5SLQ9GUhN+lAOyyYrT8zdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If8LR1GlSkqswvfQoncDX0k/wCy24ZULfidEBaMASug=;
 b=vv2X06KPoYSdq1KEffHro7yYc71Mk2JJx3XnF7q0kzEyV12Dzl3Q800N7dLhW6kbc2zCh979idfg9OyBOPItvmDXhVmDdZ3Me7VYIkv4NSPo8i0jb6LS88Ex7Rk80IQqTn5HU5X3QwSVUH3Gjwhm/877alkM3TwV3DYPQ6ccmlE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB7337.namprd10.prod.outlook.com (2603:10b6:930:7b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 04:37:22 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 04:37:22 +0000
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        quic_cang@quicinc.com, quic_xiaosenh@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Several compilation warnings fixes for UFS
 Advanced RPMB
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1q8v05k.fsf@ca-mkp.ca.oracle.com>
References: <20230108224057.354438-1-beanhuo@iokpp.de>
Date:   Wed, 11 Jan 2023 23:37:19 -0500
In-Reply-To: <20230108224057.354438-1-beanhuo@iokpp.de> (Bean Huo's message of
        "Sun, 8 Jan 2023 23:40:54 +0100")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3e948e-8343-47f5-28ef-08daf456b236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sV5TDcm5GSbcjVPuuKkvnGiB6iAkWrkQJsha3vz/YbDBTonLME1Lu32VN7goCjThhR6J05qhuZ+uPpZ1n8UHQPr7ar9394G62L4AiFhgVSomuXvN02deIFevh9QgAxmK2436BYySYs6CoMEu9a59k5p1H2NoG0x+lmtwwU6OMAJYWN3WdioSTCfPlzj/767blc4Hjgr/aeQjlsyc4gFwumwYD5leusCIgwLJNU27MdDlCZ0WiBE05hW0d/sFlg2gGQby+24sQg0XW4WhLJjclVWbm4X0N4RVNxBYhyoYINC4i8IuA6Uq6XyFYhZl3wCCsFym7rwts5wFhml6Lp5iPrwO+EdC1EUF1IDlzuawRB0qklWKmbRn/mKzwsuoq7ut3zF3bb07DPpYtMdoS5Ke1xcfIob9+jmxjTiTIcfIA0C7XTNYdpjwcTkvzW3zra50RJlAtmMD+HyT3Cyx7MBRcwCFs7na8g2xsVzEXfh5oa32gjrlah4NRGMq79KYM8NfV7Bdd2b/dkzT1mYG1ZKQpW8q2CoXlrJBIz9V9M8g3DvjQqb/a+IjRcJ2Ju7yhmVC38+KyTdftt/hjgNY4Bj1A6tPR49qo8at8h++jP8AzX2tEPiBuzHlNorw/BzzwjOG2fwE31jKZSaU7ykbwvc2Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(316002)(38100700002)(6486002)(8676002)(6916009)(66556008)(26005)(66946007)(4326008)(186003)(6512007)(66476007)(36916002)(41300700001)(83380400001)(478600001)(2906002)(8936002)(7416002)(4744005)(5660300002)(6666004)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/I9ddS2UAQ8mEzsh5cM/g8BJEjaxSqVs9UX7Kug6vx/qAxA5qonG6YES5j1?=
 =?us-ascii?Q?xxryYk99lCOvR8dyMB6a7SwtK8e2UxKPsDs/iRVYnNrAKoohrAFJ4BGzBaMB?=
 =?us-ascii?Q?58WfarDjx9U0HQk9V4GqGlNDnCj5Y+1cgbtx+Nykk3STAo7IxdH5Z9DLGkqA?=
 =?us-ascii?Q?lgVXF6ZzVS12GHZz3/VfIyYEvms1zdAjstERlwl6p1dBGEPWjRNUs78bTw6z?=
 =?us-ascii?Q?FPqV+OY6bj1fvBXwRigeeJxGvOC//ACjYxGBp+Uf7xmXrwcXUYtnnamrFn4q?=
 =?us-ascii?Q?S1qUFkJBloRVGhv8bCUywHkLfzlDyoPY/YrHPeVijOMJtan0m3Vj67cFhwrs?=
 =?us-ascii?Q?1nXNJdqhGnf6qkIwoOZvechfJlBuXijhmuoU14COXgenBf5iG0lMVmUknz/V?=
 =?us-ascii?Q?ej9YpmWiufVYQ+K5sc5D2yLVR6bjTU7STfxE/0Ayxa2D5M0xOrvA5ELMWye9?=
 =?us-ascii?Q?QwYODtaRWledNnXLv/QWFOQFdxtO4BsNfKPmndyKOjREGXsE2FJHDOc1Ax+e?=
 =?us-ascii?Q?mQNAGtKiNZq3eHPtkVdK0FkwTTdyuRVICtg2vHRE3A56ot61pdOxj2FCr9ZA?=
 =?us-ascii?Q?/XsylIN6exGGLQvig2Xcw3+kFYtNZWdCTIWRf7ReXx2u9VDsblLMOEr76Giv?=
 =?us-ascii?Q?/K1CigeCdUQ95WdGWI5BGSOrgB8iOX71hugE7HbaVK/cVDaFhKWWG4kUzYww?=
 =?us-ascii?Q?iSq3WoNoS3VKCPxkhwZWWD2AWnLOhZe6jkTjePow4greqOmGwst4sHH6khfg?=
 =?us-ascii?Q?bSkUbBEaGH11O2pCRuh+/FZqH8SmQiP0cYuC1eUR2I2E/neFFxBZpMH1Kcy9?=
 =?us-ascii?Q?cuDocrPBjeXLU6ri44LJ01FWkPrHTrs4wUwe5ZCuWMrQsKZn0Inv+vRKL9Au?=
 =?us-ascii?Q?EYSvtKcl+cP6sJGuyDRLLM995Ap03mhYowFzNFWOSMkKfYNlDrXY3Y/Z8nXp?=
 =?us-ascii?Q?ZDPa4+Wj4OIitguCsB6Yu7O4ZBdp/iTAU1CRi1BnVky8q4vazbFH5Q2vH+BC?=
 =?us-ascii?Q?dRadvobeiOVVvCKbgYtXi14NWLH0H6Yk38gF5EP1H77MmBCU0lKDu4gcUhhb?=
 =?us-ascii?Q?i22AkKiH4ReLVdUk0fZDk2oZF7BTWQhY2/BYUSRCi0jDQvsDS9s8sv+9bCei?=
 =?us-ascii?Q?rxnaB/+D653ffD6o+am7DqT4647mDo5p/K9rDrSf+yIBCBuY9yuTMK3xpq4b?=
 =?us-ascii?Q?fRXZUlZRXnUATgyvpTHXO2/AZK8GrP0FjguWHZG9dymqYxfjcZYhA6Z0M9p2?=
 =?us-ascii?Q?E119TQaRzuT/V/2YHXNz7KwCEGmjaau/Gm63Nk8vQowYKtRviB5WhKw5V88f?=
 =?us-ascii?Q?EMw07Wu9qnHdi3s71FyEfVXs3TcUXVBrGFKl4J2/T18TIxVpgfN9DrUm0gRA?=
 =?us-ascii?Q?k5lQ9L6gIuxE27m7+IBqaWNATf2fYeMco8Q7ePWqC+q8RJCe3rOjqhZ8WFhV?=
 =?us-ascii?Q?NlrXbUKIUbFIk5lckNV6o589xckQD0m99P62vL0Ife4J7pC+BMYV6LgjZLu/?=
 =?us-ascii?Q?bvZXT4fGz24xQgoTx9RXTSAqwrk4YR+g86pSjhj1c7WqxbzPErpXNSe7WSSg?=
 =?us-ascii?Q?FPe8SFhN+zKpcAjk4oSyJXr4d7uizQaggjBj/qbdUDnaKVMqdWt1Ck+Jkwf6?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?R68s798tOTVXWVqs9va87s7dyqUdK/TBUz0xENLVCTtCtmcGVA0w87mul/FX?=
 =?us-ascii?Q?RqFpEeBroDkhcOe7DzJ5A2R9MPFtKZt9/D80ED+d9kdSwrJrKDh6Qyr7ywMi?=
 =?us-ascii?Q?aRBNXkpQ+qKdx4uVwgVXWF/JISzlKrOX2lfUDOzh/fPX0t+dvIm38f6XlEkJ?=
 =?us-ascii?Q?/EFQJIiBo/9HfxO6IV/TmrrfTUlh/xJFTWyPdt8wCfYCU3rBVj3Ev3p2E1It?=
 =?us-ascii?Q?EN++7T6G5jGSzkA7K0g/Jti9v8LnWQ/KARPbz9qCWnsGPGjGnjPE0M4s3SCo?=
 =?us-ascii?Q?63Xej+k2ij5vkjg+l7QtiREoNwWD8H4jH6UV/Ylh71vD4JFT6wz8BGwKvT1h?=
 =?us-ascii?Q?byfIiEAA8m7GiloMBqDbbYLKCHheCuJM12/a14BVbP4TESnnWQiiNhcVpTA8?=
 =?us-ascii?Q?DKEHn/hnWu8koeKx+SW6Bo276FGIdNP0MUKaEmFg76DtlQmwg41W2BaO4iIc?=
 =?us-ascii?Q?4Gew8m1kh6X+wZxq+lng73ed3co5B0Xm3APDUWBImG7XqcmJNwx+9OJD7b0z?=
 =?us-ascii?Q?LDHrlKC926MTHEcYLqeKxajxg+chTZYem+XNCbKqf/uZ5xVSZskgNuWmRgnm?=
 =?us-ascii?Q?pqcGDsdFzmK7162f/5zCTaXQv3MFhYgEpLzUgQi/b7D9coBEU2KekvTzqLGA?=
 =?us-ascii?Q?lZ6D7mlPVbob2ZG6rF5mlyLHSaV6UF2WL3hM1kkegDu9GF4zLKEX1DGn/CRr?=
 =?us-ascii?Q?DazsMN0zDvcsqDxUA2Fn83V9znAH1OWPoV7vnNvQ3NZvhPv0AIMqeT9MXCIu?=
 =?us-ascii?Q?POX4bH+p/8VkJZxT6LQDIsw5lLmm8GRbNpiWa/JOCkpn7SpQmxf/Ek1n4JFg?=
 =?us-ascii?Q?LzKFj1edGHOIbOpsI1yIgx7yl94CEtisp01ig2Qx0Ru7w6PeEBDId80jFKbZ?=
 =?us-ascii?Q?9+dOYTAsl7MbF8g/LW9Y1YaCD7UgztQyUykwM7g4B1pAL/t9weAdVR5heNOk?=
 =?us-ascii?Q?qhXUWPee/AZYV+rurSpdbg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3e948e-8343-47f5-28ef-08daf456b236
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 04:37:22.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlPJzCUywjsIORZjZV3Xf4sq8TvYiLKgI6YnGTwj0pQaqAI0/F90IBz+NQsU5ykqGbA8iwC+HY+rJFZL0d5ktYMlp293H16eiNAp3jBws4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7337
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_02,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=757 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120029
X-Proofpoint-GUID: 0NKTwu6YqycX9K3_HJcQEoIvx8wMuF4L
X-Proofpoint-ORIG-GUID: 0NKTwu6YqycX9K3_HJcQEoIvx8wMuF4L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bean,

> These patches are to fix several compilation warnings introduced by my
> commit: 6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support
> in ufs_bsg"), please consider this patch series for the next your
> merge window.  Apologies for this!!

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
