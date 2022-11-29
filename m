Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D958463CB34
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbiK2WvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbiK2WvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:51:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488B72339E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:51:09 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMDZ9W028263;
        Tue, 29 Nov 2022 22:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=RHKiiVc28hJsMCo6RKUzQfHyZDcgMk6bAgu3H8/3i84=;
 b=r9w3dbG7TSR6TN2fb/vclzw35RakdaIy4611qheWx9441QKyjPMeaPrR/LeQM+oMkLoT
 G4r58/W5ps/K0U+fguXW8DelfdHxwJ78Uv8X/unLBGLdmPoxQWK/SV8iFIPwz54rYhjh
 PpLa0JM7lVi80OXQWCe4eWqwnSHX2MPxZ1+ThA1/zmWfUxSBoqyK5QgssHqkCRfgcd70
 26SnJavydXt6gb+tkc0jMGhAOmm/xh0sfDAjQHB53qrjNk6PK44XP/QUbyqAhi7M7Fyw
 T/jOXCzfDLNmbBpUiJHwG6eZh8xiIUK/WZ49flDMG9vg8BApgGmZ/09lYLtUBTXmTK41 9g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2rh7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATLsMgu026761;
        Tue, 29 Nov 2022 22:50:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1w6781-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8unrmBFWsO7tmLUWe6b4AoRtv8rnUOfYFnZeUM7MhPRS0MadDp130GZ8ZzdByqBDeGeprX17gbXTYCdRV1Hinn4Mh3jICNInxSbzDWyNbltss1QDe5VO1PxSpkyXgvlcT465kPbt9L+bgnn0Oa9L+R1KJbZqAFKAg/+sHuWdW2FUP+/EdAfYPaLllbqGSHtYA6FQ7oj7lYo2SEgjcuYJgUV8kRJLDpX3BiympAQxXLnvue/7HDO0gKtdXoCT4J6Qfb7Npy7LOUdV3Fkx38R2uczIlCogGjV1BvLjprLuSrWQhFlK63TeiYRegnlLxCcjlqMq/ERKuRITmUADTAbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHKiiVc28hJsMCo6RKUzQfHyZDcgMk6bAgu3H8/3i84=;
 b=eknpWuFzjTFYdCk+wJBcsKdzM4BOLtoveu5JMCwqDjtj1wsM184VZo73SPn6Tce+2kHDRlSyev7N10C9lB8igKIso9lynxBygpjzCZqhvew3Idw1fRzed8IGDMPnGLYh3IDEatcUnU46hp+iVCauZ19L+BRlAiRURV0342mCFBUsQMcMaAovyOcFEu5KqZolGohGCEKnd0X7WAtJwW1uo73mEBIYWWwaQF4GFZi63fcvusXIdiFpWnIhS8ZhFxF7v0iZ2KQpcBfn7POqEWiI/8ZH755XR5cFBzXeeSCQ4w6bchsu3RS2C7To80sUzONpgSJqPhaBdEKdbDJmyaorBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHKiiVc28hJsMCo6RKUzQfHyZDcgMk6bAgu3H8/3i84=;
 b=OohiyS2oUOOC5NoC8LxmlyASspANHmnoiDbJOXfyCwUzSzh1HM2XpBuKdNSuPAOnR9wIuH6D4plxqVyqgY9R/zlroLKKTXk+qWrTeaLiOTV94Og6JLlcDJGmIDAtX4Pm/sLXOFnJmLssKO2UMWtdQ84trEEqHrXRjNA6XcpjS6U=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 22:50:45 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 22:50:45 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v5 02/10] mm/hugetlb: convert destroy_compound_gigantic_page() to folios
Date:   Tue, 29 Nov 2022 14:50:31 -0800
Message-Id: <20221129225039.82257-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:610:54::37) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: dc35281e-6164-4698-3f7b-08dad25c2682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOIcUtWIJX3MsRm8fNEE6PdjTj6JLOMkZffp2k9N0DHxVdhQtgZ7aaLRtX/qY2W41CTO9DOidzkAb/FQSa237mBAVA1leKkXfn4ca6Ex3OFij4XpU8Oeu6UgOlrZX5qPP/b8W5eCYSvnOqnCd2pL/ADq7J/BtVUDeJ/snfW88ptjoWS5PtV2OJyKjnNKpf5wFj36NllfnutXvIWr/7moEU3/HwmGbGY6wmQV+K5EwXts7keWikc/A0qJ7WaDglEaDxHB8i4SgDYqOW45LRwv/hqxR6l7f7bhGyBkQIrBjpVmvFuZJu7R6j8CZpLwdwqPB9/56vm5pDEjuVnDBSELLSUPvNty+ln9OBCYAbjfvXKZ+Az4MutiBXAwMMAX027G4YzQ3fQVo3Ckf0wrQ7zD2WlcY4ZkAtFxXmeh/vFtYp14MpBrJkidAE1Dpep/R4KNQWx+03WK6oI6SNoDbzwlwoRvZcoZMZvChjEGsKlYA4D3efDSe9hGNFtiSZ0RSMB2L2en4A3k+ILKDO7lCZfTR67TplfXlnm3Uv7Xj1Dok14P2ZepXN+XV7ZdOAPtbraT2HpH6sDwIDuxtWkeei2gknZLtnlYaTnOTiAm/d4flEIK7ihEHAjIRJqjDXbSrcmd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(2616005)(6486002)(186003)(41300700001)(1076003)(478600001)(36756003)(6512007)(86362001)(26005)(7416002)(83380400001)(38100700002)(6506007)(8676002)(66556008)(66476007)(4326008)(6666004)(107886003)(44832011)(316002)(66946007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ek11STNTtbVMFqmcR/u5D8IaLcFZHYMt8cyrUfi7crct5GKPtqh6DT8cD9D?=
 =?us-ascii?Q?HIqZgr8GI3s4TgAjWj+QPybra60J4YhQxhF2heE/gLV6HWg7XgMbw1TQFy8z?=
 =?us-ascii?Q?QFYLG6RqBp/wnG9X9YZ9lGtEr5ubTKrHVzIlMVX09jyFT/ClFZB7kFQ7hcZ1?=
 =?us-ascii?Q?rBDZY3TvBGXet3iGA8ZQI5MtwMRHiRKCdn6de0qMTHdSgU/NNyqxz8MfJ7Fo?=
 =?us-ascii?Q?oSsT341atIb66UfpectN+xwxhaAtaoJQ8p9BtmpP9Wu5KGcq2HD+jR4u+46e?=
 =?us-ascii?Q?yOPZdZ3zNAGQTEGDpEa2nf3RhET5zY231huiICFYZwPG55YWs0daVTwRdcg5?=
 =?us-ascii?Q?Y56vpTgdgl9ffgDOVAF+YvY0CzCvODEJ/35qfDwj4K41qXAkNWOafNV/G6NS?=
 =?us-ascii?Q?okMzSqjGFptISoMWSxgjufBlfZw0dBQujQcIT+wAkfjFWyQBoeSYPUrQZAKa?=
 =?us-ascii?Q?heiQQYEKM9o/d0rtF27UKoLO86UwPtNN3EEi1/LB6xYwCfsfM6MsXNmPVF/i?=
 =?us-ascii?Q?2JY34lrre0ZGw7J1UDRYEp5NqOSsXGDNb3qZZY6sg+JV1eaGBoNeaTwC3ttq?=
 =?us-ascii?Q?kw0u+/rfu4FVPRZ0Bwoq8pPO5V/AxV4uF5EYiZcDDvrReOuKel44Z8MJoXL1?=
 =?us-ascii?Q?SEg2vjrDNiQU8Be7nH7u23EYAIzEbNtu4GG0/ITB/FQlLFCR7IZjZKB6AnKZ?=
 =?us-ascii?Q?dSDakNpVowdI2DD1zrlJhhvyFe82I3J9FK1CplEOpC54xN+oHenf3IajPGky?=
 =?us-ascii?Q?bObFbwCp8XK0jnMiOUEB3ddOfzIY+roDmd/V49eTZmIxdP37kffr4IBzcSsS?=
 =?us-ascii?Q?xsOKffu0Vbz0JfXHR1bjAkKKCD6SLHGZi62YUWYD0s8ZVR1ONuxtfXrzuaGF?=
 =?us-ascii?Q?n6bWvfBz7kqq/R/ssJKkQL4zC8tru1uidJKLPYhzkcDbS3N4uvbtK7TkHC1B?=
 =?us-ascii?Q?EKoB1DQ0+5aYYgZshYmKMTI1NEhOx3n5YGPvariBMHTfvphz//+1SeWWuura?=
 =?us-ascii?Q?5Arl9R4dLtpZDhWpG5Kv5uVOmMZySsGE1BSf2i8jjh2CQ9G3+sKvDQLGzTFh?=
 =?us-ascii?Q?fRRbIh/0Qi2lJJjp14E94/V/XZxw7a3tEPDx/LYoKN5T2FAhFmSSmFDv/KQh?=
 =?us-ascii?Q?jR8G31PkLCB15xQuEF8MV8rMf2GREFpjoDfNkAJxL834tydSXt6aNkAUM+fL?=
 =?us-ascii?Q?9owACazWqL5sBNabzJkmHGMrEe9bzN7VGSCg73oHyFJESNfIKo76aSQcXw9k?=
 =?us-ascii?Q?+1vYssSnmov3xFwjqJmmgjzS5mRLMrLnWDXXfhD6u5TZsZHQ/xwnSuqXTCWd?=
 =?us-ascii?Q?3FMu+uuTDJTQLn0ZlXQ57QPmENgX7SeUqRvdsC7ZiawknRVNJ1PqFN2NdEDw?=
 =?us-ascii?Q?4QakACxlS5fMu2ZP63NWXLVfWsRjDgRSzEIwynnnuhwzB689lbLrOUAxHjwE?=
 =?us-ascii?Q?ErDkrg8XbP0uk+hVEWEJlo0Uitu/SgLpKyz/rI4ip1TiHIStI6lMaeDLmWwi?=
 =?us-ascii?Q?5La6GiUAh+I7jZWqXUkVyET8h3KQC0wGlJcj0lt57h6ba/2xOTTbVAw7dS5V?=
 =?us-ascii?Q?yNPZxnCjvlKRR3gcug66XdW7h/B88ttj+CZ/yV5vMc0nzPCFL6Wl5a3Ep9jq?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yEWdOMcsFLSVnejXcNE4HIkuehjQJI7T2bKyOqG8b1FDs76JTgOcNeXXmUCT?=
 =?us-ascii?Q?0UsYlZ+RzdhJnuLCIx4Js3cXBxH4+qy/4UbuKkZJgvgZOCES4GdVE3hA28JR?=
 =?us-ascii?Q?gckrzIEeSY6pHX2SOjiKp5nJ/vNT3Rr07NLz/VXhQwhzHbn1IMm69HuZ/i34?=
 =?us-ascii?Q?N7mVoxFFhaLfr8hN0OUJ4mt56y47SCgf1jkSxh7aQCioX4XRqoPgGlckFbxp?=
 =?us-ascii?Q?09q+re+CqHc6E4Z+8/I7JqdtYlHasduLWKlYRQzd0OCiL0u55CtB53ZZHgSl?=
 =?us-ascii?Q?hXcOHbSTRLLUAT7h+lm2I2y5KWf2agFyP6wkc59RScgvre9bY/iQQ/TvUIPS?=
 =?us-ascii?Q?UHtyX1rYxvO4us5jkbJm5hoami1b8ScL9Y+COQvhcs9rKqSvj+pFTIdPRrnh?=
 =?us-ascii?Q?iDIVhwm8eRl971+t8CmtQrgc8PNJbUcDsKernBgCbTF9R/P3YnF8mEZnvhso?=
 =?us-ascii?Q?c3ID6vHVt+lznWqRf/akbGyqQFF79WmYTNNRjj8KdQf1SHRf4AeMzpoGVOVI?=
 =?us-ascii?Q?16JmNwiB4og1Hx0RkSEoOGzNTnOaNJjAKuKfq1BUS2CIt7MypKmK3dCA3GE4?=
 =?us-ascii?Q?lJAxZVbumj3LrZLTJEuWeNJxloRl0zvVuX7Jjqhg/FIo1yqAozhyhK5pn8EI?=
 =?us-ascii?Q?MGHCMjUyLDq9nAtKsiQXdkoSaNA+2zEPCGUoXFgKhiQu4zoe/aYoc2FMoqL5?=
 =?us-ascii?Q?GR5yfpdIRykg/i5U5DrXzdsrkHgBV/JW5N4uUM8ooEzoGk69ybKH6/hOR1Ox?=
 =?us-ascii?Q?SEi32yctA0t3WhLOTVcViunFhBuaTHf2YPgEtbfQoWg6wAOnO2BJQtPSSvB7?=
 =?us-ascii?Q?wROtyWWBrvbQ+PJDTOnhQi0jFOLT5gP+yerbj/oO8Bfeq/FIZ+iPdfQivCNK?=
 =?us-ascii?Q?oYwj8+bLb5mrWuroiXEPuUccow2fjlVtmrMtsBGZkmq8HhkrlHIuEbGaIHgq?=
 =?us-ascii?Q?AU/VrdrjONKwo0f1y+cUnYc5pXqOg9HvO2BJsiiSgejG56lidofIXMLlKg4E?=
 =?us-ascii?Q?C1lBnTo6Bln+4fWWn4de16gVMr7B8XBA3kbS/JsRA7wghh81JYLJsYJF3tJV?=
 =?us-ascii?Q?QZKSZLcVll1mwVa1SNNg0rqxaqso1LWCHCmUhW6r5q9+6nWvL1s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc35281e-6164-4698-3f7b-08dad25c2682
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 22:50:45.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XncKkNa/2ATXoXYBUnGmRKfgZhbTNGW75JoxAGfeRe0f2epD+0saNwSyURySTUFPnluKlGZRSKkU5pHZtIanGbyt7kGzkpxjrCB0LWn04FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290137
X-Proofpoint-GUID: 1eo6L1hS93cB-ftH5VCKollboVXuz5gg
X-Proofpoint-ORIG-GUID: 1eo6L1hS93cB-ftH5VCKollboVXuz5gg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert page operations within __destroy_compound_gigantic_page() to the
corresponding folio operations.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6390de8975c5..f6f791675c38 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1325,43 +1325,40 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		nr_nodes--)
 
 /* used to demote non-gigantic_huge pages as well */
-static void __destroy_compound_gigantic_page(struct page *page,
+static void __destroy_compound_gigantic_folio(struct folio *folio,
 					unsigned int order, bool demote)
 {
 	int i;
 	int nr_pages = 1 << order;
 	struct page *p;
 
-	atomic_set(compound_mapcount_ptr(page), 0);
-	atomic_set(subpages_mapcount_ptr(page), 0);
-	atomic_set(compound_pincount_ptr(page), 0);
+	atomic_set(folio_mapcount_ptr(folio), 0);
+	atomic_set(folio_subpages_mapcount_ptr(folio), 0);
+	atomic_set(folio_pincount_ptr(folio), 0);
 
 	for (i = 1; i < nr_pages; i++) {
-		p = nth_page(page, i);
+		p = folio_page(folio, i);
 		p->mapping = NULL;
 		clear_compound_head(p);
 		if (!demote)
 			set_page_refcounted(p);
 	}
 
-	set_compound_order(page, 0);
-#ifdef CONFIG_64BIT
-	page[1].compound_nr = 0;
-#endif
-	__ClearPageHead(page);
+	folio_set_compound_order(folio, 0);
+	__folio_clear_head(folio);
 }
 
-static void destroy_compound_hugetlb_page_for_demote(struct page *page,
+static void destroy_compound_hugetlb_folio_for_demote(struct folio *folio,
 					unsigned int order)
 {
-	__destroy_compound_gigantic_page(page, order, true);
+	__destroy_compound_gigantic_folio(folio, order, true);
 }
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static void destroy_compound_gigantic_page(struct page *page,
+static void destroy_compound_gigantic_folio(struct folio *folio,
 					unsigned int order)
 {
-	__destroy_compound_gigantic_page(page, order, false);
+	__destroy_compound_gigantic_folio(folio, order, false);
 }
 
 static void free_gigantic_page(struct page *page, unsigned int order)
@@ -1430,7 +1427,7 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 	return NULL;
 }
 static inline void free_gigantic_page(struct page *page, unsigned int order) { }
-static inline void destroy_compound_gigantic_page(struct page *page,
+static inline void destroy_compound_gigantic_folio(struct folio *folio,
 						unsigned int order) { }
 #endif
 
@@ -1477,8 +1474,8 @@ static void __remove_hugetlb_page(struct hstate *h, struct page *page,
 	 *
 	 * For gigantic pages set the destructor to the null dtor.  This
 	 * destructor will never be called.  Before freeing the gigantic
-	 * page destroy_compound_gigantic_page will turn the compound page
-	 * into a simple group of pages.  After this the destructor does not
+	 * page destroy_compound_gigantic_folio will turn the folio into a
+	 * simple group of pages.  After this the destructor does not
 	 * apply.
 	 *
 	 * This handles the case where more than one ref is held when and
@@ -1559,6 +1556,7 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
 static void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
+	struct folio *folio = page_folio(page);
 	struct page *subpage;
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
@@ -1587,8 +1585,8 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	 * Move PageHWPoison flag from head page to the raw error pages,
 	 * which makes any healthy subpages reusable.
 	 */
-	if (unlikely(PageHWPoison(page)))
-		hugetlb_clear_page_hwpoison(page);
+	if (unlikely(folio_test_hwpoison(folio)))
+		hugetlb_clear_page_hwpoison(&folio->page);
 
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		subpage = nth_page(page, i);
@@ -1604,7 +1602,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	 */
 	if (hstate_is_gigantic(h) ||
 	    hugetlb_cma_page(page, huge_page_order(h))) {
-		destroy_compound_gigantic_page(page, huge_page_order(h));
+		destroy_compound_gigantic_folio(folio, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
 	} else {
 		__free_pages(page, huge_page_order(h));
@@ -3437,6 +3435,7 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 {
 	int i, nid = page_to_nid(page);
 	struct hstate *target_hstate;
+	struct folio *folio = page_folio(page);
 	struct page *subpage;
 	int rc = 0;
 
@@ -3455,10 +3454,10 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	}
 
 	/*
-	 * Use destroy_compound_hugetlb_page_for_demote for all huge page
+	 * Use destroy_compound_hugetlb_folio_for_demote for all huge page
 	 * sizes as it will not ref count pages.
 	 */
-	destroy_compound_hugetlb_page_for_demote(page, huge_page_order(h));
+	destroy_compound_hugetlb_folio_for_demote(folio, huge_page_order(h));
 
 	/*
 	 * Taking target hstate mutex synchronizes with set_max_huge_pages.
-- 
2.38.1

