Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B156C478C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCVK0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCVK0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:26:14 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562C45CEF3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:26:12 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id BAEC85FD27;
        Wed, 22 Mar 2023 13:26:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679480769;
        bh=eiP6Ka7pUzeiaH0YXaEndVrhuLTFYe1+S423DnNkJFY=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=BVNs4o1wyOhb5RDa7BeV+ocF0t9bMJzLIpN74zYil6GreQtx+MI3w80PTneRhwBzn
         edPlPPxLPAT6bf7A+8P1oMipF+thEN2GnGOBIR509QvRNJP9qXwR3jVWuz7PabSZYz
         2ZDzgIGGX9polKQJ1WRW4eKHrAbUUnjthoeIzKaULjAf8CGCoQVtIseSwugqci9WQU
         hat684GOkelF7cldrVjTxex2NEXPj4etgEzEYau5u2gFayJ8PDN36vHzPQX8vbQOk3
         fU4p8IuoSrV0hWoTi1yZZFo624rYYaTrcNo/UzJWppiGjk0Sk6A0Lbndkj/rdVRIqM
         PayoLTv3gAqpg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 22 Mar 2023 13:26:08 +0300 (MSK)
Date:   Wed, 22 Mar 2023 13:26:07 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Rob Herring <robh@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <apw@canonical.com>,
        <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <kernel@sberdevices.ru>,
        <linux-kernel@vger.kernel.org>, <rockosov@gmail.com>
Subject: Re: [PATCH v3] checkpatch: add missing bindings license check
Message-ID: <20230322102607.5rac7lmy5w653jen@CAB-WSD-L081021>
References: <20230320203350.13696-1-ddrokosov@sberdevices.ru>
 <20230321215337.GA1656483-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230321215337.GA1656483-robh@kernel.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/22 07:14:00 #20990327
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob, thank you for the comments. Please find my thoughts below.

On Tue, Mar 21, 2023 at 04:53:37PM -0500, Rob Herring wrote:
> On Mon, Mar 20, 2023 at 11:33:50PM +0300, Dmitry Rokosov wrote:
> > All headers from 'include/dt-bindings/' must be verified by checkpatch
> > together with Documentation bindings, because all of them are part of
> > the whole DT bindings system.
> > 
> > The requirement is dual licensed and matching pattern:
> >     /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/
> 
> This is not correct. The headers can and should be licensed like the dts 
> files which are (unfortunately) all over the place and differ from the 
> bindings.
> 
> Also, GPL-2.0-or-later is neither desired nor encouraged. 

Sorry, I'm little bit confused. Let's discuss correct way.

We had such discussion in another review.

https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.ru/

Krzysztof has mentioned that Documentation yaml bindings schemas and
include bindings headers should have the same license by default.
And checkpath must check not only Documentation schema (previous
implementation), but 'include bindings' as well:

From Krzysztof at https://lore.kernel.org/all/9d176288-cd7c-7107-e180-761e372a2b6e@linaro.org/:

---
>>>>> @@ -0,0 +1,20 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>>>
>>>> I found in changelog:
>>>> "fix license issue, it's GPL-2.0+ only in the current version"
>>>> and I do not understand.
>>>>
>>>> The license is wrong, so what did you fix?
>>>>
>>>
>>> Sorry don't get you. Why is it wrong?
>>
>> Run checkpatch - it will tell you why wrong. The license is not correct.
>> This is part of binding and should be the same as binding.
>>
> 
> I always run checkpatch before sending the next patch series. Checkpatch
> doesn't highlight this problem:
> 
> --------------
> $ rg SPDX a1_clkc_v10/v10-0003-dt-bindings-clock-meson-add-A1-PLL-and-Periphera.patch
> 32:+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> 111:+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> 188:+/* SPDX-License-Identifier: GPL-2.0+ */
> 294:+/* SPDX-License-Identifier: GPL-2.0+ */
> 
> $ ./scripts/checkpatch.pl --strict a1_clkc_v10/v10-0003-dt-bindings-clock-meson-add-A1-PLL-and-Periphera.patch
> total: 0 errors, 0 warnings, 0 checks, 259 lines checked

Hmm, my bad, that's something to fix/improve in checkpatch.
---

Actually, I agree with Krzysztof that checkpatch should verify 'include
bindings', but looks like there is misunderstanding which license pattern
we have to use.

Rob, could you please share your thoughts if possible? Which one pattern
we have to base on? GPL-2.0-only without 'later' suffix? Or you totally
disagree that checkpatch is responsible for 'include bindings'
verification?

-- 
Thank you,
Dmitry
