Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C62B662F0A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbjAIS2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbjAIS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:27:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FF743D92
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:24:29 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309IL3IQ003383;
        Mon, 9 Jan 2023 18:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=FXhv5ATI+xMjqJAAzKM1ERIOu5JSvfen69e/Rm89wNE=;
 b=LZkItkUCFQo1ZeowHjozOkqjTjg6g9Yxk+OX2/XVR0SJR9et+O+LQY20EXtQJw+em7LK
 WoCKVVr2ZZfNzmE3/x/0VKtl1ZHzK/JE6wqImy8aShPOubeR9IDgRoYP3NsB/SZNOEjK
 4I99SjblpkUzVo+uJaNG9xGEGr1pCj8TGpubzPIAY0MISQI4QhBOQgoRUAAHrC2/nw4T
 3sjCQXpYYF05e55elM6Go7FbayeuXmihsRCxJQv1TpqfoV991aBHYecBTGIpGGJCsBfl
 aMqOtoZNLLmS9ZeLKLe+bpyKxENc0F/wT2B7YXnmnAYkqwgXgbJDKKtHGnui0E0motRY 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n0r47r05u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 18:23:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309I5mNx002369;
        Mon, 9 Jan 2023 18:23:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy64cnyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 18:23:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkkKQORRMd4nyN5JgkjBGRjCfiZnXdbJ2gGqINuk2PfvsSgMzeuW7QLwNKxddQTf1M9RpbtLhZiXIA7xh66QDegwjHDBFL1KMepuruYnv+IRwmY5lVqe7POQ9ZkfFpmtyG3EkOhSd34EkYvRV2C8AFRBJqLQow2yNzP1eCUWyqfUSqnV6JGGLSSU9w3UuSV5caV3K/3PC/UypQQtUqJnJanEAJa7dKDXbs0ly2YrwoFxkTxrnoVzkpykUD5HpcrTViWqOopVClMybY94/5Q1x/YveKM7eP3KUX25pJsSPmljyuMC2g0WUKCALXci5cO4mbXKuuaIRJWQDJg/HI7Adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXhv5ATI+xMjqJAAzKM1ERIOu5JSvfen69e/Rm89wNE=;
 b=C68FTJK9UeXC0Dmhle4w2dT/sLf23tQCo7D9tW6iWWb+Ovgr096XEGAR4xOaS21eyUToZynkOY9jDfd7GQWJ7evqQU6nv+UDaQY/EVgvkG2WTp3G7ZAU5Chj/WKMPrZrMZ98DcXNfnicHbxtQgomcnceZkMXXFbGHwzNwyqW9qlj2bPiMe7bDbZ3s5XDURwcudX7qMutfHj43gY6tlM1TqKtSIy2CM2X5n2UFPP7pkM4WJWQnUOM0YUR+iH+MXy61XcI9GwfPjqIkw45q/IXWx1aOitF/UEJCRSM6z1wG/sk9YhgLGoDR68WQIoBNr62VCTF4namrx2ZEbyzcyiRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXhv5ATI+xMjqJAAzKM1ERIOu5JSvfen69e/Rm89wNE=;
 b=ulHLEQCYa4T41w4aH7c15aMmUsABPBjfmUEc0h8yoz8oqetXgnOiD2ErM+VfHNNHy+O8PVdQwHCWwEH1ye9xFkvXRaIXtcstQz++EjpEzFAoCnoGHaMP2tZgTBPHe1hMu8PXDYp5w6n4K7m1OUKKw+GSKAm3QL9TW/ezlIdNKRs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Mon, 9 Jan
 2023 18:23:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6002.011; Mon, 9 Jan 2023
 18:23:49 +0000
Date:   Mon, 9 Jan 2023 10:23:46 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        songmuchun@bytedance.com, tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 8/8] mm/hugetlb: convert
 demote_free_huge_page to folios
Message-ID: <Y7xbsnYSM687X8pF@monkey>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-9-sidhartha.kumar@oracle.com>
 <Y7jGyH9Atv3sPjcZ@monkey>
 <Y7jLVJ9kvBFCUhNd@casper.infradead.org>
 <Y7ncSXYzCmjzmS87@monkey>
 <0b711878-71b0-4a4b-4f0b-af157d6cac42@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b711878-71b0-4a4b-4f0b-af157d6cac42@oracle.com>
X-ClientProxiedBy: MW2PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:302:1::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 009c141b-e17b-4068-79f1-08daf26ea73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLRTNUx9e+E+7o3UoWmM2CStU8hiHvriU3Jy3S+N0q9GbGZ/vEe0SS8nkdRpPlLAxPdgu6nAEAjJ/Sg0AIm8rWUbWsd2h0i4yMKLldCwvsG3onn897orkBFAollFd8gjI5FOtcyf6apBD7UmMcT0KKjBgYqYd6upI+cRbkEGCmfw7LFwb1sRc1s/8Zte+Lpj7+bE0wlNQstTByCqlSGPRFexLULle+6oEeuExQsg6b55Uoxa+9ErEGh/T2PnhJuIVxO9cwY33zk0iqazrPuBbawDjYJy+bBo8ZmTIms1MIQ43xNwlNvJVJ50qtpuZBGo0DKDfHtN7ZhWStxmwJ5p94zX8V4MGCmCCSxGA74sii54gXlz/UokGk/DtNAS8ft90Oaeu9mwFdwaYQL6N2Cytgz1jwfQtTyRkyvji50MhFjZImGnBzg7FLFngWEJk9clC1PXNmMX78yzeloRyyApN16ynYBPhJBPdCpVWM+rSw1W9sgbgddMxx57CEb+Nygna4cmKWEZ6b8fg22AMqt0hUU/ONwffoK1HWpxPnLpDItk02egUx1+VacgBde09caYR2mADBRRd/58M1yXshtX+w2Fr2hrX46UKR7teuO3UlZByIo/LC4OZv2+r3gbxzWaKlmA8p7IoX0GWGzN21FGB1pZU4onu2T6yEUU6bG1WPaqfLzpK8jkviZaaVokAeiL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(86362001)(83380400001)(6636002)(66476007)(8676002)(66946007)(4326008)(41300700001)(66556008)(38100700002)(6666004)(53546011)(478600001)(6486002)(6506007)(26005)(186003)(8936002)(5660300002)(2906002)(316002)(6862004)(44832011)(9686003)(6512007)(33716001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7r9D7q3wVKkO4retObP5iMXb6Pj7qHpX7jb/ptUJqTEl9tD4NWmT4ZAF9Mh/?=
 =?us-ascii?Q?4DOABnAal5vhcM1NmL+yXrLA6YIW6+ZOzZC4jGxmlisXhW0Yuu+yuIcN7iVd?=
 =?us-ascii?Q?Xn3odKodzLiU1PnpBKgUW9UdY5uICB921DHFZ4owSVyYmUW5X5xNX7wTU8y8?=
 =?us-ascii?Q?u9LF1bg1v6zCi7RI4WYyj9OT1Asv5oVJ6MdnRz8NiF6VV9niZQAdrxln/0n+?=
 =?us-ascii?Q?Iad6blIPF3oAg0KY5xfHKJwDnNCfkGhAaKdNBWhZ4ud2WXRr6/ng3XqqaIM7?=
 =?us-ascii?Q?zNT3a6ctyTC9zIh1dCvrz5tqeWAKnmcZT2SoX15wcE3bktOvmVletLfAd0hN?=
 =?us-ascii?Q?rSgYmzK7GqmaEBWPvLm+diMz45t+IknmqZ4cTO/Hal42vD57dKmzuHv9WtBK?=
 =?us-ascii?Q?8ZhbDAovaEImvJNWT4KGubCuJLTlEzvnVsPL4cB+Of+WV3iEmms/2aQ+ssHl?=
 =?us-ascii?Q?s9igugBhqeKgVGkS9E2oTHwtgtwTxb37OFJz2KFBvKLzHBpycmd3Uk5J4KoY?=
 =?us-ascii?Q?f05UxIQZB2yyE9WrtGRq952+hxnlAp4q6HuC07vYbgRQQP+o1UezNzjVY7/O?=
 =?us-ascii?Q?2Y/qUo9ejKvjXNLFaECdNuwk5JWrU97eIdfhiubMKiGUgmKtvw8NHhyS/Q3s?=
 =?us-ascii?Q?xMdjIE0A04Zl43Edb09UUSznKLoueWJHIIU9l65gVOtzJ6RwHwj6FBGhSopz?=
 =?us-ascii?Q?wHCQ7hXZJ5azBZ9t9CN2iGhjDPBBtyRJYnrRFZ5jV2dIPHIVLXaUxcC9zM+v?=
 =?us-ascii?Q?T0hAPHjz3WjZCTg4xG/HQb9urqTmE8E+ELXVaM/aUTA79zIBh/Yx9DWhLWCB?=
 =?us-ascii?Q?Yaon6LBwzK4GcWnSR+nToUl/Dv2JusGau3BOExh57WOTXc7KIqSk2rCwSNhC?=
 =?us-ascii?Q?WxtMquXIfBNZzbunWwsTZg1XCvmQYMZO03QqfqOWUNLoSJJslLFW4kGSRcvs?=
 =?us-ascii?Q?8zWNIzJwqgfYugqW63oHpTwF/SdNEZmoeXpDmf9XHUEyjYUvNoi6Z/rnvJnM?=
 =?us-ascii?Q?aRcZ0efT9UViKcbywSQlQRq0tK0GNcXzhwjAFpMi9fkGtzkWyk5TFFLHue+z?=
 =?us-ascii?Q?/MWps98ulCk+gQX/bD+AB6kn2QjgVocjayDE3y9WVAi7ifjXjM3QV20d5IO8?=
 =?us-ascii?Q?P0GYeAwMHo65TpilZjyjNrevi0IA5tWzEeM12mCx/oW+OZSI9mxG+nZ9tJ83?=
 =?us-ascii?Q?J1hPKXu1JlHbfQZaccZjAuhrWYwtuGIwQTBkqCook4/pTG+Jd9LTjtQH6tSR?=
 =?us-ascii?Q?whcmJ1f1ToKU1E5Z2npbltfFdvBv3fAYBxEKazP7MKeEn9wncV/h8yfVpqIC?=
 =?us-ascii?Q?I8Rfx5lF9pPqEPzbkv5gDOkB5ANivJqxn3nZVA0JAT5BhLwAIx8krEjn/xJf?=
 =?us-ascii?Q?uIsIEyBO3hbYeBxVzteWTDGERbvoS9Ij1rdGLwwfD9aAUVOrqnCpKWBMQeqY?=
 =?us-ascii?Q?0tY+ovYeQvjG8Iy5497LzrR4xseU/8PlWCUlGyaJr0UkSdQq0uOHQI6WfNV3?=
 =?us-ascii?Q?DT5PuKhozXKe3S9xQeeBUjM5Bgyq6YC0iwGTVMquUKxTpnaM/TgGyYxT+JhH?=
 =?us-ascii?Q?EsGJ7PMrAn3yOEPxk74i1N/7oVrig0idAWifyRZF+HWxTbhPYOcGcUFaGeb1?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OOH02rLFuWYcirgyVLKTMzD5HM2wf9P431Hi7bwsmneo4GOJhHNNExRA6sCb?=
 =?us-ascii?Q?PgixSr6dcg0sfRqNr0U951SbSfOQSBFVyMEBMh3/n4xMdGb05lRwOLXxQy6/?=
 =?us-ascii?Q?IWvkRxVp1jc0pZ/UG9NWPOHcrNeuBEWqKGgydNj7UXUWeM80JXw5pNZ2Np5C?=
 =?us-ascii?Q?zKk9pdPw8zwQWQTiepgv/8yoH9GtvLgT5K7VQVzBjyYeant34V+n7I4RZa7x?=
 =?us-ascii?Q?6xomc8asMnXB0815DsTUWJnJU/YfP6g2odVmC3G9+7fvhkcSTyrYYz6+3xss?=
 =?us-ascii?Q?SLRdGdg1xyyEtUJT2hAUIa8cJ/45CWE3wRqgeeJmPulMaj2tOOFME9rI7Fuu?=
 =?us-ascii?Q?MIeNUcRypshDMG+1ivxNI9vjLAXv3a5HBsyxISzZ+zhqF8iR5T90NEY7jZJR?=
 =?us-ascii?Q?2i92d3ZVgBFlw5AwdxgNr+cdp6M3hjGUCIoga2EVjWv2p6wfoboABPr6jsCK?=
 =?us-ascii?Q?LkpW2aRlqkNyJLm8p3vY0+N1dZwMXuXep1efW2SnGt/8sM09y88ZY8Ghgoyl?=
 =?us-ascii?Q?cKylXCsMSmpRU4EIooDJs1sWge7Hffff7NgkX449XNtH+/C7Kl18CiuAs73L?=
 =?us-ascii?Q?UHDeSRHz9DzSb/H3WhMUXbxRmv7hWZ7ZY2p3dRsWqhsleVQkgdvfBEVGehWd?=
 =?us-ascii?Q?lu/EY4bDc6tZUEku6tmb/K/bI0j5K0cm59QLxu9JW9z7P/Rtrh3FwmWmAwVk?=
 =?us-ascii?Q?kUJPTiFWe9o90oyjYmbDr1d53CqkVcpCV6O/XAxj3Xn7scLk1XQIdF42uyXt?=
 =?us-ascii?Q?1YYFjPI3PZmz0xnwLor9xJ4qXfNQdaNBE50em/W47cmEe6DqxN5PKLViViyj?=
 =?us-ascii?Q?zTUIa8CrxVi5ogdnzZOveUDrE4p86GjnOoFD+IcxZhWg0LGqmcLSRolMRht6?=
 =?us-ascii?Q?lKx48QHQ5O3sEjEZcyXZZ7I5L16a2r06Uz1HlVxVWp7Si2KvQdG7igM5wpAh?=
 =?us-ascii?Q?gIpYbubd2tocUjUC6hi0reVJIf5bXbp4Xr311BK6zpc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009c141b-e17b-4068-79f1-08daf26ea73b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 18:23:49.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xl4oOhICLmsM2HoTT7X4nwBsp1DLUx6FQb8HkbpIJWu5xBI56cKpVuFCdxMXXnXVgTPNUpbbvcmK+S4bphS/4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_12,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090131
X-Proofpoint-GUID: khyt0lhvYMB5tT2F_9JzGG0YTyTOI-U0
X-Proofpoint-ORIG-GUID: khyt0lhvYMB5tT2F_9JzGG0YTyTOI-U0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/23 10:36, Sidhartha Kumar wrote:
> On 1/7/23 2:55 PM, Mike Kravetz wrote:
> > On 01/07/23 01:31, Matthew Wilcox wrote:
> > > On Fri, Jan 06, 2023 at 05:11:36PM -0800, Mike Kravetz wrote:
> > > > On 01/03/23 13:13, Sidhartha Kumar wrote:
> > > > > @@ -3477,15 +3477,15 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
> > > > >   	mutex_lock(&target_hstate->resize_lock);
> > > > >   	for (i = 0; i < pages_per_huge_page(h);
> > > > >   				i += pages_per_huge_page(target_hstate)) {
> > > > > -		subpage = nth_page(page, i);
> > > > > -		folio = page_folio(subpage);
> > > > > +		subpage = folio_page(folio, i);
> > > > > +		subfolio = page_folio(subpage);
> > > > 
> > > > No problems with the code, but I am not in love with the name subfolio.
> > > > I know it is patterned after 'subpage'.  For better or worse, the term
> > > > subpage is used throughout the kernel.  This would be the first usage of
> > > > the term 'subfolio'.
> > > > 
> > > > Matthew do you have any comments on the naming?  It is local to hugetlb,
> > > > but I would hate to see use of the term subfolio based on its introduction
> > > > here.
> > > 
> > > I'm really not a fan of it either.  I intended to dive into this patch
> > > and understand the function it's modifying, in the hopes of suggesting
> > > a better name and/or method.
> > 
> > At a high level, this routine is splitting a very large folio (1G for
> > example) into multiple large folios of a smaller size (512 2M folios for
> > example).  The loop is iterating through the very large folio at
> > increments of the smaller large folio.  subfolio (previously subpage) is
> > used to point to the smaller large folio within the loop.
> > 
> If folio does not need to be part of the variable name, how about something
> like 'demote_target'? The prep call inside the loop would then look like:
> 
> prep_new_hugetlb_folio(target_hstate, demote_target, nid);
> 
> so it is still clear that demote_target is a folio. A more concise version
> could also be 'demote_dst' but that seems more ambiguous than target.

I am OK with that naming.  Primary concern was the introduction of the
term subfolio.
-- 
Mike Kravetz
