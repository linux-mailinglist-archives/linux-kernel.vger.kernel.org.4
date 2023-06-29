Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34742742D99
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjF2TXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjF2TWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7633A99;
        Thu, 29 Jun 2023 12:22:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ3phG002877;
        Thu, 29 Jun 2023 19:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=4JLI7/JunPAOiUTOIZei3N9WOAFJGTtHQ2DxGwPOSkk=;
 b=eJi0D4QuTIoRZmM7jqyI0eDH2TXWKFeTGelzFeIwelJ+Ri0ePixugp09nN4WR0GitP0c
 JHKh3aJk/Zd4IwkeB3rFFddqaYD1JfSyOkZ81CnD71XIUiTkcrG7cV4XIVTp87IgLTOk
 Ep+bpaYmrfPhf55Pnk++5b/aU8rE+cPp/et+0/DRaym8IAc3GblgKrC+Y80VOYSDkWI4
 sQcpnojmev/AlTeKTlW3ATo683W1Jq0xuf/ywt8YE6aJmUCTgZU/+wQGCCNh57GZWR0p
 J3TUpYy+lM0D95PBIFfB3Tlf69iiBc6a48A62RYfa/3YEyYAyZsz3kiug91oW0acOfkN zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40ebwfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TI5a7v003989;
        Thu, 29 Jun 2023 19:21:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdur4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwP6ZJLrcQJbSADMSP30Tbl0+BehCmmI6xrDTYDki6b33DJOtgJ2/feHlCBnb6BXhySNK9elzbx88y9XKwj9XFqAFCFFpyJUnrNoTyV/Fz06/PojTx0v0mpr/kbwD2p/CBgurKkeF6Jp/zu2zhUXCI6f//wkdz3Vz7VoZBYTzdZGTbzlXCKQMqH1f1kxBgOEtMsQ9soFWTSjQ2xw9l4jycDzx1e4CTZPOlenldqx/qZaOZSLTIBt/KwWB2bK3Lgo7Soxta+b1YXYludUBwus/YiOC56EbMLkWDtuQ/Xlc17BJdcGUhk7L9NyEpqaa9M28W0KtpZJhEKlOllzUf7YTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JLI7/JunPAOiUTOIZei3N9WOAFJGTtHQ2DxGwPOSkk=;
 b=RJ9oN8RKERuwcTxg7vDOVqW+DqTgIHerhsiE5ylhOQtds2B3+EtY6vRjYqHgMY683OV0eYwEEQz89TH0Hu/1sZeDiNQJ/k0YXJuhPgJedUPkh018vZekeZ3lSnExmZz0OuYN16PZmTfxafTgZ9xYUXH+ecE7926hIhhUHMdGHjGuRi9dw+FJ4qOWqZw0W05tLxvEzAbmEok6dcPVe9nWQ4TPYLZ54hHZkzpLXJ+EENT5mRGKHWlEEo6y4QD1PfT6cNf5tsiEOI2yCGwaVNGZxGAJ9gNrf/h/yVDfGNakJIsoq/4rSxOHpmum6IdU4ZxWOHDWOJ87zg4rcY8C/oEG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JLI7/JunPAOiUTOIZei3N9WOAFJGTtHQ2DxGwPOSkk=;
 b=awwonEUG2R21cJ9nfFoQup7uFXL0CTGTtavIT1iKVk6zeRKKfcqkjBoGEGAcHTEIVeww3vn+HJ2B2shUr+l3Kg17HcoKZZJ4ALT09Ip9pAGNXUI75/091Oz3bXI5p2RDLZae5eT/8xacPRLXw9ttpVeUMsCiY0vT4CMEKN/QI/w=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 29 Jun
 2023 19:21:35 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 19:21:35 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v25 03/10] crash: move a few code bits to setup support of crash hotplug
Date:   Thu, 29 Jun 2023 15:21:12 -0400
Message-Id: <20230629192119.6613-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230629192119.6613-1-eric.devolder@oracle.com>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:a03:114::12) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f71007-2819-4ad1-f786-08db78d60ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1BVAdT3rJSe1WccO/IoIJ8S2xrN0J85TwRCG4v2mD6mATiyyqShkXfj8L2G1CMHCCV77RXXO5gpvHKtekTZMA8KUR5obvT7M8JA0qWZJHTIUgK1fwYs9P18i/IdOMtaU0voAFI+I653YnEYQ2ANy235ijMRyt4Y4zTd07wf9r4FUXLCbcfVUHfPEp2n8OywbUisLF+LXzqtIyWItJ0znHyggDmV5OqljB4EPH6EB+79BlK53f6+waBpfUcfoAcxDt1o021tFxsc9MVB1fJzrVJ/Vmc+5Wor8/3JlIBK9AEj6mpxnzxtV5CC/Jj2RHEFtvQuV5+87lOhTmi3nqHFQVxP1Oh+cKztcf6YWSr9eSluDww6rHxc7N/VD6LVFL8vkGqIR5oDQP32ZAaLBBsevRc1SZitSLWmXWrrXSVm6PUDEmNqixL3EkVndNLLqPYztR/xH4gtJ8kD7ls7LIddOA4v8nf77I9Jxut52nuX4jpP3G0w8COZDkHYfrPm9QvwkFhlHSKpK8QLg7XU0nYnhBY3B5XltUDVljFO3157UpJfT9UttkJWDy92fEQM/ffANQZt0bcGLFW4j5+dLFxOJ060B35p5KNIPZ9/bDUwx04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(83380400001)(316002)(6666004)(8676002)(4326008)(8936002)(6486002)(41300700001)(36756003)(86362001)(38100700002)(921005)(2616005)(7416002)(7406005)(66556008)(6512007)(5660300002)(66946007)(66476007)(478600001)(2906002)(186003)(26005)(1076003)(107886003)(30864003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?12FykM6jMXvgjHs6l12faFOKAgCQEOKABHZdvi6+Q/ofwShI4q+1ywxnunA1?=
 =?us-ascii?Q?rGsab5lysdm4ARYBzQlBQAQBPp+1Vg1EhX8WbxpESd4D0Qd/NYv7WmTjGh/1?=
 =?us-ascii?Q?vJITentO+tB4CLAgqy50BLuInSjdV2RfW71Jy/4OXFPrkTf1LMQuWRxxfvm3?=
 =?us-ascii?Q?YXzrsKUwlrOz6El1ajYB9ca4a7VCitHZe1nhnNiWZ0NA2EiED4JXnY6yIayD?=
 =?us-ascii?Q?Pa5r8o+wLrb2VBvQ0EeUC1v7hJE0AfrXmfSI1wXp9frKxLq931tOfmPEIfXR?=
 =?us-ascii?Q?cEu52XR3VVLfcGMaCCkAbVbEvzfgHWS+RDCXMtDA4IJycp2XYdzKQr4LeB7g?=
 =?us-ascii?Q?AzIM4EqpmxEGwBUDsy6QLnTTvtisuObLYc878QbHx+zB1vSTzQKaZk/9qij6?=
 =?us-ascii?Q?9HGkPDR8p5vAscLodZvQL23jWBV26vJXo7PY6k3NOVSe36mx98esFuVj5+hl?=
 =?us-ascii?Q?w5M4G+q86mKoeN7a4jbqMjJLlo0BV/jFggrv7Bz3HZmGdAKjnLEUrhZdmU96?=
 =?us-ascii?Q?l/U9hUyvsb5jF90P0Znmb76CADizqGjh/5i0sg0MOcmyN3KEnUcagvYTg8cQ?=
 =?us-ascii?Q?mHAMjZH/guwjIhQX2cNtMTKBWbCqwy7WfJN/eMQRQtjXJ5p5CTDHdUNGeeUH?=
 =?us-ascii?Q?YxfO49nRFtE+Z6uyuI1d7MrN5wKUeM+z7Q38n+OXGhgJwcDM8EQNQ3acY7sQ?=
 =?us-ascii?Q?MM8kDLTzNhHuaeKIz4x4MN2kxeSM0GT0A2tN0Eh20GdNhDlf/lUFgaIAc8Wx?=
 =?us-ascii?Q?TBhz8ZarCjR0QfOFeXVR4kTIxlPg0RWNMSOibfl0suyVnHIlqJHT+UzXWCdj?=
 =?us-ascii?Q?SCiVvRDi4/xpgZTens/OhE5PfEIa1oR+ri4kaulpxN3YZ6RQpajpu19bl47m?=
 =?us-ascii?Q?yNyqV40GVAXdgir1sbyjgAAltLzQJggDInRvZpc0S7qMMGKb0nSSXCWUJSnr?=
 =?us-ascii?Q?Ohy1HFnQeyL842CGkcUudIwgIGwD4/JwSM6kZMOsAwJgd1Y9uAejcNkFXqsR?=
 =?us-ascii?Q?j4WrqaafhEB7C4LRpIYm29YSi4vPK2mpiT6MEXTuU4wcpByYivz4i0mVK51h?=
 =?us-ascii?Q?t/O6Wx/SPpK32R1Wr6WBk4UwH2reKGY190BOZ0A60cRlVchd+2VTGdlHiKKf?=
 =?us-ascii?Q?euUSsHcDtvP8KF5WyNJH9v0CWY3Pvq4OlBlTuSBH5n9PCaEUbaJz2Y/UxIPv?=
 =?us-ascii?Q?klHR093RYlddR69YTxvkbVqqeD66biELl2qGHpW8S10W6TEo8iAYC3oz16Uz?=
 =?us-ascii?Q?/FjMWMfUxhBZnehLWs5CAwBlwoIOcE0vfej1msVN71PTxKLWkuaEsF8F+adU?=
 =?us-ascii?Q?ntCGbv3msn58FEZU4Zod8c3d9qsZ9M2fWdPpPSmeOW90j48s+C9zBzDcaIw+?=
 =?us-ascii?Q?KLGUX6c3dcDNrxESwKL3hudgjXTpJBFDd/Qtf2ZKULVH82Rqbifg0MHiA0XF?=
 =?us-ascii?Q?UyTPSHhBqYhMb76DwYbaRbrmkiHXZND/JUic/oOYVl96qmlPVR8gI4M1j63P?=
 =?us-ascii?Q?WdY98nQbW3hlrU9encdhqNBQ+kGTqRE5FToweRAqv42Hw0T7HsCSmtdvz4QT?=
 =?us-ascii?Q?VoUwAxmkXjTFEJyaFzc+kX+am+hmusPzcOPeHsDA+umIw7jlEvYz35xOYGuL?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pO+/3HCsNVPK240gvDuUyLVo8e0tEEwzxisAJIhH02uvedIWQGtFq28wji2g?=
 =?us-ascii?Q?1tnCiM7O29qKlownBn0tX9LNBQYpWxDe2W+gaKfGXDZxXpmchU3mQrW/TJYw?=
 =?us-ascii?Q?1Wxv3SMjXKaUskP/JK0UUF4AZhHbwAS1r+KCoW+reiXT9jfpoD1jY570AY2g?=
 =?us-ascii?Q?1+jqfzDEtMujPLOAP/xBbLKYzmSeyfwsWvYprKRVU1X8Qn9AiPjExbcz83C+?=
 =?us-ascii?Q?SJ8MZauKh0phOC3MRW2+Xyu79wkp4GX6uGvvsoLGzc7Y3DjfNnhbZnOmoiVt?=
 =?us-ascii?Q?+z1Ms0R+c9FDx6dMX+5XTsrP6T6p1gH8/y6/zkTQgp1PpnQ9dN955nUvIT7q?=
 =?us-ascii?Q?WlZ0vv9/tdgk7HbRzM56QTmB23M33+GUZYssMqQfq6xG87aX5+s+gnCQRJa+?=
 =?us-ascii?Q?c3lMnRsugZsKXldC8W44PakveUgr4yVCPvjP8CwHNCpBYZJuSvC912VsqFjt?=
 =?us-ascii?Q?f7hmEHbxeL6JYPkzUUaVQkT6wQNBniPp4QLBtQerM+mALeo6n0+SH5G4CVDS?=
 =?us-ascii?Q?Aqe8XLckKj9Ky02K/j7df23rkWiJPmMlFvaQjHomjAt84LdkGEqW+R8zxHvH?=
 =?us-ascii?Q?xNWa6JG7EZWaCUyYXAOckBlf26sENUk3ABugSvDrP+LYHT2uhd7ULcLlDqQK?=
 =?us-ascii?Q?xhjCrtD3fcAQm5Ddf4ARQLKJyBKTfEjiS8p8RwlgH/seUJ4esVdEZYP6CZjp?=
 =?us-ascii?Q?WeYZnvy+xzUvRSu8MYUMK2wB4BK3u0aIGMtwKcB1zSmNIBghV5GVCO05eJLP?=
 =?us-ascii?Q?fp9y6RsBsG+f3bHWqUPLBixtSALIMW+wAMLDVxh3m9QYLIAVEp6l0udT37J8?=
 =?us-ascii?Q?QxFLPcj0YWbrou/575VInsTMplsQHu/OpSfI53LKmzga3pyFmPpc7PawlnYQ?=
 =?us-ascii?Q?e0oyu9pV4nAd2GS9blrxaT9GEyukQbT55IS2R/IHSOekSGE2v6r4Yi3g1qNs?=
 =?us-ascii?Q?bZOv+1L1bQvg2tNa7tkob/64rZ+jijWY5VSf6hDcvSfP7UPWD74i1Zyk/+Le?=
 =?us-ascii?Q?IVNK4i0YhSZ0DrtwsfQzZH5Jtr/Rf0E7/yOPgxJqkk7G8E4ZF6+MFLc6I6w3?=
 =?us-ascii?Q?rp+8AYs879PbPWk+r7fP5H+rGpLg74ctO5imnZ6/KpDhyA5S9wdmuwiRrcJl?=
 =?us-ascii?Q?UlPzzrcLFH77Kr5aECPnr+1FVIUdgj4MVZ0iARNVp51uJlbfh3+mqVadBnn8?=
 =?us-ascii?Q?v6mxAEnMUlbJ10YbNaszWLJNT5RPd7rfh6aP+3muRbdp381K8IKgR1esYfu8?=
 =?us-ascii?Q?bYaY/Ta4SjVyBuNk3qkHaC3aQD9s1SLNr+ZCj44tYY4M5JWQPj6i4/4rRZnF?=
 =?us-ascii?Q?Xpb79XmNGJz+5WSUgYzezfIewo+cvk3mAPcolXo7vfwUOhVzw9MURHMP61jY?=
 =?us-ascii?Q?b4wN9xFZTcsg602lWO1v8NfFv/3U0TvwTq0kNi1BDFLdIEIFhq2YjQakR1LS?=
 =?us-ascii?Q?Wtj4kDnhPvk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f71007-2819-4ad1-f786-08db78d60ddf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:21:35.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LElDIAJHKXuBJtjEUnQpQ8SIE15KP+d9bh7Vu81XtEUcTzy07jNt6ZEkeQb4fuxWnzwBdrb+rOg9e2LFo7m0rLaKEz942qCpTW/ykDEQjc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290174
X-Proofpoint-GUID: PLfGWo6Ere8vZHQPw-baLrFz2LB6sBy-
X-Proofpoint-ORIG-GUID: PLfGWo6Ere8vZHQPw-baLrFz2LB6sBy-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash hotplug support leans on the work for the kexec_file_load()
syscall. To also support the kexec_load() syscall, a few bits of code
need to be move outside of CONFIG_KEXEC_FILE. As such, these bits are
moved out of kexec_file.c and into a common location crash_core.c.

No functionality change intended.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h |  30 +++----
 kernel/crash_core.c   | 182 ++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c   | 181 -----------------------------------------
 3 files changed, 197 insertions(+), 196 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 22b5cd24f581..811a90e09698 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -105,6 +105,21 @@ struct compat_kexec_segment {
 };
 #endif
 
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[];
+};
+
+extern int crash_exclude_mem_range(struct crash_mem *mem,
+				   unsigned long long mstart,
+				   unsigned long long mend);
+extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+				       void **addr, unsigned long *sz);
+
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
 	/*
@@ -230,21 +245,6 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 #endif
 
-/* Alignment required for elf header segment */
-#define ELF_CORE_HEADER_ALIGN   4096
-
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[];
-};
-
-extern int crash_exclude_mem_range(struct crash_mem *mem,
-				   unsigned long long mstart,
-				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
-
 #ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 90ce1dfd591c..b7c30b748a16 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,187 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
+int crash_exclude_mem_range(struct crash_mem *mem,
+			    unsigned long long mstart, unsigned long long mend)
+{
+	int i, j;
+	unsigned long long start, end, p_start, p_end;
+	struct range temp_range = {0, 0};
+
+	for (i = 0; i < mem->nr_ranges; i++) {
+		start = mem->ranges[i].start;
+		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
+
+		if (mstart > end || mend < start)
+			continue;
+
+		/* Truncate any area outside of range */
+		if (mstart < start)
+			p_start = start;
+		if (mend > end)
+			p_end = end;
+
+		/* Found completely overlapping range */
+		if (p_start == start && p_end == end) {
+			mem->ranges[i].start = 0;
+			mem->ranges[i].end = 0;
+			if (i < mem->nr_ranges - 1) {
+				/* Shift rest of the ranges to left */
+				for (j = i; j < mem->nr_ranges - 1; j++) {
+					mem->ranges[j].start =
+						mem->ranges[j+1].start;
+					mem->ranges[j].end =
+							mem->ranges[j+1].end;
+				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
+			}
+			mem->nr_ranges--;
+			return 0;
+		}
+
+		if (p_start > start && p_end < end) {
+			/* Split original range */
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
+			temp_range.end = end;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
+		else
+			mem->ranges[i].start = p_end + 1;
+		break;
+	}
+
+	/* If a split happened, add the split to array */
+	if (!temp_range.end)
+		return 0;
+
+	/* Split happened */
+	if (i == mem->max_nr_ranges - 1)
+		return -ENOMEM;
+
+	/* Location where new range should go */
+	j = i + 1;
+	if (j < mem->nr_ranges) {
+		/* Move over all ranges one slot towards the end */
+		for (i = mem->nr_ranges - 1; i >= j; i--)
+			mem->ranges[i + 1] = mem->ranges[i];
+	}
+
+	mem->ranges[j].start = temp_range.start;
+	mem->ranges[j].end = temp_range.end;
+	mem->nr_ranges++;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 69ee4a29136f..e9cf9e8d8f01 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1150,184 +1150,3 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	return 0;
 }
 #endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
-
-int crash_exclude_mem_range(struct crash_mem *mem,
-			    unsigned long long mstart, unsigned long long mend)
-{
-	int i, j;
-	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
-
-	for (i = 0; i < mem->nr_ranges; i++) {
-		start = mem->ranges[i].start;
-		end = mem->ranges[i].end;
-		p_start = mstart;
-		p_end = mend;
-
-		if (mstart > end || mend < start)
-			continue;
-
-		/* Truncate any area outside of range */
-		if (mstart < start)
-			p_start = start;
-		if (mend > end)
-			p_end = end;
-
-		/* Found completely overlapping range */
-		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
-			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
-			/* Split original range */
-			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
-		} else if (p_start != start)
-			mem->ranges[i].end = p_start - 1;
-		else
-			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
-	}
-
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
-	return 0;
-}
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1

