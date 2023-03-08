Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EEC6B11B4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCHTGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCHTF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:05:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D00FD5174
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 11:05:03 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HiG2X016916;
        Wed, 8 Mar 2023 19:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=eQJ19SqzWani4OMelInbv/eVtuPOHheWoeHe88oUJMw=;
 b=Eu9kwYD4xB3I8huRIQIzKlTxLGz6OAurbxAt3gZKTNq0uspF5pVINbLmlmSEs9IDfv0L
 oC/uHreNxoCaDT/JaAr2f0YLhNjVJ5ReKBr2yy6Qc5I3dKu+9ccFfBmWiVyyrZOZSa1v
 8isXNtntcwlUDX3XBuFeAjvridgHHKjjMnU1M7PuA3hD1HSXWAHQAtDDwJIRjs6tYZVI
 tkljfMSiBo+u6+aqI7WHABzFMBBGIPm7isX4LF8WSO+k6uqEqxmE5+E0UD8podF0a3Fe
 ztbjo0fRWwQb3Kg2cqlnyYSXgMu67Yq+/i8FcFVf/3uDhlshE0thWPBl2vr1JVT9E4Bu Sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p41810v40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:02:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328IFUgl021707;
        Wed, 8 Mar 2023 19:02:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fr96bpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:02:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwm7bn0cvTgMERzb4EGf1Aupshb6iiqMxnsO1hR4tOJjpMjgdvOQBraTGK2p4bi7400lhiZBFmO5XvI1zW9nT+9rgekSPDm8hSKoyaGMZlGJfCiMVMa/uvS7K4Go3iuWhTnxLIZ2rBVR5vM16bgzwuvyGdvNCd2sINB4iacYi7bqofYMM1t/Zk1uXpMKQzy5RL2oRK+daSICBRLy3AKwD7fHQE1luuB3LdFaMeN836IuetaotarPd59xrn+Rb01DVTFj9EV/CTJPGsGoObmZENkJlWAEuXcRA2fDkVtkScCVzOSZeoSkyUSuzEKQZON+vuhFCCvQtwojIBovKdXsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQJ19SqzWani4OMelInbv/eVtuPOHheWoeHe88oUJMw=;
 b=m/u/LnigHnqYLjja/zNkQjNPy/d6B2lx8gRt7ZWukEEBGs70698LcW5EiLh6CBWsqB5CabkPmZDrToC5GzktocEItiI4afoOg6LIuP0ZzZrlcEfkqLPkmRjXWufgR8rS0anfRpNVrhLEy6GYf2oU+X/MdnSM+Ox9CZ5+wr4g9Zz5JhQO+qd9HNBSM6U0zFvM4LmcVhmjvVexEDUn5RRUhqN0PolydOE77jhbjl0kuWe1bs0PG26I+0rEdHXNFjUFcoJchYKZHtuFEvuWvuo45rjgZ6NQRi21aKDcbZzDVAoQ7iUYnaFQVDExJ7HZ61BWaseKso1iSu4coNpt7mAS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQJ19SqzWani4OMelInbv/eVtuPOHheWoeHe88oUJMw=;
 b=qxQXfMFLzDLX5soqKb8JW42PNedJ7ngo4MQGr2sQDI/AzxTCr9TD5CM9ira7VZOxu8CSzrk6WWJs4zzv6jG/KilijKNKKKHootuklsEexqGeWO9jkbtTGYUpirq7CijH25JRz0k2FySOeXCgnBGq1HSHTjRV14OfSVShSISv6sw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7339.namprd10.prod.outlook.com (2603:10b6:930:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 19:02:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 19:02:09 +0000
Date:   Wed, 8 Mar 2023 11:02:06 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: THP backed thread stacks
Message-ID: <20230308190206.GA4005@monkey>
References: <20230306235730.GA31451@monkey>
 <ZAaCISgq4A/GnkCk@x1n>
 <20230307004049.GC4956@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307004049.GC4956@monkey>
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa4c6d6-6820-4957-96a1-08db20079dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2l+oZnWXKsuid3ILgkgfZznQLC/w/mAdfl1Khl5QptM3gA/mXxXNcK/LEBPd6ZUPdO5p5OvrSwKqSFEQorsSDbC9jOnfzFWbDaLzMrJZIfMBVaMJuadsuxu2L5PsoZrTjFoBGtpPgBzCtcwz0Ct0+LX1ii3nJP/2yRAOfuiDbTeXQzVGbs/YxgLLWcaSjBzHltSfjalJFIEr0S/illje4oalAgKPQsTC8X8je/PfHioMM3ZjXeHwYa/o5jG1iO7HYeQULrtHjyYx/+W2VduEsxi6OgjitnWYCvjcEsxTfKds37Q3h+fEA3E+Jv3IvJRQznVSWC4GHsg0I2P2bmL8Zx3jYR1+nDNNxgeiKIWymcqrVusktOzQ5ovIGCR1xe9uRHy+gAHqEFu1Trh9+F6mmP5C1GPhNChdItY5u0/SI8H9l9bJGmSFjF4hoMrM6nnhOabTTG5Kx6Ue/r5EOpUWEbD5TqZGjM3Z3nPStSkHrOpCpuTI1e0c5s0PJsIEh9EneykLpq3tpQJlMCcHQZv0SDmV4ixvbdztO3qQlYl21wyTvr4LFrc3p5Hz7WCk2m4Kv89xF1eHLeoHAEMGCzKXsRrD4fs3dg5+xaad4sF7KVKF2qkQblZMFp4N53vb7KDI+lLUmUQAbJySDAWVrv4yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199018)(6512007)(66476007)(66946007)(186003)(8676002)(110136005)(66556008)(316002)(44832011)(6486002)(478600001)(5660300002)(4326008)(33656002)(41300700001)(86362001)(6666004)(9686003)(26005)(83380400001)(1076003)(33716001)(38100700002)(8936002)(6506007)(2906002)(53546011)(3480700007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cCafmdJNGIbU2ZFI2h67X8gSiCw7BtMwnPvzLmRLc8kbuNGb350fTc+vrLZ9?=
 =?us-ascii?Q?XoNpOS/FI5lScOZCyjH+H6lCo3NyaX4QhB7n6sKXWrOMaZERxFeSYFlBxSwQ?=
 =?us-ascii?Q?XYQM9PpWrfmjsnJGTtkmgg1DJY8ZOUtaHmrAnExI6VnuM79fO5TXSEPdOdon?=
 =?us-ascii?Q?bY00dfnRF6LSxXTsNYoLHCritsJP1yLbugEP7GTXneRcY4LhSZVfHkgSyoWp?=
 =?us-ascii?Q?8q38DPMMF26ew2q6oXH78fFSl0NBE5apm6Vb690OPwS3eRXgHGk+2ZVsRmnW?=
 =?us-ascii?Q?IWI4ax6+4/dEDo1JD6SPwSMG3dWM8Is2e0G8B9SqnI0TUyoS1vYvX1mLFi47?=
 =?us-ascii?Q?e5Zy657Fb6zEfQtV5+oe904/LmYk8TmTS5SgfTlTfPwej5lpbVe84PFFYNYh?=
 =?us-ascii?Q?1eqnKoRT2KA8XVm1FqJMcL2I2YwaUTXtmjqyx4HvtgYXwLbbVgxmde41Xbws?=
 =?us-ascii?Q?XTZWczGEW9HpyJGI2BxLURBz/g9P0mTtKERV9ku4qVkvoyy6HVln1H9H7Jfm?=
 =?us-ascii?Q?z9q6xTSKAbuyZqd8/YFjNmN1zTpWF491Xqp7Eij8DBC5RRqgebGaCZQyyr4e?=
 =?us-ascii?Q?fzeGXfpGvxzB7OdNZnLCJhliiWeSWGzwKlhFqfU0vKMu4Irg16y54bH2CUwu?=
 =?us-ascii?Q?2BZX/aDQGuv4gflTro9bVNtfVsFr88bSAmrGkn5E6fo350fB0hFiKZCjP6YV?=
 =?us-ascii?Q?iwCJU1haoZ3iRvcyn+9R5sBwcHUJACr7v77/5ygikv9V8eATG/+100PmdKuy?=
 =?us-ascii?Q?KbDoYVBx22kjNw8A6F+3afWJv5xp3ipYiJwBYVHI4V+qQjvasTrjacWs9AM0?=
 =?us-ascii?Q?BfPhTNUUlaMWbgHIHClOC8RY1UuvHdL7n44TjX2FoEDqS5qvUy1tsgyKIUc9?=
 =?us-ascii?Q?HtOqw/mG1GAjhYBAQod2782mo+poxZNxg1ROZ+UQCl4m7QFlMB3z12KEKwg1?=
 =?us-ascii?Q?Mhab27nMrS4wF9duw3G7RHfBj6A9bITQC0iIz7jEiGkRrRQ+i7qw/3UznFZQ?=
 =?us-ascii?Q?yLMqlaOR1nxWq55oWmsluy7duZ6PM2x9wEGRV8v8HG2x7lPRtZZ1EQD9hPOH?=
 =?us-ascii?Q?nopaDHVGV3doKwdVQGpsgb0JPu2LATZGT8v/gkSEanUzt+n9uzx2AWfjHsGt?=
 =?us-ascii?Q?AOE0RgAah4vej/VHb2thCTiLz02gfYpZty4vSlxEr0gZe5H/6n5lCvbUkqBL?=
 =?us-ascii?Q?+cUEtpwx62C+Vw3+fA7LkVg50Bl6MhVKJSbknsHVSBnYqxOM9SrY95jjWvW3?=
 =?us-ascii?Q?bAxStJvfobrh8GPZa+DaAcoIhsUeOMhRvDjJRtCrhLiZUTDnzjKZm5TNH0QP?=
 =?us-ascii?Q?Cemvc0pIkzykk15Ji+5KJJAeVW+X2LgS9R04nHN3XmhNLNrLIiLzPXUfU9C0?=
 =?us-ascii?Q?1HlC3ASjyHgs492oHnFcH+PUppMoRgzI1BGPTo407KHwRfuHA4jv74gFEXoN?=
 =?us-ascii?Q?P4VT5o3zEL0uzN0G1z6Zem7LCYUK/OvjFtHkZctQyMLC8wRNrtSDgpTybTT0?=
 =?us-ascii?Q?OSd3jIkQKvaGVe++s/dWthiBBT8kjyH5FPvP0QYTbBdEYqLIV+3gLV8l9G9i?=
 =?us-ascii?Q?M75TlR+9Kv0pFH6Mm9IIt8v8KgAV0wELzOyv01CnjZKIJlhCPgqzbxV/Z+4q?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dknCfbhcfT8m3V/Vo1vwWC+QXXcDBL7JLerSBP6pCjelpqTkUmiWob9PxSyPXI7tHyHzu4Vf692TmyIDpqW/AP9ahjftDceS82xnFPpjehf6lLVZuzYRvBPCbi4qCCfll3ZUn7LWXDKfSjl8LNACh23fs2hsM/X5qqG/mOW5BFmAv9Kw0KTEd0KsAonmQC5OW30989zbPlxfwVjSWe9uLmrvu0Od51lH7pzrA+hW2sE61GByJRdLqlhUVHrTplKRkdLhD/QUR5byqNb7MRTUcMYLF+8dhyuuLGP+9regLZGjk9BxCeCBKWlw0nHLWblSf938S+v4d14xhf/1MakXCTDqh9hchnrfRsvOz7L4sYS5DXuxXhBktxamibk3kCd49yqFlv0s2Zrm9LpSmQqx+BwVBwOrPKB8inB9XTqVGnJ80yxxvvk/rB/s/IB+496NdSkpw7ulBlONx6uWXdumec+dvUP66LPnA+vmBW9rSaJgIIKjIgwrZPwwJnrdrzy15n+SUWF0zeEXzm5WyaFxeecLW/BU0jJ+tJroTtdwtQEXAzOmHSLUBFvWbRHVoK0+VbNg+tMPK7FTaSXacALhF9p+6Du9mLv2O+Lc0UmxRvnK5UCho8GkTq74amoWH3PnskzDmuH8Zj3JBWssQTIVwbxs2dFqk8oWEyxiu2p/vOLtJ41UahR8P7iAqKoUVWBV3NDcx3gQG5K83Uf3S/QrvIM0TS9aUHUmxsLgC9qyCV22kspzXXU5z+AeRv2ewfBZ4fqmGfAchBB3cs8AWV98BQpN3zKZYZa3fdoxD+PbMrzKh59CyMitWC1J+A3zw+ji5f2Yq4UG2wnouatwUfeTaG24hluZQHX+Iudaz5hprkVfGbUHi+rQrJ7HHtDZcGxE
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa4c6d6-6820-4957-96a1-08db20079dd8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:02:08.9881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JD3FasSCthaUYxwsY9rBjMG47v2NusheX4TAzcTWS8t9rVj07PKOHyZ/Xbj3bhdQjhYvKsmd2gEsQC7H1Hdx4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_12,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080162
X-Proofpoint-ORIG-GUID: hBHOSkR56TBsAuMjNtmR-C4otv-qawFk
X-Proofpoint-GUID: hBHOSkR56TBsAuMjNtmR-C4otv-qawFk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/23 16:40, Mike Kravetz wrote:
> On 03/06/23 19:15, Peter Xu wrote:
> > On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
> > > 
> > > Just wondering if there is anything better or more selective that can be
> > > done?  Does it make sense to have THP backed stacks by default?  If not,
> > > who would be best at disabling?  A couple thoughts:
> > > - The kernel could disable huge pages on stacks.  libpthread/glibc pass
> > >   the unused flag MAP_STACK.  We could key off this and disable huge pages.
> > >   However, I'm sure there is somebody somewhere today that is getting better
> > >   performance because they have huge pages backing their stacks.
> > > - We could push this to glibc/libpthreads and have them use
> > >   MADV_NOHUGEPAGE on thread stacks.  However, this also has the potential
> > >   of regressing performance if somebody somewhere is getting better
> > >   performance due to huge pages.
> > 
> > Yes it seems it's always not safe to change a default behavior to me.
> > 
> > For stack I really can't tell why it must be different here.  I assume the
> > problem is the wasted space and it exaggerates easily with N-threads.  But
> > IIUC it'll be the same as thp to normal memories iiuc, e.g., there can be a
> > per-thread mmap() of 2MB even if only 4K is used each, then if such mmap()
> > is populated by THP for each thread there'll also be a huge waste.

I may be alone in my thinking here, but it seems that stacks by their nature
are not generally good candidates for huge pages.  I am just thinking about
the 'normal' use case where stacks contain local function data and arguments.
Am I missing something, or are huge pages really a benefit here?

Of course, I can imagine some thread with a large amount of frequently
accessed data allocated on it's stack which could benefit from huge
pages.  But, this seems to be an exception rather than the rule.

I understand the argument that THP always means always and everywhere.
It just seems that thread stacks may be 'special enough' to consider
disabling by default.
-- 
Mike Kravetz
