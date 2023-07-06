Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C0674A4BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjGFUQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGFUQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:16:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091BB1727;
        Thu,  6 Jul 2023 13:16:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366K3jFo017763;
        Thu, 6 Jul 2023 20:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=rcCM1q3frfb2uqzdP80w5fDFeEjXv0n/0nc/A0BklzE=;
 b=Jc3HboKQ36SYFiZaBkkDAamCaidZUzCMBkZDjZT6n85WaFNcG0ZCr97hw86Cbm9CDHE8
 8bn5YRF+xS94LjD5eR01RtCyTP8M9BV/C1q1/6AB7GrDHLc9l09zCJ4BwyiWwCgkHg1y
 oDnhsjPY4muju2LnI0/U6W92F1A9TB+kI7WbEp/lW+7pmG8m8WVTLQRLAvdArU1M/E/l
 NCDYHamgtzCMbws0yzdz1z9CG1E37xn0FICixnRanBFjF2DhNdeTGyTZ87uHVmb6eZ6T
 lhdwH436zx9ZQOkCbeYALpWsVQW8yQODMl+t7FhY6874mxFcmsQKqy6sy/KR1Bxing8H iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rp3vy82qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 20:16:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366IXnuQ010152;
        Thu, 6 Jul 2023 20:16:08 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak7hn6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 20:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXdnwZUXcAvrJCJNdDE8swTUdK9L4IW95ruJJbfLVjuXhZ1uXgahQM+rdbkAdf/vF6W2Cjt8AmfqN6twL5VhvVR+PG/7ai4jSgJai+LpcVjVlPbfjFV92HShDsZ7J8VkBr2v90HgucxBfH+5BqRrZYAmAo0/3fTQN5EdJfNSq+1iuffGt3/kQrtopgJVrGKfV4wKycXXUYQ31IfHV72AoK7+vX93UP6vWkH4JLowjD26Y7KoLXxMFueeDXDZjOO9uGi/XR+Apgbm6IXndkaftlZeBg3vhE/sv7U/hS9MSNPRCvXmM/N9c3D9w7U+OMzE4HH0K4dGIbrro1S/2h1qoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcCM1q3frfb2uqzdP80w5fDFeEjXv0n/0nc/A0BklzE=;
 b=PcEkwP2AoiwOwZ7Ie9jmpCmPQ1aQy29fMX7dajmvgUl5VAf4h9/2w0HYJQDkwVDP3oSyOrUQ4PKbJTP5zHIJgvLL12V1Vv17/d2NUbOandIlLt1+Zu/nFaPmDPVu1lthM0JPxkdhWgo1yNkGltIrlXLJ4YBXo5Z/sxD1Ul2eJCi3N7UnBMbTmqepYUQmCXqTPC6cRJRR3op/BD5FUxUMdTkKbhtTolqBlXpqH8FcWQK+1odK4jUERZBvJa50zcbRQ88O4Yi9g8CtrjbXFq8o57oEQwFtPsPXaR5cgWs76OWh+BxcJYl7KSPb9l1kFdgsQXDfeOdf6OUAotwyXKF7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcCM1q3frfb2uqzdP80w5fDFeEjXv0n/0nc/A0BklzE=;
 b=kQI3GBEXgEeBFA6I47H7gC0YR7zi9fSmz8PI5ZP6FMun4uzwa6Xngomx/xK5q5RqmfZLEesqtEUH9nXvw1tIsJzCWq9dwPDOM49xWEvMywUV1EyQToJZPuWSbGI4EoiR6jYDbK3DkaZECc5vpzjrwQ0OPpdBVhtLbpwpJ4Lj7mw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7353.namprd10.prod.outlook.com (2603:10b6:610:12c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 20:16:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 20:16:04 +0000
Date:   Thu, 6 Jul 2023 16:16:00 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, david@fries.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, zbr@ioremap.net,
        brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 5/6] connector/cn_proc: Allow non-root users access
Message-ID: <20230706201600.kkgf7urekwt4y7r3@revolver>
References: <20230704001136.2301645-1-anjali.k.kulkarni@oracle.com>
 <20230704001136.2301645-6-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704001136.2301645-6-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MN2PR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:208:23d::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c3d9c8-b489-4b61-0465-08db7e5dd308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkElanLIZW9RsQlAaUiFM7X+IGTg7ou5kH0uo6CzNbVXNxTwR9iO4OpcBf6Hss9QnAwjpcBDHxGYhzA6wuhjMdIAF4KxqYwmNjP+H/E/Tfw3GykGWjnjgjXcxbxxTzpjJ8TUT+rCKmKsWxF7JjMxkh7Rs1tiyVkywLTwXKq0XbjeLE+0d62mRSEFXAHiodoCL3D94SSqcvl9aFIOCCYleTbHmboSe+WfBIthuEOKrQmX3bFMODNU06udJGJRNFEq0XI8bcZXFJkPZoiOmZBzXm746Ql8kEx4QCCP7BM3m2xNOf+Cy6A8MciiD/EHco9Lz8sSmBtJLkHACYjHb+akJKzULZmvzkj/mZvbX61becVe58utrOw5NFo6emJdTq2MMdEm14pm24hF73JJ1rkBsBM5addQLOAgMSxgl2SuwY7dpI1bDmPL1K73Z2K/GiOD1ZQ/SxMCU/haCfpykAIdSb1FoDu2TAprV3Gzw2RexEsTePX9LXSJj3dmrLLED1+J3EntybuHIJXPS6IATYBsmfvfQV7KSOE7QFnnJ50t6jc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(6486002)(478600001)(186003)(6506007)(26005)(1076003)(9686003)(83380400001)(966005)(6512007)(33716001)(4326008)(6636002)(38100700002)(41300700001)(2906002)(8676002)(316002)(8936002)(86362001)(66476007)(66946007)(6666004)(66556008)(7416002)(5660300002)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CcM4pndHDPAA5I97U36zm0CLt/q3/WY0McjOG9+us0JAft4e1DGD8ecO08Wg?=
 =?us-ascii?Q?aWOjmwta61Vsj8jkQw33makz4qUICsEjpz9fhLoReM/uWaeRDUowlcbMzF2b?=
 =?us-ascii?Q?GRuy9Bw+2XigLMsKL+cJaSYxFzaeAlubSU+Xf/0QWGRD8O0g617gCjebx3aG?=
 =?us-ascii?Q?KoXGlZ76ktkCSBafC4sH9f8sJNm2CmFF0mENYKJdJLPoPqykcvP+2bl9idhh?=
 =?us-ascii?Q?u8yw8DihDqYyhEMsQc7kJ85f6P59vedokiJpSHPW/wdNlz288XK3jmFpQp1B?=
 =?us-ascii?Q?lAoYFoN21ySTNtnTy/DeZvYTaj+AibEkCYD+9hFzDgFXxENGbRyYImQUzZ/P?=
 =?us-ascii?Q?pWbEkaPA4xzLtCX3VWvG5hSqvf8vYoTPaxL5twItPcynaNbbxXUBlb5kO7IT?=
 =?us-ascii?Q?UaY/GP1eql+OfhmpckkYbo46VqEMuFjfsm5iYgZRhcK4yvNo9W7oFhhgs/Sg?=
 =?us-ascii?Q?PUU70KPkVHWdDpv1Qm3tvzVcCKhLQFai4X/D56YOFXZnGG2IKWZkMEo9j7pQ?=
 =?us-ascii?Q?6ur9NoCTFV6GD7XmobiZJCmt/nzZWZG+uz4kSdtm8x6kMMV9K4TDkHST4Tsh?=
 =?us-ascii?Q?KXlrsWI512dMkNCaGe6eayiqrS2kttljurSrWLhkUke8sNlM0g95ct+uqre8?=
 =?us-ascii?Q?ilNKdSzR5WXGpmx+WxMhm6j+pW6oa+tUPKY5RB2zN1r1483E+Yr+K74JxVQW?=
 =?us-ascii?Q?/nS4peOyMkUnVZ1oL5P4ZX7LWYW+ndC7DW7tn3qtY/v3qL+ciKhqRqeKaBrI?=
 =?us-ascii?Q?jEVWNk7W2hm+P5qq5KIrBMVEvy7nS/cdGFg4DEL/PwBf0w+hh4kW87DcMXqA?=
 =?us-ascii?Q?6OsWmnHjl0AXWlv709IQ9O29jJcXlnR9fT/oX9UHWYT2A4TSGpu49rNg7NwG?=
 =?us-ascii?Q?0KtTxxouPjcFeTUyjQBOGJ6ABkbowIao7NJ1tEo2dYQcp4meCwXblqyHj915?=
 =?us-ascii?Q?YH/pBAqQQMvfQvCB3XJk95SV7a20ibvOJJ+1PiaiflHTqiiqUaQOuLdd1n0k?=
 =?us-ascii?Q?UoUxjoZRVyzhvopY1v2oG/cUL0xNgP2CNvcm3DW2UL5SvQ1SQH+q1VKzaT5f?=
 =?us-ascii?Q?RtIpni4NOrUIWw0acUOOe7K7QPn3NJgDmySHCyJvf7TBIoAq/fcv16ImMD6U?=
 =?us-ascii?Q?urK2i/i+ihi07iTtvf6Qz/zy5tedCH4TAgxT85A+oYNlPT/7b43fQQnKzKxK?=
 =?us-ascii?Q?Hu9t2pSem0OHti0fmLqbBcGp42rxey8Sr48UfOE23o9IIKZV7ny0mptCQMWD?=
 =?us-ascii?Q?8Fz+zjGTLJX3a+1+96m4zYOwr5HHiyAcAlIOYVqhhyxNsxdNNoaw1b7ee4nw?=
 =?us-ascii?Q?vPLp4PBtY5h8N3uGyv0pq0+Rs6h5qbdyzvPqL4MrvgmW3N7b74v5S9Ljr+qu?=
 =?us-ascii?Q?j66S1ZfCO3fNf0+FDbpxdlxOx+G3P9LGo+68JCJcoZBCmH63pteDAY9ZMrQ7?=
 =?us-ascii?Q?gLs4d0TaSLFXaDeIOXAgvws3ynlFnarsjbQ4x4yK+N6pQb5NOakzaOrHpYnB?=
 =?us-ascii?Q?VeaKuq1HhSFNm1qLEoKiB3vmKWfvCX5bUvydCje+MfLA19HuKFv8/2BFrsBt?=
 =?us-ascii?Q?V6qEkpjlM6lE5ilJIJM7I+ITLuwFChGUNO27NECyIxqUCGzI5tQKOZEU8m6v?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IJ48J0OFD57gLZEnW095rm6pu+nnzmWFPE5qZsDnCOnouzNW9gse5wsPkJYf?=
 =?us-ascii?Q?4kUwyQs7lWqe7ak4PEh3HAcrZfRg3fugbChjTPsvmCkcTEm9mReV/JhQSEky?=
 =?us-ascii?Q?9ojLOrOnvQw3fXdljEnE/SIsfQT6WL/F+WcKzOaqidR2oZKqf6Pk5wwQRpKX?=
 =?us-ascii?Q?mLGQfUBuwba8/H7dJe1LZpANOLe59+YmpDXAMmZzo2Y+OeHOJpOG6yEGteJZ?=
 =?us-ascii?Q?Bfys/wNn4umD5wyBPnYpL9aiqHiN7xIqZPwZvgU+2q/o4kJltnvgAl/OJExq?=
 =?us-ascii?Q?IFLFPi51yZJu7E1RQ2tm5jB6NJ6inOJ3wtcw3Jf/0lMzQF3UemBKAQIH/AnC?=
 =?us-ascii?Q?rHZq2AD8t4/351Luf3AEv/2MXHiD6q3OuqUHG24AwoeR118ucTndTIfpm+Yq?=
 =?us-ascii?Q?HdB4LM2GKT8nwFV5tYJBL3V9yNFREtGYlIkDHJeEclaLAQ345vI1JT3BTNuV?=
 =?us-ascii?Q?sD+Z8bTY+8wX7yVPgjDg+VUI2d87yNeFeQaa4sg1q9O10gv+hLYDLaOZqMoL?=
 =?us-ascii?Q?Dzi5UzbRvW8fWyfPnKhK/fHoa0e2hwsldQ467a8/aYgZZaxu8XihzfV5hT4o?=
 =?us-ascii?Q?L2wE9re2UhdShrWqoyG6T6ovMyZYcmH1+mko0gjYDRrcuDP+obd8rqic6WWd?=
 =?us-ascii?Q?Px5htRJ32a0iBZrBHN+FRdQKlotDBVJ8cuMa6P229C7daW9bYIk9VhqhgKye?=
 =?us-ascii?Q?/bKLT+QcWZtTjZD8JMlHs0KpRxvuda7I7duIvVyiGBjPxerQkeRmDiV03OMD?=
 =?us-ascii?Q?KYpOTgm15aYzkVHrimvFVy7K5v9yPpMk9XkyITA+mzwhpD2u/cxYQc9QiXcb?=
 =?us-ascii?Q?x+9U7vWZwluYWtkJbZpQBMIO8e03DXPRkac9buhMAInUY4slj1dfsPO0Fjkn?=
 =?us-ascii?Q?okDWgiFaUi0KkXm6gqLqriaUUegzyBw0X/korMn3Nvd4krswS6ifV/XGIDYP?=
 =?us-ascii?Q?QJVTgFn72Eo3w2yGgVv+yUHKP6LUUxqY0x/EdWd24PAGKVhKvHW69q7n/W/p?=
 =?us-ascii?Q?W5ZucbK1D2TU8Ixk7ljuXMSYGE7bJXvOGpqCe2SKXIJ+dr0bPOlR9O6irWij?=
 =?us-ascii?Q?rZYlzF4fpG3s23OSRAaZZkn0EVaiL9d62902uuRCw+Rl4WXiJQA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c3d9c8-b489-4b61-0465-08db7e5dd308
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 20:16:04.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xuXU1OkXEERI3GoXpvvv+hpMfTK6F5slFDN10vRluoalshobJ7AuqBYyLXU5Lw5Gj8wE1bs1riEkem0kkeKdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7353
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060178
X-Proofpoint-ORIG-GUID: PId2eYTOJ0gwwIav982FkcOx9_VC0ovq
X-Proofpoint-GUID: PId2eYTOJ0gwwIav982FkcOx9_VC0ovq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [691231 23:00]:
> There were a couple of reasons for not allowing non-root users access
> initially  - one is there was some point no proper receive buffer
> management in place for netlink multicast. But that should be long
> fixed. See link below for more context.
> 
> Second is that some of the messages may contain data that is root only. But
> this should be handled with a finer granularity, which is being done at the
> protocol layer.  The only problematic protocols are nf_queue and the
> firewall netlink. Hence, this restriction for non-root access was relaxed
> for NETLINK_ROUTE initially:
> https://lore.kernel.org/all/20020612013101.A22399@wotan.suse.de/
> 
> This restriction has also been removed for following protocols:
> NETLINK_KOBJECT_UEVENT, NETLINK_AUDIT, NETLINK_SOCK_DIAG,
> NETLINK_GENERIC, NETLINK_SELINUX.
> 
> Since process connector messages are not sensitive (process fork, exit
> notifications etc.), and anyone can read /proc data, we can allow non-root
> access here. However, since process event notification is not the only
> consumer of NETLINK_CONNECTOR, we can make this change even more
> fine grained than the protocol level, by checking for multicast group
> within the protocol.
> 
> Allow non-root access for NETLINK_CONNECTOR via NL_CFG_F_NONROOT_RECV
> but add new bind function cn_bind(), which allows non-root access only
> for CN_IDX_PROC multicast group.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> ---
>  drivers/connector/cn_proc.c   |  7 -------
>  drivers/connector/connector.c | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index dfc84d44f804..bb1fa5d66cf9 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -410,12 +410,6 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  	    !task_is_in_init_pid_ns(current))
>  		return;
>  
> -	/* Can only change if privileged. */
> -	if (!__netlink_ns_capable(nsp, &init_user_ns, CAP_NET_ADMIN)) {
> -		err = EPERM;
> -		goto out;
> -	}
> -
>  	if (msg->len == sizeof(*pinput)) {
>  		pinput = (struct proc_input *)msg->data;
>  		mc_op = pinput->mcast_op;
> @@ -467,7 +461,6 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  		break;
>  	}
>  
> -out:

This label is still in use from your changes in patch 3.

>  	cn_proc_ack(err, msg->seq, msg->ack);
>  }
>  
> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
> index d1179df2b0ba..7f7b94f616a6 100644
> --- a/drivers/connector/connector.c
> +++ b/drivers/connector/connector.c
> @@ -166,6 +166,23 @@ static int cn_call_callback(struct sk_buff *skb)
>  	return err;
>  }
>  
> +/*
> + * Allow non-root access for NETLINK_CONNECTOR family having CN_IDX_PROC
> + * multicast group.
> + */
> +static int cn_bind(struct net *net, int group)
> +{
> +	unsigned long groups = (unsigned long) group;
> +
> +	if (ns_capable(net->user_ns, CAP_NET_ADMIN))
> +		return 0;
> +
> +	if (test_bit(CN_IDX_PROC - 1, &groups))
> +		return 0;
> +
> +	return -EPERM;
> +}
> +
>  static void cn_release(struct sock *sk, unsigned long *groups)
>  {
>  	if (groups && test_bit(CN_IDX_PROC - 1, groups)) {
> @@ -261,6 +278,8 @@ static int cn_init(void)
>  	struct netlink_kernel_cfg cfg = {
>  		.groups	= CN_NETLINK_USERS + 0xf,
>  		.input	= cn_rx_skb,
> +		.flags  = NL_CFG_F_NONROOT_RECV,
> +		.bind   = cn_bind,
>  		.release = cn_release,
>  	};
>  
> -- 
> 2.41.0
> 
