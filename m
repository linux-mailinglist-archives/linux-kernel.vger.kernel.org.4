Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A7365C746
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbjACTRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbjACTPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:15:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B1A140E3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:14:32 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303JDs4u001004;
        Tue, 3 Jan 2023 19:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=nmxhlfpLfRSO3dUF47ZIWemR1CIptCOWAJSWro+sA0A=;
 b=PQHTlecYd0kLfXFq7fiD4ej3/8kSbxPE30/yfTL3Js/O4MAClv8CeHsSNaJKCWrTTRWe
 z4jUfTWgJDTF6P94+PCyiQy4Q7OQuNUehGR/chzVXDGHHuupqEbtHyLS31YsuaydfjFV
 Uk/tgY0gdqkz0nPY6ZbaOCXkYGxd0Bw1NpqED3vWquCwBbA+xmrfrl8Q4qQqUrxV/pT6
 VLPoz8/KNuQmM5TXn865CdvdvsF1OXuaFddOnOtklqjeE4ngUl9iV18i735QXkJh3nTK
 JDsLEVWF3GtU87WUSML+5i2iQuXe9Be7xfB4TXzKWqb7Voez8L7WKGAKpFtRB3zM4OK9 nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgqmxha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303IOtmP012258;
        Tue, 3 Jan 2023 19:13:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbh58pxg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxqT1lKBT22Q72IWVKokcpCL3f+vuZhzcHzLekcOfaGZX3vv2J1xw0ddFrkcrsjpe9x7jMuegVBVpzaXLbGBTvqI/mm4cz/XnHhTx8MHIzQAWftFgleoYfdkQazWdrnXBvsnAsDVzEuF8G/h78mqKS+gog5dEZbAc5BONEchOCEGd7IMDE3cR1A4/g6Gg7rO9G3ScszzF9cS3EbRBgTNemr2r0m8l2KlXjYYkW3bPJDl3NWdPjF9eRZHN4kRqy37bhH6NBmcIOs1kWJAwzEqK930chQvuk1cERfmrCRO4lgWhv4yZo6f8P/IDZ8mXU3R1zXcVFihdauKTihoCeSJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmxhlfpLfRSO3dUF47ZIWemR1CIptCOWAJSWro+sA0A=;
 b=RbX2LNkW9InXmoa2GzZNLKBRvUl0Zp569+gj/xFK2dRbqay7lMfccaYN0j8sgzwImxVFvm4S7frpa+t2foNSKPZGirbtJkR+oy4NoCUXHT1SQ5GWAp9ofl8yBv6lW4YPVmo1IXfyPCo9th9vLmOJhqjAfsl6Ry8HKj/mQYo/7o3uKtjePZU07i6lQiJY0PXqzokK9CMhOfGarY6d8tzpeUgqfzQeo8eup9l85YuDYlCcuB9D1Xahe2Mc/4Tkd9kl03OykM6mFg8ZKv55vGqFRySRPImDR66QlyO2To4dS069/s65pYTGYTcWDxsT/F97FnwSgJCPDOitV+X4kCJd2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmxhlfpLfRSO3dUF47ZIWemR1CIptCOWAJSWro+sA0A=;
 b=Cwzq+vAj2/HYqXlobLJFTlshulpIHtX03OCxB4VRUOdX1FaM0yH5WYcuVhmVcshhe3H7dJ3oe/gZoycibxgrpRV7E/5QaEKhdy7UHYlLse9kO5Pz66y/xWtHaB79AB6MwOCLpczs7tWmRp9Vrd5gAliU13Nr2dBE5YTrwf5rESw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7332.namprd10.prod.outlook.com (2603:10b6:610:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:13:48 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:13:48 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        jhubbard@nvidia.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 2/8] mm/hugetlb: convert __update_and_free_page() to folios
Date:   Tue,  3 Jan 2023 13:13:34 -0600
Message-Id: <20230103191340.116536-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0438.namprd03.prod.outlook.com
 (2603:10b6:610:10e::14) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1f64b9-a329-469d-6617-08daedbea417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVDBZ0anCoB+65Yo0lIELu9eMwV5Om3ZQrImRGYsJ13kCktSz6zpOSICGrSTgVx/Rt8rPP3/0Jma4Kq2t+8r5diugxdmS/eXdN72s6F3W7NXGueTdrrUJshuCZUKV31GzC6n1h2/7sqtNSQIXRqyQjW5kyIDKcd0pjmREFvJXcOwQz52+jl42B8jzSTsxgeC9Pvnq23FX6y7+7sVaCzZv0zFVaynbyF+PQ4r+PY244VlWRiJq4t+MdrTDQGZq6SF4ZCNBuFopLwNRwwy36C2z/Zw8yGDKai2DJdeigQ2N6R4A0Vbzx8YRDOrdhIT/bQ8HFr4Wc+E6BjT9uSaeTxqK9s4MDoCQHJMJOjNNic4e/RNEkJYIyUq4OQukVML/lLORbYiJrdS8UwNKHsZ8fMQfypl7NSD8lZ4jZl+BGA0JsistiGhrP7PworNnUOamU5XTO0xgkvaPp6ZBwWe9DVunddkDtrkYIi+psVxRVQporWCgXiBZuOtzDx+6UQwCum/Zj4nc6XEi2p073d3SGzFFFQBv6DS3DgTyqNG1fbwfEgY+Gx2akAyQnEbLM+6yn1J5pLSVgGWjJN/b8Ass9OdLp/WwIkU1PC6KtKrQ1yFEp9B6umpMHvb/41LCM0HAELTDhLscgyvwurgJmgqMTUp7zmf6cKGdWA/tyvvoJsiaFL0wPXkHDcsdd8RrHHS1ybF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(5660300002)(2906002)(44832011)(8936002)(8676002)(4326008)(41300700001)(478600001)(316002)(66476007)(66946007)(66556008)(6486002)(107886003)(26005)(6512007)(6506007)(6666004)(83380400001)(1076003)(186003)(38100700002)(2616005)(86362001)(36756003)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BelMtur2pDte7RjtycTYDuzsupD5vblRv/fBfszIDXPHGyokYWTXZUNmIf8P?=
 =?us-ascii?Q?UnysZlR8OISR79qJnRbYt5ZvQpNwtXCYUlfc/kD4bLIhjoGZIM0GzQUIrZ7f?=
 =?us-ascii?Q?5D5G3IuuFEmGXPZEoHjwEQRnLXlN4+2Mb5U757DNQ+j6qSBo1N4/maM5h8ln?=
 =?us-ascii?Q?FrhbAbIo62GbfcFuSTOshnSRfUOu2JR5UAzGMG9qFvtqpUrg6oubUIVQBDtS?=
 =?us-ascii?Q?eHAAogXlFn1asPnhphG36TJYN+cstGFwYHh9mdYO350mNvxzY3NZW3xM26cm?=
 =?us-ascii?Q?r2ac8c/XqmO99Ek+owNLMjZDYCIC6ubmwjL1c9zaL07RdNGnUwjHRGd55dsO?=
 =?us-ascii?Q?GJ3JoGrDpd8iRO7DnSikgWvgUX0zXtMMfPXk+AXx5rA9/0hXoN/Q2jB6JsEo?=
 =?us-ascii?Q?yNaF4viWI4yXbSvC+txaxJeikGi/+0jX6e+wbJ4jDoq2nP+rEhT/Iadc61qh?=
 =?us-ascii?Q?+WniGlWYRXXXU0/p61y8OtfaXWift+n/Nsjtu6jWEzLUVHXDuJ3IMJvNXAZu?=
 =?us-ascii?Q?qpMY8aOw3YJfW3IRJygmNWPeMRBC35lt8UsR/nNHkf8CL9xeUcNxtNRA5fy1?=
 =?us-ascii?Q?vPu+3jdcVsx5bWDa8DxAebmrrRVHycvdp10/gObsp6OkUKutZ/4geg6eWaNw?=
 =?us-ascii?Q?ZnRmUBW5R1pBa1nc5oW6pugt6JW4oRnrjYoLTfkhIAnFHpVecHtIPnQhjJVi?=
 =?us-ascii?Q?xuq+Gx1c7PLunB36Dnsp94iPB5cnwpjfFfhNEuf90xJTB06vXB6fwifPxlS6?=
 =?us-ascii?Q?461a+oydAXMm1yx9ZdNrh2jPvoYMiC4R3W3yYGKtf59DgqVMFbgB+N3/LaFu?=
 =?us-ascii?Q?Zq0UolD1b1iO5O2wYMtLNzlRuMWH+1OQiDGRo1nlE6wryt1D7gpUIC+XujFV?=
 =?us-ascii?Q?4WEZ/OWhygkxqz5xe/yIcWcx63KydeDkI2ISslxZjvcH2kJt+bAG8My8364r?=
 =?us-ascii?Q?qP4/3OtFrGJ50Knpzu1WvqgLsBHjviriorWIp3yLeDIpMpnQzCsLVrDNX+7y?=
 =?us-ascii?Q?kqAE2uFAZns+Gmcmd28C8YsJIByY4VMM0ZXZaNekGwqEd/euRUBGahIGD7ZP?=
 =?us-ascii?Q?JzPzhyLNal+tcCp5wl12QEeVabvYaxvJ8bYxqQMekTXnrsAI8RosBSzOjcxd?=
 =?us-ascii?Q?263gaOqvJLG69PeGs6LF5zckClTBNf8F8MRhLMV8kzSJO+tbONx3dcYrN9I1?=
 =?us-ascii?Q?QxVTh9jZOJkm80p/J4XZA5GHifTJ8Z4eY92by3EXPbPoWlBJQAF4UX03m7Be?=
 =?us-ascii?Q?cXxSbwvjUyRkAE20y1BeS0PNV9dpl7lP3+piESYcZ96wku79iJiRj9lC4v7o?=
 =?us-ascii?Q?eE0p2ANZCIUx5yK/s6nnEAHt5EBYFHIPOrmZBOKS/C0k+DhpOL9xxtT5jPr2?=
 =?us-ascii?Q?ED1ME25FhbOUAycebiGFdOqNw57A26FratW3rGOJ8uVa0o9gHmnCEWJ7RRxz?=
 =?us-ascii?Q?Q1xlo/oq1OWlKGqsceYNzV00JG06OE8FpteoOJfiT3Bh4iYJIj19fkxgcw5T?=
 =?us-ascii?Q?a2unjsGVHE0wG8M9Ep4vLr5CNOCVSMUXBjGOMEcwW9LaPzfPlxu0yKioVBu7?=
 =?us-ascii?Q?W4N/iHxoVnUdnWTDj1pYIuTF+8ZLIX55WoCuRSrd60T0CrXQxKdAJN9WUExS?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?RZIv6I6CKCq1IF6kMtQmklXOPAkcHhLwDR8wFtnz8PJZPaXUDtMrhQbqcuw4?=
 =?us-ascii?Q?Rf2kjiPmDg0pf3JbSl0QaiGdCNaefMM0W+xmHUJWDxNMF2QeOHn83kvICvQg?=
 =?us-ascii?Q?2VN1FiS4pb/TFnzGqbNg8KvHmeFP0p/zVxujNC8gINUFz4+uiiPpT7DNkH31?=
 =?us-ascii?Q?SdlPa1QAnG088/EU7aLBkI2/KK2GeIfOmgaWOzc4q1U9xneZrri1moQZsQbO?=
 =?us-ascii?Q?mErb7su0NQsFVRT6xuXaAWOzrhwVN79QtOc0JPjztRgQtfPt6XeK4L0cgIdu?=
 =?us-ascii?Q?OuNQsLrrbQh3LLuvGljIR9/pGtZoP/Dhn0UiqDsnfZmZeWRtNYDB6m3n1lBO?=
 =?us-ascii?Q?4iZ65zF2bTqXDUtLlndVpmMVvm0SLl3W9EeGhrmyD+TV7V0fO4fyoOktax7+?=
 =?us-ascii?Q?M+dSD2ur8FANImUyP7ol+npl4oIOdQtPQ3qlBcr4yPagSUkMGVBlhKVMyOBO?=
 =?us-ascii?Q?hlmq3HK459ux0jKr/WWbPTs+njLg+MtKXp9YqAxrC1SgVoHFwTys4kBWMWxq?=
 =?us-ascii?Q?9DnKndKXyJUrScVR8UrbsNAec6xc2cbqf+/AM7cLjTtL8Fu8aZjfdIFm0cUN?=
 =?us-ascii?Q?/JwKll+0ATtNAJKHGzFsbHYLloCRWTdAK7WuoMvaUnxsDk8uGZ2g4b3yr5Rv?=
 =?us-ascii?Q?bKzx437OFKtSi7i+K1hTpib55ol9Jwbrab2W7bQpgt5XTyJsD5hfFoGpt+E/?=
 =?us-ascii?Q?S+Z+/ianrCzy6KgSo3JV3wobmzXi+iqY1/5J3e54aKbwqOeUwTF5uxH9IN5W?=
 =?us-ascii?Q?t8lABnfoli3lOY4Zb3TcCgsHP2ZXHBkWYBzasyf8YhZOeTgfgR58NToJqhry?=
 =?us-ascii?Q?kZ8yB81rKM4q76IZDVZIE98I6TwyBZECg3TLSh7U02hvZJqTQe5SWp/XYlzt?=
 =?us-ascii?Q?M/Xe+AOIj1h0+MeUitA501UCibuM/Cd8sobOkZ0H6vf3cELlK1P3OHGPz/LZ?=
 =?us-ascii?Q?0r8Gt2x2/A/5yTZe95y/YSlRfDACfOLi1bkWVA4ywHo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1f64b9-a329-469d-6617-08daedbea417
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:13:48.0943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wjLtPCbodH2K9Gp6/SUBdGMoaZ+xbVhI+CnxIXRE4c/tsr0k3Wej3d4gnGpznGHZEPoavkzg6wxZ8ABb8dV6LW3beJy1k9I2RzN4nTB+5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030165
X-Proofpoint-GUID: yxgObO0oQ9E6IEi_IE11GawBj19kW2Cu
X-Proofpoint-ORIG-GUID: yxgObO0oQ9E6IEi_IE11GawBj19kW2Cu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change __update_and_free_page() to __update_and_free_hugetlb_folio() by
changing its callers to pass in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 90c6f0402c7b..b06ec8d60794 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1556,10 +1556,10 @@ static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 	enqueue_hugetlb_folio(h, folio);
 }
 
-static void __update_and_free_page(struct hstate *h, struct page *page)
+static void __update_and_free_hugetlb_folio(struct hstate *h,
+						struct folio *folio)
 {
 	int i;
-	struct folio *folio = page_folio(page);
 	struct page *subpage;
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
@@ -1572,7 +1572,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return;
 
-	if (hugetlb_vmemmap_restore(h, page)) {
+	if (hugetlb_vmemmap_restore(h, &folio->page)) {
 		spin_lock_irq(&hugetlb_lock);
 		/*
 		 * If we cannot allocate vmemmap pages, just refuse to free the
@@ -1608,7 +1608,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		destroy_compound_gigantic_folio(folio, huge_page_order(h));
 		free_gigantic_folio(folio, huge_page_order(h));
 	} else {
-		__free_pages(page, huge_page_order(h));
+		__free_pages(&folio->page, huge_page_order(h));
 	}
 }
 
@@ -1648,7 +1648,7 @@ static void free_hpage_workfn(struct work_struct *work)
 		 */
 		h = size_to_hstate(page_size(page));
 
-		__update_and_free_page(h, page);
+		__update_and_free_hugetlb_folio(h, page_folio(page));
 
 		cond_resched();
 	}
@@ -1665,7 +1665,7 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 				 bool atomic)
 {
 	if (!folio_test_hugetlb_vmemmap_optimized(folio) || !atomic) {
-		__update_and_free_page(h, &folio->page);
+		__update_and_free_hugetlb_folio(h, folio);
 		return;
 	}
 
-- 
2.39.0

