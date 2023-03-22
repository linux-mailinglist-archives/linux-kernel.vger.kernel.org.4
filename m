Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3181A6C4F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjCVP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjCVP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:29:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8D850F9E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:29:51 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCXqM8011929;
        Wed, 22 Mar 2023 15:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=iT7tWPjtTDUvi4Q4ZfjNHUifauiSAcPckBMCgicUaOk=;
 b=E+tlQz7W85p38KChTy67W306dVAXYH6o5sbXlbRRthot/X3aS2DbN0bu3xBiCVaa30Hh
 Slcer4JYTVDvMcftRSwjp5Jp9z7sfk70whepYzXhn0rMFCAKv0CurAqOL2E9c2FcVIyv
 yKXY3z3/vQ7CIQiSMn/kCSfBnFoVvCjtQpyZWJkFwEuHDArI+Y9buLGwlUOy5OHWSKHL
 hmkvRl+YXbtUZh15cR8r9thWXnYv6gof3eTFelJcuXww1oL0HoOZDOxoC9PTQLTx4VIE
 xdJpmHAzdwO7DcuoLRxVbTNieJ+SpOhbP5+CdDQS5mTjlgkMUnvOpdMdY3xui668e6FI GQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bchc42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 15:29:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MEEQTS027627;
        Wed, 22 Mar 2023 15:29:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pfyexttab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 15:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRwZQCRxfIr2WYKlSYuds2kySbTVNrbyz2BwXxXMk58uPuF6/2sqBXHmtJNOgu/mkEirLF5cbaH3qvoUGK2zMJ1zRSlFPKUTf9tUGvfkKD6AGIfwx/POe7ebK+SWWe4JFeQkQ83KthD+V3/rRII6p01xh9Ar7IYU01aPqr9IKcZC3rJfY2lTHDFqx6IJJTSW9i5yunb6sUufhk8ho5W31BjxP6cx67akNq4WRzBfy/kbFQEoui+PkH9KoUHGagu7K30+ahRctxWGQWu0KC4U1f8Rq9WqBUCd/aRfDLjTo/VJNKMxtqBfQNg6dEOs6ztZd4HRAHGN5hOILzhvdegjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT7tWPjtTDUvi4Q4ZfjNHUifauiSAcPckBMCgicUaOk=;
 b=Uf2DlL6tTsgCmzF/k7Vs6oG+TItoaj5sKy71/Md+i+XIDIHg98gjrvW5qykldVtPc/PdFdO1lDk6hL7b3GvfSuzXChna16uVBcxrPMWE6GwbFodw84DLmjTI6Pb29QsNI2nvwz6ApAb+QZ5xJBVKziqvEPZPw14lL/XdnxpPJrosBcfqehdxdp8U3FOwnYPs8vx+MyAmEkx/9hxmiZDcBlxl93fY4MKDDs2vLi2GxY/6X6zKc3Yy3ANHN5mr1IN5yKPE97ZEN+o+o4Xm/w8xJ3XSzoaPEHQtqIri9VeNGeHgcnruUZm2mTbW9uM1eX/FsU2HAAHHJTJu5QVf4NDzvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT7tWPjtTDUvi4Q4ZfjNHUifauiSAcPckBMCgicUaOk=;
 b=L0oTPvSawLpzcMbbIL1ndFFNhktOeAh2wPsdFl4zANlQ55swZpTB2HH8q3nXDTIZHKwRg9AV3kpcC+YhS0ox53I9S03pl4pPUrLjR8I2R98JLca4vNSC+SMRCvz4BpeboTuuyKXT6YoIPZebxqJqUkDLBLpvBBubKOiSuTYLx10=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5698.namprd10.prod.outlook.com (2603:10b6:510:126::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 15:29:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 15:29:28 +0000
Date:   Wed, 22 Mar 2023 11:29:24 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH v3 4/4] mm/mmap/vma_merge: init cleanup, be explicit
 about the non-mergeable case
Message-ID: <20230322152924.mqffqk2wvn6qmqqv@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
References: <cover.1679468982.git.lstoakes@gmail.com>
 <ae4845250ae9e7d000ca28fe90e64a331f664ce2.1679468982.git.lstoakes@gmail.com>
 <256bb98e-4bc8-f094-5ecb-500827fbbfa5@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <256bb98e-4bc8-f094-5ecb-500827fbbfa5@suse.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0012.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3b4293-3285-430c-af12-08db2aea396d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lKlvWAzPmNIkGYY3zAuCCY7oYQ/vV1zmXbeFnoymgMf7OSxn8p8P8DoPkDrjZ6vSMuzqXlT3xYl+hhrq3N86S+1RthyhlnWHFWmtpu/n2ICTPlwtLMtn2XgtQyUmi89qjP1MVaLmhQ3YfemXu7UzWeloiON9EKuB/hB/O5qvR3CO7s5BTon5r0Y4azqwrgbgxvtn0I1XTPPlb6yra0PZleSxO5h2SKZ8nVp/AN8DpmweYg924Wgvi3B86araz5/gv4HDqH22ayWAseqWRSfXbAbVGloosi8jr6hCNbQl/tAdHnUwI9JKKlwP1UxjOaVnQfjPeY2ToNN9LDNaCgLBEEwvJbiBNRtsNPQlo5LT4jkoemvstWIQXy8TzU69L862jREDKd3QrH7fd1K15RyVA5jcEkw/ZG9Xyx35JTTr8q4TBEk7OpQbmSRwMHJcNnBw4niSynYgsxg7kpR18JQK0dhWhe5hcBtzwcXOwi/1QWZtFhwAU+8VQsPpJJlBsPDlrBtCI4Vd4d/SUI90CHKVaoi6/l0z865y1hKi4rXDsMTHufpeT7MlrvSGe7y8D42dBGVz9sdT+KaOzb7hx+Jxn4yV2z1w0hCVRrGzLUKILwg73Hl2vPef/BKllChK9BD+uvob/53/WCSEyoxO39Vjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199018)(9686003)(6666004)(6486002)(53546011)(1076003)(6506007)(26005)(186003)(6512007)(33716001)(38100700002)(478600001)(83380400001)(2906002)(86362001)(316002)(54906003)(8676002)(66946007)(66476007)(41300700001)(4326008)(8936002)(6916009)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?94OUBOttT82jFB2hFAGjHsI+lmeGZ2VnP4ua8ysFUnZGa+XayNXDKqXNybnN?=
 =?us-ascii?Q?eko8+KeLvDfYi+Flv+QIJpSHzzdOMLrAPiG11rSGvs/3QkmQdtazuEdHrJ4I?=
 =?us-ascii?Q?Z0BaoxbND63zJm4iiunz0607Awc5lv1Ktlr1WGC2HRFg/yWJqy9YvSOnAdAb?=
 =?us-ascii?Q?3DrmjcFbR9TbIe0P0v9XZt5Hhb3l0elxTMNNffmW+iv9X5tLwQqnuBZ+d1aL?=
 =?us-ascii?Q?ttNrSZoysJixZtsHhZEKaTRhVR6IUtRuCuWF4Cap9Fx0zQq/JfjSs7Ey8U+o?=
 =?us-ascii?Q?z0UyLknzZLPU8xUT/cIPyLO3kCm2sAewDNOJMR22q+zxYEzV8tPLSlenXlt9?=
 =?us-ascii?Q?3UueH2LZBCEdo07pLt7694TyCyqW7R+ibWDuBtFRZEBGIfLj0jgfnI1HbDQn?=
 =?us-ascii?Q?l2g45KnFNibl/1EIiKFaxMvL8A4xMr74ue8AezHiSWWgEwHpkYdxRveFCEuf?=
 =?us-ascii?Q?vfx1e7fozVnMzA8CqTtCN+h3+QmstjYZfxtyj30pvPEzFRK2+nMfBYfC0soC?=
 =?us-ascii?Q?KeODO+mZv+n+vrXl+GLQ2BieuR9X9aj+qxDPoACZisDqkeCDTJ3uKVXql7ET?=
 =?us-ascii?Q?vxXOifze72gfPjruK5RDXrl9aspzM6GKnmE+tUDko2BpG92ecPRAdp7RxxIx?=
 =?us-ascii?Q?oderZBndKBcBXdPPzx+v+hsLGP+FFACNSo6Ly1RJt44oIywvUjFjJCFGZvEJ?=
 =?us-ascii?Q?k75JuAPx/kt858Q0bF4cdMkzjCuMgTaRP1xRtn/03ij/rD66jTaXcI7z/vll?=
 =?us-ascii?Q?jzDZmf/51wFPFgxXLvRitFvcMziM5/xg/jFd3KfnmVn2friCbS7vAnlzUzM9?=
 =?us-ascii?Q?KaBzovPYTTSv4AGoambBytGZSNkb3asSlKuusDacPzFXVdeRRsaJV1rsp+3K?=
 =?us-ascii?Q?fu75uWMfxdsDngD9VGe3IfelLu+SWarX765TNDh81LA6ZA4I5ZHMKS46F6Px?=
 =?us-ascii?Q?GPctPUqRYlGBdg9LWHrymaGDm5GhxOw79Zgr0bopLONHNZLQwvMn4kHpl/55?=
 =?us-ascii?Q?pbao/CtpCEz0B91PyPEfWA5qxSwPsIY3n7i7RWmW9HWC8EcDgz87LoK+FEkY?=
 =?us-ascii?Q?W8r08/l5bjqn82UvawiS5QSuYsIJAQuv8qwCiOUcPTjX7jiX8KmBpPAUCJdi?=
 =?us-ascii?Q?3Rrl6cTboPPPG9r7XGqnv4ne52MNboA/UpsXTnknzSIC86Q5rsGlji3BaQh6?=
 =?us-ascii?Q?EpAo9CiTJjeqEr37KeLcYhcGcality/XjbDOWiRfqUSl3H+vkbz6Te7z/rhR?=
 =?us-ascii?Q?UefERu5/SChDB9Yhk6b28NJhmU5xww0QTCsOBKe4PyJGLCcSajONtuLLH9E6?=
 =?us-ascii?Q?O9yUGtnMwbTjZJbmZsl+98w/niMv8e9osWN8KKMfNAlOC6nnAQiBPxdUjrLw?=
 =?us-ascii?Q?cU2/tt32fpddHe5TRrStlg1N9W0MD9/2JmzhuSbT1Ayu/OefoRdmBi6rCHs6?=
 =?us-ascii?Q?aP89AEnDuh/tlizxf2btlUhhhit/+GvwJaaksYnzxHGNxkyHHBYC9LuBos/0?=
 =?us-ascii?Q?D1vmTtVKM11Pbmch+aLh0tKhSlNppGpV2y51PCrXC5VQ+1JfntaIO2JqtUnf?=
 =?us-ascii?Q?JCJVqfTAJ4Onz5f0ZV0/fXzYfj37qOTK+gWSD+wqAueNLvY0pPpYw+8Fa0ry?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EOFLo4o4aE5ExXHBFAI5Kf51CrdCOw0is90TN4MmkhfagTmGYkCs6HosonbY?=
 =?us-ascii?Q?BfKEPCzU+lArKdnBUgrEze+ggiqnDvX9iZBzq7w2UVHN9IKafdVF1uLRZ650?=
 =?us-ascii?Q?ad3h/5YdWfa7RZDR5QmbfYwyZ3NGeyNvQE3Olvw1C8m2JBQADZI2TxuPLfyM?=
 =?us-ascii?Q?jy7M+ujtzrINRHO1d0SevCcyT9EE/MvAFTiyQSOF8aVG4O6dnjDtf3SAkNFd?=
 =?us-ascii?Q?xvQ2lHhAWvxg++9G8PfEUTe8cLPK7s0vF5S33EMrHRk6ftEnaVQ3Frc6I1Hg?=
 =?us-ascii?Q?SjnT1z1ejVKcIbPfaPdKTqJax9RWcCHCqZgRaw+ogXVDL9zF5NpSGX7DfPHf?=
 =?us-ascii?Q?TiB7e78pjsJ3OC2rScAWgEOYeMD3hWPGpJK/I2kXb9xCjK9jAJOWsoeY6UAt?=
 =?us-ascii?Q?18lUPfl+FEASDe9NgH+ykafkWnctvPSG7zgntQ4SxSLmn/r8FCfRTimIarzR?=
 =?us-ascii?Q?5pXwy22lJf6IO58cxXactD7cQXQLWzMiGkca1E+J0jllDTtcNMjrom224+K7?=
 =?us-ascii?Q?cY3X61ZPMmMeVqnirsGaVkqEEdKpSEdJMwd8xgn36dZOjHE7tOBREg6EHSCc?=
 =?us-ascii?Q?zlW+Z/i7DaIvxg87mSSNnLnu2xHyqogIPVJ0+IRq7p2BQgjHC+L/r40+EKFy?=
 =?us-ascii?Q?TYsbtFpjBkIX3keSoN2u6y6zqaIG17PTh7okhMfBPDrgR0GMA0ChYSP6w6T4?=
 =?us-ascii?Q?5uGLjubjGOBmnBiU+CFTuIjeaxloiF8zc3diEPOgYiQzALsHF8vy/0f3gnX1?=
 =?us-ascii?Q?yJ+oT06EwWHAi3cYH9mwDFadfcLtOWBNuWbQCEezwo3Xzgs7bD1hx4FX2GOu?=
 =?us-ascii?Q?p7o+zWzfCmGP6/2qx5/j6mKdpTqN6Xv/8nmk4d0twgkwqEv2KYF9BEPXxFRr?=
 =?us-ascii?Q?BvJr+CL4BZ7DZ47HLdnYQQUnZAISvbeo3QMFXgvTGYT69a0Fr0aTF8ousPxS?=
 =?us-ascii?Q?y/GQCSYTK99bHjy5xb5SeHq8yqv0M1LjsXdvYIwfPO6ecJMnxhYH54SZkapd?=
 =?us-ascii?Q?MeNd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3b4293-3285-430c-af12-08db2aea396d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 15:29:27.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dp/ObPfbzB+tLV59ueKfHRL8OsQgy6zixpGaNt2Bz1XON87kUturnzykFQLtotvBmPe9SX3OxFfcMujL9khRdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_12,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=821 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220111
X-Proofpoint-ORIG-GUID: pUuWZgh5AzUqg5Hi47NgwfmbHNkaxHNV
X-Proofpoint-GUID: pUuWZgh5AzUqg5Hi47NgwfmbHNkaxHNV
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [230322 05:28]:
> On 3/22/23 08:13, Lorenzo Stoakes wrote:
> > Rather than setting err = -1 and only resetting if we hit merge cases,
> > explicitly check the non-mergeable case to make it abundantly clear that we
> > only proceed with the rest if something is mergeable, default err to 0 and
> > only update if an error might occur.
> > 
> > Move the merge_prev, merge_next cases closer to the logic determining curr,
> > next and reorder initial variables so they are more logically grouped.
> > 
> > This has no functional impact.
> > 
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Some nits:
> 
> > ---
> >  mm/mmap.c | 57 ++++++++++++++++++++++++++++---------------------------
> >  1 file changed, 29 insertions(+), 28 deletions(-)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 2a4f63716231..642f3d063be1 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -909,18 +909,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> >  			struct anon_vma_name *anon_name)
> >  {
> > -	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> > -	pgoff_t vma_pgoff;
> >  	struct vm_area_struct *curr, *next, *res;
> >  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> > -	int err = -1;
> > +	struct vma_prepare vp;
> > +	pgoff_t vma_pgoff;
> > +	int err = 0;
> >  	bool merge_prev = false;
> >  	bool merge_next = false;
> >  	bool vma_expanded = false;
> > -	struct vma_prepare vp;
> > +	unsigned long vma_start = addr;
> >  	unsigned long vma_end = end;
> > +	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> >  	long adj_start = 0;
> > -	unsigned long vma_start = addr;
> >  
> >  	validate_mm(mm);
> >  	/*
> > @@ -939,36 +939,38 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  	else
> >  		next = NULL;		/* case 5 */
> >  
> > -	/*
> > -	 * By default, we return prev. Cases 3, 4, 8 will instead return next
> > -	 * and cases 3, 8 will also update vma to point at next.
> > -	 */
> > -	res = vma = prev;
> > -
> > -	/* Verify some invariant that must be enforced by the caller. */
> > -	VM_WARN_ON(prev && addr <= prev->vm_start);
> > -	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> > -	VM_WARN_ON(addr >= end);
> > -
> >  	if (prev) {
> >  		vma_start = prev->vm_start;
> >  		vma_pgoff = prev->vm_pgoff;
> > +
> >  		/* Can we merge the predecessor? */
> > -		if (prev->vm_end == addr && mpol_equal(vma_policy(prev), policy)
> > +		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
> >  		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
> > -				   pgoff, vm_userfaultfd_ctx, anon_name)) {
> > +					   pgoff, vm_userfaultfd_ctx, anon_name)) {
> >  			merge_prev = true;
> >  			vma_prev(vmi);
> >  		}
> >  	}
> >  
> >  	/* Can we merge the successor? */
> > -	if (next && mpol_equal(policy, vma_policy(next)) &&
> > -	    can_vma_merge_before(next, vm_flags,
> > -				 anon_vma, file, pgoff+pglen,
> > -				 vm_userfaultfd_ctx, anon_name)) {
> > -		merge_next = true;
> > -	}
> > +	merge_next = next && mpol_equal(policy, vma_policy(next)) &&
> > +		can_vma_merge_before(next, vm_flags,
> > +				     anon_vma, file, pgoff+pglen,
> > +				     vm_userfaultfd_ctx, anon_name);
> 
> Not a great fan of this, I think the if() is more readable, but if you and
> Liam agree, I won't mind much. Either way could consolidate the parameters
> on less lines maybe.

I think it's more readable with the if() as well, fwiw.  If you revert
this to an if(), then you should keep the braces as it looks very
awkward without them.

> 
> > +
> > +	if (!merge_prev && !merge_next)
> > +		return NULL; /* Not mergeable. */
> > +
> > +	/*
> > +	 * By default, we return prev. Cases 3, 4, 8 will instead return next
> > +	 * and cases 3, 8 will also update vma to point at next.
> > +	 */
> > +	res = vma = prev;
> > +
> > +	/* Verify some invariant that must be enforced by the caller. */
> > +	VM_WARN_ON(prev && addr <= prev->vm_start);
> > +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> > +	VM_WARN_ON(addr >= end);
> >  
> >  	remove = remove2 = adjust = NULL;
> >  	/* Can we merge both the predecessor and the successor? */
> > @@ -984,7 +986,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  				err = dup_anon_vma(prev, curr);
> >  		}
> >  	} else if (merge_prev) {
> > -		err = 0;				/* case 2 */
> > +							/* case 2 */
> 
> Move the comment from this now weirdly empty line to the "else if" one above?

Yeah, this also makes sense to me, and brings it in line with case 8/4,
etc.

> 
> >  		if (curr) {
> >  			err = dup_anon_vma(prev, curr);
> >  			if (end == curr->vm_end) {	/* case 7 */
> > @@ -994,7 +996,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  				adj_start = (end - curr->vm_start);
> >  			}
> >  		}
> > -	} else if (merge_next) {
> > +	} else { /* merge_next */
> >  		res = next;
> >  		if (prev && addr < prev->vm_end) {	/* case 4 */
> >  			vma_end = addr;
> > @@ -1010,7 +1012,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  			vma_start = addr;
> >  			vma_end = next->vm_end;
> >  			vma_pgoff = next->vm_pgoff;
> > -			err = 0;
> >  			if (curr) {			/* case 8 */
> >  				vma_pgoff = curr->vm_pgoff;
> >  				remove = curr;
> > @@ -1019,7 +1020,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  		}
> >  	}
> >  
> > -	/* Cannot merge or error in anon_vma clone */
> > +	/* Error in anon_vma clone. */
> >  	if (err)
> >  		return NULL;
> >  
> 
> 
