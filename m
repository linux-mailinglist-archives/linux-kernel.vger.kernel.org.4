Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A3665C73D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbjACTQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbjACTPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:15:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB3214030
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:14:28 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303JDrHH000987;
        Tue, 3 Jan 2023 19:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Q/ely+APh40QA7PIqRoFk6Hlp8rvygpoGpgybXM+zlc=;
 b=wSeRFYurYteDdqZqD4bubFhhzrNE3LSDIew/fnoFzF87LKWa+iOF+4rzkFxJQIJtpIN/
 qFfG1FWmy/GcV1fLw9HCFAtRHOAiI7AuZSRNf4U1Wy9Yi9o+kRLlXh1EOESFzum6RxRg
 +WiR8QzmDiMfuYDHZdrz8BPgnPedZBhrmud1nZrpBCDFpeHncGZU5V6QMlpjUhlanwLo
 b85cieWo/lBoZeZXyCTRrB8jyoxiShsvRloeoAXi4R+ugFf26F57aAavfaPLgNnt+OnY
 vrDIc0lbD8SbuPI9cW0WN1emKilLlgdVxrbJghphi2lYrBtfKo7t4rI9V4MbgXUigsRM 6w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgqmxhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303IUVKv012246;
        Tue, 3 Jan 2023 19:13:53 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbh58q0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7ri1QMkjy0cQOf06EdA58Rqn7cCczV6yWT3AMrrk9fUqSH3BqA66JAxejUaEtFyh9UU8LfqFomz/7SmPENURVQv/7qUIJRw0/dEnsO7uDYUU5RW1BxNM0assoQRrZIuacol/d7lcLCxT78fw26q3LWJCFevztWalzfoWCicnQt/KHTEYc3K7h/5ZIDxrHyu38Nrt5NopLC6sD8FdwNPXJUQoidZqRDw8jDYnnJz1zt8+FObfaveAhbYIsv2j/hDuRwzY/nDQFKF9XE/2ZWcUW2JbxP8bdIQRfc3gqxiyQwgEf6Z4caTuWUpp2xAwOovPRCPMKoebifkiVnOzjDc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/ely+APh40QA7PIqRoFk6Hlp8rvygpoGpgybXM+zlc=;
 b=Rq4QM9CHrArbcKI2d0WQfYksRsqe1T8xcS6fVMeRfovpf4ZCd1pit8e/whLgzzT2ns48jlGgG5YduP1QI2M2bxjOPqzmgMMAuoPwGFqJV6Igg2fkvOadUGkjL224gJncr28cljQcuh7e6WfQUaZrcjLagTT3iDC7qcuvqCjPujth0tMUdiHVhr27OZ6Vp0hMizHyNZgVAXPmURZYbv5HtcglYdDfByaJbbSKMghyOqCBf3sizLwXhfG863uoyhCecbO/c5Hks9qT63WchLXnTYig0OqXElT1ZYY5KILiOzcobfPf7FyC7R+U8+uz+OjxuYwtoudo+MTE21RHhJr8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/ely+APh40QA7PIqRoFk6Hlp8rvygpoGpgybXM+zlc=;
 b=FfV9hhUuoKjiZyou9/XNrX96nNorkGh/RlQls8W9imPQSgjBZDrhJjqQoANou9bS+hvCeYf7u+7Pg9ousd6EXoX5aBAfv9qpx3G3nDoORQzjDwNFuv7ZiJKEGm+C9DqrdnFOgPZG6HnjIDsseV6750Tu+NBfESvKxoJiDX6HW0U=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7332.namprd10.prod.outlook.com (2603:10b6:610:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:13:50 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:13:50 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        jhubbard@nvidia.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 4/8] mm/hugetlb: convert alloc_surplus_huge_page() to folios
Date:   Tue,  3 Jan 2023 13:13:36 -0600
Message-Id: <20230103191340.116536-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0449.namprd03.prod.outlook.com
 (2603:10b6:610:10e::25) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5ed562-826d-4c18-d821-08daedbea59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMr49GoZ7BWorU0vfjdPjXH97CT/DdOju/5eOWIQGry/9KHrrjWGqcHUPgYYUveKC2KFYg2/CfEfvjfWOLAA5lQIVd+ztuKf4tOo33/ha76ndRm5Ctqd/YNsDN+vrfk2S433XihLKU7eHgEZM2gcTI99/xNUuJjfD6crhF5zxJY/+YNrV9FZKCozTSdUMk6cjQoJJ5c6yrJofmk8FN5xznNEQEFXeG5SGOI8Ujw4MS8hiEUxfNcM2P2T3aKAUBMO152KFUTlfe6GejloWBAf4dsGMAIyb/UwyB4A7YWdYWgadgDpDmiTtXq1zBJsSAgfNEXzzvj7jGJeLji81Sb5dBF8xo8jcuOwiG4R9TpjvQ2lZyR4fA8tW5Uq+fuU3pUrS5vcN2LDtEOPQbsqM8HHCVxecFBw4HFu+a4wSRzELznNIZQ2Va4EaTvntCqcMyrdr0+slXlxLIMrqoUYhC0I7TIjFnMg0nBq7fWGzf0L6cdciub77elLZD4ejJTgf74dqxIWRTmENyzTan5df9QhhXaMu+9ROn0IES5Sy4IMDbplVJsY3p5UWmQ1uZkrVuCZo4Ly8TEaMFpwIj2tF6kpWHGEc+O4RewlAYQSE02RM6pqrzaoYXBG2UD4jPIc0z+7ldcPdEjnt6Q8659phHXrr/NPaGSChRKz+YBXbKEVZ3xpF0xMkuU/RxYSGR34N/f+Z9yQyuk56xT9QnUg5Q7KkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(5660300002)(2906002)(44832011)(8936002)(8676002)(4326008)(41300700001)(478600001)(316002)(66476007)(66946007)(66556008)(6486002)(107886003)(26005)(6512007)(6506007)(6666004)(83380400001)(1076003)(186003)(38100700002)(2616005)(86362001)(36756003)(22166006)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ufvHpW/OvHRC7UphAjvaBH6FrpvwjitSPQ4DmgS/5GXDyt//NsAvFjAZCQkW?=
 =?us-ascii?Q?/KirRki2Ta5rf7JgsWPRbhtYbfdwLnUzhwQXBXFkBhWQOQbKeTHK+5y1FQ3f?=
 =?us-ascii?Q?N3cqwqjt6iUo0JoDcCml6V28VBgM6T4q/C9hedCuO0I5RjHXftNZ8jf1KlVC?=
 =?us-ascii?Q?R+5Vh9cpte83CXayxi2atDYZ3C7OElHR9/AUocOKhwk/iQqdhXYB0goazU5o?=
 =?us-ascii?Q?LJ9ydPaUiapNYhqqd+ML7uOAOTM/uItTVzB0oAJQ/QgO/ObEqfgvXb4yKq7U?=
 =?us-ascii?Q?OQvC3SEB/miILnu7dEkw1vMQn4mmRnwxpw6Pk8ebBdI+Ti6lOx7b8NuScpP4?=
 =?us-ascii?Q?EZqVySDwV1aZaBrrUzrVEqWbRmPkL7Pq2YUdAmSg64iFNQj0mkjXx9hIAoYQ?=
 =?us-ascii?Q?y8DL7ipeGCBlbgNMyO18e33gTAF43sPmTqmb942Wb5QVQ/VYO3b+NrR2MAan?=
 =?us-ascii?Q?FFnWHkLGyNfd/PbqzEcjqsTX29yrEhLzHwUrOdyk/DDWhRhVSyMW9Gf+XmQC?=
 =?us-ascii?Q?ZrtwDo1Gr6UTtjXHe6uaGUvZeluAzZFhoGtkImHwWpzqkByYtMEO2HpDpfYl?=
 =?us-ascii?Q?wzPbdp64dmFOo8DSX8EQaVYciQVy9m5nCEi9xdLnw7DeTBMp5T7yNutYhyAg?=
 =?us-ascii?Q?LXDKZxwr3kFHg4bHbiXUNdzGmb/LyfmT94t9WlSF6hSYK6zdUAsbZtnIJaL1?=
 =?us-ascii?Q?fVfj3yDRYdeOOnCOFk7eUiUMS5+VMWGMctSb8PttCXM2MZk5bDQuTyQSYr5Q?=
 =?us-ascii?Q?5ifefx6iAP8O0YBV02UkWLBcVPuM0+zcMBR1deVcZcKb92yjU6qtvGmqNIFo?=
 =?us-ascii?Q?nZawj4WSugB0pYyju51fDMu3TZ5yjvaxrNjfkG+asm3jzx30wk5tZIv3geU8?=
 =?us-ascii?Q?JYhoNF1ph2ZT/iWol98c4qv91c2gdNd5raTJW/RI7mye1QCayNuCAx0+UcPA?=
 =?us-ascii?Q?sO1soMvLPk8pGr5432bsmaxAOfnpizTTwrPhQ9nmnqQttquAXwRyDtYcMzg+?=
 =?us-ascii?Q?Q6pSV2GT7N1UvFhDuD7oa6Q2VO/oGSkcS4P544foaBDjcd+DBzo1zoA6fE1H?=
 =?us-ascii?Q?lxO4v6ASuLLdWYFd6zipVItyXJlVQDWG0A352qrpAZwA/YRvBZEKJGfWwryb?=
 =?us-ascii?Q?3LLV9Xd0ppYrjwn/vaJ3GN1nsV105yzCABA8biCENaiSonbw0qJon5uUrzbs?=
 =?us-ascii?Q?fGgMzXS/nnz7DRVD6zDdK+xS9p1Csy5iDfzjSD90DP6ygIkvoo+9VX5tHzJ8?=
 =?us-ascii?Q?1gEn3xn2keKBP0+J61PzPDB/4PCLXDUWGujEhv/NxH+0XXhKBb5QXFTN6feZ?=
 =?us-ascii?Q?KpzogZRTQcwYRA+HjK6HBr58ns2Zllwn3t6L7kvIiDj7MlnW6uy5oy4fDidd?=
 =?us-ascii?Q?k+vJVxT6EQbbMBKWGLytGFB1OPbFW2XHk+RWG7yup+cs/+iKMIm/REzcpBts?=
 =?us-ascii?Q?iJIz06xLF/a7AVqgW9rE7yNRiNGBYvWJvLpmWIe2WMlxGpskggmWtEc/1kNV?=
 =?us-ascii?Q?ME/NGYTH82mJ1v5/IOg25/Up1MX7AOI6Q7M2pfCDmGC8I8AUfbqEBn6OV7fC?=
 =?us-ascii?Q?Pu9hFZoAQQeu0q34eHD+5xUJ0/RZWUNBs0Ura2zpMnAs14KYMTME44O4BC98?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?eCdMklFc9M6fnK9Q1Q2neALlxe0NP9mWv7mkEVr2KMCWzCiDZQbmfcdv8yLP?=
 =?us-ascii?Q?J+b4X1VkhLU90Ep2J/vaMGRs6H6OvDfMhfB6ca+lC+kmmC2gKxrawfQMsEf8?=
 =?us-ascii?Q?RzQ9Cy0M8P+w+Y12N5yMZh92+35wMoWN47sUUG/Z3eG5kzdN0citP4AzX+SL?=
 =?us-ascii?Q?/EzgbvDCGfoz5Ll1CIhFJScS/xEWPTSJUA6gjxI+IcR7CuZ1uyCtFldl+Meh?=
 =?us-ascii?Q?PqcljKn0QmhlkUDdpkr3vp6pAt4QutLff2XDs9RECoRNp6fKbQwe9iFwE6Le?=
 =?us-ascii?Q?SjAP9zPI/JGqd39qnXmjRf+e/LFaJOkiEyIUUzTNTwW6zXUXKGWhymXdLF8a?=
 =?us-ascii?Q?M1E+FHVPteMVUGI9ispRxtuAJhQWogknXwcZSts9byTm7kJrk1zy9Q6kqdms?=
 =?us-ascii?Q?7cWaO7bUXNQUCQQvrNUJPmNZegSaVeiYLAN/fjAgnpgZWRIX+/9NyswAuzUl?=
 =?us-ascii?Q?AclQeT2ZrLeltGHYzy4RfRndiA/83w/ID5oHBxOtcHvnjsQ7XgM1gK2VZsg4?=
 =?us-ascii?Q?fLCiC1vTSdXzHeOJkVgo94t05JcwZbTaWySlkU+Tt1iYjdvf/g5LU8CCXG49?=
 =?us-ascii?Q?FIDCIjVoWmIeIQOHUfin2C5nRjn37Y0nyiyugDhIaca76pal01d5b8hgt453?=
 =?us-ascii?Q?ur1HTtffG5+AjXFc0Y3Uarr91U7FhDcLRXfdNd1xvWdSfK0TUKFJXk7o9bPm?=
 =?us-ascii?Q?TUHp5/nGU14114wZLHBxSEzTiCEVWhY1X9UM7u4DRf5Y0PKYR3DcQr+mQL8p?=
 =?us-ascii?Q?yuVzT+p5QBjuotQvjscRGd1hCne8/7VP7/vhvAIK7zQ7pJCcXhmGC/yELKuz?=
 =?us-ascii?Q?o11ApsJZZnGvqQyU5K4EoxykaK9AC8DSUDS4IR8dFSeGoj2dvGmtBHJiwssU?=
 =?us-ascii?Q?H959hJd6BelRX0EZjqAE9Ad6754QHu68g/YGoOHSwGO3vqRirNWYqRRz+vGz?=
 =?us-ascii?Q?xPf8CspXuiB0Tru6R8IW+wYCA1ngYTtQjwU+OcGf8Wo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5ed562-826d-4c18-d821-08daedbea59b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:13:50.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMBz6xhX9YgqnjbGyI0VV/YMk++zS/e/WMgE4CD8tbJfJ6InKq41MpgmeQaHQ9Huv2NzfXbM2bX66JTmNU2h0CByiB4i0EMEIR+ya0ONSXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030165
X-Proofpoint-GUID: 0sLC0NNNmPn8gAthqaOjsS7y9KAfyFFL
X-Proofpoint-ORIG-GUID: 0sLC0NNNmPn8gAthqaOjsS7y9KAfyFFL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change alloc_surplus_huge_page() to alloc_surplus_hugetlb_folio() and
update its callers.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8dffb77d3510..0b8bab52bc7e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2237,8 +2237,8 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 /*
  * Allocates a fresh surplus page from the page allocator.
  */
-static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
-						int nid, nodemask_t *nmask)
+static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
+				gfp_t gfp_mask,	int nid, nodemask_t *nmask)
 {
 	struct folio *folio = NULL;
 
@@ -2275,7 +2275,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 out_unlock:
 	spin_unlock_irq(&hugetlb_lock);
 
-	return &folio->page;
+	return folio;
 }
 
 static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
@@ -2308,7 +2308,7 @@ static
 struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 		struct vm_area_struct *vma, unsigned long addr)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask = htlb_alloc_mask(h);
 	int nid;
@@ -2319,16 +2319,16 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 		gfp_t gfp = gfp_mask | __GFP_NOWARN;
 
 		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
-		page = alloc_surplus_huge_page(h, gfp, nid, nodemask);
+		folio = alloc_surplus_hugetlb_folio(h, gfp, nid, nodemask);
 
 		/* Fallback to all nodes if page==NULL */
 		nodemask = NULL;
 	}
 
-	if (!page)
-		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
+	if (!folio)
+		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask);
 	mpol_cond_put(mpol);
-	return page;
+	return &folio->page;
 }
 
 /* page migration callback function */
@@ -2377,6 +2377,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	__must_hold(&hugetlb_lock)
 {
 	LIST_HEAD(surplus_list);
+	struct folio *folio;
 	struct page *page, *tmp;
 	int ret;
 	long i;
@@ -2396,13 +2397,13 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 retry:
 	spin_unlock_irq(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
-		page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
+		folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
 				NUMA_NO_NODE, NULL);
-		if (!page) {
+		if (!folio) {
 			alloc_ok = false;
 			break;
 		}
-		list_add(&page->lru, &surplus_list);
+		list_add(&folio->lru, &surplus_list);
 		cond_resched();
 	}
 	allocated += i;
@@ -3355,7 +3356,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * First take pages out of surplus state.  Then make up the
 	 * remaining difference by allocating fresh huge pages.
 	 *
-	 * We might race with alloc_surplus_huge_page() here and be unable
+	 * We might race with alloc_surplus_hugetlb_folio() here and be unable
 	 * to convert a surplus huge page to a normal huge page. That is
 	 * not critical, though, it just means the overall size of the
 	 * pool might be one hugepage larger than it needs to be, but
@@ -3398,7 +3399,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * By placing pages into the surplus state independent of the
 	 * overcommit value, we are allowing the surplus pool size to
 	 * exceed overcommit. There are few sane options here. Since
-	 * alloc_surplus_huge_page() is checking the global counter,
+	 * alloc_surplus_hugetlb_folio() is checking the global counter,
 	 * though, we'll note that we're not allowed to exceed surplus
 	 * and won't grow the pool anywhere else. Not until one of the
 	 * sysctls are changed, or the surplus pages go out of use.
-- 
2.39.0

