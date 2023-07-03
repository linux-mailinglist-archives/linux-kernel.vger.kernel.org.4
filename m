Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABFD745531
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGCF7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjGCF7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:59:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E83BC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:59:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 362Kmxhr017325;
        Mon, 3 Jul 2023 05:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=mWjQpZo2a6ZCry9xshQ+oF9KkRkC5CiVlfyKFHFCjOo=;
 b=jliCc39LISMvdZaP8bIYwVGCPZCXISSwiwHGfHRhSbCb2+fZo+I7F/yq82ZPrJvMBLJG
 l1U26Q9NmAv+KvT0jKMZw6cEhUIM031Jv4iwXFrqfuXKRHVZRPsGfpUGUzKtiCjGV7lq
 cIqzpOE5f2WvjLhuxjU3Htif5O77136PrHImnN5fM6Syft+FwXozjjhUEKZkpFhTTMuN
 GTeXH1KK+yU0mrNK7RAqEdpPeug9qg3+Tq8GcWNFPaLI0aXrHSE8Ii351TvRFpoX9tCc
 Fe7vRcDc2CCUFj0XMB9cuxRdArhCyUfEjwqZGX0NzPudZ58zxGSa2Mje7onUW0H2h1jC 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjbrt9tqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 05:59:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36341NvC038627;
        Mon, 3 Jul 2023 05:59:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak2kv9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 05:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MH3FlEQ67bWA18PMv1MRGSwxAcnaijJ4iafaTpRZm7gAmTXAf0rLFMhOJV3U8RhOkGGn6tAlIr3UdR0hvBbNgG8N5JrZcv8rVOJm+Xx842mOwqnhYWAjMSB0J6YbMgJ2+vNo1k5YYI6tlw+bAhpQPFFgNIVxQylIJArPBvLEzdYqeeWPssEHwHTGfGvUDpf2pxSrRVAPny9MfM0DDcq6PsCs8M1/67NkRPU7AQLxajuRTEg4KkUrI0VrDs66yOtHNUCkL/+Rg4dreL/PTKvxz9FmdXFUM1arhiIfS2uGhglbZ8qQVU9LrhBhHzspBg/NyUyjfY9PxJLMIwKZDr+YMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWjQpZo2a6ZCry9xshQ+oF9KkRkC5CiVlfyKFHFCjOo=;
 b=D1CIIZldfpm7nXyr02FbZYL8BmDaT+nODbqHxZmlozGAZCDClm/zMm3ML20BOfjX08eAjQImHN0p1XkQ+A2oaLocbVYUpQoXMRupG0oN8MkyUzDq8JBO3aZtdO4tU4uEVbQ5P60u4s7wumvIUKfk39ojkbu4/gEOT558SzfSsVuIsbf3fMu6eos9s5MlbjXwXAhr7kOSNllXXY6FOSZq0v4oK/NT7803xkgooiAoyMWF/c08fTP2CeU5JMW9IPAkUUX8WlmE/IvYsspQFAWyi/XyH2BpbqzX3mxRYVmhXyiJ017++Eak6EdFR6Pp1ZLORplodGtbUu3pkk7adtbNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWjQpZo2a6ZCry9xshQ+oF9KkRkC5CiVlfyKFHFCjOo=;
 b=nrGe8yxgYcjS6jdyXaA3OwdxZ68eRvBX2f/IwD+E/df420KqgJjrWAS10ZXWoQwcdZkx83VfP7/wby3GHsoc12FQbXx+nfYh4+xz2BLd66tLz01EaTJaidFV2+GEdBPq7+J8zn5OohmBs0RGTfaOJSJp6wq3F6HFnAd1+hppIgc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB5548.namprd10.prod.outlook.com (2603:10b6:510:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 05:59:07 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 05:59:06 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 4/4] mm/memory: convert do_read_fault() to use folios
Date:   Sun,  2 Jul 2023 22:58:50 -0700
Message-ID: <20230703055850.227169-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
References: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB5548:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba42725-885e-48b6-3d09-08db7b8a9cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQUoLkhhr5DsQDs5vLzMaGRONzdcH2qgy7q8gqoP05rg3r6Bb15RvXd1G45fqlBz2gKQ3SWCFd+JER9KpIlXjmkFJiYDvevBA7xWKaRbmOdRIf9HXIDj24Y5lMeeJ6Bv/e5md0zVH9dSsmdCcosGYjN9iYdui2PjZnlAybYYKW1nQyZMyiVxu1xGhdoXUEoZGAKPRXiO0Gir2PD4aV96KbT4Gdk9Z++P4sGXWQWDX4N+7N38hlEtrpcjk4S/HkUGMbdijmsTQNEtJgnvszRHPmFdikCRNayITy3cLddOXvtchSWV02vq4nQlh8gsCsdCtg8oZaRB39Zao6bOvIR4Z5TIZOY1BcRyOUlhecuXmm4HDGWdaFSJNiZsSW+2QkZ0//xCceH0hpdwkDpp0NApF2WC9hQOMgVFUlbNunbqengvcDc29j+k9AlockHFHKh91TOZLgb3oukkgdYKMRpEWNoljBVfNTzmCDqE6s5CV7Sd8Ov+cnwZg7bkAoNIOhawHuZqMABDhyomy+QzgV+FgAP+ql1tgZtnMgTq97ik10UerzeqKQnSxat/w9CETKLL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(2906002)(41300700001)(5660300002)(44832011)(8936002)(8676002)(4744005)(36756003)(86362001)(6486002)(478600001)(6666004)(107886003)(83380400001)(186003)(1076003)(6506007)(6512007)(2616005)(38100700002)(4326008)(66946007)(66476007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tNDugnlBGdz8PLbf3FF7c8UTx0EK7uotQcSoT6RgZNbH25zd6EtMhyDBGE32?=
 =?us-ascii?Q?uH7chw5Z7MYTZUbe6Yu2Pn0lLs/0EtNx8yJyegXw4nJTOenmgYCAYwGU74mj?=
 =?us-ascii?Q?tA6Bb/DvJCdx5o1xa7UGWiuhCGHnw4OpWrroVU0z/L4E3VmnCPDRaT0RoqRa?=
 =?us-ascii?Q?1nzSPsRBRpnn3Uu7r1NG3/7Merg9hLdHILh1CPcaz2ZWT42csPyfP47KBlag?=
 =?us-ascii?Q?cwx3pYj0ISh17hqnPsWuf/SjCRg1DKW9Wwa75hTp8/49Um6nZGZzeAQU2ov2?=
 =?us-ascii?Q?GtedrdkYkICReZieHmx8tpN3B1qA7ExKGzO1v5o6oRgBkdf1tUkmm8iUxamG?=
 =?us-ascii?Q?gEl6gIM0uDoBjCr40Br+UfSuLTkRqfixQyTS64uPkotl1GQWmvzV4Kl/o2a1?=
 =?us-ascii?Q?LxRa6XmC2aNXbQ1QCf//UM6XdgACpQSCcT7wzJnphnIHdeOioy1iXbrB6g8B?=
 =?us-ascii?Q?BskE1B4CFyHXi86tDMeVsO+etkF2tSIjDhKcrnJcZ04YEIpRkt/f+UjNtIqN?=
 =?us-ascii?Q?wxyZW74+g7uxeIBFd4V6hVJeyvocX9cKGFnY4q08xNbNrqjJHnrlI2HuM2pJ?=
 =?us-ascii?Q?DjmopBMa1rkkCMX8TRXFHRCull+TdqVtwvQd5EEKp0T+ZXOXQinjyJX+Ytt0?=
 =?us-ascii?Q?TIbzqBvq+GuWdkJkydEHo0Xb7B5dnm8OAUIrKtkDoa44UlVIgsBIKvxoLzhS?=
 =?us-ascii?Q?E0y0ff1gb63bu9Q6A9n18AfJgAsGeV4ONCHIArMMzVUfv6+bBtYzOW1MZH0Q?=
 =?us-ascii?Q?x36245aJmLNe5IkjGodpNT9RLvTtpgXkgiuuk2t3i1XPm/njD77+lwWJi1T/?=
 =?us-ascii?Q?EoaaT9vAFMzo2+0vmO0yFJh3t3jkQcaUNEj8pIw9idzfteCPYHlK8i4BcTog?=
 =?us-ascii?Q?cm8eKndjVQbj6l8ejA7z++PEuHPZ6iHrYCpJenrPJ64oRM6yL87DgO/K3MOj?=
 =?us-ascii?Q?u+agCNEV2VA9pyV94k4bf6z+94Y17jknTCIGEUJ3BmKf8SuO3QFMEBq508a4?=
 =?us-ascii?Q?uJJe3Cv5v4D+ohQ4rQP53lijHfRCRW7kwxW/Lrebh4h7aPekIY2VUumRoY3o?=
 =?us-ascii?Q?p4aOuVyWhVHTQ4Fb6kuLpvmRy5RYyvCDzExjMepHc4I3bViRMfsM5hy/Zm4E?=
 =?us-ascii?Q?ZtaBUUQvXYWY5IU030Be2SH67Sz15k0xztZElYs6zNJuGwdqEDoofhYGzpiO?=
 =?us-ascii?Q?Qb2p0ZFq2KZVDuGNbVR7Slbs5DJuoLLsT1VIWi9/7DDr4QFJwPL80RwyiXVh?=
 =?us-ascii?Q?j+3um8cs6Wn7v/OkF9m3oSJBUBfHLca05pXmQ7uAyjkJc/RTTO3hcoAuiW6U?=
 =?us-ascii?Q?A8wIgkZD7PDG7+mORe7XUanN3Nf3kBAn5EAVBpq6bsjCoLh+Qb5i0/bKDlvp?=
 =?us-ascii?Q?3CpRlqlHqijI/sEVCYDvaeprs9c36ATfI/+VQH2jv0lyiorgsTW3I4rGks6e?=
 =?us-ascii?Q?Xb+eRdj1T5skJfaQHRhpzXITRoMnF8bWkEb1GeaR5tKKuwpnkzAfVKA9hPRz?=
 =?us-ascii?Q?3jYz1oslwyNUrm5udErWxg0nuKec+HpyLpPsUbgywSNQ1n6NO2Wa9fI04zDL?=
 =?us-ascii?Q?lCU1OvdbHdmcIe6Su5mTLzU4vrZCqrfTNc2AMtYue6AfE8Nqpb8cGC5VxlOC?=
 =?us-ascii?Q?v+RT65Q6PhABEOy2c+E+7WU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0tQ9Oo/ES+ecW8Q2ofw9Ywh3qxeBHW0ia8ieBht05CbIL2Jqu797wQG/HzJP+Exen+cytMaaIBP2Jyk6py8oAcCinQAyD+nwQX9kBYkOvsZFVWb7CK/UKdBLFOinY/Ls+nKUPwYgWIqaLoR1Ofg+y3e/PZaTwyhADXziOSFNjQ6CS3zVKq9062cfyIax3tKxZ+3tnUAxrhwCABk/sI115GWyTC6iSLxDQVpCig58xnJOHXHbghVdzW69Zhwi80ofmvdBEoYzc+v/c8cEyMORMfzQfGl8IWiswh/okj0GX34qUDnmBGKm/UpXn5lftKd6WHS4sh3Go53hjfeS7UeC3CPpzNQwLPEDCg9ZdjWyGiwef8S/9zr0/aoBbhdRlsQbivo5UaHIurEcg7P08g86IVgStPwJGIDQXspg+ZSNUTgb+1IxvKwp9uXItFPFgg/tB2Qa7CkTAMI1uK0jvr1bQHDwEMHhFZjRvn0VzF8aghIote3+LeRDZk/0HCUyZ5XLn9c6GcugBD9/FlgR1Srrxfp1zBbqTEr+AqYL2aOTJVeYiWSXuPRPo2P/mqc/f4uKtTkH5SRXNuAGA/GFvsZGQ1t5BkIOpfLDDfX6v0+svG2I4MjFCuJCs3dKPXXLRsCT4spSDXTMqeiUN3PE9cWPVi1uEFPQsSkH4IaTGI91fEF2hxL6QeV/jjzU3WjKSkASCa9r3JJ6VJyssgtltEd+yL71oODhorWAgGbq+j0bFPgJoCHeCNLaF/ugO7TOXaea9GBsXEKfyj4AH3TtAVDNgF4CvAjF49kn1SSVn3INmfAFccYOSVAHeWtnBGEK2+Fat36lVa+ib4jZ+G4I2ttomeRfLfN44qjZ6e0AIm5BFZoPm6GT+lNY4hJsXMDXyCAY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba42725-885e-48b6-3d09-08db7b8a9cb8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 05:59:06.9136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Zf4r5vNmlvAiM9r5sTB8vGAot5HuNAjQPxQu6Q/lTKpApx0V4qa4ApOYNxY7ZGrGZ489XbjDCdpeXx4hUwWgJ8ub4Wy8rm7xV03FTYU0hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030056
X-Proofpoint-GUID: BNAt60cMlimAfNfcHa035vsMOJJClT3M
X-Proofpoint-ORIG-GUID: BNAt60cMlimAfNfcHa035vsMOJJClT3M
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saves one implicit call to compound_head()

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 33bf13431974c..b97c66df4adac 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4528,6 +4528,7 @@ static inline bool should_fault_around(struct vm_fault *vmf)
 static vm_fault_t do_read_fault(struct vm_fault *vmf)
 {
 	vm_fault_t ret = 0;
+	struct folio *folio = page_folio(vmf->page);
 
 	/*
 	 * Let's call ->map_pages() first and use ->fault() as fallback
@@ -4545,9 +4546,9 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 		return ret;
 
 	ret |= finish_fault(vmf);
-	unlock_page(vmf->page);
+	folio_unlock(folio);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
-		put_page(vmf->page);
+		folio_put(folio);
 	return ret;
 }
 
-- 
2.41.0

