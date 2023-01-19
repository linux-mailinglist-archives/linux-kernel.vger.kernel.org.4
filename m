Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752E2673FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjASRco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjASRcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:32:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AD68693
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:32:32 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JGxEaB026055;
        Thu, 19 Jan 2023 17:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=CjMA9bYljKvFOnLrgHOg5syMRkLp+e/FCs84BJVbw28=;
 b=0lqpvbn0CZulYQAUvwQu2khWMaociMxla5wg1kbox7x1GEmizVbVwxi7xPCOVm9shwWp
 qCSsUjVIhhF0f9LCTO/BKmgRcO7JYuzj9tDp0g3BOASoVBj6HEaml2IzEWXgB37LQhg9
 spdTH1JKZRSYDsS1T8R9UrxYiTgSuW4RFwVkscof1DfxJ/ZTJrNyKa23+w4CpF/Zg/dX
 dU+oUrkOWeSNlxzfUEsCnt+MqkPie07/xApLSH0EkQX7UOklkkq+NtN2Z4+xcpLx5CuK
 WvJ9SdAeyH0QtuOQasRYXnSHejIaUj+4tkHd4MrjRwK9d2b9+vViZH7ehBNx1Zc00yFM Xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n78958dfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 17:31:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JGB9YA013489;
        Thu, 19 Jan 2023 17:31:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qme0795-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 17:31:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTXq63XxrGj/wWow9TVLVitIKTJ93kD9ysb2VIsdjmsr7e6Fr4saAU/e/5kXOHydQtUuTu8JwKhTt0gmjRq/FyVOxEt8N7Ooq7G/v/xHuv/MedECRogT2jmIv71+RFWEU25Cb3QZyZop0/Y3ZogZ2y2ehll375iTGds3pNJvc/x5hwgjm4RTpDu7Kwu/vEgn0Lidx/ShJlb69ARE2xyRtLqc0WVMQyJHkf+ymYV/FmqJk276rXHeEjm9WyNOwaS+AI+GI1dFgm6WwDN4+jvbqirPJNcYal+ZJIP35HDJZGntfgCm1Fl0fTgDzs0g2T7Yjp24qlcush4Ny2OYsK41gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjMA9bYljKvFOnLrgHOg5syMRkLp+e/FCs84BJVbw28=;
 b=FgdTogstz4K4aZjimVXOIWOlpX+YShQrUUUCnUmI9aoLYeyzNlgbbR3aElZnIhbsw04eigWSCiKIV7bXhxJaZDCmS9SF3373GkGoknuW352pab+zfTbz43boHQeRjj5DOeAT2IoQLO8f1e6Kw2gWswWMy9v97whfu3JpAdNiPSNc6H4wnOha2OJMB2l4E8q9yKYHEbsW77sUavlWIN6Y0VD/JyVlUIslaO8IrczkjPhXXCcMp/vFfj4EfuQIsnJbofmvixx5AOQpFFZeHVVz9QMVlQxPwyJCQtHJEtJ/vBBCX2SduL/kxRhK1e0l+W07XvWF+7dPc/vjxhiQ30GSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjMA9bYljKvFOnLrgHOg5syMRkLp+e/FCs84BJVbw28=;
 b=pjhOt63NEzgKmLWqCvqnzNlV9ZI9LUZjV/Nqrxa4XgDK4FIrtQGkLIpXb534/EQvAPiGaBXM5WKX1vFaYrhyEvyBKeFFWbcx9vf/Ve6Himc/YvvCOFFNLDGKG3UF13qOYfquXkPCPbZ0wnOm/BbK2xR5f/Z5iJ5nMJIFgGTPR/I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB6785.namprd10.prod.outlook.com (2603:10b6:610:141::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 19 Jan
 2023 17:31:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%9]) with mapi id 15.20.6043.005; Thu, 19 Jan 2023
 17:31:46 +0000
Date:   Thu, 19 Jan 2023 09:31:43 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
Message-ID: <Y8l+f2wNp2gAjvYg@monkey>
References: <Y8BtJzBLTpw5IR+H@x1n>
 <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
 <Y8B8mW2zSWDDwp7G@x1n>
 <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com>
 <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey>
 <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:303:85::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 2304517f-5cd7-42d8-cc84-08dafa430a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58cHwRmSWg6OPlxbIH3C+gvfwmTmTkjeNRRJidNIkKL6d9Rsw9rjHLXTC80nyXr2xpXoBTo0p040UnFHKoL2eDiQiz82gD5+eOUaymsvcsMYGSv24M3QWceyGiFflJy0fkKL5QF1LJVTRaKLS6wf6lFAR/MxG08LbaTdj7c4qY4WXdvMYOp6PkjXvvIq15ydB9IjM/2PF3rsvopoJEwjoEXjZ5FWQ68BYZQgEfFLpGyIeXZ0TINYxP7ub9ErTYJ8COskfZG+pWH1Y7+fNWFKlS88eO18wbhm2krNXXd1YTt+TaaTJo5bjUC+Lc0u2uKTKazBIkXVJrHVGGarkPJ+d7X0+MCYNY6+8emfodYS8wsPfDXJmHJepHyVooSTEOoGPlUSqkSnXGF+EGKhOK2XstZXwV85t7eYP466ydZrSAFFcCARwoLb/Ojijb1EYkuq5SCnfME9w/1jc05K2/4DcHJ/GQVSf7Mj9D8HBrzdmPqOaGX8R8R3rx/z7avj/yRD5UQuP69uK56WCsjFoLEfjn/8oJerAerde0/DQGRvADid5crYn8cdpDFK1uXYnnV120+mmxTG+dobqDJgTG+4jMkWAVCYbfP7ruakeMJ75OmrPmILcmD/DjfD+9bMnTEhwF57qr8strSnfuc9laQ6o+yjU4qyzyNmCZOEkm4Hp1b+v3D4xRJ6QCU2JeqIwZwr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(6512007)(478600001)(9686003)(6486002)(54906003)(44832011)(6506007)(26005)(2906002)(53546011)(41300700001)(66556008)(7416002)(316002)(66476007)(6666004)(4326008)(8676002)(8936002)(6916009)(5660300002)(186003)(38100700002)(66946007)(86362001)(33716001)(83380400001)(66899015)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KUlpiM6I3g6OSXRgt08tm+IcxFhwsx2xtAIQLSbedXA8sjHU7aq6AVcFmncy?=
 =?us-ascii?Q?a8hB/hXrAmPMvz+j3RPUJf5WNfLnGxSzeUoPDJbeYCKR4vm2OhnWUOpm3bUm?=
 =?us-ascii?Q?s401H5PMIvBK8e9msAhdyWLCZqsTFUwaW+MOFrMWTnH99zR7XQfj5cvHySki?=
 =?us-ascii?Q?1BCbm69WexS6h+EOpdB/JEboSbcj6IGUpk1cygf6NJlAFua6L7S9kl2YiS2U?=
 =?us-ascii?Q?O4j9Qjtd/c7J3z8dWu61lQZpkDaCCXSxADWjy06ot+Vi2j4pCXaEXlTW2E90?=
 =?us-ascii?Q?DzW18tyK51JqtDa567ceXJ6zQ7YypxBSF1CGMcFzMvH9dQ/iA5mP7sanQQwU?=
 =?us-ascii?Q?VyJsTZnppJVwjcxcIKWbZZPb9huJfPV9pKOa0P2/hYNtN98OGDbaO68TSm2J?=
 =?us-ascii?Q?amH1urKLbuHIqkMh0uN0Jlz9xvB0PWw7OWcLXaLjfx5ddKdgn1mMbefgOL/N?=
 =?us-ascii?Q?foWjgUVMF80yhjVHv8rt+9os4QoInB3R9N17n1D8xo5aQY1yp3V6ULf0xyUt?=
 =?us-ascii?Q?kZekF3PLVT2PkIrQNfYxIDTCdF9hCWN4A+X9Cvpqhi3ZUkQZ1lCabcV/RF5L?=
 =?us-ascii?Q?jKGfOwqLsfyAjjwrxuP3h6li/9DzGpuh0APcPJyNMBIREgKu21eHCr4fdPRF?=
 =?us-ascii?Q?vgvdKxwZIX7/WtRpjdTPbNuZ0K/n89LHRPEDcjSuskCwIuL3TdkxxomK9/9L?=
 =?us-ascii?Q?U5jaIMyQNSajd1v2nCsc07/jPJmH1zvyS6eA6ww6GcEkvqlf7n0ip9lemDFn?=
 =?us-ascii?Q?iNM/jOxVKizNZjLFozSYyB+NmOyIVXt9+5jVvTXMIK9BORODfZw+yW471cB3?=
 =?us-ascii?Q?TclHH7V2raOiSeUBd1l+gjemCxbFQl8shjdRSrxpa0pu77UDiwO12WWxw198?=
 =?us-ascii?Q?n5EmHAhrzx2TgnuN2KmokXUNFKuKfMA7yW4au+Xu2LrUUCNL8Flx9Xqe1wHZ?=
 =?us-ascii?Q?+PYvxZ7Mz6Q2KXM5SfSZNMvEL1fmTfALfbTVMYskWxVlFghuWL5fcNO+Ghdx?=
 =?us-ascii?Q?eqnSNQEm/2I+F2ZzA5lHnkgwlvlSdMKCTBH9w3YZIoFT6fu3+PdwIk1Zjwar?=
 =?us-ascii?Q?11qgkozV9F+GYdIVwFSioEsuA+xtruaSGOF5YUDFq1A8Z4Nz4k8HlAoKnuwG?=
 =?us-ascii?Q?LalB2co9LN5HgjonhgY57VL6lE3CPqVvtQutnZWIjW2wJo6T3ikld+5PrqAN?=
 =?us-ascii?Q?CJwmJnuzIX3ZUCyGtD1j6YawcY8Xb24Wf/2hrUUwNwDpb4QOYRtm6gUBQdwy?=
 =?us-ascii?Q?xF6l+b8n2P6YWe3CfWhDljv7XguZe4tDdA7N3Ubz3/WXTMpiM9WmEqs0rvrO?=
 =?us-ascii?Q?58FG4uuP8FwOcmCwQoDuvVXC22xGTMCF4pDUN26/rWSHr6J4ECxT6He4sA4J?=
 =?us-ascii?Q?LzAB0uVnnmrW1ugM/NaC6J1wlmdsJvMzp7jOXNZw0Q5dAWI7Aujt36jDmSvQ?=
 =?us-ascii?Q?PsVRe9u3qaDGZ1kL7a+kgKsUFOWWUMeA15ksH8Kwns+/W/f+e33DuhQGaShF?=
 =?us-ascii?Q?mWNDFhYii/MsUORLW93eu54jPxIHLdjoNIjnirTytSr+4fmIzIvyzB+0ibj3?=
 =?us-ascii?Q?L6z0DrqvgwaWLvzo+Rl60D9SDiM3NsdSwxRPnQ72rFML3UroalaH2KlxC8r0?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GUbXtqgPsGU5bpyMEuYEGq+0okt35hojA373TjHEs8Mf6ltMxcAH04KBFmoS?=
 =?us-ascii?Q?nODmNqMbQ2Nfv8fN/Bnx4MS4eMRw5+mBS6AEU4eUejGpy5wehlD4+lsioIGC?=
 =?us-ascii?Q?vjd0y9JUhEwyyQbgWZghVXeFC01yxbEOekNKY0xgd/w39qZ9W8scDF/LZaZq?=
 =?us-ascii?Q?PBe7XWxOXHt4xYiCovnNn7OQ+31or5DRIo8u+QhudrFy7ahjND9VVmUQt2cN?=
 =?us-ascii?Q?9yKcLtYdim87lG9Weza0/yNJYE1+yoVWJ2HXGium0Cku3d1IO9F+clhp1qpT?=
 =?us-ascii?Q?pC4dKVfIlqUnyndwgnhW6ewOfDIGKDA8oanSJFeCBNVUSb8Laq1E0LwB0fnw?=
 =?us-ascii?Q?fH2Zv350uwHznOcUDBnTE6aDALqOvdDeVHnhT7SkiVu32ZwZXQfPbATVP4KC?=
 =?us-ascii?Q?ISvh0jTRFGOTVIiIJu7KxwmFYuh6EGPVscajB6HkO/XtPzrZWp6DqAsOqBpt?=
 =?us-ascii?Q?iS6FWbqI1PQMr/PViIE1idzL4IHDv82gmutgrVXCVvs7APurflIjVM07rH6o?=
 =?us-ascii?Q?YZCdVvrUwZxQfoKdQ+cHX62532cD2asOlV+1NX41SliG1bH40cpo+fAuYiMq?=
 =?us-ascii?Q?n6rpLMmhx9gMT+pNuhtIp6EE8bx9b7fewVMh4IyWki6h+G80ZCZI6bJaFf8z?=
 =?us-ascii?Q?aJcGLm84ZjTxIjeBb/NOINeQzCjxW8yPpv77ucUM0EFwHk0x8OkgX1HW87pU?=
 =?us-ascii?Q?OqLmwKUA2LUraBYsqyd+x2MjWsyEeq3EZyN370XcYHvJXC+PJG0wvt/NuuL+?=
 =?us-ascii?Q?NPdB48U2NziTc9BvWOIdQbTv+4iBBQPnklwVxTrTDxpVPXc6e7MYdOMyijMd?=
 =?us-ascii?Q?6xt50kuC02fYL5HgTX4Cixb72pckvWrFI7kwDGk24LxA1VHn1W7ZaKGfY+Qg?=
 =?us-ascii?Q?6r8ZQoIiM1dOGHpXvxz3T83R1T3Po5Y76dhYnR3Oet/JufP7ik+sVH0OImUd?=
 =?us-ascii?Q?BZZxJsAKVjDNMRqb7nz/vtrUA/eR10eP0Flr10tFF/kRsMrksy1ygshNseU0?=
 =?us-ascii?Q?LlnilHx13fzO3maQrd+dGxcgTg0JibhrcZ148QIt2ZmQLJG+yZt+hsFsotg1?=
 =?us-ascii?Q?Ry6Jkn3g7cM0pWxdo4iYzDLdGdhUx7gP0BDiA6teb0BQG2RoZLVuWRqrUAel?=
 =?us-ascii?Q?nExAx4O81dq+wof4NkF/XwyYuloLtro6HA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2304517f-5cd7-42d8-cc84-08dafa430a04
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 17:31:46.6997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEOaZAzJ+OUenIypCPWKpJb3Ldp2eEI710aqSJYn3F4jpbnulFiakMesQeOCM/JLS9qNYR9ornG/C4v387zlMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_11,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190144
X-Proofpoint-ORIG-GUID: 5nwhaBKjaBC8s4wFYA0ujA7Omqe1yJS1
X-Proofpoint-GUID: 5nwhaBKjaBC8s4wFYA0ujA7Omqe1yJS1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19/23 08:57, James Houghton wrote:
> > > > > I wonder if the following crazy idea has already been discussed: treat the
> > > > > whole mapping as a single large logical mapping. One reference and one
> > > > > mapping, no matter how the individual parts are mapped into the assigned
> > > > > page table sub-tree.
> > > > >
> > > > > Because for hugetlb with MAP_SHARED, we know that the complete assigned
> > > > > sub-tree of page tables can only map the given hugetlb page, no fragments of
> > > > > something else. That's very different to THP in private mappings ...
> > > > >
> > > > > So as soon as the first piece gets mapped, we increment refcount+mapcount.
> > > > > Other pieces in the same subtree don't do that.
> > > > >
> > > > > Once the last piece is unmapped (or simpler: once the complete subtree of
> > > > > page tables is gone), we decrement refcount+mapcount. Might require some
> > > > > brain power to do this tracking, but I wouldn't call it impossible right
> > > > > from the start.
> > > > >
> > > > > Would such a design violate other design aspects that are important?
> > >
> > > This is actually how mapcount was treated in HGM RFC v1 (though not
> > > refcount); it is doable for both [2].
> >
> > My apologies for being late to the party :)
> >
> > When Peter first brought up the issue with ref/map_count overflows I was
> > thinking that we should use a scheme like David describes above.  As
> > James points out, this was the approach taken in the first RFC.
> >
> > > One caveat here: if a page is unmapped in small pieces, it is
> > > difficult to know if the page is legitimately completely unmapped (we
> > > would have to check all the PTEs in the page table).
> >
> > Are we allowing unmapping of small (non-huge page sized) areas with HGM?
> > We must be if you are concerned with it.  What API would cause this?
> > I just do not remember this discussion.
> 
> There was some discussion about allowing MADV_DONTNEED on
> less-than-hugepage pieces [3] (it actually motivated the switch from
> UFFD_FEATURE_MINOR_HUGETLBFS_HGM to MADV_SPLIT). It isn't implemented
> in this series, but it could be implemented in the future.

OK, so we do not actually create HGM mappings until a uffd operation is
done at a less than huge page size granularity.  MADV_SPLIT just says
that HGM mappings are 'possible' for this vma.  Hopefully, my understanding
is correct.

I was concerned about things like the page fault path, but in that case
we have already 'entered HGM mode' via a uffd operation.

Both David and Peter have asked whether eliminating intermediate mapping
levels would be a simplification.  I trust your response that it would
not help much in the current design/implementation.  But, it did get me
thinking about something else.

Perhaps we have discussed this before, and perhaps it does not meet all
user needs, but one way possibly simplify this is:

- 'Enable HGM' via MADV_SPLIT.  Must be done at huge page (hstate)
  granularity.
- MADV_SPLIT implicitly unmaps everything with in the range.
- MADV_SPLIT says all mappings for this vma will now be done at a base
  (4K) page size granularity.  vma would be marked some way.
- I think this eliminates the need for hugetlb_pte's as we KNOW the
  mapping size.
- We still use huge pages to back 4K mappings, and we still have to deal
  with the ref/map_count issues.
- Code touching hugetlb page tables would KNOW the mapping size up front.

Again, apologies if we talked about and previously dismissed this type
of approach.

> > When I was thinking about this I was a bit concerned about having enough
> > information to know exactly when to inc or dec counts.  I was actually
> > worried about knowing to do the increment.  I don't recall how it was
> > done in the first RFC, but from a high level it would need to be done
> > when the first hstate level PTE is allocated/added to the page table.
> > Right?  My concern was with all the places where we could 'error out'
> > after allocating the PTE, but before initializing it.  I was just thinking
> > that we might need to scan the page table or keep metadata for better
> > or easier accounting.
> 
> The only two places where we can *create* a high-granularity page
> table are: __mcopy_atomic_hugetlb (UFFDIO_CONTINUE) and
> copy_hugetlb_page_range. RFC v1 did not properly deal with the cases
> where we error out. To correctly handle these cases, we basically have
> to do the pagecache lookup before touching the page table.
> 
> 1. For __mcopy_atomic_hugetlb, we can lookup the page before doing the
> PT walk/alloc. If PT walk tells us to inc the page ref/mapcount, we do
> so immediately. We can easily pass the page into
> hugetlb_mcopy_atomic_pte() (via 'pagep') .
> 
> 2. For copy_hugetlb_page_range() for VM_MAYSHARE, we can also do the
> lookup before we do the page table walk. I'm not sure how to support
> non-shared HGM mappings with this scheme (in this series, we also
> don't support non-shared; we return -EINVAL).
> NB: The only case where high-granularity mappings for !VM_MAYSHARE
> VMAs would come up is as a result of hwpoison.
> 
> So we can avoid keeping additional metadata for what this series is
> trying to accomplish, but if the above isn't acceptable, then I/we can
> try to come up with a scheme that would be acceptable.

Ok, I was thinking we had to deal with other code paths such as page
fault.  But, now I understand that is not the case with this design.

> There is also the possibility that the scheme implemented in this
> version of the series is acceptable (i.e., the page_mapcount() API
> difference, which results in slightly modified page migration behavior
> and smaps output, is ok... assuming we have the refcount overflow
> check).
> 
> >
> > I think Peter mentioned it elsewhere, we should come up with a workable
> > scheme for HGM ref/map counting.  This can be done somewhat independently.
> 
> FWIW, what makes the most sense to me right now is to implement the
> THP-like scheme and mark HGM as mutually exclusive with the vmemmap
> optimization. We can later come up with a scheme that lets us retain
> compatibility. (Is that what you mean by "this can be done somewhat
> independently", Mike?)

Sort of, I was only saying that getting the ref/map counting right seems
like a task than can be independently worked.  Using the THP-like scheme
is good.
-- 
Mike Kravetz
