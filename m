Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6862F74921B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjGEX5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGEX5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:57:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E91199E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:57:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365Lubne006304;
        Wed, 5 Jul 2023 23:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Oj3bbXx8FWzdspXfN7shb+jtp41CeTINGj3wjk9cEW8=;
 b=uggzfDeL023txlp6tZ/vrZbpNKJhiygZJlXMfuJl97mwdaBBukLCTn+Wvs6oaCW6dpFb
 bBYTiOptUFbxs4ky/qnDN+LbfFAt4fN68Rmk1rK11DjH+FN3OUN+eKtahdYOoKKQjHSW
 NycT4F5N3jU4OVfB7teqKyt5Q1H7MJlVdSCJWeeviA1kwSjX9ROe/Esl8kIHOwj5dItW
 VfScaG0tsPWFHSXZzMvwpFA4JoE/lY9ntIVhxG8vtL+hmu7lvdZZwFcAqBvt4rgA3Fym
 UZVNBVIBCi9UOcMjSv0m9+rW8iRE5beslVFUK6oxgaLT2l5azq9yt4Fo98j8g3ZT2fmt IA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpufkrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 23:57:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365Nb0AQ024611;
        Wed, 5 Jul 2023 23:57:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak6qvaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 23:57:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeqp1tgpgTOOfNjBB85/mQOJcVIyk1R8rDClwHlqk4JFpFQL4TU2TueNkjuC0IO58NgO+9X87/1+R5ZZPs369gORaa+yBYlyjKrqN3xl54SX3XkdgYhblLtqswpXcCIIOH2i8XHwk/AGLE3QIi31q2NriWsqCNpmMvItDIm8n6wPNCygNqLdoBf05UxoC8ZzsC+bQYdC+kIL+bfZqXHZ/d5tBWdgvv5uaoNOD90wzycE65VlnY8oRLStSHJMNeT/mcmW++unIoHb+pkDEsLtxq7uHTjAWYwqTQX7Q6KeO4JwPUAa71qJYxrGBOLKwyKB+y3SPVmdBJMp1TRsZAxc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oj3bbXx8FWzdspXfN7shb+jtp41CeTINGj3wjk9cEW8=;
 b=Fr9Mpyj5qTu/R8HOTGbijiiqivTTnsxK/cj3n/J7abOxFX1Wad7D74EzL5QQeh27myodDAbdtZZZ9daRghiBAselP/KGgrfhvW/I6FPPLOa0IkhLzCOzG8RO7lnh6j0Yn3V9a6d3IuxKewXmJTHeSX3VRfWCIKisHzvhvOP5zv3nbz5tWf/SejIHPCFunEPHqRGGK5ZeraGfS1glRCc5J+0XQ5FvEuzX+/baJm+bY9sPc1j0Vb/CXdH/fOkZSSxbys85USLzV5vpU2/Xdzu8QCjs5eDoFn7zsEvhO+NWOorzPSyLG5mABP0KPuCbX9d8VNbk0+YZPDCJULoPrAA9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj3bbXx8FWzdspXfN7shb+jtp41CeTINGj3wjk9cEW8=;
 b=vjM2H8UD2Lx17GHH4W+FSW13iv//ZPZq6jKFISXsNJZpcDdyNnsoZ7NBa9QpjR4t7B6H5mnCfwtIl7xEfTNnvSpFk1LFVWtZTU17OjsSIPkupWCvgJ2Ri8QNdqrCQQcHNK0ATbmEXuiPOLyGoJGbyJhP0Bi+WbucgKeiD+tsppg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6064.namprd10.prod.outlook.com (2603:10b6:8:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 23:57:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 23:57:08 +0000
Date:   Wed, 5 Jul 2023 16:57:05 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 2/4] mm/hwpoison: check if a subpage of a hugetlb
 folio is raw HWPOISON
Message-ID: <20230705235705.GE41006@monkey>
References: <20230623164015.3431990-1-jiaqiyan@google.com>
 <20230623164015.3431990-3-jiaqiyan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623164015.3431990-3-jiaqiyan@google.com>
X-ClientProxiedBy: MW4PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:303:b8::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8adbcb-78ee-48c0-62db-08db7db38aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0S/ITK4aDBnr9XQK7pV+fUkG45UyZrXIXv6oRuiYn+K3KEhOybRvRZxan+OfH3rlcYUInZMXQXOfc4cnai27hZ5Aqb5GyzcWZNUFD6Nv8yHhNIB7ui3SUrXRbtn0ZfMEwRtqf4PRIaG2OXcEudkii22Vtd1hB0kxSuFk9nP1BXk6UPElyUsXHBguXdnmC77H+GZxr16D03Z1+DyjM6Nde9u1hERCQ3XMW8e6MbXCpXqmPSLtRjodRDx0v/YKSuKw9dDrcfSKAFAnOgIO6n8WA9PEIa2ga3bRnQFi2gSX7kXseFWUYhRT/Xi+QNrYxq1rSEKnKAFsOnEO26nt/sQHwcPNx73vgDZmTljWlPIJ/4uXPLOqcmT75wPLQK+GjnzZDMtdLbY9ciIC2JR1VnQb55+/MAwTBchmtloFLkFBEl5x0oJUZ4R+aAYV2FCqw+wN5Za4XuphThGO+N59/3CUa9lRRsuLnu5B5etCWDifvqAMtZ3SMStIzroIAoY8KidrJ0W/oaGxHgOW5YtKDEEL09GT7Xgmvf1Q+jfWz1hJk6vXY5t7rhzjmMjx56JSZGw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(6666004)(478600001)(6486002)(186003)(6506007)(26005)(9686003)(53546011)(6512007)(66946007)(2906002)(33716001)(8936002)(6916009)(4326008)(66476007)(8676002)(41300700001)(66556008)(316002)(7416002)(44832011)(5660300002)(38100700002)(86362001)(33656002)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wOdowEm+W6hEmbJrOxzEEHAC4lhLZ2+4EvK0C7y+BHKHLdcOJadnN4UlpjOs?=
 =?us-ascii?Q?GUUvBpO86BrSlshQdbEsaaTpEVjww2AGtRHNF6Jr0DrIKEDlAkUhfrZAk9rk?=
 =?us-ascii?Q?QRhdaRMu58RpbxWjbxBWnQXz/av/kfRMv104KaZKzHqKAdU5ODYe+PY6Ajnb?=
 =?us-ascii?Q?75Cud04V/y1io/AucEMkBMdW08U5DCf3isytxIAEIRtmt2nH0QQuJWaai2l+?=
 =?us-ascii?Q?jT5LTuKmRLMgh53hKoL5e6vtOMP3K5wiyzxMm7vRl82DU8swB3CYTYaqEwqE?=
 =?us-ascii?Q?//cDjARRU1sYgBhigo17ZtG8dGZSUcfE4j6BsgqeE+K0NaR6hjd8sfHhZZAB?=
 =?us-ascii?Q?LYcFRGNfVyrkK8d586HmOqIzsNBe4GE9ZofZPIZ8yj54x9fOtp/0aBcpWm9p?=
 =?us-ascii?Q?JzbAB283iuIg/tvtPNPhaQuOW7HrzyDDkUvRJ2XEitrnPzT9PFvS8ckgRD9/?=
 =?us-ascii?Q?UjzX2DI731mQgeSW+yKi3IDnuwoS2utVCLjWCX6sGtjhoqvL2wp/lXKUz9e8?=
 =?us-ascii?Q?Wf3R/6gkIJQcvkq7EbZF5JwpICG3ybXhxfMiZEGJZnm1IMZKsLlo+b5qrRc2?=
 =?us-ascii?Q?Dw4E2/7HFqwn7Ox9pi8kKQtlfjYDDwz/Tfkz1vsrB2mTOGDK5a+MkeqLXU4h?=
 =?us-ascii?Q?mmgSQ25u2hfd+ci7hiVkBi66LjbvCmXuRdEjS+tqsMxwq5gr/BeN3dLpxlnN?=
 =?us-ascii?Q?HtvhHqYD0a6zGRVXTz3g2AFEtCRGPgFPVDzFMRUcq5JwKPDxAW95Hjn6Ecfg?=
 =?us-ascii?Q?fYcujbrD3GAvOCjYkFWiKuVY8UHZHE20lZWyXY0VOpD6tb6Dx0CXQ4QQLWJe?=
 =?us-ascii?Q?5GdxL7i4BE2VQC76HreqSqNQgyTLZzQ4BMcf+DCNdo2ghKYMRy8OyyKpl90D?=
 =?us-ascii?Q?Nkp3FakOzeQ1E+gGrDUCMFLVYj2D3u0WxfFb0vc4dc7k4hopxh7tw7BhgTrh?=
 =?us-ascii?Q?1HT7X68fcxrvZMhxJ3quz3aIhs9u9RUkY8iVf2cIURaoW2g/EcnRQyxCq8Pe?=
 =?us-ascii?Q?0tITn9GBRlLEF48jljpBfLW/OKYkcTG0JlREffdSkTZp8b9sd+oJj55ipd2m?=
 =?us-ascii?Q?rIR1UlEeRKobMlcUdowiPy3ZLCoLc2/3Nk1VEXhU04pHNCALPbiHS18OaQ6z?=
 =?us-ascii?Q?HLIWZkWLuB2w75moRxCzCZmUxwoELtXCAVuSvCjKaHvDzqoITjask9P7N+gM?=
 =?us-ascii?Q?CTKlCF31g7MzSQATKAh03hNBO/g/yZnyvi2Yz3EajvF2H3QTRBBLQvN/pEZy?=
 =?us-ascii?Q?w9kF7O0x2CJxIdh83D/Jj6vl/Wu6tL1j9p0mUhMQt+CUULAzHeVX2spZQHn+?=
 =?us-ascii?Q?unL83XR1FdKbNjlWNFqQz9lnXGJuV7oXtfGtSQV48/9o7EIhvpqbbNWNr+X+?=
 =?us-ascii?Q?KazH5lBbOp2vBurL12UEKbWLF0DuBh/PfVfpk/k0PMpOTRodV+HuNX5YJUJQ?=
 =?us-ascii?Q?i+6xiqPbn3tH27Kd2n5hTf0bNCY3ii7wfIaH8mGpeeP26EXM/Egvoi0Lg4oE?=
 =?us-ascii?Q?gjz3fbIiTpD+/mnGil0tWNyJp0+yOHw1MrIdFwvHBhAnZoqdmPaECelQhYbQ?=
 =?us-ascii?Q?EJbX/aFvbKEoarcFN+s9ABtIb0GeCiEeL2XZ29wIo76xrRaVsRkf1seWBlW7?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?itzAEnum51Lo8h95j2LPxENYuTS0CYEtVm8zZcSLiuT/2UkKRRa7bNCbbELv?=
 =?us-ascii?Q?rrxZmy4qCOT/3j+PfD30iNXr+rKplUJXyngapMwt2ed11ulF5+ygInC52mEl?=
 =?us-ascii?Q?IN/47Tu5TSbrdoW2NFdYFArsTo4idHsvfCI3ZdFPcY8WQC8h/uD3BMRhfWeN?=
 =?us-ascii?Q?l60SJGOIEqCACj7jxgIQQ982LgxDhYaaGcLY9pDkqh5Q4fFiJ+uZnOKV3uOC?=
 =?us-ascii?Q?Q2C9oofR05kY/Ig0DrHdQw8fZhAFQbN/8SAGsdWqfZbuvulDdOfLfwBOQQgW?=
 =?us-ascii?Q?7TftFUrFeEDK+13maXQugV55p/gxf+wtzmtLeCTA/0U2MzxR6xs2bEu93bAX?=
 =?us-ascii?Q?GpBcoszJPYEZIIiH6jAPEOlKqWSFuJ6RSIVS1v8S5MHdFjJGkJ3dH9L/CAGQ?=
 =?us-ascii?Q?bQsaCzKh7rMrz2dvsDF7V/hVqRix83GJUqijNlheJ6gVhPtHrZDNQWBHaJBY?=
 =?us-ascii?Q?niM3DpBXBlJad+GL/VGnLEV+6Mn/lpW0Ai067U3kZRhCobgmQeGtHYmlJIBt?=
 =?us-ascii?Q?af7D7FXN3SX5mK4njDTZDSowj4pClJltbhaqOKF/b7TVSthgh/3cdT2cV2qs?=
 =?us-ascii?Q?/R9kzQrp5Gjk2IYYCtQl89LXhDgicaG06V/aJvawFMP9VNrpLhX2OMw3ZD0f?=
 =?us-ascii?Q?JEz1WgZNo5iEBMEhnO/Isn9hYGyI2R6FN7LAzAF48sg7cdigkom4qGh6jpbB?=
 =?us-ascii?Q?MQRLl8XhI220HeQmAUxxFtyzrb6QjDMjmgdeUghj6tRDuezE8cMXol6ByQzf?=
 =?us-ascii?Q?202vebUFBdrr8yXsJpdYJZO662eB6zo/u/YXMBLx7r4K0bTMt4CZPxwBKPEK?=
 =?us-ascii?Q?hf7dyMlXk8YIQnR0VTnHj0G7EdQCkU0go2ixY2Vah96mklMG4HPr1N0B1pY6?=
 =?us-ascii?Q?96UHrtUhRCYl0fTZK6e988OgH1GY6dGb9ytKPFDEm3/HJVdUNotDfTPomc94?=
 =?us-ascii?Q?dVtkG3mHl7dBp4ygC5wLZo6XgGLIzNjLuzUv7wxcqyk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8adbcb-78ee-48c0-62db-08db7db38aa5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 23:57:08.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68XVbomZZzPT4kUsKJlu4Vp8gRAPOFFEJ0OlcRhmgDtMhjgcNq+JH3amBkq76W915++69z0M1QkBhYL5a73wrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050217
X-Proofpoint-ORIG-GUID: TVJgKuYCpupr5IdsHj65_m-6zHjQqCh4
X-Proofpoint-GUID: TVJgKuYCpupr5IdsHj65_m-6zHjQqCh4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/23 16:40, Jiaqi Yan wrote:
> Adds the functionality to tell if a subpage of a hugetlb folio is a
> raw HWPOISON page. This functionality relies on RawHwpUnreliable to
> be not set; otherwise hugepage's HWPOISON list becomes meaningless.
> 
> Exports this functionality to be immediately used in the read operation
> for hugetlbfs.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  include/linux/hugetlb.h | 19 +++++++++++++++++++
>  include/linux/mm.h      |  7 +++++++
>  mm/hugetlb.c            | 10 ++++++++++
>  mm/memory-failure.c     | 34 ++++++++++++++++++++++++----------
>  4 files changed, 60 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 21f942025fec..8b73a12b7b38 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1013,6 +1013,25 @@ void hugetlb_register_node(struct node *node);
>  void hugetlb_unregister_node(struct node *node);
>  #endif
>  
> +/*
> + * Struct raw_hwp_page represents information about "raw error page",
> + * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
> + */
> +struct raw_hwp_page {
> +	struct llist_node node;
> +	struct page *page;
> +};
> +
> +static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> +{
> +	return (struct llist_head *)&folio->_hugetlb_hwpoison;
> +}
> +
> +/*
> + * Check if a given raw @subpage in a hugepage @folio is HWPOISON.
> + */
> +bool is_raw_hwp_subpage(struct folio *folio, struct page *subpage);
> +
>  #else	/* CONFIG_HUGETLB_PAGE */
>  struct hstate {};
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 66032f0d515c..41a283bd41a7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3671,6 +3671,7 @@ extern const struct attribute_group memory_failure_attr_group;
>  extern void memory_failure_queue(unsigned long pfn, int flags);
>  extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>  					bool *migratable_cleared);
> +extern bool __is_raw_hwp_subpage(struct folio *folio, struct page *subpage);
>  void num_poisoned_pages_inc(unsigned long pfn);
>  void num_poisoned_pages_sub(unsigned long pfn, long i);
>  struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
> @@ -3685,6 +3686,12 @@ static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>  	return 0;
>  }
>  
> +static inline bool __is_raw_hwp_subpage(struct folio *folio,
> +					struct page *subpage)
> +{
> +	return false;
> +}
> +
>  static inline void num_poisoned_pages_inc(unsigned long pfn)
>  {
>  }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ea24718db4af..6b860de87590 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7377,6 +7377,16 @@ int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>  	return ret;
>  }
>  
> +bool is_raw_hwp_subpage(struct folio *folio, struct page *subpage)
> +{
> +	bool ret;
> +
> +	spin_lock_irq(&hugetlb_lock);
> +	ret = __is_raw_hwp_subpage(folio, subpage);
> +	spin_unlock_irq(&hugetlb_lock);

Can you describe what races the hugetlb_lock prevents here?
-- 
Mike Kravetz

> +	return ret;
> +}
> +
>  void folio_putback_active_hugetlb(struct folio *folio)
>  {
>  	spin_lock_irq(&hugetlb_lock);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index c415c3c462a3..891248e2930e 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1809,18 +1809,32 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
>  #endif /* CONFIG_FS_DAX */
>  
>  #ifdef CONFIG_HUGETLB_PAGE
> -/*
> - * Struct raw_hwp_page represents information about "raw error page",
> - * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
> - */
> -struct raw_hwp_page {
> -	struct llist_node node;
> -	struct page *page;
> -};
>  
> -static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> +bool __is_raw_hwp_subpage(struct folio *folio, struct page *subpage)
>  {
> -	return (struct llist_head *)&folio->_hugetlb_hwpoison;
> +	struct llist_head *raw_hwp_head;
> +	struct raw_hwp_page *p, *tmp;
> +	bool ret = false;
> +
> +	if (!folio_test_hwpoison(folio))
> +		return false;
> +
> +	/*
> +	 * When RawHwpUnreliable is set, kernel lost track of which subpages
> +	 * are HWPOISON. So return as if ALL subpages are HWPOISONed.
> +	 */
> +	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
> +		return true;
> +
> +	raw_hwp_head = raw_hwp_list_head(folio);
> +	llist_for_each_entry_safe(p, tmp, raw_hwp_head->first, node) {
> +		if (subpage == p->page) {
> +			ret = true;
> +			break;
> +		}
> +	}
> +
> +	return ret;
>  }
>  
>  static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
