Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE04872A1F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjFISQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjFISQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:16:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3943335BE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:15:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3598sG57014618;
        Fri, 9 Jun 2023 18:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=51HlncHWPWwzJm8x58udYapJwCBeryBGIw6qcLHvhro=;
 b=kQzqjet3XHRBoSFDOzROcNZE4dnQEdiQx6xqflS3P5GdLApIOn67HmLWnSOMTDNH9RL1
 rxUBbfNdO5i3s21SVF2GDDjEWuYmztk/N+HiLurQ2LskcVk9GnclfQfYRtI2vNqgbUtk
 /xQu51KPkIGjSweVWKfUr1IsA+LK9r2ToMhfcpRLIOsJQpSjMjBQSkuZH34XFYxvREJN
 KWH00544aFboJUEKAD6obCf54UyYe35p4Fi4y8uiFA9Tn73YtpFzBAsPDwrh6QLl7hAA
 uyeRgL8YZAbo1J4QPC0koRaNAWi5ocsL3a6VgXURNOD+iY/Y66w8czzXjw4dHehhW/52 3Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u7828-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 18:10:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 359Gj4Ga015748;
        Fri, 9 Jun 2023 18:10:44 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6pqkks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 18:10:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCA3xoVAh/lxHQuUBUDYhdMqjQ/NzP+8xiGBgj8pllNeNywwd2TbhO9Qooil1xEBM6fmdI5yrfsOpTcSTRJ2cZjCGbigkuJdMDUO4mMzjpdHHuzZkeN/7XK76mGz5jT4g7rdtQsbeh3ZWU43O47z5wTHNepzUnoiER/UxBut6LE/Hfq1MhZPp6HlQowUmavnyCSy+cZT9Q217vDAoy49PdnULE/qGgetTzVqkZ1rRaA4UTu1hMXsfEIiedMWxsrXyXRRXmvPJ7cJgYRksH39+05Rd2SNdVxNUT3oGna+3rMQn+6hu+vqUZkubrXh9FHe04H0YaTJS6i17M2kPu+YFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51HlncHWPWwzJm8x58udYapJwCBeryBGIw6qcLHvhro=;
 b=dXKUK75b9QXp95ISsdxCh5MTwi6JYBQDWMDlqjDrdhSNn9khrUBiWNtv5Z+K9IEN/wu2Yb9Xds18LdOr9SLv4Wo2V9CSUq74/3eGK04uyLEcZ8KQuqbGRhtAcQoTyQsXyVfQUXdzoqfL/mcpwedAdjsslvhmKF/O+LwQGm+uQtX2anNUNb8o8u5eCrhOmfAJMAmI+qC2cGToVuF4Ji8uOi3lRNTB8+DxOhmuNUV2n3qOJEoUi4EeWdoAeXH6VB2fPD32C4X+kICFL6riJl3lE821jlGMuJjFYgW98+Y0XqgY8EOsqq4MZ3SylhDbATWFp/uXubDp/fwZKOUmEqEE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51HlncHWPWwzJm8x58udYapJwCBeryBGIw6qcLHvhro=;
 b=SX3x+alM1T8gW923STSDn78c7wDrAdNnYAXpT3KsEqjp3GLjYH8aTO74Atnmj48kok48zZHA1WHv0AuHYfOkIhrrkPCNioO6vfF6DJV+G/K2HwU3f0jvpG0kyrPdE1/tLPZ+kxIPDe/1kco/mXVg8OqjtrMu6NMD2F89QK+jLms=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7396.namprd10.prod.outlook.com (2603:10b6:610:144::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 18:10:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 18:10:40 +0000
Date:   Fri, 9 Jun 2023 11:10:36 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Tarun Sahu <tsahu@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, aneesh.kumar@linux.ibm.com,
        willy@infradead.org, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com
Subject: Re: [PATCH v3] mm/folio: Avoid special handling for order value 0 in
 folio_set_order
Message-ID: <20230609181036.GB139487@monkey>
References: <20230609162907.111756-1-tsahu@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609162907.111756-1-tsahu@linux.ibm.com>
X-ClientProxiedBy: MW4PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:303:16d::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b0b06b-93fa-43cc-f969-08db6914d4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cx5c7IZeWE4FrsscZ/06p91e1LVVfLeXTDlh0qTNh0et1ayPzmXn0i8/OAGmGjmK0k4Ny6weIgYgfAxi5ucvk3q5X68pa0bh+vmCykVG8mtjLnQCek5WQ3zIJ3ZvXjj681zHbN28aAPdOnR5QzuPtKeO6rRc1iwJ/m343I7U2P+2cfeyEhy+ZHKZch4N0OzLf6v8u5/GgTHxJhknYi6auriJZVMp5h6areOzH6K1JIiUSD1zyCwtdg4yJ7+mkOMKrrrxoASab3BgFQS6VyDSqlwj3/pCfnKGRjEH5ZhRt7TnzLZR1Hk+DsjxCUOAS/MVoRay1J7hRQzGitl9wRQZUM6g4wm7mgx8xDgs4mcQpNVV9mHLtXlLm0D1BaICeR+kNZLdeOXE0d9rChhln2TDHJ0TZLrkAqcoLYadcJRoYI5yzAZMIcvSq2HDzLzmtvL0fhO5djbIYNx/veOh6g4/c+1ZlY+w4vlwDl0jCXRhQtyyIZNnBIwK9AyQIuBPo/u4ofv7EI1UnC5p+XIEGSj9rFQLwQGTW6WAqcVwcBi3UsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(478600001)(6916009)(316002)(8936002)(186003)(41300700001)(8676002)(4326008)(66556008)(38100700002)(66946007)(66476007)(9686003)(53546011)(966005)(6666004)(83380400001)(1076003)(6486002)(26005)(6506007)(6512007)(86362001)(44832011)(33716001)(33656002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DZVvckFwf5EQOug0Dw4p7l7ntpdFXO6Vq29ri/RGz2K0R+42gRSxm9hi+OM1?=
 =?us-ascii?Q?pK8lwPX+PDC3oBAeb4UPD5QGqzUlrbPxDa0JQDQF1Zu0wsnyoWKRMvzOUSzY?=
 =?us-ascii?Q?mrWFQMy8zRG7NxGFCWFHC4YKdMAH7wAlvNI4CRcDg4at8Zf59e3NfKrGgVqo?=
 =?us-ascii?Q?/C+FWVhmLksHpEchphyjyOl+7G7nKIsiPetUPXK90F0E5O0/dN2N9oidPdfT?=
 =?us-ascii?Q?VsNuuT+ruYddlbByvTPKwAybm/kVjSJPTcMrR6dR/ev9AouVN3hwuvyx62Di?=
 =?us-ascii?Q?4byhfu+cQwKHBZ2HRXoBOmKzi4X25OYLsYkkuiyXQrYPkyIWHhlK0stOsZQo?=
 =?us-ascii?Q?xd/8HAY3MrdShejiKErKNiw/8yi3K+zwEcXWNyEIYBHzVFCZgnxGOzn8hcDO?=
 =?us-ascii?Q?sCzytjnYT5kdTEDbD0fTRadpxMzSB3Sf93NdyUz5fDT3gr4YPunPfUjnP+ao?=
 =?us-ascii?Q?JPRi3qjXp3+3O30DEPfi7UPcPaEdvK/1r1Bsegpvc+AW8t55ko0I6TbEJfsf?=
 =?us-ascii?Q?+Op5I8S0o+oY3V8Z45jsH8pkIkNNuij7SY2dJghbuHdd7Bx6MD323MtSrswx?=
 =?us-ascii?Q?mG0rsv6LtWySKhxdN+HNP29v87AfN8PS1TaphImgBSqYHmoOX8qfdHwupE71?=
 =?us-ascii?Q?HZ58bWvAVLN3LFRzUg1uVNvOKlEUxfMeFShTl5NYfhR/XA17ka2eklXFXipb?=
 =?us-ascii?Q?Yk9lBjEle4eB/uT23vPDT7IZaNtXNRTNunqN2/Og+zUx0Y21f8PS/Ngi+SZf?=
 =?us-ascii?Q?2o5rzXizx8LMaNb1rnZX1CtLLZDjI7DNY7ekOwR44DST278aeDMiHXBcym6v?=
 =?us-ascii?Q?rA7X4sq9LYb5irLRi6kdW/xovi1cywrihaxUBu5y4FNErH32RYuga4pxAe6U?=
 =?us-ascii?Q?kbodapO7T2y/tGbiSS2CMU78bNcPhAY+lMGajg1DU1KCmKts2I6PS6OJnWbn?=
 =?us-ascii?Q?oKxZyjHYoo3vO/rB6hlhtw8xX7hwuQIAcumpQCU0MrOdsGmdxhc5f8TJPcI1?=
 =?us-ascii?Q?ExZn7y+/3eD8JAp/SpxWGXRM8aMfUQxQAj3tOoFa/ezSH+dS321G/Yjo/xDt?=
 =?us-ascii?Q?ZiSxQmPxpNxC0spaNH72j61av+q7OuOh1DQQ5XQxLPXo2Ya46d40Y64AD4yZ?=
 =?us-ascii?Q?tVP1zXSgm0IOJF0LBltRjbGCdre8gBTmL8z5AlHe+CT7N0AISmaKV/a0FiVX?=
 =?us-ascii?Q?ud6w+YWVrZSMgSDCx6byvz3p7ZJkx337TZ+LWoXOZptVPEOww8uPpKiELg9o?=
 =?us-ascii?Q?cxeKzJKjLdqJdCO1cBgr0Lry/9wfPg+nz3+N+lUPlq2v6Q5VJOhmsx89mODD?=
 =?us-ascii?Q?z35O6WFRrrZHMmAxog5q4bGkz/VSlIx5/0KkMnqDSNJfcaWzmlU/64Uo2jwK?=
 =?us-ascii?Q?Nij+RG9lnT1m0Jyf3WiQHKNNb3dM1N/8T0aODJ4jd7unntNB3OtuMxXERAmw?=
 =?us-ascii?Q?fzZv9l7F0uiF9Sk/50OnVHvBtiJItIxDsvuZ/zaU+vDrKNPc0s1iUGkCFT5K?=
 =?us-ascii?Q?QTVFzFdDLFoHHUeqbdofQYBYeUzkyius+/TC6hdPR+9HqHmRa+q/uiv7OOkx?=
 =?us-ascii?Q?GxnV2M8J9E+DiZQhWcqRxA9ALUtF4STIkjfHZj1+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kyrGPna6J9Uu6jZ3gGFeI2r1OMmqAL0n1D7PXOtnXiYwTMvRFS1pOtBWQQmS?=
 =?us-ascii?Q?MJxO8DfhSOEA/y0yGZxI40OODKrETV0qEOXPwcGbx4D31FDfmcg+GNTNEWmE?=
 =?us-ascii?Q?hP7T9ElrZoY8fC37MGIK9OEoI2xsb+JIZC/eNm6dsDvK7timzqZGVDUaG1lf?=
 =?us-ascii?Q?7vAXX994M3noVwXSZCGBzFUd7iQ+S44Lrl9qE8dhjqHluKa8Wx0BwTeF2lxG?=
 =?us-ascii?Q?WRl/OKXAsnTj8pWsOT66omyxvgxNj8fypZjx0LtRTdlXuZlSkb13EQjTE+AD?=
 =?us-ascii?Q?KLXLBYGrFWcFVtRtR4UPd09SDxtos081DbzGTRSYp15Gvswtmoiq80qdC4yg?=
 =?us-ascii?Q?VALG4vCnwlBTrT39X/aVqc4vCdFy2WwlZtsY6dVyZsSXwgpIdWu3OHauB372?=
 =?us-ascii?Q?QS5iwXT9xCiugJiY3umSEBxG0HV8I75zPzeZGgpYUF3Sa/lGEwA3kqDAIkUE?=
 =?us-ascii?Q?L4MtHGdm/L44Jm8grMLzQXmhSFRqbIme3IiKLbx+B7WY9CvrJOz6YCDPhGc0?=
 =?us-ascii?Q?7cwGX5UT8KABTBRygI/TznkW0VKqH7cniYsZ3HEGIUkT5BUDTM2HQfg7NFKk?=
 =?us-ascii?Q?vLLgl88azx3gjYYaTtwXHe3Sgtf1AD3lUVg5RJroL9l1arVpp3I91+GXV6Kk?=
 =?us-ascii?Q?huvNJQk2qkpIaQqAvUXOfJDCac61yo1tg+VVmzsYpwWzg/G95uW+g29uFJKG?=
 =?us-ascii?Q?SqULv/WM+SuVCXOEbf+7kExuhq8AbMtem82dWT6jztErWeP3tvSDSDxOi/4y?=
 =?us-ascii?Q?TPJm9BWpCrBo5bI16ELgxaGfmd8TDV2GECL1m3TKm8qASHx1OlX4drtMTWq/?=
 =?us-ascii?Q?awGoOY4VToVRxdIU3KMoujTsNQ9/+wGh3IpqlzWaGTLLdE/LJhpemKOAe2Wz?=
 =?us-ascii?Q?lXpeE+no6exZ2qOmlNyPFSuE+XJjxjZG6MnKr1qYd13PwbNvw+AfwjIjk96R?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b0b06b-93fa-43cc-f969-08db6914d4e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 18:10:39.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsz6F/WNGq1KgYlUmk48bN8dMGElb9/TreBHF2dSo1zC/Kx4QzZD3ZwWhtSJVNhHc8ITjBsta5Rm3Bs1Dme8pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7396
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_13,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090151
X-Proofpoint-GUID: VzOn-hwB_TayxMPnbZV0NblHxIN8Scfa
X-Proofpoint-ORIG-GUID: VzOn-hwB_TayxMPnbZV0NblHxIN8Scfa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/23 21:59, Tarun Sahu wrote:
> folio_set_order(folio, 0) is used in kernel at two places
> __destroy_compound_gigantic_folio and __prep_compound_gigantic_folio.
> Currently, It is called to clear out the folio->_folio_nr_pages and
> folio->_folio_order.
> 
> For __destroy_compound_gigantic_folio:
> In past, folio_set_order(folio, 0) was needed because page->mapping used
> to overlap with _folio_nr_pages and _folio_order. So if these fields were
> left uncleared during freeing gigantic hugepages, they were causing
> "BUG: bad page state" due to non-zero page->mapping. Now, After
> Commit a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to
> CMA") page->mapping has explicitly been cleared out for tail pages. Also,
> _folio_order and _folio_nr_pages no longer overlaps with page->mapping.
> 
> So, folio_set_order(folio, 0) can be removed from freeing gigantic
> folio path (__destroy_compound_gigantic_folio).
> 
> Another place, folio_set_order(folio, 0) is called inside
> __prep_compound_gigantic_folio during error path. Here,
> folio_set_order(folio, 0) can also be removed if we move
> folio_set_order(folio, order) after for loop.
> 
> The patch also moves _folio_set_head call in __prep_compound_gigantic_folio()
> such that we avoid clearing them in the error path.
> 
> Also, as Mike pointed out:
> "It would actually be better to move the calls _folio_set_head and
> folio_set_order in __prep_compound_gigantic_folio() as suggested here. Why?
> In the current code, the ref count on the 'head page' is still 1 (or more)
> while those calls are made. So, someone could take a speculative ref on the
> page BEFORE the tail pages are set up."
> 
> This way, folio_set_order(folio, 0) is no more needed. And it will also
> helps removing the confusion of folio order being set to 0 (as _folio_order
> field is part of first tail page).
> 
> Testing: I have run LTP tests, which all passes. and also I have written
> the test in LTP which tests the bug caused by compound_nr and page->mapping
> overlapping.
> 
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
> 
> Running on older kernel ( < 5.10-rc7) with the above bug this fails while
> on newer kernel and, also with this patch it passes.
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
> v2->v3
> - removed the copy of page/folio definition from commit msg
> v1->v2
> - Reword the commit message
> 
>  mm/hugetlb.c  | 9 +++------
>  mm/internal.h | 8 ++------
>  2 files changed, 5 insertions(+), 12 deletions(-)

Thanks for answering all the questions along the way!  

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
