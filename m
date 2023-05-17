Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9447075A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjEQWwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEQWwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:52:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B535B99
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 15:51:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGoep024508;
        Wed, 17 May 2023 22:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=RXNZsKc1u8yQrZsRfhREd8mkUWazIRxoVxoGYYi73XY=;
 b=rV5gXNDTZK9zgZA25ZvV4TwjTetGlR2j5RIgw29Txe/NLctYF8QVwben7dFepG0WSjUw
 qja54Rd4lQxpj0v3TCSUsxa8g2LfOY6QQycyXGWA86H38FLSaWEBPrcguFjeToQnvVoB
 74VnRG8i9bH7UKPaX+qJpX4wcTWCzV04Dz4CNqWqs6gM63La7vlbwmq7XOmy42U5IZan
 yXxn4VAwduBK6j0Khtsm0zbtGyMhe5+g8trL/iCD0wP1th7rEzH7lxZQ6ujq/JhT+JN5
 tJP2BjSsEtem30aE8dm7zR9YVs+kPNzhj6Q23k92zUlhglld8vXJLVKs6W0Ohlp79eNF Nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwphamm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 22:51:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HL0rHp004143;
        Wed, 17 May 2023 22:51:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10cb7e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 22:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLnL9yu5GGn8sA0yToSVykmRyUT0xZ+AXkWyjjflooC8sYgzWQ7LYgO7IIM8mw+0dJl8cjOjSjguWcv51dqPjydZTVpDdHCQSYWw62CWQ3r+7bO1pywtzjVagxWS4tq8EKwxg0UGOWmIVF5RBoz6UGcO7werFic50F3CFs7Symvd3J/dsAye8kMB+okpOi4oUAdnvl6DCccFwHPwMvePGMuAJ7O3RwAdYehlZ7cFlF6pqjszuqdgn4EE6cOgyksFEmQgyWYzuPLrhzBP4VffHpYvnA9316pdmroyOg3zWeZdzSZH57I9jP/GSqmM4MhF9aJQB52bgpAHkQN1a2nRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXNZsKc1u8yQrZsRfhREd8mkUWazIRxoVxoGYYi73XY=;
 b=lfTa0+9NmIUCsGQo+hzJ19zUbgVSfPkzFDDCd9A03t9DE8W3CFn0KZah2yNGcHNYiJWUz3Y0LX7K4x/OQsyyIUVlLJaJVz9FxITouVYFPy7K2fH4uQeTloYG13El/aSR/Ml7A0KK5zwn6JM8FLQZ5r0MoVn7RcC5qy7XJ0CGbctCGvpHn3FVvmeQAzQTw4gLAyi8inU41u+VXom2BLK2A7ynU4nrlkhkBUxngy9i3Plv5e+NEsSc2J7aSrCvNBDUJ5fy01l4xeCYTaAW9x+9lncZ2lxMyxNdXvp688du+uhtTImVfOrz77XI4oRW1cLTAYmIlsM8KbTRHyjrWsCUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXNZsKc1u8yQrZsRfhREd8mkUWazIRxoVxoGYYi73XY=;
 b=KJIlwqRbJ8a4jobVqaHu5HztMrGaXY1cPBRu7JsiX7ispFmZNE513XDTaImKQKaoeYPoICjbyLfEvKP3Um64etQYEcSE/rJvele8iJ3/N3upnhmUyCvTxvjBpYtJ2n2RgW1HRqWFNgAXuj1pmHr4p+ZV8yjA7Nckm88Lyfa3hHM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4501.namprd10.prod.outlook.com (2603:10b6:510:43::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 22:51:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 22:51:44 +0000
Date:   Wed, 17 May 2023 18:51:42 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <20230517225142.xbchqdmp6ma5wzkg@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
 <ZGOcAOFOjx3XPGqO@x1n>
 <20230516164907.5bf2qe7nn5bo7iaa@revolver>
 <ZGPjlVOV5R7x4CV7@x1n>
 <20230516225251.xwmz2oyebo7k56ys@revolver>
 <ZGTbp9LLNYG4ILXk@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGTbp9LLNYG4ILXk@x1n>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4501:EE_
X-MS-Office365-Filtering-Correlation-Id: a0732c7d-1723-4e7c-f9f6-08db572949b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ovlJUrBjQs+N+Iu6gUwHhkcSDkiQnMYeotJHRH7k4clyi2lLG4oWLyGzmIVLtseEQbY2VXsjV7ruWs2b4M7NyE6qMn/xhL5UJcHA8nCbGZRow4WR6oOHtKaFlND+/otLoPNmVmDmZQBozhmnXZyegHv0eiVJj5OwiWOtECZvXFE9v7RY/kcvAjoxhri1x6N4QuO2Ep8Aie4LsVOSLpQbC4GTB1yimjsHo5vO4qx2TBTiU0nCEpp8ULq9gVfHHijrBV5h/Dynza944hOCEGPL11tPfhEhXABKIvY8WP9RC9fvQut8ZSt+zLy5evwLmddYzfgttoXOtKkIULKNaqv3FnzP4EgXCtk3tCICubjMRPNe3LKp+fMpBObjaDG+l0l5hWY77tZwnO92nILSbYYQRcpalM+jumnZ7xgpZIdWS1MwdQBciZ6VrQ+oNN9qEgXFKZOhsO84iWY6hTu3iHioyq2IZkGdDkrXX+9ffs2uWfK5Qs9F1Yup99Y+3RJiKkGX2LpbmU8MHetg3N0VYw7K6ZKc+Lu/KBIV8sgp4Y1XWSd5z52A/UU+LV/bfme6aEqS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(66556008)(316002)(4326008)(6916009)(66476007)(478600001)(54906003)(6486002)(86362001)(83380400001)(1076003)(6512007)(26005)(6506007)(186003)(66946007)(9686003)(41300700001)(2906002)(8936002)(5660300002)(8676002)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iun0bxYBiyQuhRXojNB4OJeazvVnay01I6EELWF2+jW4ipMgm4kpeG96WPqF?=
 =?us-ascii?Q?8kAYe7W66Jnv8cPrpmuSxuyf+EkZ2Axxqr0LbuiABANR/Ae7Wxo/Pul4+qP3?=
 =?us-ascii?Q?+hFfUCEM1440s8Op+9gWGIrJZBz4FOY3AB+KW1F+uWjIULd/L9Vt2pi2XLlu?=
 =?us-ascii?Q?orL5z4wE06Uqkh7NeKhycL4zjc7nl1V6Nt2+LMDWjWPdp3CRJI3TlXkYxVuD?=
 =?us-ascii?Q?1N/8gGdPbDwjUEXvniygHw+TSsCLEVi9nzhjU6e32qItIhTMezr218Q1t5Ih?=
 =?us-ascii?Q?XMoYWnHo/lgufz3O9hXx/rHrjciKzjf3bDzzFgDWA0oaUuAew4qfOeTUbDVi?=
 =?us-ascii?Q?6mlfYXmR6heph5vPcogkEorwPvo/Is2gDcvaEVmm+tHHzc45YZDsAexu3ebu?=
 =?us-ascii?Q?IVBNvgOa2SlzWmra+qtGCF7/a8pThWD/u2Ynbu+fTnpNwPhP93lneTHBQO7l?=
 =?us-ascii?Q?dXfLpWgB29Flv1GTefDNxELobEWqj8wiOPDviNjvlcxujq7MoxX3v04rafcE?=
 =?us-ascii?Q?ZejhQbDwBi0WII9Ex8YFMmyoOz9WOsFBG9KWwNz3rdUkw+uAOyhkNPtYAkFH?=
 =?us-ascii?Q?OMpL8bN2aP4C4exB8Mk7f4UQLCd+Qy5iGd1K8RZB0i/PTNh+rr+0L522A/3N?=
 =?us-ascii?Q?THJ8gAgeBnX2p67CPpumQDqAkjCm3Al/aevr3fFS1kyJtI8eAGTatfLjF5do?=
 =?us-ascii?Q?f52Gkcz7SyYONwHkJuV0kClmZDBR40BswomsdJO9ysc5z+qFC+6Q30jwatG2?=
 =?us-ascii?Q?F1L7nn4mTFT3aH0tV40VHP6ARD8lUkQCTQYzHI48eRhr40VjMU70HIA7eSNG?=
 =?us-ascii?Q?2iJcM9swdrVGrYMvv9tlvIUsw/t+nTWbL/DjFI8JitmgXJvf6JYIh/OsFNaF?=
 =?us-ascii?Q?Phme6E0esDnFl8nZpaJXFAFJTpONILw7eiShaH7KAMv1JAy/yBWsf3Jb002v?=
 =?us-ascii?Q?LPc1qDQ//e56eWJZcBgqZzPnHloT2DMNA7bcCA5qptA6xMyssZZrfJx+SwlR?=
 =?us-ascii?Q?9GIT4KXGYwzPAUTkQPRNC1jyFPJ97z1s0VHH85utnru0cIECd7tVwOcUaeqY?=
 =?us-ascii?Q?GXqi2U+Ij2NHVQG5hrK4odQB4SSS5VWL/gnY2TLzjBC9pPeRmtKpm3DCMzzT?=
 =?us-ascii?Q?nf+R10xPUpqooBsfFhAmL+7pg/JTFiaU57NTjQQ4efCrXL0nHcR0/gF6XTbN?=
 =?us-ascii?Q?P9Uimi8dwCa/bim7wamY2vgpUPEyQ3U8+DIdfx+DsWQnJptuu+AGc2jm1EP5?=
 =?us-ascii?Q?AxAc3X/8RKFJE/0d1TvT88shiEvtwsfGI6BjqBNB4CxYDN33zHEG6fcrOIDq?=
 =?us-ascii?Q?UsfuUxFks7TtE6a5tCVaH/oJ5qU/TEcO2u3jUbAQDzeCDf+6uFTbIjmrPaN2?=
 =?us-ascii?Q?nWnLphaE8mjlI+gavgQiMPD96m8ESVbYDXWiEzQVDR/FiIKqSSi0v8cFGZoF?=
 =?us-ascii?Q?XE/qNTQBqXn2b55fEy9925q1V2Sd2R1pNz5KIXCdIluSgzbxnDolAAG/qlr9?=
 =?us-ascii?Q?c/0RYbBybUu/TSE83p/KM1n63pXfII6FfTgzSgtM6tzmMnLuoZvhszl6jZrC?=
 =?us-ascii?Q?HXKt0HOaQmjkDN3ILaduVua+zfQdICW/FhaFdo5q4ltWGIO7uD3nDd1aLd2z?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?381h+6l3pmpNLLbEcKGXBsE3QKWIbLdG1Ub2NCvKMPt0V9gli0RVNualjwev?=
 =?us-ascii?Q?LuP2PCp2CSkebki4C9WdNEGVB/tYoIce9tsjCQ3POQhdLyNBNLon4Okn/US1?=
 =?us-ascii?Q?jB0tQnvsP2w4aIK2Zf4J/o2Od24zswSjEMiQMNlN4m0ILBmRLHZh29Dr9OUy?=
 =?us-ascii?Q?5yUybbRtoKQGDsccvVbs5kULWPcCxv+iu43goBPNGBG4b2Zob3huiojm6HDD?=
 =?us-ascii?Q?OUQIxbWe4Bw9B5v7ciLnaMoGxFE2839gk+1FJLbBXuub9yx22ePV1RO1SYQe?=
 =?us-ascii?Q?I1hiPjYphfux8tZ0LwhTYkOZcn8D8M2+eqCm7Vp5pBuNYdZL8MaJ1FZDXVqL?=
 =?us-ascii?Q?L8bM8/G/IcMhW2VjhFVQgSQo3Ql2i7iN54M5EqBhTiVO3akwBgL+gsJvxgoz?=
 =?us-ascii?Q?6UupxzvywvexZR3vNNVjF6oq/jRy/OUcfKg4YE8fZcprRhcURrw+NMiuaxqV?=
 =?us-ascii?Q?X25jg2awVsAHKMjbmxpYUSKJ1ab5HsRIjhW3LuE1mIlZ8I9pQ6XR1vtPhUw5?=
 =?us-ascii?Q?IYlLs5HGufT73XRFX6bllI8neKc463d5JZSK8Kqw2edg6mwkvSMMxOgolInn?=
 =?us-ascii?Q?l8Bvq8vQGOjEKV7FvckaMwPWfc84FzbO2oE+V2tfDZppbPL34WWZKavawnWL?=
 =?us-ascii?Q?ewRsj4GC/0yLoPO2duunIMGe3QLJqglLPqnynI8DEfuOK7coFC5UP/8ECXKO?=
 =?us-ascii?Q?tsrnD9xS5thcyz4fJh7fPnYko1Sp7RKuOmhE/EycfvNoUyOTkwwOYS8UIpXq?=
 =?us-ascii?Q?UnwGb7x32eexbtcPMl62rgZxgl8UYRhE50upFez/OA6ti4PM7aYbtZcBH1Pi?=
 =?us-ascii?Q?o4H/gXk07hWiZOV2uC6EwIRgD5L3/DHgGdQl44a4nZuuy43yxwf4/VwPA1aK?=
 =?us-ascii?Q?kxLokoBEkxqRdXEbxazPsiK7u8/yVD19KZq57fgSIpqRG1SBVK7xURw1LUO7?=
 =?us-ascii?Q?9HpwiEbOL1FbbPBJHovwVe5IeprJsN9GR8AIbjUESfe6MOvXY/qS9LEm5LMW?=
 =?us-ascii?Q?VpXs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0732c7d-1723-4e7c-f9f6-08db572949b1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 22:51:44.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgHyr4/EYKreWP8+p5G8DdaR2Plbaqb8JZUHcrTtjV2x8+kj7Fcbz9A+7ciEC6Ut1EZXGpRHWUZ7Rvktz3tBnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170187
X-Proofpoint-GUID: 6nT41Tp1pp7lEfsrFCNPEDxmB6qvC8K7
X-Proofpoint-ORIG-GUID: 6nT41Tp1pp7lEfsrFCNPEDxmB6qvC8K7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Xu <peterx@redhat.com> [230517 09:50]:

...
> > > > 
> > > > I don't think this is safe.  You are telling vma_merge() something that
> > > > is not true and will result in can_vma_merge_before() passing.  I mean,
> > > > sure it will become true after you split (unless you can't?), but I
> > > > don't know if you can just merge a VMA that doesn't pass
> > > > can_vma_merge_before(), even for a short period?
> > > 
> > > I must admit I'm not really that handy yet to vma codes, so I could miss
> > > something obvious.
> > > 
> > > My reasoning comes from two parts that this pgoff looks all fine:
> > > 
> > > 1) It's documented in vma_merge() in that:
> > > 
> > >  * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
> > >  * figure out ...
> > > 
> > >   So fundamentally this pgoff is part of the mapping request paired with
> > >   all the rest of the information.  AFAICT it means it must match with what
> > >   "addr" is describing in VA address space.  That's why I think offseting
> > >   it makes sense here.
> > > 
> > >   It also matches my understanding in vma_merge() code on how the pgoff is
> > >   used.
> > > 
> > > 2) Uffd is nothing special in this regard, namely:
> > > 
> > >    mbind_range():
> > > 
> > > 	pgoff = vma->vm_pgoff + ((vmstart - vma->vm_start) >> PAGE_SHIFT);
> > > 	merged = vma_merge(vmi, vma->vm_mm, *prev, vmstart, vmend, vma->vm_flags,
> > > 			 vma->anon_vma, vma->vm_file, pgoff, new_pol,
> > > 			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > > 
> > >    mlock_fixup():
> > >    
> > > 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > > 	*prev = vma_merge(vmi, mm, *prev, start, end, newflags,
> > > 			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> > > 			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > > 
> > >    mprotect_fixup():
> > > 
> > > 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > > 	*pprev = vma_merge(vmi, mm, *pprev, start, end, newflags,
> > > 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> > > 			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > > 
> > > I had a feeling that it's just something overlooked in the initial proposal
> > > of uffd, but maybe I missed something important?
> > 
> > I think you are correct.  It's worth noting that all of these skip
> > splitting if merging succeeds.
> 
> Yes, IIUC that's what we want because vma_merge() just handles everything
> there (including split, or say, vma range adjustments) if any !NULL
> returned.

I don't get your use of split here. __vma_adjust() used to be used by
split, but it never split a VMA.  vma_merge() is not used by split at
all.

> 
> > 
> > We know it won't match case 1-4 (we have a current vma).  We then pass
> > in vma_end = min(end, vma->vm_end);
> 
> Case 4 seems still possible and should be the case that mentioned in the
> patch 2, iiuc.  But yes I think vma_end calculation is needed, afaik it is
> to cover the last iteration, where that's the only place possible that we
> may operate on "end" (where < vma->vm_end) rather than "vma->vm_end".  It
> actually pairs with the initial "start" adjustment to me.
> 
> > 
> > vma_lookup() will only be called if end == vma->vm_end, so next will not
> > be set (and found) unless it is adjacent to the current vma and the vma
> > in question does not need to be split anyways.
> > 
> > I also see that we use pgoff+pglen in the check, which avoids my concern
> > above.
> 
> Right.
> 
> It seems so far all concerns are more or less ruled out.  I'll prepare a
> formal patchset, we can continue the discussion there.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 
