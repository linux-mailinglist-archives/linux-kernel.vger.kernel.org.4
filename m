Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62285622DC5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiKIOZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiKIOY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:24:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BA4326DA;
        Wed,  9 Nov 2022 06:22:24 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9EFXLj006707;
        Wed, 9 Nov 2022 14:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=I1d1bqXhzhDNq6Kusl94sLc+gKjQzctiUPQdP4RW9Ac=;
 b=eX/M1MLxtdBOa0F6QsnDiWLJ8eZdHFZKQ7Xknd0ljxNa/1juCA1R+gS9Ba/nukymQXmV
 PxO66eLOu7hqIY4I7yp0IOD6YLkqeU0DhpOfHtXLOzZFVme/VtVcwcvb3g4fKMC9sSsK
 57Augnz0pBi46xHRjRjyCeONoB4eLgk3ZoFaimAnaJyKfK9Kcrupyl25JFJWaActTU7U
 wk3NflAJpt3FhKMdupGZ3aPeXmKi53raBulK8moz4BPAMPdKZrH/SRtsa1ocj8XlQCWo
 woToDw/obJSFSK/bFxXoW4p2CLdRbJy21PvhMedyxjcdSIjsAAb0nX5zyx3JABGi8Xju eQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krdfkg3uu-34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 14:22:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9CY2Ze017805;
        Wed, 9 Nov 2022 13:42:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctdn9ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArqE5SqIsuTgkvKHCaQDRR/vLvELbM38b6dAwsdj9Iy7pdvFzVISLN0nJw60MtC+F9KLS4YVp/3pywpecefl6GEe2r17fmKw3ujU++1Q3pcbff7XZosqwt3TkYx2azxev/d3sdGQyER8Yb+yNSnDA1u2phelD1S9k45520Oetwa2TBmc7G0dxAqmRk4ApjVBy7X8LnAcvVcAgPt5rE9F/QBEDUeSXTEOuh2v0LJQJmbNTj/xvQdqi4HV02RslNf64PS03q8Fd/Fw7pFd1Ey+NlDprvD25uh5CWphN1Y154N0H/oj0gEAPlbHLr7xOCCifAoXW09GiH5R1iu6cPDiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1d1bqXhzhDNq6Kusl94sLc+gKjQzctiUPQdP4RW9Ac=;
 b=au8/oDJNWc7uGbDcqNPYJQ9/sEUGK4McC5991WPLe/jMd2x73YUctG1TUXTYJjSmUdQT7iQCWgqoDvdyoBo5d0WHe3YmhWoJzxRsFWOVzU3d6UrFFB+QsOyNT+1zqSKCRsVGTGhYbim/+Jd5C4uBXEgbA5XVsmBI5Ki6DuS1s5ahNdjN9X+dapNAmKK7RUBVwpk/iP1D1KCMVhJBXf0nP89EDiavPWeYP5jFHaukqSXzcPjPvaeJnkzUclq6kdmYun6rDQZGAp4U1rXqmvqfSRe0pPANerezpKihFzhxp1/zmCTEOI7Kgo3oxbc6GcMXrwM39Aw7Op+1G40keCdJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1d1bqXhzhDNq6Kusl94sLc+gKjQzctiUPQdP4RW9Ac=;
 b=Ir+jygVsxdL/DczIjEgXNfR0RGbsNr5H4fby0UpgRfeiN7gzAQJT5o0ddGdjiPPzIqFl3MoZzHkRNpEQRn8lweCXQS6Gs5HZsx2prumKaJVy2diNLlJT4+sK93Coi2DqHDAjiYtmFET4y2y+hoCM9gFMf1V9S9v319cBse28I3A=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BLAPR10MB4817.namprd10.prod.outlook.com (2603:10b6:208:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 13:42:40 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 13:42:40 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 7/8] kallsyms: add /proc/kallmodsyms for text symbol disambiguation
Date:   Wed,  9 Nov 2022 13:41:31 +0000
Message-Id: <20221109134132.9052-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221109134132.9052-1-nick.alcock@oracle.com>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BLAPR10MB4817:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab987ce-8a7b-4d6d-7685-08dac258453d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xz6EwKElrdiPx/D+D6kFTGxTO3aN3mNrGowomGLaRL33ITNSTkB1wFY7OH/UYtJksBFRpSiBBYp89knGvIYcoELn34lBg5Ui7J+RTix/giWnn6M1hyVxQfqI0Di7xOUZZvgZiEfj2NuodIvOOd/Ix8roQGaAG7k/ZhxLmgLogw+Tj2cskJsyetRY7meHX1/ubqJryyklGGE1b3o99SJzV+XQ6LaFhU+f+VF7XnFMYUdJvOSBHmFe9PorpNDuB0Ymv8bODA67nZJyi5MromtfNtzMJq6bCEi5qoc+nAy1kV/1ut2ryPX+m/jI6GcQ17GWBGAbaMnQdy5Fj5orHUprUWELzTmuaqjxC3u2Om7h6vP2oCwsEayyRCI4FLdaGk/7WeqGeN/Qi704rI3XK+FI4kJIcX07boecrLAvmTmxqQrx6Flksm7hpmh0Pix+HA15mVF2yqo61qG885nyiXw6c85vb5CFoGu1M0KnG5NvusjEJ0M4PEx7H1OLHhgsaK1nH5HdDv9Vx/oMJarlLTdk4xAEH1htLh6+/H04W+t5kuAjK4li3FZwH3Z3Hkyzrt1lqADVoO5F1BF6TZGnX1cyNkK13OodRaNte/TwLeO6fe81CwOv38g6EL0XuCemo86nYrq6K9mfjIPMDSBregf7kLDOviVe4+pUw2mikkYbRIVBqQfhik9U3ssNmxnx1znTT7L/exg6uxEZbrqu8wGNnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(2616005)(66556008)(186003)(83380400001)(1076003)(38100700002)(6512007)(5660300002)(8936002)(30864003)(2906002)(6506007)(4326008)(6486002)(478600001)(6666004)(107886003)(66476007)(8676002)(66946007)(316002)(44832011)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HVBQFLSkfDzEGgmEbgc1DzjRB2xdj1jCr/c08x848BU64f9GQLbBYUYyud2a?=
 =?us-ascii?Q?0ObpGdDtclHhiee5jG1mSWOZnYbmXUOBBvXWu2oejgCUDJCO1uhHYgVPrsuE?=
 =?us-ascii?Q?fGGuy7VxCYo5deNzZ1URagXQT9FQGeEHfm1L6hn0eLt05f3MW3Oj/02mYaCi?=
 =?us-ascii?Q?d5fAYtkOINMYzy31ZcftK7vBLsa7czIs0JatA82S6g6mNMh30JLKAPT5I0Jm?=
 =?us-ascii?Q?KvyJ8gwmoGB/0BXJ3CX4Jzo/D8QZcOXC0Y3xSnPUlRgG8d0p/PpoyifHDqID?=
 =?us-ascii?Q?PYRL3P6wP6aa/8jxhDRpf1JdAs8DgEUbzX7HRM1iWq6w9RP9owRsKJO7synz?=
 =?us-ascii?Q?mwetbvWMAM0snRXuDhAoTyqX2MMtI55xse6Q4SIfo/lQOANZFCBYOZnjn4Yz?=
 =?us-ascii?Q?hLLrtaNfeG6RcfgJevVegsO7MwgRbj9vzf+U3o6qhzlTZfdKAuyHHFY0W0fL?=
 =?us-ascii?Q?XbkPN4smdC40DkD7JiaXlZDSWIca4NLBQnM4X+2RWiC4oo8vc2uBVAV0+8HV?=
 =?us-ascii?Q?kaiAoGyp7a6XqF4X8zNNlZvkwZ9OhE2LR34AdVxysMdamtOeMKIjyxz9SvER?=
 =?us-ascii?Q?wqC6naV3gNDTRcbrCE7XJMQtweIFekiz7o7q6GQitE/SXeEhXDegrPwzzUkg?=
 =?us-ascii?Q?7i6q8bKS3U7tfjzeyjQNlnd9Ra3pDE6RpPEFBAOoEsRJ1oJAtTHAJEm4NX0F?=
 =?us-ascii?Q?pKRxn587Ma7JN7YVXJvwQBKOL+yCRsPHtSSwQU6JskmknVQm6eIv9wq2c4FB?=
 =?us-ascii?Q?CcA3xMtNBKY7S7oKVtAr6h2WqeGrc/ejsRmS+IFztnbaO2423Xtz/gohEVLL?=
 =?us-ascii?Q?mEQ5iYA7nHMN52DwQPt1WC8PbVqM9ZGCq3zf38uDyKAYo57kU44GF6GDnIkz?=
 =?us-ascii?Q?SIOFrj/3FzD4DOW8TQi9SkPg/Og4dNW5A6XyPQG15neEzUGvoc4sYFRqlvAc?=
 =?us-ascii?Q?JFyIVeefBVxVeagpj1Al5yY0/FeRQpyfhoa3LTdYUAeK2nmY66i3RklMb7DD?=
 =?us-ascii?Q?QbQo0m2/J9Ql/yQ4YrttRqxMuijHKp+5gYwhDiF6pKZfr0uX5h85IzvUH565?=
 =?us-ascii?Q?EIO+5hjZGDii4CwxdZFN2OSQAF+rRncQdCgmJl+UHHRe+LGjdJ+6MQdpd1Of?=
 =?us-ascii?Q?MbDZnkl8Gzk2qGqUcNccED5MSkRW0zqvJk3aW0ABEu04X1T08wTSOkrduNNz?=
 =?us-ascii?Q?cSbDft+5mHUU1Cq2lQ0RucEW/Jyi5teXgj5yIfzl8H0awoCUwBK8iTwlZsBA?=
 =?us-ascii?Q?N1DjR6klSSr6uBCqeiIBbls4LmXugnAi1czznsrf0tKa1ClV80yEG8sCIWak?=
 =?us-ascii?Q?qxPpabgBS4qP2M9q5L+mOqsIdSiNFeqBbWmG8mv3CuRZ8Stz6YMh+gzRhdi0?=
 =?us-ascii?Q?A5spG+mveObwqGSE3vCv4XcWIJl1dYnevEt3Os+t4LgbbmW+sDFSjFfQB5pp?=
 =?us-ascii?Q?CpnTIWLKj6YYAGfktlFVLz7fNYG9OuUoYijCKeGL0h1vy1XuOKyXa2+Y26hV?=
 =?us-ascii?Q?Vaw7elhMmRO8Ob4tY+Jqj3V5J4QqLXwqEtepifsO+XfCmrFLBkfgPcGq5XlB?=
 =?us-ascii?Q?XL6JQ/1A92anEU8nWWOMPQSVzBYWrFuttVxn4nPdmuaal0YRv2Tnysgq+s/S?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab987ce-8a7b-4d6d-7685-08dac258453d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:42:40.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l84Km0OqCdW0jXxt+U0fcwOQZKNSqhs2bhdOkC452GxK8fLeBxeI3qrzW0YF575y0x2gE62x5N7f+47imvbOvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090104
X-Proofpoint-ORIG-GUID: kl124VuEc4rHVQfU_TC6A3VRXi9WX96S
X-Proofpoint-GUID: kl124VuEc4rHVQfU_TC6A3VRXi9WX96S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the tables added in the previous commits to introduce a new
/proc/kallmodsyms, in which [module names] are also given for things
that *could* have been modular had they not been built in to the kernel.
So symbols that are part of, say, ext4 are reported as [ext4] even if
ext4 happens to be buiilt in to the kernel in this configuration.

This helps disambiguate symbols with identical names when some are in
built-in modules are some are not, but if symbols are still ambiguous,
{object file names} are added as needed to disambiguate them.  The
object file names are only shown if they would prevent ambiguity, and
are minimized by chopping off as many leading path components as
possible without (symbol, module, objfile) combinations becoming
ambiguous again.  (Not every symbol with an {object file name} is
necessarily ambiguous, but at least one symbol in any such object file
would have been ambiguous if the object file was not mentioned.)

Symbols that are part of multiple modules at the same time are shown
with [multiple] [module names]: consumers will have to be ready to
handle such lines.  Also, kernel symbols for built-in modules will be
sorted by address, as usual for the core kernel, so will probably appear
interspersed with other symbols that are part of different modules and
non-modular always-built-in symbols, which, as usual, have no
square-bracketed module denotation.  This differs from /proc/kallsyms;
even though /proc/kallsyms shows the same symbols as /proc/kallmodsyms
in the same order, the only modules it names are loadable ones, which
are necessarily in single contiguous blocks and thus shown contiguously.

The result looks like this: ([...] to show where lines are omitted for
brevity):

ffffffff97606e50 t not_visible
ffffffff97606e70 T perf_msr_probe
ffffffff97606f80 t test_msr     [rapl]
ffffffff97606fa0 t __rapl_pmu_event_start       [rapl]
[...]
ffffffffa6007350 t rapl_pmu_event_stop  [rapl]
ffffffffa6007440 t rapl_pmu_event_del   [rapl]
ffffffffa6007460 t rapl_hrtimer_handle  [rapl]
ffffffffa6007500 t rapl_pmu_event_read  [rapl]
ffffffffa6007520 t rapl_pmu_event_init  [rapl]
ffffffffa6007630 t rapl_cpu_offline     [rapl]
ffffffffa6007710 t amd_pmu_event_map    {core.o}
ffffffffa6007750 t amd_pmu_add_event    {core.o}
ffffffffa6007760 t amd_put_event_constraints_f17h       {core.o}

The [rapl] notation is emitted even if rapl is built into the kernel
(but, obviously, not if it's not in the .config at all, or is in a
loadable module that is not loaded). The {core.o} is an object file
name.

Further down, we see what happens when object files are reused by
multiple modules, all of which are built in to the kernel, and some of
which have symbols that would be ambiguous without an object file name
attached in addition to the module names:

ffffffff97d7aed0 t liquidio_pcie_mmio_enabled   [liquidio]
ffffffff97d7aef0 t liquidio_pcie_resume [liquidio]
ffffffff97d7af00 t liquidio_ptp_adjtime [liquidio]
ffffffff97d7af50 t liquidio_ptp_enable  [liquidio]
ffffffff97d7af70 t liquidio_get_stats64 [liquidio]
ffffffff97d7b0f0 t liquidio_fix_features        [liquidio]
ffffffff97d7b1c0 t liquidio_get_port_parent_id  [liquidio]
[...]
ffffffff97d824c0 t lio_vf_rep_modinit   [liquidio]
ffffffff97d824f0 t lio_vf_rep_modexit   [liquidio]
ffffffff97d82520 t lio_ethtool_get_channels     [liquidio] [liquidio_vf]
ffffffff97d82600 t lio_ethtool_get_ringparam    [liquidio] [liquidio_vf]
ffffffff97d826a0 t lio_get_msglevel     [liquidio] [liquidio_vf]
ffffffff97d826c0 t lio_vf_set_msglevel  [liquidio] [liquidio_vf]
ffffffff97d826e0 t lio_get_pauseparam   [liquidio] [liquidio_vf]
ffffffff97d82710 t lio_get_ethtool_stats        [liquidio] [liquidio_vf]
ffffffff97d82e70 t lio_vf_get_ethtool_stats     [liquidio] [liquidio_vf]
[...]
ffffffff97d91a80 t cn23xx_vf_mbox_thread        [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91aa0 t cpumask_weight.constprop.0   [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91ac0 t cn23xx_vf_msix_interrupt_handler     [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91bd0 t cn23xx_vf_get_oq_ticks       [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91c00 t cn23xx_vf_ask_pf_to_do_flr   [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91c70 t cn23xx_octeon_pfvf_handshake [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91e20 t cn23xx_setup_octeon_vf_device        [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d92060 t octeon_mbox_read     [liquidio] [liquidio_vf]
ffffffff97d92230 t octeon_mbox_write    [liquidio] [liquidio_vf]
[...]
ffffffff97d946b0 t octeon_alloc_soft_command_resp       [liquidio] [liquidio_vf]
ffffffff97d947e0 t octnet_send_nic_data_pkt     [liquidio] [liquidio_vf]
ffffffff97d94820 t octnet_send_nic_ctrl_pkt     [liquidio] [liquidio_vf]
ffffffff97d94ab0 t liquidio_get_stats64 [liquidio_vf]
ffffffff97d94c10 t liquidio_fix_features        [liquidio_vf]
ffffffff97d94cd0 t wait_for_pending_requests    [liquidio_vf]

Like /proc/kallsyms, the output is driven by address, so keeps the
curious property of /proc/kallsyms that symbols may appear repeatedly
with different addresses: but now, unlike in /proc/kallsyms, we can see
that those symbols appear repeatedly because they are *different
symbols* that ultimately belong to different modules or different object
files within a module, all of which are built in to the kernel.

As with /proc/kallsyms, non-root usage produces addresses that are
all zero.

I am not wedded to the name or format of /proc/kallmodsyms, but felt it
best to split it out of /proc/kallsyms to avoid breaking existing
kallsyms parsers.

This is currently driven by a new config option, but now that
kallmodsyms data uses very little space, this option might be something
people don't want to bother with: maybe we can just control it via
CONFIG_KALLSYMS or something.

Internally, this uses a new kallsyms_builtin_module_address() almost
identical to kallsyms_sym_address() to get the address corresponding to
a given .kallsyms_modules index, and a new get_builtin_modobj_idx quite
similar to get_symbol_pos to determine the index in the
.kallsyms_modules and .kallsyms_objfiles arrays that relate to a given
address.  We save a little time by exploiting the fact that all callers
will only ever traverse this list from start to end by allowing them to
pass in the previous index returned from this function as a hint: thus
very few bsearches are actually needed.  (In theory this could change to
just walk straight down kallsyms_module_addresses/offsets and not bother
bsearching at all, but doing it this way is hardly any slower and much
more robust.)

We explicitly filter out displaying modules for non-text symbols
(perhaps this could be lifted for initialized data symbols in future).
There might be occasional incorrect module or objfile names for section
start/end symbols.

The display process is complicated a little by the weird format of the
.kallsyms_mod_objnames table: we have to look for multimodule entries
and print them as space-separated lists of module names.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v9: add objfile support.  Commit message adjustments.

 kernel/kallsyms.c          | 277 ++++++++++++++++++++++++++++++++++---
 kernel/kallsyms_internal.h |  14 ++
 2 files changed, 274 insertions(+), 17 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 60c20f301a6b..9667962173f1 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -187,6 +187,25 @@ static bool cleanup_symbol_name(char *s)
 	return false;
 }
 
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long kallsyms_builtin_module_address(int idx)
+{
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		return kallsyms_module_addresses[idx];
+
+	/* values are unsigned offsets if --absolute-percpu is not in effect */
+	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
+		return kallsyms_relative_base + (u32)kallsyms_module_offsets[idx];
+
+	/* ...otherwise, positive offsets are absolute values */
+	if (kallsyms_module_offsets[idx] >= 0)
+		return kallsyms_module_offsets[idx];
+
+	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
+	return kallsyms_relative_base - 1 - kallsyms_module_offsets[idx];
+}
+#endif
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
@@ -293,6 +312,54 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	return low;
 }
 
+/*
+ * The caller passes in an address, and we return an index to the corresponding
+ * builtin module index in .kallsyms_modules and .kallsyms_objfiles, or
+ * (unsigned long) -1 if none match.
+ *
+ * The hint_idx, if set, is a hint as to the possible return value, to handle
+ * the common case in which consecutive runs of addresses relate to the same
+ * index.
+ */
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long get_builtin_modobj_idx(unsigned long addr, unsigned long hint_idx)
+{
+	unsigned long low, high, mid;
+
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		BUG_ON(!kallsyms_module_addresses);
+	else
+		BUG_ON(!kallsyms_module_offsets);
+
+	/*
+	 * Do a binary search on the sorted kallsyms_modules array.  The last
+	 * entry in this array indicates the end of the text section, not an
+	 * object file.
+	 */
+	low = 0;
+	high = kallsyms_num_modules - 1;
+
+	if (hint_idx > low && hint_idx < (high - 1) &&
+	    addr >= kallsyms_builtin_module_address(hint_idx) &&
+	    addr < kallsyms_builtin_module_address(hint_idx + 1))
+		return hint_idx;
+
+	if (addr >= kallsyms_builtin_module_address(low)
+	    && addr < kallsyms_builtin_module_address(high)) {
+		while (high - low > 1) {
+			mid = low + (high - low) / 2;
+			if (kallsyms_builtin_module_address(mid) <= addr)
+				low = mid;
+			else
+				high = mid;
+		}
+		return low;
+	}
+
+	return (unsigned long) -1;
+}
+#endif
+
 /*
  * Lookup an address but don't bother to find any names.
  */
@@ -564,6 +631,9 @@ struct kallsym_iter {
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
+	const char *builtin_module_names;
+	const char *builtin_objfile_name;
+	unsigned long hint_builtin_modobj_idx;
 	int exported;
 	int show_value;
 };
@@ -594,6 +664,9 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
+
 	if (ret < 0) {
 		iter->pos_mod_end = iter->pos;
 		return 0;
@@ -613,6 +686,9 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 					 &iter->value, &iter->type,
 					 iter->name, iter->module_name,
 					 &iter->exported);
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
+
 	if (ret < 0) {
 		iter->pos_ftrace_mod_end = iter->pos;
 		return 0;
@@ -627,6 +703,8 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
 
 	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
 	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			      &iter->value, &iter->type,
 			      iter->name);
@@ -647,23 +725,74 @@ static int get_ksymbol_kprobe(struct kallsym_iter *iter)
 {
 	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
 	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
 				  &iter->value, &iter->type,
 				  iter->name) < 0 ? 0 : 1;
 }
 
 /* Returns space to next name. */
-static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
+static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms)
 {
 	unsigned off = iter->nameoff;
 
-	iter->module_name[0] = '\0';
+	iter->exported = 0;
 	iter->value = kallsyms_sym_address(iter->pos);
 
 	iter->type = kallsyms_get_symbol_type(off);
 
+	iter->module_name[0] = '\0';
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
+
 	off = kallsyms_expand_symbol(off, iter->name, ARRAY_SIZE(iter->name));
+#ifdef CONFIG_KALLMODSYMS
+	if (kallmodsyms) {
+		unsigned long modobj_idx = (unsigned long) -1;
+
+		if (kallsyms_module_offsets)
+			modobj_idx =
+			  get_builtin_modobj_idx(iter->value,
+						 iter->hint_builtin_modobj_idx);
 
+		/*
+		 * This is a built-in module iff the tables of built-in modules
+		 * (address->module name mappings), object files (ditto), and
+		 * module/objfile names are known, and if the address was found
+		 * there, and if the corresponding module index is nonzero, and
+		 * iff this is a text (or weak) symbol.  All other cases mean
+		 * off the end of the binary or in a non-modular range in
+		 * between one or more modules.
+		 *
+		 * The same rules are true for kallsyms_objfiles, except that
+		 * zero entries are much more common because we only record
+		 * object file names if we need them to disambiguate one or more
+		 * symbols: see scripts/kallsyms.c:disambiguate_syms.
+		 *
+		 * (Also guard against corrupt kallsyms_modules or
+		 * kallsyms_objfiles arrays pointing off the end of
+		 * kallsyms_mod_objnames.)
+		 */
+		if (kallsyms_modules != NULL && kallsyms_mod_objnames != NULL &&
+		    kallsyms_objfiles != NULL &&
+		    (iter->type == 't' || iter->type == 'T' ||
+		     iter->type == 'w' || iter->type == 'W') &&
+		    modobj_idx != (unsigned long) -1) {
+
+			if (kallsyms_modules[modobj_idx] != 0 &&
+			    kallsyms_modules[modobj_idx] < kallsyms_mod_objnames_len)
+				iter->builtin_module_names =
+					&kallsyms_mod_objnames[kallsyms_modules[modobj_idx]];
+
+			if (kallsyms_objfiles[modobj_idx] != 0 &&
+			    kallsyms_objfiles[modobj_idx] < kallsyms_mod_objnames_len)
+				iter->builtin_objfile_name =
+					&kallsyms_mod_objnames[kallsyms_objfiles[modobj_idx]];
+		}
+		iter->hint_builtin_modobj_idx = modobj_idx;
+	}
+#endif
 	return off - iter->nameoff;
 }
 
@@ -709,7 +838,7 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 }
 
 /* Returns false if pos at or past end of file. */
-static int update_iter(struct kallsym_iter *iter, loff_t pos)
+static int update_iter(struct kallsym_iter *iter, loff_t pos, int kallmodsyms)
 {
 	/* Module symbols can be accessed randomly. */
 	if (pos >= kallsyms_num_syms)
@@ -719,7 +848,7 @@ static int update_iter(struct kallsym_iter *iter, loff_t pos)
 	if (pos != iter->pos)
 		reset_iter(iter, pos);
 
-	iter->nameoff += get_ksymbol_core(iter);
+	iter->nameoff += get_ksymbol_core(iter, kallmodsyms);
 	iter->pos++;
 
 	return 1;
@@ -729,14 +858,14 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	(*pos)++;
 
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return p;
 }
 
 static void *s_start(struct seq_file *m, loff_t *pos)
 {
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return m->private;
 }
@@ -745,7 +874,7 @@ static void s_stop(struct seq_file *m, void *p)
 {
 }
 
-static int s_show(struct seq_file *m, void *p)
+static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 {
 	void *value;
 	struct kallsym_iter *iter = m->private;
@@ -756,23 +885,82 @@ static int s_show(struct seq_file *m, void *p)
 
 	value = iter->show_value ? (void *)iter->value : NULL;
 
-	if (iter->module_name[0]) {
+	/*
+	 * Real module, or built-in module and /proc/kallsyms being shown.
+	 */
+	if (iter->module_name[0] != '\0' ||
+	    (iter->builtin_module_names != NULL && kallmodsyms != 0)) {
 		char type;
 
 		/*
-		 * Label it "global" if it is exported,
-		 * "local" if not exported.
+		 * Label it "global" if it is exported, "local" if not exported.
 		 */
 		type = iter->exported ? toupper(iter->type) :
 					tolower(iter->type);
-		seq_printf(m, "%px %c %s\t[%s]\n", value,
-			   type, iter->name, iter->module_name);
-	} else
-		seq_printf(m, "%px %c %s\n", value,
+#ifdef CONFIG_KALLMODSYMS
+		if (kallmodsyms) {
+			/*
+			 * /proc/kallmodsyms, built as a module.
+			 */
+			if (iter->builtin_module_names == NULL)
+				seq_printf(m, "%px %c %s\t[%s]", value,
+					   type, iter->name,
+					   iter->module_name);
+			/*
+			 * /proc/kallmodsyms, single-module symbol.
+			 */
+			else if (*iter->builtin_module_names != '\0')
+				seq_printf(m, "%px %c %s\t[%s]", value,
+					   type, iter->name,
+					   iter->builtin_module_names);
+			/*
+			 * /proc/kallmodsyms, multimodule symbol.  Formatted
+			 * as \0MODULE_COUNTmodule-1\0module-2\0, where
+			 * MODULE_COUNT is a single byte, 2 or higher.
+			 */
+			else {
+				size_t i = *(char *)(iter->builtin_module_names + 1);
+				const char *walk = iter->builtin_module_names + 2;
+
+				seq_printf(m, "%px %c %s\t[%s]", value,
+					   type, iter->name, walk);
+
+                                while (--i > 0) {
+					walk += strlen(walk) + 1;
+					seq_printf(m, " [%s]", walk);
+				}
+			}
+			/*
+			 * Possibly there is an objfile name too, if needed to
+			 * disambiguate at least one symbol.
+			 */
+			if (iter->builtin_objfile_name)
+				seq_printf(m, " {%s.o}", iter->builtin_objfile_name);
+
+			seq_printf(m, "\n");
+		} else				/* !kallmodsyms */
+#endif /* CONFIG_KALLMODSYMS */
+			seq_printf(m, "%px %c %s\t[%s]\n", value,
+				   type, iter->name, iter->module_name);
+	} else {
+		seq_printf(m, "%px %c %s", value,
 			   iter->type, iter->name);
+#ifdef CONFIG_KALLMODSYMS
+		if (kallmodsyms) {
+			if (iter->builtin_objfile_name)
+				seq_printf(m, "\t{%s.o}", iter->builtin_objfile_name);
+		}
+#endif /* CONFIG_KALLMODSYMS */
+		seq_printf(m, "\n");
+	}
 	return 0;
 }
 
+static int s_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 0);
+}
+
 static const struct seq_operations kallsyms_op = {
 	.start = s_start,
 	.next = s_next,
@@ -780,6 +968,36 @@ static const struct seq_operations kallsyms_op = {
 	.show = s_show
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static int s_mod_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 1);
+}
+
+static void *s_mod_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	(*pos)++;
+
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return p;
+}
+
+static void *s_mod_start(struct seq_file *m, loff_t *pos)
+{
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return m->private;
+}
+
+static const struct seq_operations kallmodsyms_op = {
+	.start = s_mod_start,
+	.next = s_mod_next,
+	.stop = s_stop,
+	.show = s_mod_show
+};
+#endif
+
 #ifdef CONFIG_BPF_SYSCALL
 
 struct bpf_iter__ksym {
@@ -905,7 +1123,8 @@ bool kallsyms_show_value(const struct cred *cred)
 	}
 }
 
-static int kallsyms_open(struct inode *inode, struct file *file)
+static int kallsyms_open_internal(struct inode *inode, struct file *file,
+	const struct seq_operations *ops)
 {
 	/*
 	 * We keep iterator in m->private, since normal case is to
@@ -913,7 +1132,7 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	 * using get_symbol_offset for every symbol.
 	 */
 	struct kallsym_iter *iter;
-	iter = __seq_open_private(file, &kallsyms_op, sizeof(*iter));
+	iter = __seq_open_private(file, ops, sizeof(*iter));
 	if (!iter)
 		return -ENOMEM;
 	reset_iter(iter, 0);
@@ -926,6 +1145,18 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int kallsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallsyms_op);
+}
+
+#ifdef CONFIG_KALLMODSYMS
+static int kallmodsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallmodsyms_op);
+}
+#endif
+
 #ifdef	CONFIG_KGDB_KDB
 const char *kdb_walk_kallsyms(loff_t *pos)
 {
@@ -936,7 +1167,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 		reset_iter(&kdb_walk_kallsyms_iter, 0);
 	}
 	while (1) {
-		if (!update_iter(&kdb_walk_kallsyms_iter, *pos))
+		if (!update_iter(&kdb_walk_kallsyms_iter, *pos, 0))
 			return NULL;
 		++*pos;
 		/* Some debugging symbols have no name.  Ignore them. */
@@ -953,9 +1184,21 @@ static const struct proc_ops kallsyms_proc_ops = {
 	.proc_release	= seq_release_private,
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static const struct proc_ops kallmodsyms_proc_ops = {
+	.proc_open	= kallmodsyms_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= seq_release_private,
+};
+#endif
+
 static int __init kallsyms_init(void)
 {
 	proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
+#ifdef CONFIG_KALLMODSYMS
+	proc_create("kallmodsyms", 0444, NULL, &kallmodsyms_proc_ops);
+#endif
 	return 0;
 }
 device_initcall(kallsyms_init);
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 2d0c6f2f0243..0ee6d97b732e 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -22,8 +22,22 @@ __section(".rodata") __attribute__((weak));
 extern const unsigned long kallsyms_relative_base
 __section(".rodata") __attribute__((weak));
 
+extern const unsigned long kallsyms_num_modules
+__section(".rodata") __attribute__((weak));
+
+extern const unsigned long kallsyms_num_objfiles
+__section(".rodata") __attribute__((weak));
+
+extern const unsigned long kallsyms_mod_objnames_len
+__section(".rodata") __attribute__((weak));
+
 extern const char kallsyms_token_table[] __weak;
 extern const u16 kallsyms_token_index[] __weak;
+extern const unsigned long kallsyms_module_addresses[] __weak;
+extern const int kallsyms_module_offsets[] __weak;
+extern const u32 kallsyms_modules[] __weak;
+extern const u32 kallsyms_objfiles[] __weak;
+extern const char kallsyms_mod_objnames[] __weak;
 
 extern const unsigned int kallsyms_markers[] __weak;
 
-- 
2.38.0.266.g481848f278

