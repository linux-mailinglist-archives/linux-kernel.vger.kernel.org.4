Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69A66B9FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCNT3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCNT2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:28:51 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9D45BAF;
        Tue, 14 Mar 2023 12:28:47 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 13F265FD1F;
        Tue, 14 Mar 2023 22:28:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678822125;
        bh=I8FmdPnM7dDH9PZcltGUQjyy4agraZazHHbaG/8Vggs=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=R05HmtKuFnX5q9NAxSi9p8n5YBatv1yYtaOoacnekLXwP3JQy/3vPmhQLehD2x8Xs
         +QVucbtN+RfX95KtzIoSCklc8yGutxcVwqBc6+Z3AfAlv0J2284Or3FD32GDOJqKCX
         tKglCJVXvXHalqvN3xxCXZ/HBTV5GG4ZEDat86g07YRjqDSJGNJaihlKR3oYyhxz8T
         u+BTnE09q5nboslp1vPbUPWXWPzNI/QVfkR7EJVlnjga/+l/FuOfBdGqCdgmwt7U7L
         ugF6jwsIAPhWxdOHfdMlXLp7VADW3/p/iJdVoa3qNGURRy3CmlcFzL2+8isWxhwGbW
         i+4AlhRsymjfg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 14 Mar 2023 22:28:43 +0300 (MSK)
Date:   Tue, 14 Mar 2023 22:28:43 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 3/5] dt-bindings: clock: meson: add A1 PLL and
 Peripherals clkcs bindings
Message-ID: <20230314192843.ajjfzkn4lxnmjxhc@CAB-WSD-L081021>
References: <ffebef1d-8447-181b-1890-3e638d399c62@linaro.org>
 <20230314114825.yiv4vcszr6b7m45w@CAB-WSD-L081021>
 <2d9297e9-dab7-9615-3859-79b3b2980d9a@linaro.org>
 <20230314150107.mwcglcu2jv4ixy3r@CAB-WSD-L081021>
 <9d176288-cd7c-7107-e180-761e372a2b6e@linaro.org>
 <c8fecf94-2581-6cc9-955c-324efdc7c70a@linaro.org>
 <21add21d-4afe-7840-6c49-3786f82761d9@linaro.org>
 <6b7ae52c-d84d-8d08-139c-5c67ec363e85@linaro.org>
 <20230314155641.6iw5vgkrrqcx22n6@CAB-WSD-L081021>
 <b9b4d33d-f325-6437-4f4d-f051d2455e2d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b9b4d33d-f325-6437-4f4d-f051d2455e2d@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/14 06:01:00 #20942017
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 05:37:04PM +0100, Krzysztof Kozlowski wrote:
> On 14/03/2023 16:56, Dmitry Rokosov wrote:
> > On Tue, Mar 14, 2023 at 04:40:19PM +0100, neil.armstrong@linaro.org wrote:
> >> On 14/03/2023 16:37, Krzysztof Kozlowski wrote:
> >>> On 14/03/2023 16:33, neil.armstrong@linaro.org wrote:
> >>>>> There are many ways - depend on your driver. For example like this:
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/samsung/clk-exynos5420.c#n975
> >>>>>
> >>>>> The first argument is the clock ID (or ignore).
> >>>>>
> >>>>> BTW, quite likely the problem is generic to all Meson clock drivers.
> >>>>
> >>>> This issue about "public" non-continuous defined was already discussed at https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
> >>>>
> >>>> I don't see what's different with this one.
> >>>
> >>> So you are aware that all undocumented clock IDs are still allowed to
> >>> use in DTS and they are ABI? Changing them will be an ABI break.
> >>
> >> Yes of course.
> >>
> >> Neil
> >>
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>>
> >>
> > 
> > Sorry, guys, I'm little bit confused.
> > In the discussion pointed by Neil not-by-one-increment ID with public and
> > private parts are acked by Krzysztof due to explicit explanation in the
> > gxbb header. Have I to comment out my situation and stay it as is?
> 
> I did not NAK your solution here. I just pointed my usual remarks that
> it has certain outcome and minuses (undocumented ABI). But it is OK.
> 

Got it, thank you.

> > 
> > BTW, I think changing IDs value would not affect logic, because
> > it's not connected to driver logic 'by values', but 'by constants
> 
> You cannot change the IDs, neither their values nor the names (with
> exceptions). IDs - so the numbers - are ABI.
> 
> "Constant names" - I assume you mean the names of defines - do not exist
> after preprocessing, so also not really relevant here...
> 

Ah, you mean the situation when dtb blob is old and module or kernel
image is new, so ABI is broken. Yep, agree with you.

[...]

-- 
Thank you,
Dmitry
