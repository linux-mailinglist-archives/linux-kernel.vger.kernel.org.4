Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438936F87EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjEERrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjEERrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:47:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E5A1C0E6
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:46:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhO1x014853;
        Fri, 5 May 2023 17:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=J7UkLuHdvcaGWiHLptvkrDXfaS4Mp30zRMqlVBCT7Tc=;
 b=xWpisiGXJN8A+8B+DdW/hE77xzaLER8/Npbv9ncSIH00EXpr7vnYTgYQ3A1C/fO33Cu/
 KsgTzqm2zS/MbpvvQCGcJBkfL3y7EJyUfueGmCrn78N/KLenEnAPTJwLAFXOqjBhaOTb
 13AQpcSiUpVfEdbzIvYtqGOtIWMyJOHmDxOfxghTyENe10V7hdikziGPnQkz7SNSWb/L
 AO2F+/0ZVVfK5IxrGCz3Lepb8c0xqEk6KbNZAo9bjaKRjOqid71FhwKCjgCcvzUBNqXp
 oPJqCFbtF6qJiOsWUSMIbrFKM4hb+D46GkmID+I+caH+CURsjf+5XTfAg38xxiRtlI1e Bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8snede0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:45:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345H3l03020835;
        Fri, 5 May 2023 17:45:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa5g04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:45:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhlqnNhVKoiHhdXYYL5MHsm6nD988kJd14f9IwI9NMLtIyPbNr/wvkDNO13LdSyxZWh8GC14YuHdku62+4Q0MBg02tnS6HI7W51rTgQsaz2mFwhRGf+Gps1Y0g0HZ9KtHiapoSopcGJgHipO/u5Pd5QjHg8UpaLsWdJFk/IY1tvuZqTsHcZ6xbn72ScoEl4/ulDWlNfACXGSCn1BumcLnhXbQR5Idp/A0rlmTNEjn6xpKSjkZlsPV1+GWabKZQgbNsokpoK1bGlpjKXDe5Kfsmlo9GpbRd/iTn9UawAJhE6rVKMk+Aw4r5vOzp/7KZMfZPPC5dEDttIaTVGgBcq43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7UkLuHdvcaGWiHLptvkrDXfaS4Mp30zRMqlVBCT7Tc=;
 b=ZTp2qzHAJ5jicvC7UZ9hjS0ML0806KfmO7MBA0BbE8H4fgdjynWUXbgL1yZ8y+sQubV4/bM20hXKNhPCghWDQdqbr//vcLwWgNDA0MgHlm4eGogVdpiOq+58Hl1JRHoV56E+5DhcelVkCSRKuB0Czf39d0Njng2BzEhT6kFP/yUM2L3zr9YAqu1kEgv5owEGfN0dhz2GtxRR5qqq8ee9m30r5ziXhtg2tGeMVccNupP65uoWGi1Xlfya+a2/79zy2cSqBe1g6woZEyBBHmPj3hqJhrb9nCOKNxPj6N9oGfvUbW/hgNyJJ8kxRykvycjf+WL/lCiKwLrfP78UbZzdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7UkLuHdvcaGWiHLptvkrDXfaS4Mp30zRMqlVBCT7Tc=;
 b=CuFSRmdk0UTXfxInglWL8jlshFG2DX7grQHcHw4hG0lCn3j75jKP4B7wOwHjmIqBE86658xmCkSQVO6Xz6j5vThfQ4wrl/8LcrSD5A7gJZk56iM/dCFvBWejWGDfqzoRSF9Gz7/Sp99ar2G0yyUwJCV+k17z1wM8+Hcxc2RxG5A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:45:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:45:06 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 36/36] maple_tree: Add gap to check_alloc_rev_range() testcase
Date:   Fri,  5 May 2023 13:42:04 -0400
Message-Id: <20230505174204.2665599-37-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0254.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2a7743-cb70-4045-e3da-08db4d9076b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1i11IAxjS0dbbgp+qvFwil9gsXxsx9t/9esfwEQU5M7jkUpbrfM5d6zZRRY7i/IDVGVEF6HiSLx+/b9qGmLpvhgn+5/LrHJ20+gXiR3gmt/L4zBrzt5yaLyBLvue/FZ/3jw3owY5RAJhHlOj51g1rMmPmQG4UOsYKv+XAb5U02poGXHJ7+DkYCwMz4RHpSl0IbputFfVuYRM0aRtPnaoR+kC/PC3pxPCYgq9A6uOL9Cy3rs1Hzt/ZGqQtQDJZ9otIvkGrYm3OsrFG0ZNZMpNdIF+s1Uo54zov/l7ltC/Reh1RyPqlLkz6YrgRijjDbDDx21ljwIigx+j3i9m63NzqQbhFPLGXi4ah+/6+ymQYTWiXr754ZjDuyHn3M2CPiZwz8qJli1HsmHfaKkuRH0GQMR+q3OBoDAtNeFwDBtkKXF+ernWeZ07ECK30C8ZuePOIPvuS8e9eX5hLYXpg8pQelDP2GzSCCLK2VtU5n9C4OcmVBBnKf8lpaXHPxaRSl/B0yUh0QOn7hk45LOgeGB1jgg4qby5XL3QahT/e/KWJR5xHnfQE3qpByn9JrAo7lZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(316002)(478600001)(6486002)(107886003)(2906002)(4744005)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iUTX8M45225crYePR+vVW12jJQ3pZOIrfpc0FWhmzrnBERre2WYl0oIcRDby?=
 =?us-ascii?Q?vUu65kX/K7P+NJFm5buIVMzITOypYQ10l/e7FuvvzUp5oaNOZYFZYMbqVGDp?=
 =?us-ascii?Q?WYq/xM2So2s8gre+0Py5AtYkscr4pCkWGehI6oswGW8FbZG47homcvuJR0WM?=
 =?us-ascii?Q?DWPO1m8imuygJQ2AeaVyrL7y2bXnS7z1TgrcUEK74CYaQner+Rk4/nlG8wN1?=
 =?us-ascii?Q?W1Yumjcd/VAFPc3j+8/fle6U8iL2Jxo77X30x16Pe2kUIsrh8czOo7j4VA0c?=
 =?us-ascii?Q?8uB18ycbwGud+tvOF+lGwKcX+IXNJi8BSihriFSVI7IvLhYZyH9bCpEK0sos?=
 =?us-ascii?Q?/QRuaLxMAYqAAm43+3TvTGNEPjsd9lOnq329in43TX2nipMaOPe6fTuxzwNI?=
 =?us-ascii?Q?QnKhgjpxHPM3iN1tByNDlE5PeJnHVC6gbLWacn28YtfLnbZc5EKM8s54l29+?=
 =?us-ascii?Q?KIQOvev07gb0mNobLGQwBHNmJhkEqTtg9/2i/M6gU+EHzqSrwPZ+Kcw7ZxDT?=
 =?us-ascii?Q?Rt9eLGXKoFxe9iQxiHEDC1pPyxQ5EPi6QbhyFK3/u9rwbxZH38Cvtxrvsnai?=
 =?us-ascii?Q?UE08WElNRG62Q+tRFrGtf99reIWmXSVWeWwTm1zoKZS4IlOqdCKC5VYQuZzX?=
 =?us-ascii?Q?3PFqRpEsK59qdBANj+hhisksXHJgU5jab7ewcDCpGR9+46Ft/bSiRHXH73IL?=
 =?us-ascii?Q?kdrBNxYT/194paUf2pgkETKKDoqXh8glS8eb4cybJCErrId3/zWUvfVTnx8P?=
 =?us-ascii?Q?+EwODabMGN7n/7nGJ3GGDF2HyHVU2GSNG8R05OzwUYitQHQItDYyHwyfBrYf?=
 =?us-ascii?Q?3N+9X8SGSaKllJAhGu+c8uEN51VczSxL9UPfhUm36UsWK7EXJysZXyQrUB/R?=
 =?us-ascii?Q?nhk0R+A9lxe8gXWnxAzcij+EMaA/6LNl81kzXl0fYEztPOD0jQGkt6hb8RSS?=
 =?us-ascii?Q?eyukyodPYwfiTfZssLQFEFZQ7dd9S0FF8vFYpipkJygXT5lwYPScattIqaBc?=
 =?us-ascii?Q?1YZ9d7fKrQ/VzQ5DZXablJuVm1VGrIVhUe+2bvw2+Uu+3kNBOxDPdVfyc/lE?=
 =?us-ascii?Q?G5L6PLKlS5+IrPdEGzZlGPtjXEvg4mY0vqDjgqpyRk4RIUzQp7c/vetKvXni?=
 =?us-ascii?Q?HWlG116KF4feCb0AM1xzbVrO1B0exWCUIbG2FwVTNPibFow6k9Uy1FBAbOVq?=
 =?us-ascii?Q?tFHD0wFrgUeEwPwLaq36XJxHw6GSHa4l1DJfWqDy3JuGmccijIW3zqKAzptd?=
 =?us-ascii?Q?b4cOYp1NwK+8+xDNK7efd828YFrD75s+QFRou3I2QpKDACohWUz4bYBOzivI?=
 =?us-ascii?Q?9+YIAXDp5Ae5ZiIhNzEVH25RURkQ2zTP6tt6DGYon9oaNknJPBVIEunMzCBo?=
 =?us-ascii?Q?KehZS0D5IaEWvQOhIrB1++zYdo56Fi2eiIPG+xj4oqGm9HeAqZxOTW01Jv2/?=
 =?us-ascii?Q?R/s8kWUFM8vHQs4jKcRu7EIAEHj7bttAzi4S+MozMHQLzO9xv5YsRuudgevY?=
 =?us-ascii?Q?OoHzK01h2+9kLyvar7yJUUmIZfImMW3E/r4nq4h41Wor8k+SYkRCZX5q49XB?=
 =?us-ascii?Q?E710vwdwQw4cX2tccXlHgF9l4Qugoh/tPWd8tipA9+bzZq3LDGdC/RQSgFcQ?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VGZB0a6WXvqoqdbmKjy0aUOX/Ml1rWyTkoR7T8zhndc1QYFNbOW0zqhJVK9Ed6/HtyLXNtR5RgbTU2LQ32HQO6yRYoKpae+ru7jVA33vmf40thhTW9EJKk4ZgG1Xkr4PuCYtG1Bq0GGt5IdVHrXO7LgQiDQ5md9OxWjxSJcRX8g0Mz1Bi2jC2/duU0xz+j/jNSJn/p8FpZoQ+1A/z+TybPgWJC49nVbzgrtPy4ulgz0V8kFo2F6z8Y4KIhNzY3LMN1Ww96PhjFbARgxirv2Wh/Lgs8GBaYhsVzt5wJ2IAYeWFB+7c3xuGm6bHMLInxFcA0O/Ft2KRFAA3LlBMu0Xu6f2kGqAqheqN+Ttu04LRmbog0u2EvPruIpNiuGxRjjVOD9nokIvEAFNLdJMFGldPU6R+hto3z2iA6NxWBYE81uNt3mF9aeU2ZIFgfPIa6QShG2y46BIWYrrQHnjNHoZHoapthyncwCzxjA5q2m5EuTYGXNfYdZkLlwXmrJh/tvqJSdaarYL9DHI7jrTewkuaIxh55i/9Bzlw56mvlmFIelHWG9SjV4Glnzl0waikNFh0OMobdJfM5iW7R0Kw+Nk/I0TVx8YDDnLLlKpL3rkwM0p3ghuHE4cKTdeVOQqD7KzNVMMxt/zvgqsgLf6lmMak8PAFKTafarKZyrHavWTgOcboNg0cz0qlYW2w9xV56ozvZw7SiqhLPmo3IEnQ+oHBUvkJxGfJ7nfyLuSW43GU3j8LbDJJ9hFxsDS11Cr/WZuLm5/Yg1TU/32561iEIWZsEstrFL5r6pcXNoR+EP42kxHepUJLyMvEUEHHxoRc5gbbT/oZoki+LQy3LXMnXvqd/0iF16OsoPDhhyt5alESEumOzZSZSSI9LU05xj5Krg9Vpg4t8ZNHhA5Yz+AvagxLg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2a7743-cb70-4045-e3da-08db4d9076b5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:45:06.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+jD7XPy6dYNN2EDUF1N974x55tSHxH9cP2XQlW4PDMKB6y5uH2gqlwKygTuuJUm8TuK82VfrD3XV2adhP/z7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: r0wcokRVHZ-TWRhIRkSC69oXu0je7ljP
X-Proofpoint-ORIG-GUID: r0wcokRVHZ-TWRhIRkSC69oXu0je7ljP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index aa3c4fb9175ed..9939be34e516e 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -804,6 +804,7 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 
 	mt_set_non_kernel(1);
 	mtree_erase(mt, 34148798727); /* create a deleted range. */
+	mtree_erase(mt, 34148798725);
 	check_mtree_alloc_rrange(mt, 0, 34359052173, 210253414,
 			34148798725, 0, mt);
 
-- 
2.39.2

