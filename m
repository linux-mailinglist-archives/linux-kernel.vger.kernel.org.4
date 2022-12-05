Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE0642CDB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiLEQco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiLEQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:32:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9271E1E722;
        Mon,  5 Dec 2022 08:32:28 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Fm0PQ031674;
        Mon, 5 Dec 2022 16:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=a3si6jS6Ox0g5dRLuVXNTk53yxWpnj6BsrmMRA3/7pU=;
 b=dh7PVIxo06drniWCNfFP8JuBsuCECF2ojveSRAkXDXvJFOlk2r1PDtQu+msrQRItX6BA
 5tOJVGuDf9eV0hY/1EJluqUofHsaL5CiOtfRAPZLa4o7IzM0sit1nsUMJ8IKPzGyLZH3
 xEUIM8OiWNl/IKtB/8mvIgbWj8mMobgJx/PQaqFRcB6mPTpluk+Wm3IJbG/RQO2Gl3YI
 yYAjtay5t9ZCcJ7vfSJajoS6RZQ43UZh8GdY+BPYBKpmPf58GTcuFTg+spzyLREbKU56
 InbYeWXVomh2mRqnKxxiVc+ADi+zM4aS97kmShTm/58bDATuz3Z6C7Nww9A3tN+AwnmM 2w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yeqm9uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQvi8005358;
        Mon, 5 Dec 2022 16:32:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ucswacx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpZthtiOr3cxEnnkwP1itT6eLqc7lMlHgY4X3lbesf0D1VH+ZctupwlRWU529LtFEoVetMjkubpv2heLpmwaHjnbW/IjsIIvwyn1MwLekMq5SR56ZeIq6Y4A2ZZlbCFFh5AVxcnx+X/iQjf2DOTjzEeZeM2vQvRkvMs5UURzfZYU0anXCgSNVxeIe2LoUTQvgOJeVGa6chNQ9zbfROT6NvpwYYURrKFzcztBijNwav5kgjaZPsmLCkfbwt1JF3SobHM3NF0BcJAm/3/kp4klZdS7KHD7bhkXKfF7CGApOHNRyKf6celSDass9Ih/E9rzAnt735xuThX90D/QfxaSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3si6jS6Ox0g5dRLuVXNTk53yxWpnj6BsrmMRA3/7pU=;
 b=eFyeFsAnZigMK+BfWcUmuo99Lqf9w5P+7+m0R9OdlFCpBp562HYEwNBQOO4LwX5M6Lr0gHlEHtDlwpwllB7jlEOloBLcwpzCfia6+CzE40IOz8ARuenKTnptZuUtsLWYGHRpza7UO654rKh91Z1fzMO0WKf67Sz53n86u3CSfoWXacm5/Uujg4P/U1eO5YANOMIjDRQ8P72sPC6jgGXMVazhXFbKZ3JJv3OOTkmZ5OFCEioVcWU9i4F3xXujQ199PU9uO1sNe8bD8lRhDPoWxpO8W7I33enTRXG4FqZIwCigBPxuPvjCa6R/gvYRve5V7H1g1sCQlNi+6I+i7Snf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3si6jS6Ox0g5dRLuVXNTk53yxWpnj6BsrmMRA3/7pU=;
 b=tLqHBQ9tdy5gJBtlvYH3NWHgbLVbLSXeRhnoENNeh9wXHStI101CN97tYqWcG8m1NwcwC9N2KMR6DIAdhxiW2r/nNbExhmuz2dlh1FQbLEwmHiGVYACxMFfAFBfW3faTiA+MlQ1EVM/O8ZTX/gJ4pAl+ZHO3IXiWiZPLbYZAlpM=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS7PR10MB7324.namprd10.prod.outlook.com (2603:10b6:8:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 16:32:19 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:32:19 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v10 01/13] kbuild: add modules.builtin.objs
Date:   Mon,  5 Dec 2022 16:31:45 +0000
Message-Id: <20221205163157.269335-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0183.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::8) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS7PR10MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f64cec-8c76-443a-665c-08dad6de4706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQklG6dc1LFQLuPFxTKL2mDOHYL63ytM9eLop/m+qav2Zk6RdkcH8cILJvK+lt6hm73MVy+nFgqDWPr8ggItTIRZdOCn+fYCu2eLPQcnfXDZEKcVyE6o0c+uq0h/zYOTQrlS7TXBdC0ya0+X12IX+0vay7Cqj7f0NDHZgU5y9hhFqVjdZ8vPAXCPlK8/N2dRSlHFKIS3bQiUc0Z7GlBJdk7XODlqxpflWJtNHPeqMp3uKoVXwTOqebuEcgxK3NNJbkhrdJtfhEBNFqSQv0IZIoNjIR9Q6Ub9BiLn8SGOQMaDYHNgQeUcNVHyUesTBJIlmPuHwXpyw37KEcKZ0kREuKtSFNoqm6ILLN1Pg6r40+eYfruB3Pxm3BSIdaI66tkW+GYqI2Jec9UjJ1Cc6MEizeaY/G2A0/aAVrUe2dUV3kN8YKwSWnouEn9mM/zK6mpVc8VPjVagc+F7QztBgQcbfQesKH3vrGPch+p2IFdVZVRGxYmRKY4MG8b/tyT2FvTewYrU+BJj9L8Ec9jNkuWJPW2tvcwR1x9IEZvKiEScMxlTlghwQdAITf5wP+qT/Cc+G7UOrl5yXNywE+1UwX1OzUGF5VASBx6CydDW8Hj9Rq8KiTqRKkWvAJWBmQSegw2xYb+UCOUUqP3Gj4xf40jerA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(86362001)(36756003)(1076003)(2616005)(41300700001)(66946007)(4326008)(66476007)(66556008)(8676002)(44832011)(8936002)(5660300002)(6506007)(6486002)(107886003)(478600001)(6666004)(316002)(186003)(6512007)(38100700002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FvsE9OBoLrgsKPHHSwyCRQo2gsGXc4EdVUQNBGjqh2wOeXRQdvQ3D+E0wskb?=
 =?us-ascii?Q?PooIfyQ+jxo48dtNMEjZbVPfQLZuAA54EvvaDg7VqvdwY5A2lgu67UYnRu+Z?=
 =?us-ascii?Q?BinmXC0rFOSVGYD85d4WqagguDg+k1Wc8ANRZUqKtdTIeKpo6/mOY2wNY7/b?=
 =?us-ascii?Q?yaIUz2cWqdTYCnKVwyau4k+1ESbM+a6PCoNsIsneDbPWhb9Y+339TE1ksJng?=
 =?us-ascii?Q?JGxvSfSrUKZwzLc8oSggMd+ZYbQVgkHldCZHi7KFkoAV+5DgBLCCk3rlOXhc?=
 =?us-ascii?Q?dnkjJ32JxnOwtAbblLHvdDeI/RlERPemPscorjuxF5sfAf0wkNDRSaS171nj?=
 =?us-ascii?Q?fujov1LD6Dqe/l8DNBu08xKcMfw7Zq1nyaLjmhBxqknan13WTjlWz/K3tP7J?=
 =?us-ascii?Q?AtLsLcGVnSOTCG7Q0gMO3lWbZ0QGN6CtM9jpeRzJD884x3U9HBXhv0mUlUcl?=
 =?us-ascii?Q?tLH/qjwxSTx/uFuTXR7pEtd7SThNjyufW2CfmB+8TFAcZ3hUJ0OvSEZGFyuU?=
 =?us-ascii?Q?+PB+9KFrJzmJmOb+hxk6sMuY+Lj5Yb9jX594XI3E9cDqCItlYVBSg/RXfHvA?=
 =?us-ascii?Q?8rTAfF4CvscNf1ZKU5uK7BCRKE4nN8xoT6zZ2pDVgyCkI3hXNnYEOzbXYkwt?=
 =?us-ascii?Q?KHCBnnPEJXrLM3eedIyuVCMdw0P113vNObYjRXxaXRN9XJ8z6X91Q/1E6WyA?=
 =?us-ascii?Q?l2gFsYwcq4VG4V5SI1naS9J8IofEESvzVtlag81eNj4b1rtM+JDqj5chKL3D?=
 =?us-ascii?Q?O3loNo7TMhG69E09FhN7WVtdxoESXJuHa0YAvp1W+NQi133iypEyMgkUIzV0?=
 =?us-ascii?Q?6shoZH2dCQJyYlWNVtKUwKdXq/qU229qMVJ2CZTTg+2f3fxbk7+O9cL6GJFY?=
 =?us-ascii?Q?sTY0pM36YDgrut/l/D3hUyeTYySwsh8m3ROXCrsp44Dq3gy4/G10ars44Msp?=
 =?us-ascii?Q?am6Ur82ucmbQdjCfi39HB8bgssxovrJQtI+abEf8cZEXov+GK9guv4vE8yx6?=
 =?us-ascii?Q?+oWSAIzwUQu0WFV7bjdJZiXSzk2Mup67KlCTdSx0ugWzh1ukPh9PCtPWPBHy?=
 =?us-ascii?Q?3SSjz0oaS0C51REVnfA9qKU67QsqnpAhRjTZQseTFe75b/H3ujvwwqi1QoEd?=
 =?us-ascii?Q?lv9Fph8rxv6PcDVrtAfJqDiSBRqb9l1BWMw6UyWBR59gS5In3yH3lOONrO0e?=
 =?us-ascii?Q?yNyENbMBb2xO+tIZPz0rItT8kCXVE4YlRvty5NOfmTdd9aT8oGzsOmceVc0P?=
 =?us-ascii?Q?ZG3l4lxh90UTWHCerJClixXHqbgvWrGoElMuhJ3Wq6X2eV1pzF+otEq42Upk?=
 =?us-ascii?Q?L8YGDXR3A5TpyXNeXxjau7bnGVSPzkndFBzbqOozcDlPFwbvDkmRfO/lTJ/v?=
 =?us-ascii?Q?QmXYm9+ZdQA2vQWLUD4pnENWEyahNcCLhvz7KU9qg/gpdLe1bPao7tgmF84o?=
 =?us-ascii?Q?EKrzUmdKWuObYk/+qOHsdsj/NamOKNjb89xqdLo1M7CmRFEG/24Ravs254jB?=
 =?us-ascii?Q?7U43Lh/NQJQ1ms7YlaPbidx4cxSo0738QMPnnpfWHKAyEoJYgKjTHl6Vm5cp?=
 =?us-ascii?Q?JfaYwCzEyo3ukQY9s453y+9vDn2VRjx+x8h0EiQbzFb6bYKcafLttXOGvpNz?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XhcQDf9uM72i37p68lir/b2Kql/eADA7mXn8DHGXdZXj5gxUg6gM/w0Ot652?=
 =?us-ascii?Q?Jlav0JhO+DhrQ9puOKmGIcZVedqGeTPhBD49QlHRaxXB1lc7xwAcnZiylaPz?=
 =?us-ascii?Q?NziIkpUdo5ycvRMDjIfE3uXeYcR6po3S9irRoHStrboezChN8bAAjXbRn7pU?=
 =?us-ascii?Q?0lJ+6uP73xC/RgIWmHw6iVS+PRjIlrnLs5+TRf5C7RmcXcPn4lebk1mqJwcH?=
 =?us-ascii?Q?fNN1RYYgIL68fmovESc1bi/IsPiXJEJy1Xvx+PrRyBNKGsWDY382xivnSRZa?=
 =?us-ascii?Q?x4ary0tc/uZ23qFgJF5aZWtt8ac4j3kXjnzg5X2LzEXSxYpWEOLzIKoGKCBu?=
 =?us-ascii?Q?vMHAKWrKR3Kvw5QLWbmxa+EtN5GEmFsNPpt/cJ2neqs4U5HBdXqDBsUmj2h6?=
 =?us-ascii?Q?w+1qzYide4RP1wYjJgJ9j1a4hEGS/05SQm9J5iE4xBtUEvxGgSHj3YR+pdK/?=
 =?us-ascii?Q?i1ptXhorEgVc1ojT7dHW0+7zQZy5x+AwXo1tSgHpS8UqbQubQUx8GPIaJGaa?=
 =?us-ascii?Q?z9XpedtizWUsl0qyioX9sOfkt5jUP6cRyEe1LAThEb46JKwF+mRT5+a8k8ky?=
 =?us-ascii?Q?LcSC+tIH0O8jC5fX2ATLnpPvLB18EgIqYK1eArNI5yhsEFMCPQyIrdXnnBFK?=
 =?us-ascii?Q?bi+RAfUqLBtJCUOLhuFwzuBS9vGoDmU+F3gJ2Tycrfhj3frhLcWqVZjcfJPq?=
 =?us-ascii?Q?msgPSEQZvUa2q57l7CwbhFKi/z8YGptxG17pjk7G2z9Lzb6drR9SofcllFC1?=
 =?us-ascii?Q?JcYna6p4OOVe9F50ERtQhz390SOVT4nrbMp1h+ffT2mCAXOu9rTYtiI7c0b2?=
 =?us-ascii?Q?MYV5UawoZfbdW/ruQcsDpOY+E/1rH4FCvl1pm8JtwesOBZ7j8wcXsCNIbsbU?=
 =?us-ascii?Q?R6njOMViZX/CL+dMnd+zq/7dIK8YHpr+CriioW/8nVAxveFFPQ3Ytm0sCOh6?=
 =?us-ascii?Q?4KObjXM3d6oWlUYKsyBK1i90VqsBmBQr7yS3YbQXwdI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f64cec-8c76-443a-665c-08dad6de4706
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:32:19.0750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiQQYQvPE1fUvNfGAWWxI/DF9KYoZGpdBfLTfMU9IOeM23Nlwx3Ckcdtig4/gSxdwtIECwPPwhW4TvJAba4B6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050137
X-Proofpoint-GUID: tbTjqoyPlUPrIvri85ZYRlrfji2mRHq_
X-Proofpoint-ORIG-GUID: tbTjqoyPlUPrIvri85ZYRlrfji2mRHq_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

The file modules.builtin contains all modules that are built into
the kernel and this is used by modprobe to not fail when trying to
load something builtin. But for tools which want to see which object
files come from what modules we want to help them with such a mapping
as it is not easy to get this otherwise.

We do this by just extending scripts/Makefile.lib with a new variable
and define to capture all possible objects, and stuff this into a new
modinfo.

Note that this doesn't bloat the kernel at all because as you can see
in include/asm-generic/vmlinux.lds.h, the .modinfo section is discarded
at the link stage.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Nick Alcock <nick.alcock@oracle.com>
---

Notes:
    v10: new.

 .gitignore                      |  2 +-
 Documentation/dontdiff          |  2 +-
 Documentation/kbuild/kbuild.rst |  5 +++++
 Makefile                        | 10 +++++++---
 include/linux/module.h          |  4 +++-
 scripts/Makefile.lib            |  5 ++++-
 scripts/Makefile.vmlinux_o      | 15 ++++++++++++++-
 7 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/.gitignore b/.gitignore
index 5da004814678..ef8665c64f21 100644
--- a/.gitignore
+++ b/.gitignore
@@ -67,7 +67,7 @@ modules.order
 /System.map
 /Module.markers
 /modules.builtin
-/modules.builtin.modinfo
+/modules.builtin.*
 /modules.nsdeps
 
 #
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 352ff53a2306..ed1fbc711f33 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -180,7 +180,7 @@ mkutf8data
 modpost
 modules-only.symvers
 modules.builtin
-modules.builtin.modinfo
+modules.builtin.*
 modules.nsdeps
 modules.order
 modversions.h*
diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 08f575e6236c..504f31517cb4 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -17,6 +17,11 @@ modules.builtin
 This file lists all modules that are built into the kernel. This is used
 by modprobe to not fail when trying to load something builtin.
 
+modules.builtin.objs
+-----------------------
+This file contains object mapping of modules that are built into the kernel
+to their corresponding object files used to build the module.
+
 modules.builtin.modinfo
 -----------------------
 This file contains modinfo from all modules that are built into the kernel.
diff --git a/Makefile b/Makefile
index ac2ec990422d..93bfaae45396 100644
--- a/Makefile
+++ b/Makefile
@@ -1228,7 +1228,11 @@ PHONY += vmlinux_o
 vmlinux_o: vmlinux.a $(KBUILD_VMLINUX_LIBS)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o
 
-vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
+MODULES_BUILTIN := modules.builtin.modinfo
+MODULES_BUILTIN += modules.builtin
+MODULES_BUILTIN += modules.builtin.objs
+
+vmlinux.o $(MODULES_BUILTIN): vmlinux_o
 	@:
 
 PHONY += vmlinux
@@ -1558,7 +1562,7 @@ __modinst_pre:
 	fi
 	@sed 's:^:kernel/:' modules.order > $(MODLIB)/modules.order
 	@cp -f modules.builtin $(MODLIB)/
-	@cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
+	@cp -f $(objtree)/modules.builtin.* $(MODLIB)/
 
 endif # CONFIG_MODULES
 
@@ -1571,7 +1575,7 @@ endif # CONFIG_MODULES
 
 # Directories & files removed with 'make clean'
 CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
-	       modules.builtin modules.builtin.modinfo modules.nsdeps \
+	       modules.builtin modules.builtin.* modules.nsdeps \
 	       compile_commands.json .thinlto-cache rust/test rust/doc \
 	       .vmlinux.objs .vmlinux.export.c
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 676614d56c25..8c3bdadc93e6 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -179,7 +179,9 @@ extern void cleanup_module(void);
 #ifdef MODULE
 #define MODULE_FILE
 #else
-#define MODULE_FILE	MODULE_INFO(file, KBUILD_MODFILE);
+#define MODULE_FILE					                      \
+			MODULE_INFO(file, KBUILD_MODFILE);                    \
+			MODULE_INFO(objs, KBUILD_MODOBJS);
 #endif
 
 /*
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3aa384cec76b..f7e5a83572fa 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -112,6 +112,8 @@ modname-multi = $(sort $(foreach m,$(multi-obj-ym),\
 __modname = $(or $(modname-multi),$(basetarget))
 
 modname = $(subst $(space),:,$(__modname))
+modname-objs = $($(modname)-objs) $($(modname)-y) $($(modname)-Y)
+modname-objs-prefixed = $(sort $(strip $(addprefix $(obj)/, $(modname-objs))))
 modfile = $(addprefix $(obj)/,$(__modname))
 
 # target with $(obj)/ and its suffix stripped
@@ -125,7 +127,8 @@ name-fix = $(call stringify,$(call name-fix-token,$1))
 basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
 modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname)) \
 		 -D__KBUILD_MODNAME=kmod_$(call name-fix-token,$(modname))
-modfile_flags  = -DKBUILD_MODFILE=$(call stringify,$(modfile))
+modfile_flags  = -DKBUILD_MODFILE=$(call stringify,$(modfile)) \
+                 -DKBUILD_MODOBJS=$(call stringify,$(modfile).o:$(subst $(space),|,$(modname-objs-prefixed)))
 
 _c_flags       = $(filter-out $(CFLAGS_REMOVE_$(target-stem).o), \
                      $(filter-out $(ccflags-remove-y), \
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 0edfdb40364b..9b4ca83f0695 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 PHONY := __default
-__default: vmlinux.o modules.builtin.modinfo modules.builtin
+__default: vmlinux.o modules.builtin.modinfo modules.builtin modules.builtin.objs
 
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
@@ -86,6 +86,19 @@ targets += modules.builtin
 modules.builtin: modules.builtin.modinfo FORCE
 	$(call if_changed,modules_builtin)
 
+# module.builtin.objs
+# ---------------------------------------------------------------------------
+quiet_cmd_modules_builtin_objs = GEN     $@
+      cmd_modules_builtin_objs = \
+	tr '\0' '\n' < $< | \
+	sed -n 's/^[[:alnum:]:_]*\.objs=//p' | \
+	tr ' ' '\n' | uniq | sed -e 's|:|: |' -e 's:|: :g' | \
+	tr -s ' ' > $@
+
+targets += modules.builtin.objs
+modules.builtin.objs: modules.builtin.modinfo FORCE
+	$(call if_changed,modules_builtin_objs)
+
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
 
-- 
2.38.0.266.g481848f278

