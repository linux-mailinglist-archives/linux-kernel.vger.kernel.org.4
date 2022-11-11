Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDDF62635B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiKKVGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiKKVGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:06:10 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA55783B94;
        Fri, 11 Nov 2022 13:06:09 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ABL5L2W124440;
        Fri, 11 Nov 2022 15:05:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668200721;
        bh=qZUp0LgToCdeKTOa83YyPSwidLhs3SutcFlXMmeJ5+g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Nk8BC8B1RQkKSHbYNSEtNECGVu6W9yYKEsbJ5eKqzvUZUtARwYEG5mLRuPbdqrKdC
         uXMqSarIdMkG6TVr2dRZER9MRDGmXwVVXOLlAsKiIzX31SKCg0VyOpheMf7fW6U0s4
         hoYQs4/YNUoKusjtgFgBMYtuHQB50mat3wigoFbE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ABL5Lv2092391
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Nov 2022 15:05:21 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 11
 Nov 2022 15:05:20 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 11 Nov 2022 15:05:20 -0600
Received: from [128.247.81.39] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ABL5K5I066401;
        Fri, 11 Nov 2022 15:05:20 -0600
Message-ID: <e5ce57b2-4557-2dcb-fb3a-71e2acae4502@ti.com>
Date:   Fri, 11 Nov 2022 15:05:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/7] Rename DTB overlay source files
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221024173434.32518-1-afd@ti.com>
 <CAL_JsqJxgVwsjKnkCEkZeoSsDgaRD+DVPkHRBc2SrcSq69PBNw@mail.gmail.com>
 <Y26lDEtiG4KFzc91@smile.fi.intel.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <Y26lDEtiG4KFzc91@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/22 1:39 PM, Andy Shevchenko wrote:
> On Wed, Oct 26, 2022 at 09:11:21AM -0500, Rob Herring wrote:
>> On Mon, Oct 24, 2022 at 12:34 PM Andrew Davis <afd@ti.com> wrote:
>>>
>>> Hello all,
>>>
>>> This is a series based on my patch here[0]. As suggested by Rob
>>> I've resurrected Frank's patch and appended it to mine as a series.
>>>
>>> First patch here is my original patch, 3rd is Frank's patch but with
>>> the unittest changes pulled out into the 2nd patch. That was re-worked
>>> moving the source building macro into scripts/Makefile.lib.
>>>
>>> Patches 4, 5, and 6 are an attempt at renaming all the existing DTB
>>> overlays. Split out by platform so they could be taken by platform
>>> maintainers or if easier ACK'd here and taken all together.
>>>
>>> This should cover all the DTB overlays so we can remove the old .dts
>>> rule for overlays and make .dtso the only supported way, let me know
>>> if we want that this cycle and I can post that too.
>>>
>>> Thanks,
>>> Andrew
>>>
>>> Changes from v1[1]:
>>>   - Added patch to rename pi433 overlay.
>>>   - Cleaned wording on patch 4-6.
>>>   - Collected some ACKs
>>>
>>> [0] https://www.spinics.net/lists/kernel/msg4548509.html
>>> [1] https://www.spinics.net/lists/arm-kernel/msg1020165.html
>>>
>>> Andrew Davis (6):
>>>    kbuild: Allow DTB overlays to built from .dtso named source files
>>>    kbuild: Allow DTB overlays to built into .dtso.S files
>>>    arm64: dts: freescale: Rename DTB overlay source files from .dts to
>>>      .dtso
>>>    arm64: dts: renesas: Rename DTB overlay source files from .dts to
>>>      .dtso
>>>    arm64: dts: xilinx: Rename DTB overlay source files from .dts to .dtso
>>>    staging: pi433: overlay: Rename overlay source file from .dts to .dtso
>>>
>>> Frank Rowand (1):
>>>    of: overlay: rename overlay source files from .dts to .dtso
>>
>> I've applied patches 1-3 and 7. I'll send a PR for the branch to the
>> platform maintainers after a few days in linux-next.
> 
> The patch
> 
> commit 941214a512d8c80d47e720c17ec17e8539175e93
> Author: Andrew Davis <afd@ti.com>
> Date:   Mon Oct 24 12:34:29 2022 -0500
> 
>      kbuild: Allow DTB overlays to built into .dtbo.S files
> 
> broke the build reproducibility / no-op builds.
> 
> Before:
>    2+ execution of `make` on non-changed tree did nothing
> 
> Now:
>    Each run of `make` (even without a single bit changed) restarts vmlinux
>    rebuild.
> 
> Please, revert or fix.
> 

I do not see this behavior. What config are you using?

Not sure how this patch could be the root cause, it only adds
a build target/rule, but doesn't actually use it anywhere yet..

Andrew
