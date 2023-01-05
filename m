Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C50065F3F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjAEStL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjAESst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:48:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E3D5E65C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 10:48:49 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUNrA002764;
        Thu, 5 Jan 2023 18:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=QxGFe5DQXlYlRgcUQjVm06xcldkCLL7qct+la0xNcRs=;
 b=J5LOhcqoyFBnv5lukaK2LaOg5kp79sG8y9xd7IBDHWUhxmCtoifuQ/eJg0Va8pxmbiRM
 hbOYpZxNLIKs6n/rqZiakSotWxCpEcMis0onpd6DCfAlCz8nX+Y5YdFn5LANpDUwzDcH
 WPlu4HCobqZnLq9rrZIKfuFvnkyFaTiRKgxfWsJ5sh+bUfpb9yjYCNCRADbmqs9NbSpD
 Veql8KX2/nNPso5kW3Wx8T5QTmFdvQAXuPPyYn1xAbwBhW7hJfwSITh2moZmaXmziphz
 lBEJkXWVgAvbCyCzABOuoQlNcru+slptsCLVxN8A1d7OVDcMPwtWILWZlXAYKy30JLGE Jg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp11myd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 18:48:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I4GUw012167;
        Thu, 5 Jan 2023 18:48:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdf0t3xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 18:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2eyeUKqh/cY5eUlsEHRGFIemWx/VL4JVU0jwSsp1Ybox3gqFiOzykieWIJQybRc0MDS4Z4BDkkMKTgZeebK1MRGtrw/j6E+BYX3Hndcs7VC4qsKFE1+175ZcZX9feGmEITBk+nlHcKwDMtvhCkNSsxn9TOYf9AQdgRTb7Ig6mLZ3KoyC0F/zFd3/fHol12Pc9DTYoXIqGIx3Z4Z4urO+2EwaaGEDuFEBb/Eb7dmBct59w2/2+TCOzu6QqueAFvhvleKunkKtb+t0DEfDHaN3RwwgrqQz/RRzU1w2CXUdxuhOsA2JA6ZBNpAEGNMzgezkbqLi3lXoJOHY/qb1kD+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxGFe5DQXlYlRgcUQjVm06xcldkCLL7qct+la0xNcRs=;
 b=e3ZbQcdcU+FDr35+ZHfVuyFJKm2MBk8MyzY3bCgByufSSdCCqyQL3jZMAQbJQPhny8MK60NdxmudCCCESEPyMQcSHBqPzc8ikxf6/jXlGUNNA7dytShwK9b1eBUCQNVofFBRkcGWY+pAxU5NEu5yaddsq+9zy3GgHE2IVDQLYsFJqKfiRBfmn/JnTEqRqZhAp0bC4RECEqJuwoL9BtAhkN+xwUOoyiU7xyXm5crXekFelfRITtMTjtoPqNls/+xiryVhSRk6J5Gna3N9w7Tu8hHGI6SFp5x5I0EyWlsDovFspZEMPZJM2pGLZgQ1LdJ7gNHNQbGDNqSvYDHWzbuC0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxGFe5DQXlYlRgcUQjVm06xcldkCLL7qct+la0xNcRs=;
 b=k5Vkcm3gYxyY+K3ViZuezuaewENipDiYfgURXfd4RXvP/z+jlCmsvKJQb0ZgO8noTRHsMUjUukzMIXZIPZKrI/0oC6I2pgZI7oPVNwU5r1E1psy0rzQFU70Qd3TP4wWpsFluChf9/CIqdIJmHQvtBjs10zCNmjb1E9yfPQ50CcM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 18:48:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 18:48:15 +0000
Date:   Thu, 5 Jan 2023 10:48:12 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] mm/mprotect: Use long for page accountings and retval
Message-ID: <Y7cbbLAZIxcL77+f@monkey>
References: <20230104225207.1066932-1-peterx@redhat.com>
 <20230104225207.1066932-3-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104225207.1066932-3-peterx@redhat.com>
X-ClientProxiedBy: MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: d225651b-ab79-4b6b-8642-08daef4d679b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GT/r0OamVbdY5+K9FtwEBG+nkog1djHZbl2eB2WJyws9Mhk+2/e1/v3V+pFaSY1LvVWeDdPULtJlloeBAVwSJUTBOhfsXhikOln8PHTEtARKXPkFZDMvAZqCdoVTR8bpLx/1nGMk5OvtuuGrH9T2bjYPGyT7djeafx6U6WRM9eAul4E0QUBNNJfg0Cu8ciJlE3XrNd1fqrG4Assw2HuIk9NiiD0PSjoE6fo1BJbKUdA+Jb6r+mM/GlDUZv6FPm//G7dIjv26AwCo5nFsxVs36km4BsF7Sxu/sZ85mewCYaUcJgD+cmzaysVVz3kIBt6G7oL0NqF7T+bLLJwtqaF/DVN/z18N9PiBLMpeCgbYwQWx3s6cpjqxbfqqdfa8e2UebH884TzPXiVbZAFJ2s5O6lqHrPi1GVCKr4vVXrKUAkJId2kraGJZZSLseZZjAjvhrwgEeW+j2SE/QsOE9fNeR7eWXVLgX3p46E/8tEEEnF89tOkTBfjvqTJnWcXbI180XE6C9sAVH/4GjVt6bSHD9UE6nESDpxOgt5LO8udyT/quSmKgWTyaqvDUDJhCdvJ+h/oe3zp0/Eb6i5ELGUySrrplgOurb6m2ItNpKuNhB6XKFc+q5XRWVZ/2ZPq0A2tC1rFWxQLv/C9Ypg4RbxHyOKeszBDwH7lsNODFvh82wEmANPmex++IK6Mzug4SOVeT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199015)(26005)(6486002)(186003)(38100700002)(9686003)(6512007)(66556008)(83380400001)(8936002)(5660300002)(66476007)(8676002)(7416002)(4326008)(41300700001)(86362001)(33716001)(2906002)(54906003)(15650500001)(6916009)(316002)(66946007)(44832011)(6666004)(53546011)(6506007)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v0wsM0LxSFNHIOhaXVpJryb00C8zUffcTeEQY6oOrmGBBqd+Jo0uSA9pFctl?=
 =?us-ascii?Q?EQokVY+hB9rOuCs5AxEzcLzSFPfMn5Q1Em9gEw26wI3xazmVne1LI3HhpaoW?=
 =?us-ascii?Q?iunECBsSigF6vfGQpQvaSD2xiLLgyhQTpZBMXvUSGz8kruWD/w/rzxWCe/NZ?=
 =?us-ascii?Q?MGGOWWgmQ5kx9ym/0t/mjpK9yPGn1lAlHl5I6Dqh/ToSF49Md/6+oHsJ8PC0?=
 =?us-ascii?Q?E0NO7p84+ufdFM7jDsefT+iA9c2rmGgMHh/9pDegJg+GzlNDRMfFswC2end+?=
 =?us-ascii?Q?zWPVyomdtvIgEaSiKo2IK03Pf1a3D/6wNSpDkErBJCy/zbrr1fbIvM8mWTuT?=
 =?us-ascii?Q?Wx0KyWvHkcuBeM0sznK/TwCbwU5LL8vI24i5dGzYI0sc7vwwVpgr5Oxlhi2E?=
 =?us-ascii?Q?hx3lR0gTnOfPTHmJ4qvZCzJnj1htwgaxSTU2v+kArFB1PtI1nynMzdEKOw86?=
 =?us-ascii?Q?xI/VcYKg8oR23NLFo6qAIi4f9snT10fmbhpDDHtD4kmvEIi2/QjnSeNY/wb3?=
 =?us-ascii?Q?RV4/ycKPA5A4FCRaz0Luhc2Cb22vnowyH+1dvVtz3w+rRKq83I+tCJCihCEy?=
 =?us-ascii?Q?13umbdJzknuTAEYJaXvuN0BcMH2bd3kYwqkOiv/6AQkF8ZoqNjYd6ez7jTxg?=
 =?us-ascii?Q?SZm7zJcLZCI+ufj+FP+9I4BUBruxFqJZHJJcLzsFNm8v8gBR+ZVWyM6l/b/Q?=
 =?us-ascii?Q?lskCeMcTpP6MqKKGLs21SEEmMbxPMPrSAcsRoFqFuL38us1ket0X3upDszVk?=
 =?us-ascii?Q?H4xWSiLwG970TCl6wF1D6i0qipiH+mIpLVDzH4OJWyda5jQPo7MqkbZbCrTt?=
 =?us-ascii?Q?XN96OflEG47eMkpu0ZkyRIObcJo+2fRbt6juEbu1Jwrj58dBLlaQ9A7IDuvP?=
 =?us-ascii?Q?+S13ZssuZxSz4yuH5/RkzPSih2hmgj/eKIHONMc0EwjPYXlz7JPbY5sykmj1?=
 =?us-ascii?Q?tBAbSq6FsQhJyE3ApEThPVSoSYgwKKXSIdt2Na4lMrCh0r4oOG4qVxmVpSic?=
 =?us-ascii?Q?KVe+hFjc9zB/kveC/JUIuwzklJgcQcP3ZXaOhFjjiARuMXRGBhmlZJzeaIw8?=
 =?us-ascii?Q?acfKXhNpqMwp0ezXKk5C7cZf1aVd6D9egMoUHEniHpSphVwUVujQETHoeK4k?=
 =?us-ascii?Q?iB/hNDl4IuzMiBBBh777qZ41V01p924v1ryUr4vFA7icl/02erDhA3oQTIt6?=
 =?us-ascii?Q?kXMK4U242zdcgXTsgC5RmRtDIavQNun/bSbZFwY+thPftgsIdewhzeqjPSwM?=
 =?us-ascii?Q?m7vQzqbXqA8ugJf9ka42NXM9eJyCV/hThni/0R2qzizAh4ZFlihP3KECk1G3?=
 =?us-ascii?Q?ofNsxZ3azi5QhPWe+PuGF0ZdURbPNLWxf1VsecPILWbwe95EwU5GKFQEDWzb?=
 =?us-ascii?Q?Vo0OWNShkD083ltS/iieTAJYb96Q63YoeFx0pLtI70umhpCFV+ZJSXaqGLQF?=
 =?us-ascii?Q?QQrs5cx64IYIiZ2RNzjcUfMY3HtUMVxa97QaWsk0Kb9LOIGmk5v9GPxoO731?=
 =?us-ascii?Q?DT5cccd70MOBS7RULMzL1W4gus0Ybg7iXvjQqb0miUi1ZwnjhuLjQ9cdV0if?=
 =?us-ascii?Q?neguV5xZJbWrfp1RpzAXV+9fiu7MOyYHoexf2ZR2u4zj8NZzRb++BiEnf6Cf?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mGqpWNr6FqX+0AWjzRQHaY67oAglPrsvGB/BA2scqxQDCbNNrtX7xcrWyXFq?=
 =?us-ascii?Q?VkZmF8XdqlChQfY93WL3mwpSBRJfEZqs4DrhVucY6zkZ9M+0sfhMd5CDXV4v?=
 =?us-ascii?Q?802xID1MNaz5NqPUNJMs2aNvYwvN+Q4xiFhOVn+PV1xMMCOQFpfWgGRP5/K/?=
 =?us-ascii?Q?7Ug84uVn5un71lckFHNwSMJFIqKfoG3uSrUfBsjEaqHrJGZc9s/wNn2UFIg8?=
 =?us-ascii?Q?SnGddgmJLv6N9zpfFdUNS9vqwvXtzoPt1ZeUZYn4TfkK1hggzPZxzd/8nsjZ?=
 =?us-ascii?Q?bU7eGd0A/GRZX9EXtdxicnoUbE5ljzRoFuljSdhxsGrqEYkH6hUmnr4BhBRK?=
 =?us-ascii?Q?oOwSWpHSwYzAsmAQ+bVszX+aQp2iVP5Erwcl/qLgE6fdfP6A+Rk471fMHubc?=
 =?us-ascii?Q?qS+PFAMzSq3cdLyh2YterDgjkaSOMeI6VNF1YJD8vA8IXXu7pOvi85gY0DuS?=
 =?us-ascii?Q?XkITz4QUiV13O05S6L3BAyXgyK5Mu/Y3gD3LhYuCmIcXYV8OKMtcWa1Q/en4?=
 =?us-ascii?Q?RhYWo5aQq1vg0wZbkLlr4YeMaV/Gqh4YIlqT9PBHH6P1E0J1MXwu9bRL3akc?=
 =?us-ascii?Q?O0qUGwdUWmWs6qqvWUAQFgZcG+9rsqiCGc+dgOapFqn1JXqFbURSz3ZemMOV?=
 =?us-ascii?Q?jOZQcP5w+LdJa9+6nj6vLJLkkgkvF2H53k0pusSto1XHkaRtyOFZ271xXztc?=
 =?us-ascii?Q?5HL+XVQ7H8AmOznkfBOg7OzYWSMhq1IG+RRj+l+19VR65IkUd5kgL8K/M1Mv?=
 =?us-ascii?Q?uYuMfF0XRHGCO4Hq1REsPOx5nvTUHeECUxRtsRArqXZFLFLrLLEPsqRRMCGm?=
 =?us-ascii?Q?3y/GMQqUmXFsOC8ItvYyhT3lsf8vsASiY+zqKKM8Fbh1zlrwNHok33Z+e5O5?=
 =?us-ascii?Q?ZdhcZRq4YFg9o5f5CzH+c0WjKyNufXblvAJuapPOYlS7FGsCDAwjunx2Jzdo?=
 =?us-ascii?Q?0OiAIIaMLTZw9ILJVLSXvWxsktJHdlF/QqeCBP8LT78xsXED9Yydu9p/Kure?=
 =?us-ascii?Q?WxYUSrAmg6izBFIN+NBMkOaqz6NRm7Lg4+owH+3Jr2/ZbsU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d225651b-ab79-4b6b-8642-08daef4d679b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 18:48:15.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3Vmyl8Mw/osal6pNdVVp2dm7x+ZGzKXx2mG9CcZUR/9cuGPXM/9x+s2Sy3cYsLvL+yFlyB/VP9rXnORy33lZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050148
X-Proofpoint-GUID: O8nkGx2J7z_En8a4uylZ18z4PI8oV3uK
X-Proofpoint-ORIG-GUID: O8nkGx2J7z_En8a4uylZ18z4PI8oV3uK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/23 17:52, Peter Xu wrote:
> Switch to use type "long" for page accountings and retval across the whole
> procedure of change_protection().
> 
> The change should have shrinked the possible maximum page number to be half
> comparing to previous (ULONG_MAX / 2), but it shouldn't overflow on any
> system either because the maximum possible pages touched by change
> protection should be ULONG_MAX / PAGE_SIZE.
> 
> Two reasons to switch from "unsigned long" to "long":
> 
>   1. It suites better on count_vm_numa_events(), whose 2nd parameter takes
>      a long type.
> 
>   2. It paves way for returning negative (error) values in the future.
> 
> Currently the only caller that consumes this retval is change_prot_numa(),
> where the unsigned long was converted to an int.  Since at it, touching up
> the numa code to also take a long, so it'll avoid any possible overflow too
> during the int-size convertion.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/hugetlb.h |  4 ++--
>  include/linux/mm.h      |  2 +-
>  mm/hugetlb.c            |  4 ++--
>  mm/mempolicy.c          |  2 +-
>  mm/mprotect.c           | 26 +++++++++++++-------------
>  5 files changed, 19 insertions(+), 19 deletions(-)

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index b6b10101bea7..e3aa336df900 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -248,7 +248,7 @@ void hugetlb_vma_lock_release(struct kref *kref);
>  
>  int pmd_huge(pmd_t pmd);
>  int pud_huge(pud_t pud);
> -unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
> +long hugetlb_change_protection(struct vm_area_struct *vma,
>  		unsigned long address, unsigned long end, pgprot_t newprot,
>  		unsigned long cp_flags);
>  
> @@ -437,7 +437,7 @@ static inline void move_hugetlb_state(struct folio *old_folio,
>  {
>  }
>  
> -static inline unsigned long hugetlb_change_protection(
> +static inline long hugetlb_change_protection(
>  			struct vm_area_struct *vma, unsigned long address,
>  			unsigned long end, pgprot_t newprot,
>  			unsigned long cp_flags)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c37f9330f14e..86fe17e6ded7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2132,7 +2132,7 @@ static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma
>  }
>  bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t pte);
> -extern unsigned long change_protection(struct mmu_gather *tlb,
> +extern long change_protection(struct mmu_gather *tlb,
>  			      struct vm_area_struct *vma, unsigned long start,
>  			      unsigned long end, unsigned long cp_flags);
>  extern int mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 017d9159cddf..84bc665c7c86 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6613,7 +6613,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  	return i ? i : err;
>  }
>  
> -unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
> +long hugetlb_change_protection(struct vm_area_struct *vma,
>  		unsigned long address, unsigned long end,
>  		pgprot_t newprot, unsigned long cp_flags)
>  {
> @@ -6622,7 +6622,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>  	pte_t *ptep;
>  	pte_t pte;
>  	struct hstate *h = hstate_vma(vma);
> -	unsigned long pages = 0, psize = huge_page_size(h);
> +	long pages = 0, psize = huge_page_size(h);

Small nit,
psize is passed to routines as an unsigned long argument.  Arithmetic
should always be correct, but I am not sure if some of the static
checkers may complain.
-- 
Mike Kravetz

>  	bool shared_pmd = false;
>  	struct mmu_notifier_range range;
>  	unsigned long last_addr_mask;
