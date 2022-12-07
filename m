Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E79E6450A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiLGAwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiLGAwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:52:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D39EB49E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:52:52 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LKXqV001109;
        Wed, 7 Dec 2022 00:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=VAI8nQLmMQqegatevbImJyUZcMdBJZj0Nqj9Cbov/0I=;
 b=WS7zl/HHkl6/fF6mzgeOCVG/fzTLOSBUZTWtZpUUdqx7pwBdfKxDJvtQw8WzBbDvchv7
 Co6E7GkqX57VxMVSag7NDiUdY2vTMz4Fc2V07glm43U9pPXIjQ3uQcBlvTbHl2RDXjrH
 v0wEW3E0x7a2HedARY2mmJRISBL7J/yrzc+FTocz9K3LPOP8cDQraUmrHvjeGanDRrCS
 qppB2RpgFKarBHFhhdTfcavJp7dHms007Bax02/YfpWdImvc0HqXNQu8zxfYT/snLTlT
 rb693d3D8JwfjflL/A07FtQIQ8hpgy8X7bL8kDEBqNdNd//q7uxSfYgVMSc91lP954Vh 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ya49dk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 00:52:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B6No7gA030601;
        Wed, 7 Dec 2022 00:52:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa680uev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 00:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNxJZ5BHBbbyhL+HLvVHbECOpP4/g815hzoZtGJuagkBu3YBn5RXS+hRkms+R+RJ4P/2O8lNOSAHBwnCEW1pYCCh864rIPMwy/av4SPUbMd/fBm1DYmYKduFkH3WM+sKMQn5Y4U/TyZgoZj+ldKPVWnC5SRQLDTvlG4drh8ha0USGbpkAEOe9IoGK/s4qBDGFqlM7jQsZIqy2WqHSC04J49F4FjTG97aUNGD79fiuuUmW2AKFgLRh/3WWJEcdEN/aDbL/96sJgDrGDLrL5Pjckk7OtfAFV9+3mXpCLOqkSGuwQvRCdMuHoArrDDv+F1Jbm4nnAzhlczxc4jDo4CYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAI8nQLmMQqegatevbImJyUZcMdBJZj0Nqj9Cbov/0I=;
 b=n+VTgkuxR6h6pPCSsy9GfdapGy7832KiF92TITR/5EZcnhDgJ6EwfGmHixruoiLNhOSaE69MRYUbkAV/UTWQ7npyRHUAwurQiMvvMaSd1wDQHGXJepVj7jO+tNLRqH3bsLyarwQYvmSmfJPl0MXFfxXcRjx+SFtsHE8sKXsBqt933E083skVyrYY4G/Xy6V3hX9n+klqjqmfyE/llx20exEgBxH1AyKBonPwfFwnuyCD9VR9gtoQr2H76AlUc7+4lvhyIWl4DslSJjpGDCr4Z4D+H+R9lXVphFywWAJJPT0AZMf05JQP1+OQIRdbiue8/CNzFUe56ogroO0CB5jXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAI8nQLmMQqegatevbImJyUZcMdBJZj0Nqj9Cbov/0I=;
 b=DZ/OQDZFzEi3+m/+nZ33nUesTXcTXPhLNA6ioJN/qxigCDFOhI0o6pgkVK2PoYoKwQ7K7VCwVHjsj+FFLkUSYXdtxSZz5rE6AxkFmkuPxCdgk977722ot9/JHZ2iPSzp4OeIkeQm6UQzdkJYg3lcUpX94zTZWck/cNdGK0YEM90=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4720.namprd10.prod.outlook.com (2603:10b6:a03:2d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 00:52:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 00:52:30 +0000
Date:   Tue, 6 Dec 2022 16:52:27 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        hughd@google.com, tsahu@linux.ibm.com, jhubbard@nvidia.com,
        david@redhat.com
Subject: Re: [PATCH mm-unstable v5 03/10] mm/hugetlb: convert
 dissolve_free_huge_page() to folios
Message-ID: <Y4/jy28JfXqfYOQe@monkey>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-4-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129225039.82257-4-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:303:b9::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: 165f41e8-b5e4-47b0-292f-08dad7ed5150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bDl7ZNsBepAU9ax20VFkmqoRwkfa/IwyVR4ohwl4UcCepPnrc+5m9ab4oJ/tGNFW6s38Zo6fjs/nG/ZCARiPED0+BLMeVtYJ/zG6NzbZgkr8Q/OSS21d0NlCjAcC5Ihu7KTTyJ8sJ2WlZW68riN3Ph6iAPaKZcqmFG+8/mUY8GKZk6kq/jo9ZBrZGNT3JU5gDHXFdDZ2egZ2IZQ4B5+A7FCesOjqzxxc8o5nx0yu0vhdRT1sZ08deqHwlZrkcVXpGppunIF/3cJnnY0mEKOGsZK2qHslUFsJS+ytZtSzsUxb6dCalpgH5zRZfJ4XqJg9utTRPrC3CibXYQdT9cANuXn3E2sRshypFRsz4UK7+hzRbsKM93Wd5io54o/hzB/fvZfpKVipmIsrvyJdBGKPMJETnLJtJxVgE0Jb+T4xrkyj3OdPWgXF8EZYm/CoUgnAaR9tUDSXRTO/6lFdya/7G8YZRiw3fgpGvJ1+AebHiz73lxibF5gANadHBRC+O7BcbNlUHcCoQlZvqJy9TvO0MTD5l2rgp6zVlBA4OqIs97LE2qZc1RqGUJRjAjQ36vIYxyTUkp/S0yZKOwFjOhG66tccauwnYb8BWRMbl27Y3jUXswH8WndiCZpIGQ6mPELsIH2fFVUZn+HcZnpHULrXu+AGP/s8/McWJwOv0th07ans5Oqwrdvfm3bK/2HdOKO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(4744005)(2906002)(44832011)(6486002)(41300700001)(478600001)(7416002)(8676002)(4326008)(66556008)(86362001)(6862004)(8936002)(5660300002)(66946007)(9686003)(66476007)(6512007)(26005)(186003)(6636002)(38100700002)(6666004)(83380400001)(33716001)(316002)(53546011)(6506007)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tdOC4IeyYfVTFrEqH1/4ZiWA8Lt304xF96MfX4JXikypGk9xbyPHfkbRa1GA?=
 =?us-ascii?Q?UWBtE9593kJhfxOAKllbKCYoSlM4pYrR1/L6UjqewH44y9wEFPmdU7XaK9+k?=
 =?us-ascii?Q?JF5zydjEErxwtiiDuVLqM4mtpWWxpbrucDa5ad4h1C23XBOe32PPT1Y6zJ4n?=
 =?us-ascii?Q?/Oi37z3O8ZfHNIrRSDeBp9GVViD2SnabOmDrTqTjHjhFsS0D/j+GtbaP0Pd0?=
 =?us-ascii?Q?KRvXmToqS5b0DSzKdZNcXqXUcNJvF6sppUqUc+i1tHkE652c9HhcQ8FNhJr8?=
 =?us-ascii?Q?z6xI8DxCP2/bhqdmRe6DPUS5JBRL257G6OjhmRIxIsbnMoKCObjy1RjKDdtM?=
 =?us-ascii?Q?M5ZJLAuki7C9wkt72HKOfylgtZ6hoMr8Ti+FKeTiNHz4aExuRwRD9X760zyP?=
 =?us-ascii?Q?A7Nv+eydkZKP7JJQ1vm2ahShLiNnPIIE79WnGRO1UZoZGGjFB47cb4FmOcGC?=
 =?us-ascii?Q?HNGj+Lm+VfEbXyBCYJ4t4qBwFvaJOhdBoX7b3WDKk5ovqzPimJVJYjGIVs/0?=
 =?us-ascii?Q?nYjpEviRgVnqq7juevyyq2Q7ZnOK9emXwaraij1O7FsyCJy59L+kokfHi5ns?=
 =?us-ascii?Q?nEQixNNFqpDxJV9AV7mZMGOUqPlvxnIIhcVt+wmX5WRKP0Oak7OBDh2amD5+?=
 =?us-ascii?Q?P8sxtJfDY5VveU6IlY0yfYobPollH4pyCX2jbQzMec/CHWQwZ49FMrDhiWx4?=
 =?us-ascii?Q?XBqcTnsce7xwznZn671UsYVhLjIJHXl5ut6pgeeok2NR9JYAg8ZEYihmj1qk?=
 =?us-ascii?Q?l2+TFhY78YIcQKHTBcNtLo4PrIyyPN2mAvb9iVuZgPvHDoOLgy6/nQgnCw/6?=
 =?us-ascii?Q?I0YLabXoD6SBPHvzES/bUI+5nA+aYX382xgn75DTEXSzRchcKvcGPcNIcs+p?=
 =?us-ascii?Q?e+yFv1EUZ4pfcIbrDsX2kYFHsyboGoRVaEgVOn7R4i/41dRRRnbZKd7pHMyZ?=
 =?us-ascii?Q?Do46nZsci6NHT2Vj3IbDhkP8F51IZvRW+dqgFuu1EGp8Ls77/X3U3x9bvR/0?=
 =?us-ascii?Q?o5Q0NrI4khgWu5KRGoZdOa/0h6iT3rIkSJTAg9JUZZNKb63E2jrvJNcf4P5/?=
 =?us-ascii?Q?jIiN6YDWC+jIzj5fYnipwiE3oZaD8SfX7zg0y2gbWEz9zCN5dxDqCrX4VWwJ?=
 =?us-ascii?Q?orBnO44/Aqq60SBBA6B9j7KBIzD7erDoSL5yKbLeipDIHnPSMDo1LlgCj5jQ?=
 =?us-ascii?Q?qTdnGpXKY62xX7mym7pK95qSiXXgbRy4eFrbrYuFYSaqxInwbtAfViv5yMVq?=
 =?us-ascii?Q?eXBKK33oH9fUAR/Fs/V0WnLFc/cEmCppj7xeo54s+i5PyBSFkaMPUW9JvC1A?=
 =?us-ascii?Q?O03jmfmZYQrwD4O73DtA5eGaK8MHBi38sf68WJEQxztpcnFXkCaYE/xMiNQb?=
 =?us-ascii?Q?ZYtLAHtppb5nK9PwyeW/J7IdnMO/OXDj6ePC23E1hSounixy0VxF+XeG9yen?=
 =?us-ascii?Q?UF+0qhf5T4qmTNHwhRqdO/ntmCA6dZA8dTkstdfNfKAlVZmwBtPccGRQMJhq?=
 =?us-ascii?Q?qBiUVIWMC3gTM9OTj9q8L1yY7lFCJk3BGGRqk5Nix3U+voG40HMBxnvNBb/y?=
 =?us-ascii?Q?cJDerBjNdN67ySaAB1mjue8gD74oN6qSfTH2VgskoG0VDUTKMuS4VIGqtJS2?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4JzzCpNYD67o76faASrHSx2FyD1tgAGqPTe3Tp8bInVxvfaDNLh7f6IGCW5r?=
 =?us-ascii?Q?2cuR6Lcd8IITjRIIiaJ/HEGwTC3OElQVwaWYUOj0AorfOdk94bpMDfuVop1i?=
 =?us-ascii?Q?ZnHyLQI4qHIJ3kIjgC6hog52WGxQq7queUJlei60AvZ63UgzKsIhJQqj8RsW?=
 =?us-ascii?Q?X0ICFmOva8iosT0As3yOnRGvgGTrC5sWri1UUu/XRtDu4J7TMFg6BQCgk9FX?=
 =?us-ascii?Q?x57+3BM1rn/F97u/HA+2z+K4UX4LrXnPY+8vsyIcfg7xsY8ivusJEzq379gd?=
 =?us-ascii?Q?/XII1MRW22t5Ia+rvw5/Q5PPEMGyZlfGQfbB98f6efnh+JEzHJEPEz/YIoc3?=
 =?us-ascii?Q?KEi1DiJOrDRWqcwRPrjJFL/UuPedfw3NWxxyVOE4byvE2lRuOfZ3/ut6Bh3B?=
 =?us-ascii?Q?I2HBRDEpl3BQwnbaajqk3l/N5UuQqp8wHIm1yGn70KI6Lhk7NnUcagj0endm?=
 =?us-ascii?Q?r/yQXqfS0iAUiuiF6Fa16d14Ox3Jr/7HvoPMRJLtFXoMFmc32Pft34FSm8Nr?=
 =?us-ascii?Q?ueHgt1h+zjBQrj5uuMxMAtlZDSKrsshhTfNi1gxEy32M3V61zZGlxsnLx8HP?=
 =?us-ascii?Q?ZYe4lcWJXACsqVMKYUSAQlE4qnnvaIhy63PLZQ3n+a18N0CcubwTvyrrmCWJ?=
 =?us-ascii?Q?Ko0ILQJZAvVOOCyTtSEJPwQIir+NnwfVkuTIl33aeP9oJCaxWURvi5sgphnE?=
 =?us-ascii?Q?F3fkkqQappYH4ZlJ9k8aw5rqze8jFf0mWWr8gNg248dyYYrW8B35ep+CTJOc?=
 =?us-ascii?Q?T7JfDwHwb/8wn0vPWZgLnZJwdwj9y32ore4f4r+HuY/L9eGbAFuN7eKIsbvn?=
 =?us-ascii?Q?bcWU/KKsIs8zLaSvZKhOuxY7GsLjIJKJZc7coHdiG6VgYFqF39n5GGlV3yXf?=
 =?us-ascii?Q?UNrtp6YlYkjHnM81oHkQnXA1qyPp4SJeh82Nhl8QHu+C1Njx36DLOayppgYB?=
 =?us-ascii?Q?0seqI0xjlqpvWLKo3zDUtL/npQOYDvs5ABvXHfsrdBF+3RYF/FDP2ZFE0WUF?=
 =?us-ascii?Q?P4FJi882oyMPDnurHrKGlrs94HW2sYFPBx1rs42FeLyfTa6OnQj+TmKLY64+?=
 =?us-ascii?Q?ZdbkXcvzFXb2rS2YO6gr29Lnczf+mjLlobzYd5pp65DUJg0id4o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165f41e8-b5e4-47b0-292f-08dad7ed5150
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 00:52:29.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlCMioo5jM05TjHHKMhn5i/LQIAf/UIoGqWSD2cJkRqET/sRISfh4F+qa7PbqetkpNI8Bx05rCtbQwjS22jOtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070003
X-Proofpoint-GUID: 4a3RMHeP8TosD8m2hRfTHKTT0uCRtaae
X-Proofpoint-ORIG-GUID: 4a3RMHeP8TosD8m2hRfTHKTT0uCRtaae
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:50, Sidhartha Kumar wrote:
> Removes compound_head() call by using a folio rather than a head page.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
