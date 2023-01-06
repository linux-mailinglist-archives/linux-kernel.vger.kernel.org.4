Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0286608FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjAFVzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjAFVzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:55:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585D07FED4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 13:55:14 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306KotAP025482;
        Fri, 6 Jan 2023 21:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=RpFFYzyO80UMpUfGKtMWiJz2MeJ8Z1Oy9LNDUb4rOQk=;
 b=hL/P8yubvYNPiHEzs4G5c+64A+HgQMUEkBcBLNVqHKKuW1ub0NGKFM6x0t+9Ufg0bddk
 8ZDWDzJicw7Rpe1tywrsGpKi3ZQiLeI60WZHXc18HKalA+3FNMUekFjDGXIyjAP94Um7
 8l1g65n625VmGNapRw8Y7GGu6x0yCsftX2Lu/WvWnb4kwHbhOF8bvhG/Y4U03hw7VtI2
 N9pr0oKIaYuBP63rHzRsGd6TvwSz5OMlWwU99Hv2hQbNNdacVyE01ZJAVCjMEn3Ujbf1
 CswAloakwZPYKLCxRdI8Si/ANBeAu2S4cQfGsQFQ4HPobe1WEan6OdLcruRTJe3a4kqc Eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp146dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 21:54:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 306K3sO8023314;
        Fri, 6 Jan 2023 21:54:49 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkgq3pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 21:54:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIZVxGXUXKtSXsPItrDIi1csxKgQiUyK5YoQ1FSCIUjYeJbJAgOAY0NGi1t6T8O1s1i/b+7Twuue8mq2vqHhlWsLzf9R9w8qSS8jqXvQL7jSNgYk/auByjuYB9ehZzg2fwb0fOTnf8sM3DhW+bYEWGPS3cUmraK/OF5/zjx046M+nCBOhpWZbSdq3z/leaWohFCUGQP8XhHf5PRXcqitV8jB7PAf7GdXY+dpfAGOEdvhacZpbQiIrM0uyPqshg0zKrZclOPG/OBGDixZDyut3i6XOjybjHmlEuJ9942lZLiaPJDYx9TL/oLUKwd4tJL4VOYUU4Xk9rp22jHOeAfZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpFFYzyO80UMpUfGKtMWiJz2MeJ8Z1Oy9LNDUb4rOQk=;
 b=ATnZAd/zgmiEclOAhus8za7o/56WSHqXCPZiu8ck8qbJo3ucZWB6luGxyhqifypCsjd1wObbDDs1dTWH4C1tgT8QOaNvQ3tkClEdUMm/0HrJ6v0sTG8nTaQYBwmPiXmHLkIgeQb+2xfh66Np2C3r27pSmrJ0EJ0MD6hOBYAlxwlQHPih6BptpH2dBel/Rvppry/sOVfcHHcftaJZn8DqyTAjtyxmtdeytmlafd9G7QzgQFXjoaCSzVuqm6ssyYXczVr7h3w+siDxOjdIM7ZOgv2SiftRo66V5Q9kc2XAEwxTTvY8OOxcBYyw5JR84IO/7Vh+JgaivDGq7ry/wv75cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpFFYzyO80UMpUfGKtMWiJz2MeJ8Z1Oy9LNDUb4rOQk=;
 b=zIY479obFwMrFlXChzdCfNHPkiCITPZEawBNkKrBSbgGn1NBfRrWfOLTDG+SXAQYE/nUPOKWNt36X2zsi3yb8ILJ7hUDrC5ig1gj4t71JbRUXiurl6xWnUc6yVtk68GI65dCiHd+gJHOWnUYlMDqZb0OoLFHx9ph+yRbP4d6UpI=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS0PR10MB6774.namprd10.prod.outlook.com (2603:10b6:8:13c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 21:54:42 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%9]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 21:54:42 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, sj@kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH mm-unstable] mm: introduce folio_is_pfmemalloc
Date:   Fri,  6 Jan 2023 15:52:51 -0600
Message-Id: <20230106215251.599222-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:2d::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS0PR10MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 80de60e2-7a7e-4eea-fcb3-08daf0309dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ulaq1uYTcVXAOasFh9rCUU7jE59Djna7lY0EwNgabMDwgyVQ1prhKDcEiaynX9pCO1pMWDj7wtkmHM3iYlrCt0I0xeZ6DT9Wa1G9SNBuVUEKPCX/WvmqbG3Du5RHaZZkXaVzxfOEcUlryDncBOz5O6sYK+TA7uGuOVk0DEDMM7qWyvax+T3DWfhnYCxkIJZ5zwbk5eXEN0BRN5uI+1LZIylPDjhR716NyS9LgPzHtD8aX1q2Zdu1s7BYGiGAc81d0bKbzCQJYiUpcZKBRI0YNWIGgV3ls+w/fnyZq6+OXgAhmRh1lP741jdQ5jgZOwuHJNTZ2fDmAKMGOvRlaq2O/1lgx/TFiIZhDQHQxe9c3Xb0vs64e2ldxpzsuNHNvI+5v1KGSGmNXgX0Xvcb1GPGwNYjTG/f5PweIETNr7ZoKg/zwGaL0l4MyK7QAXMygSnATcgEq0QKBrBxVtktK/8WdzsYIUNEELthOId+2fHWYQBRk7bKyrZ8vzNmdOTtaaVPf1O/UK2kzmUrd/pLCUWawV3vsC1q1KR8DAHIxgSdjsil+fmdtcIJPnLwCKpXI3QvGiCSP68TOcaHxNO9zRFQz28VLV22gTa0NGIyRFcqQ7UjrfH99UzuckBrWGbSCYQd/cK8D/l1rTM36JLor1/RAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(36756003)(5660300002)(41300700001)(38100700002)(44832011)(8936002)(83380400001)(86362001)(66946007)(6486002)(54906003)(66556008)(2906002)(478600001)(6666004)(8676002)(1076003)(66476007)(186003)(6512007)(2616005)(6506007)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ar044ZL56kcOA/nahvI3xZLBQMbVywqn1z3Kdey0RoxHF0XBkOV4XuoDdlar?=
 =?us-ascii?Q?Mq/zHLfRqz/bqf1Y0iugInWlBSJWYD/XJMpI3v8WEo4WQpPHWsQRi8ViwxXm?=
 =?us-ascii?Q?yD9NRIBANIIxSiyUmY7qLOlQGX0vconJnBFAzgXwTveoskr/M8MsoI88QyeL?=
 =?us-ascii?Q?JaHjVioj+Ypnzrh5b+USmhJZEZ6We7OAecRp2CjmpIQ4O6VF/RdcFhN0aSZ+?=
 =?us-ascii?Q?v/SMdRbBTzqc2z2HX/G2bVcErlTRh86kPeIlFlzaaFTMH3FjIi/hs9ejJnRp?=
 =?us-ascii?Q?mFiLTJXjNbur0c93WQZ1JjGUMfMbDInkcfZtkX7EwoMr7zAGOyDfwFbY+xRB?=
 =?us-ascii?Q?rSkbVQDR2d/tujKpB23LkqF7izgpyzFNpsq83gV3i/8e150Vpt7IV2YgZirR?=
 =?us-ascii?Q?LzeQiwhJshdjfGArIqvPIr6KcSdZy8OjW8TU0UQ3L92Ra16AtVCgRJ/pv180?=
 =?us-ascii?Q?7kjvO4ojQeUJSL2O8T0LCGKozizOWKKH3dTjIELGsYc3aZKc7e0dL2iDlyCh?=
 =?us-ascii?Q?W7RIKiXDNga+nRAaIBGNMgJLlVdqRP3OOTpENyzry3kbEohfgIqJ/N2vIhWx?=
 =?us-ascii?Q?PW5SBEzmbXkkGhdX4GjpCd9i0QXPEHb5+5oSJyqjYIXo4XOVJH+yn/JNJQ2x?=
 =?us-ascii?Q?PzikJSzhtz9WH63DVcgTXXkVJD6+w3fpLNH576aCKqMfKrK/AwkWCuXCE/kD?=
 =?us-ascii?Q?FaSWBxQ3IwETMqH1n+9rx7ikGZvqqJS24Rqbf1QCELrWFxPwAshjRyCvBSXc?=
 =?us-ascii?Q?WbARsroW0abhC+kvoYyKxWEss6UCDrk5YK+bGu1D0v0YZXOOfqQ8oarjGl/d?=
 =?us-ascii?Q?RkasC8QYBp4qTQgSC4n+vWueDfYQuZQXsk+NArRDwcyOZpM/HCcURvw+gt6s?=
 =?us-ascii?Q?N3i4XQbw33LhQHzGtKoeUQtO1S8bHF2UI8IanBZZq2dZERU2qJMCiu432BQ9?=
 =?us-ascii?Q?eAISDvTrFngWViK+rFo+5rBodt1dWtjdorBZtz4mcZpcLajUunGsHdAWolgZ?=
 =?us-ascii?Q?TyguiygTef8QHqA8/ynSCxmlx3UcoDBCSfPN35ghQbP0neci5G/aulnQhjGc?=
 =?us-ascii?Q?Y3pKBTzKJHpGg3K6Glr5OeRlrYP+Z4FgUwPzw6F9EZBIrenAnP14ADfkb65t?=
 =?us-ascii?Q?BlXKarc8RyQhLhk88n2nIWU/aKG0mRe224ziGompdQR1D9N1soBiz9epTS7s?=
 =?us-ascii?Q?dxElMyfkhr6fccV/952D/2LMLAZzVdy4VAOK4tMYGK6IGnrKTr5VxpN1CW39?=
 =?us-ascii?Q?ILQdrceUoFhGaSfwPRfj1ApLshJ/G9hfBAZ5sWtLzkA0sXFjA0ZpTVZA80t4?=
 =?us-ascii?Q?U4fKCU2zqp392Z7Emtx2UI9lY5eiKaUh/JRB9jGpgfViIKHZ7w8+ovS79m/N?=
 =?us-ascii?Q?pwgt4ybWOre4q7k5Xrrnlg3fclHUXG65Rth1uDSK2Uqy3t00v2MnpfS0YfZ9?=
 =?us-ascii?Q?NJtX40pAnTMPqJWCP/85ART+9gwqo2WNpUqiVZW9EAyfxzG4/1SH9kmfp4xC?=
 =?us-ascii?Q?lursiZgemWXdCw7dhHof3qKdlTXrtKeMy8n+jzFLwYqRZJPTQJSRE885jhY5?=
 =?us-ascii?Q?bCdvdZijZf99+YqDw5X5Xj72w3/kINy43/XOCU3ojgyH4Yf0IEOMp3cq0oru?=
 =?us-ascii?Q?O+Gh2Xbk11GEj8pPTbFUalg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E96rL+yRgTGJfNK8rjL/r66uXCPhY8lj1uZZ+4h1a/dnVJf7PYXY1qjYY+xA07M9lgnsaeYgAFeTRgpuD7/wLznmrnD4JaDirqTqsYIq8EcOQcSvuoGW+bDeU/tBZCCOaRBbukRFo+sL1JfcuJ1LwE+UBvyhQ6W4r35gJ9P3d5iWiW2WXYicQqCgffg6BTlmP9m7L8F7HCRbvHVoTuK5gnCZ1BEO4SLlEPukAHHIRZmNEFhgsa47h0S39u1D8A3Hybot5TElPUvlYw+2oGaWOP1ViWrIEbTusr5bO/8Rjg6kGJ3esGfvHuZTD4RppmvD9s1ntVFtPJIS2/2/v6dcVAcT1mEXY1BpIKqferPOJpgKdQWm5BJ3UYLXK6gLWTlsWYLal4nzyPRm+eZp3D5n9hzp3MlE+6X1w68WOV/pquP/Olf5Hc1cSS1/uKx6CIbdpmpao4mY7eYkqNU+rOVrnc2ScVZ8DGk4Z6b47YJFXZxcdpdVm6UJbQqucDflu6eVpO3pmTPOekrEXMFcsFeUGA9RfXWNVJAcegnaE45aPJ7gDpp3rpLUDjXVuTnoT2bqHoSoKwruIGytI41RmVA2HdfYhrsHGE9IiXwc9XJqF0BaKu+LkaCBdKnrV9Rk46/eoHae43X1h7JoRKTKU/YM93W0XmSrNBCtw0VHojFMoQ9nf4M2nwf1ZcK/JQTGhis53nebzDYMbExqaT5cqRz15GIGPcBA+hzYPNHlp6d2+MDiqjK+IVxoIzlkZDrzfch7mWHDeSb0Fm7R+uC7vfTLt+bXH4krlU39F3xY52ifgY2IP2xTD/0YKh2+/20a6vK1EbEiBl0AqemUn860v8yBLedApl2sBZ6mYULucoNglB0yUxy0ZRvHnD0Y/e5XY9Jovj7OAwn7yolx9x04uYjjqeRRugCHdtlFLnjp4jc8i+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80de60e2-7a7e-4eea-fcb3-08daf0309dbc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 21:54:42.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyTUUpsUNEAGxwPG7Dpd96LKgd58GX8uF0/g7XZ8lyCgrIAPvs6Oa8Nh191vTabEJxXvtqTP+shmYjhcdNcIMEQZzJg2D75xThzEsiNHe4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060170
X-Proofpoint-GUID: 7zcQ9muLaGLmFqbrE0Y4uC3TjfDZRPDu
X-Proofpoint-ORIG-GUID: 7zcQ9muLaGLmFqbrE0Y4uC3TjfDZRPDu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a folio equivalent for page_is_pfmemalloc. This removes two instances
of page_is_pfmemalloc(folio_page(folio, 0)) so the folio can be used
directly.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/mm.h | 15 +++++++++++++++
 mm/slab.c          |  2 +-
 mm/slub.c          |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c37f9330f14e..79d5a0cbf4c3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1906,6 +1906,21 @@ static inline bool page_is_pfmemalloc(const struct page *page)
 	return (uintptr_t)page->lru.next & BIT(1);
 }
 
+/*
+ * Return true only if the folio has been allocated with
+ * ALLOC_NO_WATERMARKS and the low watermark was not
+ * met implying that the system is under some pressure.
+ */
+static inline bool folio_is_pfmemalloc(const struct folio *folio)
+{
+	/*
+	 * lru.next has bit 1 set if the page is allocated from the
+	 * pfmemalloc reserves.  Callers may simply overwrite it if
+	 * they do not need to preserve that information.
+	 */
+	return (uintptr_t)folio->lru.next & BIT(1);
+}
+
 /*
  * Only to be called by the page allocator on a freshly allocated
  * page.
diff --git a/mm/slab.c b/mm/slab.c
index 7a269db050ee..01291ecbc0d8 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1373,7 +1373,7 @@ static struct slab *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
 	/* Make the flag visible before any changes to folio->mapping */
 	smp_wmb();
 	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
-	if (sk_memalloc_socks() && page_is_pfmemalloc(folio_page(folio, 0)))
+	if (sk_memalloc_socks() && folio_is_pfmemalloc(folio))
 		slab_set_pfmemalloc(slab);
 
 	return slab;
diff --git a/mm/slub.c b/mm/slub.c
index 13459c69095a..0cbe6eff23fa 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1859,7 +1859,7 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 	__folio_set_slab(folio);
 	/* Make the flag visible before any changes to folio->mapping */
 	smp_wmb();
-	if (page_is_pfmemalloc(folio_page(folio, 0)))
+	if (folio_is_pfmemalloc(folio))
 		slab_set_pfmemalloc(slab);
 
 	return slab;
-- 
2.39.0

