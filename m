Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4426869F610
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjBVODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjBVODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:03:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43991D92F;
        Wed, 22 Feb 2023 06:03:09 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8x8IC011276;
        Wed, 22 Feb 2023 12:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=4MmwrWnKBOyxPQSoqL45smFNsISedP80rLcsqa0OXMw=;
 b=MXnemTBCXB9BTso6zdPy7LrOmOBtTfuCY/X0A6+iNENirmq3kRJd3/zHQa+EXv5wHFjr
 F0udXRpjpsww+i3G9AKlPBewfLGkuB6VDszGXGvZEaucXhvash49PYMaVYCo8uMQVm6m
 tEupVIGFk7H9ddXxpxA8triQh5NnygjLiIhrmgTocKS14ani78bO35Kt97dRar4GKbZ1
 lipMmspZDki1cVy6P2rTV1Efn0Jq1WaFxm/VU8PM63qGpZGE2bVAqqr2kPH7VLfTYOHL
 s6vH4hpe5OKdczVV6atHoa7A+gP1X9ExjFUpNbby55THrfssy7ANvxKmT2Gb6nK+AYdq 6A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn90qqpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31M9rdix027245;
        Wed, 22 Feb 2023 12:16:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46r0e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4dShGt6ttd2YdvxSC6IVGtybFgcW3N+FT2ic5t+msbJhI/SoP1tRov2oUWCb09ozTnj6IyMmwJd4eOSiRgclASZRD6fRBXb5W9nRcPz+gpYbQeNG5+wnZN/cGrPxqF+xbY43QQKYVzqBvoW/3QNyiwN44UXRo5HJr/PZFvrUGhgb9CV8cCGhcBxir7gktgX2hCrZKHbzu2h4KX76k5RrzvnHv6UthtHfHZf7N71GlgbaezWMi1lTIur6UWP7fg+pnd4g9jyLju6Xez7thq3NF44jzkMHH7uueFc7r0l6MI/X/rLbeoZxeS8dNFhPwCpkftNaLIy8mOhRh/tWKGFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MmwrWnKBOyxPQSoqL45smFNsISedP80rLcsqa0OXMw=;
 b=lzubuX/RzSL8ZUR5DEDybEpWuZR4Dr00zL0mSdfBz7UTfWL8kBC0Ep0Hmp2IHwt3BvONRx6AUOvB2YnlfpwfoSx8Uy6esYVd6ILbcDy6mKsHtVJl3+5nHpjIePi7FtrhaFCpvZKcYPJWE2b/7ixJwB9ButPCh1SCTS+X4acFXZaL3zVPz39+UzQSxCs9ieMxDiV3ZXDqFSmM+tFl+trotcMToTUTqs1GHitr78wU8PZVXHRjxQ4R+Ri++q9h7hIQXQQpXSMu6IiF1kf2RJF6rxpIcJmQZECW0dHG6X8VyH5MUCwfX8nbngAWQfAQx74yUUKA8ITN9/Wj62y05yEOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MmwrWnKBOyxPQSoqL45smFNsISedP80rLcsqa0OXMw=;
 b=JwEiD585OvHdRAQqv7Kxc8IurasVcCj0Ed1QK7M8O8K8npm61PKgYi09N6G364sYnurmLNIt/WP3dWnZE5PpL58dIncTEvhKZDG+NYtBk6jH8vhZxdlqS45VGqpoIPeRs7O4ZzeRYLzC6NSfc4pbq5J0yQGW5JKfjk/jdf+t5vU=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 22 Feb
 2023 12:16:39 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:16:39 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev
Subject: [PATCH 21/27] kbuild, dma-mapping: benchmark: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:47 +0000
Message-Id: <20230222121453.91915-22-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0390.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::18) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b785eff-df15-4ede-3585-08db14cea6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQHKs5uWnhgf3sMlI+OzrnmOUi0pHIMQsFF1mmwc90TKHEHhoiIu4wWql6I113IIDIrS62ENfopIjt7i0u+6PsXT1i3B/Ikn1amB/GJLiX9jmchrAxSQWXvJBpoGIHmxp9p8p78gT/grD1FuxjrSSxk3/DYlOSl1vEh6uQ+el4oZd/HU9LC/KZlpgg6aoEYP1kafgqKkC2cfV5oBG24ccHPRI6ni9OnSPtztfN/aOGzLDqRl6n+tpT3RRdgMxoDM8R08qM1KtOVaejW9y3yqox3yzDiHRTDFIqIt6x32N/Xl8of5TzJnrCfJhbsgNw4MtzzYLGQ6pkEXnoybylL9m2a88gV/+q7NDClu7+UkuItn3yU36NEdjz1OmEZYenTYlfY50ImI25jf7WTsfjcAPkU3CkVljrRCb3ziOTZVn5g27o4e6bzUdvzwqraXoM4+H48AF1nXpEmTFHvGpuzKg8qz/lDXqd25cLebTC0LJrazGBNMTJJOT870dNo+4Iz/WdOeCBrYg0vAGKUcFqguivG3+oD/4fDl5cgaWzHQy+sXGsuNMog7C3dwVSGsUYVJ3fKQCCN6qqms9ZuKciE5n74Lvn9U/VLwo5h1FbywMetgeyU3NNcMNmINfB5CnhWAlHv0c1ycJBCoHXPcYSwX2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(36756003)(5660300002)(44832011)(83380400001)(2616005)(6512007)(478600001)(6486002)(6666004)(6506007)(186003)(6916009)(66476007)(8936002)(66556008)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(1076003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QadeF5O187roTrNegKrA7VkK4/mZkLNq/8I9SoCwAK1cm//Buvnb4iW0xgQu?=
 =?us-ascii?Q?DSP98G0/AovyYArSGigox8+8REgnTJ8TqPl5OWe/O3NzXf3kaPkK/LzqQv+g?=
 =?us-ascii?Q?wNQW8ePwU0npOGLfA4aopA22kZu3rlFMi5lF4GVv5jCqs4QWbxDff77avYAO?=
 =?us-ascii?Q?S54Y3cnN50rsb5lixdaXYUfJaZvswbTGTZqZ9ox5WLdCMBeV0h56WdTMq29u?=
 =?us-ascii?Q?T88yRDC3AtolyWejvH+r3a3sIaGkKVKHz7xbeS+hTrdtrzBhmkrAxKUyiAwf?=
 =?us-ascii?Q?j5qw+q+u/szxVZIOa0Yn+JVR8YFCJWpUMuQPOno05Biaf65GIhJvX1hFRDKq?=
 =?us-ascii?Q?T6e+1FmQOJqXG/4H6YtjpzXHi596asH2w8/+2xf63hh4qOrj/3EKsszarpwT?=
 =?us-ascii?Q?taBG0Hlj8ZJO1hTs11fUm0w9gc6GQcaKT6Y93kS43FsqLoPjQ72w432FqUxW?=
 =?us-ascii?Q?/tujk9WOkfNnAx8Dwohwn46cW3RvrxVU89gscEXmT/GbKGCQgdiDSRJUaBY5?=
 =?us-ascii?Q?MA2PzoFUpEtQhryoeZeoKNujC1jV0j7BblZQ8/BXMsHMaielAsw4HWWnCXix?=
 =?us-ascii?Q?xiP4cFf0aX5aTKvYM29kaZ8CVq8zaRXvVr1NSUVLc0+kVT1HhUEgZPuhhVdq?=
 =?us-ascii?Q?7/dEsmBWeFsbKqpy17aqRx7nOGbnBYsO/mDUsXEib5vHpbM4RgA2tGc0qNdg?=
 =?us-ascii?Q?14Ot7LCglbmasGO7BL49V+1kKmp3BsyqFALzofVUdlgkFBTXIsF+YHHSikLS?=
 =?us-ascii?Q?BFvvIC/QivwmnWQq07sRqTKywHnObzRuRfyHVxvQN7Z36eFFIolRN77YhGqF?=
 =?us-ascii?Q?ppsvBmZ5gNotqv8ekEk1Xfs+mJf13F/bDxgxNlZCGk8mqvZSwSvPMRh7rr9Y?=
 =?us-ascii?Q?luNzaf4SixlJYPqzHdMNykzBIfTy7qLZGyzd0kfbit3/Z6eWBBmjoJhhvnD9?=
 =?us-ascii?Q?SoHSv5Vq53KVP+KCLSQzm+kDBrDZoLlwzynPqxeOfU4CYS8jskJ4A1vGbAlG?=
 =?us-ascii?Q?Z+DGSWLAnRayJUacKnhIQ8GKeWMKNXQn4+bT5KPLEX/elOMpmxCItXHCxpK6?=
 =?us-ascii?Q?YkrOmJI4Q6yJzZvtLlRsKWeostxFyW0lgkbZptSz0UOntkl6Tme6ExqzaCDD?=
 =?us-ascii?Q?AxLGkQQoB3dlur5/ePcz0odTe9xRGjUd1ORwwKPSXHJzJJ+33hyqr05tc7Wq?=
 =?us-ascii?Q?NW1TJLLEGBAtl/+v7VvPe492K8+pEZ+eQdxnQ9nosz3AXbPrB8cpxe4NnFsP?=
 =?us-ascii?Q?VvUq+iMHd4ClAQC4/YvN0+VdDKqC5LV4sThOR9ixjbfkTs+bmZ3glBxP1fgx?=
 =?us-ascii?Q?vjNeh989i4z/rvYAD/WR7JFBUxthg9p4Qs9bEhz+DetCNf/Le0uuM5AJ4+zl?=
 =?us-ascii?Q?gKROfEvDU4zb+X6vk+ETonDJcO0QwhH/hiFXiIPazbWaOVkv1yTwnWpxKNlc?=
 =?us-ascii?Q?pDe3q5r23dGmxuMkHV3bL5fFOnr4JKgXnxEb5XFIUL0lGzhV/ncdfAlLIrlz?=
 =?us-ascii?Q?8+Y4f8DLWXNkXfJMgZRRzzpS0ATbeFQGpzrLrm9g9+w5yS1G58hgx2Gg1fxs?=
 =?us-ascii?Q?D2kzrb9YEsA9ypibAXNAdk8zOdM2Gj4XYKG5SX+pvpmHkkDOi39lvYhtfRaC?=
 =?us-ascii?Q?5Jckq4ifNBOxt4Fx7Fdvk+4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kmoJ1EmMz8xM1pWK/4AMMABg4WgfMm/ckh+AS9fRzeKsk+2ig3RgSaA7FkVP5BFWLvQqJFMMC/rr21tZEhhYsoUW62vIgPTeu2LsSQcH1qGHP/PLAiS5ReGK9rr00P+O1fQQh3yQNq3QM1oOuhVYjG8J/ueGttjLZXy3KjPMFOFonsI4mgJb6+mFJAzyffGiGlZtW1L4KYeogrwa0W5V37JpdboY94djez/5PCKPrJjF+z55eAJWa/AS9EeMijAbwqRbzpT+tGEJCoJWh9u+vguJHrdHx+Sf/fkNUB0KPlATZUArzC6y41D28bk4TLbSRc+CJzqU/0fNB4DQ4D6pmnesEOFmXWgT6ZORqcPbh/23TTBm8ZRuTxQSdg1LV/AOdSRadM1IBKO7OxK9tWNhQISp5Ar3GnrI2xOx5vXzWhD7RLr7dY+YmEnf+EeQ4aBY3qt52UPZ6BVBztGBja8GNjyGAfCwJQ4nsivx/NhuGrrBHuEn1/vYQBEQKr6jfHTUKZp4+KnVhoGNGXWsauuqDY6tOcNE9dlOkvgszAhtWJHHSDNC4wlTyc+PRl5EVIdf93cxq+5tlmL781B5zDAf2Z5guLDa74jll1ATdOJuYYj61U3jIOn+gGJ5H6Ls0cBQoB/WHjWcEsUSewSQrHpC99cY57dGIkC7drznK5O6aZStwJUHyfxHBbLpE6i0x53txw8j4spNLYhddY4/iiW0HqZlQWdqw4vsuzmgoVezluXkwAuRjD+p9WRcZlDkW6WAki0K8Hn5OLmcA2VzMH0TIXaV8VdM6FPUiVbxoa2PuXEtJCPIiQ/ISJyTWG1NPP0NEdwYAQLFBaRtk8uuJ4t33x+f/Ukf+PWOmrTRNDHVA3haHn0jcfl8I2cOXMbnwZGoHB6sza6+Xxu+cSG4OLa6YxnTHf89/zf1iAfo+jldlpA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b785eff-df15-4ede-3585-08db14cea6ad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:16:39.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FcgdtZkEhzD8SqnDvKMbZ+Egx9omVBscRT2o9h39XyIlQbJv2DtnTBNwt5dQdkHCm/xk+p2+Ot4f8xw98U4XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-ORIG-GUID: kFSMlKis_qcg46bWUVbdthemmw_BGerd
X-Proofpoint-GUID: kFSMlKis_qcg46bWUVbdthemmw_BGerd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev
---
 kernel/dma/map_benchmark.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 0520a8f4fb1d..02205ab53b7e 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -356,4 +356,3 @@ module_exit(map_benchmark_cleanup);
 
 MODULE_AUTHOR("Barry Song <song.bao.hua@hisilicon.com>");
 MODULE_DESCRIPTION("dma_map benchmark driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

