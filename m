Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5FF628AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbiKNUoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbiKNUow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:44:52 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7F65FD5;
        Mon, 14 Nov 2022 12:44:50 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AEKhre2086852;
        Mon, 14 Nov 2022 14:43:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668458633;
        bh=RRwVbs6Nxajdn/lHSP6EvoUJW0qDTPedg7Ql4Rbsgxw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Ln7toHtfnHFQmyUN4xGjisz7miy4P2ui4/4LbCh0KRI1xLSuZRExRAoD0LcgA3rMX
         8qFAxVf7UZzDtvaAmeMxuv+Ldi7GEfBt1IWXvzbM82U2cw1W+6YDIyabEqhOiWyG9N
         KzJcmEifBV3764UfYkDRQZ0FaC7YXga2WskNPiHI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AEKhr84038214
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Nov 2022 14:43:53 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 14
 Nov 2022 14:43:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 14 Nov 2022 14:43:53 -0600
Received: from [10.250.38.44] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AEKhqYZ026574;
        Mon, 14 Nov 2022 14:43:52 -0600
Message-ID: <f28505a4-3384-b6df-5229-d576a089b1dd@ti.com>
Date:   Mon, 14 Nov 2022 14:43:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/7] Rename DTB overlay source files
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
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
 <e5ce57b2-4557-2dcb-fb3a-71e2acae4502@ti.com>
 <Y3DhIO7H9mfRpe3z@smile.fi.intel.com> <Y3Dk0HJAPuq64tKe@smile.fi.intel.com>
 <Y3JnfSUpBfATkD69@smile.fi.intel.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <Y3JnfSUpBfATkD69@smile.fi.intel.com>
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

On 11/14/22 10:06 AM, Andy Shevchenko wrote:
> On Sun, Nov 13, 2022 at 02:36:33PM +0200, Andy Shevchenko wrote:
>> On Sun, Nov 13, 2022 at 02:20:48PM +0200, Andy Shevchenko wrote:
>>> On Fri, Nov 11, 2022 at 03:05:20PM -0600, Andrew Davis wrote:
>>>> On 11/11/22 1:39 PM, Andy Shevchenko wrote:
>>>>> On Wed, Oct 26, 2022 at 09:11:21AM -0500, Rob Herring wrote:
>>>>>> On Mon, Oct 24, 2022 at 12:34 PM Andrew Davis <afd@ti.com> wrote:
>>>>>>>
>>>>>>> Hello all,
>>>>>>>
>>>>>>> This is a series based on my patch here[0]. As suggested by Rob
>>>>>>> I've resurrected Frank's patch and appended it to mine as a series.
>>>>>>>
>>>>>>> First patch here is my original patch, 3rd is Frank's patch but with
>>>>>>> the unittest changes pulled out into the 2nd patch. That was re-worked
>>>>>>> moving the source building macro into scripts/Makefile.lib.
>>>>>>>
>>>>>>> Patches 4, 5, and 6 are an attempt at renaming all the existing DTB
>>>>>>> overlays. Split out by platform so they could be taken by platform
>>>>>>> maintainers or if easier ACK'd here and taken all together.
>>>>>>>
>>>>>>> This should cover all the DTB overlays so we can remove the old .dts
>>>>>>> rule for overlays and make .dtso the only supported way, let me know
>>>>>>> if we want that this cycle and I can post that too.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Andrew
>>>>>>>
>>>>>>> Changes from v1[1]:
>>>>>>>    - Added patch to rename pi433 overlay.
>>>>>>>    - Cleaned wording on patch 4-6.
>>>>>>>    - Collected some ACKs
>>>>>>>
>>>>>>> [0] https://www.spinics.net/lists/kernel/msg4548509.html
>>>>>>> [1] https://www.spinics.net/lists/arm-kernel/msg1020165.html
>>>>>>>
>>>>>>> Andrew Davis (6):
>>>>>>>     kbuild: Allow DTB overlays to built from .dtso named source files
>>>>>>>     kbuild: Allow DTB overlays to built into .dtso.S files
>>>>>>>     arm64: dts: freescale: Rename DTB overlay source files from .dts to
>>>>>>>       .dtso
>>>>>>>     arm64: dts: renesas: Rename DTB overlay source files from .dts to
>>>>>>>       .dtso
>>>>>>>     arm64: dts: xilinx: Rename DTB overlay source files from .dts to .dtso
>>>>>>>     staging: pi433: overlay: Rename overlay source file from .dts to .dtso
>>>>>>>
>>>>>>> Frank Rowand (1):
>>>>>>>     of: overlay: rename overlay source files from .dts to .dtso
>>>>>>
>>>>>> I've applied patches 1-3 and 7. I'll send a PR for the branch to the
>>>>>> platform maintainers after a few days in linux-next.
>>>>>
>>>>> The patch
>>>>>
>>>>> commit 941214a512d8c80d47e720c17ec17e8539175e93
>>>>> Author: Andrew Davis <afd@ti.com>
>>>>> Date:   Mon Oct 24 12:34:29 2022 -0500
>>>>>
>>>>>       kbuild: Allow DTB overlays to built into .dtbo.S files
>>>>>
>>>>> broke the build reproducibility / no-op builds.
>>>>>
>>>>> Before:
>>>>>     2+ execution of `make` on non-changed tree did nothing
>>>>>
>>>>> Now:
>>>>>     Each run of `make` (even without a single bit changed) restarts vmlinux
>>>>>     rebuild.
>>>>>
>>>>> Please, revert or fix.
>>>>>
>>>>
>>>> I do not see this behavior. What config are you using?
>>>>
>>>> Not sure how this patch could be the root cause, it only adds
>>>> a build target/rule, but doesn't actually use it anywhere yet..
>>>
>>> For your reference I started with this one [1].
>>>
>>> When I bisected, I just answered with defaults on whatever `make` told me at
>>> the configuration stage.
>>>
>>> The actual `make` command I used:
>>>
>>> 	make O=/path/to/the/result W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64
>>>
>>> But there is nothing that can affect the described issue.
>>
>> Actually, O= might affect which Makefile is used and how.
>> The C=, CF= are sparse flags, W= is just warning level.
> 
> As far as I can tell right now it's the OF_UNITTEST on x86_64 that makes the
> above mentioned patch to be a culprit. Not sure if on ARM / ARM64 you can
> reproduce that. And it's really strange nobody reported this for a week+.
> 
> Whatever, I'm open for the suggestions and material to test.
> 

I think I found the issue, we forgot to add the new dtbo.S/o files
to the list of preserved intermediate targets, so Make was
removing them after build.

Sending the fix now.

Thanks,
Andrew

>>> [1]: https://p.defau.lt/?ZSOdGnNxF9v9AQtrfDo_KQ
> 
