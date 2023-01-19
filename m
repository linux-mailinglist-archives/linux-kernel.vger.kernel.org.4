Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4226745C8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjASWS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjASWSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:18:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1ACB4E04
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:01:36 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JLT6nn020875;
        Thu, 19 Jan 2023 22:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=jBvVR8eMUPDGvnVyFTmNhVo8mwKj//WVrStVLElXt00=;
 b=wNPxDUuzuD/ogAV6MzlnQpShXZQyX+RV0+bqdaLh4uehLj310Ox3YHHNvmVejgejhOrG
 TkWqCnilljyR+yS/ogSnEYaSuMwG8+HyZOjpvdAbEdpJPEFoAv9ul8B2ethmftu16gVq
 QaKM5YB8Yv3X8WHbYvjDWowdPAIe6ByiYtIDuwIG7H7ogNnDuuiJ4UFwJ3f1GV40eeWR
 TuE/r2TKD7arb0pyz/UvJFogzmXfhoJhkIYsm7LaPU7080rD5Y2CZOQReByVvRLg+ONv
 tX3PmcUQAEsvdp5HsBiH7dWBtzjNfC86kX/6bVMy7g9nZZWNfdLXeSJKcR7eT8ed1j/I QQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medkgn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 22:00:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JLGuF9004631;
        Thu, 19 Jan 2023 22:00:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2v1mev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 22:00:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXPt5+JUI5gRj+QMy7LnV4YalnMY6YUESCSUnQUrbocIHNv3heP3Xd6zYu/r78x7vpLiH72rlUOLVlAqgw3Kzsh3RP+MmiAVsc1B6tvQnRhtOi3NI82wPW4As1ZasEB7S9yJ3af1t4VBiNCc3d/uOqtPMcjnZCuTBDPw0yYwDhUP1GIDIBRzNdZvyudRnI7YKsasnR78+yuxTWSwS6hSbxLVlevVfA/u2olcg7Lo7oTUrj0haiCOVicYwUqYSmMaGUY3qvt5HJ5t8GwXzgTDhVsvTWdFww8G3lW7lWCWTZn9mr7Li7m4E1oIVH8krnpWV9ZMaV+XDOZPURuahpPOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBvVR8eMUPDGvnVyFTmNhVo8mwKj//WVrStVLElXt00=;
 b=jYH5EACYsAwMSbOE/O0P+JiwQF41P+zmcTQOAja33rJhPgpEzikPw6kRKoTFQiSbra2NJLzefwi5jvlzt5DVqhEx5JtFeDssXZ6cPpsCCCpeNMILcu9kN6XVZ4vu1YBBRZJ60KstQ53gxl/NLo5oySIRYGM8v/mmHjUygadd8yQDi4c/UGBSl/DMkSFlWy5Vpbn8gIdEfsJXYH5TPAVkp7/QAt6sG8gPfvsHna0BahvDZeDfe86n9zEHqFnHmwjXjEA4vSQCUsucpwJy8sDRs1Rbhz+o0v5SVOkVhReC/TCTUfA/xavlYm3282rQ8LhUsvD/HKSTwaFVC1HwL0ibgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBvVR8eMUPDGvnVyFTmNhVo8mwKj//WVrStVLElXt00=;
 b=whyM2VODA2ty6lhqZADpFnyJAiiK/9dNvUG/lb1qxJs3fw5DCzASoV0rSwvSTbZImaeBKooTLnvmwbGFdQL3gvjCmVM+NlmYV/cKbb483hsRXVlYyqQN1sHc3oI+bGD92Tw3Hvm1Vbh5dWNOETh/jCz30FpPmFuJUXZGZYuFYfg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4205.namprd10.prod.outlook.com (2603:10b6:208:1d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 22:00:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%9]) with mapi id 15.20.6043.005; Thu, 19 Jan 2023
 22:00:36 +0000
Date:   Thu, 19 Jan 2023 14:00:32 -0800
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
Message-ID: <Y8m9gJX4PNoIrpjE@monkey>
References: <Y8B8mW2zSWDDwp7G@x1n>
 <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com>
 <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey>
 <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
 <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:303:b4::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MN2PR10MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3337de-d9b0-4449-2c3d-08dafa6897c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjG1mBqAekeRjt5s8lzfg+v5idkCm9s4a3zNER168jOxHiWIqy6VK3woWTQXJGj83dRZef9aUWjnHcEybdKnuCqg4igq4X7enRllurMgXt13kRWMGXAFMdGuIPTXw8qgWSfDS4q93duhEb3mbtPhxS03b8GDFFWQtz/AhibPfx3EsNLJWdzdQLks5DrlNfPBvRCnXgzh2fNsLoPDMm2rPfabYrm6NfTGo7bPk+A6Uf/3ix/g7Q6fL2dfbSEnP3J0m9MDRUK4Vv/UlmCsC9S9+6+83WEku6gpG+o8riM0GpmcxBoBtQX4Rvqnmw4s21VcgAnPA23rIzPpyk835iKUfLYNz/5YAvATxryBWh4YPU1drYoX/dNs3Cxho25pd2awW3lPcrbsi/T3rgARQ2W9Rj8EDk2C49CIWkD/RgKm1o0vDELB+HSlDgRkjndMS3LbSeQdmcavrqd9ZBk6Tr84gM+rz7+cSF99Guxfy8hVydaeQgWh9EdmEQ9ckScpnazLVBKpDXrRwhwThlDG3PMqWKxeADGfSsjmKfE+Wv4HM23SKm6rs4GzZb52E1gG8Os32xwZ2AdgpuxLgxCU4rLnENdlulLZW7rmzUCA/X5judWYwk5PtbGLoW1CgOyQROPg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199015)(38100700002)(316002)(66556008)(8936002)(66476007)(2906002)(7416002)(44832011)(66946007)(5660300002)(8676002)(33716001)(6916009)(41300700001)(6512007)(26005)(83380400001)(186003)(9686003)(53546011)(54906003)(478600001)(4326008)(6486002)(6666004)(86362001)(6506007)(66899015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ioy5gLyBV6psT3dcEv/J9yMIQUU72SO1V4QnCBjpHAEQfN60/RC3XR/gPfWA?=
 =?us-ascii?Q?De+fBdGomQ100Y4rxiNSM0J5hhukg3/zAlv5k3AUeMDgAko98IH6H91I1dP6?=
 =?us-ascii?Q?Z/KKKcnTmNmv8LBttKIWr8ULsceB1oHwkl1AyILYIwWUavbzRe7+YLiRPSrY?=
 =?us-ascii?Q?ZT4Qz3A65uPkVh7Phz2VnSnW3mFUjAEwN//82LsOTUVLRVObWoHr+WXpbC26?=
 =?us-ascii?Q?UrDyVrbNjfGP0oyuAc9WC+K2iQCqeHQQVwRxkQ2wI/RbphRZKkcw5KtTBOJh?=
 =?us-ascii?Q?PwQdLR81gWTudl44K+YZx02OW6taaFtrkAxME9iYKl2V2YNzq7q1eZ5JG7xY?=
 =?us-ascii?Q?JpEEL49vdz2RBpz134uZ9Msb3p9OdVwQrPhQlo5ayrWCnKX/6VM1cmDRyQ/U?=
 =?us-ascii?Q?tGF+pCOxLQDuqbwtfftiWsUXSxib+UX/8/n5/7xfup8BIP6ZztHgRsZS1780?=
 =?us-ascii?Q?acWLP0w6YYS8i1KPJkLCif4Yu/lAdC/QVitzZmKQnoFqwjpk9n2AT6jQlv7g?=
 =?us-ascii?Q?oxfoGginvqFbgM7o83njwH3bZV+uUdK9QPXik5UE1qslLBDcjZtpVYL7e+vI?=
 =?us-ascii?Q?vibCCZ5jDNZ09UK1QPVEU8DMfDz7EbI7DMaRqkcxTR1ZvxOTbsKMU0zqpGEX?=
 =?us-ascii?Q?86A8aqonajgfxRBV8dtUMuani7NslSNgfB6IBqR9lOp5BRTX2ySyMavxlscm?=
 =?us-ascii?Q?BGV3t6pZ5nr8Eqq6L2ZEqHLOW3VwfMB2wESa7tWLDuz7urJuLFIyCjLWJm/6?=
 =?us-ascii?Q?7Lozv4Np9W+7rxfyGq/I53j23LdhR5wfCaybSxmuNdxkch+VK1X/9nuKINWi?=
 =?us-ascii?Q?VRl2ZBTxcfnDX3PXPXrU5C7GCOQLzoW+hXW/liXmDUlzdaP0uy1UTQkMBnfD?=
 =?us-ascii?Q?nqeFyt+UBV5XgQwDJBx8ihUYcTePI73ttyYrxOyJJxrr4eIR/huBSYgn/Q6T?=
 =?us-ascii?Q?/wK2i3cZOIiwWgZHQhlx+mwL1JG3UX0Yf/rGZotEU14uYOfjt39IEiaOu/Bk?=
 =?us-ascii?Q?oDxcApipBcbvH+YPJBppMgKwFoa6VBjSbcvOnJsxUU8WfCWKc8lyEP5+ylTk?=
 =?us-ascii?Q?MNpCuGGlmyo7F/XAl9hXM22diRfuORVMWhn9c6XLxm4qxj6nBKEQ6ZcoYWNd?=
 =?us-ascii?Q?7bFKqIvUHpLXKKkLdfrO8p7k+R4U+Fi139vZwE23covvzk5fP/weV53p/hWS?=
 =?us-ascii?Q?pyQMopNinZ7P+VkmUmbaoDetU1ZDfe1VNt0YGW+77AoDItep9rPVL2PzkTzl?=
 =?us-ascii?Q?/KVh9pcZI63ld1aZzRT/vb+EYjBZS9RAHiF6X1N1wVOxzcIcZdDWlSepK4CX?=
 =?us-ascii?Q?tY3O4tOoTgQNYI4JhbESyUpJ2yGwVA94tE8h51L/zIvArZIJv23QcyxTllHD?=
 =?us-ascii?Q?fEN5EUA4VDg2AHuwzVMzexAQylz1xbze2T+DWj45a/ZFKd0C9h+z8u1p4pJW?=
 =?us-ascii?Q?m63C6qN2qWQdUSFHuUX4Z3vz+NxxPLvQTe+r/VdTrpMe3pB/jQEIJbIbqQFy?=
 =?us-ascii?Q?lJlcW/VAulFhjZi5ioEeM+aH4e2/UvViPkE9pHGtZEQxFgCOWxNgVsb0e7dD?=
 =?us-ascii?Q?PBwhh7zluzrjbLo4G/fsc+t5KlympRSB6UTjyBNdLcIgpGIRjM/3eFqQbWrg?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Km3iBLdb5G3X5bedaxxJH9zXjOvKfm5OPGp9orXGANPk6vPSWITHKFe+JW4E?=
 =?us-ascii?Q?t/XFEAH0c6J9Y4BvpOPpm/yBaw7zi1wi2D5K0NY2L9ELZhXVhfRk9urn/4X4?=
 =?us-ascii?Q?XMvyrcCSYKOef2aok7gENBIKfSvwvdCZWaPTGVQ4OGhKeYhNObrqBl5dg2bW?=
 =?us-ascii?Q?T3EjboLKDweb1N5yfHzT0hkKwkT4Ga18CgUECZBlYXtrbkomp5GSP+2WJ7+Y?=
 =?us-ascii?Q?BxJr5AigSjMJN+dcXdC2Iwvas7mGfEQzxTyEV+tir1sF2ghPoRUSaxQeLumm?=
 =?us-ascii?Q?EFDHp6+n9xUFNmsfADdWUx9eQYPLTVB/pqYDtrcfQ2ym5Gr9d74DLHwfrtCi?=
 =?us-ascii?Q?8m2idhWctGMhw2dYsXYLfciDgMyUA6TOwySMOb2HRUHnQI3UdU4IpiGOM2fY?=
 =?us-ascii?Q?avJ6JwDznltmWU9CvIFQyGXxmUt2IEhYAX9ZLYrAgOCsmwFMVoZZsIp+0pcO?=
 =?us-ascii?Q?Pml6aM/plvRADDjpYFjb8PaFmZKd/xN7BYovDdWIYOcFW5FYmI6HWYdHfx6k?=
 =?us-ascii?Q?QxZ23Hed1KflAJmiS1Bx0W+s/hfJ15zPMWJn4S8srNAYOZsHnTQN4BCeES2N?=
 =?us-ascii?Q?GCFU3a7VutIfHR8oCMH6bJDKIkEwcr6k0JLeKDpnDnPj0TqiTeHpNRVxuFYF?=
 =?us-ascii?Q?ucbuRe4xkdq0yN/QQa6AdK4E2KZHvHE5Y2xbhIeQnZaNRnnvwVVNwCG8pfFD?=
 =?us-ascii?Q?3W932aeEbD67johxYo7U5xYa6QG3jQxcNtl4QnA4bUT+8WjP8ZAWY955V+eZ?=
 =?us-ascii?Q?dEC7RR+PzEd2bOxJG9s/4IA2N4NT2NlnRZ4K2AsNtmu5V7Ff63ksS9Tl0YLs?=
 =?us-ascii?Q?M8F612NZPVSNIsCEpfJWP9cy2ARJmB0TPYoJBNnVrhZJsviGGgzchCapdQAb?=
 =?us-ascii?Q?V5qIVn467Zn16hr3BjXlJ8wwaU4+Fyz3t97efidqwn5WssSElROQ1m2G6/G+?=
 =?us-ascii?Q?SnEDNkIauLxO1yXP8XsN1PnuabOK4bVWfwRx0cyRLvA+3R3AR15gL8HJFDxw?=
 =?us-ascii?Q?EbHkFWD7+s4WHsJZrz5bSQrFnPHjCcQc+uATW0cNrfyttcEfE35byw6mECrA?=
 =?us-ascii?Q?79UIk03fASXNid2O4CstuNhR6LyCXaVEJ3QlGhL0g3/5qh1/vQniVpyVNqTR?=
 =?us-ascii?Q?UzFfN4aupmwiuKgZPiKDDEtKA14s5m9/KQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3337de-d9b0-4449-2c3d-08dafa6897c3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 22:00:36.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaULk3QBytnCIUuwP0jTMb2wAm08+hnLxJi8tFIpchb/Nilx9iNA/2ZTO5aB6T6RThsPtdO88t8KymaALWVL2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190186
X-Proofpoint-ORIG-GUID: TAV2GewkGNZc_ZSqhxy-qZ1EbAE4tHHs
X-Proofpoint-GUID: TAV2GewkGNZc_ZSqhxy-qZ1EbAE4tHHs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19/23 11:42, James Houghton wrote:
> On Thu, Jan 19, 2023 at 9:32 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > On 01/19/23 08:57, James Houghton wrote:
> >
> > OK, so we do not actually create HGM mappings until a uffd operation is
> > done at a less than huge page size granularity.  MADV_SPLIT just says
> > that HGM mappings are 'possible' for this vma.  Hopefully, my understanding
> > is correct.
> 
> Right, that's the current meaning of MADV_SPLIT for hugetlb.
> 
> > I was concerned about things like the page fault path, but in that case
> > we have already 'entered HGM mode' via a uffd operation.
> >
> > Both David and Peter have asked whether eliminating intermediate mapping
> > levels would be a simplification.  I trust your response that it would
> > not help much in the current design/implementation.  But, it did get me
> > thinking about something else.
> >
> > Perhaps we have discussed this before, and perhaps it does not meet all
> > user needs, but one way possibly simplify this is:
> >
> > - 'Enable HGM' via MADV_SPLIT.  Must be done at huge page (hstate)
> >   granularity.
> > - MADV_SPLIT implicitly unmaps everything with in the range.
> > - MADV_SPLIT says all mappings for this vma will now be done at a base
> >   (4K) page size granularity.  vma would be marked some way.
> > - I think this eliminates the need for hugetlb_pte's as we KNOW the
> >   mapping size.
> > - We still use huge pages to back 4K mappings, and we still have to deal
> >   with the ref/map_count issues.
> > - Code touching hugetlb page tables would KNOW the mapping size up front.
> >
> > Again, apologies if we talked about and previously dismissed this type
> > of approach.
> 
> I think Peter was the one who originally suggested an approach like
> this, and it meets my needs. However, I still think the way that
> things are currently implemented is the right way to go.
> 
> Assuming we want decent performance, we can't get away with the same
> strategy of just passing pte_t*s everywhere. The PTL for a 4K PTE
> should be based on the PMD above the PTE, so we need to either pass
> around the PMD above our PTE, or we need to pass around the PTL. This
> is something that hugetlb_pte does for us, so, in some sense, even
> going with this simpler approach, we still need a hugetlb_pte-like
> construct.

Agree there is this performance hit.  However, the 'simplest' approach
would be to just use the page table lock as is done by default for 4K
PTEs.

I do not know much about the (primary) live migration use case.  My
guess is that page table lock contention may be an issue?  In this use
case, HGM is only enabled for the duration the live migration operation,
then a MADV_COLLAPSE is performed.  If contention is likely to be an
issue during this time, then yes we would need to pass around with
something like hugetlb_pte.

> Although most of the other complexity that HGM introduces would have
> to be introduced either way (like having to deal with putting
> compound_head()/page_folio() in more places and doing some
> per-architecture updates), there are some complexities that the
> simpler approach avoids:
> 
> - We avoid problems related to compound PTEs (the problem being: two
> threads racing to populate a contiguous and non-contiguous PTE that
> take up the same space could lead to user-detectable incorrect
> behavior. This isn't hard to fix; it will be when I send the arm64
> patches up.)
> 
> - We don't need to check if PTEs get split from under us in PT walks.
> (In a lot of cases, the appropriate action is just to treat the PTE as
> if it were pte_none().) In the same vein, we don't need
> hugetlb_pte_present_leaf() at all, because PTEs we find will always be
> leaves.
> 
> - We don't have to deal with sorting hstates or implementing
> for_each_hgm_shift()/hugetlb_alloc_largest_pte().
> 
> None of these complexities are particularly major in my opinion.

Perhaps not.  I was just thinking about the overall complexity of the
hugetlb code after HGM.  Currently, it is 'relatively simple' with
fixed huge page sizes.  IMO, much simpler than THP with two possible
mapping sizes.  With HGM and intermediate mapping sizes, it seems
things could get more complicated than THP.  Perhaps it is just me.
I am just too familiar with the current code and a bit anxious about
added complexity.  But, I felt the same about vmemmap optimizations. :)

> This might seem kind of contrived, but let's say you have a VM with 1T
> of memory, and you find 100 memory errors all in different 1G pages
> over the life of this VM (years, potentially). Having 10% of your
> memory be 4K-mapped is definitely worse than having 10% be 2M-mapped
> (lost performance and increased memory overhead). There might be other
> cases in the future where being able to have intermediate mapping
> sizes could be helpful.

That may be a bit contrived.  We know memory error handling is a future
use case, but I believe there is work outside of HGM than needs to be
done to handle such situations.  For example, HGM will allow the 1G
mapping to isolate the 4K page with error.  This prevents errors if you
fault almost anywhere within the 1G page.  But, there still remains the
possibility of accessing that 4K page page with error.  IMO, it will
require user space/application intervention to address this as only the
application knows about the potentially lost data.  This is still something
that needs to be designed.  It would then makes sense for the application
to also determine how it wants to proceed WRT mapping the 1G area.
Perhaps they will want (and there will exist a mechanism) to migrate the
data to a new 1G page without error.

> > > > I think Peter mentioned it elsewhere, we should come up with a workable
> > > > scheme for HGM ref/map counting.  This can be done somewhat independently.
> > >
> > > FWIW, what makes the most sense to me right now is to implement the
> > > THP-like scheme and mark HGM as mutually exclusive with the vmemmap
> > > optimization. We can later come up with a scheme that lets us retain
> > > compatibility. (Is that what you mean by "this can be done somewhat
> > > independently", Mike?)
> >
> > Sort of, I was only saying that getting the ref/map counting right seems
> > like a task than can be independently worked.  Using the THP-like scheme
> > is good.
> 
> Ok! So if you're ok with the intermediate mapping sizes, it sounds
> like I should go ahead and implement the THP-like scheme.

Yes, I am OK with it.  Just expressed a bit of concern above.
-- 
Mike Kravetz
