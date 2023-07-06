Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3977A74A254
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGFQj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjGFQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:39:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521841727
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:39:16 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366G3ntc002034;
        Thu, 6 Jul 2023 16:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=eKIMZ8ZrypitCIbtsj/aGplEfX/DSuTSYvIeZckxPqk=;
 b=g4dDq5JnoVfqyR0leYlZjDxmt7omyeIRziJcEWwWArejiAUG/Rg8U3ZmkxlXz0lk8kRy
 U2ztB0ejCDZDvWEJekcDf+p3sBaggyNQfEYlZhTNmrMr9Oz6xEK/dHn5YvC0tsdQDCk1
 A2ZyuKPG7kd6JNxOWAehIGgra3Clhbiov47IQvr2Co/IbNjP8ZM7ydi2OpAP13GeAdYA
 7rz4X2NBxUvltqAtoNO8J9BXUP7wUMm6bF5atX/fApcC7+KPZeFlggnCC5ScRD/ycXro
 BmOLgmyqD37VOUVWuDpMFumRgIWG7s/sGCErHicIxND6tauD36yOv8w53tyKP9WZw4us Gw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6cs8v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 16:38:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366GYVLc010307;
        Thu, 6 Jul 2023 16:38:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak79pue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 16:38:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLEJk6i25N0Ogi+fPMhN6rttGNLO8Mxw31iuZJH80VfhBoqCeMpD/xF0mZ3PKsyu0Wuqc14UyOpkd/gTBPAFclU15ficqWbdmoxigs8ckx1ET7XRTPyXURgb/3j4ACzrXRwbuPszbwB8dVqgeXHRTwOsMGb3HpoXT0ZvZWiy3F8mqT7/BXJNiwZAxIjqcuXGvvi0g0zMbEGQxidZ8Ie3I7P38nhDjkRLio5X7BqvIE7X7y7QTWUvQxavdGw/Y2md/BJyPIB+q2zd3btViYvw0MnMNSrX9j329HCPx3OqHYBA2HuDAljAYWfXue1cnUI5C7zDGW2qDQ8alaZb0+V6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKIMZ8ZrypitCIbtsj/aGplEfX/DSuTSYvIeZckxPqk=;
 b=ZVSYQoYbqWl1V7scC1iCMWXc3IcODr740/kuQehNdqnLmRIbNJ6IQ3Qhkxxo0sU8MM26PiJshFbgr7aUJZ1vfBRUvXMsFME+E6GiaMVeh4jn60s3nUGFCQskM4n/jxhPzPfaJ68s4xuSgVg4Cp53wHKw8/gn0h+S0NnZJ1hebEtf7vx6Hd1MAokVblim2mvMIHpS0+uuPJgs7OL/GRC201aMRQf+lFLWtAm5mB8zKXkCNQMUMPp+6bq18zB1EaqEBEv52fwWCfLubf2+yolU1lOakUkLnf4fZc5pBO0GNoLqa51rdqJ9ZYZAB0PJ6nOTXh9Ai/UVFi73Igo7pMa6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKIMZ8ZrypitCIbtsj/aGplEfX/DSuTSYvIeZckxPqk=;
 b=rl7QKATBt5aZK9pnKY2gBeRgieF+6cUVz21t48gexfrRMIcPsb60dfmcdzNh5Q8InECjRZsAb+bqfrjPcO+cZlwRCxmergFy64spgolxpPX54SgqP95+9wfsfM+Nzy1t1v3vvQXkZ3hpySIg29bMCoC8vVg07cK0oZQGAWmuRu4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB4955.namprd10.prod.outlook.com (2603:10b6:610:c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 16:38:53 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 16:38:53 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        zhangpeng362@huawei.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 1/4] mm/memory: convert do_page_mkwrite() to use folios
Date:   Thu,  6 Jul 2023 09:38:44 -0700
Message-ID: <20230706163847.403202-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::12) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: d684c700-ade0-4b7f-3c43-08db7e3f7c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BleejqJnXvtp3hj/oketlswziQjQSr/mFZ2gj8kWeW8RhPWJs92c6G9i1+NfteA849KLR5ziQE3Khc58ocX7sUbWp9Ai8F/KF2GI0jV1TY/wWXgsE0o8rlBrHWXOj95zGYgGlY6abdmzpBEUM4+DlLUZWVwy14JwbrT7L8kEtyo7bJfvHJ5Z0Jj2NBriQOiYkzNzuZrF5jSj9g0HhtAIB8rp+owKFIOXKZ2UsZvNUx4HRhuv1BTAQgGgMPp7U6HebpIRJsbhih34pLo5bCPqah7k2n8kQQeM158ZFdaHTyXG15w11Zz+WFO/vabrOsD67d3AoIBw2OXvCVQaxtO/PN4NXf062EBH9wIoqwl3oRuWUufrXWRib9p211pszTpltcs3QfU0NUZmRZidTyuaTSzpHNoywRo1eVHv3MRF+ctFGUxZ90GSqEgaAojc0S+YPtNysUeMYvMudqdTQkBpDbrvywbQABSkoBK78zHGeVBH/BFGyY+WEyEij+l7RLd0A5wPk5z2tA2Mv7/qob+1zioDtZySQg4dPtLuLJmLwDFmgFcsdqqob/rNUw/1et5s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(5660300002)(44832011)(66476007)(66556008)(66946007)(38100700002)(4326008)(41300700001)(8936002)(316002)(8676002)(86362001)(36756003)(2906002)(6666004)(6486002)(83380400001)(107886003)(6506007)(1076003)(186003)(6512007)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4+hB6oMRFtR9oNPAea09ttRFMvNLuA8hMQjcLRXelEEAOE9vfdYBrGRywPrj?=
 =?us-ascii?Q?b1KvRnCZbMwJxrHn0vPitn0lDE8OXpAk2KsOjEkYENYSSHPCdTUwqXE1w+ti?=
 =?us-ascii?Q?hKFyBl5eytoVZAu/FMmJYmPn3w2FtUqKsp4meslBuEWZ/o4InvpD+bQj+1vY?=
 =?us-ascii?Q?2Z7oZD2JzQHW6fRNpb5owrKoU/9tlNVd2IsUmijncubXlLaTDbrVbJiWgYsE?=
 =?us-ascii?Q?jkIDz6bm4Dbez/bD62OLI7guQs2Ino2l495221w3umEHY2/Ewq2DrdE52UIa?=
 =?us-ascii?Q?/PODTG+VwwKZTmQYuw1w8nqloYHYChVxNGEnTLfAJ2zeGabrjfXXJpnqALDb?=
 =?us-ascii?Q?diDwgnPmy+WzNqemT2A3AX7QLTNLLrbENJhU3ADl8cLiRP/X/3uW61KzH+yM?=
 =?us-ascii?Q?RoDUYUiboHcWx5JCGBm9LIb5KVmDtLiNtkEFYqSYEdefe93kqXBK/94TEaMT?=
 =?us-ascii?Q?DQsWXHVyLSm1zEMiHvP5v6/5LnRw50TPp1ZxqOezcF/S8/ExNBmXfLEZDfv/?=
 =?us-ascii?Q?YVonMvX8SHPz4tUrGMe7gM2fK3VXqHacyvAtVoNYq0uasfWole6+elHlRxf8?=
 =?us-ascii?Q?z3CrXp1JZJ/a5wHSij40td4FovLMs71Fv8Vt4zPsxSXxoICRfqhfajCAfGFc?=
 =?us-ascii?Q?yAL1Q0sTeDW/KZ/MmKR7mOrM2eFi2Et170ZO56z4feZ3DzRlotnkfuCJFlbx?=
 =?us-ascii?Q?cEPSYixveiEk9CeyAzuBMs9dB6VjKFtuRR05jeGvK3yBl7ETeONSLVqRHzn5?=
 =?us-ascii?Q?FbHDQo2Hus4Bd+0Mqpcgn6EXFb0L4uWTfhCDyC3/ROXwSeNm/Ngk6cV2PZMn?=
 =?us-ascii?Q?8eXTXRULNqTS2ZYweeLj7vdbHBjjWZdQEgVP5XQaTo6kPWaaHVJMyb9W6p2/?=
 =?us-ascii?Q?jQCC70yUGdCbuICXqg3ehp0mCm1PD05wQpsvcB/iaBgWQPgAW+TNmLyuX3HQ?=
 =?us-ascii?Q?iNPSqBn8eVoUWHI8vNcDb7PD1LhN8t/wez3fKdloUVo42fleGRwrOnueNSue?=
 =?us-ascii?Q?vun4dsuevzdCvWMW5IH+B9KZccFKcTPEHQmRW0cHL87RLIn7Q1fGg6avrFFF?=
 =?us-ascii?Q?hJxvcUByXWIlpdwTyBI0aA38GlmjJ4qVzjeCjNtvXJ1fYpBE+D5Y23h5drzs?=
 =?us-ascii?Q?/T9jnwl9J1zE543riiJusxgeCUciTxYNajHbL3n4mToydlPF+7Mm9Ykj5XA7?=
 =?us-ascii?Q?tf7B1D2rTcPzk2Da+sDliwrnx4VSNoAyP3FRLRZAAVmVcamacaxIUZYoAEOH?=
 =?us-ascii?Q?meQHMe3vyM3WzZQxQviLM/BvFiwRD+ygjxhh4IOAjvXc0K25iM6Qy3PlQvfQ?=
 =?us-ascii?Q?DmIbZ+LKLax/nq7IDNj3wTrHro+mOHHNj5eDLSTMxsRM52wunaPX+d0WG1xi?=
 =?us-ascii?Q?5QfV4pc/HhTJTg2rfO1GfKDxPt3Py+c2pp73rmeBUBMkgf2682dWWX6ywzVM?=
 =?us-ascii?Q?0OYywuD0eqORIboUwKQPkiWa2a5/NcNtpG9kNN22Yvyr68f+B2Vj2Fcgk//D?=
 =?us-ascii?Q?ga6sAp+K0FW0ZYgT+JQllE+GdjL3Pn41tdSmcVfqj9b7PWYDHwwlXKIEYCL+?=
 =?us-ascii?Q?OQ42bNajEdM+nbBUcqKp8hygtEV1ZNRErfPDbmvya0Fh4MqgXDngxLnnC9so?=
 =?us-ascii?Q?SDdoBn5IHIqQ6D+RB0JVVhY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qwe3piIttDKpdG9xx7iPRT4D5ukvTEDEFtmtA8Q2vKWxWPjYMOFZTx2n511kFjGd8e7Fwe7RyUqgn6Mbxx0aDlFvKIk7OX8BEqPhWijBOVAKOxBwmJdQ6ixIRySdk674v9gsW3tq+J/y3p4rEcdGwQqxQ5s7cVF4Sf35UpiaWTF5XcIrwqMvHOOrZE7wBMVCh1uNLmZ1DoScpC3UwEGlANutMh7dLIxskCTIjw9w/emu83CWWqJCjiDDjA8TlwEJ6v44pS2H3veUx3mRfLh0onLQ0ZjfyVnw8fdMv100yshtDuw6KD66tXUzYFd7/k7O4MOQYc4Th3QEmva28yfppS7IpB6TqlTCQxPpDKElWqLRx3R/JPH7gb8s0nNiYx/9KgiPJb+ErRG1Q1grjaV188iScK210rGwPHYqLD2VH1iWWVEau/zGu2iEOcfVhw9nWboSfU5L8H5EebWvK5It9+7XfZBLMtPvtcs5Ei1FU/WYw7muglQNyz3sPHv/6zVHY4qX/Bw5mi/rJDsz3B5C4BzKcGtmPWPyWF6IVz+aIIM7fpLCnj5jb/gTurJn78wbpUvHCq/SQY8/j8dVRxg5WsIELRpPE4jMe6SQe3stwyCTX4IblvcFPW4z+MS8VLxzAgefZqNx7YQXXjB890t09IpfYsyCelChHZ3PvfBPlYMMskSba0zfjxH5Y06ruiitUqfjN2QXaJfonU2MwJunM1xfvBgEVyCobbIRVE/EIBx7JeFFg+o3MgLqYXkFNFA0PWJhaw/eiX4YaNg7cPcQ8o70An+7OaYIaddKLVS0FAisiu7fuKQp/Gx5CCQq68tMwSVwWfC+Vsai6xLfriaKBOp+O2657LMHbyehDCXzziWNd+tNLEST0OHbbqEjjKK/NEJnnRPOyI60/HspiN6iGA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d684c700-ade0-4b7f-3c43-08db7e3f7c21
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:38:53.7378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysyUiLLLrxm7euWYT/q5+oNxMAhD30vbgMRtudUVhpHHRYW2nNoCEjKaZrWMNy2u03IHmWVp1sXorNCdXTxas+2eIlaC/HOhFPNB+0n/zPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060150
X-Proofpoint-GUID: 7_DHzLf13NVVQ-V6wrw5rQELKiThzpPx
X-Proofpoint-ORIG-GUID: 7_DHzLf13NVVQ-V6wrw5rQELKiThzpPx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saves one implicit call to compound_head();

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index cf4ae87b15639..1736a130fa829 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2935,7 +2935,7 @@ static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma)
 static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
 {
 	vm_fault_t ret;
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	unsigned int old_flags = vmf->flags;
 
 	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
@@ -2950,14 +2950,14 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
 		return ret;
 	if (unlikely(!(ret & VM_FAULT_LOCKED))) {
-		lock_page(page);
-		if (!page->mapping) {
-			unlock_page(page);
+		folio_lock(folio);
+		if (!folio->mapping) {
+			folio_unlock(folio);
 			return 0; /* retry */
 		}
 		ret |= VM_FAULT_LOCKED;
 	} else
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
+		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	return ret;
 }
 
-- 
2.41.0

