Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1913A6E2A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 21:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDNTG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 15:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDNTG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:06:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0136319A6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 12:06:55 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGuvJ3001435;
        Fri, 14 Apr 2023 19:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ucgF8MHYNIxDSs/Cw0Bg4n+v16HGnmoQWqpr4k67iBU=;
 b=iKaoy7FPkufjMZwsxG3HsJtXmyHkzlR27RcWuaGZ0qHPB+gYgeQ/1d0hktArB8K4OlDz
 YcWjPxE9kPurM5Xvqedw5yXliR+/DsIdkTxgSWR21M5ytZc7GJkk2SL/RPZOyZ+YzpJR
 CsLWjZb8YY7+/gbXiGT0PeewlDxFekg2lIU4wG6oiIBSdG8D0S1EFvgUhAitCMC64PuS
 4u+xc+1JMNVmDxq2FDF12odyvRkDb6Fp4gIcfg7YZN9kEGX0q3q7qbhXUbS0KxR0uOS1
 GF59sYRkV6slAj8KbsJwYny1wQmJR03DC77fRSRubh/xFGXKPjedRyITFzLocFtRgmii 2A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bw6rtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 19:06:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EIR7D4040327;
        Fri, 14 Apr 2023 19:06:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw8c8qyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 19:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCfW/E5xnfuBzGB/e3cI7i/JEpm5GhkC6SSuJuWRYg5hVjwhh6Dd8DZGqerIlmqm193a7+UN3yhjRtSDBHr5j1Xj9e7f9EV0MIvLYGTn+vToCd1ynNTdPLGlewLpzjd/d52cjKjui/x9lq4s8HOgYfSrte1MB7YJ+fExNVUOqD8882kQGUdaftTtwO2yNCwAfXTlBiyszlHHwH3g7bDMwNKMYjX/sdR5vC3loO38UaaP1/ohG3kzk9bOKXjgLi7ytWONmbi3TW87Z6o9CyzwPuD5lh3U42KZBm6OTjmbE8NnxE8cgPg7ZwIhmgVVfJGyMx/1KJGYlGa0TZPZuyexvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucgF8MHYNIxDSs/Cw0Bg4n+v16HGnmoQWqpr4k67iBU=;
 b=J88uOZW1Lm/TaezPsBXNqC0ZxrmkIVhp5qIMQj6asoepWO3fD/5UIJSy+OP5H6UPGTHZ78J+bUfKKm7BwtwQ24aryNzTwcQl9lkPtRmFlUWoph2AjC4L5CmaQJzaI7BlhForS0I/FfImEvTmupwOeoh4fir9pwG9tTtk51OW+7s1Y/hXjhK5Iwxfu09zo5F3aaWnnTl8Ug9p3NpZYPYK4KdFBGP4s6+TMyeMdDYjFM7fp6MjJMdOQcgsdcHUtYcDQlet25rVQNDVI9Dc7ecRO9hT3vtfrhekNTVuPGWJEI1UOdaSCQxNlY4TKu43Z2Y6aUd2kzo+yZtGwifTQhuiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucgF8MHYNIxDSs/Cw0Bg4n+v16HGnmoQWqpr4k67iBU=;
 b=jgDBcAz1Oi+cdS3WBt+kjkBAQbIkBZhVadrpBFQK7xyWC08A3TpOLD/cfKO/NqsMgLlRRgn3ZoRhIfPak3oKlBbqZY/YeV+ln/Utam/SLlm1c/Zo1oHdDT+pvb0vuS/+ExKMugnUFcdZRuSuc0Ag846rNdW6wpuL2tbipHc4Csc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH8PR10MB6385.namprd10.prod.outlook.com (2603:10b6:510:1c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 19:06:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 19:06:34 +0000
Date:   Fri, 14 Apr 2023 12:06:30 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: Assume huge tail pages are valid when
 allocating contiguous pages
Message-ID: <20230414190630.GA4712@monkey>
References: <20230414082222.idgw745cgcduzy37@techsingularity.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414082222.idgw745cgcduzy37@techsingularity.net>
X-ClientProxiedBy: MW4PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:303:b6::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH8PR10MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f25cc0a-14c6-469f-bacb-08db3d1b5d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErOJqExfsnbiQ4wgXmaKdlIUEjavyxr9zNwhRs1LVG4BxRe4fEuya4ard4v5/x2pdqrTiv8L0FwR2tsX/abyMvBr/1sckSxdP2qIRG17qGTPK3Byd2ckUuhUsIYBsMWRMpZw41AUEJ0QKBCVJREB2hP8CijEs/1+SWHUXQo7PsijQugO5auNpnU8HbVqQynDZSeOiBvs8QJVWSYvuLQDuuj9pMB5WAPx5agW+Lgv0LbaBYoRAmL9AU371ZinebDdgLnNIYNqat1H2vjMhjDKOlEiBs5YOPGanCEEUPweVVDdq/swYjPd14IG9xQQC6a7STtGNnekv7VnbgQECxuPo85dxiDBOKpTRWU4ldSWouqUniOazi41HFkGsrIUO53aAvjDoqVEGf3LFmi7ejtkEkdCV7++l1yuJSgZENdjFqYf5g03m1zLzVUb9VV+f5aRw3QV+dwIgZaHCgarRluxt98nOH3FD8YcSJGaE9naPFyiBtw1omTqE64KclJWxjocl08LWZXaEZOhYAFdUlHQNEwARScHnbcEK1XTFBCzmErWeWBMB0hWPTZ+oD4cUDjNHndghst9cTT0X6qSNSw4Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(316002)(4326008)(38100700002)(6916009)(66556008)(33716001)(66946007)(66476007)(5660300002)(44832011)(6666004)(966005)(86362001)(6486002)(41300700001)(54906003)(1076003)(186003)(9686003)(26005)(53546011)(6506007)(6512007)(2906002)(8676002)(8936002)(83380400001)(33656002)(478600001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W7dqpQqoyI/cXMMPwfg12qAPior+l5NrzzlZEnypYKt1Wmg0rurf4svunypG?=
 =?us-ascii?Q?5VgtbZyCsDQF3E0u4SJARJLmxxW2Bn+HwHHnc89edSUCotvxUrgnYuyOQ/AN?=
 =?us-ascii?Q?3TQqg8ATmaBxb/mxELodTEytiCEYcG59udwPPzaXfFi441mLcsmHTKtrQkNK?=
 =?us-ascii?Q?8YQ3HSUPz49iRQAOGLLeMOjtAy8ToWZ73hi7ioik/Ue0bpjsxvBr4wPUiufj?=
 =?us-ascii?Q?9WOn6nQSAA+BAMlHxPKPmIWWA17LcuraGQznEdS1ElWF2d3OsiuIGq8s9Vs3?=
 =?us-ascii?Q?AFK80FIi5TaXSNzPxys5AU1eU84e58EkSCM0MS8X6ZPjMzHxXIkOO2re0L5j?=
 =?us-ascii?Q?2jgD3VxE/kU0lymwwgz2Sxch2WDpP8VYENctCorx80qsZ1BjRyyMU+0ESiRD?=
 =?us-ascii?Q?KIhBVVe/3zPSG9XgkS+JO9/4sAOWxWH11rEdipDPg1uiSLgmLM3fL187mqQR?=
 =?us-ascii?Q?d9LYTpu+CMhZjQljw8NC/T56iz7Mj/HBf/gyvm1M7ZfwrwdZp2W9bBwpHqXr?=
 =?us-ascii?Q?J4J1Fz1rzsAtdeEMtrlyNVYfJy/bdTFujmB70xgbU6INUjAdnCMUjk8v7c2A?=
 =?us-ascii?Q?CkTrr2uGb38hNyR37BUOxd3tLfHl0owydR+aAZLZhG8cO8npw8OvPpzyG8Oh?=
 =?us-ascii?Q?pcfCCtd7eoSYYbBQm5abBMQMNW8Q2AvQ2bUOoe8y06T0P9qByJHYLF5iewf5?=
 =?us-ascii?Q?BKApKUqxYeDxWNxJ9l+ty+I1FcYFQMZOKrv24IX0ecQf/XMZd+i+Y6NAm1e7?=
 =?us-ascii?Q?Q/hTKIL9kPyimJBDwybafQXTZtzNGnv5tbMFjqKmHycE07j+aSGqO8kCpbf+?=
 =?us-ascii?Q?V3F/zie2WMkTHQcfIKccOyFzTMYbnFHz2GJ/ok95HLwQKSdfylV1CsRqHHu4?=
 =?us-ascii?Q?bJm1Sax5VGmTQJSI1voGNqVi7ku5NmP6qRqNlybQOrIbxz9j99+NsjjU1KQB?=
 =?us-ascii?Q?VltKvuzL0lJAGhLWiP/ICdLEEFpfJrIs1CsvK/m4eptDzUMBBIAObEykWqIN?=
 =?us-ascii?Q?nIFjt5ESXQAOQT7zDVBwZlrXSJ1inf9qEDhp/ofRL0+HA2reezhCzcAyeuVH?=
 =?us-ascii?Q?Y1Ac7P310vf/mVMGglJka3uE8jBurKEPkwdbz0PrI7oTQ55I5JvmUGx5QQ//?=
 =?us-ascii?Q?b6a3h6NGsR3f6ZAAsJfi3cL2J5sW2sj17boCO8O0MqsS0EDjJOaaUVuVmJX5?=
 =?us-ascii?Q?ozFO9k6kzVfmpxH1AmNPZPrSFJy66AoyFL4BrlUVZhKeU4Bo2lhTIlE+SV+6?=
 =?us-ascii?Q?jkvmKpP9JxTnmLaxSJocBAUgbV+lvGu0eFPlOXtIfK7RQC7sbV54wvPnhv2e?=
 =?us-ascii?Q?BNxXhdXcyKYLwmZwrhPFXgeiuTZTIl7J8ULCiu2ZDM7J3m+FLcIwrcyjXtDZ?=
 =?us-ascii?Q?+zjpmQF3Pd9RxHS0aSLvYuwhpkpqDqmn6VK5LsOPSgwFZvXkLa5ClNzLpXNG?=
 =?us-ascii?Q?2AvBrDyJNsl/HtMCIrKCHplC2xtGVNNDYF/UiIn3xgxhf7G+3bjdRP5oM/ZS?=
 =?us-ascii?Q?jaF78AJ4uU8OqfDGVOcGRTmJAkne5N+cGbjmTgwlcMX0TUPEcJ2yQ/pIuI2x?=
 =?us-ascii?Q?z/awHk86WMAIkXrp7fYmu6VCKYss0OCDZcC2+4LN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iles/Ns31PCvh2YRw1ylwY9KmFBRgiuFKwVNSY3Z/sucz9b6lW0GGCJl5v+q?=
 =?us-ascii?Q?klFOPPRheT0twUeWrvg90HMP99jH5aJe4ZTY/z+l18Jx/rehS4G87LGrLSkh?=
 =?us-ascii?Q?1e4dkcNam/Gjz0LW1JzuWE3Ibd+cizPsZtyTPCVgZP7mJMzWKmtY7fkL2TnC?=
 =?us-ascii?Q?vmiY1DEcbwj9QzNJHJ/aIJFm5mzLic3Re8jRFW/kmab42bKUqsJbjgxTScNi?=
 =?us-ascii?Q?Cl4hYEjfVNKd+lY57vk1xALPx3jXmOjMa+BAY5iZGBGqioMy8/dBDQ6tb+Mk?=
 =?us-ascii?Q?5NMmBWZWOtndTu4xXp5glYGc/MwPd+Bk84a/ir7xof1/fJ5kWfG/+RBQ3H80?=
 =?us-ascii?Q?SxdnvrmUGo2/SVm3NIpbIcG1PyXgJJh12vyRCb6tKoGCbJNPxIdvN8IMNkyC?=
 =?us-ascii?Q?F6T7Lyod+DGgbKN8lzEkCV/4ShbGdLNaMMUASSlcnPq/m6Aoud2RcV/Th5Tn?=
 =?us-ascii?Q?fqQag0kKGl6sN5c7GMJlzRQpZzvyITG9+9GOTOvayYLKAWcRLGKZYiDAF5sE?=
 =?us-ascii?Q?Ev/hdVnf2ojQbm5XvoJw0B0aJCR6f/H52Dai9fMhaCZ44DpceU1Iwgf2XyHO?=
 =?us-ascii?Q?Pu+gOyI2qaDA/U1OA4bJ8R0mkEMqAJYH7ocMvW18qwqCoL6ooqr0bPUSYUk3?=
 =?us-ascii?Q?BNVqrlme8h+sz1UjXlkx3epVHOpPkvxGwzrSq2fVrXbjFGMlTz7UUBZytQp+?=
 =?us-ascii?Q?75jQ48OPcN+COQV/kMfYxHgWZQrLcdGQPZJGyelJYnSJiLINh20fV0N8sfGx?=
 =?us-ascii?Q?FP15oTWEBbWe94SIkqWRoZ6PdpPtt0xmny8kkVA7C5SEm+r9fmQzFg9D9ZO9?=
 =?us-ascii?Q?SM8gNIQI+RYy/4mfJNNHqIgpnQ3ZeJxL+Cq+5ilH3jWQITQWY/jA/n8gOdSV?=
 =?us-ascii?Q?JMsG1r+6faaJIZQlS1lbQbCGRV+Q+c3/fKblMW62QGVvfDlk7HCt+aLVpG+R?=
 =?us-ascii?Q?Gw9MnoldX8GzqY0WcqhFC43TgZbcpIuTKdqvQbOB7y7TAByUnhcM3otjFkuq?=
 =?us-ascii?Q?GRAC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f25cc0a-14c6-469f-bacb-08db3d1b5d57
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 19:06:34.4881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0YEDIHkU41hfJOCIsT/+QdCvfNvOH2bjkpw6rqnY+2VQe3VumtSlc8W2Xk+2+WkVUFVJvmmvZeXY9C+45OfHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_11,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=799
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140169
X-Proofpoint-GUID: FBgdCB8_1CbG1MHNxbmYNYNnoEbPIHTS
X-Proofpoint-ORIG-GUID: FBgdCB8_1CbG1MHNxbmYNYNnoEbPIHTS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mel!
Apologies for not noticing when the bug was posted to the list.  Otherwise,
I would have jumped on it.

On 04/14/23 09:22, Mel Gorman wrote:
> A bug was reported by Yuanxi Liu where allocating 1G pages at runtime is
> taking an excessive amount of time for large amounts of memory. Further
> testing allocating huge pages that the cost is linear i.e. if allocating
> 1G pages in batches of 10 then the time to allocate nr_hugepages from
> 10->20->30->etc increases linearly even though 10 pages are allocated at
> each step. Profiles indicated that much of the time is spent checking the
> validity within already existing huge pages and then attempting a migration
> that fails after isolating the range, draining pages and a whole lot of
> other useless work.
> 
> Commit eb14d4eefdc4 ("mm,page_alloc: drop unnecessary checks from
> pfn_range_valid_contig") removed two checks, one which ignored huge pages
> for contiguous allocations as huge pages can migrate. While there may be
> value on migrating a 2M page to satisfy a 1G allocation, it's pointless
> to move a 1G page for a new 1G allocation or scan for validity within an
> existing huge page.

eb14d4eefdc4 was the last patch in Oscar's series "Make alloc_contig_range
handle Hugetlb pages".
https://lore.kernel.org/linux-mm/20210419075413.1064-1-osalvador@suse.de/

It seems bailing out of alloc_contig_range when experiencing hugetlb
pages was an actual issue as the cover letter says:

" This can be problematic for some users, e.g: CMA and virtio-mem, where those
  users will fail the call if alloc_contig_range ever sees a HugeTLB page, even
  when those pages lay in ZONE_MOVABLE and are free.
  That problem can be easily solved by replacing the page in the free hugepage
  pool."

> Reintroduce the PageHuge check with some limitations. The new check
> will allow an attempt to migrate a 2M page for a 1G allocation but
> contiguous requests within CMA regions will always attempt the migration.
> The function is renamed as pfn_range_valid_contig can be easily confused
> with a pfn_valid() check which is not what the function does.

Michal suggested that we reintroduce the simple PageHuge check and fail
alloc_contig_range if any hugetlb pages are encountered.  However, this
certainly would impact the issue Oscar was trying to address.

Do note that Oscar's series actually tried to address the issue here.  In
isolate_or_dissolve_huge_page() there is this check.

	/*
	 * Fence off gigantic pages as there is a cyclic dependency between
	 * alloc_contig_range and them. Return -ENOMEM as this has the effect
	 * of bailing out right away without further retrying.
	 */
	if (hstate_is_gigantic(h))
		return -ENOMEM;

So we actually bail when getting here.  But we are well down the call chain:
alloc_contig_pages() -> alloc_contig_range() -> __alloc_contig_migrate_range()
-> isolate_migratepages_range() -> isolate_migratepages_block() ->
isolate_or_dissolve_huge_page

The overhead of getting to this point where we bail in
isolate_or_dissolve_huge_page is excessive.

I suggest reintroducing the PageHuge check with condition that it will allow
migration of non-gigantic pages.  This will at least address the issue seen
by Oscar.  I agree with others that the CMA check is not needed.

> +		if (PageHuge(page) && compound_nr(page) >= nr_pages &&

I 'think' some architectures have more then one gigantic huge page size.  So,
it seems this should really be a gigantic page check.  Otherwise we will bail
later in isolate_or_dissolve_huge_page as we do today.  However, we can not
use the hugetlb interfaces to check for a gigantic page as they require the
page to be 'stable' and we hold no locks.  So, it would need to be open
coded something like:

	if (PageHuge(page) && compound_order(page) > MAX_ORDER)
		/* after MAX_ORDER update in linux-next */

-- 
Mike Kravetz
