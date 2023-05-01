Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D196F3508
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjEAR05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjEAR0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:26:54 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2107.outbound.protection.outlook.com [40.92.53.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41852AF
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 10:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YASJI5bGYzakWODw1puXNd6p9a+Y26UWJtwavAKs96fCCV3GWBFTichAD/BIFt9RrH1vkQjHyjKuOaPCjP3zba8TNnvDCunj93yffgzybZkfVdXxdRjkHfeIlHBNNxRxplaDoCnWM0eLYnpvLV6sB9Fb2hB3t4O2lw6ed3MmbXKdQ3BI1sPYj1iksvqVOzPpWu5gKbEfcsMLJmNS7ieMu8v2Apy36tvPepKnkEt243AX2wmWWCDVi/l+zujyUuHzGowQPhlauNEP69pC0QWRMMKg6pz0y1VxCz/rS0zQxSk4wEioZEsea00Ghv8QyXgQsGZ++dNga/WJSMWLLlmAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+5wWrJCn5d1ss3FUxnJ9ooqNEA9bOCeDXManW79pY8=;
 b=fQZ4bmhNa9Bw7rvR37mFiZcIHJQYaXWDvcWHdghwWqTV+eN4a/JfRNHP1xEjGH82qi1Y9fRqaosMvj004FOxeShEE0+ngLiv0a8No4XV+Ww+FaDmK2YilXw97MgVAcfDuZEMSQQcHO+fkk47FUcneg+Q3ba7n9Ae72A3lXuCRYzpVF0baSpT4P3FTj2XTngDOMsxaZVhN50Nu+7hmodRKcc0C1kN2s+WQwyo7JukglDM88qsOd2kgxlt4kqpNld1bRCYcXvkU9KIETRc/fjXfCFu9zzSnUpn3u+uq0Gx9k8CgH87P8SE/5KTlTryjs8BDNMplJMBk6mHBvy4qw3EDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+5wWrJCn5d1ss3FUxnJ9ooqNEA9bOCeDXManW79pY8=;
 b=bQ9VtQdRrCNQe1kqvOT/8s+YPO2YmWbx0EyEABuGCSQbBkxSAVOakJN+SBdMgIGaXB8xvEPdB2ZKMGCB2xYA/ioqNq9Wv8IgpHXwAQ67RXvekmyFYTPSw4PV3ROkw+CEHIuTvAPxG4Yh60QmK8F15f7BdQ3m4Fu4a8u6scXehyC4ZvrlFDlMrMyCGqzzQuMlg93uuGw1Nrc91MyKJRRXvVrs6+hd0sWIz3Zw8+LbojBXcB1yXG5FStgrr99RETcyWinWICXJyihTftwgaDJP7HSr+e5kMH6UCw5zDMLoFRHY8PXCMWOlSAbuQnbGEc58k5B5gaeceQ0VITJG09+5nA==
Received: from TYZPR01MB4257.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c3::8) by SG2PR01MB3578.apcprd01.prod.exchangelabs.com
 (2603:1096:0:3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 17:25:44 +0000
Received: from TYZPR01MB4257.apcprd01.prod.exchangelabs.com
 ([fe80::eee:d027:c3f6:fcb0]) by TYZPR01MB4257.apcprd01.prod.exchangelabs.com
 ([fe80::eee:d027:c3f6:fcb0%4]) with mapi id 15.20.6340.028; Mon, 1 May 2023
 17:25:44 +0000
Date:   Mon, 1 May 2023 22:55:36 +0530 (GMT+05:30)
From:   cilujain77@outlook.com
To:     linux-kernel@vger.kernel.org
Message-ID: <TYZPR01MB425729E75181BD99835D5F7DC36E9@TYZPR01MB4257.apcprd01.prod.exchangelabs.com>
Subject: =?UTF-8?Q?Qualitative_and_quantitative_analysis_is_point_toward=E2=80=A6?=
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-TMN:  [xRo1GHSBjdGVIxdCbOcqDkyUkmIiwAe4F1mObgFwcx/KtLA1Jq9DHg==]
X-ClientProxiedBy: PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::11) To TYZPR01MB4257.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c3::8)
X-Microsoft-Original-Message-ID: <2718028.15.1682961936566@localhost>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB4257:EE_|SG2PR01MB3578:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a42808-0953-4d99-2070-08db4a691868
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SkD6L50qPweAReKJu23eidJvD45b0aVYD7GorJtWxcyXnQVcDK91XyN2NFA4q8/wnUW8/+Jmi+Y9YT0ZoO5H+JBGvujE2zIdRVetupEY42PfMngBCuguUmc/72bHclRWxqj8a/b9rONKlgg/PmMyMq6HiEDJX4oY0MAJKe5iRF/roU0VD5NheDEkdl7UhoAlsEJmhcEytpYJVKRyZbjMn6CCV8xboEQicJmXjfd0WgWKxQCmhedNsXPVMs45PM4+WsaaSSLZQAlfLx0zk4iyYrxVFQxcoEH9LuyY3vsk58d3ifEyLSL0ISI+lo5cPLASfFOOMUmHExOb92PosDUr1sof16+qiqajg22IRMtIwDcmd2wg9zjbWScnUKhiYcgSOvBoEHKGqjVHb/EqG6bQDbiI0H/7fC9NgAmiTJNpTnk5mZ0WF7SBaKYUTczk0HkdJAi95a0CNDoxw4pyuBYItcHSNl5fGRAqoh0rCPF3AbD4akGyd164mHI958eQtbSf0bPZKvBXu6HcPjqCvfNVTNffVd/fNJaFq+oSpbbhr2/OEgOMZbil3Q64Y0DE3Vx
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9OeA4K+Ht4ZDXxl7f5kploSrsP1OmMeVGbhTndNk3wQE68X73YS0jw/CHZYn?=
 =?us-ascii?Q?MY6G7zM2wx/I/z+drALcRsBClBy4DiibyLLYT7rXtnd4BLSw5Afw3YsEzncT?=
 =?us-ascii?Q?xCNQBJm8QsGmJHygyqFZaVh2lhx45jQXT/T859ti3thSspaRvo0qoxzysbmD?=
 =?us-ascii?Q?ZMEDH0s6r2jnjcmMVIFuAbR/RK59YegrKcec6imyjvULoPq/NYTKgiHHnt9l?=
 =?us-ascii?Q?zE2tddMO+ueHOgSfqMdVDwl6sx9r8VyGdVb+a80fo06E9GpwPow32HZ6z2ih?=
 =?us-ascii?Q?aHJKlW/mv1TbuYwDW4wVls7UWrrHCYmHEnRWi4X1E42BjJwn5hhcmzq8eb1n?=
 =?us-ascii?Q?+fAxoc5HO6fASFPeTx+TEXjztPVNktQHxDjaI32Sg06L6ilpgU145FpOI0oG?=
 =?us-ascii?Q?H1xKwK2v2dTR83uSjKQf1dfSsZ5RgLBg8hw4HGql+xdAhCf7ZCeTiZFtnYnD?=
 =?us-ascii?Q?3wjf8zcHWfNmztWCCax19QNfeABT32QFNj7uzZHfFfO4DHM0lAfJp2tNQBNZ?=
 =?us-ascii?Q?4KReuXMgZBjVNIpxFd9t+zjvjcttUKTgZkV1IQGcnl9PA6vHVvzBZTv2m96p?=
 =?us-ascii?Q?5rhM/duTVifnxiB7zoHA1viEgbXQ8Isyry42vPFG3WdG46hvjTqVSt46f4dL?=
 =?us-ascii?Q?4q8LKIpfmMyxJZKi9B+VZeghs9nugUrY5f0x9x+EH3qmUV9atPL4ghBjEf9o?=
 =?us-ascii?Q?Yy4x44ijYPXm+7PePoQWgAUL0wpPlu8ClhQkcNkaWOUxT/RbpeHNy4CiGEgu?=
 =?us-ascii?Q?TrlodIsWo56Ww/u193Vraxy7yHjd2nm5w5FSD4AzqF9cxTxH+ExXFV2rS9wC?=
 =?us-ascii?Q?v5w/gKN7QaAK2De7Ne1o5Z5NHV6PcWCtxVxHR7aBfu2N8t1i1rrbr3TVVOV7?=
 =?us-ascii?Q?ZcMdRJ3grCfyqDr6Jy6XShsyRlW1r2SA5Dg4VZ5MQ1klBA/S9ny7gSZZVuRy?=
 =?us-ascii?Q?OxL78AESrEQLRrWEMfvDYfht4IqQVrKoCRip5ELZZc8ltSvYSdmx8owWnzB9?=
 =?us-ascii?Q?hyNSOOHBOFkFjwa2fgVzBPXY6IdpntFvFsj7KPz5YWbNmLFdHJPvGXYvV6QK?=
 =?us-ascii?Q?ti0t9ERbrdF/zpdM/ub97cCXOJ1QU+cbhlw1IRaJsqDYC0HM4LxmRAXzAXuW?=
 =?us-ascii?Q?3YN7yyiwTGPujttqohEphtNUkF8URfc1hyP9t/h9MU8oWERxi4DMYAqUsMIV?=
 =?us-ascii?Q?Ozoj0HrVSZt0Br3B5Rm4672/5uOvBtXtrXeGQFgmGIZzstVzDTAAIQoDMIrv?=
 =?us-ascii?Q?uhXBQBtIQrOFFNeltcNw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a42808-0953-4d99-2070-08db4a691868
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4257.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 17:25:44.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3578
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day to you. Most groups have married the processes for internal decision making around the objectives of technology groups and business goals. Governments, Fortune 500s, entrepreneurs, educators, and nonprofits are all saying the same thing.
