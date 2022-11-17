Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6766A62E3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbiKQSQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiKQSQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:16:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB72B64;
        Thu, 17 Nov 2022 10:16:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHIEflC007339;
        Thu, 17 Nov 2022 18:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=L1RWe60EQJr+YN09V2ivMs/W+Bag9IKC2KGs1S/0h2Q=;
 b=FyILnfAbjqsKUC7m7estq//LRXlUv+ccFO7x+NVCrvxSFvo4U1Sx66ximeBV8dpw2f3m
 G81mKVosn5VHNFPHwUdwJpuelLgc5uziV08ElrE6/JTBfZUZZux45lDFhMKGd1gDy5kZ
 gtonf6CwegWs3hMN/Riz3XRiLbgHmmBIyh3o6RUMdFUVF701p7A3yh44f0SqjRljwWdg
 iRNS01aSNjhuwnIsdE0MrnwK57hcz9/2x6PnWz0Vb0vseg6DCIfqPTia/RUbJneNtMgh
 VoMijrIA5QiTlF8NKKpUGMV9cf+7bRYfePU3XFMFHetrvwCiS848uop3OGJIkNIOZi+b +w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3nsa599-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:16:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHDoS0034326;
        Thu, 17 Nov 2022 18:16:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kw2ddwu4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:16:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDiWbWJ7195bEuI0n93uRkhsHyQuWg4zQ9aKGZarTO4nR2FxcjA6GZbFRZT/o/2WcwM3WYldiNBglE9ZxsrvyB4KkUOU0Vjp0w3h8omSCpc5f11Lo5p+RtSAucVLygqRI+fmakJ/Ru5UZBYR56Id1gO9uq2qLxEYrF5ykRtEs7Q5xMsUj3ppc+DIKVNXHZ1MIQ66rou8dBSq4FQudsmtuBhv21apPjmcK13Wb4OKEyjw52XDO/WI/yp6UNPN6/Pz1UX6Jn3kOG+dr1Gi6PyLFktQTCFJWWmdiO22wBfAxJVGnogH4cOIbj3zI1sw2g8UI+lzDJ2RXTZrRHPw0iz7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1RWe60EQJr+YN09V2ivMs/W+Bag9IKC2KGs1S/0h2Q=;
 b=axLUiUCC74sLbVkDm/xKbwWa8TpIm0TM74Dcw/pnsV8jeYaWDF0FG5ZKbnjKy6nBgcvMT2SPWj+VvH3/3GcxpGyiNyzJej8Q5E1ZXR3DT/abYejDQJSJGWMlDXMOin7g6DUbVJZgB/nPOex/OZXllYPxeznabJXAhLbG+VpElZ14AA/NpbuhbJFjDCrq+209jp9k7D9H+SjbjdJgnwDcZz1fiFOKjyrvXJHRFWvlU+8sIZlpgbHSIqyNubLe5woqfq+NTdCo/+2cbJ1KAV/W6keu93PifcRT6UN3R9VDznpWUuRvAeRvsidh4MLek8SOvGrXHRobvMGpsm2wZdEeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1RWe60EQJr+YN09V2ivMs/W+Bag9IKC2KGs1S/0h2Q=;
 b=e0kJwPcP3CmEDkdfSALhnD0LvASqB2n7OqMRwawrXR0RjYq9iRpRHjtbhw6lKMiIVjKaMKDxSdr/mXefPcYorRP2K7bxVGtQYTZ2KBJtm+WzQR8mU8LDODRxoTM1WQCCKb0ANmFj3mPfbmUUFh6z/6tNEt0aYiTuORWw6MX2uQY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB4994.namprd10.prod.outlook.com (2603:10b6:208:30d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 18:16:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 18:16:02 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: bfa: Replace one-element array with
 flexible-array member
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mt8pwip5.fsf@ca-mkp.ca.oracle.com>
References: <Y3P1rEEBq7HzJygq@work>
Date:   Thu, 17 Nov 2022 13:16:00 -0500
In-Reply-To: <Y3P1rEEBq7HzJygq@work> (Gustavo A. R. Silva's message of "Tue,
        15 Nov 2022 14:25:16 -0600")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: 12550291-5617-4192-0a19-08dac8c7c912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: As9GQM0X3uK3QJDzDXGXSzGXDy6gE9y0YZarv8dw76vAnJ5dpZIh4Jt5/MtM1lN68xmXvKmHtf8sf8eBTQLECZXOGoeOXgCu8TsmmragsK76bGxl7OQEeZVHvKie95s5I1r8CrfcCPLAd7a0qLOmZlfSSC96puofeu43mPf1SVX4RXL9eOSNxlHsavWS/zwwJomjW6pUXtW3AOKbSHpoVaj2/uJIRoDoyk0NZvbiKywnmY7dtF4+UqltW4FgMhHaqXpwKyisXl4uH2n57Z2CQGVUSGIy/kKxoDnRJC30h0AEh47/CFd28sBsOkxhUYyIq1+uO0XcgDKUcqfcqZHntf5zZGjTHWUCcgQGeF7qnxOgDY4j7P8Ur2ilGbkcxQ+RSU141XR6q2DfKGCtclD+lciFLaJeQDvvxBpqm3EhbdP+szV2cyyQb8Pctoy9ZCPG8cy7eSbAiNNktvaYMVXMo6TLqf7pSUi/H26jTtXEvcXvul+ZK9SwDBQhRuGdL5NXrr7BSIzQpE285FYb6do4Rtvb4xJ1EG1sPPLBfgF2rcQsNngRrThKspYMlh7Lncuh0ySqDH1jG2eCZXN6p6ylBwEQHmNQaFF/spoMqbGfD0ZfbY8fw4GFERjWJhJ05JRisHvTysONDk5+K3ozSKWBdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199015)(86362001)(2906002)(38100700002)(41300700001)(66946007)(316002)(478600001)(8936002)(4326008)(5660300002)(6506007)(66476007)(6512007)(66556008)(8676002)(36916002)(186003)(54906003)(6486002)(6916009)(26005)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b71UDFzAhp6ywSHA0BVAFbKpEt+b6qUKn/amcsyPTQjaLT+PXpubZ0eQOz1/?=
 =?us-ascii?Q?Xd1VvXJeIw7Xm+mi5WIiPhtJyGypARsYtuo/0y0J6RKgKnnoe+ybtjsHHV/P?=
 =?us-ascii?Q?aYzODWujIzqcMnBMFxXQucgAiMByHIQ0PKA+qYU1I8tNd0AP0bUlWnuptviy?=
 =?us-ascii?Q?j0RGoyh6y6QbMixmEzUyjY4nkArEKVNDKiD0ra/3+iWL+Ob9ipMkIN5AwMAh?=
 =?us-ascii?Q?Fjftx4TevZ2OC4lvnq3u3MZT3t9ibIMMZpRXsqJcmG3cIL2f+pMICdji7JzG?=
 =?us-ascii?Q?TWfokUB1dhh99TPBihBW3OM7ADOxM8xqI/h3uKFtLiXWptAVc9Bhyhs6dhGP?=
 =?us-ascii?Q?j7THvqhFTplVlyiw4iNNovfgn7K+TrLiZZpzSJyl9XL92hgxZeHRhY72eyJ7?=
 =?us-ascii?Q?pXvojA5rS6nYukdTaiKWzIbtrd0fOm7inYhhNo0tMDwKDn9sQDl7oaPQ3rXO?=
 =?us-ascii?Q?bLSlTuKFlesygxvvAU2DcB4F/IIqOV7dGSW47BAE83wNQkB5/h8LeA7gKCf3?=
 =?us-ascii?Q?sKbs3mzahCcIYL9yRCuGRXAyPJNCi4Ht9B4L9iQuH9M9G93Im9XhMHZf084U?=
 =?us-ascii?Q?a1NkbG4gxXi1OPlVmklptwU2wvQWjp5zkOtsEnkvkxDm/Fr3WVTCFwoBP1Dg?=
 =?us-ascii?Q?+fEczNlcIQto+OeteberS6j6p1i4SEiQ1AZwwoiBAzXJ1k78Fe5gAT5rDObu?=
 =?us-ascii?Q?EZONT/qwrjWAvOCgdyZ/ptJTwUj86wp+po5X3r/99vMCj0CLu5GLPXO9mht9?=
 =?us-ascii?Q?DDD3v4Op8cTsPHKiE7HGAgdocf0QFMiItrRtK7nQVr8sfYdYl6yqKRMTRH+w?=
 =?us-ascii?Q?s1aV8AL61GD2qLWFpKOvs9le8cVhbDAjTD9aTDXVz4aW821dUjbfd8VMWrkl?=
 =?us-ascii?Q?SK9c9bXkZBHEW9stFNJsZSWO1V53Ft2UKm+LOsXs7Dg4CQF1lTJ+5qy/6PoI?=
 =?us-ascii?Q?Q9W+sFqjTOa0bbDKX4BftHqvjX6vtnJfMJ+jhKHp7XsswiJLVafWhii2Qu/a?=
 =?us-ascii?Q?zb0WgHLFRqPPrEu/PYG/nWkLjxvLKWM0sTukoUNYkUjcp03rmalnNu/8VRp8?=
 =?us-ascii?Q?6lKgfCiUQpRRHDttsdAXWX4EpSmTYU6+0ZqFyjz8DRKg00OgTRqlCAp4R17Q?=
 =?us-ascii?Q?otXmag7a2PFVKEzc+irRvCQF+E9XHQc1eQxvB2S2BiN424EMj6ftEi7AllRM?=
 =?us-ascii?Q?ckitgHrvaxIs/tafWHyO0bbT3x8aq3+Oyw/m5EoVcnbVpBWdewtbIenD1gL1?=
 =?us-ascii?Q?LsjidJlH4dyYyydS5FScM97J3iXtG/Ne8qwan+jEUZzpoJ0MeQVsOAYVJUPx?=
 =?us-ascii?Q?kEX8J8WUo0AowXDp/pBpDqrmxjhQZYuD0c4PAhrDCqBHGlmUduz1HKMQo04g?=
 =?us-ascii?Q?5jB5rGrCdIsHkrQJTkZqVwdJV1j8qT5xYtvPMKwLj+SmLy9gOSj3hkaFGCit?=
 =?us-ascii?Q?fT5wFotv+eNMvyU9v1dogjOur5v1bUm2TleyJbWSXm6//FFvkV4+9x8zC5AI?=
 =?us-ascii?Q?PwOQkmsIeQQrde/tSItHEfkjB0daKWvIxbZ3tWcCilN751pWnISOBp9DC0fH?=
 =?us-ascii?Q?3LcmiTcBV2EvhLThT1mrJVU0CBozbO9KP8QsYRVqRp67s+s0Roc/lL2kj3Ai?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KWqeAf7t6ZsKR6QkBdxONQLMWwNZ5Xumg7W6Gg8+YIyVqLbgdJRJI914/aVO?=
 =?us-ascii?Q?gHgHXepEOd1KHR1XEif8kRwc98AF52jkhQ1n2uD+MyOfraSsI5sYQNDImUZ+?=
 =?us-ascii?Q?/HxzofAjxgKw0eT7TmWImwZrKxQFEIsQSj2qHNJe7Iaye5Ielka7k9006V6U?=
 =?us-ascii?Q?fr6IKQEzrBzyYp0V361BOimpyVXAFXgWT83mXyxNGYgzIlY0mRIms3FlXc/z?=
 =?us-ascii?Q?OtRiEOSdHy+9Tif3IO6Io0qr63bMfmoIbboiqZ+mXyJbl3LGtV3FKWQzjlNT?=
 =?us-ascii?Q?cfpyVJZ7Oupkh6nG5+lUlEMXOdq2FKruWMRacRw7QNdbIFBUoggcTBBO5Hlk?=
 =?us-ascii?Q?fxatzp8+o5SgzpfZbMkApyuxHz3QwbCpEqwMDXlhkB2/sH1by7yPEWWAXGBN?=
 =?us-ascii?Q?l4OfaT+l67vHyIN6HrXxxdRRuFItxj98xlawrZw+wBjh1v6kRnlLm9p9dCos?=
 =?us-ascii?Q?Zv9+/iEWujPmGztxEYEk/tUu72NLv5XG9Z+0eVWoppvQdNpTFyvhw1KvUpW6?=
 =?us-ascii?Q?zyAEEO67Ypt1QN+pMpEwdSGToa9L28fF9Bq8ktA28gu+T/g0ofBolGgxw1J4?=
 =?us-ascii?Q?LrtRzpOn6NdPjvA269jyWV/Z0FUUPOiL4xtYXOshOkWoOyabmrn2Bl9afrOQ?=
 =?us-ascii?Q?a5pwRP0T+thn7qTfK4suaEaB7GBZnqn9wjFJ+mDQA7HNviaIjcHJYDYExamO?=
 =?us-ascii?Q?DlieYl+afQzyxMe4tJ89R12zoFsDp16A6daPc2Oc8R9DBcalqjbiZPcn38gf?=
 =?us-ascii?Q?RGCvgE0Mk6hDPBCyeQEtx4Uee0eT/jttOQnu9GNcIaUO0vKgcwl0GxCbNKfC?=
 =?us-ascii?Q?txEuliQgmSZFHqBR+5SaaznMu+n9UQ+b96m7bgPCJeRWrb3tf5V5hjIOnE66?=
 =?us-ascii?Q?yPUyZvGkdfdWkjS6OrELQr8QexYEdV6f09IvBr3c++9HU2rhiUIGeBUjPZkG?=
 =?us-ascii?Q?hI3X0ZSPbOPjXR8VRoqnxcnNtklIVZ6jaGd+r52NsHw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12550291-5617-4192-0a19-08dac8c7c912
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 18:16:02.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Xeqp+6jLSNlpW9yegPdBwN9OChy89xaMR+ZC18YKBNr+9Q5MDAbagra7gdMeKe94YWQ02RoUFwwfew1YV7E8d5IVnMAkekMGIoa4Bbgdcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=813
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170132
X-Proofpoint-GUID: juaps3G4yGMKCvTQwARBoBk7xqMwPL5Q
X-Proofpoint-ORIG-GUID: juaps3G4yGMKCvTQwARBoBk7xqMwPL5Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct fdmi_attr_s.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
