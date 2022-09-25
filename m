Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B125E5E947F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiIYQx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiIYQxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:53:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D951B2C115;
        Sun, 25 Sep 2022 09:53:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28P9PiGh023254;
        Sun, 25 Sep 2022 16:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=BjH2GZPAAvfUqXLnihr4fO12kJMKuXIx9XrL+3P2jXw=;
 b=wkMzMr5Ea8Vu9kApqQRW+NdXMk6r9Pz91knaLzu5d+q62PQHW/7zIeEDdyVWIhlZ01iC
 /bTnE5OYTs7G92aW3S8ITWLyhepdySMOOoUwn8FgkHiFBeS4S0i/C2gA3hz93x79faFP
 1jwdxnQSARt4O4qY5loIcdXG0ntJRKDXIqpGej9nHqNlCmPiTm163Bww3oQUXDWmIoqu
 cp++aJJhm2HEf/dBRM80P24hKNfnoXWcEypPq4Fln88suySnVYm6QGYN1cJI5dFaz6R1
 ezUebgF9hETIsS40109kvzVGxS/LE4hUMLKRnK7kn3kPECiSbjYQQ0tggeMyUMGsbdAo xQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrw9xe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 16:53:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28PCIAWv019178;
        Sun, 25 Sep 2022 16:53:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvck6nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 16:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW68GU+tuSkjpj65AYMvtDcrxYCgVBIi0kn1U7oErHNHIDVtkNDZHy8V+9mTAarDa02bX/aPH/3ZeTbAUina8n4p6oXkQvGgNGSoB/84t5KSWAHf4QMaVd3ItDEoFbjQMwpo6Nug8OQO85oJ+n7+SLzbLJBSrLq7w8X+mSoAPJFS3dqFsXi6ggAHsDuMsLRFkRh4qAB+SUG1NBQmKS4w+TyoMXdfnwYNIZMocF7OcG9Q8b4/rPGsUZ6knx7houktRIg+oxeUV3XDNLndULLOj+3EIE32wrSXDdJMEhWNJyevwkmECqCFZTg05wIMrCcYGVNcZx1tvswXr/YTkca36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjH2GZPAAvfUqXLnihr4fO12kJMKuXIx9XrL+3P2jXw=;
 b=no2C3NQGrs5HQ0abX/GG/iOkJD0vQkXg+3WEIU3l9h1lo56TLz/8B4KkENu+ooRtAMDKYplMCrTcn70elNqg6zDOY+Lu2LriDzpif3jNtEdVr3T5hJswRwwWuntMqaf6FszNgUfoqc4NUy/jO3bUBYyC5Sm0EEiZSlbte8x3atkeOJyqmJU8dKykRnibmYe36P+k6Ovw5vHfwMCxKr0kxBRxH86K14qCIGhMroj0A+2YOwmQUM08q2G/QhfRpVzlylPKT7J+FJoMy/3/aLYOgVFcT5tXh1hmwB7V0/6EquLG5abgH98/Lw5VUX5vBmdGcyJAoac2+HBQpjRQuicBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjH2GZPAAvfUqXLnihr4fO12kJMKuXIx9XrL+3P2jXw=;
 b=J48q4YQJ8zUUr4jMihNzADQZq9pPIx9XsLnUWeOsY5sn3rMQT+QEt8MMxm0ItLZHIFSU8n+nWEFaWgJj+q/LZvOqS/WeCrVdrLpfdYSrxI1l2L0dWY8/PBQ1NBcZrpczsiM+ImuUJFxg5rkIDcmG3XdZY3zlN9cib0WDNXa2xqw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4413.namprd10.prod.outlook.com (2603:10b6:a03:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 16:53:15 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%5]) with mapi id 15.20.5654.020; Sun, 25 Sep 2022
 16:53:15 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_transport_fc: Adjust struct fc_nl_event flex
 array usage
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkr3s8ev.fsf@ca-mkp.ca.oracle.com>
References: <20220921205155.1451649-1-keescook@chromium.org>
Date:   Sun, 25 Sep 2022 12:53:13 -0400
In-Reply-To: <20220921205155.1451649-1-keescook@chromium.org> (Kees Cook's
        message of "Wed, 21 Sep 2022 13:51:55 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:806:6e::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 6885126a-2dd1-4b2b-84af-08da9f1670bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwlaZbwheroq7is+oS8Y5ASofWdKvwVVMHSTy1KK+KGbZDDS+iyPhTDf1m27LtUs8xm9/5P9u1EHknRjx6D2N3ihtkKUMZCkA5Jly+k6TiPCpWE/eUEtvFhW7HZnNLPdkzziWPDvndS224fLU3QYz96ZgzgVuu6ZFpsHJuVWvHZx0ESCWReLpeYylahX/L/8eFjb+6GG92dgqHVbDRIEUOS1o9YouxkBIcKGXAeaQJh7Zea9gQHOXSDZlQgTUq5oBt+Xpqn/Z5vVsCu9Rv9ZVN30H+rN7479yNSEclvLyxcDwXTJfkXd/1ZeZoUgjowVrNFh2uy0kCcoPtuZdfJZiLzutqH5/aD6/OSjzhotdhOYuM/bFQjB3+LMdKlaIwI2J5K4NTPxlOmq8tINYP6tqT0sjsNhe+3DbMOKdWmp1Ij1NiKz21lok6hXcT9BW8npIkXdTMkdyvNthVRDhtvXqmajF8z8E+hRD0Ka6CYLQvwqa0PUEeyDUzywCM8qYxfA2d3PfMyEfsu7uxGKB94NR2XpwgdTyDtdqxcXcZjYk5LRcAa1tuvTobJO2aPPQhVUjvGG1MgnqLLlhKn8sWy/PgAZzpPJEbVhJSmdzEm/PpCKRydtKwG1ydHLisnKmG9OJ7m64iOTC9qULHvp2ruCHE+C2m8NJ7U/TOh79qVX3tV6NOp1ySHrvi7XQeHHqz9W3lUK5cmEhJYPx0D5YrOOpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(54906003)(6916009)(2906002)(316002)(8936002)(5660300002)(41300700001)(86362001)(4744005)(66476007)(66946007)(66556008)(4326008)(8676002)(83380400001)(186003)(6486002)(36916002)(478600001)(26005)(6512007)(38100700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8QrEyzPqTEW/PM6vMup9fcL6tobCrZkBue4NQtyQ7w5vArPNRMrEhwXmS9hR?=
 =?us-ascii?Q?sQp4zSECoD5wYDMRMdG7o+H0QRzDmAAaLmTWFfA0eKRY1rSahjN+EHg+4aaD?=
 =?us-ascii?Q?3bmLWTKmunGlccjJIRMInrbiYMcLi+NNB+YZrUSP1lr7Il3uYw1uuKlXO1Rc?=
 =?us-ascii?Q?GlZVNuPtNBpLw6VORQXe7fSmsHwryQy9rMMev1THPQq/d/WoY2cIkGSQ6bpp?=
 =?us-ascii?Q?W+s5bAuJ6n3d10u2KSvEmEZItU5UFVW+aygc2LnKki9HF0/TxYhbTq0VpMyz?=
 =?us-ascii?Q?nAxfy4hAr8lQEL1xB3ZqHoxX4JiV/KkANiNr21x5y99oWH+5lW2vOIPNI271?=
 =?us-ascii?Q?ZZLvBaRjyhgEAyTKXrqWfyHk9+DPy25tno3yhVxJ4grvXPzrLklqfgkl7OEc?=
 =?us-ascii?Q?UX/Lga3SLrP8vjo8iq4SMBXAKduSj53vS6fOU+LMhfEXb4BW07KTKE+aabFJ?=
 =?us-ascii?Q?nBZj5+jFngsE6VkQkrKwNb5jtgCyNLL6PLlp9ELpBKnY/SmztQc01hQ/+Od/?=
 =?us-ascii?Q?2laiuof/T06SUDru70DyDu41wJkce+Bbd/vjt1DCYB1C7XLkI22tNkZ/wMfu?=
 =?us-ascii?Q?z9Os1KNsx9QpJ1ceytomxxfs5zcjo84CAWyzzXP/4KggYRdiehXZRtkYElUr?=
 =?us-ascii?Q?MIsLUpgsXj0SPQFwZTwPfrE361QcLST3t/0zqg3fgqRy6yAGSqRXI29kHDmz?=
 =?us-ascii?Q?EGyuip3+wnZHDj8PPIONHhe2JHQcSr5A6+m09oi2E9O2pNSzLwYQ54QdDJRU?=
 =?us-ascii?Q?uYdQviATeoiNDO3PotjsenCcxRyqxOa6nZR6lndBQ6DiclD1lYtUZUbqFM78?=
 =?us-ascii?Q?whG1G/xDAHtEsKcG2NjYKH5Qg8sUTO1uiFQvGp84JgKyLR7bu0+Wiwd/GtyW?=
 =?us-ascii?Q?Ku/OD+w0pOXx6hVLgL53sheWSnrVbkWh63hAAhwbidoXFmyU2o9sQEh7Ixpv?=
 =?us-ascii?Q?rVbXcxNrARaH+KPI6FWf3Pwaq1Z7pjprddGNQRe+5ZnEypHyJRw4F1uHeaQt?=
 =?us-ascii?Q?OdrIZqwUaViDrvCSdgkompxppi3P6HV0yphG1rIndxyZ+L/ysMxkThJqmdnA?=
 =?us-ascii?Q?Lsas4f9I/IavSPXCSPlo2QbyDhyIFObHkKjQR+aHA+QWbbBh91Oj1x7Nnnxc?=
 =?us-ascii?Q?ipheBTljtEtB12TnDyVqaflBrgeQsdRB0WxLdTExLxDRFmdcthxMPxENxM0n?=
 =?us-ascii?Q?AkmJMGIWle+cjDeDf7YhtSnI5DnsM6/omF+AQb+InqAl6aN3GvDtFas5VsRn?=
 =?us-ascii?Q?ZCCT8XL6L14V6qcpmS3O/SpoPgNnikSUs/Y210DOaQJfFvB0kP74mH7LyxUd?=
 =?us-ascii?Q?tcZ7wNagylwoN39+tERd9X7gZsJFAMKCvgYDT4nLV3aBKQG00JTqaz23UHTh?=
 =?us-ascii?Q?QpSndR1Cna0YYdUuC+5Xhg1dAlpDrQAstapmqQiV3ub+/mPphBmDjinUQh/4?=
 =?us-ascii?Q?+oeXP+p7wLg0cSm/GdEJU7MBexDtKtwLRgpsoo2LkLU1Qtuli9n4NYGfjFdQ?=
 =?us-ascii?Q?qwhYGF3ynG1ri390SS9VloPQgZfGm8OMMEHDCuBJYZlUOGl89eSU60d2A1X+?=
 =?us-ascii?Q?NSlgjWnF8Jmz1bK18DE2S1YRK96IXOsl5+UCnmJ2HnkBSwQtdOZRDZC2X2Nx?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6885126a-2dd1-4b2b-84af-08da9f1670bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 16:53:15.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEKQuySPftPZZY/W146kdMXBznQok6Z6dWNeLUmkjBmGQPjEdQz7Wlu1ia+aVkNOIzwuBKUAfZLtDb0OnhjXVac6rgD2joj3FJY2GkWek1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-25_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209250123
X-Proofpoint-ORIG-GUID: l9QB3zgQdcbOTjPsZwnbZC0bcj7iJTsc
X-Proofpoint-GUID: l9QB3zgQdcbOTjPsZwnbZC0bcj7iJTsc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> In order to help the compiler reason about the destination buffer in
> struct fc_nl_event, add a flexible array member for this purpose.
> However, since the header is UAPI, it must not change size or layout,
> so a union is used.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
