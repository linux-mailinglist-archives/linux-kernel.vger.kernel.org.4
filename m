Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222525E8629
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 01:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiIWXD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 19:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiIWXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 19:03:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C9612C1E3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:03:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NJEDVo031896;
        Fri, 23 Sep 2022 23:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=TCok9rWR6yf9D1W69YGKLv2azQaBU4O5YMnropdRrGQ=;
 b=MXsNy59Tvy+6tLhFHLTHkNM3zbarY66BgPmLACdpe/cDiMNs2SQEokPI/hflo9kTs3Rg
 Tv+0JydfGmAsi4LGk64gKm8o2JDBHg8AcgnGZXRA1IBS9XazyxIQkLvJ3ysNaGLMjI7x
 3fP0N4pr2HBlbMEt02qj2rgjUf1/8N/WQuwDEsuXpjMPMcaQlVLP+kV0diRqp9cIv9Xz
 4Vg9qZFaU5VsuURjcH/WwY+oACK5qOrYgEjYPC+qy82FlAaN9cY3Zpzzb8V5GARzjJB0
 VDLyYspfuI6GgVTosJFTC2v3ds7r+ahoQImkYRsdKIzC1XIVz1ljrNmbxA9CI2zNEgu+ kA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn688s4r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 23:03:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28NKYnlF005688;
        Fri, 23 Sep 2022 23:03:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cs5uk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 23:03:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFACFTYvu556LpR4fUxTChTMO774Fu0PofJkh9kBFjB4mQlMuv16ywGstvVyhJIZspoW+M3cBhepTuaudRypEo9s6S0nWSudjkxDvUV5sXNzRjk0R5hNsHxYiGC/BWDTOdqBIL0ksjsXh2z+2s1f6FrTPjcIVZBQtVKL8Qp0PJSfmqrkobAENhRaotLvWlI+LgXxkEeHQA+VkzLqcp1IzOdd41UCmdbQBN5x6AN+k3p+A3o4fgVqVc8aRJFgmjaEfwGQr885Fvhj9RsC01eayp/yFFTRWPMi3L7EZeLO0XZtqwKWgZdGSXXzm8StM5R7k0Z0dmCrY0qmqRNG5ngyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCok9rWR6yf9D1W69YGKLv2azQaBU4O5YMnropdRrGQ=;
 b=CHXn9chkK8cS5rWg+PDynwe+90Sz+80+2Ut3ctdOn1WQW4ezEI76GMahjSxq+z+FCgqcvUD6ibMKQmMrKqYDdcQcC0V80U+yMovfbYtCzVXuaXkVpXBRVKyUVMloebyFJZ2K9TtaWbrMZtIMaBDSKlpNQy/ToQ/4JGO8tqFr+eydC5y8GP0lvou56qF/PQ1Gk0dyFOoG3ZiJwLMVpfTv9TaKD42C4N1w4dujlCzsFGRcB3yWNW8Gjptvn7DN2x6PQiPRIy439Pc7iNZGZB2u+oV8e1r6PeK5Qdb/x1ZF98daACpChePgGZje4FNLIgDhGijdzgqlyArWyvNf4f/PtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCok9rWR6yf9D1W69YGKLv2azQaBU4O5YMnropdRrGQ=;
 b=hwxRfu+zYHC7SmRAvmNroVpy2Y1QBfTVBBbntD7TWtqRN+Ucmg/qAaA++n0LdEKUPoLHe6xjN/7TBVFUp99ewgZIpYa+Y754pGMNLItUpZvFP0yFUwVzxYtJQMZGHuSlwLjqwcKXmkXFpV2Tjau3wJJp7jCSk/EBOHv8JWEu/P8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5201.namprd10.prod.outlook.com (2603:10b6:208:332::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Fri, 23 Sep
 2022 23:03:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 23:03:01 +0000
Date:   Fri, 23 Sep 2022 16:02:58 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, vbabka@suse.cz, william.kucharski@oracle.com,
        dhowells@redhat.com, peterx@redhat.com, arnd@arndb.de,
        ccross@google.com, hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH v4 4/5] hugetlbfs: convert
 hugetlb_delete_from_page_cache() to use folios
Message-ID: <Yy47Irzuck6/sxXr@monkey>
References: <20220922154207.1575343-1-sidhartha.kumar@oracle.com>
 <20220922154207.1575343-5-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922154207.1575343-5-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:303:6b::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: 301a3454-737c-4b8e-3ad7-08da9db7c3a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnZxhZ7CYqtk+SFBAFD4HoKFbkQcC0swIyT5EwkZUhZU+JFceJ0M8fFUdFR7KGt2NDL1hf9ENa5sHCcL4mK5egDFqvzEleMU1BeOq4JLcCicMNbU3XErGW8pGZKMsuB9L0g1U1JHJYxKAIPle88BShqD4w+t4LsKZ5RSs87MCVUyb9my8l60HOMVodGAKgJOZm5PMgR24aCdEnI5XnDPhAE316e8gHYelsBiRqFWMt9/FZtXiwRG8tIO8j+Tmfg/crIvaIqE30U8DMQP8pn0uuYwaV0Cb1j65Z0a4kNuqyeNPdJ6PfXA/UbjV5ToG891NsIUHMawxewF2D8fxGC8JPcZiZyPOkpRYsqUGagRqjG6APpqrEAO56ghccVbfhr9/8z20gIylFxbhNgEd4aSsGENkRtcBSR95VxLrxJYk8y4GCxi8ETLOeUiabZgcpHF48abTmFJUAWTeaYx//NhStL4WYPqNQl9XBm573wATTiGxpAjifO0Dh3+Zh5LlftTvfQ3oGgvNJL+TywUMJ7gSBC8JxDNfW+ihsAtfVt/+o0Fwtka+7+eU2EzAVaFisxwaPqhUhwrJXBEvcgshwz43F5YWeT+Q9l1GkaEFlzbET/TCH41gQnD58qkeewt+ZXWed7VI6jCzn+JRlcYIjfK2yRnQov4kqvxs2WPXuYqa8j1DxVNTV4HQUzRsoibfkMF1TTIJ8TjWiL5jQj/rEUusw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(38100700002)(8936002)(6862004)(5660300002)(7416002)(186003)(83380400001)(86362001)(26005)(9686003)(6512007)(478600001)(6486002)(6666004)(41300700001)(6636002)(53546011)(6506007)(66946007)(316002)(66556008)(66476007)(8676002)(4326008)(4744005)(44832011)(2906002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jQIT0QWHQvwW/O664vMd//JH/pycEJ/cnZYH8zMhYlDxw3+w0g7SrDdFKRjD?=
 =?us-ascii?Q?QMVHbZ8Uff4LQMsi99ZvPWVWX5Tewb9ieoOVhF8/Bq24qntIl8m1etETbxRH?=
 =?us-ascii?Q?MCfy0Fx9jYRRU47kZoExW4SNffwgSnm6EIprhkhyvfoq9EFDmoPwNGTEFvxM?=
 =?us-ascii?Q?7zzjZQXWkNyDYbKiqP+4sdSikziSiB227oRtfbVnOHXIgORCv2NP1auKWoAZ?=
 =?us-ascii?Q?vCbmjASHvFQmjiIYS9ugVrk+sdiCCOXlqzRh7QgF4GYYyFiTBZKisu8jm6c8?=
 =?us-ascii?Q?k6sf1Ou4b2RpyfMPNp0JYQMKe3K2lGFSkwChT8H8WZDeRaDm1mTxlHUKrshz?=
 =?us-ascii?Q?Gou/jibItJz1LmMmpxCUIXeDM/B8d1/JjG7lmGojEFIIhnnIZZKPAoqoCe3n?=
 =?us-ascii?Q?cBcZV2oIc6TnVDlBAlIIBn8iQZbzJCliZIXCtVXCCpNQM0M+a15sPrWaaRVA?=
 =?us-ascii?Q?Zhw2ABfXev20P7EspeeIx8KjolHuffyjyJPkAxRzFg6GZPA/ajiIPiKxkgJr?=
 =?us-ascii?Q?q28WXcjiVn/79RedmYBzuydo58S3kh1oY4Z6pBbQUgiWSpCvww+5b1/TLwnR?=
 =?us-ascii?Q?U/QQnYpjUkpEFTC757d12KEStAk0QqdUNWq7+/aFmTIi7tN9xfC53CS8EKr8?=
 =?us-ascii?Q?8jmdOlww53FBKZZapdt+qLNGh2cjSWFjzGMuTqUaHvln2IMFKIDn5wzjOn5X?=
 =?us-ascii?Q?MFdu9AGibX9VnIUQaSF1pU9dORXROA25dsTr3wyQwwbB+Is7m9TkwbrbMf23?=
 =?us-ascii?Q?0yli9X9boGpjyNygEfZSQ0Vcaetqftn0GGe0YpbADpGw+2W0HoAqqVqwkwXO?=
 =?us-ascii?Q?Nc6wXfRUKicFpFT4EpoY8yDbtqqnnqWIVPdZoQt3wv5MGldMuAW67n592DkJ?=
 =?us-ascii?Q?bqGgKRWJicX36YOi2dpTIHNTZ7hwkNL77ZpgthGeyEGd2CKvfq6cO+D+hUT9?=
 =?us-ascii?Q?ZKkX+XDn2B8efCnyU2CglaiHYcQ6gBWzgs7cr3skoG93JbeIWryvMSVY3X3G?=
 =?us-ascii?Q?2fsXD7EefOfbOoooDdR8yG9VkqjxX9ExXMs5i69uo4CHbOt/xlP2OcISZmoI?=
 =?us-ascii?Q?kLOz2PJkb3jOz/Jp6hO78c+dB6c8/O4UWTgG7BA9fQoqAKMqEnia/oWh7yrO?=
 =?us-ascii?Q?QtLRkTu9sdjymKFqcOWNXRbypdXXM3jHDgyS3C/CgMessCEk7eBHix6GZgLc?=
 =?us-ascii?Q?hkbEgZ4eBz2DomwLr6m4TJq0dCOv2l3+RBePOcdQ/4An9zciOdlbQci0zar3?=
 =?us-ascii?Q?DhzZFggUBAAV1336RYL6SMN9vvZJir5M8IZC3lFifKxG693lnYP0FTU6xloh?=
 =?us-ascii?Q?osmFbFdOUGXjsjEChO5UaleD5Gi+zJWZ5NoccvpGowKRVQphAv0G73gVlpjI?=
 =?us-ascii?Q?HCwi7hENmrZJ+9WwhE1lCV4ragJoYCQkfPAVjbAueNqC/Pz7BfQ/pUQEXOl5?=
 =?us-ascii?Q?p/QKrz/o0gA4VJ5SxW17BlBLH3eV7IMVn8dsUidVOqmBHseS2Ne/GvlwEXQK?=
 =?us-ascii?Q?e+81wtfLQQ/ACHwwTYmS9RIlf99QFDbH+5ZAi43WWPREsmo3RfYQ6Wcd9xdb?=
 =?us-ascii?Q?e81i3P66ReqhBhBW7VCkd1md/mUacmtnk0toMY10hRNE6rMHQYJXZik19GhB?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301a3454-737c-4b8e-3ad7-08da9db7c3a7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 23:03:01.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScVLBbDAvXb8FLyk8XLNT8nCMC7tKlGPuPTSMfLOAGYmWoA2Aro9k2kKhpsvObcqjbUomLQuqwneBMZLB92MJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_10,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230149
X-Proofpoint-GUID: 0SNlbOPDXgS95DXfVa17L3ZktT3EuBBb
X-Proofpoint-ORIG-GUID: 0SNlbOPDXgS95DXfVa17L3ZktT3EuBBb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/22 10:42, Sidhartha Kumar wrote:
> Removes the last caller of delete_from_page_cache() by converting the
> code to its folio equivalent.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  fs/hugetlbfs/inode.c    | 14 +++++++-------
>  include/linux/pagemap.h |  1 -
>  mm/folio-compat.c       |  5 -----
>  3 files changed, 7 insertions(+), 13 deletions(-)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
