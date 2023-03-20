Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00C66C08B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 02:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCTBqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 21:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCTBqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 21:46:22 -0400
X-Greylist: delayed 616 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Mar 2023 18:46:20 PDT
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31379C163
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 18:46:20 -0700 (PDT)
X-ASG-Debug-ID: 1679276160-1eb14e6d7b1e670001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id czeTCPi4m3nL3oj8 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 20 Mar 2023 09:36:00 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 20 Mar
 2023 09:35:59 +0800
Received: from [10.29.8.47] (10.29.8.47) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 20 Mar
 2023 09:35:57 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <81897a7c-2dab-f854-ff09-e50d8b875f02@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.47
Date:   Mon, 20 Mar 2023 09:35:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] perf/x86/zhaoxin: Add Yongfeng support
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH] perf/x86/zhaoxin: Add Yongfeng support
To:     Dave Hansen <dave.hansen@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>,
        <silviazhao@zhaoxin.com>, <cooperyan@zhaoxin.com>
References: <20230316021647.771-1-silviazhao-oc@zhaoxin.com>
 <6f78ecfb-99c8-eee3-cad0-69bbd88a107c@intel.com>
From:   silviazhaooc <silviazhao-oc@zhaoxin.com>
In-Reply-To: <6f78ecfb-99c8-eee3-cad0-69bbd88a107c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.29.8.47]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1679276160
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 926
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.106283
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/16 22:59, Dave Hansen wrote:
> On 3/15/23 19:16, silviazhao wrote:
>> +		case 0x5b:
>> +			zx_pmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
>> +				X86_CONFIG(.event = 0x02, .umask = 0x01, .inv = 0x01,
>> +						.cmask = 0x01);
> 
> On the Intel side of x86/ land, we used to have these open-coded
> model/family numbers scattered about.  But, a few years ago, we started
> populating arch/x86/include/asm/intel-family.h and using those instead.
> I think it's been pretty successful.  It's a lot easier to grep for
> INTEL_FAM6_NEHALEM_EX than for 0x2E.
> 
> Is there a chance we could start doing the same for other CPU vendors?
> Perhaps start with:
> 
> #define ZHAOXIN_FAMILY_YONGFENG 0x5B

Great suggestion. After discussing with my colleagues, we decide to add 
these open-coded model/family numbers into a new file like 
zhaoxin-family.h, create a new patch set and re-commit.
