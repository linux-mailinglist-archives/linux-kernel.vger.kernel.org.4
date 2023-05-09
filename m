Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B566FC1E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjEIIqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjEIIqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:46:08 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED59883C8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:46:06 -0700 (PDT)
X-ASG-Debug-ID: 1683621961-086e237e536fe60001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id edT1DtMeMi1OGdsv (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 09 May 2023 16:46:01 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 9 May
 2023 16:46:01 +0800
Received: from [10.29.8.33] (10.29.8.33) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 9 May
 2023 16:45:59 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <f5d3c74c-3a82-30af-9603-09eb907bff6d@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.33
Date:   Tue, 9 May 2023 16:45:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] Add PMC support for Zhaoxin Yongfeng architecture
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 0/3] Add PMC support for Zhaoxin Yongfeng architecture
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>,
        <cooperyan@zhaoxin.com>,
        "Silvia Zhao(BJ-RD)" <SilviaZhao@zhaoxin.com>
References: <20230323024026.823-1-silviazhao-oc@zhaoxin.com>
From:   silviazhao <silviazhao-oc@zhaoxin.com>
In-Reply-To: <20230323024026.823-1-silviazhao-oc@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.29.8.33]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1683621961
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 864
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.108523
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/23 10:40, silviazhao wrote:
> Add PMC support for Zhaoxin Yongfeng architecture.
> Dave Hansen suggested to use macros instead of open-coded model numbers.
> So create arch/x86/include/asm/zhaoxin-family.h to introduce macros for
> Zhaoxin family numbers.
> https://lkml.org/lkml/2023/3/16/841
>
> silviazhao (3):
>    x86/cpu/zhaoxin: Introduce macros for Zhaoxin family numbers
>    perf/x86/zhaoxin: Replace open-coded model number with macros
>    perf/x86/zhaoxin: Add Yongfeng support
>
>   arch/x86/events/zhaoxin/core.c        | 55 ++++++++++++++++++---------
>   arch/x86/include/asm/zhaoxin-family.h | 19 +++++++++
>   2 files changed, 57 insertions(+), 17 deletions(-)
>   create mode 100644 arch/x86/include/asm/zhaoxin-family.h
>
Is there anything that needs to be modified in this patch set? Please 
let me know.
Thx.

