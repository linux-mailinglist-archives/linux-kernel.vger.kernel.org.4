Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742B46EF6A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbjDZOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241146AbjDZOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:43:23 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF431985
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZAToeNh/iqjhimxlGF0MP+929P9NS1fJavm8yS3bn5vChet8FMk2Yg6tlsLmEXzdgDiv9qp1hCza9ndyGb0lkBt3+AxO/DiyQHa/oDsNwgTfATB1eugK70m0ck7tfk4ntxXG/ls0JWRsUUASbFi/WyFvAOsCrl/Zmk0hSQeYEKZEtpnDmuNOPu1gTrZ2f2NsTeZbHy/7M/b9g06DK3DUdFJDtZCD/MF/R0rcHJ84KoPWsyIYDOE2qHhhFTfs3j6z6lVV1+L3v1GPgb18b9iWUjJHIhYTowdqppVNZxlqMIfqz47IrRlWjpI57xXtYmcggJVomF+MEk4xl3E7nhdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt90x6IuFKhqtjG97cacBFvVh1HMTZ6sVnPGLUEoXow=;
 b=LdW7hQ1drIIi//VzY+D2ZC+8lPJJkQd51DxAHo9vM2eWmAsQRbeA+92L1CQ5R5k+oNzMxzhSZuEkQ+3kq64Th6eqetlBBLh524sDB5bAACVilM01CtpXeYSGv0YJki13Lvuk7PcvIT7bQTX9uucR2dUaz8sfThIAecXrjiQ0YkZRpTaOhdnY7fBESjHVdfRcqXw2eKTo3bDZh2oYXdKtCYIz5OBU0L5rrR7V8V/xx1ewtwvvbMqzBgAxFCHWukBVqg8iXXVwksFwEznDfCQVaI0DEtn7P9Y7dIbYIitGUssl9eAE0fvtwkdwx2OvPlgrs9+BMuP4tevEizKvj6RFUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=amacapital.net smtp.mailfrom=ddn.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ddn.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt90x6IuFKhqtjG97cacBFvVh1HMTZ6sVnPGLUEoXow=;
 b=SrHyFclP84K6TXT+2GGX30CERcRsiYUzMw0Xo9dlxg0l/1IrpDLmDgH3vAfrmVoubd45Hpm/mU3hHp/hqHmjUKrbH2BoMjPhXVQWnskydW0oG4+g5uVrqG/mW/89TQwabRcLtA8BC0RDqCHG9+3qPr6xvZSIoyQDRugJMLa/oaY=
Received: from MW4PR03CA0245.namprd03.prod.outlook.com (2603:10b6:303:b4::10)
 by DS0PR19MB7742.namprd19.prod.outlook.com (2603:10b6:8:121::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 26 Apr
 2023 14:43:18 +0000
Received: from MW2NAM04FT038.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::d8) by MW4PR03CA0245.outlook.office365.com
 (2603:10b6:303:b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 14:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT038.mail.protection.outlook.com (10.13.31.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 14:43:17 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id EE00A20C6878;
        Wed, 26 Apr 2023 08:44:24 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     avagin@google.com
Cc:     avagin@gmail.com, brauner@kernel.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        mingo@redhat.com, peterz@infradead.org, posk@google.com,
        tycho@tycho.pizza, vincent.guittot@linaro.org, wad@chromium.org,
        yu.c.chen@intel.com
Subject: Re: [PATCH 3/6] sched: add a few helpers to wake up tasks on the current cpu
Date:   Wed, 26 Apr 2023 16:43:16 +0200
Message-Id: <20230308073201.3102738-4-avagin@google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308073201.3102738-1-avagin@google.com>
References: <20230308073201.3102738-1-avagin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT038:EE_|DS0PR19MB7742:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6f4de0bf-0545-4b93-e2ec-08db466492c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nDcNdegyVu5kNQv4nAvMsYYYTwiv7NrprFPIx/z+GuCGKnBTGcCHiV4+XrXcadfymhswgIEe5KL2059ggAhIO8LTPzV29RZ+aTRkbRRh5uLqoezwg2jlK3RpfLVZ/y7G+wbzaLgd2zJ0F6U/uM0lRi9IYC3Z4bTq96Rq9MOwTkbmi8TzVorB1apz4lD0O1VNEh0PnPm3parG8IYOxxz+CQahryMme2bw/V8lI7xEL3QYR0dt+2Vo8F4H8/tbyKqZJVhj7cIEXAh32o475P7xGTD3YWOeWgVxUlMksB2CefO4meIuCrkMvKE0GSHh6igjEt06XbZo49ps5rVnqUVJm8kHPu5Dhs34mLxtUEjrOJcX4PI/0YFxqHWakvFXdPC6tOTvXDl6If9IsKzrXtcPyoLIZ8BUOnfaaRnMY87c9AO+sVLNAHwcuznk6uq4Zd5rdF33riqBcVgzHn0MtIju3W/1nxomV9tHBI1dBCx9VuQhQbhvFDu+2hkTYMohhaO/tx1Wi7Mbs47kbDzBCPKoj7VL8TamlFJATwDftOpwblNwb8gwJnOfdVLKeAF0hy+zVP8hANAud4dE5m5yZIECNYUzMgrTti3BGH+2tsVJjkYoekBXUxi/HAg7W+laXCp6WiAX7IHi/GnaMUOCibrjQ3gEBdCHKqEZk3IILulAD03oXWkD/ZXrY0D74oyQtn0
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39850400004)(346002)(136003)(451199021)(36840700001)(46966006)(966005)(9686003)(1076003)(26005)(356005)(40480700001)(336012)(83380400001)(36756003)(36860700001)(47076005)(82740400003)(186003)(6266002)(70206006)(81166007)(55446002)(86362001)(70586007)(6916009)(478600001)(8676002)(8936002)(7416002)(37006003)(5660300002)(41300700001)(2906002)(82310400005)(4326008)(6666004)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 14:43:17.4973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4de0bf-0545-4b93-e2ec-08db466492c1
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT038.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7742
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add complete_on_current_cpu, wake_up_poll_on_current_cpu helpers to wake
> up tasks on the current CPU.

> These two helpers are useful when the task needs to make a synchronous context
> switch to another task. In this context, synchronous means it wakes up the
> target task and falls asleep right after that.

> One example of such workloads is seccomp user notifies. This mechanism allows
> the  supervisor process handles system calls on behalf of a target process.
> While the supervisor is handling an intercepted system call, the target process
> will be blocked in the kernel, waiting for a response to come back.

> On-CPU context switches are much faster than regular ones.

> Signed-off-by: Andrei Vagin <avagin@google.com>

Avoiding cpu switches is very desirable for fuse, I'm working on fuse over uring
with per core queues. In my current branch and running a single threaded bonnie++
I get about 9000 creates/s when I bind the process to a core, about 7000 creates/s
when I set SCHED_IDLE for the ring threads and back to 9000 with SCHED_IDLE and
disabling cpu migration in fs/fuse/dev.c request_wait_answer() before going into
the waitq and enabling it back after waking up. 

I had reported this a few weeks back 
https://lore.kernel.org/lkml/d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com/
and had been pointed to your and Prateeks patch series. I'm now going
through these series. Interesting part is that a few weeks I didn't need
SCHED_IDLE, just disabling/enabling migration before/after waking up was
enough.

[...]

> EXPORT_SYMBOL(swake_up_one);
> diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> index 133b74730738..47803a0b8d5d 100644
> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -161,6 +161,11 @@ int __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
>  }
>  EXPORT_SYMBOL(__wake_up);
 
> +void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key)
> +{
> +	__wake_up_common_lock(wq_head, mode, 1, WF_CURRENT_CPU, key);
> +}

I'm about to test this instead of migrate_disable/migrate_enable, but the symbol needs
to be exported - any objection to do that right from the beginning in your patch? 


Thanks,
Bernd


