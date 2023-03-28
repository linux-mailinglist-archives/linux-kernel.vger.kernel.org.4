Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1AE6CC013
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjC1NDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjC1NDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:03:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603EA6596
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:03:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SCxsUs002690;
        Tue, 28 Mar 2023 13:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=EKdVC5JCb+vI3xHG2mwkrsMd4HmEDqwh+VQy1dv1PEk=;
 b=lhW/58PkVBL0wqa9V0jOHXwmlBQxbKVwl7JccApY44SFZWeZ6weUmNwQQwIZSvOooIoC
 A3UDKvnDdgtG1MEqOm3oRKDYN9Hb7a3LMTn2Txyp73KJqJKSeBfWGjdjcmsAIF8vRliA
 eurtohoGw3IuLIijoSeNLkuQJiMBrkqYTX0OHdzuxxiiATjTjkz89gr3wa4uH9UnQW11
 cIC4xLd84dXe0Y+dM4ut9OcWdEFzyE3s5cOtghYC1IkwmjRPeLzueR6mmfH6/6ZCYdRV
 vjGWdmM2z11Iob2Rn9+wcF84eA0l2z2DTLtjD6/Rv3oVHrro/RSEEYJ0b20DIgQVbzdb tw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pm0qpg08e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 13:02:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32SCtWsI020336;
        Tue, 28 Mar 2023 13:02:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd6ky4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 13:02:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yuv/JmcYMUYqgFDBDcBCgKzN6g5DguwbTJ2YMhK9VCeCdzNsc61QN+SJ2KrH64MlvGUIM14uK3KTZV+Ke8xirB6iOztnVS5r/Lx4YZDkqLjU65XwZpHxKGSz8HRIyDmHo6Ubv4cekm5ghNJULxLmhg5xeysXUePwCn963NHIj2FLxBGziqS55zeYu6ezlDK4I/HauVMwiQRF98fbIY52OILd/1DgHkXOmbEtYIGC9WYfFWDEKTTTlcTaKlHyAjYTg3/Ji+NC1nxltrSYDARPQvpUz1VObMTEIiPggHFMkmpwqVeDvRa5XfCuXYdx7Ic8jqMZBg/H1yN6jXgljWNP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKdVC5JCb+vI3xHG2mwkrsMd4HmEDqwh+VQy1dv1PEk=;
 b=ZehKgL8uMk+Qf7wI75oiEnF5j3fKXAM79dbSMkcbCTgKBsgpghUhdOO0S1K1+HzaJFbz5UbHekjlbnXU4gXFEDb5kvhP4weAI0ilALDZf6m4S4aY3tiq311uHZPjKaIos62Lhv/SW4XsAeiZfJ5+BN8nnmIxSIKI3Tjw50bsL3+7vNxgG+nTMfC4PEVghWIzNTywiYRyJee/GWu9Lnap192lsR7xMJFn6UVyG93TYpZ9QstQiSzIWA6Igy63E5cL5Z3keC0VBs/i7/1C/JB611/K+IMWQUKxfuBcJidSgE6wK+VRUuljr8vqhmkq1Xk6gi0Ue+0a/9KP4LYHv+F9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKdVC5JCb+vI3xHG2mwkrsMd4HmEDqwh+VQy1dv1PEk=;
 b=jUhXs92zb3O9g2/tq6OLC+rQgqJr/hUadZeCyoWG4/T+8SJn1UWNe1QL9jZXuq+Ru2ZgFbzSjvWUrZdhWfJzG3doFvmdN6wTp3kRj4TP6Cji8c6Pj2ff09JzWtBqpS27sDxGW2lZ7ynDzO1c+UGedo8Jg0CG3cAtjIZ3a60A3m4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Tue, 28 Mar
 2023 13:02:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::9fc8:73bb:cc29:9060]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::9fc8:73bb:cc29:9060%5]) with mapi id 15.20.6222.029; Tue, 28 Mar 2023
 13:02:33 +0000
Date:   Tue, 28 Mar 2023 09:02:30 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 0/8] Fix VMA tree modification under mmap read lock
Message-ID: <20230328130230.gdmychfid3aggikd@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
References: <20230327185532.2354250-1-Liam.Howlett@oracle.com>
 <20230327123515.bce6c1ea3660e9b17db50c33@linux-foundation.org>
 <20230327194800.fzqfrxfh3nfmqwgk@revolver>
 <a017acde-7520-743c-963b-94a23c0f30c8@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a017acde-7520-743c-963b-94a23c0f30c8@suse.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 48800dc7-b079-4c52-eabb-08db2f8cb215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5AGTYr474qCoT7ObAstt4ni6eGo/H4lqnftJ/XC0ym3UAASUH2co5jkXr1xA/9JQMTRARaxpL9CZFkllYSeujbBUw8V1FWWEZnwsDycF7XaSnWDeLlu8Eg8DcyZWTyPbaxFUCJ5XccraqFyK2cXhsQxYn5e17Uf2wp2TvWiRxGpiyRLe/YPXowWj8HYi28+E3RycM7M7aXB6eBZc+wZZ9Z6f6JCFVt0dN+8V5CIEzqumisr/79LvvBWC/AFeO2S5dWMQuw89EbcB3Kk22dGW2VMeMHDlBTRUs9sWGxDG3G7ZXkWYNLI45e9Gh4bK9ZZmlKcQMHiWt8XitfSraIj1zTYLTrc21x7IMzYVRezKrPEMPoXQ0zmhS9vphxrLEPNkNRF9qcjrHIQl0YjW3tq9P4mZIECeTg3OX4tEJ0daIA+s1Hyy2TlQ56YrKJaAUplPqo9xrc6PKQBH+73+D08gylvRZubbzwu+3d3yJvzzRYpkuZAdhNpJOFejEwebbcvGbhrPtI/PgFycTNIaroIyYP6JZIgEFS/omlDUSU+N6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199021)(8936002)(5660300002)(6506007)(6512007)(9686003)(53546011)(186003)(1076003)(2906002)(26005)(86362001)(83380400001)(966005)(6486002)(41300700001)(38100700002)(66556008)(33716001)(478600001)(66946007)(66476007)(4326008)(6916009)(8676002)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1dsIfcjvGQQpu0NCOUzRX1Oe5MH6aKRKItc6D1Il3iTdRS6LWXcIIgb1Iuc5?=
 =?us-ascii?Q?qCX18arbOME++SEoj52KmAgKqM2tfWMKYda0/AVJri+OZlH0Vmrd6mpPGOQj?=
 =?us-ascii?Q?n/P584Zf7IdoaMLdo7uXE6d33dwqdLNt6RDqZUtFJf9LQryLnP5TzQAgqj1A?=
 =?us-ascii?Q?0Js2zizESue2prkkA+tOuJ2zDGpNYSI58WSG0V4wkKOGVscX0Aq16Fs93hXt?=
 =?us-ascii?Q?3o9RiPd8kE+DEkvO4w61o3o6HuggKCP0+xVKSUWUSk5lnQCsDk4u0TBKSAF2?=
 =?us-ascii?Q?0t1lDQg8Ou78/LpHBkVwimxa1U7Uc+ShWBJVJQ8JvyRYcUqJsgaD4zG6QkLS?=
 =?us-ascii?Q?Up8EainwMP4BSMaXka3bJfI0Cx09DzlL2NvCHGFBZg1/OA46k/qdYtwFKCb2?=
 =?us-ascii?Q?735kkGl8YvN06e53BnJyFvayGP15xcysd7o9mFMisx7xsju6B+b8RmrsHoAH?=
 =?us-ascii?Q?BLBB3mGKyc3ccLeAFvschBI3L4ZmnnBaVjB8dDkNmTxKe1YT9q4x0aPkr+V5?=
 =?us-ascii?Q?+lgohn6LFcNmPu4sst9m2cgsylV2P7PRyKaZAejdenf6mh8zchYLOSwiuqa8?=
 =?us-ascii?Q?nibZTETFdxpxx8J3D+sJMmevqGnfRFBCxqTwXu1XVYeLhbmS99/w6RiPHjLm?=
 =?us-ascii?Q?gqqQxjq/PnsD6SLpTT5gFGvW6i3hRYczvIki/fJGf5EfGnzwNP+1bSSzQpiJ?=
 =?us-ascii?Q?VO/5BwGoP0cDty+kIwWxFUeEWCj9/WQS3udzthhCd0+hhVM/uQqYZof48Hzu?=
 =?us-ascii?Q?OsEkbLdMQdJJlHG2tZfqImr2s8R//3PazQAgXEeM+SZQCSj06KggZ1SXkHnE?=
 =?us-ascii?Q?wjTq40PrACFkOz3JRh8mwPEoiKgABiLCiycd2FEjsMpRv9G6HwClFzMOIwwa?=
 =?us-ascii?Q?UGjMfU3qDKLkDvBmJKP6gpR9JDMrRJQ9lXAAulgj7EAvla2wEfFoDtQkVAn8?=
 =?us-ascii?Q?TG6JDfRaZK25x2a5o9umuQWFNykgIDwtySdT0IeAkBeUZil6dAUdyuFvVATz?=
 =?us-ascii?Q?fXJvD0PnK1Ccs/EKTgz/LH9lkEu4UCNgAe7oHEOET9QIz3qhAuYzRBujtCtv?=
 =?us-ascii?Q?/c91wmgpT0YWW7vFKAgd0qjgYWNgc0N2T6e2TPIEen19V8VAWcbOyNT8fFpf?=
 =?us-ascii?Q?GmbaVBEeJYlHfulSZoRDPqQqLpCEnJkdp8wKIUZcqAnQCC8m2qyALT9OPbXR?=
 =?us-ascii?Q?//vl4RW+wZgARK40GIC5T8b+81W6t3ROuRAt7lF7tT67JXD8oO0x4uK55OBG?=
 =?us-ascii?Q?q3h6gC2pYO9P0TN6Yrafpd5afpjE8G3rbSpS/nZPqQIg6EEAuqhWT8v9ts1U?=
 =?us-ascii?Q?STtO30kzIv/OqifU6of1UhHjCN6nf7lN/3VC28yGfBXu/OQsm+KJGiYw/dWS?=
 =?us-ascii?Q?QuYguHqsT31iXaszEIEKO+IYvoZxtcn8tnz1/7Iq7nwvQt5KR3PraSauSSpB?=
 =?us-ascii?Q?5XhzLJ9SsHQKQjos1flUl5/7hAwOik0/geCIXZA3ZeBawiclehvF/ECKnsfR?=
 =?us-ascii?Q?r0T03gjmJ6rzkD3Xt8OpstJ6uVSKEUo35b9uolBUjdBuYYgmBJTtmPcaHscu?=
 =?us-ascii?Q?lpYl/+SffVFRR939UZ7R5w8WJDfTA3cyRYCe830IcZDiK8pcepxkcVhXIzaU?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8QSLAAa4h//HOhHDSwQRCb56HMdwDn++AelB4HhHr5+SrzPEEjM79/o5qhmU?=
 =?us-ascii?Q?4+T8PQ6couXx9MXmEoYUJqlv/FsnVr2XDQiJsc1Tv9+sMVr+L8GB6ZaTsDgA?=
 =?us-ascii?Q?owX0/4n7EUsfJqDBAf8/0ASM+/fi9zI14SwzVhSFc7LVh28u/YcPCGnAx7P/?=
 =?us-ascii?Q?LBHuf43hyJdDJlfUsFEpWBI6C1JvAAq0AoQPFnL4iU5/6v2BcmzvUtqRcSIz?=
 =?us-ascii?Q?NEHmtsj9SYs40HrAjCQwDhpEF5YPf2Lbmhc8U4BpQz6ac5X/RqWP6RsqmO7c?=
 =?us-ascii?Q?5OiDZnYPTLh8Yyhx1vZvnMCMWHz/TtTITOqevK7dLXZTHi0oIAyiBQLlXJp+?=
 =?us-ascii?Q?8l1Peck46ffNl34otF/nTtqEdKqci5U4pT5y4wtTJb27GfkvasVhnH0Wy5SW?=
 =?us-ascii?Q?RaU+B1a/bS5excwORRJtdULHIIy3II5UrV5dYuwgevGACi4I0nb/FgdjM0Sw?=
 =?us-ascii?Q?MykjQr8K3WJpGK0DfLWkBGsllMSt9gotpGr3nY3HdMSHoNtBwgv34GRjpzQs?=
 =?us-ascii?Q?h6dm6+eVTtJpJljih4tUpBc44TUjqNxHI+7XmiNS8ds9y7t2XjO0ZGODbVzX?=
 =?us-ascii?Q?reuCx12oxt/LDf0cKjPZKoTM0C+L/teaetvZtEsu4jQeaoVRyAEZzq+pwEXS?=
 =?us-ascii?Q?zyd423TmcaDvzgSnakXx/KkviktseWtWEzuQam9q024+xTR3AEI/iYfHO7lt?=
 =?us-ascii?Q?9q9vjC6Bywb1jzYYHJxBLAjQi86UNFDrsGivK5JIAWyNTAiGYs4yU24eXhur?=
 =?us-ascii?Q?BTGMxDkkl78zZ4r/dNe0HpGzHJzqJDzZu+FhsAUM5A8Iisge/C938yGQepSv?=
 =?us-ascii?Q?iuIqCA4iZ1LhSfb9yARf44jdgnUWkh0kl78eMWAwmtlKrszZLV8dbx6FdtiZ?=
 =?us-ascii?Q?7+4zVH23mAHbJgmfJr2mbRS7nm+fcg+KojyXnJ7T+i5rEs8xziO81qKiK4Xj?=
 =?us-ascii?Q?8jEk8A83EoxqiwIOqCugMg5dz0VDMBY0Ydxbu+25sHE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48800dc7-b079-4c52-eabb-08db2f8cb215
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 13:02:33.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CK29s3lqRlET+7MSpkskUMLRUg5mSSM5wnsx3+Sl94mfsFVWfMzA6p8IGAtgLY7YT9TnxtPXoJH6kc1m3hqYlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280104
X-Proofpoint-GUID: FsyyBZ1ZxDsua-pVlPh5zw38mplQgnIm
X-Proofpoint-ORIG-GUID: FsyyBZ1ZxDsua-pVlPh5zw38mplQgnIm
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [230328 05:11]:
> On 3/27/23 21:48, Liam R. Howlett wrote:
> > * Andrew Morton <akpm@linux-foundation.org> [230327 15:35]:
> >> On Mon, 27 Mar 2023 14:55:24 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> >> 
> >> > These patches have been in -next since next-20230301, and have received
> >> > intensive testing in Android as part of the RCU page fault patchset.
> >> > They were also sent as part of the "Per-VMA locks" v4 patch series.
> >> > Patches 1 to 7 are bug fixes for RCU mode of the tree and patch 8 enables
> >> > RCU mode for the tree.
> >> 
> >> What's happening here?  I assume you've decided that the first 8
> >> patches of the "Per-VMA locks v4" series should be fast-tracked into
> >> 6.3-rcX and backported?  And we retain the rest of that series for
> >> 6.4-rc1?
> > 
> > Yes, they need to be backported and fast tracked to fix the issue syzbot
> > found.
> 
> Stable usually wants the "mainline first" which means fast tracking first,
> then once it's in mainline, they pick it and annotate with mainline commit id.

Right.  I meant these patches won't cleanly apply to 6.1/6.2 and will
need more than just a cherry-pick due to the vma iterator changes.  I
have those modified patches ready to go as well.

> 
> One question is how Linus would feel about this now for rc5.
> 
> Another question is if we should really deviate in the patch 8/8 backport
> just because it's not necessary for stable. Generally they would also prefer
> not to deviate, unless there's a strong reason.

Just to clarify, the change is to remove something that isn't necessary
at all.

> 
> >> 
> >> Patch [3/8] hasn't come through to me, to linux-mm or to linux-kernel.
> > 
> > Should arrive shortly, I received it from one of the ML.
> > 
> > 
> 
> 
> -- 
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree
