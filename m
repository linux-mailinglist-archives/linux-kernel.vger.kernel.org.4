Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF406D3CD8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjDCFYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjDCFXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:23:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF7B5FD2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 22:23:15 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332ML952010090;
        Mon, 3 Apr 2023 05:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=4gImNjdBdcopMpLrPUI6c2EyH13eycBU+Tw9ntgOP6Q=;
 b=VAXqkuILTv1fDmRnW2ObaZ5Y3mpmAS5G9sXXZ18ssmMK2aENP3rweY+kmyUosGNQ91ki
 9fXkBRil/1wOZlhtaU+QMCN2UYI1MgdRzJUh14rfk5kpsSE3o8ZQC/r5LW/DbF5dTqp3
 nvQBeK2nINQTlk2bji6xt8VMjh6ToTPKO8lo7F5nBYswLftjl/wWPCqoJZhf4DA3xlMb
 Ls4UMQsaP11TpQwNUwnK9h2pPcYfvN8MkKF+pWZBd323QnZ2R3F8VsbCGpKeNsRgn/cP
 kSniV524vjnqeP+QpNA5PN0BivXSAqtrW7Zh+0vfk0oVeu7gfq6N2Mk/AdSb9Oj82LB1 ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcnct4sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3332iZTs038319;
        Mon, 3 Apr 2023 05:22:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjptnpk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0ihLWkM/rbL+bJdATRKrvBavYnXp/Zp2f062BDmqwkm9RJckaDHIllhye01eOecD3q6fhbh2R6D96F5miAW0g59PxH2xog9kboGfq72EZm7zqynDB1SeoIeWESZ5QqFgvXn55vXSxXWvR8cQqWuGhFiGL2mtkyldqBuC5udI1X3UhT3CrUpnZ7OISs3bYNRHOwipnicgdAEsEakEEA2GZqYhNqJT6s4GQ0dmslb5ZfvitXlkPnoT4lsiFgs8kNPeAFgkGvQDcUBNkQ8W/TmXBPY9DmK4ZVbXYtXlHy7UM51xPpK/Sobsa9ILXBO0FDMV1ryteKaTvyHQQwRPAsXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gImNjdBdcopMpLrPUI6c2EyH13eycBU+Tw9ntgOP6Q=;
 b=lv91NjVV6ySkt8VungP3ENIpnfjso/xqzrEihbXLS3HQFet6kHAB34nZ+kG5h9YwT371pN/wInALslUkqbhc3VbvtUn21wZP0ABP14lki5Kh54Ig5kAkmLdkGY3sHd9gHNzcra1QUbEAvK+ugrLhim3J5JBYHPqac9+6e6i63lSvuIh649pFOF1/+QGFtf1Vxflwx0J5H/xSudzhso9QSiY4qSnBg6le3ClLoWlHBUdtW1fhwkQ0sO+jlKrp2w0OT2O0xfd94yG+wVjlGv4JNSDKy/DIU0hGntHtmCcqCDIx6FYzG2VldaZI0+K1YZbc+YC4Y987qRAgz2sfYRuO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gImNjdBdcopMpLrPUI6c2EyH13eycBU+Tw9ntgOP6Q=;
 b=hrxFOJGxUlMf3BtPCEx23f6FMeCKATpfuY9g9kFZjJ2AC7RwqC3kWnXghkSFwEme0Xfu2cYNr6aHsf3KBJHATzZsxw4BLqUbK7gwiukjVUwX9kwczch5q9mrja97kQaMFip1GOyqAbYb16i0k6T6d2psLJx7ZshYY3RuYxMyoOY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 05:22:50 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 05:22:50 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, jon.grimm@amd.com, bharata@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH 9/9] x86/clear_huge_page: make clear_contig_region() preemptible
Date:   Sun,  2 Apr 2023 22:22:33 -0700
Message-Id: <20230403052233.1880567-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:303:8f::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA1PR10MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: e955a7c0-ed1c-47a0-8465-08db340377bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbL+kGjbKMFebho9UeIYDAfwzB792wIeFWpV1vh9sGs83OIYJEydEXYIHVSMhBvRHES+eVIMNRRr79X+Vu9k8NJR0nTHtqmipzbeIt/N45SxqXEE1HkqOpsw35vLkg0hhw4O11CfW6Tjm1Ydw0iNXnYAc9VaVf2vx31yaRT3MtC3LY+qkreaWxsx6ArAKfEdpYrr5JZ2yEYvL5X/7o7u7fAh0E307GMLx5c/ZRqoeAJxdaDo/6vIJYLIaFrciCZq3+24PUK85Ulc3aEp2TVDoaw1q5isZ1T5Ytm21/id2qmRrT0wVgQFgQB0mK4yaMtQUdiBRVyTIdujMCX4S0M2Fry1pLdqhHLMbbr7sRB9lMtrmfTdEnQbnWRXLQuKvJgoFH8i0BzHwW01jgtEW4jXvUh5PQTSAyP6JXXIaXCcSUu3UmB7yiOzj9CCqY2gCqpfQTmDM2VME3yA1oDPVWfEQWGsCCIc5MzSRdzQiK1sqASy817NjtfCyQ2s+Wt1V1vtPzH7qYYJIMTo0p58LbCJI4mCdnCVnEuhJaVOqWD3zjz2ObXyXDEGwnTeU0C7l6hFRXZiCMCHkicNe/I/DAvZp1hR7NG5/8NW8iL7xvfIW10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(86362001)(36756003)(103116003)(2906002)(2616005)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(107886003)(6666004)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(5660300002)(7416002)(38100700002)(316002)(478600001)(8936002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7VYrq0RaXD3bgzxE/BXFfDzqbIwOC0DYaCtJqLH5lNpBA63lLnaZWuLJ3tPi?=
 =?us-ascii?Q?lkdsy+ZJFMRFm14jYuksDPqGV3NhE+nFW31Gx0vaEQLgYG5DtB1/4/LWNZFK?=
 =?us-ascii?Q?ZGBitzCcqxJY57b/BuuxWh4BCdhvg+TjWkuLbzXdsBSWEVOqlYMYmHTLUwXS?=
 =?us-ascii?Q?APMPzDA/+pKObtOnrr6tHfd4lOc3IdhkyvzaW4lWQD4t/cffS/Ml1DwEx4Ur?=
 =?us-ascii?Q?ywlbU1Hj/kHXjuyT8VqiKXq0ai9DOg/0HYrndsVHXos9ka/sueJbJl6yD/YR?=
 =?us-ascii?Q?pPi6+cgLSv1v67QlGzejM5H6e0HXF83YfzsXJ96/y37iRufWvXtmOAmanWK2?=
 =?us-ascii?Q?iPi394NaCS3+viVN2qgCB1VFj8qX1hXLn9GWU+KcmiDpo0x/kWRg/SKal4I3?=
 =?us-ascii?Q?Z1vl3qSBuHi1yTPjq8RQzYQfDSwVPGAk7ZqhbIG8BZzoiKsNLiAEgN2vsScL?=
 =?us-ascii?Q?dmHgOiYhN2csxq3lIUNqtes7FGzCU7SkCtYlaK/ua2uzW7M+B1nwETsBpBB2?=
 =?us-ascii?Q?/iont+xIF0Bwbt0ze9z6YaCAjZiIsnDXlK3hZxzBYWZF03ihM20VNuhStgF0?=
 =?us-ascii?Q?JpzrWWKcyiR1JheGP5boZkKHOQufFHpTkjpHWmXF63eXYLTtAzXw1zdOZKpj?=
 =?us-ascii?Q?DGG2huHj9+xoUaM7IIbryj2eRy36xVwSOtpyLorUAztf8Apf6RVje4ZqegPn?=
 =?us-ascii?Q?qIop15cCy5soXu3hfWIQwzulUZCd+WMCQbyfLzHkIJ3FReZTaJablAyOkhqT?=
 =?us-ascii?Q?+26m4mahzcyLVz0U/Vc92pDcE11fGqxQTiVb8ThmjW33PvV/cT6wN+aTCPVY?=
 =?us-ascii?Q?MNzyBjkTXlGpnqsX88hI2FTB53OX1ov08ltA+WmN2SmF6Xz3DUbDRxBkyhHo?=
 =?us-ascii?Q?/GMufWTcWlPjKMiPap1V8VPG95D8w/WyuDEp4BXi5QgFgzd9jVjP0+2no3bS?=
 =?us-ascii?Q?IIXyzkmV3yRpZitM8bH0hmZVJdg5UhdZJBCmD+4poXmAvgeTTmfM0xdlLXqh?=
 =?us-ascii?Q?tbcVARD/MDq7/yhZ9vfbioALR7EjaILBzKIfbrgESsznglPrE5FOo624UjsA?=
 =?us-ascii?Q?YCSeBvyE4Oc42zVx4XZ9SQKAOGQ1BfKGEqN915UW0NpKeSAWqD4CAqif0sv/?=
 =?us-ascii?Q?EEHkxFa71mfJ1cyIplzf5HHgFKFAPrU/+hewPly9TKqOjQVdi+aH0hj8mW9K?=
 =?us-ascii?Q?P/Yc1czmdf4XlgZGp0XvDmfEa4h/SW6QlXs74DUtt1XSa3rSXbGpkUjQcl5y?=
 =?us-ascii?Q?p+q0GGDnI7bbrcVWvnpPcO/KHwBfrQLfxcaVMDTZtvW3EDxyYqlRG3knO5MH?=
 =?us-ascii?Q?mgN37sUf2t6aaEIiYjle6HGXVS35McEoImJlH/k0Vd3cJZWJUUgnb1PIbteM?=
 =?us-ascii?Q?0l3KFT8GAf2vbZBv8jtN/mueAIluhCi8xNFqirWbvdJc5W0oMJuB1XeHB9Lx?=
 =?us-ascii?Q?wU3VfZk6Zy5lj6Cm1dL2aMww+S8vQS7aBj1ylgqT02YOlm+G1ovPao3R2e+h?=
 =?us-ascii?Q?BgmqyseJ9pXjE3yqu9govtzFf3ANq6lsGcvx5Rt/cc0rRSGNAYPlyPN79zPX?=
 =?us-ascii?Q?p/56H8nI5DmgYmnRHjQMofC2oVFr6/CwF2ekJkW1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zr7CdQo1TrKnvgmfFDz3j1d2Anwbz6bLRpTr+VoRl9+nwyQaWpYiomWGBkNG?=
 =?us-ascii?Q?mt0NUftprS8cjk3KoubFfszkqIss2U3xLl9O6CpJQs0ZdlGA9yX9VHUFIgD9?=
 =?us-ascii?Q?1tdvLaJ+LPHJylUYK0YrB3ii/R+LmJ8XN/KssKle/J8x7VYaAvnE/nAWfVk+?=
 =?us-ascii?Q?aP7sLnt6DqQxvqA/ldn26Rsm11Xw8JOxrBpnO4hDetLXuztPR89cD2IttP5G?=
 =?us-ascii?Q?zoZaHkB6H8qQwrS5BNuLkY0543Qew2FB3sYTKsLFt6D4b69uQIDKRaE/VoTA?=
 =?us-ascii?Q?53ToVyf3cJjUDXeScPzVYnayT4IdHbrETHe72U3No/NUP4lSfr0GMjKiRCIh?=
 =?us-ascii?Q?2Q6tX1c78RLaeuwIG3tuGToMY22D1tZvgxlae5U/D22tvdBbB5pCj0zBEVSO?=
 =?us-ascii?Q?25PVshq+dYHgJD9dJwtVKc3cZGeKjbbh23Doj0wFK4PPJTX2InbSVk/s6TNg?=
 =?us-ascii?Q?qhVauNFnTIovP40U+Emme9r43WH6gc07gcyzOsx7STmKWRZdcZQ5TRJdO7Yr?=
 =?us-ascii?Q?2tH3iE2BEJXvT67wHGPoadidRC7Dl2zqplJa7cAu5KkVotwPFUPxNsy5EFeX?=
 =?us-ascii?Q?ET9/2BUGbzwTASTVVtqwruC4k7ObwzevzvVNm6Kv6+QeSjJvih1Di8YILSSF?=
 =?us-ascii?Q?8G0HuNGLwwWfSlzKip+PONfJp3oAMYzAITu/QxdpsbbzeAAt+4BdxoqGs02N?=
 =?us-ascii?Q?BfAue1MyxOheYQbZlfgaS6N6MG2006KlSFOgu+oAK5/wzsfOXxmzhmp3mSXm?=
 =?us-ascii?Q?9SIgqHgQ8oRs8biJ3hjoOemDPfOQqFsMqEcfv6uJP+e3Z075BjKjyCvXCnms?=
 =?us-ascii?Q?rPcwe5O4Wa/lQ4lNXDnrz/R35bFHcjkXtl3nQiYI8B3AZ64+aJ/bXhcC2ECr?=
 =?us-ascii?Q?6RwEMb4TwLSCL9OJJ90CxxTYukwfcX4Poc6ome553Z6UX/SpohcMJ/sR7t7D?=
 =?us-ascii?Q?5D3Qj6QlqWFVVG61hYcu/Kcanazh+NBaxSTchoElgq1ntzk5HecvAJ9Nzr3r?=
 =?us-ascii?Q?glZA/3QaD9CD3iOLsmMOqmXkyMdqYIhXyd9YYGo1aLYS7hsoMIXo6DwFL8Et?=
 =?us-ascii?Q?/B7wM2Gdukn2RONgDs8vvxKEUSvw8K5gmy6ZrqqqeQm68rykVCvGS5cvD6Hk?=
 =?us-ascii?Q?rHxk7d5DlhnLaV0L3FaPhzXcaJDKZDBeFyKye0K7ju3oztBdh7LZ9uI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e955a7c0-ed1c-47a0-8465-08db340377bb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 05:22:50.3049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pToPetuEUS3W64nx5gmBwlvkqB4VZHXRQ5V0Ff95DELUVJ0dIXKXQ2JbahRL8UPalC6BtBeRJbS50q2c4MrN1LLDBTrGYYyWX/4rkAerLAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_02,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030039
X-Proofpoint-GUID: JqiodZDSs7DsfTtPyIchBXU6qHB8E9Ma
X-Proofpoint-ORIG-GUID: JqiodZDSs7DsfTtPyIchBXU6qHB8E9Ma
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear_contig_region() can be used to clear up to a huge-page (2MB/1GB)
chunk Allow preemption in the irqentry_exit path to make sure we don't
hold on to the CPU for an arbitrarily long period.

Performance: vm-scalability/case-anon-w-seq-hugetlb mmaps an anonymous
hugetlb-2mb region, and then writes sequentially to the region, demand
faulting pages on the way.

This test, with a CONFIG_VOLUNTARY config shows the effects of this
change: stime drops (~18% on Icelakex, ~5% on Milan), while the utime
goes up (~15% on Icelakex, ~13% on Milan.)

  *Icelakex*                  mm/clear_huge_page   x86/clear_huge_page   change
  (mem=4GB/task, tasks=128)

  stime                           293.02 +- .49%        239.39 +- .83%   -18.30%
  utime                           440.11 +- .28%        508.74 +- .60%   +15.59%
  wall-clock                        5.96 +- .33%          6.27 +-2.23%   + 5.20%



  *Milan*                     mm/clear_huge_page   x86/clear_huge_page   change
  (mem=1GB/task, tasks=512)

  stime                          490.95 +- 3.55%       466.90 +- 4.79%   - 4.89%
  utime                          276.43 +- 2.85%       311.97 +- 5.15%   +12.85%
  wall-clock                       3.74 +- 6.41%         3.58 +- 7.82%   - 4.27%

The drop in stime is due to REP; STOS being more efficient for bigger
extents.  The increase in utime is due to cache effects of that change:
mm/clear_huge_page() clears page-at-a-time, while narrowing towards the
faulting page; while x86/clear_huge_page only optimizes for cache
locality in the local neighbourhood of the faulting address.

This effect on utime is visible via the increased L1-dcache-load-misses
and LLC-load* and an increased backend boundedness for perf user-stat
--all-user on Icelakex. The effect is slight but given the heavy cache
pressure generated by the test, shows up in the drop in user IPC:

    -  9,455,243,414,829      instructions                     #    2.75  insn per cycle              ( +- 14.14% )  (46.17%)
    -  2,367,920,864,112      L1-dcache-loads                  #    1.054 G/sec                       ( +- 14.14% )  (69.24%)
    -     42,075,182,813      L1-dcache-load-misses            #    2.96% of all L1-dcache accesses   ( +- 14.14% )  (69.24%)
    -         20,365,688      LLC-loads                        #    9.064 K/sec                       ( +- 13.98% )  (69.24%)
    -            890,382      LLC-load-misses                  #    7.18% of all LL-cache accesses    ( +- 14.91% )  (69.24%)

    +  9,467,796,660,698      instructions                     #    2.37  insn per cycle              ( +- 14.14% )  (46.16%)
    +  2,369,973,307,561      L1-dcache-loads                  #    1.027 G/sec                       ( +- 14.14% )  (69.24%)
    +     42,155,621,201      L1-dcache-load-misses            #    2.96% of all L1-dcache accesses   ( +- 14.14% )  (69.24%)
    +         22,116,300      LLC-loads                        #    9.588 K/sec                       ( +- 14.20% )  (69.24%)
    +          1,355,607      LLC-load-misses                  #   10.29% of all LL-cache accesses    ( +- 15.49% )  (69.25%)

Given the fact that the stime improves for all loads using this path,
while the utime drop is load dependent add this change.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/mm/hugetlbpage.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 4294b77c4f18..c8564b0552e5 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -158,7 +158,17 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 static void clear_contig_region(struct page *page, unsigned long vaddr,
 				unsigned int npages)
 {
+	might_sleep();
+
+	/*
+	 * We might be clearing a large region.
+	 * Allow rescheduling.
+	 */
+	allow_resched();
 	clear_user_pages(page_address(page), vaddr, page, npages);
+	disallow_resched();
+
+	cond_resched();
 }
 
 void clear_huge_page(struct page *page,
-- 
2.31.1

