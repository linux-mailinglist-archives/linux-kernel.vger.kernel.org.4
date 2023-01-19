Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC75674434
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjASVWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjASVVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:21:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C574616D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:30 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKx0Pj017696;
        Thu, 19 Jan 2023 21:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=RmtvA3kqCtgodpedmZsZAiY8pDqRCnqPRbwQa/+SAlM=;
 b=CbDbxWxPr06wb7g2iaw8qBy5A0Gv35+p2CcCzDzeEDj1I/r0nZtLXgMz1/sOjSE5Nwwc
 LgyWfiq33e+jOCTUs8fj4te1nAnBVKIZwYEqxmQeHIenlJNMfdTgZ4pS8+dDdus5M8ko
 4DmX+Kb01NFhH+fl/y3BNDtvkYzrme4KVWLvXzFrz17dUtRG3WyID7NdojyYHeANhN4T
 /hyuB3r5YA2NuZTDX/S5JDVxrWTplQ74dN+H3WjpmWfVoSQDf/Ga2I2uPNE8IoITLZrC
 Ow+yy10X6rObl+fjVGqo5m3l4gsVfuQULHfei3AOpncRSthM0RmdD/WFOPTh3THa8pgw FQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaak9s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:14:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JJWBTR018769;
        Thu, 19 Jan 2023 21:14:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quh8svu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:14:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLHZaFsGzzRIgNzf+brz4z0IphIgX2dEsVHQEdnRxbPvomNfCLT2SWS8RVrkwARNsZq+Kv6N9gq7mdG6XGViKsTC1NPOxs/fombOW0sZU1htIcfXuogMPUXBIaszVhi99UisJaJ2vUI2EXLhqGNbMmy8Y6MElD6LOaJToyJ0q4lNIN95N5oj9GmkqnXfOQWfIg5d0Scrueit7w0mnsgGgzLafN3HFKa/1yRsRQZI0I+2IlB1IgkkbWMBAfH6uJlKNpk27D0RGrT3om4Z6IwrqqMOvM9mpO/Fz2Ob6PqEeKx5iTULPPvuTbkQCKZkiMd9Jl4xSdKUqdXUYBmQ/UFGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmtvA3kqCtgodpedmZsZAiY8pDqRCnqPRbwQa/+SAlM=;
 b=BgpY+pPZt5xZgziMkfUEzcIikMEHKp1I1CYMYaFXlyMUrziYPQFSo4dJ6gBDU32U8iZaRcornnJk5Ec916HX0ftnMdOGF1r74bwOyyosgdHc5J6MsrLy4u2mKiQHIuEnc1Syhq8Nt0IjnVvWdmszLFMHaJQQUqPkFxPzaO08A9Eqt6co4kVXoFgZvBH5/RF/SJQVDBsnOwpEnhzZIz3fFwkBdymkaRF7C7y7lNw7VQbohJwbOzpstsci09vjZMiunfRMMgNcHKRdJ5qN4BYYIahxEZWsEqvw29Awd+XOBqmPwuOHV/GKxwsLZHsKaST39f2qgd8azKjFeqVZRLca+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmtvA3kqCtgodpedmZsZAiY8pDqRCnqPRbwQa/+SAlM=;
 b=f6tSu4luhR17FgczoKyV9DAqBeFEs0h3OEisdWzOaDzgRTv43KZ+qrW26q5wCD98m2ziqBo3ih6i0ee+idOiOpuYoUWiWp6emuu80sQ6OYinccoEkfyEW5+Nc+IOxxwvRWxCDaArHfwishXTdz1Wk19j+f0NTDRuJeZq3nJ59FM=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Thu, 19 Jan
 2023 21:14:56 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 19 Jan 2023
 21:14:56 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 1/9] mm/hugetlb: convert hugetlb_install_page to folios
Date:   Thu, 19 Jan 2023 13:14:38 -0800
Message-Id: <20230119211446.54165-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::45) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|SA1PR10MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: d22a0594-0986-473f-991a-08dafa6236e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFOxjED1Lsdu9fR3AT3YphOFc8OUR5fM6fOJ9l6+NQHEbIDlPtHc8dJ2xg4qcMHXwNXsJzoRJO/YJ8bh9G/k6o1MoiDMZ5RrX/oZVv+hOoyTeDj8V9rfOCCW6aY+osN9UVrwWXv+OIRJWbILCQWMbcdlepMyUh/b8ZiYLeE3sL2M4zPG23G5wQOR9ITlycqZfP82kC+GwCjg+5Kl6/6GsQqdY49G2IYDfIJe21wWSK66zvD/zhxBpI3AKff9abAs67snIPw4ESb24I9r+SL7Qp28YHlzZQMK97NQEDeyZMvQvNajPM+/xwhUZc68ExYHXR/8DiDIiUDAnUd1O5qPqkwQU/wgE7oEIDSadpW8Rm7Sbimv9c1sANjjmhCrRLIRN9XMv5l1iLDO0Y5Llck378lJpWdsvI014hfOeZqaKWCLWbn/VTzzpwpw10t4mL0yUhTHv4eCwJYQ/K00cEdNpjjVMuGCcr8wz9xzBqMJCYja6Rz6ficWYd4tKaPyaQH/so4N5PvI/cUPBlQXARYuajCgmRTvIePcoxbMrvQEzTDerD6oy9kA+WrPqHQA7QY+TLitmH8+R3ngodS0ULy/6jOXp8x0qmolZii4tHWNnHmUmxukqT3S51LkHgr6oXfGNEa2aqgbQ3upEs8hz0CCtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199015)(66556008)(83380400001)(38100700002)(5660300002)(107886003)(4326008)(86362001)(8936002)(2906002)(66476007)(66946007)(44832011)(6512007)(41300700001)(6486002)(1076003)(478600001)(186003)(6506007)(2616005)(6666004)(8676002)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b44ZdWPNM9MJxV0C5vf0/G4ya8Kq90q65sVLZSlp2lDbSOukNQ705szwuwSj?=
 =?us-ascii?Q?nAjvEjzPnp9ihAQDPcq3ByY6H7hZufjnv/HY7beQVwTARuqrmvG/njwLiVy4?=
 =?us-ascii?Q?LhDLoI662o2dE14JqfHw3TJlljMwMpKI4lQejQay+5WbhizbTLN+EmaxWfNZ?=
 =?us-ascii?Q?ypHNOOTiGdC5QDpnZy2O+afQ04ptxi1fHQ7cskF+H4rnIidJpu0QGsr9vdBy?=
 =?us-ascii?Q?ZSlRdroc8+z7Ln8dYdmZQbpGQIAok9gKq2OnXxM2UhXOxXNquPTwqWddhryE?=
 =?us-ascii?Q?d3eB35XVX+zhYhGKyItLguStbZ5v/lv7YFx3nf+GQ2KSnLGbWVO5Z605NGjI?=
 =?us-ascii?Q?Za9dBNGpGfiPCvrVYY57NXy5CWr07oUXi7gIjHTt/W6FU7zEQIy6V1r5j8gg?=
 =?us-ascii?Q?fdrE61gpCrjYix2BqzPntM08pBnQz3uQ8Ic1OT6SkwHUamQ5Zw7VBY93n2vG?=
 =?us-ascii?Q?JB7cFkQ06TlBMQ4cWwefTflVrVrhdcYZNZmCLHADK1b6NDsuiiiV5sIfwis0?=
 =?us-ascii?Q?1L2cWfGDK6PW6fL6th16lZnfu26BVlsvEVnvzmqC/9J2AzKKveGtHJekr+Kn?=
 =?us-ascii?Q?zgGyjmAkQmZ7VQ+4q2gkCzOAgiY4F7eS6WtSbD3UUiel/V8opnR5fPnEbAYr?=
 =?us-ascii?Q?kJtZ38wgJDcQQ0P6V2WDT/YAyAqOe2+TXnBi98HUGcRnhHT92T29xipGk3G+?=
 =?us-ascii?Q?kwL2wDavq8tlrXR/SAAq6HSAlFBPKRyJxRyDHJRgDi01diFFKfAPthRPaHV0?=
 =?us-ascii?Q?zxCxLD4bx4nzedviKDFuNUhygfnooEQWludbrAptTS6nDeUzugJ6+xVRZFN+?=
 =?us-ascii?Q?3QW3IsUY3wSDaxUhp/BfCwzfurbrt3lhrOrU2U8WyPyG7EhK9ZEq02POGK10?=
 =?us-ascii?Q?73ZAwCYn/Vh5MS7yFU8y4sijmgUCBfFZvN7J1gWhZtdyp01SRi5autac1J7F?=
 =?us-ascii?Q?0RUPkW1B6JT17NRX+f6/i5hM+lkgBAI0eS8q+hGofr49F89OBVfZat7ESROG?=
 =?us-ascii?Q?IgEnL7S2fxxPPGSl2zqTkB4IqjNjdc+sB6Hj+kLtEBaJdwJZmUzAQ75VOYLU?=
 =?us-ascii?Q?ZLUUwtrp0jedkBkvImwb1mOKy0hipQFJVfijXWVIEQaDO9wKiQj+UJrHhepf?=
 =?us-ascii?Q?XSBTYNwUf/eXos8VDZodazFdQjKANt7uU/w3sCMAeFTmB39zkkXV3C2fcChy?=
 =?us-ascii?Q?VEG9PMdR4UHN33bgchnFfhhaoBB+x+RTaX9gzUxvPdg1g6J3woAqS9E5ZRau?=
 =?us-ascii?Q?nJUI3UvdnR/tP/JQtaZ96Dv+BXBrO5cIs/X6jU0RPg03TW/9zDFgvaDxQ8vC?=
 =?us-ascii?Q?zP3vUGTOBqkwlMnV2ORJxG1AQfv2iGaT4Dax6PDupqz3wzWoHkuxHpGVAGRX?=
 =?us-ascii?Q?rJm60cLYjDxoSVS4sRTv+cpP8JVttXO61UQy3hf7MYPJHf2cxR/DIkNYNU2l?=
 =?us-ascii?Q?ryhjj5EHn4ZJ6z7GblGZpZlGvSlMUMJrt1nmV6lMoeWua5itueeNGQPd4+1W?=
 =?us-ascii?Q?xEB58TzX6i/7LZdS7VKLI0gZZBIMmr/EAl2KneykcBtTOOfL5uM4AK/9z+UB?=
 =?us-ascii?Q?Km18zqFIAmrmULn1taqn2dMMY2aHb0uI3qFvixsNsOJ/S+aCeQYHOsw1HiLC?=
 =?us-ascii?Q?8sKGU2EhYzTpXA9tnGugWFEVgzVAqOOozMhX0fm8UeDh4D8vi6fQp/gb5+nY?=
 =?us-ascii?Q?cgNOfw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pgy0p7u/kcM2CHh7qKPsN8zfoQn9DNsdfw9iYFJ7IXxS7ZO25sJAfUrnX7PT?=
 =?us-ascii?Q?Fqs/S9EP8H65/MotMbvh0uLPlWp1fU9KAPmU+IhcyUFIaDpZCD6rCvaBan6N?=
 =?us-ascii?Q?gJO16x29/CMMUfPoSFw5eWrYaYXE+MHC4bxPATrJZHa2r8HQeWGUi5vWTTSR?=
 =?us-ascii?Q?7+yg6TzOuCnBaY0z5YTN19jfTCAiX5Am1Hh/ZhIqHeK/wcUdkN9/VefeBTfU?=
 =?us-ascii?Q?uBDc5TC/1xcSBlc0NVleMu7MoRO9/G+d0Tj9OeGEo9t3XulsuqQ0y+e6RsZO?=
 =?us-ascii?Q?IrSa6OGnDW/l/+RBb1saawmjaAB+kB+HQ3J727gMsPgE7XDIruqKFWnix0uZ?=
 =?us-ascii?Q?Wl1dpO1tswmOvJOVBMwRPqlCH//ILHZxwabR8r7pZjGMwBYfmf3jMEfxHMdt?=
 =?us-ascii?Q?q6svNtTCF7Rv7CdCltgxafMcZiI5boNiknYTwUb9fvGhqD+EUXzmZ6wgCgFR?=
 =?us-ascii?Q?Gd9tMz/HGPtqKm3E25L+VvqMciy2sBm2KoIZJaZ/LpPUEvFea4YP4pq59T9z?=
 =?us-ascii?Q?d+al7UR2Y9gjP9Tr7ZL+8Zqg1BRV/byTDmhLlXQYq/VGGjbhrWZobCWlFNrX?=
 =?us-ascii?Q?u8LH6XWebgweuLa7dmc+gq9/ruC1t5Gm3a+9glUph5bgOadAfpnuQ4gkcHDQ?=
 =?us-ascii?Q?Q+I+tDft4ruVRWyAUEC8WbeZGr6M7eCVTbqU/3dzuZ83fdnTe141gyfnwP7m?=
 =?us-ascii?Q?AokYRV3EGL5quv96w1uVt5rxWxEiqhUliLG+oMliZSbEAequ2Bh124XhI9c1?=
 =?us-ascii?Q?TOesmIYiuM1Qr8q/+uiByu0KL0ahRoFiswaKTYAeH0jb9Ll9L/+iEMiOmzi3?=
 =?us-ascii?Q?TsFxFU6s28KR18rxe4BUJiJyoEPHJ89fdfYxxGOisw/JUkWRqAmB+Un4/GBY?=
 =?us-ascii?Q?KnjcEwitOOULxiJfX3e8TXuAgh+izb4XxnfJZNwnzbUZBwoI0IRVCmoCoPAt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22a0594-0986-473f-991a-08dafa6236e2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 21:14:56.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrmxVsZpd9qTJqWhFGFG8fnbpgce0AYbfazSg41qNXUrDqBik0PLtTOsuruipah66+J2iL7taXVnGRU7Hr4sjgKCgwEPLw7QPD8xG148jg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190178
X-Proofpoint-GUID: M4TMB-CV8n1WS0qLuIIaqWGu-QRK-JYV
X-Proofpoint-ORIG-GUID: M4TMB-CV8n1WS0qLuIIaqWGu-QRK-JYV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change hugetlb_install_page() to hugetlb_install_folio(). This reduces one
user of the Huge Page flag macros which take in a page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d20c8b09890e..849206e94742 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4946,14 +4946,14 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 }
 
 static void
-hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
-		     struct page *new_page)
+hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
+		     struct folio *new_folio)
 {
-	__SetPageUptodate(new_page);
-	hugepage_add_new_anon_rmap(new_page, vma, addr);
-	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1));
+	__folio_mark_uptodate(new_folio);
+	hugepage_add_new_anon_rmap(&new_folio->page, vma, addr);
+	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, &new_folio->page, 1));
 	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
-	SetHPageMigratable(new_page);
+	folio_set_hugetlb_migratable(new_folio);
 }
 
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
@@ -5107,7 +5107,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					/* huge_ptep of dst_pte won't change as in child */
 					goto again;
 				}
-				hugetlb_install_page(dst_vma, dst_pte, addr, new);
+				hugetlb_install_folio(dst_vma, dst_pte, addr, page_folio(new));
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				continue;
-- 
2.39.0

