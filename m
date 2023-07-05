Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89437748E28
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjGETok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEToh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:44:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB231732
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:44:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365J9tk4026780;
        Wed, 5 Jul 2023 19:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kLaVdzqwzCfX6zaRLf4aFStQzSFEnzVid3+UmntP8l0=;
 b=x2MzM4JlbMZ3e0n44T8TgkSzrzLnEMmtVHITBFZ5UED/3IEf4pBfNZwFf/5aHvIUDORV
 0q+00paOgBRWo27Cvr2rzPQw9ziTDCJcCuD2qh81YmOUn0naLXjRnIZfBc/YtvJ/Q1Fo
 Yldm8Zysm2hBCBSsJbgb+1zpuJ18YKcqrqCj4Ela2GSl3ZQpWEtWgzTWZoRDmhZtQ0OE
 25yZpajLOajIr8XOZH7dG/ukEWYPGTJIYj/hK1F1vjh1N5vhnhl5ckVPZwiSSWX2VBaH
 7L0IdsG1d6yyiuvsdBrjkROmTPhawuYvyWvpH4V9ZQpPBp8FwVXSpDFxB9X6/mQ41Xld LA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpuf8rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 19:44:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365IlhXt025202;
        Wed, 5 Jul 2023 19:44:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak6hbcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 19:44:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWBoPySkGpZ8revh/mOSdm+RFBoO0gRWl8BYPv0lU1MG9kOrqGXzkFQ+9zNpQrBLCgc4THm5hlApxz+jyxoGJilE7U2MfwAEj166X/TMlNsFV3gAJamtfPbZQAxfoWYOd+TXHF+DIOvYthDmc09Lx68qtSbRdKW6ssvrjKcGz/h1CcEZI3fc7aM34HtlMRLvXeLawbZW/YLoReVcFyxwhib/4BH706iIrmQ/rWII3oswvJhYzWm2iWq9tDiCH0sJafiriZYOmf/+o0aWR16K1d61G4B5WIHgO3D40C4wOnyHnZ2GCZulYh6NclBG/q0hZE+6HlrB+S4i/q1hOMnLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLaVdzqwzCfX6zaRLf4aFStQzSFEnzVid3+UmntP8l0=;
 b=aJxbo2d6jWXxKHY+Q1B82OFzKK/We+PPmfFlOLTpPf3vNrzjtSGVbcU/QIZNbO+kgLSNt2ICUkL07EVjKnAF07GtdVvQrjEV4vUrzrtvUQc/ibbW9v+HaD4LHt3jlVyYyIGsEoRC5e1nlsZpVCQdKldn706zDidO6w6PXyAh2YPNsdcl3cvS/KqLQVWtVcs3qKHe2UanbYN1i8wf2NzcZ/fu4x69SHtr9jVMekL+7bFj9KSXjVX6wgHO56KQj0S/h3uD22tSH4OGBWlz53GE1mU+A91MNzH8nkPc+a6j8IcmKWzxh5ObR/C/fu8NlmlfiALZWrGAPZxdvBXlI9neUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLaVdzqwzCfX6zaRLf4aFStQzSFEnzVid3+UmntP8l0=;
 b=ZoOzrdxsxKhhQ4QuY+kZskTFBCw2Y1yIzuSLko5AAPb+ifZd9RsYYn4CWf0YZnHuj8IL9a1Tn1EpVg1Hd8bN5R4SaWhAgfCM4xcjaWhJpM+EiOhcRMof6Rxsk2gnRnJmgmGGOtPL0VSVk8Cx8m9D4qlp8g2gWm3YbBCu6WcU4P0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB4533.namprd10.prod.outlook.com (2603:10b6:510:39::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 19:43:57 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 19:43:57 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 3/4] mm/memory: convert do_shared_fault() to folios
Date:   Wed,  5 Jul 2023 12:43:34 -0700
Message-ID: <20230705194335.273790-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
References: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::44) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c08156a-b109-4c87-ba1e-08db7d902c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2XQm5U8O6IG9gT3vNn/WG0GEpi1EPeM/5lePqzeAW8dP9EFQ8hC2EOw44mJ3o9K2zjk/OHXblOoXfaXPMr8/pYDIBRhjQRZjLIJhdJHQRX+fUbF9kZFbc1a1TAmIG0JtnuhUzOhh+2cYRg9FFO/xpVj8xByHos5c8WrWbmk1OP4p92N66hHLVVb6avl9LF63v0IE1h0aB24BlYE3mdQqtgao+sDrLgoU/S8rZ0yOLn4f2R+rG5/KYfVmb2sPAmuGm0guzXFjKxt6J/a9k+fRNEOnJKoY6HKmLgDq7LXfgryIv2dUrIHSVrOqEEg3Q8RwusJ6WG6m5uWSUYCmjcuRLOdMyb5LEHOXabZHUe9tycMRD7+E5q0C4yg5778pwfaccKhCcJzU5rwaooymeUr9gJoBE1eCYtQ1BFRgqtIwNcuFkwRjHHNc0C2tjcrbuyzxqqXRPK8smP1yGChRDG+q7PFQx7cRlrAS5swKnA5st5EnvRDdW2nPuaiqafBSmLQaD2GU80zaF8e5tEA4/VnxisicLjFUYpFzZEHtRyBDleB6A+akMhj6F3Z9Gv7fgQd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(41300700001)(2906002)(5660300002)(44832011)(8676002)(8936002)(36756003)(86362001)(2616005)(6666004)(478600001)(107886003)(6506007)(1076003)(6512007)(186003)(6486002)(66476007)(4326008)(66946007)(66556008)(316002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2WA5FjZfQeAbPXVALK7BXG+quyKaKu54u5rEXIDAn10DRiWn5DBX5vIgKhm3?=
 =?us-ascii?Q?o5zFYntzut9weUMSsoFfS15/LLCTXsi5VQJBAl/Tk2qk/BPO7oyPs1XgoTTW?=
 =?us-ascii?Q?//t/S0bGQPKmiwkaQOh1jH924k3PPqDDCIo3dne3CMb2MskxwNbavZlAL/Tt?=
 =?us-ascii?Q?kE2vXy2vLvgtIt/wmyd/I9imhtuv3d0uzYNLe29tQ8j/E7rdHRqbydVPn/EF?=
 =?us-ascii?Q?uznt/pHsFAwqcjsuGvWJVdZJ8p4gak3M4ysb/l8yg3376CkGGzKAAucW/jMK?=
 =?us-ascii?Q?S1y14ZL1tH+VuJkNjRytUVZZfm/t2OZplfl5CmnrXeUCNf4OIrURKbF32MXr?=
 =?us-ascii?Q?d2TLGenyMTupPv7+WZZUpYjKAR8e9yJYvT3CD9JRAVjRZ5eOKMcqQwJFuQx2?=
 =?us-ascii?Q?eH7FwGbgyujUh/3v9JKo3nHpWHAvzlp0CDYlCdsaKa2HdnqUFg7/eVdf1SBN?=
 =?us-ascii?Q?u44pUcOEbwVDIRabI7WplaAmWu+5maoKRxX82mP1dZhHi3+6KTkUHBTDoxnx?=
 =?us-ascii?Q?I6fra/4IZOawpS7QjbjYZPBnLYLVfokS5IFLSMqXIwcRjlxRJwvCtY609TiF?=
 =?us-ascii?Q?+qYTPV10CcUmw08PYbeza3qggXuh3MqdYr53egRfN/F9U/TJbxpzXYRQ73Xn?=
 =?us-ascii?Q?LJ41ktIBbXTtexyTXMFnRBxIjuJy8DDiQ3eYrKRtdGnUkG6/RyF6jNqe1yBx?=
 =?us-ascii?Q?1bmkVZO/QCtgW3/ZcAlCug18weBoLvnIWqvjPzUTBbA7SBgR8YcjDRwnREjU?=
 =?us-ascii?Q?fYbLD+3+vROtEgw0qoz863sMcIr+vCbA9XoZKGLQsY30fUH/xPM8yYeLLrHh?=
 =?us-ascii?Q?Q6+D2gQDEJYGEwuxpEM8Xm/1+m01g860ttwrB2+2RdFLX73TlNFvEPCIjj79?=
 =?us-ascii?Q?5AxnJ0jqvCRSQb6h6m4b0sn1jh9pXklVucaR+sEyUstGG4rMXm2cKFTr1+0/?=
 =?us-ascii?Q?e9ssCDo315o4w0T/CEqFUOsRmULlZalqjtBlpbV3YMGgU5MdVBCbdLcKqfhY?=
 =?us-ascii?Q?sOfrGAxYhrBbcVWrx/OAqBA3xkfLQbrxfyWaoffDZACmFJFTPfKHSGWO00k9?=
 =?us-ascii?Q?+ZBJqqr4gXfZL4uBrHyO6X7Xm7T4c7Kx8uNqYgcKUSC8k4V7ouANaV2MnLh9?=
 =?us-ascii?Q?6s7d8dJxINmrKdicUwiOCpPja9xVrCsMRSubOPEun9uEfR3siraos0ZIHblx?=
 =?us-ascii?Q?wRmmQsPEf6TVB9sPg6ma6UHfeu5oDqR9E2RA4mzhqYr39pAUc/OaO7RBQRzr?=
 =?us-ascii?Q?pu5qK4ekqDchMIK9W8SZTvA6Z0LKNYNrGHHMRM1y7jCS+Dl8Sdtnk+ZmjTTI?=
 =?us-ascii?Q?hCQ771n6TJB10er8nofzENwLy4YBVs1NsGdsp3JE9whwviYJw2D8QKLMJEbg?=
 =?us-ascii?Q?HTOuC/uSCxfB2f6lJQ7oLbliS7EjQwXZug4TuqwD62FFI4neVI8HENrEqz8N?=
 =?us-ascii?Q?osS2mPGyLoFTF81GqfZnU/7VJ1wEhvunLtKpKa+tv+La4648ogQaufSYNaRH?=
 =?us-ascii?Q?b+bqSxnLPpAQT5TVqlrR9rRpcQ5Iqod85payPov345tTTNAAMAnnp/8z8A1l?=
 =?us-ascii?Q?V81vBN1xni63Ksco1+zrDl0HttpM0xnTj1jWSCSX6goJy8A9vUKliFVcacwD?=
 =?us-ascii?Q?mZI8Ern53zhOD52PNxsTuuw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VobPXkaiKw0dK9ceKqrjCVqPlsLaVaN0OvAi0NWxDQyKUnEI5JYciOOAUfwJ51rAgxuRvQkpln922PY8JhcgkB6ncaVqtDHeYUaAHtE83Uiwrk5I4pnz3p687HzWpo0ZfMTF/F3+A6SzixAe1oXBXcgX/bdtT095AAxFmk9sef00W09IsP3A4AKhj2TVyCCq9FwoxEzkUnpg3AU77JdlL9ZcjBhAb+hLxxlfKUK1Hmzl0IcFRp3asQ1Hh+yJYmVeQsx5GWDl1X30P26lLTYodx8HNuJnmgM8C5vH7CcNjiubou9St5MsyNJoBEXx7A3KhT9sogj8SwwxQaSbQVlSXY2StXgsu3mOzcwd79K18MZu+qunPF8DX+6bL+bumS5V3PoPEi5uRq1QiZUZVZwCqS60pTE9NF3MDp141bdm47+wkJC9BseAa7j0z9xi+gxh2SajM1xqgcUvpD2GdzTKYCo1pHnlEea3E2U15nPT9ZdAD/2LigzE396LqGvQntAiD7JAw2i+PBF5E/x77rdhU4/2iq5bY+mzjTA1rX8v+4y+4uJjcBEj7DTeuhL1ExgJlOtwFNu3lwscLRKjzGJ5ZOPJ7qRYG1JEK9NdqSreC0erYw4aJ+m5z30HEHbG7CRcUwpvhS5zVCppVUrkEpRZ1OOJ+OeHMIf5Agip9fSkNyzfFejkRpiryb+t0e+3UKAyUEJLrsLCzrTVUEXcctd0mg3dkXZJNcustULs/QtGhhBpMIiiPOttJaUywQaSh3ihgWRprj2lMz/Y7ZlUOthOC38XjYiFxskU6Ik1dAFKzmhC+dvdh4q6JNo/t6R4JyyziAMImlMx4TQP8N541WXzn5PlckY7xhI5s+TGpbgZlKoSKpxMlahHyMlmrpE/Rxr7
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c08156a-b109-4c87-ba1e-08db7d902c17
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 19:43:57.3394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBTQOV3I2JZB7KSkaLLS89HVu2L17r3/k3kd/D7bRLd8VabKWZYc18B36OjuRH2Kup009mqaLjdFK3PLmmd7dbH9TDkktcARWHVq75dA3x8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050180
X-Proofpoint-ORIG-GUID: M9-XHpMHVJl8IMCMoywoSL_mP6h9dm9h
X-Proofpoint-GUID: M9-XHpMHVJl8IMCMoywoSL_mP6h9dm9h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saves three implicit calls to compound_head().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---

v2:
	 - move folio initialization after __do_fault()

 mm/memory.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index fba33fb55a010..ce7826d3f6200 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4593,21 +4593,24 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret, tmp;
+	struct folio *folio;
 
 	ret = __do_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
 		return ret;
 
+	folio = page_folio(vmf->page);
+
 	/*
 	 * Check if the backing address space wants to know that the page is
 	 * about to become writable
 	 */
 	if (vma->vm_ops->page_mkwrite) {
-		unlock_page(vmf->page);
+		folio_unlock(folio);
 		tmp = do_page_mkwrite(vmf);
 		if (unlikely(!tmp ||
 				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
-			put_page(vmf->page);
+			folio_put(folio);
 			return tmp;
 		}
 	}
@@ -4615,8 +4618,8 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 	ret |= finish_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE |
 					VM_FAULT_RETRY))) {
-		unlock_page(vmf->page);
-		put_page(vmf->page);
+		folio_unlock(folio);
+		folio_put(folio);
 		return ret;
 	}
 
-- 
2.41.0

