Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF6074F364
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjGKP2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjGKP1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:27:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914DD133
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:27:53 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B8Ynr7022937;
        Tue, 11 Jul 2023 15:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=a/ptGN96a+Z84/4bTsXtXrQSAnR24HxplPnnMPQsFgI=;
 b=forZ4+qE33TD5XZ60mmUOaNiSQzKT8WZ7BJQvpPKzVyPv5/lXMCPPl09sC9eqp8fYoof
 B0XBo1v6wowjCV3LDxsv+i0akTUgRD6YiKhIYyeHB7gZ0fxXUjPsb7ygdGLYP8CXANBc
 ZC40ZD46rehSBXBzfLQZSBDxaGY9mi2Bvu7HO4OZFbs2kY44CHtisLXRvmENfRlLyfx8
 PjfPXJaNLagZPBjfffHEHWcghzvdubEd13dzU9vvRP+I7FvtYzjlxtmX6XZlA3OFWHGk
 n/UNJO9IMbB/1ZtP5NrDy/6aT3ztKmODgnQA+Jq9e8S+orfI67qJZg1yFXWR+h4Lsuu8 Cg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyud58an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 15:27:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BF3XJd004196;
        Tue, 11 Jul 2023 15:27:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8baa3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 15:27:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUZLGMHRe/hdyDpBfe7d9SlHEX5/QwBgwppOd0XcRnh1oHmylAOm1/7xMJUcE/yl4WIfuOSA1yaB/EoCUWjg/VQTmqo1D5q+DDTCf9bsFdDlYwt/vCmFVKK+3qJCx1loqMUA0Fu91XZKL1qM1t6qUMor+chJcWU+XHlWWt4ujU7YqIM2VKQMRDp4bnOwggo6uzRBbJddsgbnJZJzr/Ytdx/lWdkyr2dyCR/oOeYKHEzYj7ily0IG/nlev5Hen6s/YtC+/3JOwjIoWV4O6aa5czCyiLjnEojwD+z9RPsyaXM1DD2JHd267el0Tri39ewuFQrgLDtxIT0rb2KlINFeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/ptGN96a+Z84/4bTsXtXrQSAnR24HxplPnnMPQsFgI=;
 b=li1ZkapeuM2mVWljeLLqkUqTqfTDGTKbRvx7+qT8I7hJJEI+da3c+zJemV6lWtsdlfpfM3ix7ReZQiFA4hoKRSdcIHKV1p583FGJ36LtZ5SgZ0FdOxwBnlqRO/gy1bZVnGOxuP/RqtDVnjdIK4/xQHmzuX7lt9pptJjE7Onx2GAmbmV0Fu+e4eFY0Q18IgVA4CKrhaDkRqT4QcK8k6013FY0qFtCQzba1SwZNw6YKikvaZFTHzBXYCGyb5rqF51ugpu6jqYFv37hVnlCAz0p8LQyfY9Jl41c+xS5Q7qcqiQgQLiHY4H65XwRKcBKa/UXg2wBwPvldWQX5PD6CaPYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/ptGN96a+Z84/4bTsXtXrQSAnR24HxplPnnMPQsFgI=;
 b=PKoa1akXshXARTW/Zai2ZB5arxDDIR92fv2TmP7laQ4FDgnnX2PPDrSJ5xpe8s5ouur0TQuB0kUD6K71rSh1QEsgW04GxzJgMnfjX7LaFyILt5P2kSzms3AUdYGsObbBXMhSlOCI6xBl1jjEMK8ih6zdX7dFK3JrLo7KZkcNQmg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by LV3PR10MB7841.namprd10.prod.outlook.com (2603:10b6:408:1b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 15:27:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 15:27:37 +0000
Date:   Tue, 11 Jul 2023 11:27:34 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v4 18/49] mlock: Convert mlock to vma iterator
Message-ID: <20230711152734.hith252qxjbnz4bt@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
 <20230120162650.984577-19-Liam.Howlett@oracle.com>
 <50341ca1-d582-b33a-e3d0-acb08a65166f@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50341ca1-d582-b33a-e3d0-acb08a65166f@arm.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BL0PR0102CA0005.prod.exchangelabs.com
 (2603:10b6:207:18::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|LV3PR10MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cc0f04-d18d-4dd4-9566-08db82235b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAW5uYvX0R5yiuNiuJ7tkxLr2HuQsM6iYDns8bSpip3KQxk61fS3n4n5kW4XMnw25qgGysXBvmV24DHomAcvGUsllSMKKjy0vkVv1Tb7yKUD75nMQQUP4pzXHgqxYoWe+Q6ma7fXeXQ40AmX0+jsuUMc8626NN+BbqmTRoCtaWkRf3V52BBTVZzsNtfF4XUYpcwLmc12SoLTsOPeiUuBAYtxCt6FMWQj/uXQzxXB59tieUFFRFfL5Tq2GouXx/x72+2CoYt/g1XcLMOtNXmyizn6Gql6WCuqYVbp0lCpFIq3uTkEoQU+NkEstgoHzR/GeX36fdADweXRsdPCaqWoHMwA3tffcMaFzTG6NJtluVQQwjdA03MgDA+oyZ+kf0yDriJdJQ5doeF6R+F/1MN/KCSX7rgU/ooQm2f1NScBZjoV2wJqv32OnHXtpg/Xy0ur4W1czCjTqQlOonsx3aRRoX3X/8d5BdBn1QyVix4UVNLpOPOWFH3kiVRfwl9kHFvRV5giTFcKaspLXA1Ffk/czOpqkqBGqkNme+TxD/LSy5y8F+po5psppvPuBec20Ks4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199021)(5660300002)(8936002)(41300700001)(66946007)(66476007)(316002)(2906002)(6916009)(4326008)(66556008)(6666004)(9686003)(6486002)(6512007)(8676002)(53546011)(26005)(1076003)(6506007)(186003)(83380400001)(478600001)(38100700002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zg7bGf1PFakdrTGeCJL39deB1vfpHb1y2p+CScOfPdiCnep6dNAPTOzrA1bA?=
 =?us-ascii?Q?5pxxjmVi7l9XqHUANy11DdXiMs60mQiCe1gyDJsRELWlnuizcig6vi0hGLYs?=
 =?us-ascii?Q?J6X/VIQOwDCXC/EAPYhxUMh9BsRwbYFFmQDH7/LBxJC7myZIefWntMNLmTTR?=
 =?us-ascii?Q?SbLc7WOaF1Bce9/4MXY19ECT8uSay2FRfbDKV9rWCWs/Dzr61UqCCawmnbFX?=
 =?us-ascii?Q?l2Ptv7P37HS5IqNLX8GS0VPXE1JmrJ8GQTJ7DGVA8hrxEf2Xr/6KbsrG0MpY?=
 =?us-ascii?Q?wSKd7YxOSoUWRmHi0HwHgOkzTohqK4wSEE1SthHyp802IQDcHHqF7yQ104eu?=
 =?us-ascii?Q?d7wWHvJBMgEdUhNvdbCtbd1bI7jrHY0blHUlsZJTzc5J81GPCClWMyOBdA6O?=
 =?us-ascii?Q?Wt0wHAgOBGGE7W9CG51wqg0uoHMOEcXXTvqKHTwe8Z9SBuJrnFg/uPRCA3Am?=
 =?us-ascii?Q?sfBnKLIBCrmuZ4I6C7JcEZHXbVUA0CSPSQoy/PHUutzBSclB7WLrTP6EL/sd?=
 =?us-ascii?Q?BJ4lyik9oxjQh+JBxoEXPWm5tpKAd++rDTQaG6Gf5l40Z2YvIROWVpKON3B+?=
 =?us-ascii?Q?VUqLkmZy4+0JpAGX0ilMc4nvbmmrXvcQjw1SCbmxwIBoaVAjxOAh4wvtV/nR?=
 =?us-ascii?Q?dH4oidNaAvuTmY3J96LhzwWj2zevtdpbERFkh7t/lesDsbsEJnbAW32zbx7V?=
 =?us-ascii?Q?LwOj9auSnW6GMfiL54ymLqkjR85xvbRdb9IwAYTuj74Gc/e1IdY04qFUcnJ4?=
 =?us-ascii?Q?ucCt7p0y0MfJEbknR6H9bsC1AB4U/rJ4ACQAonr9Ej02A95gVf9WgJwe2y7C?=
 =?us-ascii?Q?wM6O+XEB2nk02cXNp6IcfXBpfMB8iuXxKQ4MFvNxOzGOdRahgVjZMd9rs7NA?=
 =?us-ascii?Q?6pa9HOZS+hfXI5DsRar++Ea8xuNafB/14wgvDTVFFzDQlgeNgs+HlBpVN6Zn?=
 =?us-ascii?Q?xIHzMIs+d1MnzW6ek8JZeVw1yD63bnonVBQqyO5g70C/a0vKQF0gByAIAzpm?=
 =?us-ascii?Q?3tuLcMnDuv14PW8tdScLycCBIeQRu6qDKSyr8l8brCc5YFtU86faTe2prVRg?=
 =?us-ascii?Q?5iHjPMMtgn+cV7GegECM8ZIO1ZWpOwQr9Sg619YvyR8yPLFQmFRkok7E6tBt?=
 =?us-ascii?Q?pMsqxbew/jqUEQKF6LiLW2StjwAqFhV2DhNDFkMleVjwWxknYz23aisHsJ3X?=
 =?us-ascii?Q?urCUG/obAlPoCUJ36fMkNw9vCnh25Ly9ELkUgeeQwCxVTcGSvcNSgdFMH/af?=
 =?us-ascii?Q?hWExPEypNXoBJJgdRAvkJBF3Nn0lkZ/Y8jc9gbcpf9W3X1viFSNuYilRQaa2?=
 =?us-ascii?Q?VsBKai1nHbWt5OYIvrDIWuuJ+Zg7AYqqdi6Exu3rEHPg6vVr73jymEG5+XwX?=
 =?us-ascii?Q?svR7sy5h0GF0BCdKqXIjq1GGYYNN8LdJQDTVOUnF37U/vB2J5zHO3bsBtD3X?=
 =?us-ascii?Q?mnX8+05eBVuCxh1et9jq80UUB+vE+UlBIquHVArnUMgSezUv9CmotOSgx9AX?=
 =?us-ascii?Q?tYwmI+tP3d1fCLih6TT07o+QxSbeB6AzMMJQybtHnCzqqWZZAdSWAxeS1R5T?=
 =?us-ascii?Q?utCqsQ0FD7JsqMa9TIvKwOI5FfeoT1rSgdFF52RCJfBVPTgWWhcNv6cebNgl?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vJOtDlmJTEZculMkrVsH7dOVK4LqPEPqkgNIsTBCup4uWvJ/yG5SEdZvAp6jEejRIyffHshJk0Opepfg/ASDW1Gwmf6GXdBlE6Vu2/sS7wAcXB7eZDRxKHEB5JD+HO/MP7Rh//ZN9DMdv0kMl5m0EvOmY0t27rT3HP9HwyJn+BstPCZEs8o4cseocq/KJfYNics7MxEe9aa08QZPYJqS7IIaGtztfjnzr7bXVp3JS0fEjZ7QTIbyVioK76a1H30pHhojOKWdRUyagHAhqqd2mVNpNoWntiMsqJKGW9rG+zsKGtOIYxun7UWIYwEqGnP/m6suSILw4lqVk+4ofYVvfEdePt4utbAkb7a06P8GO+S/8hhtsv7N27UbcRF/RuUsmKJh3MPVZJcPDWpZehAWxQgDpTISPK4tN3cB2P7I5YvZndGDR+2thmmkLgZVpActKpz/g3L+WNC+J2uT+5I022hYk8ZG8oPnue1crrhL1jd//jWFvIoJ6oG5n36knbLmNtq3POKZskMbPbTTUgk3qt28ICVSU3u9RrDQHss4MBBeExkNXo1X/6Wr7fhaefUDanqvbsDH+6mJtESTf2YMi4A5BxfMrYoxMB8zLHFdvHVBjyJ1dxuybPVxMMJ2Dpvy4MpZadd42K85B5snH7HLI0qOTKOvbM+OIEdgz2y4Zv0fVtIXMXLZKRMWR+LMtdij0YFEf7b/JHhWz8o905BMr7V54k4c6Mn23BbTrig00BfPOey/AAsH0j34ECayITxHqxzsapHwlAPwgd/mxenn1Tv9Q/T0LkU2+MPh250WuVE7UjbAgAcR9f2+rTgQ9D0K1K24qn7GFqPG/XDBU8WhVxMgGDRtvxGZ5doV7RipzxB//otK0qXlmzJAR0//D2anW3EAisHJ/QtVXqLwQ3n3UeqVIYUctW/3aqz1mlWbAtc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cc0f04-d18d-4dd4-9566-08db82235b27
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 15:27:36.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXaPuTojyxb5P/ouOGSKVMnlithJrzfCcf9HCopWj8t6QJVpp59e9pEdyvAAlccuUMXe/qLsvbLnqfHp/FPwpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7841
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=707 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110138
X-Proofpoint-ORIG-GUID: BOHp6hyewLokpqhrfDSdb6bzizk_dSTc
X-Proofpoint-GUID: BOHp6hyewLokpqhrfDSdb6bzizk_dSTc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ryan Roberts <ryan.roberts@arm.com> [230711 10:09]:
> On 20/01/2023 16:26, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > 
> > Use the vma iterator so that the iterator can be invalidated or updated
> > to avoid each caller doing so.
> 
> Hi,


Hello!

> 
> I've bisected 2 mm selftest regressions back to this patch, so hoping someone can help debug and fix? The failures are reproducible on x86_64 and arm64.

Thanks!  That is a big help.  Where did you start your bisection?  I
assume 6.4?

> 
> 
> mlock-random-test:
> 
> $ ./run_kselftest.sh -t mm:mlock-random-test
> TAP version 13
> 1..1
> # selftests: mm: mlock-random-test
> mlock() failure at |0xaaaaaaab52d0(131072)| mlock:|0xaaaaaaacc65d(26551)|
> not ok 1 selftests: mm: mlock-random-test # exit=255
> 
> This mallocs a buffer then loops 100 times, trying to mlock random parts of it. After this patch, the test fails after a variable number of iterations; mlock() returns ENOMEM. If I explicitly munlock at the end of each loop, it works.
> 
> 
> mlock2-tests:
> 
> $ ./run_kselftest.sh -t mm:mlock2-tests
> TAP version 13
> 1..1
> # selftests: mm: mlock2-tests
> munlock(): Cannot allocate memory
> munlock(): Cannot allocate memory
> not ok 1 selftests: mm: mlock2-tests # exit=2
> 
> Here, a 3 page buffer is mlock2()ed, then the middle page is munlocked. Finally the whole 3 page range is munlocked, and after this patch it fails with ENOMEM. If I modify the test to split the final munlock into 2, one for the first page and one for the last, the test passes.
> 
> 
> Immediately prior to this patch (2286a6914c77 "mm: change mprotect_fixup to vma iterator"), both tests pass.
> 
> From a quick scan of the man page, I don't think it explicitly says that its ok to call mlock/munlock on already locked/unlocked pages, but it's certainly a change of behavior and the tests notice, so I'm guessing this wasn't intentional?
> 
> I'm not familiar with this code so it's not obvious to me exactly what the problem is, but I'm hoping someone can help debug?

I think I see the issue and I'm working on a fix. I appreciate the
analysis and report, it really helps narrow things down.

Regards,
Liam
