Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B20F60FBA1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiJ0PR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiJ0PRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:17:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9C5192D8C;
        Thu, 27 Oct 2022 08:13:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RDwpQK004242;
        Thu, 27 Oct 2022 15:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=hap363KyHpas8oX3IprFUUhb/5f0V4dGMFF8U95fRoo=;
 b=d8cV0u9mwIUNifyt35fEtVqLyZd+MoI9zZ4VAA5tHOyLzRH7EOxUueZOhTGBn9pVcIjW
 LWso1WBieSq3751LsBCYULUtGM/MHUdWWA8bxlt77kuNRUDAZawOEmLIA65jJ9jTZpXl
 9aaZbIVFgleTURhL2fX6x1xA5Lew1m9+H23LhTBFzboT9z3qEbJJfjUOTAM/jyB5IgCC
 TFCZzGwJl/l1keCOEFXgasJVVD+e9E8RLcwpZ3w5VCBqv4DOcjiD1c1EjgG4NQJEJxEE
 MAULF6ZCHfWWCGr+wCiRwh/o6iRcJfT0CSem1aabm3j8Vma3Gd5Ra1K5B78JgEVHuuWt Sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawrtc7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 15:13:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RDMdtk006533;
        Thu, 27 Oct 2022 15:13:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagh2jfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 15:13:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mz3ISvRWlcBOHHzPYMaSFSVcZjta6BTCIq3it0CUEmMbT0ZAelmCoJHzJBM2PhjfTepv0/s6FzJihc+XlvjrfHikFZcMJvzqEzk3IiRv9EADHA7pMf6nmMvmcEVpDvmKmsmiu9FZAKkBbfFOGJVzZlENIKWg5wbTnu3hi0Y9ihhKpIG21Po1vIgS35mphe478cfOlCq9lH4IVvpNOQOFwYraNoPXfy2YIeMrg1ng+NKd4PLr68RKfb1899Nihn18JlE4yjIiT9Fgf2khIjXHbAJvhSxHqYEAbSUBgsmbBfH0MFAIAIpB4fejLTgMcT4rfRqwJz9ROELqep6tdwlGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hap363KyHpas8oX3IprFUUhb/5f0V4dGMFF8U95fRoo=;
 b=PXRVNZuanF+NDWKLoEfuISDieSeDaFyJOA9ywkVavVFF6Wh7qhIEBc2FUPpe0oYbZSMVx7eOFqYqiz3snPAU24e4Qs9fi5BRSa+ukK1qWSJ7HQYEZKlTf5o+uP5KDefJJgVljFYl+j/92NgT2IB3hXJVDkkzjxDS0wHQcmcwnvC2TsP0t2qBxtX4MGhmzjcllY4gbSJ8Kp7IprzGDA8ITEf308NuBRNxopeRjyfEsWpZaxdR7OZ/17S13rRyiUAMo7n1W7OaobNnGpf2ZPlqF5QRGD5M4j5cqljKyGlhxSQfnTM8inbPt4PKGPAyQQYT+eOZRzAG/77LyTvNwnPACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hap363KyHpas8oX3IprFUUhb/5f0V4dGMFF8U95fRoo=;
 b=oDkcx6hk8DxLAGR3hsiFKs+37gzYKjTGG8/H+EKfnFFJDti68m9udgo/CSp9/J65SX5TfkurNmJGsBPcNHKb6C48u82K78uzSbySBjY6+gfVxI5RkRs5Y5bkaoSriAVr82ytvRzSzjo2qsF7bNHD6dTWo0F6VqLfMfX7xz0+4B4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5835.namprd10.prod.outlook.com
 (2603:10b6:a03:3ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 27 Oct
 2022 15:12:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e%7]) with mapi id 15.20.5769.015; Thu, 27 Oct 2022
 15:12:58 +0000
Date:   Thu, 27 Oct 2022 18:12:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     smatch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
Subject: DB changes and job changes
Message-ID: <Y1qf7w/jo8FH5I8G@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: JNAP275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|SJ0PR10MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: eafe9b86-1f2c-4242-c493-08dab82dbac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NRQBhq8hCOovsZvYWZ6mrqSUI/fbfvhiuj9bNzMofvc0fhZcmoRDv3eNOD/JQFhR81jCqJMNRhfEGrA4oQei0t4wuI3lDW7QUrIu20WQfQY2Y5U+0/5oVH/GivvmBwDmnoWohOZfYustXDtcfdXcdei45GisAMRhZbvV1Mg3uFFARQntt9+JO0coxWLJf/DAWCsLeGIDhn8uhTnfLeHvSTV7Vnm5VtPZzTU/BS1Z7+GGWBAvsHiHD4XDXb4L8SXjz4yN3xyqR9VM7ogJvqjP+FFDhzC5UxBivrveMt7jJDCT9cbzP0hNUGQxoyONPAoWqqVqLYY4lsIXJzH2mysuTNTgVlNlIH6WJTic/tE330mJylXSoLY5eSws9mrzZIXO4gm0lV9KQmQ3rDGiBIrUCWyu+40zFSMedDbHuasrI7oiJwB4N9QUrHYRu+My30ydAf9B4bOinybSA6iJcpir417ryPTr4ktfVoUhxWQ0hTJUb3NtID7CMo6vg5Ih3fjz/Wzff2ynT/I6ihM9f1bd0EWp2+O3F5d8XRhHaPP3cqS9WYPLJvmDkgqNjV4U7TcztD9vG/vPKPfiMuS1ZDcMuNmmRu6ZcxWVfSDJuOXA+g+re2U30I72cNAWDdPHLHIqxAcrrFGfMJwu43VaU3fn6Lor3tnQzo/UeBqK5a459cgapQB78UPzxFoSuNvJkHdxhB9CkFoapK2nInS3Pw7/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(6486002)(478600001)(186003)(8936002)(6506007)(83380400001)(38100700002)(8676002)(33716001)(5660300002)(2906002)(316002)(6666004)(6916009)(4326008)(9686003)(66556008)(66946007)(44832011)(26005)(66476007)(86362001)(41300700001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YnH+hNA/Wlx3U3JWmQ17LIx33sSyFPAkLGyibu05wKLTBintqExzlntktaxM?=
 =?us-ascii?Q?s9czFZH222JFcNeiIxAsQADXXDclXVLR+LKaYceAG/cQVOk25yvEPcoAmiBh?=
 =?us-ascii?Q?tUkB0Tbw/v1EKmPeH8QrzgI+cBnhj9ifz11R/zK4K5/IMf6ES2UEKYyRauob?=
 =?us-ascii?Q?YCBLXGmj/fxShd779kvaa96SN+HFMXx3tKaI88jGIG0HClvNcFa3DZn7SSxp?=
 =?us-ascii?Q?Yt6/wjAWCk3fWWQhCSrkS7zLY3TKvpaAC9uFjtUHT57PHmcNCOcVQPhZMpq5?=
 =?us-ascii?Q?xD2z/pfk7fTtkHC/KpLJUNh5+M+aXntoH5FGzJFIZBuRm2bwRXCayvYRcX1B?=
 =?us-ascii?Q?8bp5RmV9kiMbfg8JkvBbZ44TiArnfw5KM90QIbqVPmiCWVyFTAB7mxTfirsd?=
 =?us-ascii?Q?ZLNGV0F4JP/xGp+Js+DIL+wz5S6PukoTP4C8pOKC8BROHKrbuwznyqeWIRSz?=
 =?us-ascii?Q?H0pwzjRP3aAbaoPmOShfNK/ps5RqJaLZi2sX98w58Xi03ELKEiczgyJqBYoC?=
 =?us-ascii?Q?/elfydfbj5cumZVNqZZdYUzWKxUCkaydlIKGIlKAzDTuYGMlHtnM/kSDJmid?=
 =?us-ascii?Q?TkiV6oTFdBb8MEihL5lbxuD+dPQGPMddHx+7rYZT9Yy1GydL5879IXECOtI0?=
 =?us-ascii?Q?rY7GUwFhhYUlvNtqKUOuhXCbsaMdQKkLcBFeFOIm2X3EszDS7ibBIKCRDRmD?=
 =?us-ascii?Q?0qlxrbExuW+n3O87xbTwnpAt2lle/gA6FlnYPC+v60NF/qG1djowtJxQ+aMr?=
 =?us-ascii?Q?PBEGZq2fl23LzSVADxh0q68BxN3RegAU3IH/75Tco7iA5E9zfkehITdVWZk7?=
 =?us-ascii?Q?s1vvI+gv+pfyer+OXNQqraa6fPQKpTnA5VF688u05WRsPG4gcdLUyYCCMGFh?=
 =?us-ascii?Q?9VGQ/wActNJAC4mPGthPbyPeLqO8uzJnJBEPl9cjWXTvMAH/3CmxOt2ds+1l?=
 =?us-ascii?Q?dmyD7af2kpVvCWHlAOdyLMNST3ukCTADgNvXBnTWCFKhlYUwJsVXFlkkLv5o?=
 =?us-ascii?Q?VW/o6TWbNiQlUxl7AHgOV9rlCeDJBMNgD5O5rCpGDhNHkLwdnVKSKhi+uUOQ?=
 =?us-ascii?Q?Ez6B2dAuN59K1M5h9WJVH2vs1S/B/J9CORZJKN+3fn/XIqnRG92FWag8Egdm?=
 =?us-ascii?Q?5Z9uAqy8WY1hYqeG6A8W2j/gOFI3xMvYkO0R37hVq31WmYuRs52IKylRWESt?=
 =?us-ascii?Q?S6cFMBz+44J16DLnccD21IYTJxNfm0nmvgWRyFh71uqMFdbKhno8E7iK1otI?=
 =?us-ascii?Q?J3ABz7BL2ai33Dmk/9K4tkmpULQDAPMTC1zvJrJcpOz8jvYn9bPXHhkv8PNZ?=
 =?us-ascii?Q?yYxDiVVOQAYsSidx1+B6fBFhmoUGqXoMSLMEyZhzXsZzFWIMoIzm/GAiwlEF?=
 =?us-ascii?Q?DgZVKd3KS+eTEHpxD7cxrwzYDmOuwt5Qpnsv79M9Rcu4UyvVOmuz29T7Swll?=
 =?us-ascii?Q?z0QR108xQaAwCeq1FUGAMxEPm/vegeZ+yA3JnaMMu0ZzgaDnr41I/qM6FnQB?=
 =?us-ascii?Q?xR1gOe9Wr2iQBFbjCB2dBG+4Sxkm/5oY4Trke46k/EaQ9hrIVlEFQsRBTmYe?=
 =?us-ascii?Q?PTsT9Ksxt9OGLAo5m6kUyT5t6ksgav/yJ2Q1zqynCpykS8yuARSaqftsxqrn?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafe9b86-1f2c-4242-c493-08dab82dbac2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 15:12:58.0523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5qvtp3MrIf40lLY4xQImOtGvKtmX3j+2K2A9/j+i7W3EUO22aPEeuiF3zogt21XAWwBO7ztrMh6KxAM/smptXqJsJeY2Ete/Z6lvr+a8Fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=544
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270084
X-Proofpoint-ORIG-GUID: c1OrA8n7Qb_Z_pH0uYYQHC69JSuePQa9
X-Proofpoint-GUID: c1OrA8n7Qb_Z_pH0uYYQHC69JSuePQa9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple things.

I recently changed the DB from storing filenames to storing a hash of
the filename.  This cuts down on the size of my DB from 44GB to 28GB.
It's unfortunate that it's not backwards compatible but it's definitely
worth it.  Hopefully it doesn't cause any issues but let me know if it
does.  <smatch@vger.kernel.org>

The other thing is that tomorrow is my last day at Oracle.  I've been
living with my family in Kenya but we've always wanted to move to Uganda
where my wife's family is and where I have family as well.
Unfortunately Oracle doesn't have an office in Uganda so I'm going to
need to find another job.

I'm tremendously grateful for my time at Oracle.  In basically every way
except the location it was my dream job.  I'm especially grateful to all
the great managers I've had: Chris Mason, James Morris, Dhaval Giani and
Tom Hromatka.  It's been really really really good and I'm definitely a
bit sad that it's over but I also am excited to try make life work in
Uganda.

When I started kernel development in 2009, static analysis was not
widely used in the Linux kernel and there was a backlog of easy to find
buffer overflows.  Now static analysis is an integral part of the
development process.  Smatch has also improved enormously and can detect
much more complicated bugs.  I'm so happy with the progress we have
made.

I'm not exactly sure what comes next, but it's probably still going to
be something related to Smatch.  So I'm still going to be around.  My
email address is <error27@gmail.com>.

There is still enough work in the Linux kernel to keep me busy for years
and I enjoy working on the kernel.  But it might also be fun to use
Smatch in user space...  We shall see.  Last time when I was unemployed
I worked on the Linux kernel for fun and I'm going to this time as well
so you're still going to see me on kernel-janitors for a while at least.

The other thing is that if you want me to write a custom Smatch check
for your company I'd probably interested in doing that.  Or if you ask
me nicely and it's something for Open Source then I'd probably write it
for free.

regards,
dan carpenter

