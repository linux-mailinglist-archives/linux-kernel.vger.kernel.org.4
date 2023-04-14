Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6568C6E243B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDNN1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDNN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:27:48 -0400
X-Greylist: delayed 773 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Apr 2023 06:27:45 PDT
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8CD6A59
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:27:45 -0700 (PDT)
X-ASG-Debug-ID: 1681478088-1eb14e638601c30001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id oaC3tpWSXUbpeUsq (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 14 Apr 2023 21:14:48 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Fri, 14 Apr
 2023 21:14:48 +0800
Received: from [10.32.65.162] (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Fri, 14 Apr
 2023 21:14:46 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <7866e99a-df88-14fa-92ae-c5b5d176724b@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.65.162
Date:   Fri, 14 Apr 2023 21:14:17 +0800
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
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20230414104808.GBZDkvaJechZSM+SI9@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.65.162]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1681478088
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2276
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107406
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/23 18:48, Borislav Petkov wrote:
> On Fri, Apr 14, 2023 at 05:53:34PM +0800, Tony W Wang-oc wrote:
>> Extend CPUID leaf 0xc0000001 to support SM2, SM3, SM4, PARALLAX, TM3,
>> RNG2, PHE2, RSA.
>>
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 0]  SM2
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 1]  SM2_EN
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 4]  SM3 SM4
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 5]  SM3_EN SM4_EN
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 16] PARALLAX
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 17] PARALLAX_EN
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 20] TM3
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 21] TM3_EN
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 22] RNG2
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 23] RNG2_EN
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 25] PHE2
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 26] PHE2_EN
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 27] RSA
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 28] RSA_EN
> 
> None of those flags are used in code, why do we need this patch?
> 
 The instructions about these flags can be executed at any privilege
level. I think using these flags in kernel mode is a case. This patch
shows the statement of these flags to the user mode explicitly. So users
can see and use these CPU features conveniently.

> If you want to dump them on the hardware to know what's set or not,
> there's tools/arch/x86/kcpuid/ for that.
> 
>> SM2/SM3/SM4 imply the instructions support for Chinese cipher security
>> algorithm generations 2/3/4.
>> PARALLAX is the feature of Zhaoxin CPU that automatically adjusts
>> processors's voltage as a function of temperature.
>> TM3 is the abbreviation of Thermal Monitor version 3.
>> RNG2 is the abbreviation of Random Number Generation version 2.
>> PHE2 is the abbreviation of Padlock Hash Engine version 2.
>> RSA implies Zhaoxin hardware support for RSA algorithm.
>>
>> All these features have two relative CPUID bits, one bit implies the
>> existence of the feature and the other bit with postfix "EN" implies
>> the availability of this feature.
> 
> That's a lot of waste of CPUID bits but that's your decision.
> 
Sorry about that.
This implementation aimed to control or statement these features
independently.

Sincerely
TonyWWangoc
