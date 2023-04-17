Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A43B6E3D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjDQCrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQCre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:47:34 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329222117
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 19:47:33 -0700 (PDT)
X-ASG-Debug-ID: 1681699650-1eb14e63880fab0001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id x1VcCWwhnV8HXCt1 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 17 Apr 2023 10:47:30 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 17 Apr
 2023 10:47:29 +0800
Received: from [10.32.65.162] (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 17 Apr
 2023 10:47:28 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <8647895b-560f-2272-aae4-eda00fc06eca@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.65.162
Date:   Mon, 17 Apr 2023 10:47:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] x86/cpufeatures: extend CPUID leaf 0xc0000001 support for
 Zhaoxin
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH] x86/cpufeatures: extend CPUID leaf 0xc0000001 support for
 Zhaoxin
To:     Borislav Petkov <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <seanjc@google.com>, <pbonzini@redhat.com>, <kim.phillips@amd.com>,
        <babu.moger@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
        <sandipan.das@amd.com>, <CobeChen@zhaoxin.com>,
        <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>
References: <20230414095334.8743-1-TonyWWang-oc@zhaoxin.com>
 <20230414104808.GBZDkvaJechZSM+SI9@fat_crate.local>
 <7866e99a-df88-14fa-92ae-c5b5d176724b@zhaoxin.com>
 <20230414134824.GCZDlZqDWLl6A958SF@fat_crate.local>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20230414134824.GCZDlZqDWLl6A958SF@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.65.162]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1681699650
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 807
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107522
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/23 21:48, Borislav Petkov wrote:
> On Fri, Apr 14, 2023 at 09:14:17PM +0800, Tony W Wang-oc wrote:
>>  The instructions about these flags can be executed at any privilege
>> level. I think using these flags in kernel mode is a case. This patch
>> shows the statement of these flags to the user mode explicitly. So users
>> can see and use these CPU features conveniently.
>>
>>> If you want to dump them on the hardware to know what's set or not,
>>> there's tools/arch/x86/kcpuid/ for that.
> 
> See this here. We have this tool exactly for users who wanna see CPU
> features. All CPU features, as a matter of fact.
> 

Ok, will patch this tool for Zhaoxin extended CPUID leaf.
Will add Zhaoxin CPU features to kernel when they are used by the kernel.

Sincerely
TonyWWangoc
